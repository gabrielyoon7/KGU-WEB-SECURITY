package kr.ac.kyonggi.cs.handler.stateenum;

public enum UserAction {
	
	Submit(1,"제출"),
	Modify(2,"수정"),
	Add(3,"추가"),
	DeleteNoEtc(4,"삭제"),
	DeleteEtc(5,"삭제");
	
	final int useraction;
	final String str;
	
	UserAction(int useraction,String str){
		this.useraction=useraction;
		this.str=str;
	}
	
	public static String getUserAction(int useraction) {
		String result=null;
		
		for(UserAction u:UserAction.values()) {
			if(u.useraction==useraction) {
				result=u.str;
			}
			
		}
		return result;
	}
	

}
