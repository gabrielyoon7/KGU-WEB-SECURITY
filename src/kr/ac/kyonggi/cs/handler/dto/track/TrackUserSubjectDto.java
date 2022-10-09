package kr.ac.kyonggi.cs.handler.dto.track;

public class TrackUserSubjectDto {
    private String id;
    private String sub_id;
    private int year;
    private int sem;
    private String grade_sem;


    @Override
    public String toString() {
        return "TrackUserDto{" +
                "id='" + id + '\'' +
                ", sub_id=" + sub_id +
                ", grade_sem=" + grade_sem +
                '}';
    }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getSub_id() { return sub_id; }
    public void setSub_id(String sub_id) { this.sub_id = sub_id; }

    public int getYear() { return year; }
    public void setYear(int year) { this.year = year; }

    public int getSem() { return sem; }
    public void setSem(int sem) { this.sem = sem; }

    public String getGrade_sem() { return grade_sem; }
    public void setGrade_sem(String grade_sem) { this.grade_sem = grade_sem; }
}
