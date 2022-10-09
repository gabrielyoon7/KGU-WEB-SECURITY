package kr.ac.kyonggi.cs.v2.handler.dto.graduation_checking_system;

public class ExternalLectureHistoryDTO {
    String per_id, year, semester, history;

    public String getPer_id() {
        return per_id;
    }

    public void setPer_id(String per_id) {
        this.per_id = per_id;
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

    public String getHistory() {
        return history;
    }

    public void setHistory(String history) {
        this.history = history;
    }
}
