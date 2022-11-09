package singleProduct;


import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class cookie extends HttpServlet{
	
	/*쿠키 생성 메소드*/
	public static void setCookie(HttpServletResponse resp, String value, String email) throws Exception{
		value = URLEncoder.encode(value);
		System.out.println("쿠키 저장할 때 쿠키값 - "+value);
		
		email = email.replace("@", "");//@기호를 없애기
		
	    Cookie cookie = new Cookie(email, value); // 쿠키 이름을 이메일로 지정하여 생성( key, value 개념)
	    cookie.setMaxAge(60*60*24); //쿠키 유효 기간: 하루로 설정(60초 * 60분 * 24시간)
	    cookie.setPath("/"); //모든 경로에서 접근 가능하도록 설정
	    resp.addCookie(cookie); //response에 Cookie 추가

	}
	
	/*쿠키 가져오는 메소드*/
	public static String getCookie(HttpServletRequest req, String email) throws UnsupportedEncodingException{
		
		email = email.replace("@", "");
		
	    Cookie[] cookies=req.getCookies(); // 모든 쿠키 가져오기
	    if(cookies!=null){
	        for (Cookie c : cookies) {
	            String name = c.getName(); // 쿠키 이름 가져오기
	            String value = c.getValue(); // 쿠키 값 가져오기
	            value = URLDecoder.decode(value);
	            
	            System.out.println("쿠키값 : "+value);
	            
	            if (name.equals(email)) {
	                return value;//쿠키 값 반환
	            }
	        }
	    }
	    return null;
	}
	
	
	/*쿠키 제거 메소드*/
	public static void deleteCookie(HttpServletResponse resp, String cookieName){
		
		cookieName = cookieName.replace("@", "");
		
	    Cookie cookie = new Cookie(cookieName, null); // 삭제할 쿠키에 대한 값을 null로 지정
	    cookie.setMaxAge(0); // 유효시간을 0으로 설정해서 바로 만료시킨다.
	    resp.addCookie(cookie); // 응답에 추가해서 없어지도록 함
	}

	
	
	
}
