package singleProduct;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import MemberAction.MemberVO;

public class promoDAO {
	
	
	Connection con;

	PreparedStatement pstmt;

	ResultSet rs;

	String sql;
	

	/* DB연결 메소드 */
	private  Connection getCon() throws Exception{
		
		// DB와 연결을 맺은 접속정보를 지닌 Connection객체를 저장할 변수
		Connection con = null;
		
		
			// 1.WAS서버와 연결된 DBApp웹프로젝트의 모든 정보를 가지고 있는 컨텍스트객체 생성
			Context init = new InitialContext();
			// 2.연결된 WAS서버에서 DataSource(커넥션풀) 검색해서 가져오기
			DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/jspbeginner");
			// DataSource(커넥션풀)에서 DB연동객체 (커넥션) 가져오기
			con = ds.getConnection(); // DB연결
			
			return con;

	}// getCon()메소드 끝

	private void close() {

		try {
			if (rs != null)// rs가 사용 중이라면..?
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();// 커넥션 풀로 Connection객체 사용 후 반납


		} catch (Exception e) {
			e.printStackTrace();
		}

	}// close메소드 끝

	
	/*DB에 프로모션코드 발급 이력있는 회원 조회*/
	public boolean usedCheck(String email) {

		boolean check =false;
		
		try {
			con = getCon();
			sql = "select * from promocode where email=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			check = rs.next();//이미 발급 이력이 있으면 true
				
		} catch (Exception e) {
			System.out.println("usedCheck메소드 내부 오류 발생 : " +e);
			e.printStackTrace();
			check = false;//발급 이력 없으면(조회 안되면) false
		}finally {
			close();
		}
		
		
		return check;
	}

	
	/*프로모션 코드 전송에 성공하면 propocode테이블에 코드 발급받은 이메일 저장*/
	public void addEmail(String email) {
		
		try {
			con = getCon();
			sql = "insert into promocode set email=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			pstmt.executeUpdate();	
			
			
		} catch (Exception e) {
			System.out.println("addEmail메소드 오류 발생:"+e );
			e.printStackTrace();
		}finally {
			close();
		}
	}

	
	/*주소정보 조회해오기*/
	public MemberVO getAddress(String email) {
		MemberVO mVo= new MemberVO();
		try {
			
			con = getCon();
			sql = "select * from tp_member where email=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				mVo.setName(rs.getString(1));
				mVo.setAdd1(rs.getString(2));
				mVo.setAdd2(rs.getString(3));
				mVo.setAdd3(rs.getString(4));
				mVo.setAdd4(rs.getString(5));
				System.out.println("dao에서 호출함"+mVo.getName());
			}
			
		} catch (Exception e) {
			System.out.println("getAddress메소드 오류 발생:"+e );
			e.printStackTrace();
		}finally {
			close();
		}				
		return mVo;
	}
	
	
	
}
