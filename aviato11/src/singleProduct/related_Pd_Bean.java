package singleProduct;

public class related_Pd_Bean {
	private int pdNum;
	private String pdName;
	private String pdPrice;
	private String pdImg_Main;

	private int sale_Val;
	private String sale;
	
	public related_Pd_Bean() {
		
	}
	
	
	
	public related_Pd_Bean(int pdNum, String pdName, String pdPrice, String pdImg_Main , String sale, int sale_Val) {
		super();
		this.pdNum = pdNum;
		this.pdName = pdName;
		this.pdPrice = pdPrice;
		this.pdImg_Main = pdImg_Main;
		
		this.sale_Val = sale_Val;
		this.sale = sale;
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
	public String getPdPrice() {
		return pdPrice;
	}
	public void setPdPrice(String pdPrice) {
		this.pdPrice = pdPrice;
	}
	public String getPdImg_Main() {
		return pdImg_Main;
	}
	public void setPdImg_Main(String pdImg_Main) {
		this.pdImg_Main = pdImg_Main;
	}
	
	public int getSale_Val() {
		return sale_Val;
	}
	public void setSale_Val(int sale_Val) {
		this.sale_Val = sale_Val;
	}
	public String getSale() {
		return sale;
	}
	public void setSale(String sale) {
		this.sale = sale;
	}
	
	
	
	
	
}
