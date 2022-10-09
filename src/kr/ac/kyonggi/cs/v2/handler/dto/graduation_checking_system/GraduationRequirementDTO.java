package kr.ac.kyonggi.cs.v2.handler.dto.graduation_checking_system;

public class GraduationRequirementDTO {
    public String id;
    public String year;
    public String all_credit;
    public String elective_credit;
    public String major_credit;
    public String jin_seong_ae_credit;
    public String msc_credit;
    public String major_lecture;
    public String major;
    public String major_essential;
    public String major_selective;

    public String getMajor_essential() {
        return major_essential;
    }

    public void setMajor_essential(String major_essential) {
        this.major_essential = major_essential;
    }

    public String getMajor_selective() {
        return major_selective;
    }

    public void setMajor_selective(String major_selective) {
        this.major_selective = major_selective;
    }

    public String getAll_credit() {
        return all_credit;
    }

    public void setAll_credit(String all_credit) {
        this.all_credit = all_credit;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getElective_credit() {
        return elective_credit;
    }

    public void setElective_credit(String elective_credit) {
        this.elective_credit = elective_credit;
    }

    public String getMajor_credit() {
        return major_credit;
    }

    public void setMajor_credit(String major_credit) {
        this.major_credit = major_credit;
    }

    public String getJin_seong_ae_credit() {
        return jin_seong_ae_credit;
    }

    public void setJin_seong_ae_credit(String jin_seong_ae_credit) {
        this.jin_seong_ae_credit = jin_seong_ae_credit;
    }

    public String getMsc_credit() {
        return msc_credit;
    }

    public void setMsc_credit(String msc_credit) {
        this.msc_credit = msc_credit;
    }

    public String getMajor_lecture() {
        return major_lecture;
    }

    public void setMajor_lecture(String major_lecture) {
        this.major_lecture = major_lecture;
    }

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }
}
