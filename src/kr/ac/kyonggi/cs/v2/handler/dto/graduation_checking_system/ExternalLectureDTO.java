package kr.ac.kyonggi.cs.v2.handler.dto.graduation_checking_system;

public class ExternalLectureDTO {
    public String per_id;
    public String year;
    public String semester;
    public String name;
    public String big_type;
    public String credit;

    public String getId() {
        return per_id;
    }

    public void setId(String id) {
        this.per_id = id;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getSemester() {
        return semester;
    }

    public void setSemester(String semester) {
        this.semester = semester;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBig_type() {
        return big_type;
    }

    public void setBig_type(String big_type) {
        this.big_type = big_type;
    }

    public String getSmall_type() {
        return credit;
    }

    public void setSmall_type(String small_type) {
        this.credit = small_type;
    }
}
