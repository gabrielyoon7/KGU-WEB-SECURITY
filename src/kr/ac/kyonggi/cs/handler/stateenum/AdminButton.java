package kr.ac.kyonggi.cs.handler.stateenum;

public enum AdminButton {

	Unqualificate(1,"자격없음","제출 불가",null),
	Unapproval(2,"전 단계 미승인","제출 불가",null),
	Stand(3,"대기","대기",null),
	SubmitPossible(4,"제출 가능","미제출",null),
	Deadline(5,"마감","연장",null),
	SubmitComplete(6,"제출 완료","보기","form.do"),
	Approval(7,"확인","보기","form.do");
	
	final int state;
	final String str;
	final String btn;
	final String link;
	
	AdminButton(int state,String str,String btn,String link){
		this.state=state;
		this.str=str;
		this.btn=btn;
		this.link=link;
	}
	
	public static String getButtonLink(int state) {
		String link=null;
		
		for(AdminButton s:AdminButton.values()) {
			if(s.state==state) {
				link=s.link;
			}
		}
		return link;
	}
	
	public static String getButtonName(int state) {
		String btnname=null;
		
		for(AdminButton s:AdminButton.values()) {
			if(s.state==state) {
				btnname=s.btn;
			}
		}
		
		return btnname;
	}
	
	public static String getState(int state) {
		String result=null;
		
		for(AdminButton s:AdminButton.values()) {
			if(s.state==state) {
				result=s.str;
			}
		}
		return result;
	}
}
