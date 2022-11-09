package blog;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;

import blog.BlogVO;
import blog.BlogService;

@WebServlet("/blog/*")
public class BlogController extends HttpServlet {

	// 새글 작성시 글에 첨부할 이미지의 저장위치를 상수로 선언합니다.
	private static String ARTICLE_IMAGE_REPO = "C:\\blog\\blog_image";

	BlogService blogService;
	BlogVO blogVO;

	// BlogController서블릿 클래스를 톰캣 메모리에 로드 하는 시점에
	// 호출되는 init메소드 내부에 BoardService클래스의 객체 생성후 저장 하자
	@Override
	public void init() throws ServletException {

		blogService = new BlogService();
		blogVO = new BlogVO();
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doHandle(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doHandle(req, resp);
	}

	// 사용자가 get방식이든 post방식으로 요청하든지 간에 요청을 받을 하나의 임의의 메소드 만들기
	protected void doHandle(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// 답글에 대한 부모글번호를 저장하기 위해 session내장객체를 저장시킬 변수 선언
		HttpSession session = null;

		// 재요청할 페이지 주소를 저장할 변수
		String nextPage = "";

		req.setCharacterEncoding("UTF-8");
		
		

		/* 어떤 페이지에서 요청이 들어왔는지 사용자 주소 알아내기 작업 */
		// 요청명을 가져옵니다.
		String action = req.getPathInfo(); // /BlogList.bg
		// 가져온 요청명 확인
		System.out.println("action : " + action);

		try {
			//List<BlogVO> blogList = null;
			List<BlogVO> reList = null;
			
			if (action == null) {

				List list = blogService.blogList();
				System.out.println(list.size());

				req.setAttribute("list", list);
				// select한 게시판의 전체글 개수 request영역에 담기
				req.setAttribute("total", blogService.getTotalRecord());
				
				// 현재 보여질 페이지 넘버,블럭 저장
				req.setAttribute("nowPage", req.getParameter("nowPage"));
				req.setAttribute("nowBlock", req.getParameter("nowBlock"));

				System.out.println(req.getParameter("nowPage"));
				System.out.println(req.getParameter("nowBlock"));
				
				// 재요청할 뷰 주소 저장
				nextPage = "/blogList.jsp";

			} else if (action.equals("/BlogList.bg")) {// 요청명이 게시판 목록일때..

				List list = blogService.blogList();
				
				// select한 게시판의 전체글 개수 request영역에 담기
				req.setAttribute("total", blogService.getTotalRecord());
				req.setAttribute("list", list);
				// 현재 보여질 페이지 넘버,블럭 저장
				req.setAttribute("nowPage", req.getParameter("nowPage"));
				req.setAttribute("nowBlock", req.getParameter("nowBlock"));

				System.out.println(req.getParameter("nowPage"));
				System.out.println(req.getParameter("nowBlock"));

				// 재요청할 뷰 주소 저장
				nextPage = "/blogList.jsp";

			} else if (action.equals("/searchList.bg")) {

				// blogList.jsp에서 검색 버튼 눌렀을때
				try {
					// 전달받는 검색어 및 검색기준값 한글처리
					req.setCharacterEncoding("utf-8");
					// list.jsp페이지에서 넘어온 검색기준값과, 검색어 전달받기
					String k = req.getParameter("key");// 검색기준값
					String w = req.getParameter("word");// 검색어
					System.out.println(k + w);
					// 먼저 할일 !// 글 목록을 select하는 BlogList(String k, String w) 메소드를 추가하자

					// 검색 기준값 k와, 검색어 w를 BlogList에 전달하여...
					// 현재 DB의 TP_BLOG테이블에 저장되어 있는 글 목록을 검색한
					// BlogVO객체들을 지니고 있는 ArrayList가져오기
					List list = blogService.BlogList(k, w);
					System.out.println("서치검색한 글개수" + list.size());
					// select한 글목록이 담긴 ArrayList를 request영역에 담기
					req.setAttribute("list", list);
					// 현재 보여질 페이지 번호 저장
					req.setAttribute("nowPage", req.getParameter("nowPage"));
					req.setAttribute("nowBlock", req.getParameter("nowBlock"));

				} catch (Exception e) {

				} finally {

				}
				nextPage = "/blogList.jsp";

			} else if (action.equals("/write.bg")) {// 글쓰기 페이지 요청이면

				nextPage = "/write.jsp";// 글쓰기 페이지 주소 저장

			} else if (action.equals("/writeConfirm.bg")) {// 글추가 요청이면
				try {

					// 추가한 새글 번호를 반환받아 저장할 변수
					// 반환 받는 이유는? 글번호 폴더를 생성하기 위함입니다.
					int idx = 0;

					// upload()메소드를 호출해 글쓰기 화면에서 첨부하여 전송된 글관련정보를
					// HashMap에 key/value 쌍으로 저장합니다.
					// 그런후..
					// 글입력시 추가적으로 업로드할 파일을 선택하여 글쓰기 요청을 했다면
					// 업로드할 파일명, 입력한 글제목, 입력한 글내용을 key/value 형태의 값들로 저장되어 있는 HashMap을 리턴받는다
					// 그렇지 않을 경우에는???
					// 업로드할 파일명을 제외한 입력한 글제목, 입력한 글내용을 key/value 형태의 값들로 저장되어 있는 HashMap을 리턴받는다
					Map<String, String> articleMap = upload(req, resp);

					// HashMap에 저장된 글정보(업로드한 파일명, 입력한 글제목, 입력한 글내용)을 다시 꺼내옵니다.
					String title = articleMap.get("title");
					String content = articleMap.get("content");
					String imageFileName = articleMap.get("imageFileName");
					String name = articleMap.get("writer");
					String pass = articleMap.get("pass");

					// DB에 추가하기 위해 VO에 추가
					BlogVO vo = new BlogVO();
					vo.setB_name(name);
					vo.setB_pw(pass);
					vo.setB_title(title);
					vo.setB_content(content);
					vo.setB_imageFN(imageFileName);
					//System.out.println("컨트롤러 이미지 : " + imageFileName);
					//System.out.println("컨트롤러 네임비번 : " + name + pass);
					idx = blogService.blogInsert(vo);
					// 파일을 첨부한 경우 수행
					if (imageFileName != null && imageFileName.length() != 0) {

						// temp폴더에 임시로 업로드된 파일에 접근하기 위해 File객체 생성
						File srcFile = new File(ARTICLE_IMAGE_REPO + "\\" + "temp" + "\\" + imageFileName);

						// 글번호 폴더를 생성하기 위해 경로를 지정한 File객체 생성
						File destDir = new File(ARTICLE_IMAGE_REPO + "\\" + idx);
						// 위 destDir참조변수에 지정된 경로의 글번호 폴더 생성
						destDir.mkdirs();

						// temp폴더에 업로드된 파일을 새 글번호 폴더로 이동시킵니다.
						FileUtils.moveFileToDirectory(srcFile, destDir, true);

						// 웹브라우저로 응답할 데이터종류(MIME-TYPE)설정 , 한글처리 설정
						resp.setContentType("text/html;charset=utf-8");

						//클라이언트의 웹브라우저로 응답할 출력 스트림 통로 객체 생성
						PrintWriter pw = resp.getWriter();						
						//클라이언트의 웹브라우저로 응답할 출력 스트림 통로 객체 생성 PrintWriter pw = resp.getWriter();
						pw.print("<script>");
						pw.print(" alert('새 글을 추가 했습니다.');");
						pw.print(" location.href='" + req.getContextPath() +
						"/blog/BlogList.bg';");
						pw.print("</script>");
						
						return;
					}

				} catch (Exception e) {
					e.printStackTrace();
				}
				//글목록 페이지로 이동
				nextPage = "BlogList.bg";

			}else if (action.equals("/read.bg")) {
				
				// list.jsp페이지에서 전달한 상세내용을 볼 글번호 가져오기
				String idx = req.getParameter("idx");
				// 상세내용을 볼 글 번호를 전달하여 리턴받기
				BlogVO vo = blogService.blogRead(idx);

				/* request영역에 담기 */
				req.setAttribute("name", vo.getB_name());
				req.setAttribute("title", vo.getB_title());
				req.setAttribute("content", vo.getB_content());
				req.setAttribute("date", vo.getB_date());
				req.setAttribute("cnt", vo.getB_cnt());
				req.setAttribute("imageFileName", vo.getB_imageFN());
				// 어떤 페이지에서 글 상세보기 페이지로 넘어왔는지 이전 페이지 번호 담기
				req.setAttribute("nowPage", req.getParameter("nowPage"));

				
				// 상세 볼 글번호 값,입력한 비밀번호 저장
				// 저장 이유: 글 상세보기 페이지에서 글 수정, 글삭제 등의 작업을 하기 위해 request영역에 저장
				req.setAttribute("idx", idx);
				
//				여기부터 댓글관련!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
				//해당 글에 달린 댓글 모두조회하는 메소드
				reList = blogService.blogReList(idx);
				System.out.println(reList.size());
				req.setAttribute("reList", reList);
				
				// select한 게시판의 전체글 개수 request영역에 담기
				//req.setAttribute("reTotal", blogService.getTotalRe());
				req.setAttribute("totalRe", reList.size());
				//System.out.println("컨트롤러 read글번호:"+idx);
				nextPage = "/read.jsp";

			} else if (action.equals("/modifyPass.bg")) {
				// 글 상세보기에서 비밀번호 입력하고 글 수정페이지로 넘어가기 전에
				// 글 비밀번호가 맞는지 확인하는 작업을 함.
				String idx = req.getParameter("idx");
				String pass = req.getParameter("pass");

				//System.out.println("비번유효성" + idx + pass);

				// pass확인 넘어가야하니까 글번호,비밀번호 넘겨주기
				req.setAttribute("idx", idx);
				req.setAttribute("pass", pass);

				boolean check = blogService.modifyPass(idx, pass);

				//System.out.println("컨트롤러 check값:" + check);

				if (check == true) {
					nextPage = "modify.bg";
				} else {
					nextPage = "/passError.jsp";
				}

			} else if (action.equals("/modify.bg")) {
				try {
					/* read.jsp에서 받아오는 값 */
					// 수정할 글번호 받아오기
					String idx = req.getParameter("idx");
					BlogVO vo = blogService.blogRead(idx);

					/* 받아온 수정하기 전 글내용 (dto객체)을 request영역에 담기 */
					req.setAttribute("name", vo.getB_name());
					req.setAttribute("title", vo.getB_title());
					req.setAttribute("content", vo.getB_content());
					req.setAttribute("imageFileName", vo.getB_imageFN());
					// 어떤 페이지에서 글 상세보기 페이지로 넘어왔는지 이전 페이지 번호 담기
					req.setAttribute("nowPage", req.getParameter("nowPage"));
					// 수정할 글번호 값 저장
					req.setAttribute("idx", idx);

				} catch (Exception e) {
					e.printStackTrace();
				}
				// 수정하기 전의 글에 대한 내용을 뿌려주기 위한 주소 저장(글 수정 디자인페이지)
				nextPage = "/modify.jsp";

			} else if (action.equals("/modifyConfirm.bg")) {// 이동할 페이지가 수정확인 페이지요청이면
				/* modify.jsp에서 받아오는 값 */
				// 수정할 글번호 받아오기
				//int idx = Integer.parseInt(req.getParameter("idx"));
				try {
					// upload()메소드를 호출해 글쓰기 화면에서 첨부하여 전송된 글관련정보를
					// HashMap에 key/value 쌍으로 저장합니다.
					// 그런후..
					// 글입력시 추가적으로 업로드할 파일을 선택하여 글쓰기 요청을 했다면
					// 업로드할 파일명, 입력한 글제목, 입력한 글내용을 key/value 형태의 값들로 저장되어 있는 HashMap을 리턴받는다
					// 그렇지 않을 경우에는???
					// 업로드할 파일명을 제외한 입력한 글제목, 입력한 글내용을 key/value 형태의 값들로 저장되어 있는 HashMap을 리턴받는다
					Map<String, String> articleMap = upload(req, resp);

					// HashMap에 저장된 글정보(업로드한 파일명, 입력한 글제목, 입력한 글내용)을 다시 꺼내옵니다.
					String title = articleMap.get("title");
					String content = articleMap.get("content");
					String imageFileName = articleMap.get("imageFileName");
//					String name = articleMap.get("writer");
					String pass = articleMap.get("pass");
					int idx = Integer.parseInt(articleMap.get("idx"));
					//System.out.println("modifyConfirm 글번호 = "+idx);
					// DB에 추가하기 위해 VO에 추가
					BlogVO vo = new BlogVO();
					vo.setB_idx(idx);
					vo.setB_title(title);
					vo.setB_content(content);
					vo.setB_imageFN(imageFileName);
					//System.out.println("modifyConfirm 이미지 : " + imageFileName);
					idx = blogService.blogModify(vo);
					//System.out.println("modifyConfirm 글번호 = "+ idx);
					
					if(imageFileName != null && imageFileName.length() != 0) {
						
						String orginalFileName = articleMap.get("originalFileName");
						
						//수정된 이미지 파일을 temp폴더에서 글번호 폴더로 이동시키기 위함
						
						File srcFile = new File(ARTICLE_IMAGE_REPO+"\\"+"temp"+"\\" + imageFileName);
						
						File destDir = new File(ARTICLE_IMAGE_REPO+"\\" + idx);
						destDir.mkdirs();
						
						FileUtils.moveFileToDirectory(srcFile, destDir, true);
						
						
						//기존에 글 번호 폴더에 저장되어 있던 이미지 파일을 삭제 시킵니다.
						File oldFile = new File(ARTICLE_IMAGE_REPO+"\\"+idx+"\\"+orginalFileName);
						oldFile.delete();
						
						// 웹브라우저로 응답할 데이터종류(MIME-TYPE)설정 , 한글처리 설정
						resp.setContentType("text/html;charset=utf-8");

						//클라이언트의 웹브라우저로 응답할 출력 스트림 통로 객체 생성
						PrintWriter pw = resp.getWriter();						
						//클라이언트의 웹브라우저로 응답할 출력 스트림 통로 객체 생성 PrintWriter pw = resp.getWriter();
						pw.print("<script>");
						pw.print(" alert('글을 수정했습니다.');");
						pw.print(" location.href='" + req.getContextPath() +
						"/blog/BlogList.bg';");
						pw.print("</script>");
						
						return;
					}//안쪽 if

				} catch (Exception e) {
					System.out.println("modifyConfirm 오류 "+ e);
					e.printStackTrace();
				}
				// 글 수정후 수정 반영된 글상세화면 보여주기
				nextPage = "read.bg";

			} else if (action.equals("/delete.bg")) {// 글 삭제하기 요청
				// "read.jsp"에서 받아오는 값
				// 삭제할 글번호 받아오기
				int idx = Integer.parseInt(req.getParameter("idx"));
				//String idx = req.getParameter("idx");
				// 삭제후 이동할 페이지번호 받아오기
				String nowPage = req.getParameter("nowPage");
				// 삭제하기 위해 입력한 패스워드 값 받아오기
				String passwd = req.getParameter("pass");

				/* read.jsp에서 받아온 데이터를 request영역에 담기 */
				req.setAttribute("idx", idx);
				req.setAttribute("nowPage", nowPage);
				req.setAttribute("pass", passwd);

				// 글 삭제를 한번 더 물어보는 페이지 주소 저장
				nextPage = "/delete.jsp";

			} else if (action.equals("/deleteConfirm.bg")) {// 실제 글 삭제 요청이면
				try {
					// delete.jsp에서 받아오는 값
					// 삭제할 글번호 받아오기
					String idx = req.getParameter("idx");
					// 삭제하기 위해 입력한 패스워드 값 받아오기
					String passwd = req.getParameter("pass");
					
					boolean result = blogService.blogDelete(idx, passwd);
					
					//삭제할 글번호 폴더 경로 지정
					File imgDir = new File(ARTICLE_IMAGE_REPO + "\\" + idx);
					//위 생성한 File객체의 정보가 폴더경로라면?
					if(imgDir.exists()) {
						//글번호 폴더 삭제
						FileUtils.deleteDirectory(imgDir);
					}
					
					//웹브라우저로 응답할 데이터종류(MIME-TYPE)설정 , 한글처리 설정
					resp.setContentType("text/html;charset=utf-8");
					
					//클라이언트의 웹브라우저로 응답할 출력 스트림 통로 객체 생성
					PrintWriter pw = resp.getWriter();
					// 만약 삭제 성공시.. list.jsp로 이동하는 주소 저장
					if (result == true) {
						pw.print("<script>");
						pw.print(" alert('글을 삭제 했습니다.');");
						pw.print(" location.href='" + req.getContextPath() + "/blog/BlogList.bg';");
						pw.print("</script>");			
						
						return;
					} else {// 삭제 실패시 passError.jsp로 이동하는 주소 저장
						nextPage = "/passError.jsp";
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else if (action.equals("/sendRe.bg")) {// 댓글 등록 버튼을 눌렀을때
					
				System.out.println("sendRe.bg진입");
				try {
					String nowPage = req.getParameter("nowPage");
					
					BlogVO vo = new BlogVO();
					vo.setB_idx(Integer.parseInt(req.getParameter("b_idx")));
					vo.setR_name(req.getParameter("rewriter"));
					vo.setR_pw(req.getParameter("repass"));
					vo.setR_content(req.getParameter("recontent"));
					
					System.out.println("sendRe.bg에서 b_idx는?"+Integer.parseInt(req.getParameter("b_idx")));
					System.out.println("sendRe.bg에서 repass?"+Integer.parseInt(req.getParameter("repass")));
					blogService.blogReInsert(vo);
					
					// 웹브라우저로 응답할 데이터종류(MIME-TYPE)설정 , 한글처리 설정
					resp.setContentType("text/html;charset=utf-8");

					//클라이언트의 웹브라우저로 응답할 출력 스트림 통로 객체 생성
					PrintWriter pw = resp.getWriter();						
					//클라이언트의 웹브라우저로 응답할 출력 스트림 통로 객체 생성 PrintWriter pw = resp.getWriter();
					pw.print("<script>");
					pw.print(" alert('댓글을 추가 했습니다.');");
					pw.print(" location.href='" + req.getContextPath() +"/blog/BlogList.bg';");
					pw.print("</script>");
					
					return;
					
				} catch (Exception e) {
					System.out.println("sendRE컨트롤러에서 오류 : "+ e);
					e.printStackTrace();
				}

				// 이동할 List페이지 지정
				nextPage = "BlogList.bg";

			} else if (action.equals("/deleteRe.bg")) {// 댓글 삭제 버튼을 눌렀을때
				System.out.println("댓삭 컨트롤러 도착");
				
				// 삭제할 댓글번호와 주 글 번호 받아오기
				String r_idx = req.getParameter("r_idx");
				String b_idx = req.getParameter("b_idx");
				
				System.out.println("댓삭컨트롤러에서 값" + r_idx+b_idx);
				
				int result = blogService.deleteRe(r_idx, b_idx);
				
				if(result == 1) {
					// 웹브라우저로 응답할 데이터종류(MIME-TYPE)설정 , 한글처리 설정
					resp.setContentType("text/html;charset=utf-8");

					//클라이언트의 웹브라우저로 응답할 출력 스트림 통로 객체 생성
					PrintWriter pw = resp.getWriter();						
					//클라이언트의 웹브라우저로 응답할 출력 스트림 통로 객체 생성 PrintWriter pw = resp.getWriter();
					pw.print("<script>");
					pw.print(" alert('댓글을 삭제 했습니다.');");
					pw.print(" location.href='" + req.getContextPath() +"/blog/BlogList.bg';");
					pw.print("</script>");
					return;
				}else {
					// 웹브라우저로 응답할 데이터종류(MIME-TYPE)설정 , 한글처리 설정
					resp.setContentType("text/html;charset=utf-8");

					//클라이언트의 웹브라우저로 응답할 출력 스트림 통로 객체 생성
					PrintWriter pw = resp.getWriter();						
					//클라이언트의 웹브라우저로 응답할 출력 스트림 통로 객체 생성 PrintWriter pw = resp.getWriter();
					pw.print("<script>");
					pw.print(" alert('댓글 삭제 실패');");
					pw.print(" location.href='" + req.getContextPath() +"/blog/BlogList.bg';");
					pw.print("</script>");
					
				}
				
				nextPage = "BlogList.bg";
				
			} //마지막 else if 끝

			System.out.println(nextPage);

			// 실제 이동
			RequestDispatcher view = req.getRequestDispatcher(nextPage);
			view.forward(req, resp);

		} catch (Exception e) {
			e.printStackTrace();
		} // try catch 끝

	}// doHandle 메소드 끝

	// 파일 업로드 처리를 위한 메소드
	private Map<String, String> upload(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Map<String, String> articleMap = new HashMap<String, String>();

		String encoding = "UTF-8";

		// 글쓰기를 할때 첨부한 이미지를 저장할 폴더경로에 접근하기 위해 File객체를 생성합니다.
		File currentDirPath = new File(ARTICLE_IMAGE_REPO);

		// 업로드할 파일 데이터를 임시로 저장시킬 저장소역할의 객체 메모리 생성
		DiskFileItemFactory factory = new DiskFileItemFactory();
		// 파일업로드시 사용할 임시메모리 최대 크기 1메가 바이트로 지정
		factory.setSizeThreshold(1024 * 1024 * 1);
		// 임시메모리에 파일업로드시~ 지정한 1메가바이트크기를 넘길경우 업로드될 파일 경로를 지정함
		factory.setRepository(currentDirPath);

		// 참고
		// DiskFileItemFactory클래스는 업로드 파일의 크기가 지정한 크기를 넘기 전까지는
		// 업로드한 파일 데이터를 임시 메모리에 저장하고 지정한 크기를 넘길 경우 디렉터리에 파일로 저장한다.

		// 파일업로드할 메모리를 생성자쪽으로 전달받아 저장한!! 파일업로드를 처리할 객체 생성
		ServletFileUpload upload = new ServletFileUpload(factory);

		try {
			// 업로드할 파일에 대한 요청 정보를 가지고 있는 request객체를 parseRequest()메소드 호출시 인자로 전달면
			// request객체 저장되어 있는 업로드할 파일의 정보를 파싱해서 DiskFileItem객체에 저장후
			// DiskFileItem객체를 ArrayList에 추가합니다. 그후 ArrayList를 반환 받습니다.
			List items = upload.parseRequest(request);

			for (int i = 0; i < items.size(); i++) {

				// ArrayList가변 배열에서 DiskFileItem객체(업로드할 아이템하나의 정보를 말함)를 얻는다.
				FileItem fileItem = (FileItem) items.get(i);

				// DiskFileItem객체(업로드할 아이템하나의 정보)가 파일 아이템이 아닐경우
				if (fileItem.isFormField()) {

					System.out.println(fileItem.getFieldName() + "=" + fileItem.getString(encoding));

					// articleForm.jsp페이지에서 입력한 글제목,내용만 따로 HashMap에 (key=value)형식으로 저장합니다.
					// HashMap에 저장된 데이터의 예 => {title=입력한글제목, content=입력한글내용}
					articleMap.put(fileItem.getFieldName(), fileItem.getString(encoding));

					// DiskFileItem객체(업로드할 아이템하나의 정보)가 파일 아이템일 경우 업로드 진행!!!!
				} else {

					System.out.println("파라미터명 : " + fileItem.getFieldName());
					System.out.println("파일명 : " + fileItem.getName());
					System.out.println("파일크기 : " + fileItem.getSize() + "bytes");

					// articleForm.jsp페이지에서 입력한 글제목, 글내용, 요청한 업로드할 파일등의 모든 정보를?
					// HashMap에 (key=value)형식으로 저장합니다.
					// HashMap에 저장된 데이터의 예 => {imageFileName=3.png , title=글제목, content=글내용}
					articleMap.put(fileItem.getFieldName(), fileItem.getName());

					// 전체 : 업로드할 파일이 존재하는 경우 업로드할 파일의 파일이름으로 저장소에 업로드합니다.
					// 파일크기가 0보다 크다면?(업로드할 파일이 있다면)
					if (fileItem.getSize() > 0) {
						// 업로드할 파일명을 얻어 파일명의 뒤에서 부터 \\문자열이 들어 있는지
						// 인덱스 위치를 알려주는데.. 없으면 -1을 반환함
						int idx = fileItem.getName().lastIndexOf("\\");// 뒤에서 부터 문자가 들어 있는 인덱스위치를 알려준다

						if (idx == -1) {
							idx = fileItem.getName().lastIndexOf("/"); // -1얻기
						}

						// 업로드할 파일명 얻기
						String fileName = fileItem.getName().substring(idx + 1);
						// 업로드할 파일 경로 + 파일명의 주소(업로드할 경로)에 접근하기 위해 File객체 생성
						// -> 첨부한 파일을 먼저 temp폴더에 업로드 합니다.
						File uploadFile = new File(currentDirPath + "\\temp\\" + fileName);
						// 실제 파일업로드 하기
						fileItem.write(uploadFile);

					} // end if
				} // end if
			} // end for

		} catch (Exception e) {
			e.printStackTrace();
		}

		return articleMap; // doHandle메소드로 리턴

	}// upload메소드 닫는 기호

}// blogController끝
