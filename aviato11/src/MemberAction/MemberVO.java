package MemberAction;

import java.sql.Date;

public class MemberVO {
	
	private String name, add1, add2, add3, add4, email, pass, passcheck;
	private Date joinDate;
	
	// 기본 생성자
	public MemberVO() {
	 System.out.println("MemberVO 기본생성자 호출");	
	}

	// 생성자2
	public MemberVO(String name, String add1, String add2, String add3, String add4, String email, String pass, String passcheck) {
		this.name = name;
		this.add1 = add1;
		this.add2 = add2;
		this.add3 = add3;
		this.add4 = add4;
		this.email = email;
		this.pass = pass;
		this.passcheck = passcheck;
	}

	// 생성자3
	public MemberVO(String name, String add1, String add2, String add3, String add4, String email, String pass, String passcheck, Date joinDate) {
		this.name = name;
		this.add1 = add1;
		this.add2 = add2;
		this.add3 = add3;
		this.add4 = add4;
		this.email = email;
		this.pass = pass;
		this.passcheck = passcheck;
		this.joinDate = joinDate;
	}
	
	// getter, setter 메서드 호출
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAdd1() {
		return add1;
	}

	public void setAdd1(String add1) {
		this.add1 = add1;
	}

	public String getAdd2() {
		return add2;
	}

	public void setAdd2(String add2) {
		this.add2 = add2;
	}

	public String getAdd3() {
		return add3;
	}

	public void setAdd3(String add3) {
		this.add3 = add3;
	}

	public String getAdd4() {
		return add4;
	}

	public void setAdd4(String add4) {
		this.add4 = add4;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public String getPasscheck() {
		return passcheck;
	}

	public void setPasscheck(String passcheck) {
		this.passcheck = passcheck;
	}

	public Date getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}
	
}	


