package kr.ac.kyonggi.cs.handler.dto.track;

import java.util.Date;

public class TrackUserDto {
    private String id;
    private String per_id;
    private String name;
    private int track_ex;
    private int adm_year;
    private int comp_sem;
    private int last_modi_year;
    private Date log_date;
    private String logDateString;

    public String getLogDateString() {
        return logDateString;
    }

    public void setLogDateString(String logDateString) {
        this.logDateString = logDateString;
    }

    @Override
    public String toString() {
        return "TrackUserDto{" +
                "id='" + id + '\'' +
                ", track_ex=" + track_ex +
                ", adm_year=" + adm_year +
                ", comp_sem=" + comp_sem +
                ", last_modi_year=" + last_modi_year +
                ", log_date=" + log_date +
                '}';
    }

    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }

    public String getPerId() {
        return per_id;
    }
    public void setPerId(String id) {
        this.per_id = per_id;
    }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public int getTrack_ex() {
        return track_ex;
    }
    public void setTrack_ex(int track_ex) {
        this.track_ex = track_ex;
    }

    public int getAdm_year() { return adm_year; }
    public void setAdm_year(int adm_year) { this.adm_year = adm_year; }

    public int getComp_sem() { return comp_sem; }
    public void setComp_sem(int comp_sem) { this.comp_sem = comp_sem; }

    public int getLast_modi_year() { return last_modi_year; }
    public void setLast_modi_year(int last_modi_year) { this.last_modi_year = last_modi_year; }

    public Date getLog_date() {
        return log_date;
    }
    public void setLog_date(Date log_date) {
        this.log_date = log_date;
    }
}
