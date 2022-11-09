package singleProduct;

import java.util.List;

public class singleSevice {

	singleDao sDao;
	
	public singleSevice() {
		sDao = new singleDao();
	}
	
	
	/*글번호를 기준으로 제품 정보를 받아오는 메소드*/
	public singleBean product(int pdNum) {
		
		return sDao.selectProduct(pdNum); 
	
	}

	/*관련상품 조회*/
	public List<related_Pd_Bean> relatedPd(int pdNum) {
		
		return sDao.relatedPd(pdNum);
	}
	
	

}
