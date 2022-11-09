package MemberAction;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.sql.DataSource;
import javax.naming.Context;
import javax.naming.InitialContext;

public class MemberDAO {
	
	private DataSource dataFactory;
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자 -> new MemberDAO()객체생성 시 생성자가 호출됨 -> DataSource커넥션풀 객체를 얻는 역할을 함!!!
	public MemberDAO() {
		
		try {
			// 커넥션풀 얻기
			// 1) 자바의 네이밍 서비스(JNDI)에서 이름과 실제 객체를 연결해주는 역할을 하는
			//	  initialContext()객체를 생성하여 저장
			// 	  이 객체는 네이밍 서비스를 이용하기 위한 시작점이다
			//	  이 객체의 lookup()메서드에 이름을 건네 원하는 객체를 찾아올 수 있다.
			Context initCtx = new InitialContext();
			
			// 2) "java:comp/env"경로를 얻은 InitialContext객체를 얻는다.
			// 		여기서 "java:comp/env"경로는 현재 웹프로젝트의 루트 디렉토리 경로라 생각하면 된다.
			//		즉 현재 웹프로젝트 내부에서 사용할 수 있는 모든 자원은 "java:comp/env"경로에 위치한다.
			Context ctx = (Context)initCtx.lookup("java:comp/env");	// 다운캐스팅
			
			// 3) "java:comp/env"아래에 위치한 "dbcp_myoracle"자원을 얻어온다.
			//		이 자원이 바로 앞서 설정한 DataSource(커넥션풀)이다.
			//		여기서 "dbcp_myoracle"은 context.xml파일에 추가한 <ResourceLink>에 있는 name속성의 값이다.
			dataFactory = (DataSource)ctx.lookup("jdbc/jspbeginner"); // 여기만 임의로 지정, 나머지는 공식, 암기해야 함!!
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	} // 생성자 끝
	
	// 자원해제 메서드
	private void ResourceClose() {
		
		try {
			if(pstmt != null) pstmt.close();
			if(rs != null) rs.close();
			if(conn != null) conn.close();
	
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
	} // 자원해제 끝
	
	/* DB에 회원정보 저장시켜 회원가입 작업하는 메서드 */
	public int memberInsert(MemberVO vo) {
		
		int result = 0; // 회원정보저장성공(1) or 회원정보저장실패(0)
		
		try {
			
			
			conn = dataFactory.getConnection();
			String sql = "insert into tp_member(name, add1, add2, add3, add4, email, pass, passcheck, joindate)"
					   + " values(?,?,?,?,?,?,?,?, now())";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getAdd1());
			pstmt.setString(3, vo.getAdd2());
			pstmt.setString(4, vo.getAdd3());
			pstmt.setString(5, vo.getAdd4());
			pstmt.setString(6, vo.getEmail());
			pstmt.setString(7, vo.getPass());
			pstmt.setString(8, vo.getPasscheck());
			result = pstmt.executeUpdate();

		} catch (Exception e) {			
			e.printStackTrace();
		} finally {
			ResourceClose(); // 자원해제
		}
		
		return result;
			
	}
	
	/* DB에 저장된 정보와 비교해 로그인 작업하는 메서드 */
	public MemberVO loginCheck(String email, String pass) {
		
		int check = -1;
		MemberVO vo = new MemberVO();
		
		try {			
			
			conn = dataFactory.getConnection();
			
			String query = " select * from tp_member where email=?";
			
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // DB에 email이 저장되어있다면?
				
				if( pass.equals(rs.getString("pass"))) { // password가 저장되어있다면?
				
					vo.setEmail(rs.getString("email"));
					vo.setPass(rs.getString("pass"));
					vo.setPasscheck(rs.getString("passcheck"));
					vo.setName(rs.getString("name"));
					vo.setAdd1(rs.getString("add1"));
					vo.setAdd1(rs.getString("add2"));
					vo.setAdd1(rs.getString("add3"));
					vo.setAdd1(rs.getString("add4"));
					vo.setJoinDate(rs.getDate("joindate"));
					
					check = 1; // 로그인 가능(email, pass 존재)
					
				}else { // password가 저장 안 되어있다면?
					
					check = 0;
					
				}
				
			}else { // DB에 email이 저장 안 되어있다면? 
				
				check = -1;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			// 자원해제
			ResourceClose();
		}
		
		return vo; // 1 또는 0 또는 -1 반환!
		
	} // loginCheck 끝

	/* 이메일 중복체크 메서드 */
	public int emailCheck(String email) {
		
		int respData = 0;
		
		try {
			
			conn = dataFactory.getConnection();
			
			String query = "select * from tp_member where email=?";
			
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				respData = 1; // 입력한 이메일이 존재함 -> 이메일 중복임
							
			}else {
				
				respData = 0; // 이메일 중복아님
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 자원해제
			ResourceClose();	
		}
		return respData;
	}

	/* 회원정보수정페이지에 이전 정보들 조회해서 반환해주는 메서드 */
	public MemberVO findCheck(String email) {
		
			MemberVO vo = new MemberVO();
		
		try {
			conn = dataFactory.getConnection();
			
			String query = "select * from tp_member where email=?";
			
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			
			rs.next();
			
			vo.setEmail(rs.getString("email"));
			vo.setName(rs.getString("name"));
			vo.setAdd1(rs.getString("add1"));
			vo.setAdd2(rs.getString("add2"));
			vo.setAdd3(rs.getString("add3"));
			vo.setAdd4(rs.getString("add4"));
			vo.setPass(rs.getString("pass"));
			vo.setPasscheck(rs.getString("passcheck"));					  
			
		} catch (Exception e) {	
			e.printStackTrace();	
		}finally {
			// 자원해제
			ResourceClose();					
		}

		return vo;
	}
	
	/* 회원정보 수정하기 */
	public int modCheck(MemberVO membervo) {
		
		int mur = -1;
		
		try {
			conn = dataFactory.getConnection();
			
			String query = "update tp_member set name=?, add1=?, add2=?, add3=?, add4=?, pass=?, passcheck=? where email=?";
			
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, membervo.getName());
			pstmt.setString(2, membervo.getAdd1());
			pstmt.setString(3, membervo.getAdd2());
			pstmt.setString(4, membervo.getAdd3());
			pstmt.setString(5, membervo.getAdd4());
			pstmt.setString(6, membervo.getPass());
			pstmt.setString(7, membervo.getPasscheck());
			pstmt.setString(8, membervo.getEmail());
			
			pstmt.executeUpdate();					
				
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ResourceClose();
		}
		return mur;
	}

	public int delCheck(String email) {
		
		int mdr = 1;
		
		try {
			conn = dataFactory.getConnection();
			
			String query = "delete from tp_member where email=?";
			
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, email);
			pstmt.executeUpdate();
		
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			ResourceClose();
		}
		return mdr;
		
	}

	/* 비밀번호 찾기 */
	public String pwdCheck(String name, String email) {
		
		String pwd = null;
		
		try {
			
			conn = dataFactory.getConnection();
			
			String query = "select pass from tp_member where name=? and email=?";
			
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, name);
			pstmt.setString(2, email);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				pwd = rs.getString("pass");
					
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			ResourceClose();
		}
		return pwd;
	}

	
	

	

}



