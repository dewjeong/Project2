package MemberAction;

public class MemberService{
	
	MemberDAO memberDAO;
	
	// 기본생성자
	public MemberService() {
		memberDAO = new MemberDAO(); // //MemberService생성자 호출시 MemberDAO객체를 생성합니다.	
	}
	
	// 회원정보추가
	public int insertMembers(MemberVO vo) {
		
		return memberDAO.memberInsert(vo);	
	}

	// 로그인
	public MemberVO loginMembers(String email, String pass) {
		
		return memberDAO.loginCheck(email, pass);
		
	}
	
	// 이메일 중복확인
	public int emailMembers(String email) {
		
		return memberDAO.emailCheck(email);
	}

	// 회원정보조회 후 수정창에 출력하기
	public MemberVO findMembers(String email) {
		
		return memberDAO.findCheck(email);
		
	}

	// 회원정보수정
	public int modmembers(MemberVO membervo) {
		return memberDAO.modCheck(membervo);
		
	}
	
	// 회원탈퇴
	public int deletecheks(String email) {
		
		return memberDAO.delCheck(email);
		
	}

	// 비밀번호 찾기
	public String pwdsearchs(String name, String email) {
		
		return memberDAO.pwdCheck(name, email);
	}

	
	
	
	
	
	
	
	
	
	
	
	
	

}
