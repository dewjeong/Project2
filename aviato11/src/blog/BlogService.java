package blog;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import blog.BlogDAO;



//부장
//BlogDAO객체를 생성후 각기능별로 DB작업할 메소드를 호출하여 응답결과를 얻어 
//BlogController서블릿에게 보고하는 서블릿
public class BlogService {
	
	BlogDAO blogDAO;

	//생성자
	public BlogService() {
		blogDAO = new BlogDAO(); //BlogService생성자 호출시 BlogDAO객체를 생성
	}

	//1.모든 글을 조회 하기 위해 명령하는 메소드
	public List blogList() {
		
		//여기서는 List.jsp로 이동하면서
			//select한 글레코드들을 담고있는 List배열자체를
			//req에 담아서 req영역까지 같이 전달하는것입니다.
			
			//그 다음 list페이지로 가서 여기서 담아서 가져간
			//글 목록과 전체 글 개수를 뿌려주겠습니다.
			

			//현재 DB의 TP_BLOG테이블에 저장되어 있는 글목록을 검색한
			//BlogVO객체를 지니고 있는 ArrayList가져오기
			List list = blogDAO.blogAllList();//DAO안에서 DB에서 검색된 글목록 가져오기
		
		return list;
		
	}//blogList끝
	
	//전체 글 개수 조회 메소드
	public int getTotalRecord() {
		
		return blogDAO.getTotalRecord();
		
	}
	
	//검색기준값과 검색어를 전달받아 게시판에 있는 글 리스트를 보여주는 메서드
	public List BlogList(String k, String w) {
		
		return blogDAO.BlogList(k,w);
		
	}//BlogList(String k, String w) 끝

	//글목록에서 하나의 글을 클릭하여 조회할때
	public BlogVO blogRead(String idx) {
		
		return blogDAO.blogRead(idx);
	}

	//새글작성
	public int blogInsert(BlogVO vo) {
		
		return blogDAO.blogInsert(vo);
	}
	
	//상세보기 화면에서 입력받은 비밀번호와 DB의 비밀번호가 일치하는지 확인하는 메소드
	public boolean modifyPass(String idx, String pass) {
		
		boolean check = blogDAO.modifyPass(idx,pass);
		return check;
		
	}
		
	//글수정
	public int blogModify(BlogVO vo) {
		
		return blogDAO.blogModify(vo);
		
	}//blogModify끝

	//삭제메소드
	public boolean blogDelete(String idx, String passwd) {
		
		return blogDAO.blogDelete(idx,passwd);
	}

	//전체 댓글 조회하는 메소드
	public List<BlogVO> blogReList(String idx) {
		List reList = blogDAO.blogReList(idx);
		
		return reList;
	}
	
	
	//댓글 쓰기
	public void blogReInsert(BlogVO vo) {
		blogDAO.blogReInsert(vo);
		
	}

	//댓글 삭제
	public int deleteRe(String r_idx, String b_idx) {
		return blogDAO.deleteRe(r_idx, b_idx);
		
	}
	
} // BlogService 끝
