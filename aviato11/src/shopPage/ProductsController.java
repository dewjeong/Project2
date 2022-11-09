package shopPage;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cartPage.CartVO;


@WebServlet("/shop/*")
public class ProductsController extends HttpServlet {

		
		ProductsService productsService;
		ProductsVO productsVO;
		List<ProductsVO> productsList;
		CartVO cartVO;
		List<CartVO> cartList;
		
		@Override
		public void init() throws ServletException {
			
			productsService = new ProductsService();
			productsList = new ArrayList<ProductsVO>();
			productsVO = new ProductsVO();
			cartVO =new CartVO();
			cartList = new ArrayList<CartVO>();
		}
		
		@Override
		protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			doHandle(req, resp);
		}

		@Override
		protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			doHandle(req, resp);
		}
		
		protected void doHandle(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			
	
			String nextPage = "";
			
			HttpSession session = null;
			req.setCharacterEncoding("UTF-8");
				
			String action = req.getPathInfo();
			System.out.println(action);
			
			
			try {
				
																			
		/****** 전체 상품 및 카테고리부분 *******/		
				if(action.equals("/SelectCategory.do")) {
						
					String opt = req.getParameter("option");

					productsVO.setOption(req.getParameter("option"));
					productsVO.setCate(req.getParameter("cate"));
					productsVO.setSearch(req.getParameter("search"));
					req.setAttribute("productsVO", productsVO);
					
					req.setAttribute("option", opt);							
					
					productsList = productsService.list_category(productsVO);
					req.setAttribute("cateList", productsList);
		
				
					nextPage = "/shop-sidebar.jsp";
						
					

		/****하트아이콘클릭*****/		
				}else if(action.equals("/Heart.do")) {
					

					int pdNum = Integer.parseInt(req.getParameter("pdNum"));
				//	System.out.println("click heart pdNum." + pdNum);
					int data = productsService.update_heart(pdNum);
					
					if(data==1) {
					productsVO = productsService.selectOne(pdNum);
					data = productsVO.getHeartCnt();
					req.setAttribute("productsVO", productsVO);
					
					PrintWriter out = resp.getWriter();
					
					out.print(data);
					
					
					}
					nextPage = "/shop/ProductsList.do";
					
					return;
					
		/****카트아이콘클릭*****/					
				}else if(action.equals("/Cart.do")) {
					
					int pdNum = Integer.parseInt(req.getParameter("pNum"));
					String pdName = req.getParameter("pName");
					String cartPrice = req.getParameter("cPrice");
					String pdImg_Main = req.getParameter("pImg");
					int pdQty = Integer.parseInt( req.getParameter("pdqty"));
					String finalPrice = req.getParameter("fPrice");
					String pdColor = req.getParameter("pdColor");
					System.out.println("cart클릭" + pdColor);
					System.out.println("cart클릭" + pdName);
					System.out.println("cart클릭" + pdQty);
					
				    cartVO = new CartVO(pdNum, pdName, cartPrice, pdImg_Main, pdQty,finalPrice,pdColor);
				 
				    boolean alreadycart = false;
				    //이미 카트에 담겨있는 orgVO 객체 for문으로 꺼내서 새로 추가되는 cartVO랑 비교 
					for (CartVO orgVO : cartList) {

						System.out.println("원래" + orgVO.getPdColor());		
						System.out.println("원래" + orgVO.getPdName());	
						System.out.println("원래" + orgVO.getPdQty());	
						 if(orgVO != null) {	

							if(orgVO.getPdColor().equals( cartVO.getPdColor() ) && orgVO.getPdName().equals(cartVO.getPdName()) ) {
								orgVO.setPdQty(orgVO.getPdQty()+cartVO.getPdQty());

							alreadycart = true;
							break;
							}
						}
					}//for문

					//기존 상품이 없는 경우
					if(alreadycart==false) {
						cartList.add(cartVO);
					}				  
				   			    
					
					
					//이미 카트에 담겨있는 orgVO 객체 for문으로 꺼내서 새로 추가되는 cartVO랑 비교 
//					for (CartVO orgVO : cartList) {
//						System.out.println("원래" + orgVO.getPdColor());		
//						System.out.println("원래" + orgVO.getPdName());	
//							if(orgVO.getPdName() == cartVO.getPdName()) {
//								orgVO.setPdQty(orgVO.getPdQty()+ cartVO.getPdQty());
//								
//							
//							alreadycart = true;
//							break;
//							}
//						
//					}//for문
//					
//					//기존 상품이 없는 경우
//					if(alreadycart==false) {
//						cartList.add(cartVO);
//					}
//					
							
					session = req.getSession();
					session.setAttribute("cList", cartList);
												
					nextPage = "/cart.jsp";
		
					
		/**** 카트페이지에서 상품별 리무브 클릭 *****/	
				}else if(action.equals("/RemoveCart.do")) {	
					
					String pdName = req.getParameter("pdName");
					String pdColor = req.getParameter("pdColor");
					session = req.getSession(true);
					cartList = (List<CartVO>) session.getAttribute("cList");
					System.out.println(cartList);
		
					//arrayList배열에 담긴 객체를 하나씩 삭제하려니까 arrayList의 index때문에 
					//ConcurrentModificationException 에러 발생. 
		//			for (CartVO cartVO : cartList) {
		//				if(cartVO.getPdNum() == pdnum ) {
		//					cartList.remove(cartVO);
		//					
		//					}
		//			}
			
					//해결 방법 -> 반복문에서는 삭제할 요소들을 찾고 임시 리스트에 추가한다.
					//			그리고 removeAll()으로 임시 리스트의 모든 요소들을 삭제한다. 
					//			for loop에서 순회 중 삭제하는 것이 아니기 때문에 ConcurrentModificationException가 발생하지 않는다.
					//임시리시트 만들기
					List<CartVO> removed = new ArrayList<CartVO>();
						for (CartVO cartVO : cartList) {
							if (cartVO.getPdName().equals(pdName) && cartVO.getPdColor().equals(pdColor)) {
								removed.add(cartVO);
							}
						}
					cartList.removeAll(removed);
					
					nextPage = "/cart.jsp";
			
		/**** 카트페이지에서 전체 리무브 클릭 *****/			
				}else if(action.equals("/AllRemoveCart.do")) {
					//카트아이콘 클릭할때 세션에 저장했던 cList를 제거할려니까 또 안됨... 
					//아예 통째로 cList를 세션에서 제거하는 건데도.. 카트페이지에서는 한꺼번에 삭제됐다가.. 
					//페이지이동해서 다시 상품 담으면 그대로 남아 있음.. 그래서 위 방법이랑 같이해줌 ㅜ 이게 맞나? 몰러~
					session = req.getSession(true);
					cartList = (List<CartVO>) session.getAttribute("cList");
					
					//임시리시트 만들기
					List<CartVO> removed = new ArrayList<CartVO>();
						for (CartVO cartVO : cartList) {
								removed.add(cartVO);
						}
					cartList.removeAll(removed);
					
					session.removeAttribute("cList");
					
					nextPage = "/cart.jsp";
				
				}else{
					
					nextPage = "/shop-sidebar.jsp";
					
				}
				
				
				
				

						
				
		
			RequestDispatcher dispatch = req.getRequestDispatcher(nextPage);
							  dispatch.forward(req, resp);
				
				
				
			} catch (Exception e) {
				e.printStackTrace();
			}//catch 끝
			
			
		}// doHandle 메소드 끝
	
	//카트페이지에 상품 담기위한 클래스
//	public class Cart{
//		
//		private List<CartVO> cartList = new ArrayList<CartVO>();
//		
//		//list안에 cartVO객체 리턴하는 메소드
//		public List<CartVO> getCartList(){
//			
//			return cartList;
//			
//		}
//		
//		public void push(CartVO newVO) {
//			
//			//이미 카트에 담겨있는지 알아내는 변수
//			boolean alreadycart = false;
//			
//			//이미 카트에 담겨있는 cartVO 객체 for문으로 꺼내서 새로 추가되는 newVO랑 비교 
//			for (CartVO cartVO : cartList) {
//				
//				if(cartVO.getPdName() == newVO.getPdName() ) {
//					cartVO.setPdQty(cartVO.getPdQty()+newVO.getPdQty());
//					
//					alreadycart = true;
//					break;
//				}
//			
//			}//for문
//			
//			//기존 상품이 없는 경우
//			if(alreadycart==false) {
//				cartList.add(newVO);
//			}
//		}// push 메소드 끝
		
//	}// Cart 메소드 끝
		
}//컨트롤러
