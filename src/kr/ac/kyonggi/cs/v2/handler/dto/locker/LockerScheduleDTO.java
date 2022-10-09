package kr.ac.kyonggi.cs.v2.handler.dto.locker;

import java.util.Date;

public class LockerScheduleDTO {

    private int schedule_id;
    private int schedule_name_int;
    private String schedule_name;
    private Date starting_date;
    private Date end_date;
    private String schedule_contents;
    private String starting_date_str;
    private String end_date_str;
    private String grd_state;

    public String getGrd_state() {return grd_state;}
    public void setGrd_state(String grd_state) {
        this.grd_state = grd_state;
    }
    public String getStarting_date_str() {
        return starting_date_str;
    }
    public void setStarting_date_str(String starting_date_str) {
        this.starting_date_str = starting_date_str;
    }
    public String getEnd_date_str() {
        return end_date_str;
    }
    public void setEnd_date_str(String end_date_str) {
        this.end_date_str = end_date_str;
    }
    public int getSchedule_id() {
        return schedule_id;
    }
    public void setSchedule_id(int schedule_id) {
        this.schedule_id = schedule_id;
    }



    public int getSchedule_name_int() {
        return schedule_name_int;
    }
    public void setSchedule_name_int(int schedule_name_int) {
        this.schedule_name_int = schedule_name_int;
    }
    public String getSchedule_name() {
        return schedule_name;
    }
    public void setSchedule_name(String schedule_name) {
        this.schedule_name = schedule_name;
    }
    public Date getStarting_date() {
        return starting_date;
    }
    public void setStarting_date(Date starting_date) {
        this.starting_date = starting_date;
    }

    public Date getEnd_date() {
        return end_date;
    }
    public void setEnd_date(Date end_date) {
        this.end_date = end_date;
    }
    public String getSchedule_contents() {
        return schedule_contents;
    }
    public void setSchedule_contents(String schedule_contents) {
        this.schedule_contents = schedule_contents;
    }
}
