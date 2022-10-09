package kr.ac.kyonggi.cs.v2.handler.dto.locker;

public class LockerAppliedUserDTO {
    private String locker_num;
    private int per_id;
    private String name;
    private String state;
    private String deposit;

    public void setMajor(String major) {
        this.major = major;
    }

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

    private String major;

    public String getMajor() {
        return major;
    }

    private String phoneNum;
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
