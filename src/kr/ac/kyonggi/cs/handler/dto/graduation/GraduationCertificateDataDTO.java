package kr.ac.kyonggi.cs.handler.dto.graduation;

import java.util.Date;

public class GraduationCertificateDataDTO {
	
	private int per_id;
	private String requirement;
	private String cer_id;
	private String organization;
	private Date acq_date;
	private String cer_filename;
	private String file_path;
	public int getPer_id() {
		return per_id;
	}
	public void setPer_id(int per_id) {
		this.per_id = per_id;
	}
	public String getRequirement() {
		return requirement;
	}
	public void setRequirement(String requirement) {
		this.requirement = requirement;
	}
	public String getCer_id() {
		return cer_id;
	}
	public void setCer_id(String cer_id) {
		this.cer_id = cer_id;
	}
	public String getOrganization() {
		return organization;
	}
	public void setOrganization(String organization) {
		this.organization = organization;
	}
	public String getCer_filename() {
		return cer_filename;
	}
	public void setCer_filename(String cer_filename) {
		this.cer_filename = cer_filename;
	}
	public String getFile_path() {
		return file_path;
	}
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	public Date getAcq_date() {
		return acq_date;
	}
	public void setAcq_date(Date acq_date) {
		this.acq_date = acq_date;
	}
	
}
