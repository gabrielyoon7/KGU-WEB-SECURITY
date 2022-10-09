package kr.ac.kyonggi.cs.handler.stateenum;

public enum Log {
	
	Extension(1,"연장"),
	ReturnBeforeDeadLine(2,"반려"),
	ReturnAfterDeadLine(3,"반려"),
	Approval(4,"승인"),
	Submit(5,"제출"),
	Modify(6,"수정"),
	Add(7,"추가"),
	DeleteNoEtc(8,"삭제"),
	DeleteEtc(9,"삭제");
	
	final int num;
	final String action;
	

	Log(int num,String action){
		this.num=num;
		this.action=action;
	}
	
	public static String getAction(int state) {
		String result=null;
		
		for(Log l:Log.values()) {
			if(l.num==state) {
				result=l.action;
			}
		}
		return result;
	}
}
