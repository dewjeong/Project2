package singleProduct;

import java.util.ArrayList;
import java.util.List;

public class reviewService {

	reviewDao rDao;
	
	
	public reviewService() {
		rDao = new reviewDao();
	}
	
	
	/*리뷰 보여주기*/
	public List<reviewBean> show(int os, int pdNum) {
		
		return rDao.show(os, pdNum);
		
		
	}

	/*전체 부모글의 갯수 조회*/
	public int countReviews(int pdNum) {
		
		return rDao.count(pdNum); 
	}


	public List<reviewBean> reply(int pdNum, List rList) {
	
		return rDao.reply(pdNum, rList);
	}

	/*리뷰(부모글) INSERT*/
	public int leaveReview(String content, int pdNum, String name, String email) {
		return rDao.leaveReview(content, pdNum, name, email);		
	}

	/*댓글 INSERT*/
	public int leaveReply(int rptNo, String content, int pdNum, String name, String email) {
		
		return rDao.leaveReply(rptNo, content, pdNum, name, email);
	}

	/*댓글 삭제*/
	public int deleteReply(int rNo) { 
		
		return rDao.deleteReply(rNo);
	}

	/*리뷰 삭제*/
	public int deleteReview(int rNo, int pdNum) {
		
		return rDao.deleteReview(rNo, pdNum);
	}

	/*글번호로에 해당하는 글 조회*/
	public String getReview(int rNo, int pdNum) {
		
		return rDao.getReview(rNo, pdNum);
	}

	/*글번호에 해당하는 글 수정하기*/
	public int editReview(int rNo, int pdNum, String rContent) {
		
		return rDao.editReview(rNo, pdNum, rContent);
	}

	

}
