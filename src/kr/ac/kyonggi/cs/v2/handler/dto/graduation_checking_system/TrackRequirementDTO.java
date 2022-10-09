package kr.ac.kyonggi.cs.v2.handler.dto.graduation_checking_system;

public class TrackRequirementDTO {
    public int oid;
    public String year;
    public String major;
    public String code;
    public String name;
    public String chart_id;
    public String credit;

    public String getChart_id() {
        return chart_id;
    }

    public void setChart_id(String chart_id) {
        this.chart_id = chart_id;
    }

    public int getOid() {
        return oid;
    }

    public void setOid(int oid) {
        this.oid = oid;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCredit() {
        return credit;
    }

    public void setCredit(String credit) {
        this.credit = credit;
    }
}
