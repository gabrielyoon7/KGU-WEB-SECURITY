package kr.ac.kyonggi.cs.handler.vo.user;

import java.util.Date;

public class UserBean {
	public String id,password,name,birth,email,phone,type,hope_type,myhomeid;
	public Date last_login, reg_date, log_date;
	public String major, per_id, grade, state, gender;
	public int track_ex;

	@Override
	public String toString() {
		return "UserBean{" +
				"id='" + id + '\'' +
				", password='" + password + '\'' +
				", name='" + name + '\'' +
				", birth='" + birth + '\'' +
				", email='" + email + '\'' +
				", phone='" + phone + '\'' +
				", type='" + type + '\'' +
				", hope_type='" + hope_type + '\'' +
				", myhomeid='" + myhomeid + '\'' +
				", last_login=" + last_login +
				", reg_date=" + reg_date +
				", log_date=" + log_date +
				", major='" + major + '\'' +
				", per_id='" + per_id + '\'' +
				", grade='" + grade + '\'' +
				", state='" + state + '\'' +
				", gender='" + gender + '\'' +
				", track_ex=" + track_ex +
				'}';
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getHope_type() {
		return hope_type;
	}
	public void setHope_type(String hope_type) {
		this.hope_type = hope_type;
	}
	public String getMyhomeid() {
		return myhomeid;
	}
	public void setMyhomeid(String myhomeid) {
		this.myhomeid = myhomeid;
	}
	public Date getLast_login() {
		return last_login;
	}
	public void setLast_login(Date last_login) {
		this.last_login = last_login;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public String getPer_id() {
		return per_id;
	}
	public void setPer_id(String per_id) {
		this.per_id = per_id;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}

	public Date getLog_date() { return log_date; }
	public void setLog_date(Date log_date) { this.log_date = log_date; }
	public int getTrack_ex() { return track_ex; }
	public void setTrack_ex(int track_ex) { this.track_ex = track_ex; }
}

