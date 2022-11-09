package blog;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
//DB작업할 클래스를 사용할 수 있도록 선언문
import javax.sql.*;



//실제 게시판 DB작업 할 자바빈 클래스
public class BlogDAO {

	private Context init;
	private Statement stmt;
	private DataSource ds;
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// DB연결 생성자
	public BlogDAO() {
		
		try {
			
			//1.WAS서버와 연결된 MVCblog웹프로젝트의 모든 정보를 가지고 있는 컨텍스트 객체 생성
			//<-- META-INF 폴더의 context태그의 객체
			init = new InitialContext();
			
			//2.연결된 WAS서버에서 DataSource(커넥션풀) 검색해서 가져오기
			ds = (DataSource) init.lookup("java:comp/env/jdbc/jspbeginner");
			
		}catch(Exception err){
			err.printStackTrace();
			System.out.println("커넥션풀 검색 오류 : " + err);
		}	
		
	}//생성자 끝
	
	
	//현재 게시판에 있는 모든 글들을 ArrayList에 담아 ArrayList자체를 리턴
	public List blogAllList() {
		//b_idx를 기준으로 내림차순 정렬하여 검색
		String sql = "select * from TP_Blog order by b_idx desc";
		
		
		//게시판에 있는 글들을 검색하여 담을 그릇
		List list = new ArrayList();
		
		try {
			//DB연결
			con = ds.getConnection();
			//select를 실행할 Statement객체 반환
			stmt = con.createStatement();
			//select 검색 후 검색한 글들을 테이블 형식으로 저장한 ResultSet객체 반환
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {//다음줄이 있으면 실행. DB테이블 한 행씩
				//검색결과를 담을 객체를 생성한다.
				BlogVO vo = new BlogVO();
				//생성한 객체의 참조변수.set으로 검색값을 넣어준다.
				vo.setB_idx(rs.getInt("b_idx"));
				vo.setB_pw(rs.getString("b_pw"));
				vo.setB_name(rs.getString("b_name"));
				vo.setB_title(rs.getString("b_title"));
				vo.setB_content(rs.getString("b_content"));
				vo.setB_date(rs.getString("b_date"));
				vo.setB_imageFN(rs.getString("b_imagefn"));
				vo.setB_cnt(rs.getInt("b_cnt"));
				
				list.add(vo); //VO를 ArrayList에 담는다.
			}//while끝 DB에 존재하는 모든 행들을 한줄씩 배열의 각 인덱스에 담았다
			
			
		}catch (Exception e) {
			System.out.println("blogList() : 에서 오류 " + e);
		}finally {
			try {
					if(rs != null) {
						rs.close();
					}
				}catch(SQLException err) {
					
				}try {
					if(stmt != null) {
						stmt.close();
					}
				}catch (SQLException err) {
					
				}try {
					if(con != null) {
						con.close();
					}
				}catch (SQLException err) {
					
				}
			}//finally끝
		
		//현재 게시판에 있는 모든 글들을 ArrayList에 담아 ArrayList자체를 리턴
		return list;
	}//blogList() 끝
	
	//현재 게시판에 저장되어 있는 전체 글개수 반환 (페이징기술에 사용)
	public int getTotalRecord() {
		//게시판 검색 후 저장된 전체 글 개수 저장
		int total = 0;
		//게시판 테이블의 전체 레코드 수 구하기
		String sql = "select count(*) from TP_Blog";
		
		try {
			//DB연결
			con = ds.getConnection();
			//select를 실행할 Statement객체 반환
			stmt = con.createStatement();
			//select 검색 후 검색한 결과 전체 레코드 개수를 테이블 형식으로 저장한...
			//ResultSet객체 반환
			rs = stmt.executeQuery(sql);
			//만약 검색한 전체 글 개수가 있다면
			if(rs.next()) {
				//전체 글개수 저장
				total = rs.getInt(1);
			}
			
		}catch (Exception e) {
			System.out.println("getTotalRecord : 에서 오류" + e);
			System.out.println(total);
		}finally {
			try {
				if(rs != null) {
					rs.close();
				}
			} catch (SQLException err) {
				
			}
			try {
				if(stmt != null) {
					stmt.close();
				}
			}catch (SQLException err) {
				
			}
			try {
				if(con != null) {
					con.close();
				}
			}catch (SQLException err) {
				
			}
		}//finally끝
		
		return total; //게시판에 저장된 총 글 개수 반환
	
	}//getTotalRecord 끝

	
	//글목록에서 검색했을때 해당 검색어를 포함한 글 DB조회하는 메소드
	public List BlogList(String k, String w) {
		
		String sql = "";
		//select한 DTO객체글들을 담기위한 공간
		List list = new ArrayList();
		//검색어를 입력 했다면
		if(!w.equals("")) {
			//검색기준값이 제목+내용 과 같다면...
			if(k.equals("titleContent")) {
			//참고!!titleContent은 list.jsp에서
			//검색기준값 셀렉트박스의 옵션 제목+내용의 value값 "titleContent"에서 가져온거
				
				//글 제목 중에 검색어가 한자라도 들어가있거나
				//글 내용중에 검색어가 한자라도 들어가 있는 글들을 검색
				//단! 글번호를 기준으로 해서 내림차순 정렬하여 검색
				sql = "select * from TP_BLOG where "
					+ "b_title like '%" + w + "%' "
					+ "or b_content like '%" + w + "%' "
					+ "order by b_idx desc";
			}else {//검색 기준값이 작성자이면
				sql = "select * from TP_BLOG where "
					+ "b_name like '%" + w + "%' "
					+ "order by b_idx desc";
			}
		//검색어를 입력하지 않았다면..
		}else {
			//모든 글 검색
			//단 ! 글번호를 기준으로 해서 내림차순 정렬하여 검색
			sql = "select * from TP_BLOG order by b_idx desc";
		}
		
		
		try {
			//DB연결
			con = ds.getConnection();
			//select를 실행할 Statement객체 반환
			stmt = con.createStatement();
			//select 검색 후 검색한 글들을 테이블 형식으로 저장한 ResultSet객체 반환
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {//다음줄이 있으면 실행. DB테이블 한 행씩
				//검색결과를 담을 객체를 생성한다.
				BlogVO vo = new BlogVO();
				//생성한 객체의 참조변수.set으로 검색값을 넣어준다.
				vo.setB_idx(rs.getInt("b_idx"));
				vo.setB_pw(rs.getString("b_pw"));
				vo.setB_name(rs.getString("b_name"));
				vo.setB_title(rs.getString("b_title"));
				vo.setB_content(rs.getString("b_content"));
				vo.setB_date(rs.getString("b_date"));
				vo.setB_imageFN(rs.getString("b_imagefn"));
				vo.setB_cnt(rs.getInt("b_cnt"));
				
				list.add(vo); //vo를 ArrayList에 담는다.
			}//while끝 해당 검색어를 포함하는 모든 행들을 list에 담았다.
		}catch (Exception e) {
			System.out.println("BlogList(String k, String w) : 에서 오류 " + e);
		}finally {
			try {
					if(rs != null) {
						rs.close();
					}
				}catch(SQLException err) {
					
				}try {
					if(stmt != null) {
						stmt.close();
					}
				}catch (SQLException err) {
					
				}try {
					if(con != null) {
						con.close();
					}
				}catch (SQLException err) {
					
				}
			}//finally끝
		
		return list;
	}//BlogList(k,w)끝
		
	//write.jsp에서 입력받은 내용을 컨트롤러에서 vo에 담아와서
	//DB에 추가하는 작업을 할 메소드입니다. List목록글!!!!!!!!!
	//새 글쓰기 메소드
	public int blogInsert(BlogVO vo) {
		
		//vo에 담겨서 넘어온 입력값들 변수에 저장
		int idx =  vo.getB_idx();
		String name = vo.getB_name();
		String pass = vo.getB_pw();
		String title = vo.getB_title();
		String content = vo.getB_content();
		String imageFilename = vo.getB_imageFN();
		

	
	//게시판에 가장 최근에 작성된 글번호를
	//먼저 조회를 해와야 지금 추가하는 글이 몇번글이 될지 알수 있습니다
	//최근 글 번호 조회하는 sql문		
	String sql = "select max(b_idx) from TP_BLOG";
	
	
	//작성한 글 추가하는 sql문
	String insertSql = "insert into TP_BLOG(b_idx, b_pw, b_name,"
			+ " b_title, b_content, b_date, b_imageFN, b_cnt) "
			+ "values(?,?,?,?,?,now(),?,0)";
	
	try {
		//DB연결
		con = ds.getConnection();
		//게시판에 저장된 가장 최근에 추가한 가장 큰 글번호 가져오기
		pstmt = con.prepareStatement(sql);
		//rs = 실행 저장
		rs = pstmt.executeQuery();
		
		//게시판에 저장된 글의 가장큰번호가 있을경우
		if(rs.next()) {
			//글이 있을 경우 새로 추가한 글번호를 가장큰번호 +1 지정
			//max(b_idx)해서 rs에는 1개의 행,1개의 열만 조회될테니까 getInt(1)
			idx=rs.getInt(1)+1;
		}else {//게시판에 저장된 글의 가장 큰번호가 없을경우
			// 즉 글이 하나도 없을 경우 새로 추가할 글번호를 1로 지정
			idx=1;
		}
		//insert
		pstmt = con.prepareStatement(insertSql);
		
		pstmt.setInt(1, idx);
		pstmt.setString(2, pass);
		pstmt.setString(3, name);
		pstmt.setString(4, title);
		pstmt.setString(5, content);
		pstmt.setString(6, imageFilename);
		
		pstmt.executeUpdate();
		
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("boardInsert() 오류 : "+ e);
		}finally {
			try {rs.close();}catch(SQLException err) {}
			try {pstmt.close();}catch(SQLException err) {}
			try {con.close();}catch(SQLException err) {}
		}
	System.out.println("다오에서 파일이름"+ imageFilename);
		
		return idx;
	}//blogInsert메소드 끝	
	
	//테이블에 저장된 글의 조회수 증가 시키는 메소드
	public void updateCnt(String idx) {
		String sql = "update TP_BLOG set b_cnt=b_cnt+1 where b_idx=?";
		try {
			//커넥션풀 생성 후 커넥션 얻기
			con = ds.getConnection();
			//쿼리 UPDATE문 작성
			//-> 매개변수로 전달 받는 글번호에 해당하는 글의 조회수를 1증가 시켜 수정
			
			//PreparedStatement실행객체 얻기
			pstmt = con.prepareStatement(sql);
			//? 설정
			pstmt.setString(1, idx);
			//update구문 전체 실행
			pstmt.executeUpdate();
			
		}catch(Exception e){
			System.out.println("updateCnt메소드에서 오류 : "+ e);
			e.printStackTrace();
		}finally {
			try {rs.close();}catch(SQLException err) {}
			try {pstmt.close();}catch(SQLException err) {}
			try {con.close();}catch(SQLException err) {}
		}
	}//updateVisitCount메소드 끝
		
		
	//글 한개 상세조회
	public BlogVO blogRead(String idx) {
		updateCnt(idx);
		
		String sql = "select * from TP_BLOG where b_idx = " + idx;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				BlogVO vo = new BlogVO();
				vo.setB_idx(rs.getInt("b_idx"));
				vo.setB_pw(rs.getString("b_pw"));
				vo.setB_name(rs.getString("b_name"));
				vo.setB_title(rs.getString("b_title"));
				vo.setB_content(rs.getString("b_content"));
				vo.setB_date(rs.getString("b_date"));
				vo.setB_imageFN(rs.getString("b_imagefn"));
				vo.setB_cnt(rs.getInt("b_cnt"));
				
				return vo;
			}
			
		} catch (Exception e) {
			System.out.println("blogRead메소드 오류 : "+e);
		}finally {
			try {rs.close();}catch(SQLException err) {}
			try {pstmt.close();}catch(SQLException err) {}
			try {con.close();}catch(SQLException err) {}
		}
		
		return null;
	}//blogRead끝
	
	//수정할 글 비밀번호 유효성 검사하는 메소드
	public boolean modifyPass(String idx,String pass) {
		
		boolean check = false;
		try {
			//DB연결
			con = ds.getConnection();
			
			//수정할 글 번호 DB에서 조회
			String sql = "select b_pw from TP_BLOG where b_idx=?";
			
			pstmt = con.prepareStatement(sql);
			// ? 값 세팅
			pstmt.setString(1, idx);
			//update실행
			rs = pstmt.executeQuery();
			
			if(rs.next()) {//글번호가 조회된다면
				System.out.println("DB조회됨"+idx+"DB의 비밀번호"+rs.getString("b_pw")+"pass의 비밀번호"+pass);
				
				//매개변수로 받은 pass가 db에서 조회한 비밀번호가 같으면 1을 저장합니다.
				if(pass.equals(rs.getString("b_pw"))){
					
					check = true;
					System.out.println("DBresult = " + check + "idx는"+idx);
				}
				System.out.println("DBDB"+check);
			}
		}catch (Exception e) {
			System.out.println("modifyPass메소드에서 오류 : "+e);
		}finally {
			try {rs.close();}catch(SQLException err) {}
			try {pstmt.close();}catch(SQLException err) {}
			try {con.close();}catch(SQLException err) {}
		}
		
		return check;
	} //modifyPass 메소드 끝
	
	//글 수정 메소드
	public int blogModify(BlogVO vo) {
		int idx=0;
		//수정할 글 번호에 해당하는 글의 글제목,글내용 수정
		String sql = "update TP_BLOG set b_title=?, b_content=?, b_imageFN=? where b_idx=?";
		
		try {
			//DB연결
			con = ds.getConnection();
			//?를 제외한 sql문장을 pstmt에 담아놓고 pstmt자체를 반환 해서 저장
			pstmt = con.prepareStatement(sql);
			// ? 값 세팅
			pstmt.setString(1, vo.getB_title());
			pstmt.setString(2, vo.getB_content());
			pstmt.setString(3, vo.getB_imageFN());
			pstmt.setInt(4, vo.getB_idx());
			//update실행
			pstmt.executeUpdate();
			
			idx = vo.getB_idx();
			
		}catch (Exception e) {
			System.out.println("blogModify메소드에서 오류 : "+e);
		}try {pstmt.close();}catch(SQLException err) {}
		try {con.close();}catch(SQLException err) {}
		
		return idx;
	}//boardModify끝

	//삭제작업하는 메소드
	public boolean blogDelete(String idx, String passwd) {
		
		int result = 0;
		boolean B_result = false; //실행 결과 값을 저장할 변수
		
		try {
			//DB연결
			con = ds.getConnection();
			//?를 제외한 sql문장을 pstmt에 담아놓고 pstmt자체를 반환 해서 저장
			
			//삭제할 글의 글번호 조회구문
			String sql = "select * from TP_BLOG where b_idx=?";
			
			pstmt = con.prepareStatement(sql);
			// ? 값 세팅
			pstmt.setString(1, idx);
			//update실행
			rs = pstmt.executeQuery();
			
			//삭제할 해당 글번호와 비밀번호가 조회될 경우
			if(rs.next()) {
				
				String deleteSql = "delete from TP_BLOG where b_idx=? and b_pw=?";
				pstmt = con.prepareStatement(deleteSql);
				// ? 값 세팅
				pstmt.setString(1, idx);
				pstmt.setString(2, passwd);
				//update실행
				result = pstmt.executeUpdate();
				System.out.println("deleteSQL : "+idx+passwd);
			
				if(result == 1) {
					B_result = true;
				}
			}
		}catch (Exception e) {
			System.out.println("blogDelete메소드에서 오류 : "+e);
		}try {pstmt.close();}catch(SQLException err) {}
		try {con.close();}catch(SQLException err) {}
		
		return B_result;
	}//blogDelete끝
	
	//전체 댓글 목록 조회하는 메소드
	public List blogReList(String idx) {
		
		System.out.println("전체 댓글 조회메소드에서 주 글 글번호는 = "+idx);
		//r_idx를 기준으로 내림차순 정렬하여 검색
		String sql = "select * from TP_BlogRE where b_idx="+idx+" order by r_idx desc";
		
		//게시판에 있는 글들을 검색하여 담을 그릇
		List reList = new ArrayList();
		
		try {
			//DB연결
			con = ds.getConnection();
			//select를 실행할 Statement객체 반환
			pstmt = con.prepareStatement(sql);
			//update실행
			rs = pstmt.executeQuery(sql);
			
			//select 검색 후 검색한 글들을 테이블 형식으로 저장한 ResultSet객체 반환
			
			while (rs.next()) {//다음줄이 있으면 실행. DB테이블 한 행씩
				//검색결과를 담을 객체를 생성한다.
				BlogVO vo = new BlogVO();
				//생성한 객체의 참조변수.set으로 검색값을 넣어준다.
				vo.setR_idx(rs.getInt("r_idx"));
				vo.setR_pw(rs.getString("r_pw"));
				vo.setR_name(rs.getString("r_name"));
				vo.setR_content(rs.getString("r_content"));
				vo.setR_date(rs.getString("r_date"));
				vo.setR_group(rs.getInt("r_group"));
				vo.setR_level(rs.getInt("r_level"));
				vo.setB_idx(rs.getInt("b_idx"));
				
				reList.add(vo); //VO를 ArrayList에 담는다.
			}//while끝 DB에 존재하는 모든 행들을 한줄씩 배열의 각 인덱스에 담았다
				
			
		}catch (Exception e) {
			System.out.println("blogReList() : 에서 오류 " + e);
		}finally {
			try {
					if(rs != null) {
						rs.close();
					}
				}catch(SQLException err) {
					
				}try {
					if(stmt != null) {
						stmt.close();
					}
				}catch (SQLException err) {
					
				}try {
					if(con != null) {
						con.close();
					}
				}catch (SQLException err) {
					
				}
			}//finally끝
		
		//현재 게시판에 있는 모든 글들을 ArrayList에 담아 ArrayList자체를 리턴
		return reList;
	}//blogReList끝
	
	
	//새 댓글 추가하는 메소드
	public void blogReInsert(BlogVO vo) {
		
		int b_idx = vo.getB_idx();

		//게시판에 가장 최근에 작성된 글번호를
		//먼저 조회를 해와야 지금 추가하는 글이 몇번글이 될지 알수 있습니다
		//최근 글 번호 조회하는 sql문
		String sql = "select max(r_idx) from TP_BLOGRE";
		
		//작성한 글 추가하는 sql문
		String insertSql = "insert into TP_BLOGRE(r_idx, b_idx, r_pw, r_name,"
				+ " r_content, r_group, r_level, r_date) "
				+ "values(?,?,?,?,?,0,0,now())";
		
		int r_idx = 0; //추가할 글 번호 저장
		
		try {
			//DB연결
			con = ds.getConnection();
			//게시판에 저장된 가장 최근에 추가한 가장 큰 글번호 가져오기
			pstmt = con.prepareStatement(sql);
			//rs = 실행 저장
			rs = pstmt.executeQuery();
			
			//게시판에 저장된 글의 가장큰번호가 있을경우
			if(rs.next()) {
				//글이 있을 경우 새로 추가한 글번호를 가장큰번호 +1 지정
				//max(b_idx)해서 rs에는 1개의 행,1개의 열만 조회될테니까 getInt(1)
				r_idx=rs.getInt(1)+1;
			}else {//게시판에 저장된 글의 가장 큰번호가 없을경우
				// 즉 글이 하나도 없을 경우 새로 추가할 글번호를 1로 지정
				r_idx=1;
			}
			//insert
			pstmt = con.prepareStatement(insertSql);
			
			pstmt.setInt(1, r_idx);
			pstmt.setInt(2, b_idx);
			pstmt.setString(3, vo.getR_pw());
			pstmt.setString(4, vo.getR_name());
			pstmt.setString(5, vo.getR_content());
			
			pstmt.executeUpdate();
			
			System.out.println("댓글추가 메소드에서 r_idx는 "+r_idx);
			System.out.println("댓글추가 메소드에서 b_idx는 "+b_idx);
		} catch (Exception e) {
				e.printStackTrace();
				System.out.println("blogReInsert() 오류 : "+ e);
			}finally {
				try {rs.close();}catch(SQLException err) {}
				try {pstmt.close();}catch(SQLException err) {}
				try {con.close();}catch(SQLException err) {}
			}
	}//blogReInsert끝

	//댓글 삭제 메소드
	public int deleteRe(String r_idx, String b_idx) {
		int result=0;
	try {
		String sql = "delete from tp_blogre where r_idx = ? and b_idx = ?";
		//DB연결
		con = ds.getConnection();
		pstmt = con.prepareStatement(sql);
		
		pstmt.setString(1, r_idx);
		pstmt.setString(2, b_idx);
		
		result = pstmt.executeUpdate();
		
		System.out.println("댓글삭제 메소드에서 r_idx는 "+r_idx);
		System.out.println("댓글삭제 메소드에서 b_idx는 "+b_idx);
		
	} catch (Exception e) {
			e.printStackTrace();
			System.out.println("blogDelete() 오류 : "+ e);
		}finally {
			try {rs.close();}catch(SQLException err) {}
			try {pstmt.close();}catch(SQLException err) {}
			try {con.close();}catch(SQLException err) {}
		}
		return result;
	}//deleteRe끝
	
}//blogDAO 끝
