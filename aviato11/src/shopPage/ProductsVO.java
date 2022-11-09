package shopPage;


//MVC 모델중에서 Model역할 하는 클래스
//DTO역할 함
public class ProductsVO {

	private int pdNum;
	private String pdName;
	private String pdPrice;
	private String pdImg_Main;
	private String pdImg_Sub;
	private String pdCategory;
	private String pdInfo;
	private int heartCnt;
	private String sale;
	private int sale_Val;
	
	private String option;
	private String cate;
	private String search;
	
	
	public ProductsVO() { }

		
	public ProductsVO(String pdName, String pdPrice, String pdImg_Main, String pdImg_Sub, String pdCategory,
			String pdInfo, int heartCnt, String sale, int sale_Val) {
		super();
		this.pdName = pdName;
		this.pdPrice = pdPrice;
		this.pdImg_Main = pdImg_Main;
		this.pdImg_Sub = pdImg_Sub;
		this.pdCategory = pdCategory;
		this.pdInfo = pdInfo;
		this.heartCnt = heartCnt;
		this.sale = sale;
		this.sale_Val = sale_Val;
	}


	public ProductsVO(int pdNum, String pdName, String pdPrice, String pdImg_Main, String pdImg_Sub, String pdCategory,
			String pdInfo,int heartCnt, String sale, int sale_Val) {
		super();
		this.pdNum = pdNum;
		this.pdName = pdName;
		this.pdPrice = pdPrice;
		this.pdImg_Main = pdImg_Main;
		this.pdImg_Sub = pdImg_Sub;
		this.pdCategory = pdCategory;
		this.pdInfo = pdInfo;
		this.heartCnt = heartCnt;
		this.sale = sale;
		this.sale_Val = sale_Val;
	}

	
	public ProductsVO(String option, String cate, String search) {
		
		this.option = option;
		this.cate = cate;
		this.search = search;
	}



	//getter setter 메소드
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



	public String getPdInfo() {
		return pdInfo;
	}



	public void setPdInfo(String pdInfo) {
		this.pdInfo = pdInfo;
	}



	public int getHeartCnt() {
		return heartCnt;
	}



	public void setHeartCnt(int heartCnt) {
		this.heartCnt = heartCnt;
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


	
	
	public String getOption() {
		return option;
	}


	public void setOption(String option) {
		this.option = option;
	}


	public String getCate() {
		return cate;
	}


	public void setCate(String cate) {
		this.cate = cate;
	}


	public String getSearch() {
		return search;
	}


	public void setSearch(String search) {
		this.search = search;
	}



	
	
	
	
}
