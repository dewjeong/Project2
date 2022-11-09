package singleProduct;

public class singleBean {

	private int pdNum;
	private String pdName;
	private String pdPrice;
	private String pdImg_Main;
	private String pdImg_Sub;
	private String pdInfo;
	private String pdCategory;
	private int sale_Val;
	private String sale;
	
	public singleBean() {
		
	}


	public singleBean(int pdNum, String pdName, String pdPrice, String pdImg_Main) {
		
		this.pdNum = pdNum;
		this.pdName = pdName;
		this.pdPrice = pdPrice;
		this.pdImg_Main = pdImg_Main;
		
	}


	public singleBean(int pdNum, String pdName, String pdPrice, String pdImg_Main, String pdImg_Sub, String pdInfo,
			String pdCategory) {
		
		this.pdNum = pdNum;
		this.pdName = pdName;
		this.pdPrice = pdPrice;
		this.pdImg_Main = pdImg_Main;
		this.pdImg_Sub = pdImg_Sub;
		this.pdInfo = pdInfo;
		this.pdCategory = pdCategory;
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


	public String getpdImg_Main() {
		return pdImg_Main;
	}


	public void setpdImg_Main(String pdImg_Main) {
		this.pdImg_Main = pdImg_Main;
	}


	public String getPdImg_Sub() {
		return pdImg_Sub;
	}


	public void setPdImg_Sub(String pdImg_Sub) {
		this.pdImg_Sub = pdImg_Sub;
	}


	public String getpdInfo() {
		return pdInfo;
	}


	public void setpdInfo(String pdInfo) {
		this.pdInfo = pdInfo;
	}


	public String getpdCategory() {
		return pdCategory;
	}


	public void setpdCategory(String pdCategory) {
		this.pdCategory = pdCategory;
	}


	public String getPdImg_Main() {
		return pdImg_Main;
	}


	public void setPdImg_Main(String pdImg_Main) {
		this.pdImg_Main = pdImg_Main;
	}


	public String getPdInfo() {
		return pdInfo;
	}


	public void setPdInfo(String pdInfo) {
		this.pdInfo = pdInfo;
	}


	public String getPdCategory() {
		return pdCategory;
	}


	public void setPdCategory(String pdCategory) {
		this.pdCategory = pdCategory;
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
