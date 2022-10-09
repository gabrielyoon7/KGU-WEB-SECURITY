package kr.ac.kyonggi.cs.v2.handler.dto.graduation_checking_system;

public class StudentDTO {
    public String per_id;
    public String name;
    public String phone;
    public String grade;
    public String enter_year;
    public String major;

    public String getEnter_year() {
        return enter_year;
    }

    public void setEnter_year(String enter_year) {
        this.enter_year = enter_year;
    }

    public String getPer_id() {
        return per_id;
    }

    public void setPer_id(String per_id) {
        this.per_id = per_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }
}
