package kr.ac.kyonggi.cs.handler.dto.grdBack;

import java.util.Date;

public class BackStudentDTO {
    private int per_id;
    private String name;
    private String prof_name;
    private String graduation_date;
    private String major;
    private String graduation_type;
    private Date final_action_date;
    private String grdType;

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

    public String getGraduation_type() {
        return graduation_type;
    }

    public void setGraduation_type(String graduation_type) {
        this.graduation_type = graduation_type;
    }

    public Date getFinal_action_date() {
        return final_action_date;
    }

    public void setFinal_action_date(Date final_action_date) {
        this.final_action_date = final_action_date;
    }

    public String getGrdType() {
        return grdType;
    }

    public void setGrdType(String grdType) {
        this.grdType = grdType;
    }
}
