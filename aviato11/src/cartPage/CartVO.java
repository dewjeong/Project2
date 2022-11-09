package cartPage;

/**
 * @author yena
 *
 */
public class CartVO {

	private int pdNum;
	private String pdName;
	private String cartPrice;
	private String pdImg_Main;
	private String pdImg_Sub;
	private String pdCategory;
	private String sale;
	private int sale_Val;
	private int pdQty;
	private String finalPrice;
	private String pdColor;
	
	public CartVO() { }
	

	public CartVO(int pdNum, String pdName, String cartPrice, String pdImg_Main, int pdQty, String finalPrice,String pdColor) {
		super();
		this.pdNum = pdNum;
		this.pdName = pdName;
		this.cartPrice = cartPrice;
		this.pdImg_Main = pdImg_Main;
		this.pdQty = pdQty;
		this.finalPrice = finalPrice;
		this.pdColor = pdColor;
	}
	
	
	
	
	public int getPdNum() {
		return pdNum;
	}
	public void setPdNum(int pdNum) {
		this.pdNum = pdNum;
	}
	public String getPdName() {
		return pdName;
	}
	public void setPdName(String pdName) {
		this.pdName = pdName;
	}
	public String getCartPrice() {
		return cartPrice;
	}
	public void setCartPrice(String cartPrice) {
		this.cartPrice = cartPrice;
	}
	public String getPdImg_Main() {
		return pdImg_Main;
	}
	public void setPdImg_Main(String pdImg_Main) {
		this.pdImg_Main = pdImg_Main;
	}
	public String getPdImg_Sub() {
		return pdImg_Sub;
	}
	public void setPdImg_Sub(String pdImg_Sub) {
		this.pdImg_Sub = pdImg_Sub;
	}
	public String getPdCategory() {
		return pdCategory;
	}
	public void setPdCategory(String pdCategory) {
		this.pdCategory = pdCategory;
	}
	public String getSale() {
		return sale;
	}
	public void setSale(String sale) {
		this.sale = sale;
	}
	public int getSale_Val() {
		return sale_Val;
	}
	public void setSale_Val(int sale_Val) {
		this.sale_Val = sale_Val;
	}
	public int getPdQty() {
		return pdQty;
	}
	public void setPdQty(int pdQty) {
		this.pdQty = pdQty;
	}


	public String getFinalPrice() {
		return finalPrice;
	}


	public void setFinalPrice(String finalPrice) {
		this.finalPrice = finalPrice;
	}


	public String getPdColor() {
		return pdColor;
	}


	public void setPdColor(String pdColor) {
		this.pdColor = pdColor;
	}
	 
	

	

	
	
	
	
	
	
	
	
	
	
	
	
}
