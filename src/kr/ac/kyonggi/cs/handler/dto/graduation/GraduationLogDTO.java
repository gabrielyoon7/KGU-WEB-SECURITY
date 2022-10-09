package kr.ac.kyonggi.cs.handler.dto.graduation;

import java.util.Date;

public class GraduationLogDTO {
	
	private Date log_date;
	private int statenum;
	private String  state;
	private String content;
	private String date;
	private int grd_state;
	private int user_log;
	private String logetc;
	
	public String getLogetc() {
		return logetc;
	}
	public void setLogetc(String logetc) {
		this.logetc = logetc;
	}
	public int getUser_log() {
		return user_log;
	}
	public void setUser_log(int user_log) {
		this.user_log = user_log;
	}
	public int getGrd_state() {
		return grd_state;
	}
	public void setGrd_state(int grd_state) {
		this.grd_state = grd_state;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	
	public Date getLog_date() {
		return log_date;
	}
	public void setLog_date(Date log_date) {
		this.log_date = log_date;
	}
	public int getStatenum() {
		return statenum;
	}
	public void setStatenum(int statenum) {
		this.statenum = statenum;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	

}
