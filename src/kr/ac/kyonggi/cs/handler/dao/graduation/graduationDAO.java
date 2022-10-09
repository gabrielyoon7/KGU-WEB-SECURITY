package kr.ac.kyonggi.cs.handler.dao.graduation;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.ColumnListHandler;
import org.apache.commons.dbutils.handlers.MapListHandler;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;

import kr.ac.kyonggi.cs.common.sql.Config;
import kr.ac.kyonggi.cs.handler.vo.GrdlogBean;
import kr.ac.kyonggi.cs.handler.vo.NoticeFileBean;
import kr.ac.kyonggi.cs.handler.excel.ExcelWriter;
import kr.ac.kyonggi.cs.handler.vo.GrdScheduleBean;
import kr.ac.kyonggi.cs.handler.vo.GrdUserBean;
import kr.ac.kyonggi.cs.handler.vo.Grd_UserlogBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;

public class graduationDAO {
	public static graduationDAO it;

	public static graduationDAO getInstance() {
		if(it == null)
			it = new graduationDAO();
		return it;
	}


	public ArrayList<GrdUserBean> getAllGrdUsers() throws ParseException{   //모든 졸업대상자 리스트 받기
		List<Map<String,Object>> listOfMaps=null;
		Connection conn = Config.getInstance().sqlLogin();
		ArrayList<GrdUserBean> selectedschedule=null;
		Gson gson = new Gson();
		try {
			QueryRunner queryRunner=new QueryRunner();

			listOfMaps=queryRunner.query(conn, "SELECT * FROM grd_students",new MapListHandler());
			selectedschedule = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GrdUserBean>>() {}.getType());
			if(selectedschedule.size()>0) {
				for(int i=0;i<selectedschedule.size();i++) {
					if((selectedschedule.get(i).grd_state.equals("최종통과")||selectedschedule.get(i).grd_state.equals("기타자격"))==false) {

						compareDate(selectedschedule.get(i).grd_state,selectedschedule.get(i).per_id);//날짜 비교
					}
					compareDateETC("기타자격", selectedschedule.get(i).per_id);
				}
				listOfMaps=queryRunner.query(conn, "SELECT * FROM grd_students",new MapListHandler());
				selectedschedule=gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GrdUserBean>>() {}.getType());}
		}catch(SQLException se) {
			se.printStackTrace();
		}
		return selectedschedule;
	}

	public ArrayList<GrdUserBean> getmyGrdUsers(String prof_name) throws ParseException{   //해당지도교수의 졸업대상자만 리스트 받기
		List<Map<String,Object>> listOfMaps=null;
		Connection conn = Config.getInstance().sqlLogin();
		Gson gson = new Gson();
		ArrayList<GrdUserBean> selectedschedule=null;
		try {
			QueryRunner queryRunner=new QueryRunner();
			listOfMaps=queryRunner.query(conn, "SELECT *FROM grd_students WHERE prof_name=?",new MapListHandler(),prof_name);
			selectedschedule=gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GrdUserBean>>() {}.getType());
			if(selectedschedule.size()>0) {
				for(int i=0;i<selectedschedule.size();i++) {
					if(!(selectedschedule.get(i).grd_state.equals("최종통과")||selectedschedule.get(i).grd_state.equals("기타자격"))) {
						compareDate(selectedschedule.get(i).grd_state,selectedschedule.get(i).per_id);//날짜 비교
					}
					compareDateETC("기타자격", selectedschedule.get(i).per_id);
				}
				listOfMaps=queryRunner.query(conn, "SELECT *FROM grd_students WHERE prof_name=?",new MapListHandler(),prof_name);
				selectedschedule=gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GrdUserBean>>() {}.getType());
			}
		}catch(SQLException se) {
			se.printStackTrace();
		}

		return selectedschedule;
	}

	public GrdUserBean getGrdStudent(String per_id) {
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn,"SELECT * FROM grd_students WHERE per_id = ?;", new MapListHandler(), per_id);
		} catch(SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		ArrayList<GrdUserBean> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GrdUserBean>>() {}.getType());
		if(selected.size()>0) {
			return selected.get(0);
		}
		else
			return null;
	}


	public ArrayList<GrdScheduleBean> getGrdSchedule(){
		List<Map<String,Object>> listOfMaps=null;
		Connection conn = Config.getInstance().sqlLogin();	
		try {
			QueryRunner queryRunner=new QueryRunner();
			listOfMaps=queryRunner.query(conn, "SELECT * FROM grd_schedule",new MapListHandler());
		}catch(SQLException se) {
			se.printStackTrace();
		}
		Gson gson = new Gson();
		ArrayList<GrdScheduleBean> selectedschedule = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GrdScheduleBean>>() {}.getType());
		return selectedschedule;

	}

	public String modifycon(String data) {
		String arr[]=data.split("-/-/-");
		Connection conn = Config.getInstance().sqlLogin();
		List<String> schedule=null;
		try {
			QueryRunner queryRunner= new QueryRunner();
			queryRunner.update(conn,"UPDATE grd_schedule SET schedule_contents=? WHERE schedule_name=?",arr[1],arr[0]);
			schedule = queryRunner.query(conn, "SELECT schedule_contents FROM grd_schedule WHERE schedule_name=?",new ColumnListHandler<String>(),arr[0]);
		}catch(SQLException se) {
			se.printStackTrace();
		}
		return schedule.get(0);
	}

	public String insertgradschedule(String data) throws ParseException {
		String arr[] = data.split("-/-/-");//0=name 1=start 2=close
		Connection conn = Config.getInstance().sqlLogin();
		LocalDate today=LocalDate.now();
		LocalDate start=null;
		LocalDate close=null;
		String state = "미정";//
		try {
			DateTimeFormatter formatter= DateTimeFormatter.ofPattern("yyyy-MM-dd");	
			start=LocalDate.parse(arr[1],formatter);
			close=LocalDate.parse(arr[2],formatter);
			int compare1 = start.compareTo(today);
			int compare2 = close.compareTo(today);
			if(compare1<=0 && compare2>=0)
				state="진행중";
			else if(compare1>0)
				state="대기";
			else 
				state="마감";
		} catch (Exception e) {
			e.printStackTrace();
		}

		try {
			QueryRunner queryRunner= new QueryRunner();
			queryRunner.update(conn,"UPDATE grd_schedule SET grd_state=?, starting_date=?, closing_date=? WHERE schedule_name=?",state,start,close.plusDays(1),arr[0]);
		}catch(SQLException se) {
			se.printStackTrace();
		}
		return state;
	}

	public String insert_grd_students_at_log(int per_id) {//졸업대상자 유저추가시, log에 단계별 INSERT
		Connection conn = Config.getInstance().sqlLogin();
		String arr[]= {"신청접수","제안서","중간보고서","최종보고서","기타자격"};
		String selected = "";
		try {
			QueryRunner queryRunner= new QueryRunner();
			for(int i=0;i<arr.length;i++) {
				queryRunner.update(conn,"INSERT INTO grd_schedule SET per_id=?, schedule_name=?",per_id,arr[i]);
			}
		}catch(SQLException se) {
			se.printStackTrace();
		}
		return selected;
	}

	public String insert_request(String data) {//변경2.13 //신청서를 제출하면 subDB에 정보저장
		String arr[] = data.split("-/-/-");//0:user.per_id 1:name 2:date 3:anwer
		Connection conn = Config.getInstance().sqlLogin();
		String selected = "";
		List<Map<String,Object>> check_students=null;
		LocalDate today=LocalDate.now();
		LocalDateTime today1=LocalDateTime.now();
		String t=null;//미사용코드
		if(arr[2].contains(Integer.toString(today.getYear()+1)+"-02"))
			t=Integer.toString(today.getYear()+1)+"-02";
		else
			t=arr[2];

		try {
			QueryRunner queryRunner= new QueryRunner();
			check_students=queryRunner.query(conn, "SELECT * FROM grd_req_students WHERE per_id=?",new MapListHandler(),arr[0]);
			if(check_students.size()>0){//중복
				queryRunner.update(conn,"UPDATE grd_req_students SET grd_state_level=?,graduation_date=? WHERE per_id=?","제출완료",arr[2],arr[0]);
			}
			else{//중복이아니야
				if(queryRunner.query(conn, "SELECT * FROM grd_students WHERE per_id=?",new MapListHandler(),arr[0]).size()>0) {//정식디비에 중복이있으면=유저보다관리자가먼저추가하면
					queryRunner.update(conn,"UPDATE grd_students SET grd_state_level=?,graduation_date=? WHERE per_id=?","제출완료",arr[2],arr[0]);
				}else {//없으면 승인전까지는 서브디비에 추가
					queryRunner.update(conn,"INSERT INTO grd_req_students SET per_id=?, name=?, graduation_date=?, grd_state_level=?",arr[0],arr[1],arr[2],"제출완료");

				}
			}
			queryRunner.update(conn,"INSERT INTO grd_log SET schedule_name=?, per_id=?, answer_1=?,submit_date=?","신청접수",arr[0],arr[3],today);
			queryRunner.update(conn,"INSERT INTO grd_userlog SET per_id=?,log_date=?,grd_state=?,reason=?",arr[0],today1,"신청접수","신청접수 제출");
		}catch(SQLException se) {
			se.printStackTrace();
		}
		return selected;
	}

	public String insertgrduser(JsonArray grdArray) throws SQLException {//02.20
		List<Map<String,Object>> idmap = null;
		List<Map<String,Object>> userlist =null;
		Gson gson=new Gson();
		Connection conn =Config.getInstance().sqlLogin();
		List<String> notuser=new ArrayList<>();//수정 <List<Map<String,Object>>

		int modify=0;
		int insert=0;
		try {
			QueryRunner queryRunner = new QueryRunner();
			idmap=queryRunner.query(conn,"SELECT * FROM grd_students", new MapListHandler());//per_id 중복확인
			userlist=queryRunner.query(conn,"SELECT * FROM user",new MapListHandler());
			ArrayList<GrdUserBean> selected =gson.fromJson(gson.toJson(idmap), new TypeToken<List<GrdUserBean>>() {}.getType());
			ArrayList<UserBean> userlist2 =gson.fromJson(gson.toJson(userlist), new TypeToken<List<UserBean>>() {}.getType());
			boolean tf=false;
			boolean exist =false;


			for(int i=0;i<grdArray.size();i++) {
				int cap=-1;
				JsonElement user1=grdArray.get(i);
				GrdUserBean user=gson.fromJson(user1, GrdUserBean.class);
				JsonObject user2=user1.getAsJsonObject();
				String per_id=user.per_id;
				String name=user.name;
				for(int j=0;j<userlist2.size();j++) {
					if(userlist2.get(j).per_id.equals(per_id)&&userlist2.get(j).name.equals(name)) {
						exist=true;
						break;
					}
				}
				if(exist==false) {
					notuser.add(name + "[" + per_id + "]");
					continue;
				}
				exist=false;

				String prof_name=user.prof_name;
				String capstone=user.capstone;
				String graduation_date=user.graduation_date;
				String etc="불가";
				if(graduation_date==null) {
					LocalDateTime now = LocalDateTime.now();  
					int year=now.getYear();
					graduation_date=Integer.toString(year+1)+"-02";
				}
				if(capstone!=null) {
					if(capstone.equals("이수")) {
						etc="가능";
						cap=2;
					}
					else if(capstone.equals("미이수"))
						cap=0;
					else if(capstone.equals("이수중")) {
						etc="가능";
						cap=1;
					}
					else if(capstone.equals("해당없음")) {
						etc="가능";
						cap=3;//필요가없네 (오류)
					}
				}else 
					cap=0;
				if(Integer.parseInt(per_id)/100000<=2011) {
					etc="가능";
					cap=3;
				}
				for(int j=0;j<selected.size();j++) {
					String id= selected.get(j).per_id;
					if(id.equals(per_id)) {
						queryRunner.update(conn,"UPDATE grd_students SET name=?,prof_name=?,capstone=?,graduation_date=?,etc=? WHERE per_id=?",name,prof_name,cap,graduation_date,etc,per_id);
						modify++;
						tf=true;
						break;
					}   
				}
				if(tf==true) {
					tf=false;
					cap=-1;
					continue;
				}
				queryRunner.update(conn,"INSERT INTO grd_students(per_id,name,prof_name,capstone,graduation_date,etc) VALUES(?,?,?,?,?,?)",per_id,name,prof_name,cap,graduation_date,etc);
				insert++;

				cap=-1;
			}
		}catch(SQLException se) {
			se.printStackTrace();
		}finally {
			DbUtils.close(conn);
		}
		notuser.add(Integer.toString(modify));
		notuser.add(Integer.toString(insert));
		return gson.toJson(notuser);
	}

	public String req_insertgrduser(String data) {//신청서접수=>본서버에 추가
		String arr[]=data.split("-/-/-");//per_id+"-/-/-"+name+"-/-/-"+date+"-/-/-"+capstone+"-/-/-"+professor      
		int cap=-1;
		String etc="불가";
		//capstone구분
		if(arr[3].equals("해당없음")) {
			etc="가능";
			cap=3;
		}else if(arr[3].equals("이수")) {
			etc="가능";
			cap=2;
		}else if(arr[3].equals("이수중")) {
			etc="가능";
			cap=1;
		}else if(arr[3].equals("미이수"))
			cap=0;
		//date구분
		int year = Calendar.getInstance().get(Calendar.YEAR);

		String date=null;
		if(arr[2].contains(Integer.toString(year)))
			date=year+"-08";
		else 
			date=(year+1)+"-02";
		Connection conn = Config.getInstance().sqlLogin();
		List<Map<String,Object>> listOfMaps=null;
		Date today=new Date();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps=queryRunner.query(conn, "SELECT * FROM grd_students WHERE per_id=?;",new MapListHandler(),arr[0]);//정식DB 중복체크
			if(listOfMaps.size()>0) {//중복있으면 ->update
				queryRunner.update(conn,"UPDATE grd_students SET name=?,prof_name=?,capstone=?,graduation_date=?,grd_state_level=?,etc=? WHERE per_id=?",arr[1],arr[4],cap,date,"확인",etc,arr[0]);
				queryRunner.update(conn,"UPDATE grd_log SET success_date=? WHERE per_id=? and schedule_name=?",today,arr[0],"신청접수");
				queryRunner.update(conn,"INSERT INTO grd_userlog SET per_id=?,log_date=?,grd_state=?,reason=?",arr[0],today,"신청접수","신청접수 승인");
			}
			else {//중복없음 -> subDB에서 real_DB에 추가 + grd_state:신청접수 grd_state_level=확인
				queryRunner.update(conn,"INSERT INTO grd_students(per_id,name,graduation_date,capstone,grd_state_level,prof_name,etc) VALUES(?,?,?,?,?,?,?)",arr[0],arr[1],date,cap,"확인",arr[4],etc);
				queryRunner.update(conn,"UPDATE grd_log SET success_date=? WHERE per_id=? and schedule_name=?",today,arr[0],"신청접수");
				queryRunner.update(conn, "DELETE FROM grd_req_students WHERE per_id=?",arr[0]);
				queryRunner.update(conn,"INSERT INTO grd_userlog SET per_id=?,log_date=?,grd_state=?,reason=?",arr[0],today,"신청접수","신청접수 승인");
			}
		}catch(SQLException se) {
			se.printStackTrace();
		}
		return arr[0];
	}

	public String insertgrduser(String data) {//관리자추가=>본서버에 추가//0220
		String arr[]=data.split("-/-/-");//per_id+"-/-/-"+name+"-/-/-"+date+"-/-/-"+capstone+"-/-/-"+professor      
		String etc="불가";
		int cap=-1;
		//capstone구분
		if(arr[3].equals("해당없음")) {
			etc="가능";
			cap=3;
		}else if(arr[3].equals("이수")) {
			etc="가능";
			cap=2;
		}else if(arr[3].equals("이수중")) {
			etc="가능";
			cap=1;
		}
		else if(arr[3].equals("미이수"))
			cap=0;
		//date구분
		int year = Calendar.getInstance().get(Calendar.YEAR);

		String date=null;
		if(arr[2].contains(Integer.toString(year)))
			date=year+"-08";
		else 
			date=(year+1)+"-02";
		Connection conn = Config.getInstance().sqlLogin();
		List<Map<String,Object>> listOfMaps=null;
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps=queryRunner.query(conn, "SELECT * FROM grd_students WHERE per_id=?;",new MapListHandler(),arr[0]);//정식DB 중복체크
			if(listOfMaps.size()>0) {//중복있으면 ->update
				queryRunner.update(conn,"UPDATE grd_students SET name=?,prof_name=?,capstone=?,graduation_date=?,etc=? WHERE per_id=?",arr[1],arr[4],cap,date,etc,arr[0]);
			}
			else {//중복없음 -> subDB에서 real_DB에 추가
				queryRunner.update(conn,"INSERT INTO grd_students(per_id,name,graduation_date,capstone,prof_name,etc) VALUES(?,?,?,?,?,?)",arr[0],arr[1],date,cap,arr[4],etc);
				queryRunner.update(conn, "DELETE FROM grd_req_students WHERE per_id=?",arr[0]);
			}
		}catch(SQLException se) {
			se.printStackTrace();
		}
		return arr[0];
	}

	public String deletegrduser(String data) {//0220추가된메소드
		String arr[]=data.split("-/-/-");

		Connection conn = Config.getInstance().sqlLogin();	
		try {
			QueryRunner queryRunner=new QueryRunner();
			for(int i=0;i<arr.length;i++) {
				queryRunner.update(conn, "DELETE FROM grd_students WHERE per_id=?",arr[i]);
				queryRunner.update(conn, "DELETE FROM grd_log WHERE per_id=?",arr[i]);
			}
		}catch(SQLException se) {
			se.printStackTrace();
		}
		return Integer.toString(arr.length);
	}
	public String deletegrd_req_user(String data) {//0220추가된메소드
		String arr[]=data.split("-/-/-");

		Connection conn = Config.getInstance().sqlLogin();	
		try {
			QueryRunner queryRunner=new QueryRunner();
			for(int i=0;i<arr.length;i++) {
				queryRunner.update(conn, "DELETE FROM grd_req_students WHERE per_id=?",arr[i]);
				queryRunner.update(conn, "DELETE FROM grd_log WHERE per_id=?",arr[i]);
			}
		}catch(SQLException se) {
			se.printStackTrace();
		}
		return Integer.toString(arr.length);
	}

	public ArrayList<GrdUserBean> getProfessorGrdUsers(UserBean userbean) {
		List<Map<String,Object>> listOfMaps=null;
		Connection conn = Config.getInstance().sqlLogin();	
		try {
			QueryRunner queryRunner=new QueryRunner();
			listOfMaps=queryRunner.query(conn, "SELECT * FROM grd_students WHERE prof_name=?;",new MapListHandler(),userbean.name);
		}catch(SQLException se) {
			se.printStackTrace();
		}
		Gson gson = new Gson();
		ArrayList<GrdUserBean> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GrdUserBean>>() {}.getType());
		return selected;
	}
	public GrdlogBean findGrdStudents_log(String per_id,String schedule_name) throws SQLException {//변경2.14
		Gson gson = new Gson();
		Connection conn = Config.getInstance().sqlLogin();
		List<Map<String,Object>> listOfMaps=null;
		ArrayList<GrdlogBean> selected =null;
		try {
			QueryRunner queryRunner= new QueryRunner();
			listOfMaps=queryRunner.query(conn,"SELECT * FROM `grd_log` WHERE per_id=? AND schedule_name=?", new MapListHandler(),per_id,schedule_name);
		}catch(SQLException se) {
			se.printStackTrace();
		}
		selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GrdlogBean>>() {}.getType());
		if(selected.size()>0) {
			return selected.get(0);
		}
		else
			return null;
	}

	public UserBean findGrdStudent(String per_id) {
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn,"SELECT * FROM user WHERE per_id = ?;", new MapListHandler(), per_id);
		} catch(SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		ArrayList<UserBean> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<UserBean>>() {}.getType());
		if(selected.size()>0) {
			return selected.get(0);
		}
		else
			return null;
	}
	public GrdUserBean getReqGrdUsers(String per_id) {
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn,"SELECT * FROM grd_req_students WHERE per_id = ?;", new MapListHandler(), per_id);
		} catch(SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		ArrayList<GrdUserBean> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GrdUserBean>>() {}.getType());
		if(selected.size()>0) {
			return selected.get(0);
		}
		else
			return null;
	}

	public ArrayList<GrdUserBean> getProfessorReqGrdUsers(UserBean userbean) {
		List<Map<String,Object>> listOfMaps=null;
		Connection conn = Config.getInstance().sqlLogin();	
		try {
			QueryRunner queryRunner=new QueryRunner();
			listOfMaps=queryRunner.query(conn, "SELECT * FROM grd_req_students WHERE prof_name=?;",new MapListHandler(),userbean.name);
		}catch(SQLException se) {
			se.printStackTrace();
		}
		Gson gson = new Gson();
		ArrayList<GrdUserBean> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GrdUserBean>>() {}.getType());
		return selected;
	}
	public ArrayList<GrdUserBean> getAllReqGrdUsers(){	//모든 졸업대상자 리스트 받기
		List<Map<String,Object>> listOfMaps=null;
		Connection conn = Config.getInstance().sqlLogin();	
		try {
			QueryRunner queryRunner=new QueryRunner();
			listOfMaps=queryRunner.query(conn, "SELECT * FROM grd_req_students",new MapListHandler());
		}catch(SQLException se) {
			se.printStackTrace();
		}
		Gson gson = new Gson();
		ArrayList<GrdUserBean> selectedschedule = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GrdUserBean>>() {}.getType());
		return selectedschedule;
	}
	//2018-02-19 추가
	public String insert_suggest(String data) {//변경2.13 //02.21수정
		String arr[] = data.split("-/-/-");//0:per_id 1:number_1 2:number_2 3:number_3 4:number_4
		Connection conn = Config.getInstance().sqlLogin();
		String selected = "";
		Date today=new Date();
		try {
			QueryRunner queryRunner= new QueryRunner();
			queryRunner.update(conn,"INSERT INTO grd_log SET schedule_name=?, per_id=?, answer_1=?, answer_2=?, answer_3=?,answer_4=?,submit_date=?","제안서",arr[0],arr[1],arr[2],arr[3],arr[4],today);
			queryRunner.update(conn,"UPDATE grd_students SET grd_state_level=? WHERE per_id=?","제출완료",arr[0]);
			queryRunner.update(conn,"INSERT INTO grd_userlog SET per_id=?,log_date=?,grd_state=?,reason=?",arr[0],today,"제안서","제안서 제출");
		}catch(SQLException se) {
			se.printStackTrace();
		}
		return arr[0];
	}

	public String insert_mid(JsonElement element) {//02.21수정
		JsonObject obj=element.getAsJsonObject();
		String per_id=obj.get("per_id").getAsString();
		String name=obj.get("name").getAsString();
		String thesis=obj.get("thesis").getAsString();
		String file =obj.get("file").getAsString();
		if(file==null) {
			file="default";
		}
		String progress=obj.get("progress").getAsString();
		String plan=obj.get("plan").getAsString();
		Date today=new Date();
		Connection conn =Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			queryRunner.update(conn,"INSERT INTO grd_log SET schedule_name=?, per_id=?, answer_1=?, answer_2=?, answer_3=?, answer_4=?, answer_5=?,submit_date=?","중간보고서",per_id,name,thesis,file,progress,plan,today);
			queryRunner.update(conn,"UPDATE grd_students SET grd_state_level=? WHERE per_id=?","제출완료",per_id);
			queryRunner.update(conn,"INSERT INTO grd_userlog SET per_id=?,log_date=?,grd_state=?,reason=?",per_id,today,"중간보고서","중간보고서 제출");
		}catch(SQLException se) {
			se.printStackTrace();
		}
		return per_id;
	}

	public String insert_final(JsonElement element) {
		JsonObject obj=element.getAsJsonObject();
		String per_id=obj.get("per_id").getAsString();
		String name=obj.get("name").getAsString();
		String thesis=obj.get("thesis").getAsString();
		String check=obj.get("check").getAsString();
		String page=obj.get("page").getAsString();
		String file=obj.get("file").getAsString();
		if(file==null) {
			file="default";
		}
		Date today=new Date();
		Connection conn =Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner=new QueryRunner();
			queryRunner.update(conn,"INSERT INTO grd_log SET schedule_name=?, per_id=?,answer_1=?,answer_2=?,answer_3=?,answer_4=?,answer_5=?,submit_date=?","최종보고서",per_id,name,thesis,check,page,file,today);
			queryRunner.update(conn,"UPDATE grd_students SET grd_state_level=? WHERE per_id=?","제출완료",per_id);
			queryRunner.update(conn,"INSERT INTO grd_userlog SET per_id=?,log_date=?,grd_state=?,reason=?",per_id,today,"최종보고서","최종보고서 제출");
		}catch(SQLException se) {
			se.printStackTrace();
		}
		return per_id;
	}

	public String insert_license(JsonElement element) {
		JsonObject obj=element.getAsJsonObject();
		String per_id=obj.get("per_id").getAsString();
		String select=obj.get("license").getAsString();
		String num=obj.get("licensenum").getAsString();
		String place=obj.get("licenseplace").getAsString();
		String date=obj.get("date").getAsString();
		String file =obj.get("file").getAsString();
		if(file==null) {
			file="default";
		}
		Date today=new Date();
		Connection conn = Config.getInstance().sqlLogin();
		List<Map<String, Object>> listOfMaps = null;
		Gson gson = new Gson();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn, "SELECT * FROM grd_log WHERE per_id = ? AND (schedule_name = '학술대회' OR schedule_name = '공모전')", new MapListHandler(), per_id);
			ArrayList<GrdlogBean> lists = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GrdlogBean>>() {}.getType());
			for(int i = 0 ; i < lists.size() ; ++i){
				queryRunner.update(conn, "DELETE FROM grd_log WHERE per_id = ? AND schedule_name = ?", per_id, lists.get(i).schedule_name);
			}
			queryRunner.update(conn,"INSERT INTO grd_log SET schedule_name=?,per_id=?,answer_1=?,answer_2=?,answer_3=?,answer_4=?,answer_5=?,submit_date=?","자격증",per_id,select,num,place,date,file,today);
			queryRunner.update(conn,"INSERT INTO grd_userlog SET per_id=?,log_date=?,grd_state=?,reason=?",per_id,today,"기타자격(자격증)","기타자격(자격증) 제출");
			queryRunner.update(conn,"UPDATE grd_students SET etc_level=? WHERE per_id=?","제출완료",per_id);

		}catch(SQLException se) {
			se.printStackTrace();
		}
		return per_id;
	}

	public String insert_etc2(JsonElement element) {

		JsonObject obj=element.getAsJsonObject();
		String per_id=obj.get("per_id").getAsString();
		String name=obj.get("name").getAsString();
		String license=obj.get("license").getAsString();
		String price=obj.get("price").getAsString();
		String openorgan=obj.get("openorgan").getAsString();
		String receivedate=obj.get("receivedate").getAsString();
		String opencontest=obj.get("opencontest").getAsString();
		String file1=obj.get("file1").getAsString();
		String file2=obj.get("file2").getAsString();
		List<Map<String, Object>> listOfMaps = null;
		Gson gson = new Gson();
		if(file1==null) {
			file1="default";
		}
		if(file2==null) {
			file2="default";
		}
		Date today=new Date();
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn, "SELECT * FROM grd_log WHERE per_id = ? AND (schedule_name = '학술대회' OR schedule_name = '자격증')", new MapListHandler(), per_id);
			ArrayList<GrdlogBean> lists = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GrdlogBean>>() {}.getType());
			for(int i = 0 ; i < lists.size() ; ++i)
				queryRunner.update(conn, "DELETE FROM grd_log WHERE per_id = ? AND schedule_name = ?", per_id, lists.get(i).schedule_name);
			queryRunner.update(conn,"INSERT INTO grd_log SET schedule_name=?,per_id=?,answer_1=?,answer_2=?,answer_3=?,answer_4=?,answer_5=?,answer_6=?,answer_7=?,answer_8=?,submit_date=?","공모전",per_id,name,license,price,openorgan,receivedate,opencontest,file1,file2,today);
			queryRunner.update(conn,"INSERT INTO grd_userlog SET per_id=?,log_date=?,grd_state=?,reason=?",per_id,today,"기타자격(공모전)","기타자격(공모전) 제출");
			queryRunner.update(conn,"UPDATE grd_students SET etc_level=? WHERE per_id=?","제출완료",per_id);
		}catch(SQLException se) {
			se.printStackTrace();
		}
		return per_id;
	}
	public String insert_etc3(JsonElement element) {

		JsonObject obj=element.getAsJsonObject();
		String per_id=obj.get("per_id").getAsString();
		String name=obj.get("name").getAsString();
		String check=obj.get("check").getAsString();
		String thesis=obj.get("thesis").getAsString();
		String openplace=obj.get("openplace").getAsString();
		String date=obj.get("date").getAsString();
		String file1=obj.get("upload1").getAsString();
		String file2=obj.get("upload2").getAsString();
		List<Map<String, Object>> listOfMaps = null;
		Gson gson = new Gson();
		if(file1==null) {
			file1="default";
		}
		if(file2==null) {
			file2="default";
		}
		Date today=new Date();
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn, "SELECT * FROM grd_log WHERE per_id = ? AND (schedule_name = '공모전' OR schedule_name = '자격증')", new MapListHandler(), per_id);
			ArrayList<GrdlogBean> lists = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GrdlogBean>>() {}.getType());
			for(int i = 0 ; i < lists.size() ; ++i)
				queryRunner.update(conn, "DELETE FROM grd_log WHERE per_id = ? AND schedule_name = ?", per_id, lists.get(i).schedule_name);
			queryRunner.update(conn,"INSERT INTO grd_log SET schedule_name=?,per_id=?,answer_1=?,answer_2=?,answer_3=?,answer_4=?,answer_5=?,answer_6=?,answer_7=?,submit_date=?","학술대회",per_id,name,check,thesis,openplace,date,file1,file2,today);
			queryRunner.update(conn,"INSERT INTO grd_userlog SET per_id=?,log_date=?,grd_state=?,reason=?",per_id,today,"기타자격(학술대회)","기타자격(학술대회) 제출");
			queryRunner.update(conn,"UPDATE grd_students SET etc_level=? WHERE per_id=?","제출완료",per_id);
		}catch(SQLException se) {
			se.printStackTrace();
		}
		return per_id;
	}
	public List<String> findinsertstate(String per_id) {//현재상태 파악
		Connection conn= Config.getInstance().sqlLogin();
		List<String> idmap=null;
		try {
			QueryRunner queryRunner = new QueryRunner();
			idmap=queryRunner.query(conn, "SELECT schedule_name FROM grd_log WHERE per_id=?",new ColumnListHandler<String>(),per_id);
		}catch(SQLException se) {
			se.printStackTrace();
		}

		return idmap;
	}

	public void compareDate(String data,String per_id) throws ParseException {//날짜 비교하여 마감하는 메소드//02.22 수정
		Connection conn =Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner =new QueryRunner();
			List<String> grd_state=queryRunner.query(conn, "SELECT grd_state_level FROM grd_students WHERE per_id=?",new ColumnListHandler<String>(),per_id);
			List<Map<String,Object>> list =null;
			if(grd_state.get(0).equals("대기")||grd_state.get(0).equals("확인")) {
				if(grd_state.get(0).equals("대기"))
					list=queryRunner.query(conn, "SELECT * FROM grd_schedule WHERE schedule_name=?",new MapListHandler(),data);
				else {
					List<Integer> id=queryRunner.query(conn, "SELECT schedule_id FROM grd_schedule WHERE schedule_name=?",new ColumnListHandler<Integer>(),data);
					if(id.size()>0)
						list=queryRunner.query(conn, "SELECT * FROM grd_schedule WHERE schedule_name=(SELECT `schedule_name` FROM kgcs.grd_schedule WHERE schedule_id=?)",new MapListHandler(),id.get(0)+1);
				}
				LocalDate today = LocalDate.now();//오늘날짜
				DateTimeFormatter formatter= DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss.S");   
				String start1=list.get(0).get("starting_date").toString();
				String close1=list.get(0).get("closing_date").toString();
				LocalDate start= LocalDate.parse(start1,formatter);
				LocalDate close = LocalDate.parse(close1,formatter).minusDays(1);
				int compare1 = start.compareTo(today);//start<today -
				int compare2 = close.compareTo(today);//close<today -
				if(compare1<=0) {
					if(grd_state.get(0).equals("확인")) {
						if(list.get(0).get("schedule_name").equals("최종통과")) {
							queryRunner.update(conn, "UPDATE grd_students SET grd_state_level=?,grd_state=? WHERE per_id=?","확인","최종통과",per_id);
						}else
							queryRunner.update(conn,"UPDATE kgcs.grd_students SET `grd_state`=(SELECT `schedule_name` FROM kgcs.grd_schedule WHERE schedule_id=?), grd_state_level=? WHERE per_id=?",Integer.parseInt(list.get(0).get("schedule_id").toString()),"제출가능",per_id);
					}else{
						if(compare2>=0)
							queryRunner.update(conn,"UPDATE grd_students SET grd_state_level=? WHERE per_id=?","제출가능",per_id);
						else
							queryRunner.update(conn,"UPDATE grd_students SET grd_state_level=? WHERE per_id=?","지연",per_id);
					}
				}
			}else if(grd_state.get(0).equals("제출가능")||(grd_state.get(0).equals("반려"))) {
				list=queryRunner.query(conn, "SELECT * FROM grd_schedule WHERE schedule_name=?",new MapListHandler(),data);
				LocalDate today = LocalDate.now();//오늘날짜
				DateTimeFormatter formatter= DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss.S");   
				String start1=list.get(0).get("starting_date").toString();
				String close1=list.get(0).get("closing_date").toString();
				LocalDate start= LocalDate.parse(start1,formatter);
				LocalDate close = LocalDate.parse(close1,formatter).minusDays(1);

				int compare2 = close.compareTo(today);//close<today -
				if(compare2<0) {
					Date date=new Date();
					queryRunner.update(conn,"INSERT INTO grd_userlog SET per_id=?,log_date=?,grd_state=?,reason=?",per_id,date,data,data+" 지연");
					queryRunner.update(conn,"UPDATE grd_students SET grd_state_level=? WHERE per_id=?","지연",per_id);
				}
			}else if(grd_state.get(0).equals("지연")) {
				list=queryRunner.query(conn, "SELECT * FROM grd_schedule WHERE schedule_name=?",new MapListHandler(),data);
				LocalDate today = LocalDate.now();//오늘날짜
				DateTimeFormatter formatter= DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss.S");   
				String start1=list.get(0).get("starting_date").toString();
				String close1=list.get(0).get("closing_date").toString();
				LocalDate start= LocalDate.parse(start1,formatter);
				LocalDate close = LocalDate.parse(close1,formatter).minusDays(1);
				int compare2 = close.compareTo(today);
				if(compare2>=0) {
					queryRunner.update(conn,"UPDATE grd_students SET grd_state_level=? WHERE per_id=?","제출가능",per_id);
				}

			}else {
				//기타자격일때
			}
		}catch(SQLException se) {
			se.printStackTrace();
		}finally {
			DbUtils.closeQuietly(conn);
		}
	}
	public ArrayList<GrdlogBean> Allgrdlog(String per_id) {//미제출된거는 schedule_name이 default됩니다
		List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
		List<Map<String,Object>> listOfMap =null;
		Map<String,Object> not=new HashMap<>();
		not.put("schedule_name", "default");
		Connection conn =Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMap = queryRunner.query(conn,"SELECT * FROM `grd_log` WHERE per_id=? and schedule_name=?",new MapListHandler(),per_id,"신청접수");
			if(listOfMap.size()>0)
				list.add(listOfMap.get(0));
			else
				list.add(not);
			listOfMap = queryRunner.query(conn,"SELECT * FROM `grd_log` WHERE per_id=? and schedule_name=?",new MapListHandler(),per_id,"제안서");
			if(listOfMap.size()>0)
				list.add(listOfMap.get(0));
			else
				list.add(not);
			listOfMap = queryRunner.query(conn,"SELECT * FROM `grd_log` WHERE per_id=? and schedule_name=?",new MapListHandler(),per_id,"중간보고서");
			if(listOfMap.size()>0)
				list.add(listOfMap.get(0));
			else
				list.add(not);
			listOfMap = queryRunner.query(conn,"SELECT * FROM `grd_log` WHERE per_id=? and schedule_name=?",new MapListHandler(),per_id,"최종보고서");
			if(listOfMap.size()>0)
				list.add(listOfMap.get(0));
			else
				list.add(not);
			listOfMap = queryRunner.query(conn,"SELECT * FROM `grd_log` WHERE per_id=? and schedule_name=?",new MapListHandler(),per_id,"자격증");
			listOfMap.addAll(queryRunner.query(conn,"SELECT * FROM `grd_log` WHERE per_id=? and schedule_name=?",new MapListHandler(),per_id,"공모전"));
			listOfMap.addAll(queryRunner.query(conn,"SELECT * FROM `grd_log` WHERE per_id=? and schedule_name=?",new MapListHandler(),per_id,"학술대회"));
			if(listOfMap.size()>0)
				list.add(listOfMap.get(0));
			else
				list.add(not);

		}catch(SQLException se) {
			se.printStackTrace();
		}finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();

		ArrayList<GrdlogBean> selected=gson.fromJson(gson.toJson(list), new TypeToken<List<GrdlogBean>>() {}.getType());
		for(int i = 0 ; i < selected.size() ; ++i) {
			selected.get(i).answer_1 = getRemoveHtmlText(selected.get(i).answer_1);
			selected.get(i).answer_2 = getRemoveHtmlText(selected.get(i).answer_2);
			selected.get(i).answer_3 = getRemoveHtmlText(selected.get(i).answer_3);
			selected.get(i).answer_4 = getRemoveHtmlText(selected.get(i).answer_4);
			selected.get(i).answer_5 = getRemoveHtmlText(selected.get(i).answer_5);
			selected.get(i).answer_6 = getRemoveHtmlText(selected.get(i).answer_6);
			selected.get(i).answer_7 = getRemoveHtmlText(selected.get(i).answer_7);
			selected.get(i).answer_8 = getRemoveHtmlText(selected.get(i).answer_8);
		}
		return selected;
	}



	public GrdlogBean getGrdlog(String per_id, String data) {
		int number =Integer.parseInt(data);
		String data1=null;
		switch(number) {
		case 1:
			data1="신청접수";
			break;
		case 2:
			data1="제안서";
			break;
		case 3:
			data1="중간보고서";
			break;
		case 4:
			data1="최종보고서";
			break;
		case 5:
			data1="자격증";
			break;
		case 6:
			data1="공모전";
			break;
		case 7:
			data1="학술대회";
			break;
		}
		List<Map<String,Object>> listOfMap =null;
		Connection conn =Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMap = queryRunner.query(conn,"SELECT * FROM grd_log WHERE per_id=? and schedule_name=?",new MapListHandler(),per_id,data1);
		}catch(SQLException se) {
			se.printStackTrace();
		}finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson=new Gson();
		ArrayList<GrdlogBean> selected=gson.fromJson(gson.toJson(listOfMap), new TypeToken<List<GrdlogBean>>(){}.getType());
		selected.get(0).answer_1 = getRemoveHtmlText(selected.get(0).answer_1);
		selected.get(0).answer_2 = getRemoveHtmlText(selected.get(0).answer_2);
		selected.get(0).answer_3 = getRemoveHtmlText(selected.get(0).answer_3);
		selected.get(0).answer_4 = getRemoveHtmlText(selected.get(0).answer_4);
		selected.get(0).answer_5 = getRemoveHtmlText(selected.get(0).answer_5);
		selected.get(0).answer_6 = getRemoveHtmlText(selected.get(0).answer_6);
		selected.get(0).answer_7 = getRemoveHtmlText(selected.get(0).answer_7);
		selected.get(0).answer_8 = getRemoveHtmlText(selected.get(0).answer_8);
		return selected.get(0);
	}

	public String update_request(String data) {
		String arr[] = data.split("-/-/-");//0:user.per_id 1:name 2:date 3:anwer
		Connection conn = Config.getInstance().sqlLogin();
		String selected = "";
		try {
			QueryRunner queryRunner= new QueryRunner();
			queryRunner.update(conn,"UPDATE grd_log SET answer_1=?,refuse_date=? WHERE per_id=? and schedule_name=?",arr[3],null,arr[0],"신청접수");
			if(queryRunner.query(conn, "SELECT * FROM grd_students WHERE per_id=?",new MapListHandler(),arr[0]).size()>0) {//정식디비에 중복이있으면=유저보다관리자가먼저추가하면
				queryRunner.update(conn,"UPDATE grd_students SET grd_state_level=?,graduation_date=? WHERE per_id=?","제출완료",arr[2],arr[0]);
			}else
				queryRunner.update(conn,"UPDATE grd_req_students SET grd_state_level=?,graduation_date=? WHERE per_id=?","제출완료",arr[2],arr[0]);
		}catch(SQLException se) {
			se.printStackTrace();
		}
		return selected;
	}


	//2018-02-19 추가
	public String findThesis(String per_id) {
		Connection conn= Config.getInstance().sqlLogin();
		List<String> idmap=null;
		try {
			QueryRunner queryRunner = new QueryRunner();
			idmap=queryRunner.query(conn, "SELECT answer_2 FROM grd_log WHERE per_id=? and schedule_name=?",new ColumnListHandler<String>(),per_id,"제안서");
		}catch(SQLException se) {
			se.printStackTrace();
		}

		if(idmap.size()>0)
			return idmap.get(0);
		else
			return null;
	}


	public String downloadfile(GrdlogBean log, String stage_name) {

		List<String> val=null;
		List<String> file=new ArrayList<>();
		Connection conn=Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner=new QueryRunner();
			switch(stage_name) {
			case "중간보고서":
				val=queryRunner.query(conn,"SELECT answer_3 FROM grd_log WHERE per_id=? and schedule_name=?",new ColumnListHandler<String>(),log.per_id,log.schedule_name);
				break;
			case "최종보고서":
				val=queryRunner.query(conn,"SELECT answer_5 FROM grd_log WHERE per_id=? and schedule_name=?",new ColumnListHandler<String>(),log.per_id,log.schedule_name);
				break;
			case "공모전":
				val=queryRunner.query(conn,"SELECT answer_7 FROM grd_log WHERE per_id=? and schedule_name=?",new ColumnListHandler<String>(),log.per_id,log.schedule_name);
				val.addAll(queryRunner.query(conn,"SELECT answer_8 FROM grd_log WHERE per_id=? and schedule_name=?",new ColumnListHandler<String>(),log.per_id,log.schedule_name));
				break;
			case "자격증":
				val=queryRunner.query(conn,"SELECT answer_5 FROM grd_log WHERE per_id=? and schedule_name=?",new ColumnListHandler<String>(),log.per_id,log.schedule_name);
				break;
			case "학술대회":
				val=queryRunner.query(conn,"SELECT answer_6 FROM grd_log WHERE per_id=? and schedule_name=?",new ColumnListHandler<String>(),log.per_id,log.schedule_name);
				val.addAll(queryRunner.query(conn,"SELECT answer_7 FROM grd_log WHERE per_id=? and schedule_name=?",new ColumnListHandler<String>(),log.per_id,log.schedule_name));
				break;
			}
			if(val.size()>0)
				for(int i=0;i<val.size();i++) {
					file.addAll(queryRunner.query(conn, "SELECT filename FROM grd_file WHERE id=?",new ColumnListHandler<String>(),val.get(i)));
				}
		}catch(SQLException se) {
			se.printStackTrace();
		}
		Gson gson=new Gson();
		if(file.size()>0) {
			String array=gson.toJson(file);
			return array;
		}
		else return null;
	}

	public String modify_license(JsonElement element) {//자격증 수정 (2.20)
		JsonObject obj=element.getAsJsonObject();
		String per_id=obj.get("per_id").getAsString();
		String select=obj.get("license").getAsString();
		String num=obj.get("licensenum").getAsString();
		String place=obj.get("licenseplace").getAsString();
		String date=obj.get("date").getAsString();
		String file =obj.get("file").getAsString();
		if(file==null) {
			file="default";
		}
		Connection conn = Config.getInstance().sqlLogin();
		Date today=new Date();
		try {
			QueryRunner queryRunner = new QueryRunner();
			List<String> refuse=queryRunner.query(conn,"SELECT refuse_date FROM grd_log WHERE per_id=? and schedule_name=?",new ColumnListHandler<String>(),per_id,"자격증");
			if(refuse.size()>0) {
				queryRunner.update(conn,"INSERT INTO grd_userlog SET per_id=?,log_date=?,grd_state=?,reason=?",per_id,today,"기타자격(자격증)","기타자격(자격증) 재제출");
			}
			queryRunner.update(conn,"UPDATE grd_log SET answer_1=?,answer_2=?,answer_3=?,answer_4=?,answer_5=?,refuse_date=? WHERE per_id=? and schedule_name=?",select,num,place,date,file,null,per_id,"자격증");
			queryRunner.update(conn,"UPDATE grd_students SET etc_level=? WHERE per_id=?","제출완료",per_id);
		}catch(SQLException se) {
			se.printStackTrace();
		}
		return per_id;
	}

	public String modify_etc2(JsonElement element) {

		JsonObject obj=element.getAsJsonObject();
		String per_id=obj.get("per_id").getAsString();
		String name=obj.get("name").getAsString();
		String license=obj.get("license").getAsString();
		String price=obj.get("price").getAsString();
		String openorgan=obj.get("openorgan").getAsString();
		String receivedate=obj.get("receivedate").getAsString();
		String opencontest=obj.get("opencontest").getAsString();
		String file1=obj.get("file1").getAsString();
		String file2=obj.get("file2").getAsString();
		if(file1==null) {
			file1="default";
		}
		if(file2==null) {
			file2="default";
		}
		Connection conn = Config.getInstance().sqlLogin();

		try {
			QueryRunner queryRunner = new QueryRunner();
			Date today=new Date();
			List<String> refuse=queryRunner.query(conn,"SELECT refuse_date FROM grd_log WHERE per_id=? and schedule_name=?",new ColumnListHandler<String>(),per_id,"공모전");
			if(refuse.size()>0) {
				queryRunner.update(conn,"INSERT INTO grd_userlog SET per_id=?,log_date=?,grd_state=?,reason=?",per_id,today,"기타자격(공모전)","기타자격(공모전) 재제출");
			}
			queryRunner.update(conn,"UPDATE grd_log SET answer_1=?,answer_2=?,answer_3=?,answer_4=?,answer_5=?,answer_6=?,answer_7=?,answer_8=?,refuse_date=? WHERE schedule_name=? and per_id=?",name,license,price,openorgan,receivedate,opencontest,file1,file2,null,"공모전",per_id);
			queryRunner.update(conn,"UPDATE grd_students SET etc_level=? WHERE per_id=?","제출완료",per_id);
		}catch(SQLException se) {
			se.printStackTrace();
		}
		return per_id;
	}

	public String modify_etc3(JsonElement element) {

		JsonObject obj=element.getAsJsonObject();
		String per_id=obj.get("per_id").getAsString();
		String name=obj.get("name").getAsString();
		String check=obj.get("check").getAsString();
		String thesis=obj.get("thesis").getAsString();
		String openplace=obj.get("openplace").getAsString();
		String date=obj.get("date").getAsString();
		String file1=obj.get("upload1").getAsString();
		String file2=obj.get("upload2").getAsString();
		if(file1==null) {
			file1="default";
		}
		if(file2==null) {
			file2="default";
		}
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			Date today=new Date();
			List<String> refuse=queryRunner.query(conn,"SELECT refuse_date FROM grd_log WHERE per_id=? and schedule_name=?",new ColumnListHandler<String>(),per_id,"학술대회");
			if(refuse.size()>0) {
				queryRunner.update(conn,"INSERT INTO grd_userlog SET per_id=?,log_date=?,grd_state=?,reason=?",per_id,today,"기타자격(학술대회)","기타자격(학술대회) 재제출");
			}
			queryRunner.update(conn,"UPDATE grd_log SET answer_1=?,answer_2=?,answer_3=?,answer_4=?,answer_5=?,answer_6=?,answer_7=?,refuse_date=? WHERE schedule_name=? and per_id=?",name,check,thesis,openplace,date,file1,file2,null,"학술대회",per_id);
			queryRunner.update(conn,"UPDATE grd_students SET etc_level=? WHERE per_id=?","제출완료",per_id);
		}catch(SQLException se) {
			se.printStackTrace();
		}
		return per_id;
	}

	public String modify_final(JsonElement element) {
		JsonObject obj=element.getAsJsonObject();
		String per_id=obj.get("per_id").getAsString();
		String name=obj.get("name").getAsString();
		String thesis=obj.get("thesis").getAsString();
		String check=obj.get("check").getAsString();
		String page=obj.get("page").getAsString();
		String file=obj.get("file").getAsString();
		if(file==null) {
			file="default";
		}
		Connection conn =Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner=new QueryRunner();
			Date today=new Date();
			List<String> refuse=queryRunner.query(conn,"SELECT refuse_date FROM grd_log WHERE per_id=? and schedule_name=?",new ColumnListHandler<String>(),per_id,"최종보고서");
			if(refuse.size()>0) {
				queryRunner.update(conn,"INSERT INTO grd_userlog SET per_id=?,log_date=?,grd_state=?,reason=?",per_id,today,"최종보고서","최종보고서 재제출");
			}
			queryRunner.update(conn,"UPDATE grd_log SET answer_1=?,answer_2=?,answer_3=?,answer_4=?,answer_5=?,refuse_date=? WHERE schedule_name=? and per_id=?",name,thesis,check,page,file,null,"최종보고서",per_id);
			queryRunner.update(conn,"UPDATE grd_students SET grd_state_level=? WHERE per_id=?","제출완료",per_id);
		}catch(SQLException se) {
			se.printStackTrace();
		}
		return per_id;
	}

	public String modify_mid(JsonElement element) {
		JsonObject obj=element.getAsJsonObject();
		String per_id=obj.get("per_id").getAsString();
		String name=obj.get("name").getAsString();
		String thesis=obj.get("thesis").getAsString();
		String file =obj.get("file").getAsString();
		if(file==null) {
			file="default";
		}
		String progress=obj.get("progress").getAsString();
		String plan=obj.get("plan").getAsString();
		Connection conn =Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			Date today=new Date();
			List<String> refuse=queryRunner.query(conn,"SELECT refuse_date FROM grd_log WHERE per_id=? and schedule_name=?",new ColumnListHandler<String>(),per_id,"중간보고서");
			if(refuse.size()>0) {
				queryRunner.update(conn,"INSERT INTO grd_userlog SET per_id=?,log_date=?,grd_state=?,reason=?",per_id,today,"중간보고서","중간보고서 재제출");
			}
			queryRunner.update(conn,"UPDATE grd_log SET answer_1=?, answer_2=?, answer_3=?, answer_4=?, answer_5=?,refuse_date=? WHERE  schedule_name=? and per_id=?",name,thesis,file,progress,plan,null,"중간보고서",per_id);
			queryRunner.update(conn,"UPDATE grd_students SET grd_state_level=? WHERE per_id=?","제출완료",per_id);
		}catch(SQLException se) {
			se.printStackTrace();
		}
		return per_id;
	}

	public String modify_suggest(String data) {
		String arr[] = data.split("-/-/-");//0:per_id 1:number_1 2:number_2 3:number_3 4:number_4
		Connection conn = Config.getInstance().sqlLogin();
		String selected = "";
		try {
			QueryRunner queryRunner= new QueryRunner();
			Date today=new Date();
			List<String> refuse=queryRunner.query(conn,"SELECT refuse_date FROM grd_log WHERE per_id=? and schedule_name=?",new ColumnListHandler<String>(),arr[0],"제안서");
			if(refuse.size()>0) {
				queryRunner.update(conn,"INSERT INTO grd_userlog SET per_id=?,log_date=?,grd_state=?,reason=?",arr[0],today,"제안서","제안서 재제출");
			}
			queryRunner.update(conn,"UPDATE grd_log SET answer_1=?, answer_2=?, answer_3=?,answer_4=?,refuse_date=? WHERE  schedule_name=? and per_id=?",arr[1],arr[2],arr[3],arr[4],null,"제안서",arr[0]);
			queryRunner.update(conn,"UPDATE grd_students SET grd_state_level=? WHERE per_id=?","제출완료",arr[0]);
		}catch(SQLException se) {
			se.printStackTrace();
		}
		return arr[0];
	}

	public String getAllProfessor() {
		List<String> profname=null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner=new QueryRunner();
			profname=queryRunner.query(conn, "SELECT name FROM user WHERE type=?",new ColumnListHandler<String>(),"교수1");
		}catch(SQLException se) {
			se.printStackTrace();
		}

		return new Gson().toJson(profname);
	}

	public String req_refuse(String data) {//신청접수 반려기능List<Map<String, Object>> listOfMaps = null;
	      String arr[] = data.split("-/-/-");//0:per_id 1:"신청접수"
	      Date today=new Date();
	      Connection conn = Config.getInstance().sqlLogin();
	      try {
	         QueryRunner queryRunner = new QueryRunner();
	         queryRunner.update(conn,"UPDATE grd_log SET refuse_date=? WHERE per_id = ? AND schedule_name=?;",today,arr[0],arr[1]);
	         queryRunner.update(conn,"UPDATE grd_req_students SET grd_state_level=? WHERE per_id=?","반려",arr[0]);//반려상태추가
	         queryRunner.update(conn,"UPDATE grd_students SET grd_state_level=? WHERE per_id=?","반려",arr[0]);//반려상태추가
	         queryRunner.update(conn,"INSERT INTO grd_userlog SET per_id=?,log_date=?,grd_state=?,reason=?",arr[0],today,arr[1],"신청접수 반려");
	      } catch(SQLException se) {
	         se.printStackTrace();
	      } finally {
	         DbUtils.closeQuietly(conn);
	      }
	      return null;
	   }
	public String successState(String per_id, String state) {//2.21


		Connection conn=Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner =new QueryRunner();
			Date today=new Date();
			queryRunner.update(conn,"UPDATE grd_log SET success_date=? WHERE per_id=? and schedule_name=?",today,per_id,state);
			if(state.equals("자격증")||state.equals("공모전")||state.equals("학술대회")) {
				queryRunner.update(conn,"UPDATE grd_students SET etc_level=?,grd_state_level=?,grd_state=? WHERE per_id=?","확인","확인","기타자격",per_id);
				queryRunner.update(conn,"INSERT INTO grd_userlog SET per_id=?,log_date=?,grd_state=?,reason=?",per_id,today,"기타자격("+state+")","기타자격("+state+") 승인");
			}else {
				queryRunner.update(conn,"UPDATE grd_students SET grd_state_level=? WHERE per_id=?","확인",per_id);
				queryRunner.update(conn,"INSERT INTO grd_userlog SET per_id=?,log_date=?,grd_state=?,reason=?",per_id,today,state,state+" 승인");
			}
		}catch(SQLException se){
			se.printStackTrace();
		}

		return per_id;
	}

	public String refuseState(String data, String state) {//2.21
	      String arr[]=data.split("-/-/-");//per_id,refuse_memo
	      String today=LocalDate.now().toString();
	      LocalDateTime today1=LocalDateTime.now();
	      String refuse_memo=today+"-/-/-"+state+"-/-/-"+arr[1];
	      Connection conn=Config.getInstance().sqlLogin();
	      List<String> past=null; 
	      try {
	         QueryRunner queryRunner =new QueryRunner();
	         if(state.equals("자격증")||state.equals("공모전")||state.equals("학술대회")) {
	            queryRunner.update(conn,"UPDATE grd_students SET etc_level=?,refuse_memo=? WHERE per_id=?","반려",refuse_memo,arr[0]);
	            queryRunner.update(conn,"INSERT INTO grd_userlog SET per_id=?,log_date=?,grd_state=?,reason=?",arr[0],today1,"기타자격("+state+")","반려사유 : "+arr[1]);
	         }else {
	            queryRunner.update(conn,"UPDATE grd_students SET grd_state_level=?,refuse_memo=? WHERE per_id=?","반려",refuse_memo,arr[0]);
	            queryRunner.update(conn,"INSERT INTO grd_userlog SET per_id=?,log_date=?,grd_state=?,reason=?",arr[0],today1,state,"반려사유 : "+arr[1]);
	         }

	      }catch(SQLException se) {
	         se.printStackTrace();
	      }
	      return arr[0];
	   }
	
	   public String delay_open(String per_id) {//02.22
		      LocalDate now = LocalDate.now();  
		      Date today=new Date();
		      LocalDate tomorrow=now.plusDays(2);
		      Connection conn=Config.getInstance().sqlLogin();
		      try {
		         QueryRunner queryRunner =new QueryRunner();
		         List<Integer> delay=queryRunner.query(conn,"SELECT delay_count FROM grd_students WHERE per_id=?",new ColumnListHandler<Integer>(),per_id);
		         queryRunner.update(conn,"UPDATE grd_students SET grd_state_level=?,delay_date=?,delay_count=? WHERE per_id=?","제출가능",tomorrow,delay.get(0)+1,per_id);
		         queryRunner.update(conn,"INSERT INTO grd_userlog SET per_id=?,log_date=?,grd_state=?,reason=?",per_id,today,"모두","제출 연장 : "+tomorrow.minusDays(1).toString()+"까지 연장");//모두변경필요
		      }catch(SQLException se) {
		         se.printStackTrace();
		      }

		      return tomorrow.toString();
		   }

	public void insertFile(String id, String writer, String name, String link) {
		Connection conn=Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			queryRunner.update(conn,"INSERT INTO grd_file(id, writer, filename, filelink) VALUE (?, ?, ?, ?);",id, writer, name, link);
		}
		catch (SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
	}

	public NoticeFileBean getFile(String id) {
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn, "SELECT * FROM grd_file WHERE id=?", new MapListHandler(), id);
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		ArrayList<NoticeFileBean> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<NoticeFileBean>>() {}.getType());
		if(selectedList.size() > 0)
			return selectedList.get(0);
		else
			return null;
	}

	public ArrayList<GrdlogBean> getLoglist(String data){//data = schedule_name
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn, "SELECT * FROM grd_log WHERE schedule_name=?", new MapListHandler(), data);
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		ArrayList<GrdlogBean> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GrdlogBean>>() {}.getType());
		for(int i = 0 ; i < selectedList.size() ; ++i) {
			selectedList.get(i).answer_1 = getRemoveHtmlText(selectedList.get(i).answer_1);
			selectedList.get(i).answer_2 = getRemoveHtmlText(selectedList.get(i).answer_2);
			selectedList.get(i).answer_3 = getRemoveHtmlText(selectedList.get(i).answer_3);
			selectedList.get(i).answer_4 = getRemoveHtmlText(selectedList.get(i).answer_4);
			selectedList.get(i).answer_5 = getRemoveHtmlText(selectedList.get(i).answer_5);
			selectedList.get(i).answer_6 = getRemoveHtmlText(selectedList.get(i).answer_6);
			selectedList.get(i).answer_7 = getRemoveHtmlText(selectedList.get(i).answer_7);
			selectedList.get(i).answer_8 = getRemoveHtmlText(selectedList.get(i).answer_8);
		}
		return selectedList;
	}

	public void compareDateETC(String data,String per_id) throws ParseException, SQLException {
	      if(data.equals("자격증")||data.equals("공모전")||data.equals("학술대회"))
	         data="기타자격";
	      Connection conn=Config.getInstance().sqlLogin();
	      List<Map<String,Object>> list =null;
	      try {
	         QueryRunner queryRunner=new QueryRunner();
	         List<String> grd_state=queryRunner.query(conn, "SELECT etc_level FROM grd_students WHERE per_id=?",new ColumnListHandler<String>(),per_id);
	         if(grd_state.get(0).equals("대기")) {
	            list=queryRunner.query(conn, "SELECT * FROM grd_schedule WHERE schedule_name=?",new MapListHandler(),data);            
	            LocalDate today = LocalDate.now();//오늘날짜
	            DateTimeFormatter formatter= DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss.S");   
	            String start1=list.get(0).get("starting_date").toString();
	            String close1=list.get(0).get("closing_date").toString();
	            LocalDate start= LocalDate.parse(start1,formatter);
	            LocalDate close = LocalDate.parse(close1,formatter).minusDays(1);
	            int compare1 = start.compareTo(today);//start<today -
	            int compare2 = close.compareTo(today);//close<today -
	            if(compare1<=0) {
	               if(grd_state.get(0).equals("확인")) {
	                  queryRunner.update(conn,"UPDATE kgcs.grd_students SET etc_level=? WHERE per_id=?","제출가능",per_id);
	               }else{
	                  if(compare2>=0)
	                     queryRunner.update(conn,"UPDATE grd_students SET etc_level=? WHERE per_id=?","제출가능",per_id);
	                  else
	                     queryRunner.update(conn,"UPDATE grd_students SET etc_level=? WHERE per_id=?","지연",per_id);
	               }
	            }
	         }else if(grd_state.get(0).equals("제출가능")||(grd_state.get(0).equals("반려"))) {
	            list=queryRunner.query(conn, "SELECT * FROM grd_schedule WHERE schedule_name=?",new MapListHandler(),data);
	            LocalDate today = LocalDate.now();//오늘날짜
	            DateTimeFormatter formatter= DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss.S");   
	            String start1=list.get(0).get("starting_date").toString();
	            String close1=list.get(0).get("closing_date").toString();
	            LocalDate start= LocalDate.parse(start1,formatter);
	            LocalDate close = LocalDate.parse(close1,formatter).minusDays(1);
	            int compare1=start.compareTo(today);//start>today +
	            int compare2 = close.compareTo(today);//close<today -
	            if(compare2<0) {
	               queryRunner.update(conn,"UPDATE grd_students SET etc_level=? WHERE per_id=?","지연",per_id);
	            }else if(compare1>0) {
	               queryRunner.update(conn,"UPDATE grd_students SET etc_level=? WHERE per_id=?","대기",per_id);
	            }
	         }else if(grd_state.get(0).equals("지연")) {
	            list=queryRunner.query(conn, "SELECT * FROM grd_schedule WHERE schedule_name=?",new MapListHandler(),data);
	            LocalDate today = LocalDate.now();//오늘날짜
	            DateTimeFormatter formatter= DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss.S");   
	            String start1=list.get(0).get("starting_date").toString();
	            String close1=list.get(0).get("closing_date").toString();
	            LocalDate start= LocalDate.parse(start1,formatter);
	            LocalDate close = LocalDate.parse(close1,formatter).minusDays(1);
	            int compare2 = close.compareTo(today);
	            if(compare2<0) {
	               Date date=new Date();
	               queryRunner.update(conn,"INSERT INTO grd_userlog SET per_id=?,log_date=?,grd_state=?,reason=?",per_id,date,data,data+" 지연");
	               queryRunner.update(conn,"UPDATE grd_students SET etc_level=? WHERE per_id=?","제출가능",per_id);
	            }
	         }
	      }catch(SQLException se) {
	         se.printStackTrace();
	      }finally {
	         DbUtils.close(conn);
	      }
	   }//
	public ArrayList<GrdScheduleBean> compareSchedule() {
		Connection conn =Config.getInstance().sqlLogin();
		ArrayList<GrdScheduleBean> beanlist = getGrdSchedule();
		Date today=new Date();
		try {
			QueryRunner queryRunner = new QueryRunner();

			for(int i=0;i<beanlist.size();i++) {
				int close=today.compareTo(beanlist.get(i).closing_date);
				int start=today.compareTo(beanlist.get(i).starting_date);
				if(close>0) {
					beanlist.get(i).grd_state="마감";
					queryRunner.update(conn,"UPDATE grd_schedule SET grd_state=? WHERE schedule_id=?",beanlist.get(i).grd_state,beanlist.get(i).schedule_id);
				}
				else if(close<=0&&start>=0) {
					beanlist.get(i).grd_state="진행중";
					queryRunner.update(conn,"UPDATE grd_schedule SET grd_state=? WHERE schedule_id=?",beanlist.get(i).grd_state,beanlist.get(i).schedule_id);
				}else if(start<0){
					beanlist.get(i).grd_state="대기";
					queryRunner.update(conn,"UPDATE grd_schedule SET grd_state=? WHERE schedule_id=?",beanlist.get(i).grd_state,beanlist.get(i).schedule_id);
				}
			}
		}catch(SQLException se){
			se.printStackTrace();
		}
		return beanlist;
	}

	public ArrayList<NoticeFileBean> getFilesForDelete(String writer){
		ArrayList<NoticeFileBean> selectedList = null;
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn, "SELECT * FROM grd_file WHERE writer=? AND board_id=0", new MapListHandler(), writer);
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<NoticeFileBean>>() {}.getType());
		return selectedList;
	}

	public String deletegrduser(String data,HttpServletRequest request) {//0220추가된메소드
		String arr[]=data.split("-/-/-");
		String path=request.getSession().getServletContext().getRealPath("/uploadFile/graduation");
		Connection conn = Config.getInstance().sqlLogin();   

		try {
			QueryRunner queryRunner=new QueryRunner();
			for(int i=0;i<arr.length;i++) {
				ArrayList<NoticeFileBean> list=getFilesForDelete(arr[i]);
				if(list.size()>0) {
					for(int j=0;j<list.size();j++) {
						String fileName = list.get(i).filelink;
						File deleteFile = new File(path,fileName);
						deleteFile.delete();
					}
				}
				queryRunner.update(conn, "DELETE FROM grd_file WHERE writer=?",arr[i]);//DB삭제
				queryRunner.update(conn, "DELETE FROM grd_students WHERE per_id=?",arr[i]);
				queryRunner.update(conn, "DELETE FROM grd_log WHERE per_id=?",arr[i]);
				queryRunner.update(conn,"DELETE FROM grd_userlog WHERE per_id=?",arr[i]);
			}
		}catch(Exception se) {
			se.printStackTrace();
		}
		return Integer.toString(arr.length);
	}

	//public String grdexceldown(HttpServletRequest request) throws IOException {
	//	Connection conn =Config.getInstance().sqlLogin();
	//	List<Map<String,Object>> list = null; 
	//	try {
	//		QueryRunner queryRunner = new QueryRunner();
	//		list=queryRunner.query(conn,"SELECT * FROM grd_students",new MapListHandler());
	//	}catch(SQLException se) {
//			se.printStackTrace();
//		}
//		Gson gson = new Gson();
//		ArrayList<GrdUserBean> userlist = gson.fromJson(gson.toJson(list), new TypeToken<List<GrdUserBean>>(){}.getType());
///		ExcelWriter ex = new ExcelWriter();
//		String comment=ex.grdExcelWrtier(userlist,request.getServletContext().getRealPath("/uploadFile"));
//		return comment;
//	}

	public ArrayList<Grd_UserlogBean> userloglist(String per_id) throws SQLException{
	      Connection conn =Config.getInstance().sqlLogin();
	      List<Map<String,Object>> list =  null;
	      try {
	         QueryRunner queryRunner = new QueryRunner();
	         list=queryRunner.query(conn,"SELECT * FROM grd_userlog WHERE per_id=?",new MapListHandler(),per_id);
	      }catch(SQLException se) {
	         se.printStackTrace();
	      }finally {
	         DbUtils.close(conn);
	      }
	      Gson gson = new Gson();
	      ArrayList<Grd_UserlogBean> loglist=gson.fromJson(gson.toJson(list),  new TypeToken<List<Grd_UserlogBean>>() {}.getType());
	      if(loglist.size()>0)
	         return loglist;
	      else
	         return null;
	   }
	
	
	
	private String getRemoveHtmlText(String content) {
		if(content == null)
	    	  return null;
	      Pattern SCRIPTS = Pattern.compile("<(no)?script[^>]*>.*?</(no)?script>", Pattern.DOTALL);
	      Pattern STYLE = Pattern.compile("<style[^>]*>.*</style>", Pattern.DOTALL);
	      //Pattern TAGS = Pattern.compile("<(\"[^\"]*\"|\'[^\']*\'|[^\'\">])*>");
	      //Pattern nTAGS = Pattern.compile("<\\w+\\s+[^<]*\\s*>");
	      Pattern ENTITY_REFS = Pattern.compile("&[^;]+;");
	      Pattern WHITESPACE = Pattern.compile("\\s\\s+");
	      Pattern WHITE = Pattern.compile("<!--");
	      Pattern ON = Pattern.compile("(on)+[a-z]*=");
	      
	      Matcher m;

	      m = SCRIPTS.matcher(content);
	      content = m.replaceAll("");
	      m = STYLE.matcher(content);
	      content = m.replaceAll("");
	      m = ENTITY_REFS.matcher(content);
	      content = m.replaceAll("");
	      m = WHITESPACE.matcher(content);
	     content = m.replaceAll(" ");
	      m = WHITE.matcher(content);
	      content = m.replaceAll("");
	      m = ON.matcher(content);
	      content = m.replaceAll("");
	      return content;
	   }
}
