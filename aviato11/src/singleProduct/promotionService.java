package singleProduct;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import MemberAction.MemberVO;




public class promotionService extends HttpServlet{

	static promoDAO pDao;
	
	public static int sendProccess(String email, HttpServletRequest req, HttpServletResponse resp) {

		int result = 0;
		
		// 폼값(이메일 내용) 저장
		Map<String, String> emailInfo = new HashMap<String, String>();
		emailInfo.put("from", "kahncho0713@naver.com");  // 보내는 사람
		emailInfo.put("to", "ise0305@naver.com");      // 받는 사람
		emailInfo.put("subject", "$30 할인 쿠폰코드입니다~~발급일로부터 24시간 동안 유효합니다!!");  // 제목

		// 내용
		String content = promoCode.randomCode(10);  // 내용
		
	
		    
		    // 변환된 내용을 저장
		    emailInfo.put("content", content);
		    emailInfo.put("format", "text/html;charset=UTF-8");
		
		try {
			//쿠키에 프로모션코드 저장
			cookie.setCookie(resp, content, email);
			
			
			 NaverSMTP smtpServer = new NaverSMTP();  // 메일 전송 클래스 생성
			    smtpServer.emailSending(emailInfo);      // 전송
			
			 result = 1;//성공하면 1 반환
			 if(result == 1) {
				 pDao = new promoDAO();
				 pDao.addEmail(email);
			 }
			 
			
		} catch (Exception e) {
			System.out.println("sendService 내부 오류 발생 "+e);
			e.printStackTrace();
			
			result = -1;//실패하면 
		}
		
		return result;
	}

	
	/*체크아웃에서 쿠폰코드 입력하면 할인 적용시켜주는 메소드*/
	public static int getDiscount(HttpServletRequest req, String email, String code) throws UnsupportedEncodingException {
		
		int result = 0;
		String value = "";
		
		value = cookie.getCookie(req, email);
		if(code.equals(value)) {
			result = 1;//알맞은 프로모션 코드 입력
		}else {result = -1;}//잘못된 프로모션 코드 입력
		
		return result;
	}


	/*checkout.jsp페이지에서 place order버튼 눌렀을 때*/
	public static void placeOrder(HttpServletRequest req, HttpServletResponse resp, String email){
		
		 Cookie[] cookies=req.getCookies(); // 모든 쿠키 가져오기
		    if(cookies!=null){
		        for (Cookie c : cookies) {
		            String name = c.getName(); // 쿠키 이름 가져오기
		            String value = c.getValue(); // 쿠키 값 가져오기
		            if (name.equals(email)) {//같은 이름의 쿠키가 조회된다면?
		               cookie.deleteCookie(resp, email);//쿠키 삭제 => 프로모션 코드 삭제 
		            }
		        }
		    }
		
		
	}

	/*DB에 프로모션 코드 발급받은 이력이 없는 이메일 저장*/
	public static boolean usedCheck(String email) {
		pDao = new promoDAO();
		
		return pDao.usedCheck(email);
	}

	/*email을 이용해서 주소 정보를 받아오는 메소드*/
	public MemberVO getAddress(String email) {

		pDao = new promoDAO();

		return pDao.getAddress(email);
	}
	
	
}
