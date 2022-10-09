package kr.ac.kyonggi.cs.handler.stateenum;

public enum Capstone {
	
	Uncomplete(1,"미이수"),
	Incomplete(2,"이수중"),
	Complete(3,"이수"),
	Non(4,"해당없음");
	
	final int capstone;
	final String str;
	
	Capstone(int capstone,String str){
		this.capstone=capstone;
		this.str=str;
	}
	
	public static String getCapstone(int capstone) {
		String result=null;
		
		for(Capstone c: Capstone.values()) {
			if(c.capstone==capstone)
				result=c.str;
		}
		
		return result;
	}
}
