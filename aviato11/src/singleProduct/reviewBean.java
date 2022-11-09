package singleProduct;

import java.sql.Date;

public class reviewBean {

	
	private int rNo;
	private String email;
	private String name;
	private String rContent;
	private int rPtNo;
	private int level;
	private Date rTime;
	private int pdNum;
	
	public reviewBean() {
		
	}

	public reviewBean(int rNo, String email, String name, String rContent, int rPtNo, int level, Date rTime) {
		super();
		this.rNo = rNo;
		this.email = email;
		this.name = name;
		this.rContent = rContent;
		this.rPtNo = rPtNo;
		this.level = level;
		this.rTime = rTime;
	}

	public int getrNo() {
		return rNo;
	}

	public String getEmail() {
		return email;
	}

	public String getName() {
		return name;
	}

	public String getrContent() {
		return rContent;
	}

	public int getrPtNo() {
		return rPtNo;
	}

	public int getLevel() {
		return level;
	}

	public Date getrTime() {
		return rTime;
	}

	public void setrNo(int rNo) {
		this.rNo = rNo;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setrContent(String rContent) {
		this.rContent = rContent;
	}

	public void setrPtNo(int rPtNo) {
		this.rPtNo = rPtNo;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public void setrTime(Date rTime) {
		this.rTime = rTime;
	}

	public int getPdNum() {
		return pdNum;
	}

	public void setPdNum(int pdNum) {
		this.pdNum = pdNum;
	}
	
	
	
}
