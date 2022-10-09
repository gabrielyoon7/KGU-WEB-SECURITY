package kr.ac.kyonggi.cs.handler.dto.graduation;

import java.util.Date;

public class GraduationUserDTO {

	private int per_id;
	private String name;
	private String prof_name;
	private String graduation_date;
	private String major;
	private int current_state;
	private String current_state_string;
	private int request;
	private String request_string;
	private Date request_action_date;
	private int suggest;
	private String suggest_string;
	private Date suggest_action_date;
	private int interim;
	private String interim_string;
	private Date interim_action_date;
	private int fin;
	private String fin_string;
	private Date final_action_date;
	private Date thesis_delay;
	private int capstone;
	//jonghun capsone string 처리
	private String capstone_str;
	
	private String etc_accept;
	private int delay_count;
	private int current;
	private String current_str;
	
	public String getCapstone_str() {
		return capstone_str;
	}
	public void setCapstone_str(String capstone_str) {
		this.capstone_str = capstone_str;
	}
	public int getDelay_count() {
		return delay_count;
	}
	public void setDelay_count(int delay_count) {
		this.delay_count = delay_count;
	}
	public int getCurrent() {
		return current;
	}
	public void setCurrent(int current) {
		this.current = current;
	}
	public String getCurrent_str() {
		return current_str;
	}
	public void setCurrent_str(String current_str) {
		this.current_str = current_str;
	}
	public int getPer_id() {
		return per_id;
	}
	public void setPer_id(int per_id) {
		this.per_id = per_id;
	}
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	public String getProf_name() {
		return prof_name;
	}
	public void setProf_name(String prof_name) {
		this.prof_name = prof_name;
	}
	public String getGraduation_date() {
		return graduation_date;
	}
	public void setGraduation_date(String graduation_date) {
		this.graduation_date = graduation_date;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public int getCurrent_state() {
		return current_state;
	}
	public void setCurrent_state(int current_state) {
		this.current_state = current_state;
	}
	public String getCurrent_state_string() {
		return current_state_string;
	}
	public void setCurrent_state_string(String current_stae_string) {
		this.current_state_string = current_stae_string;
	}
	public int getRequest() {
		return request;
	}
	public void setRequest(int request) {
		this.request = request;
	}
	public String getRequest_string() {
		return request_string;
	}
	public void setRequest_string(String request_string) {
		this.request_string = request_string;
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
	public String getSuggest_string() {
		return suggest_string;
	}
	public void setSuggest_string(String suggest_string) {
		this.suggest_string = suggest_string;
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
	public String getInterim_string() {
		return interim_string;
	}
	public void setInterim_string(String interim_string) {
		this.interim_string = interim_string;
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
	public String getFin_string() {
		return fin_string;
	}
	public void setFin_string(String fin_string) {
		this.fin_string = fin_string;
	}
	public Date getFinal_action_date() {
		return final_action_date;
	}
	public void setFinal_action_date(Date fin_action_date) {
		this.final_action_date = fin_action_date;
	}
	public Date getThesis_delay() {
		return thesis_delay;
	}
	public void setThesis_delay(Date thesis_delay) {
		this.thesis_delay = thesis_delay;
	}
	public int getCapstone() {
		return capstone;
	}
	public void setCapstone(int capstone) {
		this.capstone = capstone;
	}
	public String getEtc_accept() {
		return etc_accept;
	}
	public void setEtc_accept(String etc_accept) {
		this.etc_accept = etc_accept;
	}
	
	
	
}
