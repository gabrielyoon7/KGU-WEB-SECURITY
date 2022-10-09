package kr.ac.kyonggi.cs.handler.dto.grdBack;

public class TargetStudentDto {

    private String name;
    private int per_id;
    private String prof_name;
    private String major;
    private String graduation_date;
    private String graduation_type;
    private int fin;
    private int certificate_submit;
    private int conference_submit;
    private int contest_submit;
    private String title;
    private String classification;
    private String keyword;
    private String proposal_content;
    private String interim_filename;
    private String final_requirement;
    private int final_page;
    private String final_filename;
    //자격증
    private String requirement;
    private String cer_id;
    private String organization;
    private String acq_date;
    private String cer_filename;
    //학술
    private String conference_name;
    private String thesis_title;
    private String open_date;
    private String thesis_filename;
    private String proof_filename;
    //공모전
    private String contest_name;
    private String team_type;
    private String contest_content;
    private String award_date;
    private String award_filename;
    private String add_filename;

    private int certi_level_int;
    private int contest_level_int;
    private int confe_level_int;

    private String final_action_date; //논문 통과날짜
    private String certi_date;
    private String confe_date;
    private String contest_date;

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }

    public String getFinal_action_date() {
        return final_action_date;
    }

    public void setFinal_action_date(String final_action_date) {
        this.final_action_date = final_action_date;
    }

    public String getCerti_date() {
        return certi_date;
    }

    public void setCerti_date(String certi_date) {
        this.certi_date = certi_date;
    }

    public String getConfe_date() {
        return confe_date;
    }

    public void setConfe_date(String confe_date) {
        this.confe_date = confe_date;
    }

    public String getContest_date() {
        return contest_date;
    }

    public void setContest_date(String contest_date) {
        this.contest_date = contest_date;
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

    public String getAcq_date() {
        return acq_date;
    }

    public void setAcq_date(String acq_date) {
        this.acq_date = acq_date;
    }

    public String getCer_filename() {
        return cer_filename;
    }

    public void setCer_filename(String cer_filename) {
        this.cer_filename = cer_filename;
    }

    public String getConference_name() {
        return conference_name;
    }

    public void setConference_name(String conference_name) {
        this.conference_name = conference_name;
    }

    public String getThesis_title() {
        return thesis_title;
    }

    public void setThesis_title(String thesis_title) {
        this.thesis_title = thesis_title;
    }

    public String getOpen_date() {
        return open_date;
    }

    public void setOpen_date(String open_date) {
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

    public String getAward_date() {
        return award_date;
    }

    public void setAward_date(String award_date) {
        this.award_date = award_date;
    }

    public String getAward_filename() {
        return award_filename;
    }

    public void setAward_filename(String award_filename) {
        this.award_filename = award_filename;
    }

    public String getAdd_filename() {
        return add_filename;
    }

    public void setAdd_filename(String add_filename) {
        this.add_filename = add_filename;
    }

    public int getFin() {
        return fin;
    }

    public void setFin(int fin) {
        this.fin = fin;
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


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getPer_id() {
        return per_id;
    }

    public void setPer_id(int per_id) {
        this.per_id = per_id;
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

    public String getGraduation_type() {
        return graduation_type;
    }

    public void setGraduation_type(String graduation_type) {
        this.graduation_type = graduation_type;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getClassification() {
        return classification;
    }

    public void setClassification(String classification) {
        this.classification = classification;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public String getProposal_content() {
        return proposal_content;
    }

    public void setProposal_content(String proposal_content) {
        this.proposal_content = proposal_content;
    }

    public String getInterim_filename() {
        return interim_filename;
    }

    public void setInterim_filename(String interim_filename) {
        this.interim_filename = interim_filename;
    }

    public String getFinal_requirement() {
        return final_requirement;
    }

    public void setFinal_requirement(String final_requirement) {
        this.final_requirement = final_requirement;
    }

    public int getFinal_page() {
        return final_page;
    }

    public void setFinal_page(int final_page) {
        this.final_page = final_page;
    }

    public String getFinal_filename() {
        return final_filename;
    }

    public void setFinal_filename(String final_filename) {
        this.final_filename = final_filename;
    }

    @Override
    public String toString() {
        return "TargetStudentDto{" +
                "name='" + name + '\'' +
                ", per_id=" + per_id +
                ", prof_name='" + prof_name + '\'' +
                ", graduation_date='" + graduation_date + '\'' +
                ", graduation_type='" + graduation_type + '\'' +
                ", fin=" + fin +
                ", certificate_submit=" + certificate_submit +
                ", conference_submit=" + conference_submit +
                ", contest_submit=" + contest_submit +
                ", title='" + title + '\'' +
                ", classification='" + classification + '\'' +
                ", keyword='" + keyword + '\'' +
                ", proposal_content='" + proposal_content + '\'' +
                ", interim_filename='" + interim_filename + '\'' +
                ", final_requirement='" + final_requirement + '\'' +
                ", final_page=" + final_page +
                ", final_filename='" + final_filename + '\'' +
                ", requirement='" + requirement + '\'' +
                ", cer_id='" + cer_id + '\'' +
                ", organization='" + organization + '\'' +
                ", acq_date='" + acq_date + '\'' +
                ", cer_filename='" + cer_filename + '\'' +
                ", conference_name='" + conference_name + '\'' +
                ", thesis_title='" + thesis_title + '\'' +
                ", open_date='" + open_date + '\'' +
                ", thesis_filename='" + thesis_filename + '\'' +
                ", proof_filename='" + proof_filename + '\'' +
                ", contest_name='" + contest_name + '\'' +
                ", team_type='" + team_type + '\'' +
                ", contest_content='" + contest_content + '\'' +
                ", award_date='" + award_date + '\'' +
                ", award_filename='" + award_filename + '\'' +
                ", add_filename='" + add_filename + '\'' +
                ", certi_level_int=" + certi_level_int +
                ", contest_level_int=" + contest_level_int +
                ", confe_level_int=" + confe_level_int +
                ", final_action_date='" + final_action_date + '\'' +
                ", certi_date='" + certi_date + '\'' +
                ", confe_date='" + confe_date + '\'' +
                ", contest_date='" + contest_date + '\'' +
                '}';
    }
}
