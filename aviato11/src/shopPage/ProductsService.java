package shopPage;

import java.util.List;

import cartPage.CartVO;

//ProductsDAO객체 생성후 DB관련 메소드를 호출하여 응답한 결과를 얻어서
//ProductsController서블릿에게 보고하는 클래스 (부장)
public class ProductsService {
	
	ProductsDAO productsDAO;
	
	//기본생성자
	public ProductsService() {
		productsDAO = new ProductsDAO();
	}
	



	/******** 선택한 카테고리에 해당하는 상품만 가져오는 메소드 ************/
	public List<ProductsVO> list_category(ProductsVO productsVO) {
		
		return productsDAO.selectCategory(productsVO);
	}	


	
   /******* 상품 하나만 조회 해오는 메소드 ***********/
	public ProductsVO selectOne(int pdNum) {
		
		return productsDAO.selectOneProduct(pdNum);
	}


	
	/****** 카트페이지!!!!!에 넘길 상품 하나만 가져오는 메소드 **********/
	public CartVO selectOneCart (int pdNum) {

		return productsDAO.selectCartProduct(pdNum);
	}

	
	
	/********** 하트 클릭한 상품의 하트수 얻어오는 메소드 **********/
	public int update_heart(int pdNum) {

		return productsDAO.UpHeart(pdNum);
	}






} // ProductsService 클래스 끝
