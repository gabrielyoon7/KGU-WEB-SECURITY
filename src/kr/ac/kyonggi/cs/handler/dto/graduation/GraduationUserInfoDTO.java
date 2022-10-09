package kr.ac.kyonggi.cs.handler.dto.graduation;

import java.util.Date;

public class GraduationUserInfoDTO {
	private int per_id;
	private String name;
	private String prof_name;
	private String graduation_date;
	private int request;
	private int suggest;
	private int interim;
	private int fin;
	private Date delay_date;
	private int capstone;
	private int certi_level_int;
	private int confe_level_int;
	private int contest_level_int;
	private int level_num;
	private Date thesis_delay;
	
	public Date getThesis_delay() {
		return thesis_delay;
	}
	public void setThesis_delay(Date thesis_delay) {
		this.thesis_delay = thesis_delay;
	}
	public int getLevel_num() {
		return level_num;
	}
	public void setLevel_num(int level_num) {
		this.level_num = level_num;
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
	
	
	public int getRequest() {
		return request;
	}
	public void setRequest(int request) {
		this.request = request;
	}
	public int getSuggest() {
		return suggest;
	}
	public void setSuggest(int suggest) {
		this.suggest = suggest;
	}
	public int getInterim() {
		return interim;
	}
	public void setInterim(int interim) {
		this.interim = interim;
	}
	public int getFin() {
		return fin;
	}
	public void setFin(int fin) {
		this.fin = fin;
	}
	public Date getDelay_date() {
		return delay_date;
	}
	public void setDelay_date(Date delay_date) {
		this.delay_date = delay_date;
	}
	public int getCapstone() {
		return capstone;
	}
	public void setCapstone(int capstone) {
		this.capstone = capstone;
	}
	public int getCerti_level_int() {
		return certi_level_int;
	}
	public void setCerti_level_int(int certi_level_int) {
		this.certi_level_int = certi_level_int;
	}
	public int getConfe_level_int() {
		return confe_level_int;
	}
	public void setConfe_level_int(int confe_level_int) {
		this.confe_level_int = confe_level_int;
	}
	public int getContest_level_int() {
		return contest_level_int;
	}
	public void setContest_level_int(int contest_level_int) {
		this.contest_level_int = contest_level_int;
	}
	
	

}
