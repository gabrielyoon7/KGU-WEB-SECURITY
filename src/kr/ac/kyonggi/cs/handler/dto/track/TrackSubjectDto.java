package kr.ac.kyonggi.cs.handler.dto.track;

public class TrackSubjectDto {

    private int id;
    private String sub_code;
    private int sub_grade;
    private String sub_class_ex;
    private int sub_semester;
    private String sub_title;
    private int credit;
    private int found_year;
    private int repeal_year;
    private String track_code;

    @Override
    public String toString() {
        return "TrackSubjectDto{" +
                "id='" + id + '\'' +
                ", sub_code=" + sub_code +
                ", sub_grade=" + sub_grade +
                ", sub_class_ex=" + sub_class_ex +
                ", sub_semester=" + sub_semester +
                ", sub_title=" + sub_title +
                ", credit=" + credit +
                ", found_year=" + found_year +
                ", repeal_year=" + repeal_year +
                ", track_code=" + track_code +
                '}';
    }

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getSub_code() { return sub_code; }
    public void setSub_code(String sub_code) { this.sub_code = sub_code; }

    public int getSub_grade() { return sub_grade; }
    public void setSub_grade(int sub_grade) { this.sub_grade = sub_grade; }

    public String getSub_class_ex() { return sub_class_ex; }
    public void setSub_class_ex(String sub_class_ex) { this.sub_class_ex = sub_class_ex; }

    public int getSub_semester() { return sub_semester; }
    public void setSub_semester(int sub_semester) { this.sub_semester = sub_semester; }

    public String getSub_title() { return sub_title; }
    public void setSub_title(String sub_title) { this.sub_title = sub_title; }

    public int getCredit() { return credit; }
    public void setCredit(int credit) { this.credit = credit; }

    public int getFound_year() { return found_year; }
    public void setFound_year(int found_year) { this.found_year = found_year; }

    public int getRepeal_year() { return repeal_year; }
    public void setRepeal_year(int repeal_year) { this.repeal_year = repeal_year; }

    public String getTrack_code() { return track_code; }
    public void setTrack_code(String track_code) { this.track_code = track_code; }
}
