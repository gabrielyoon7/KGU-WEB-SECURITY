package kr.ac.kyonggi.cs.handler.dto.locker;

public class LockerAssignedUserDTO {
    private String locker_num;
    private int per_id;
    private String name;
    private String state;

    public String getImg_inside() {
        return img_inside;
    }

    public void setImg_inside(String img_inside) {
        this.img_inside = img_inside;
    }

    public String getImg_front() {
        return img_front;
    }

    public void setImg_front(String img_front) {
        this.img_front = img_front;
    }

    private String deposit;
    private String major;
    private String img_inside;
    private String img_front;

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }

    private String phoneNum;

    public String getPhoneNum() {
        return phoneNum;
    }

    public void setPhoneNum(String phoneNum) {
        this.phoneNum = phoneNum;
    }

    public String getBank() {
        return bank;
    }

    public void setBank(String bank) {
        this.bank = bank;
    }

    public String getAccountNum() {
        return accountNum;
    }

    public void setAccountNum(String accountNum) {
        this.accountNum = accountNum;
    }

    private String bank;
    private String accountNum;

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
    public String getState() {
        return state;
    }
    public void setState(String state) {
        this.state = state;
    }
    public String getDeposit() {
        return deposit;
    }
    public void setDeposit(String deposit) {
        this.deposit = deposit;
    }

}
