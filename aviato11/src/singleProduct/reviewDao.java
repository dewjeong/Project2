package singleProduct;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class reviewDao {

	Connection con;

	PreparedStatement pstmt;

	ResultSet rs;

	String sql;
	
	singleBean sBean;
	
	reviewBean rBean;
	

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

	
	
	/*리뷰 보여주기*/
	public List<reviewBean> show(int os, int pdNum) {
		
		List<reviewBean> rList = new ArrayList<reviewBean>();
		
		reviewBean rBean = null;
		
		try {
			con = getCon();
			
			sql = "select * from review where pdnum=? and level=0 limit 3 offset ?";
		
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, pdNum);
			pstmt.setInt(2, os);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				rBean = new reviewBean();
				rBean.setrNo(rs.getInt(1));
				rBean.setEmail(rs.getString(2));
				rBean.setName(rs.getString(3));
				rBean.setrContent(rs.getString(4));
				rBean.setrPtNo(rs.getInt(5));
				rBean.setLevel(rs.getInt(6));
				rBean.setrTime(rs.getDate(7));
				rBean.setPdNum(rs.getInt(8));
				
				rList.add(rBean);
			}
			
			
		} catch (Exception e) {
			System.out.println("show메소드 에러 발생 : " + e);
			e.printStackTrace();
		}finally {
			close();
		}
		
		return rList;
	}

	
	/*전체 부모리뷰글의 갯수 반환*/
	public int count(int pdNum) {

		int totReviews = 0;
		
		
		try {
			con = getCon();
			
			sql = "select count(*) from (select * from review where pdnum=?)pd where level=0";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, pdNum);
			rs = pstmt.executeQuery();
			rs.next();
			totReviews = rs.getInt(1);
			
		} catch (Exception e) {
			System.out.println("count메소드 내부 오류 발생 : "+e);
			e.printStackTrace();
		}finally {
			close();
		}		
	
		return totReviews;
	}//count메소드 끝

	
	/*댓글 조회하는 메소드*/
	public List<reviewBean> reply(int pdNum, List rList) {
		
		//reviewBean rBean = null;
		rBean = new reviewBean();
		
		List<reviewBean> __rList = new ArrayList<reviewBean>();
		
		try {
			int rNo;
			con = getCon();
			sql = "select * from review where pdNum=? and rptno=? and level=1";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, pdNum);
		
		for(int i=0; i<rList.size(); i++) {
			
			rNo = ((reviewBean) rList.get(i)).getrNo();//부모글번호(rptno) = 부모글의 글번호(rNo) 
			
			pstmt.setInt(2, rNo);
			
			rs =  pstmt.executeQuery();
			while(rs.next()) {
				rBean = new reviewBean();
				
				rBean.setrNo(rs.getInt(1));
				rBean.setEmail(rs.getString(2));
				rBean.setName(rs.getString(3));
				rBean.setrContent(rs.getString(4));
				rBean.setrPtNo(rs.getInt(5));
				rBean.setLevel(rs.getInt(6));
				rBean.setrTime(rs.getDate(7));
				rBean.setPdNum(rs.getInt(8));
				
				__rList.add(rBean);
			}//while
			
			
		}//for문
			
		
		}catch(Exception e){
			System.out.println("reply메소드 오류 발생 " +e);
			e.printStackTrace();
		}finally {
			close();
		}
		
		return __rList;
		
	}

	
	/*리뷰(부모글) 작성하는 메소드*/
	public int leaveReview(String content, int pdNum, String name, String email) {
	
		int totReviews =0;
		
		try {
			con = getCon();
			sql = "insert into review (email, name, rContent, level, pdNum) "
					+ " values(?, ?, ?, 0, ?)";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			pstmt.setString(2, name);
			pstmt.setString(3, content);
			pstmt.setInt(4, pdNum);
			pstmt.executeUpdate();
			
			totReviews = count(pdNum);//새 글 INSERT에 성공하면 새로 조회한 글 갯수 반환
		
		} catch (Exception e) {
			System.out.println("leaveReview메소드 에러 : "+e);
			e.printStackTrace();
		}finally {
			close();
		}
		
		return totReviews;//새 글 추가에 성공하면 전체 글의 갯수 조회해서 반환
	}//leaveReview메소드 끝

	
	/*댓글 INSERT*/
	public int leaveReply(int rptNo, String content, int pdNum, String name, String email) {
		
		int result =0;
		
		try {
			con = getCon();
			sql = "insert into review (email, name, rContent, rptNo,  level, pdNum) "
					+ " values(?, ?, ?, ?, 1, ?)";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			pstmt.setString(2, name);
			pstmt.setString(3, content);
			pstmt.setInt(4, rptNo);
			pstmt.setInt(5, pdNum);
			
			
			result = pstmt.executeUpdate();//성공하면 1 반환
			
			
			
		} catch (Exception e) {
			System.out.println("leaveReply메소드 에러 : "+e);
			e.printStackTrace();
		}finally {
			close();
		}
		
		return result;
	}//leaveReply메소드 끝

	public int deleteReply(int rNo) {

		int result = 0;
		
		try {
			con = getCon();
			sql = "delete from review where rNo=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rNo);
			result = pstmt.executeUpdate();
			
		}catch (Exception e) {
			System.out.println("deleteReply메소드 에러 : "+e);
			e.printStackTrace();
		}finally{
			close();
		}
		return result;
	}

	/*리뷰 삭제*/
	public int deleteReview(int rNo, int pdNum) {
		
		int totReviews = 0;
		
		try {
			con = getCon();
			sql = "delete from review where rNo=? or rptNo=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rNo);
			pstmt.setInt(2, rNo);
			pstmt.executeUpdate();
			
			totReviews = count(pdNum);
			
		}catch (Exception e) {
			System.out.println("deleteReview메소드 에러 : "+e);
			e.printStackTrace();
		}finally{
			close();
		}
		return totReviews;//글 삭제 성공하면 다시 부모글 갯수 조회해서 반환
	}

	/*글번호에 해당하는 글 하나를 조회*/
	public String getReview(int rNo, int pdNum) {
		
		String rContent = "";
		
		try {
			con = getCon();
			sql = "select * from review where rNo=? and pdNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rNo);
			pstmt.setInt(2, pdNum);
			rs = pstmt.executeQuery();
			
			rs.next();
			
			rContent = rs.getString("rContent");
			
		}catch (Exception e) {
			System.out.println("getReview메소드 에러 : "+e);
			e.printStackTrace();
		}finally{
			close();
		}
		
		return rContent;
	}

	public int editReview(int rNo, int pdNum, String rContent) {

		rBean = new reviewBean();
		int result = 0;
		
		try {
			con = getCon();
			sql = "update review set rContent=? where rNo=? and pdNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, rContent);
			pstmt.setInt(2, rNo);
			pstmt.setInt(3, pdNum);
			result = pstmt.executeUpdate();
			
			
			
		}catch (Exception e) {
			System.out.println("getReview메소드 에러 : "+e);
			e.printStackTrace();
		}finally{
			close();
		}
		return result;
	}

	
	
	
}
