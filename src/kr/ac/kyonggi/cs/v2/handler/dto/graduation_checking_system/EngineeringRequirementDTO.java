package kr.ac.kyonggi.cs.v2.handler.dto.graduation_checking_system;

public class EngineeringRequirementDTO {
    public String id;
    public String year;
    public String elective_credit;
    public String bsm_credit;
    public String design_credit;
    public String major_credit;
//    public String elective_lectures;
    public String lecture_order;
    public String major;

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

    public String getBsm_credit() {
        return bsm_credit;
    }

    public void setBsm_credit(String bsm_credit) {
        this.bsm_credit = bsm_credit;
    }

    public String getDesign_credit() {
        return design_credit;
    }

    public void setDesign_credit(String design_credit) {
        this.design_credit = design_credit;
    }

    public String getMajor_credit() {
        return major_credit;
    }

    public void setMajor_credit(String major_credit) {
        this.major_credit = major_credit;
    }

//    public String getElective_lectures() {
//        return elective_lectures;
//    }
//
//    public void setElective_lectures(String elective_lectures) {
//        this.elective_lectures = elective_lectures;
//    }

    public String getLecture_order() {
        return lecture_order;
    }

    public void setLecture_order(String lecture_order) {
        this.lecture_order = lecture_order;
    }

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }
}
