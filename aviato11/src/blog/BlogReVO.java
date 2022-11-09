package blog;

public class BlogReVO {
	
	private int r_idx;
	private String r_name;
	private String r_content;
	private int r_group;
	private int r_level;
	private String r_date;
	
	public BlogReVO() {
		
	}

	public BlogReVO(int r_idx, String r_name, String r_content, int r_group, int r_level, String r_date) {
		super();
		this.r_idx = r_idx;
		this.r_name = r_name;
		this.r_content = r_content;
		this.r_group = r_group;
		this.r_level = r_level;
		this.r_date = r_date;
	}

	public int getR_idx() {
		return r_idx;
	}

	public void setR_idx(int r_idx) {
		this.r_idx = r_idx;
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
	
	
	
}
