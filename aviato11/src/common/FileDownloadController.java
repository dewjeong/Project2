package common;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import oracle.net.aso.r;


@WebServlet("/download.fl")
public class FileDownloadController extends HttpServlet {

	//다운로드 시킬 이미지 파일이 저장된 위치 
	private static String ARTICLE_IMAGE_REPO = "C:\\blog\\blog_image";
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doHandle(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doHandle(req, resp);
	}
	
	protected void doHandle(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//viewArticle.jsp에서 전송한 글 번호와 이미지 파일이름으로  파일 경로를 만든 후 해당 파일을 웹브라우저로 다운로드시킵니다.
		
		req.setCharacterEncoding("UTF-8");
		
		resp.setContentType("text/html;charset=utf-8");
		
		//요청한 값 얻기
		String imageFileName = req.getParameter("imageFileName"); //이미지 파일 이름
		String idx = req.getParameter("idx"); //글 번호 
		System.out.println("파일컨트롤러"+imageFileName+idx);
		//웹브라우저로 데이터를 바이트 단위로 내보낼 출력스트림 통로 생성
		OutputStream out = resp.getOutputStream();
		
		//글번호에 대한 파일 경로 설정
		String path = ARTICLE_IMAGE_REPO + "\\" + idx + "\\" + imageFileName;
		File imageFile = new File(path);
		
		resp.setHeader("Cache-Control", "no-cache");
		resp.addHeader("Content-disposition", "attachment;fileName=" + imageFileName);
		
		//글번호 폴더에 저장된 이미지파일을 바이트 단위로 읽어들일 입력스트림 통로 생성
		FileInputStream in = new FileInputStream(imageFile);
		
		byte[] buffer = new byte[1024*8]; //한번에 8kb씩 읽어서 내보내기 위한 배열
		
		while(true) {
			
			int count = in.read(buffer); //8kb씩 읽어들임
			
			if(count == -1) {
				break;
			}
			
			out.write(buffer,0,count);
			
		}//while반복문
		
		//스트림 통로 자원해제
		in.close();
		out.close();
	}//doHandle메소드 닫는 기호 
	
}









