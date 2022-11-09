package blog;

public class BlogVO {
	private int b_idx;
	private String b_pw;
	private String b_name;
	private String b_title;
	private String b_content;
	private String b_date;
	private String b_imageFN;
	private int b_cnt;
	
	private int r_idx;
	private String r_pw;
	private String r_name;
	private String r_content;
	private int r_group;
	private int r_level;
	private String r_date;
	
	public BlogVO() {
		
	}

	public BlogVO(int b_idx, String b_pw, String b_name, String b_title, String b_content,
			String b_date, String b_imageFN, int b_cnt) {
		super();
		this.b_idx = b_idx;
		this.b_pw = b_pw;
		this.b_name = b_name;
		this.b_title = b_title;
		this.b_content = b_content;
		this.b_date = b_date;
		this.b_imageFN = b_imageFN;
		this.b_cnt = b_cnt;
	}
	
	
	

	public BlogVO(int b_idx, String b_pw, String b_name, String b_title, String b_content, 
			String b_date, String b_imageFN, int b_cnt, int r_idx, String r_pw, String r_name,
			String r_content, int r_group, int r_level, String r_date) {
		super();
		this.b_idx = b_idx;
		this.b_pw = b_pw;
		this.b_name = b_name;
		this.b_title = b_title;
		this.b_content = b_content;
		this.b_date = b_date;
		this.b_imageFN = b_imageFN;
		this.b_cnt = b_cnt;
		this.r_idx = r_idx;
		this.r_name = r_name;
		this.r_content = r_content;
		this.r_group = r_group;
		this.r_level = r_level;
		this.r_date = r_date;
	}

	public int getB_idx() {
		return b_idx;
	}

	public void setB_idx(int b_idx) {
		this.b_idx = b_idx;
	}

	public String getB_pw() {
		return b_pw;
	}

	public void setB_pw(String b_pw) {
		this.b_pw = b_pw;
	}

	public String getB_name() {
		return b_name;
	}

	public void setB_name(String b_name) {
		this.b_name = b_name;
	}

	public String getB_title() {
		return b_title;
	}

	public void setB_title(String b_title) {
		this.b_title = b_title;
	}

	public String getB_content() {
		return b_content;
	}

	public void setB_content(String b_content) {
		this.b_content = b_content;
	}

	public String getB_date() {
		return b_date;
	}

	public void setB_date(String b_date) {
		this.b_date = b_date;
	}

	public String getB_imageFN() {
		return b_imageFN;
	}

	public void setB_imageFN(String b_imageFN) {
		this.b_imageFN = b_imageFN;
	}

	public int getB_cnt() {
		return b_cnt;
	}

	public void setB_cnt(int b_cnt) {
		this.b_cnt = b_cnt;
	}

//	댓글DB
	public int getR_idx() {
		return r_idx;
	}

	public void setR_idx(int r_idx) {
		this.r_idx = r_idx;
	}

	public String getR_pw() {
		return r_pw;
	}

	public void setR_pw(String r_pw) {
		this.r_pw = r_pw;
	}

	public String getR_name() {
		return r_name;
	}

	public void setR_name(String r_name) {
		this.r_name = r_name;
	}

	public String getR_content() {
		return r_content;
	}

	public void setR_content(String r_content) {
		this.r_content = r_content;
	}

	public int getR_group() {
		return r_group;
	}

	public void setR_group(int r_group) {
		this.r_group = r_group;
	}

	public int getR_level() {
		return r_level;
	}

	public void setR_level(int r_level) {
		this.r_level = r_level;
	}

	public String getR_date() {
		return r_date;
	}

	public void setR_date(String r_date) {
		this.r_date = r_date;
	}


	
	
	
	
}//BlogVO끝
