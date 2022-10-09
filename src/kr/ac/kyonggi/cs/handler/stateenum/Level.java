package kr.ac.kyonggi.cs.handler.stateenum;

public enum Level {
	
	Request(1,"신청접수"),
	Suggest(2,"제안서"),
	Interim(3,"중간보고서"),
	Final(4,"최종보고서"),
	Pass(5,"최종 통과"),
	Etc(6,"기타자격"),
	Certificate(7,"자격증"),
	Conference(8,"학술대회"),
	Contest(9,"공모전"),
	All(10,"모두");
	
	final int state;
	final String str;
	
	Level(int state,String str){
		this.state=state;
		this.str=str;
	}
	public static int getLevelInt(String sta) {
		int result=0;
		for(Level l: Level.values()) {
			if(l.str.equals(sta)) {
				result=l.state;
			}
		}
		return result;
	}
	
	public static String getLevel(int state) {
		String result=null;
		
		for(Level l:Level.values()) {
			if(l.state==state)
				result=l.str;
		}
		
		return result;
	}

}
