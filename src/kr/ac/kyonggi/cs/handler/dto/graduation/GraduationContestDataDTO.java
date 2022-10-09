package kr.ac.kyonggi.cs.handler.dto.graduation;

import java.util.Date;

public class GraduationContestDataDTO {
	
	private int per_id;
	private String contest_name;
	private String team_type;
	private String contest_content;
	private String organization;
	private Date award_date;
	private Date open_date;
	private String award_filename;
	private String file_path;
	private String add_filename;
	
	public int getPer_id() {
		return per_id;
	}
	public void setPer_id(int per_id) {
		this.per_id = per_id;
	}
	public String getContest_name() {
		return contest_name;
	}
	public void setContest_name(String contest_name) {
		this.contest_name = contest_name;
	}
	public String getTeam_type() {
		return team_type;
	}
	public void setTeam_type(String team_type) {
		this.team_type = team_type;
	}
	public String getContest_content() {
		return contest_content;
	}
	public void setContest_content(String contest_content) {
		this.contest_content = contest_content;
	}
	public String getOrganization() {
		return organization;
	}
	public void setOrganization(String organization) {
		this.organization = organization;
	}
	public Date getAward_date() {
		return award_date;
	}
	public void setAward_date(Date award_date) {
		this.award_date = award_date;
	}
	public Date getOpen_date() {
		return open_date;
	}
	public void setOpen_date(Date open_date) {
		this.open_date = open_date;
	}
	public String getAward_filename() {
		return award_filename;
	}
	public void setAward_filename(String award_filename) {
		this.award_filename = award_filename;
	}
	public String getFile_path() {
		return file_path;
	}
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	public String getAdd_filename() {
		return add_filename;
	}
	public void setAdd_filename(String add_filename) {
		this.add_filename = add_filename;
	}
	
	
}
