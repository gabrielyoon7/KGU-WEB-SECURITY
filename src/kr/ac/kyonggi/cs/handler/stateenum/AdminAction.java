package kr.ac.kyonggi.cs.handler.stateenum;

public enum AdminAction {
	
	Extension(1,"연장"),
	ReturnBeforeDeadLine(2,"반려"),
	ReturnAfterDeadLine(3,"반려"),
	Approval(4,"승인");
	
	final int action;
	final String str;
	
	AdminAction(int action,String str){
		this.action=action;
		this.str=str;
	}
	
	public static String gerAction(int action) {
		String result=null;
		
		for(AdminAction a: AdminAction.values()) {
			if(a.action==action)
				result=a.str;
		}
		return result;
	}

}
