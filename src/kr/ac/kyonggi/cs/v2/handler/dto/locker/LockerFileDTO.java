package kr.ac.kyonggi.cs.v2.handler.dto.locker;

public class LockerFileDTO {
    private String locker_num;
    private int per_id;
    private String name;
    private String filename;
    private String file_path;

    public String getLocker_num() {return locker_num; }
    public void setLocker_num(String locker_num) {
        this.locker_num = locker_num;
    }
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
    public String getFilename() {
        return filename;
    }
    public void setFilename(String state) {
        this.filename = filename;
    }
    public String getFile_path() {
        return file_path;
    }
    public void setFile_path(String deposit) {
        this.file_path = file_path;
    }

}
