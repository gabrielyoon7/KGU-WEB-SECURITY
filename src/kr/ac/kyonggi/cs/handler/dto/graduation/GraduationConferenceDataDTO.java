package kr.ac.kyonggi.cs.handler.dto.graduation;

import java.util.Date;

public class GraduationConferenceDataDTO {
	
	private int per_id;
	private String conference_name;
	private String requirement;
	private String thesis_title;
	private String organization;
	private Date open_date;
	private String thesis_filename;
	private String proof_filename;
	private String file_path;
	public int getPer_id() {
		return per_id;
	}
	public void setPer_id(int per_id) {
		this.per_id = per_id;
	}
	public String getConference_name() {
		return conference_name;
	}
	public void setConference_name(String conference_name) {
		this.conference_name = conference_name;
	}
	public String getRequirement() {
		return requirement;
	}
	public void setRequirement(String requirement) {
		this.requirement = requirement;
	}
	public String getThesis_title() {
		return thesis_title;
	}
	public void setThesis_title(String thesis_title) {
		this.thesis_title = thesis_title;
	}
	public String getOrganization() {
		return organization;
	}
	public void setOrganization(String organization) {
		this.organization = organization;
	}
	public Date getOpen_date() {
		return open_date;
	}
	public void setOpen_date(Date open_date) {
		this.open_date = open_date;
	}
	public String getThesis_filename() {
		return thesis_filename;
	}
	public void setThesis_filename(String thesis_filename) {
		this.thesis_filename = thesis_filename;
	}
	public String getProof_filename() {
		return proof_filename;
	}
	public void setProof_filename(String proof_filename) {
		this.proof_filename = proof_filename;
	}
	public String getFile_path() {
		return file_path;
	}
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	

}
