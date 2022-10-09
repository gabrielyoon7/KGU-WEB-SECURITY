package kr.ac.kyonggi.cs.handler.dto.graduation;

import java.util.Date;

public class GraduationStateListDTO {
	
	public int schedule_name_int;
	public String schedule_name;
	public Date starting_date;
	public Date end_date;
	public String btn_name;
	public String note;
	public int state_enum;
	public Date action_date;
	private Date thesis_delay;
	
	
	//임시로 가져옴
	public int request;
	public Date request_action_date;
	public int suggest;
	public Date suggest_action_date;
	public int interim;
	public Date interim_action_date;
	public int fin;
	private String starting_date_str;
	private String end_date_str;
	
	public Date getThesis_delay() {
		return thesis_delay;
	}
	public void setThesis_delay(Date thesis_delay) {
		this.thesis_delay = thesis_delay;
	}
	public String getStarting_date_str() {
		return starting_date_str;
	}
	public void setStarting_date_str(String starting_date_str) {
		this.starting_date_str = starting_date_str;
	}
	public String getEnd_date_str() {
		return end_date_str;
	}
	public void setEnd_date_str(String end_date_str) {
		this.end_date_str = end_date_str;
	}
	public Date final_action_date;
	public int getSchedule_name_int() {
		return schedule_name_int;
	}
	public void setSchedule_name_int(int schedule_name_int) {
		this.schedule_name_int = schedule_name_int;
	}
	public String getSchedule_name() {
		return schedule_name;
	}
	public void setSchedule_name(String schedule_name) {
		this.schedule_name = schedule_name;
	}
	public Date getStarting_date() {
		return starting_date;
	}
	public void setStarting_date(Date starting_date) {
		this.starting_date = starting_date;
	}
	public Date getEnd_date() {
		return end_date;
	}
	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}
	public String getBtn_name() {
		return btn_name;
	}
	public void setBtn_name(String btn_name) {
		this.btn_name = btn_name;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public int getRequest() {
		return request;
	}
	public void setRequest(int request) {
		this.request = request;
	}
	public Date getRequest_action_date() {
		return request_action_date;
	}
	public void setRequest_action_date(Date request_action_date) {
		this.request_action_date = request_action_date;
	}
	public int getSuggest() {
		return suggest;
	}
	public void setSuggest(int suggest) {
		this.suggest = suggest;
	}
	public Date getSuggest_action_date() {
		return suggest_action_date;
	}
	public void setSuggest_action_date(Date suggest_action_date) {
		this.suggest_action_date = suggest_action_date;
	}
	public int getInterim() {
		return interim;
	}
	public void setInterim(int interim) {
		this.interim = interim;
	}
	public Date getInterim_action_date() {
		return interim_action_date;
	}
	public void setInterim_action_date(Date interim_action_date) {
		this.interim_action_date = interim_action_date;
	}
	public int getFin() {
		return fin;
	}
	public void setFin(int fin) {
		this.fin = fin;
	}
	public Date getFinal_action_date() {
		return final_action_date;
	}
	public void setFinal_action_date(Date final_action_date) {
		this.final_action_date = final_action_date;
	}
	public int getState_enum() {
		return state_enum;
	}
	public void setState_enum(int state_enum) {
		this.state_enum = state_enum;
	}
	public Date getAction_date() {
		return action_date;
	}
	public void setAction_date(Date action_date) {
		this.action_date = action_date;
	}
	
}
