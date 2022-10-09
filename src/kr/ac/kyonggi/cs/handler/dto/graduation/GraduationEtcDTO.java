package kr.ac.kyonggi.cs.handler.dto.graduation;

import java.util.Date;

public class GraduationEtcDTO {
	//schedule_name_int,starting_date,end_date,certificate_submit,contest_submit,conference_submit,certi_date
	//,contest_date,confe_date,certi_level_int,contest_level_int,confe_level_int 
	private int per_id;
	private int capstone;
	public int schedule_num;
	public String schedule_name;
	public int schedule_name_int;
	public int level_num;
	public Date starting_date;
	public Date end_date;
	public Date certi_date;
	public Date contest_date;
	public Date confe_date;
	public int certi_level_int;
	public int contest_level_int;
	public int confe_level_int;
	public String certi_level;
	public String contest_level;
	public String confe_level;
	private String starting_date_str;
	private String end_date_str;
	public int certificate_submit;
	public int conference_submit;
	public int contest_submit;
	public String note;
	public String certificate_submit_link="form.do";
	public String conference_submit_link="form.do";
	public String contest_submit_link="form.do";
	public String certificate_delete_link="form.do";
	public String conference_delete_link="form.do";
	public String contest_delete_link="form.do";
	public String certificate_modify_link="form.do";
	public String conference_modify_link="form.do";
	public String contest_modify_link="form.do";
	public String certificate_read_link="form.do";
	public String conference_read_link="form.do";
	public String contest_read_link="form.do";
	private int state_enum;
	public int getState_enum() {
		return state_enum;
	}
	public void setState_enum(int state_enum) {
		this.state_enum = state_enum;
	}
	public int getPer_id() {
		return per_id;
	}
	public void setPer_id(int per_id) {
		this.per_id = per_id;
	}
	public int getCapstone() {
		return capstone;
	}
	public void setCapstone(int capstone) {
		this.capstone = capstone;
	}
	public String getCerti_level() {
		return certi_level;
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
	public void setCerti_level(String certi_level) {
		this.certi_level = certi_level;
	}
	public String getContest_level() {
		return contest_level;
	}
	public void setContest_level(String contest_level) {
		this.contest_level = contest_level;
	}
	public String getConfe_level() {
		return confe_level;
	}
	public void setConfe_level(String confe_level) {
		this.confe_level = confe_level;
	}
	public int getSchedule_num() {
		return schedule_num;
	}
	public void setSchedule_num(int schedule_num) {
		this.schedule_num = schedule_num;
	}
	public String getSchedule_name() {
		return schedule_name;
	}
	public void setSchedule_name(String schedule_name) {
		this.schedule_name = schedule_name;
	}
	public int getSchedule_name_int() {
		return schedule_name_int;
	}
	public void setSchedule_name_int(int schedule_name_int) {
		this.schedule_name_int = schedule_name_int;
	}
	public int getLevel_num() {
		return level_num;
	}
	public void setLevel_num(int level_num) {
		this.level_num = level_num;
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
	public Date getCerti_date() {
		return certi_date;
	}
	public void setCerti_date(Date certi_date) {
		this.certi_date = certi_date;
	}
	public Date getContest_date() {
		return contest_date;
	}
	public void setContest_date(Date contest_date) {
		this.contest_date = contest_date;
	}
	public Date getConfe_date() {
		return confe_date;
	}
	public void setConfe_date(Date confe_date) {
		this.confe_date = confe_date;
	}
	public int getCerti_level_int() {
		return certi_level_int;
	}
	public void setCerti_level_int(int certi_level_int) {
		this.certi_level_int = certi_level_int;
	}
	public int getContest_level_int() {
		return contest_level_int;
	}
	public void setContest_level_int(int contest_level_int) {
		this.contest_level_int = contest_level_int;
	}
	public int getConfe_level_int() {
		return confe_level_int;
	}
	public void setConfe_level_int(int confe_level_int) {
		this.confe_level_int = confe_level_int;
	}
	
	public int getCertificate_submit() {
		return certificate_submit;
	}
	public void setCertificate_submit(int certificate_submit) {
		this.certificate_submit = certificate_submit;
	}
	public int getConference_submit() {
		return conference_submit;
	}
	public void setConference_submit(int conference_submit) {
		this.conference_submit = conference_submit;
	}
	public int getContest_submit() {
		return contest_submit;
	}
	public void setContest_submit(int contest_submit) {
		this.contest_submit = contest_submit;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getCertificate_submit_link() {
		return certificate_submit_link;
	}
	public void setCertificate_submit_link(String certificate_submit_link) {
		this.certificate_submit_link = certificate_submit_link;
	}
	public String getConference_submit_link() {
		return conference_submit_link;
	}
	public void setConference_submit_link(String conference_submit_link) {
		this.conference_submit_link = conference_submit_link;
	}
	public String getContest_submit_link() {
		return contest_submit_link;
	}
	public void setContest_submit_link(String contest_submit_link) {
		this.contest_submit_link = contest_submit_link;
	}
	public String getCertificate_delete_link() {
		return certificate_delete_link;
	}
	public void setCertificate_delete_link(String certificate_delete_link) {
		this.certificate_delete_link = certificate_delete_link;
	}
	public String getConference_delete_link() {
		return conference_delete_link;
	}
	public void setConference_delete_link(String conference_delete_link) {
		this.conference_delete_link = conference_delete_link;
	}
	public String getContest_delete_link() {
		return contest_delete_link;
	}
	public void setContest_delete_link(String contest_delete_link) {
		this.contest_delete_link = contest_delete_link;
	}
	public String getCertificate_modify_link() {
		return certificate_modify_link;
	}
	public void setCertificate_modify_link(String certificate_modify_link) {
		this.certificate_modify_link = certificate_modify_link;
	}
	public String getConference_modify_link() {
		return conference_modify_link;
	}
	public void setConference_modify_link(String conference_modify_link) {
		this.conference_modify_link = conference_modify_link;
	}
	public String getContest_modify_link() {
		return contest_modify_link;
	}
	public void setContest_modify_link(String contest_modify_link) {
		this.contest_modify_link = contest_modify_link;
	}
	public String getCertificate_read_link() {
		return certificate_read_link;
	}
	public void setCertificate_read_link(String certificate_read_link) {
		this.certificate_read_link = certificate_read_link;
	}
	public String getConference_read_link() {
		return conference_read_link;
	}
	public void setConference_read_link(String conference_read_link) {
		this.conference_read_link = conference_read_link;
	}
	public String getContest_read_link() {
		return contest_read_link;
	}
	public void setContest_read_link(String contest_read_link) {
		this.contest_read_link = contest_read_link;
	}
	
	
	
	
}
