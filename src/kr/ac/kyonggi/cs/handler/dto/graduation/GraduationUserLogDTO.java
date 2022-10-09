package kr.ac.kyonggi.cs.handler.dto.graduation;

import java.util.Date;

public class GraduationUserLogDTO {
	
	private int id;
	private int per_id;
	private Date log_date;
	private int grd_state;
	private String grd_state_string;
	private int user_log;
	private String user_log_string;
	private int admin_log;
	private String admin_log_string;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPer_id() {
		return per_id;
	}
	public void setPer_id(int per_id) {
		this.per_id = per_id;
	}
	public Date getLog_date() {
		return log_date;
	}
	public void setLog_date(Date log_date) {
		this.log_date = log_date;
	}
	public int getGrd_state() {
		return grd_state;
	}
	public void setGrd_state(int grd_state) {
		this.grd_state = grd_state;
	}
	public String getGrd_state_string() {
		return grd_state_string;
	}
	public void setGrd_state_string(String grd_state_string) {
		this.grd_state_string = grd_state_string;
	}
	public int getUser_log() {
		return user_log;
	}
	public void setUser_log(int user_log) {
		this.user_log = user_log;
	}
	public String getUser_log_string() {
		return user_log_string;
	}
	public void setUser_log_string(String user_log_string) {
		this.user_log_string = user_log_string;
	}
	public int getAdmin_log() {
		return admin_log;
	}
	public void setAdmin_log(int admin_log) {
		this.admin_log = admin_log;
	}
	public String getAdmin_log_string() {
		return admin_log_string;
	}
	public void setAdmin_log_string(String admin_log_string) {
		this.admin_log_string = admin_log_string;
	}
	

}
