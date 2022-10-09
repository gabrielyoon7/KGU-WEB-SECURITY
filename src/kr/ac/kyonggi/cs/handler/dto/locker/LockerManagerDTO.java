package kr.ac.kyonggi.cs.handler.dto.locker;

public class LockerManagerDTO {

    public int getLocker_id() {
        return locker_id;
    }

    public void setLocker_id(int locker_id) {
        this.locker_id = locker_id;
    }

    private int locker_id;
    private int locker_num;
    private String locker_type;
    private String available;
    private int locker_location;

    public String getLocker_type() {
        return locker_type;
    }

    public void setLocker_type(String locker_type) {
        this.locker_type = locker_type;
    }

    public String getAvailable() {
        return available;
    }

    public int getLocker_location() {
        return locker_location;
    }

    public int getLocker_row() {
        return locker_row;
    }

    public void setAvailable(String available) {
        this.available = available;
    }

    public void setLocker_location(int locker_location) {
        this.locker_location = locker_location;
    }

    public void setLocker_row(int locker_row) {
        this.locker_row = locker_row;
    }
    private int locker_row;
    public int getLocker_num() {return locker_num; }
    public void setLocker_num(int locker_num) {
        this.locker_num = locker_num;
    }

}
