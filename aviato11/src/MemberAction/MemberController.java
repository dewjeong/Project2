
package MemberAction;

import java.io.IOException;
import java.io.PrintWriter;
import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/member/*")
public class MemberController extends HttpServlet {
	MemberVO memberVO;
	MemberService memberservice;

	@Override
	public void init() throws ServletException { // 최초 컨트롤러 생성 시 존재해야 함
		memberVO = new MemberVO();
		memberservice = new MemberService();
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doHandle(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doHandle(req, resp);
	}

	protected void doHandle(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// 답글에 대한 부모글번호를 저장하기 위해 session내장객체를 저장시킬 변수선언
		HttpSession session = null; // 지역변수

		// 재요청할 페이지 주소를 저장할 변수
		String nextPage = "";

		req.setCharacterEncoding("UTF-8");

		// 요청명을 가져옵니다.
		String action = req.getPathInfo(); // /signin.do

		System.out.println("action값은" + action);

		try {

			/* 로그인화면 요청 */
			if (action.equals("/prevlogin.do")) {

				nextPage = "/login.jsp";

			/* 회원가입화면 요청 */
			} else if (action.equals("/prevsignin.do")) {

				nextPage = "/signin.jsp";

			/* 비밀번호찾기화면 요청 */
			}else if(action.equals("/forget_password.do")) {
			
			nextPage = "/forget_password.jsp";

			/* 회원가입 */
			} else if (action.equals("/signin.do")) { // OK
				
				String name = req.getParameter("Name");
				String add1 = req.getParameter("addr1");
				String add2 = req.getParameter("addr2");
				String add3 = req.getParameter("addr3");
				String add4 = req.getParameter("addr4");
				String email = req.getParameter("Email");
				String pwd = req.getParameter("Password");
				String pc = req.getParameter("PassCheck");

				memberVO = new MemberVO(name, add1, add2, add3, add4, email, pwd, pc);

				// 회원정보를 DB에 저장하기 위한 메서드 생성(사장 -> 부장)
				int result = memberservice.insertMembers(memberVO);
				
				session = req.getSession();
				req.setAttribute("result", result);
				
				nextPage = "/login.jsp";
		
			/* 회원가입 이메일 중복 */
			} else if (action.equals("/emailcheck.do")) { // 1:이메일중복, 0:이메일중복아님

				String email = req.getParameter("Email");
				// System.out.println(email);

				int respData = memberservice.emailMembers(email);
				session = req.getSession();
				session.setAttribute("respData", respData);

				// 웹브라우저로 응답할 데이터종류(MIME-TYPE) 설정, 한글처리 설정
				resp.setContentType("text/html;charset=utf-8");

				// 클라이언트의 웹브라우저로 응답할 출력 스트림 통로 객체생성
				PrintWriter out = resp.getWriter();

				out.print(respData);

				return;

			/* 로그인 */
			} else if (action.equals("/login.do")) { // OK

				String email = req.getParameter("Email");
				String pass = req.getParameter("Password");

				memberVO = memberservice.loginMembers(email, pass);

				if (email.equals(memberVO.getEmail()) && pass.equals(memberVO.getPass())) { // email, pass 모두 저장돼있음

					// java에서의 session저장방법 (참고! 위에 변수 선언 해놓음)
					session = req.getSession();
					session.setAttribute("email", email); // 세션에 저장
					session.setAttribute("pass", pass);
					session.setAttribute("name", memberVO.getName());

					nextPage = "/index.jsp";

				} else if (!email.equals(memberVO.getEmail())) { // pass 저장x(email은 저장돼있음)

					// 웹브라우저로 응답할 데이터종류(MIME-TYPE) 설정, 한글처리 설정
					resp.setContentType("text/html;charset=utf-8");

					// 클라이언트의 웹브라우저로 응답할 출력 스트림 통로 객체생성
					PrintWriter out = resp.getWriter();

					out.print("<script>");

					out.print("alert('입력하신 정보가 올바르지않습니다!');");
					out.print("history.back()");

					out.print("</script>");

					return;

				} else {

					nextPage = "/login.jsp";

				}

			/* 로그아웃 */
			} else if (action.equals("/logout.do")) { // OK

				// 저장된 email, pass, name값 얻어온 뒤 세션에서 삭제
				session = req.getSession();
				session.getAttribute("email"); // 세션에 저장
				session.getAttribute("pass");
				session.setAttribute("name", memberVO.getName());
				session.getAttribute("name");

				session.invalidate();

				nextPage = "/login.jsp";

			/* email을 비교해 이전에 입력했던 회원정보 가져와서 보여주기 */
			} else if (action.equals("/search.do")) { // ok

				session = req.getSession();
				String Email = (String) session.getAttribute("email");

				memberVO = memberservice.findMembers(Email);

				req.setAttribute("vo", memberVO);

				nextPage = "/myinfo.jsp";

			/* 회원정보 수정하기 */
			}else if (action.equals("/modmember.do")) { // ok

				String name = req.getParameter("Name");
				String add1 = req.getParameter("addr1");
				String add2 = req.getParameter("addr2");
				String add3 = req.getParameter("addr3");
				String add4 = req.getParameter("addr4");
				String email = req.getParameter("Email");
				String pwd = req.getParameter("Password");
				String pc = req.getParameter("PassCheck");

				memberVO = new MemberVO(name, add1, add2, add3, add4, email, pwd, pc);
				
				int mur = memberservice.modmembers(memberVO);
			
				nextPage = "/member/logout.do";

			/* 회원탈퇴하기 */	
			}else if(action.equals("/drop.do")) { // ok
				
				String email = req.getParameter("Email");
				System.out.println(email);
				
				memberservice.deletecheks(email);
				
				nextPage = "/member/logout.do";
				
			/* 비밀번호 찾기 */
			}else if(action.equals("/forgetpassword.do")) { // ok
				
				String name = req.getParameter("name");
				String email = req.getParameter("email");
				
				String pass = memberservice.pwdsearchs(name, email);
						
				session = req.getSession();
				req.setAttribute("pass", pass);
			
				nextPage = "/forgetAfter.jsp";
					
			/* 메일 전송 */
			}else if(action.equals("/sendmail.do")) {
				
				nextPage = "/mailSend/SendProcess.jsp";

				
				
				
			} else {

				nextPage = "/index.jsp";
			}
				// 뷰 또는 컨트롤러 재요청
				RequestDispatcher dispatch = req.getRequestDispatcher(nextPage);
				dispatch.forward(req, resp);

		} catch (Exception e) {
			e.printStackTrace();
		}

	}// doHandle

	private void alert(String string) {
		// TODO Auto-generated method stub
		
	}
}// class
