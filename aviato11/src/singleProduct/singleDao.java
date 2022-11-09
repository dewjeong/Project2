package singleProduct;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.StringTokenizer;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class singleDao {
	
	
	Connection con;

	PreparedStatement pstmt;

	ResultSet rs;

	String sql;
	
	singleBean sBean;
	
	related_Pd_Bean relBean;
	

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

	public void close() {

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
	
	
	/*글번호를 기준으로 제품 정보를 조회해오는 메소드*/
	public singleBean selectProduct(int pdNum) {
		
		sBean = new singleBean();
		
		try {
			
			con = getCon();
			
			sql = "select * from products where pdNum = ?";
			
			pstmt= con.prepareStatement(sql);
			
			pstmt.setInt(1, pdNum);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			sBean.setPdNum(rs.getInt(1));
			sBean.setPdName(rs.getString(2));
			sBean.setPdPrice(rs.getString(3));
			sBean.setpdImg_Main(rs.getString(4));
			sBean.setPdImg_Sub(rs.getString(5));
			sBean.setpdCategory(rs.getString(6));
			sBean.setpdInfo(rs.getString(7));
			
			sBean.setSale(rs.getString(9));
			sBean.setSale_Val(rs.getInt(10));
			
			
		} catch (Exception e) {
			System.out.println("selectProduct메소드 오류 발생 : "+e);
			e.printStackTrace();
		}finally {
			close();
		}
		
		return sBean;
		
	}//selectProduct메소드 끝
	
	
	/*글번호로 제품을 조회한 후, 카테고리가 같은 상품을 조회해주는 메소드*/
	public List<related_Pd_Bean> relatedPd(int pdNum) {
			
			List<related_Pd_Bean> relatedList = new ArrayList<related_Pd_Bean>();
			sBean = new singleBean();		
			
			try {
				
				sBean = selectProduct(pdNum);
				String pdCat = sBean.getpdCategory();
				int no = sBean.getPdNum();
				
				con = getCon();
				sql = "select * from products";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
						
					if(no != rs.getInt(1)) {						
						
						String rel_category = rs.getString("pdCategory");
						StringTokenizer rel = new StringTokenizer(rel_category, ",");
						
						while(rel.hasMoreTokens()) {
							String token = rel.nextToken();
							
							if(pdCat.contains(token)) {
								
								relBean = 
										new related_Pd_Bean(rs.getInt(1), rs.getString(2), rs.getString(3), 
																		rs.getString(4), rs.getString(9), rs.getInt(10));
								break;//토큰 while문 빠져나감
							}
						}//안쪽 while	
						
							if(relatedList.size() != 0) {
								for(int i=0; i<relatedList.size(); i++) {
									if(relatedList.indexOf(relBean) == -1) {//리스트에 담겨있지 않은 제품일 때만 리스트에 추가
										relatedList.add(relBean);
										
/*indexOf(Object o)는 인자로 객체를 받습니다.
 *  리스트의 앞쪽부터 인자와 동일한 객체가 있는지 찾으며, 존재한다면 그 인덱스를 리턴합니다.
 *  존재하지 않는다면 -1을 리턴합니다.*/
									}
								}
							}else if(relatedList.size() == 0){relatedList.add(relBean);}							
							
					}//글번호 판별하는 if문			
				}//바깥 while						
				
			} catch (Exception e) {
				System.out.println("relatedPd메소드 오류 발생 : "+e);
				e.printStackTrace();
			}finally {
				close();
			}
			
			return relatedList;//리스트에 관련상품을 담아서 서비스로 반환
		}

}
