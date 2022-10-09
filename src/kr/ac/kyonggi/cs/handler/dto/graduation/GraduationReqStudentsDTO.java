package kr.ac.kyonggi.cs.handler.dto.graduation;

public class GraduationReqStudentsDTO {
	
	private int per_id;
	private String name;
	private String prof_name;
	private int capstone;
	private String capstone_string;
	private String graduation_date;
	private String etc_type;
	private String major;
	private String current_state="신청접수";
	private String grd_state_level="제출완료";
	
	public String getGrd_state_level() {
		return grd_state_level;
	}
	public void setGrd_state_level(String grd_state_level) {
		this.grd_state_level = grd_state_level;
	}
	public String getCurrent_state() {
		return current_state;
	}
	public void setCurrent_state(String current_state) {
		this.current_state = current_state;
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
	public int getCapstone() {
		return capstone;
	}
	public void setCapstone(int capstone) {
		this.capstone = capstone;
	}
	public String getCapstone_string() {
		return capstone_string;
	}
	public void setCapstone_string(String capstone_string) {
		this.capstone_string = capstone_string;
	}
	
	public String getGraduation_date() {
		return graduation_date;
	}
	public void setGraduation_date(String graduation_date) {
		this.graduation_date = graduation_date;
	}
	public String getEtc_type() {
		return etc_type;
	}
	public void setEtc_type(String etc_type) {
		this.etc_type = etc_type;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	

}
