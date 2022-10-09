package kr.ac.kyonggi.cs.handler.dao.graduation;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.ac.kyonggi.cs.handler.action.graduation.GraduationQuartzMain;
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
import kr.ac.kyonggi.cs.handler.dto.graduation.GraduationCertificateDataDTO;
import kr.ac.kyonggi.cs.handler.dto.graduation.GraduationConferenceDataDTO;
import kr.ac.kyonggi.cs.handler.dto.graduation.GraduationContestDataDTO;
import kr.ac.kyonggi.cs.handler.dto.graduation.GraduationEtcDTO;
import kr.ac.kyonggi.cs.handler.dto.graduation.GraduationLogDTO;
import kr.ac.kyonggi.cs.handler.dto.graduation.GraduationReqStudentsDTO;
import kr.ac.kyonggi.cs.handler.dto.graduation.GraduationScheduleDTO;
import kr.ac.kyonggi.cs.handler.dto.graduation.GraduationStateListDTO;
import kr.ac.kyonggi.cs.handler.dto.graduation.GraduationThesisDataDTO;
import kr.ac.kyonggi.cs.handler.dto.graduation.GraduationUserDTO;
import kr.ac.kyonggi.cs.handler.dto.graduation.GraduationUserInfoDTO;
import kr.ac.kyonggi.cs.handler.excel.ExcelWriter;
import kr.ac.kyonggi.cs.handler.stateenum.AdminButton;
import kr.ac.kyonggi.cs.handler.stateenum.Level;
import kr.ac.kyonggi.cs.handler.stateenum.Log;
import kr.ac.kyonggi.cs.handler.stateenum.State;
import kr.ac.kyonggi.cs.handler.stateenum.Capstone;
import kr.ac.kyonggi.cs.handler.vo.GrdUserBean;
import kr.ac.kyonggi.cs.handler.vo.GrdlogBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;

public class GraduationTestDAO {

	// 싱글톤
	public static GraduationTestDAO gtd = null;

	public static GraduationTestDAO getInstance() {
		if (gtd == null) {
			gtd = new GraduationTestDAO();
		}
		return gtd;
	}

	///// 메서드
	// choi190222
	public String delayThesis(String per_id) {
		Calendar cal = new GregorianCalendar();
		cal.add(Calendar.DATE, 1);
		Date temp = cal.getTime();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String tomorrow = sdf.format(temp);
		Connection conn = Config.getInstance().sqlLogin();
		QueryRunner que = new QueryRunner();
		String today = dateToString(new Date());

		try {
			que.update(conn, "UPDATE grdu_students SET thesis_delay=? WHERE per_id=?", tomorrow, per_id);
			que.update(conn, "INSERT grdu_userlog SET per_id=?,log_date=?,grd_state=10,user_log=1", per_id, today);
			que.update(conn, "UPDATE grdu_students SET delay_count=delay_count+1,current=4 WHERE per_id=?", per_id);
		} catch (SQLException se) {
			se.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}

		return tomorrow;
	}

	// choi190214
	public ArrayList<GraduationUserInfoDTO> getAllStudent() {
		ArrayList<GraduationUserInfoDTO> result = null;
		Gson gson = new Gson();
		List<Map<String, Object>> list = null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner que = new QueryRunner();
			list = que.query(conn, "SELECT * FROM grdu_students gs,grdu_etc_state ge WHERE gs.per_id=ge.per_id;",
					new MapListHandler());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		result = gson.fromJson(gson.toJson(list), new TypeToken<List<GraduationUserInfoDTO>>() {
		}.getType());
		for (GraduationUserInfoDTO g : result) {
			g.setLevel_num(makeEtc_Accept(g.getCerti_level_int(), g.getConfe_level_int(), g.getContest_level_int(),
					g.getThesis_delay()));
			g.setRequest(makeStateEnum(g.getDelay_date(), g.getRequest(),0));
			g.setSuggest(makeStateEnum(g.getDelay_date(), g.getSuggest(),1));
			g.setInterim(makeStateEnum(g.getDelay_date(), g.getInterim(),2));
			g.setFin(makeStateEnum(g.getDelay_date(), g.getFin(),3));
		}
		return result;
	}

	// choi190214
	public ArrayList<GraduationUserInfoDTO> getAllMyStudents(String name) {
		ArrayList<GraduationUserInfoDTO> result = null;
		Gson gson = new Gson();
		List<Map<String, Object>> list = null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner que = new QueryRunner();
			list = que.query(conn,
					"SELECT * FROM grdu_students gs,grdu_etc_state ge WHERE gs.per_id=ge.per_id AND gs.prof_name=?;",
					new MapListHandler(), name);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		result = gson.fromJson(gson.toJson(list), new TypeToken<List<GraduationUserInfoDTO>>() {
		}.getType());
		for (GraduationUserInfoDTO g : result) {
			g.setLevel_num(makeEtc_Accept(g.getCerti_level_int(), g.getConfe_level_int(), g.getContest_level_int(),
					g.getThesis_delay()));
			g.setRequest(makeStateEnum(g.getDelay_date(), g.getRequest(),0));
			g.setSuggest(makeStateEnum(g.getDelay_date(), g.getSuggest(),1));
			g.setInterim(makeStateEnum(g.getDelay_date(), g.getInterim(),2));
			g.setFin(makeStateEnum(g.getDelay_date(), g.getFin(),3));
		}

		return result;
	}

	// choi190213
	public String modify_final(JsonElement element) {
		JsonObject obj = element.getAsJsonObject();
		int per_id = obj.get("per_id").getAsInt();
		int page = obj.get("page").getAsInt();
		String check = obj.get("check").getAsString();
		String name = obj.get("name").getAsString();
		Date temp = new Date();
		String now = dateToString(temp);
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner que = new QueryRunner();
			que.update(conn,
					"UPDATE grdu_thesis_data SET final_requirement=?,final_pagenum=?,final_title=? WHERE per_id=?",
					check, page, name, per_id);
			que.update(conn, "UPDATE grdu_students SET fin=?,final_action_date=?,current=6 WHERE per_id=?", 6, now,
					per_id);
			que.update(conn, "INSERT grdu_userlog SET per_id=?,log_date=?,grd_state=?,user_log=?;", per_id, now, 4, 6);
		} catch (SQLException se) {
			se.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		return String.valueOf(per_id);
	}

	// choi190213
	public String insert_final(JsonElement element) {
		JsonObject obj = element.getAsJsonObject();
		int per_id = obj.get("per_id").getAsInt();
		int page = obj.get("page").getAsInt();
		String check = obj.get("check").getAsString();
		String name = obj.get("name").getAsString();
		Date temp = new Date();
		String now = dateToString(temp);
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner que = new QueryRunner();
			que.update(conn,
					"UPDATE grdu_thesis_data SET final_requirement=?,final_pagenum=?,final_title=? WHERE per_id=?",
					check, page, name, per_id);
			que.update(conn, "UPDATE grdu_students SET fin=?,final_action_date=?,current=6 WHERE per_id=?", 6, now,
					per_id);
			que.update(conn, "INSERT grdu_userlog SET per_id=?,log_date=?,grd_state=?,user_log=?;", per_id, now, 4, 5);
		} catch (SQLException se) {
			se.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		return String.valueOf(per_id);
	}

	// jong hun
	public String insert_license(JsonElement element) {
		JsonObject obj = element.getAsJsonObject();
		String per_id = obj.get("per_id").getAsString();
		String requirement = obj.get("license").getAsString();
		String cer_id = obj.get("licensenum").getAsString();
		String organization = obj.get("licenseplace").getAsString();
		String adq_date = obj.get("date").getAsString();
		String cer_filename = obj.get("file").getAsString();
		Date temp = new Date();
		String now = dateToString(temp);

		if (cer_filename == null) {
			cer_filename = "default";
		}
		Connection conn = Config.getInstance().sqlLogin();

		try {
			QueryRunner que = new QueryRunner();
			// 자격증
			que.update(conn,
					"UPDATE grdu_certificate_data SET requirement=?,cer_id=?,organization=?, acq_date=?, cer_filename=? WHERE per_id=?",
					requirement, cer_id, organization, adq_date, cer_filename, per_id);
			// grdu_etc_state
			que.update(conn,
					"UPDATE grdu_etc_state SET certificate_submit=?, certi_level_int=?, certi_date=? WHERE per_id=?", 1,
					6, now, per_id);
			// 로그
			que.update(conn, "INSERT grdu_userlog SET per_id=?,log_date=?,grd_state=?,user_log=?;", per_id, now, 7, 5);

		} catch (SQLException se) {
			se.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		return per_id;
	}

	// jonghun
	// jong hun
	public String modify_license(JsonElement element) {
		JsonObject obj = element.getAsJsonObject();
		String per_id = obj.get("per_id").getAsString();
		String requirement = obj.get("license").getAsString();
		String cer_id = obj.get("licensenum").getAsString();
		String organization = obj.get("licenseplace").getAsString();
		String adq_date = obj.get("date").getAsString();
		String cer_filename = obj.get("file").getAsString();
		Date temp = new Date();
		String now = dateToString(temp);

		if (cer_filename == null) {
			cer_filename = "default";
		}

		Connection conn = Config.getInstance().sqlLogin();

		try {
			QueryRunner que = new QueryRunner();
			// 자격증
			que.update(conn,
					"UPDATE grdu_certificate_data SET requirement=?,cer_id=?,organization=?, acq_date=?, cer_filename=? WHERE per_id=?",
					requirement, cer_id, organization, adq_date, cer_filename, per_id);
			// grdu_etc_state
			que.update(conn,
					"UPDATE grdu_etc_state SET certificate_submit=?, certi_level_int=?, certi_date=? WHERE per_id=?", 1,
					6, now, per_id);
			// 로그
			que.update(conn, "INSERT grdu_userlog SET per_id=?,log_date=?,grd_state=?,user_log=?;", per_id, now, 7, 6);
		} catch (SQLException se) {
			se.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		return per_id;
	}

	// choi190213
	public String modify_mid(JsonElement element) {
		JsonObject obj = element.getAsJsonObject();
		String per_id = obj.get("per_id").getAsString();
		int perid = Integer.parseInt(per_id);
		String titlename = obj.get("name").getAsString();
		String content = obj.get("progress").getAsString();
		String plan = obj.get("plan").getAsString();
		String file = obj.get("file").getAsString();
		String realfile = obj.get("realfile").getAsString();
		Date temp = new Date();
		String now = dateToString(temp);
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner que = new QueryRunner(); // thesis students log
			que.update(conn,
					"UPDATE grdu_thesis_data SET interim_title=?,interim_content=?,interim_plan=?  WHERE per_id=?;",
					titlename, content, plan, perid);
			que.update(conn, "UPDATE grdu_students SET interim=?,interim_action_date=?,current=6 WHERE per_id=?", 6,
					now, perid);
			que.update(conn, "INSERT grdu_userlog SET per_id=?,log_date=?,grd_state=?,user_log=?", perid, now, 3, 6);
		} catch (SQLException se) {
			se.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		return per_id;
	}

	// choi190213
	public String insert_mid(JsonElement element) {

		JsonObject obj = element.getAsJsonObject();
		String per_id = obj.get("per_id").getAsString();
		int perid = Integer.parseInt(per_id);
		String titlename = obj.get("name").getAsString();
		String content = obj.get("progress").getAsString();
		String plan = obj.get("plan").getAsString();
		String file = obj.get("file").getAsString();
		String realfile = obj.get("realfile").getAsString();
		Date temp = new Date();
		String now = dateToString(temp);
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner que = new QueryRunner(); // thesis students log
			que.update(conn,
					"UPDATE grdu_thesis_data SET interim_title=?,interim_content=?,interim_plan=? WHERE per_id=?;",
					titlename, content, plan, perid);
			que.update(conn, "UPDATE grdu_students SET interim=?,interim_action_date=?,current=6 WHERE per_id=?", 6,
					now, perid);
			que.update(conn, "INSERT grdu_userlog SET per_id=?,log_date=?,grd_state=?,user_log=?", perid, now, 3, 5);
		} catch (SQLException se) {
			se.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}

		return per_id;
	}

	// choi190213
	// jong hun
	public void insertFile(String filename, int per_id, int stage) {

		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			if (stage == 3) {
				queryRunner.update(conn, "UPDATE grdu_thesis_data SET interim_filename=? WHERE per_id=?;", filename,
						per_id);
			} else if (stage == 4) {
				queryRunner.update(conn, "UPDATE grdu_thesis_data SET final_filename=? WHERE per_id=?;", filename,
						per_id);
			} else if (stage == 5) {
				queryRunner.update(conn, "UPDATE grdu_certificate_data SET cer_filename=? WHERE per_id=?;", filename,
						per_id);
			} else if (stage == 6) {
				queryRunner.update(conn, "UPDATE grdu_contest_data SET award_filename=? WHERE per_id=?;", filename,
						per_id);
			} else if (stage == 7) {
				queryRunner.update(conn, "UPDATE grdu_contest_data SET add_filename=? WHERE per_id=?;", filename,
						per_id);
			}

			else if (stage == 8) {
				queryRunner.update(conn, "UPDATE grdu_conference_data SET thesis_filename=? WHERE per_id=?;", filename,
						per_id);
			} else if (stage == 9) {
				queryRunner.update(conn, "UPDATE grdu_conference_data SET proof_filename=? WHERE per_id=?;", filename,
						per_id);
			}
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
	}

	// choi190212
	public String findThesis(String per_id) {
		Connection conn = Config.getInstance().sqlLogin();
		List<String> idmap = null;
		try {
			QueryRunner queryRunner = new QueryRunner();
			idmap = queryRunner.query(conn, "SELECT classification FROM grdu_thesis_data WHERE per_id=?;",
					new ColumnListHandler<String>(), per_id);
		} catch (SQLException se) {
			se.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}

		if (idmap.size() > 0)
			return idmap.get(0);
		else
			return null;
	}

	// choi190212
	public String getDownloadFileName(int key, int per_id) { // key=1 중간보고서 key=2 최종보고서
		Connection conn = Config.getInstance().sqlLogin();
		Gson gson = new Gson();
		List<String> temp = null;
		QueryRunner que = new QueryRunner();
		try {
			if (key == 1) {
				temp = que.query(conn, "SELECT interim_filename FROM grdu_thesis_data WHERE per_id=?",
						new ColumnListHandler<String>(), per_id);
			} else {
				temp = que.query(conn, "SELECT final_filename FROM grdu_thesis_data WHERE per_id=?",
						new ColumnListHandler<String>(), per_id);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		if (temp.size() > 0) {
			String result = gson.toJson(temp);
			return result;
		} else
			return null;
	}

	// choi190211
	public String grdexceldown(HttpServletRequest request) throws IOException {
		Connection conn = Config.getInstance().sqlLogin();
		List<Map<String, Object>> list = null;
		List<Map<String, Object>> list2 = null;
		try {
			QueryRunner queryRunner = new QueryRunner();
			list = queryRunner.query(conn, "SELECT * FROM grdu_students ORDER BY per_id;", new MapListHandler());
			list2 = queryRunner.query(conn, "SELECT * FROM grdu_etc_state ORDER BY per_id;", new MapListHandler());
		} catch (SQLException se) {
			se.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		ArrayList<GraduationUserDTO> userlist = gson.fromJson(gson.toJson(list),
				new TypeToken<List<GraduationUserDTO>>() {
				}.getType());
		ArrayList<GraduationEtcDTO> etclist = gson.fromJson(gson.toJson(list2),
				new TypeToken<List<GraduationEtcDTO>>() {
				}.getType());
		ExcelWriter ex = new ExcelWriter();
		String comment = ex.grdExcelWrtier(userlist, etclist, request.getServletContext().getRealPath("/uploadFile"));
		return comment;
	}

	// choi190212
	// jonghun
	public String success(String per_id, String state) {
		// 현재단계,현재상태,각단계상태,다음단계상태
		int pid = Integer.parseInt(per_id);
		Connection conn = Config.getInstance().sqlLogin();
		Date dd = new Date();
		String now = dateToString(dd);
		int sta = Level.getLevelInt(state);

		int num = 1; // 날짜 계산해서 상태를 넣는기위해 만든다
		ArrayList<GraduationScheduleDTO> sche = GraduationTestDAO.getInstance().getSchedule2();

		Date start = sche.get(sta).getStarting_date();
		Date end = sche.get(sta).getEnd_date();

		int e = dd.compareTo(end);
		int s = dd.compareTo(start);

		if (e > 0) {
			num = 5;
		} else if (e <= 0 && s >= 0) {
			num = 4;
		} else {
			num = 3;
		}
		int[] suggest = { 3, num, 7, num }; // current_state,current,suggest,imterim
		int[] mid = { 4, num, 7, num }; // current_state,current,request,fin
		int[] fin = { 5, 7, 7 }; // current_state,current,fin
		try {
			QueryRunner que = new QueryRunner();
			if (sta == 2) { // 제안서
				que.update(conn,
						"UPDATE grdu_students SET current_state=?,current=?,suggest=?,interim=?,suggest_action_date=? WHERE per_id=?;",
						suggest[0], suggest[1], suggest[2], suggest[3], now, pid);
				que.update(conn, "INSERT grdu_userlog SET per_id=?,grd_state=?,log_date=?,user_log=?", pid, sta, now, 4);
			} else if (sta == 3) { // 중간보고서
				que.update(conn,
						"UPDATE grdu_students SET current_state=?,current=?,interim=?,fin=?, interim_action_date=? WHERE per_id=?;",
						mid[0], mid[1], mid[2], mid[3], now, pid);
				que.update(conn, "INSERT grdu_userlog SET per_id=?,grd_state=?,log_date=?,user_log=?", pid, sta, now, 4);
			} else if (sta == 4) { // 최종보고서
				que.update(conn,
						"UPDATE grdu_students SET current_state=?,current=?,fin=?, final_action_date=? WHERE per_id=?",
						fin[0], fin[1], fin[2], now, pid);
				que.update(conn, "INSERT grdu_userlog SET per_id=?,grd_state=?,log_date=?,user_log=?", pid, sta, now, 4);
			}

			// 자격증(jong hun)
			else if (sta == 7) {
				System.out.println("자격증 승인");

				que.update(conn, "UPDATE grdu_etc_state SET certi_level_int=?, certi_date=? WHERE per_id=?;", 7, now,
						pid);
				que.update(conn, "UPDATE grdu_students SET current_state=?, current=? WHERE per_id=?;", 5, 7,
						pid);
				que.update(conn, "INSERT grdu_userlog SET per_id=?,grd_state=?,log_date=?,user_log=?", pid, sta, now, 4);
			}

			// 학술대회 sta 8(jong hun)
			else if (sta == 8) {
				que.update(conn, "UPDATE grdu_etc_state SET confe_level_int=?, confe_date=? WHERE per_id=?;", 7, now,
						pid);
				que.update(conn, "UPDATE grdu_students SET current_state=?, current=? WHERE per_id=?;", 5, 7,
						pid);
				que.update(conn, "INSERT grdu_userlog SET per_id=?,grd_state=?,log_date=?,user_log=?", pid, sta, now, 4);
			}

			// 공모전 sta 9(jong hun)
			else if (sta == 9) {
				que.update(conn, "UPDATE grdu_etc_state SET contest_level_int=?, contest_date=? WHERE per_id=?;", 7,
						now, pid);
				que.update(conn, "UPDATE grdu_students SET current_state=?, current=? WHERE per_id=?;", 5, 7,
						pid);
				que.update(conn, "INSERT grdu_userlog SET per_id=?,grd_state=?,log_date=?,user_log=?", pid, sta, now, 4);
			}


		} catch (SQLException se) {
			se.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		return per_id;
	}

	// choi190211
	// jong hun
	public String refuse(String data, String state) {
		String arr[] = data.split("-/-/-");// 학번, 거절사유
		Date dd = new Date();
		String now = dateToString(dd);
		Connection conn = Config.getInstance().sqlLogin();
		int sta = Level.getLevelInt(state); // 2제안 3중간 4최종
		int num = 1; // 날짜 계산해서 상태를 넣는기위해 만든다
		ArrayList<GraduationScheduleDTO> sche = GraduationTestDAO.getInstance().getSchedule2();
		Date start = sche.get(sta - 1).getStarting_date();
		Date end = sche.get(sta - 1).getEnd_date();
		int e = dd.compareTo(end); // 윤주현 : 오늘이 종료일보다 작으면(빠르면) -1, 오늘이 종료일이면 0, 오늘이 종료일보다 크면(늦으면) 1
		int s = dd.compareTo(start); //윤주현 : 오늘이 시작일보다 작으면(빠르면) -1, 오늘이 시작일이면 0, 오늘이 시작일보다 크면(늦으면) 1
		if (e > 0) { //기간 외
			num = 5;
		} else if (e <= 0 && s >= 0) { // 기간 내
			num = 4;
		} else { //기간 전
			num = 3;
		}
		try { //윤주현 : 여기서 계속 오류가 났었음. 중간에 else가 빠지고 sta=4에 대한 경우가 없어서 조건문이 두번씩 돌고 있었음.
			QueryRunner que = new QueryRunner();
			System.out.println("arr[0] : "+arr[0]+"now : "+now+"sta : "+sta+"arr[1] : "+arr[1]);
			if (sta == 2) {
				que.update(conn, "INSERT grdu_userlog SET per_id=?,log_date=?,grd_state=?,user_log=?,logetc=?", arr[0], now, sta, 2, "반려사유: " + arr[1]);
				que.update(conn, "UPDATE grdu_students SET suggest=?,suggest_action_date=?,current=? WHERE per_id=?;",	num, now, num, arr[0]);
			}
			else if (sta == 3) {
				que.update(conn, "INSERT grdu_userlog SET per_id=?,log_date=?,grd_state=?,user_log=?,logetc=?", arr[0], now, sta, 2, "반려사유: " + arr[1]);
				que.update(conn, "UPDATE grdu_students SET interim=?,interim_action_date=?,current=? WHERE per_id=?", num, now, num, arr[0]);
			}
			else if (sta == 4) {
				que.update(conn, "INSERT grdu_userlog SET per_id=?,log_date=?,grd_state=?,user_log=?,logetc=?", arr[0], now, sta, 2, "반려사유: " + arr[1]);
				que.update(conn, "UPDATE grdu_students SET fin=?,interim_action_date=?,current=? WHERE per_id=?", num, now, num, arr[0]);
			}
			// 자격증(jong hun)
			else if (sta == 7) {
				que.update(conn, "INSERT grdu_userlog SET per_id=?,log_date=?,grd_state=?,user_log=?,logetc=?", arr[0],	now, sta, 2, "반려사유: " + arr[1]);
				que.update(conn, "UPDATE grdu_etc_state SET certi_level_int=?, certi_date=? WHERE per_id=?;", 4, now,			arr[0]);
			}

			// 학술대회 sta 8(jong hun)
			else if (sta == 8) {
				que.update(conn, "INSERT grdu_userlog SET per_id=?,log_date=?,grd_state=?,user_log=?,logetc=?", arr[0],
						now, sta, 2, "반려사유: " + arr[1]);
				que.update(conn, "UPDATE grdu_etc_state SET confe_level_int=?, confe_date=? WHERE per_id=?;", 4, now,
						arr[0]);
			}

			// 공모전 sta 9(jong hun)
			else if (sta == 9) {
				que.update(conn, "INSERT grdu_userlog SET per_id=?,log_date=?,grd_state=?,user_log=?,logetc=?", arr[0],
						now, sta, 2, "반려사유: " + arr[1]);
				que.update(conn, "UPDATE grdu_etc_state SET contest_level_int=?, contest_date=? WHERE per_id=?;", 4,
						now, arr[0]);
			}

			else { //윤주현 : 여기도 수정했습니다. 만일의 오류를 대비하여
				System.out.println("GraduationTestDAO의 refuse 메소드에서 오류 발생!");
			}
		} catch (SQLException se) {
			se.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		return arr[0];
	}

	// choi190211
	public String modify_suggest(String data) {
		String arr[] = data.split("-/-/-");// 0:per_id 1:number_1 2:number_2 3:number_3 4:number_4
		Connection conn = Config.getInstance().sqlLogin();
		Date today = new Date();
		String now = dateToString(today);
		try {
			QueryRunner que = new QueryRunner();
			que.update(conn,
					"UPDATE grdu_students SET suggest=?,suggest_action_date=?,current_state=?,current=6 WHERE per_id=?",
					6, now, 2, arr[0]);
			que.update(conn, "INSERT grdu_userlog SET per_id=?,log_date=?,grd_state=?,user_log=?", arr[0], now, 2, 6);
			que.update(conn,
					"UPDATE grdu_thesis_data SET title=?,classification=?,keyword=?,proposal_content=? WHERE per_id=?;",
					arr[1], arr[2], arr[3], arr[4], arr[0]);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		return arr[0];
	}

	// choi190211
	public String insert_suggest(String data) { // user.per_id+"-/-/-"+name+"-/-/-"+checked_value+"-/-/-"+keyword+"-/-/-"+content;

		String arr[] = data.split("-/-/-");// 0:per_id 1:number_1 2:number_2 3:number_3 4:number_4
		Connection conn = Config.getInstance().sqlLogin();
		Date today = new Date();
		String now = dateToString(today);
		try {
			QueryRunner que = new QueryRunner();
			// grdu_students grdu_userlog grdu_thesis_data
			que.update(conn,
					"UPDATE grdu_students SET suggest=?, suggest_action_date=?, current_state=?,current=6 WHERE per_id=?;",
					6, now, 2, arr[0]);
			que.update(conn, "INSERT grdu_userlog SET per_id=?, log_date=?, grd_state=?,user_log=?;", arr[0], now, 2,
					5);
			que.update(conn,
					"UPDATE grdu_thesis_data SET title=?,classification=?,keyword=?,proposal_content=? WHERE per_id=?;",
					arr[1], arr[2], arr[3], arr[4], arr[0]);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		return arr[0];
	}

	// choi190211
	public GraduationEtcDTO getUserEtc(int per_id) {
		ArrayList<GraduationEtcDTO> result = null;
		Gson gson = new Gson();
		Connection conn = Config.getInstance().sqlLogin();
		List<Map<String, Object>> listOfMaps = null;
		try {
			QueryRunner que = new QueryRunner();
			listOfMaps = que.query(conn, "SELECT * FROM grdu_etc_state WHERE per_id=?", new MapListHandler(), per_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		result = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GraduationEtcDTO>>() {
		}.getType());
		if (result.size() > 0) {
			return result.get(0);
		} else {
			return null;
		}
	}

	// choi190211
	public GraduationThesisDataDTO getThesisData(int per_id, int schedulename) {
		ArrayList<GraduationThesisDataDTO> result = null;
		Gson gson = new Gson();
		Connection conn = Config.getInstance().sqlLogin();
		List<Map<String, Object>> listOfMaps = null;
		try {
			QueryRunner que = new QueryRunner();
			listOfMaps = que.query(conn, "SELECT * FROM grdu_thesis_data WHERE per_id=?", new MapListHandler(), per_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		result = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GraduationThesisDataDTO>>() {
		}.getType());
		if (result.size() > 0) {
			result.get(0).setSchedule_name(Level.getLevel(schedulename));
			return result.get(0);
		} else {
			return null;
		}

	}

	// choi 190211
	public ArrayList<GraduationEtcDTO> getMyStudentEtc(String prof_name) {
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		ArrayList<GraduationEtcDTO> list = null;
		Gson gson = new Gson();
		try {
			QueryRunner q = new QueryRunner();
			listOfMaps = q.query(conn,
					"SELECT gs.per_id,capstone FROM grdu_etc_state ge,grdu_students gs WHERE gs.per_id=ge.per_id and gs.prof_name=? ORDER BY gs.per_id;",
					new MapListHandler(), prof_name);
			list = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GraduationEtcDTO>>() {
			}.getType());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		return list;
	}

	// choi 190210
	public ArrayList<GraduationEtcDTO> getAllUserEtcState() {
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		ArrayList<GraduationEtcDTO> list = null;
		Gson gson = new Gson();
		try {
			QueryRunner q = new QueryRunner();
			listOfMaps = q.query(conn, "SELECT * FROM grdu_etc_state ORDER BY per_id", new MapListHandler());
			list = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GraduationEtcDTO>>() {
			}.getType());

		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		return list;
	}

	// choi 190210
	public ArrayList<GraduationReqStudentsDTO> getAllReqStudents() {
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		ArrayList<GraduationReqStudentsDTO> list = null;
		Gson gson = new Gson();
		try {
			QueryRunner query = new QueryRunner();
			listOfMaps = query.query(conn, "SELECT * FROM grdu_req_students", new MapListHandler());
			list = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GraduationReqStudentsDTO>>() {
			}.getType());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		return list;
	}

	public ArrayList<GraduationReqStudentsDTO> getMyReqStudents(String profname) {
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		ArrayList<GraduationReqStudentsDTO> list = null;
		Gson gson = new Gson();
		try {
			QueryRunner query = new QueryRunner();
			listOfMaps = query.query(conn, "SELECT * FROM grdu_req_students WHERE prof_name=?", new MapListHandler(),
					profname);
			list = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GraduationReqStudentsDTO>>() {
			}.getType());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}

		return list;
	}

	// choi 190210
	public ArrayList<GraduationUserDTO> getMyGrdUser(String profname) {
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		ArrayList<GraduationUserDTO> selectedschedule = null;
		Gson gson = new Gson();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn, "SELECT * FROM grdu_students WHERE prof_name=?", new MapListHandler(),
					profname);
			selectedschedule = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GraduationUserDTO>>() {
			}.getType());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		Date now = new Date();
		for (GraduationUserDTO g : selectedschedule) {
			g.setCurrent_state_string(Level.getLevel(g.getCurrent_state()));
			if (g.getThesis_delay() != null) {
				if (now.compareTo(g.getThesis_delay()) <= 0) { // 연장효과 유효
					if (g.getCurrent() == 5) {
						g.setCurrent_str("제출가능");
					} else {
						g.setCurrent_str(State.getState(g.getCurrent()));
					}
				} else {
					if (g.getCurrent() == 5) {
						g.setCurrent_str("지연");
					} else {
						g.setCurrent_str(State.getState(g.getCurrent()));
					}
				}
			} else {
				if (g.getCurrent() == 5) {
					g.setCurrent_str("지연");
				} else {
					g.setCurrent_str(State.getState(g.getCurrent()));
				}
			}
		}
		return selectedschedule;
	}

	// choi 190210
	public ArrayList<GraduationUserDTO> getAllGrdUser() {
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		ArrayList<GraduationUserDTO> selectedschedule = null;
		Gson gson = new Gson();
		Date now = new Date();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn, "SELECT * FROM grdu_students ORDER BY per_id", new MapListHandler());
			selectedschedule = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GraduationUserDTO>>() {
			}.getType());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		for (GraduationUserDTO g : selectedschedule) {
			g.setCurrent_state_string(Level.getLevel(g.getCurrent_state()));
			if (g.getThesis_delay() != null) {
				if (now.compareTo(g.getThesis_delay()) <= 0) { // 연장효과 유효
					if (g.getCurrent() == 5) {
						g.setCurrent_str("제출가능");
					} else {
						g.setCurrent_str(State.getState(g.getCurrent()));
					}
				} else {
					if (g.getCurrent() == 5) {
						g.setCurrent_str("지연");
					} else {
						g.setCurrent_str(State.getState(g.getCurrent()));
					}
				}
			} else {
				if (g.getCurrent() == 5) {
					g.setCurrent_str("지연");
				} else {
					g.setCurrent_str(State.getState(g.getCurrent()));
				}
			}

		}
		return selectedschedule;
	}

	// choi 190210 관리자가 신청접수 승인하면 grdu_student와 etc_state 등록하고 req_student에서 삭제
	public String req_insertgrduser(String data) {
		String arr[] = data.split("-/-/-");// per_id+"-/-/-"+name+"-/-/-"+date+"-/-/-"+capstone+"-/-/-"+professor+"-/-/-/"+major+"
		int cap = -1;
		int level = 0;
		ArrayList<GraduationScheduleDTO> sche = GraduationTestDAO.getInstance().getSchedule();
		Date dd = new Date();
		int num = 0;
		/*
		 * Date start = sche.get(1).getStarting_date(); Date end =
		 * sche.get(1).getEnd_date(); int ee = dd.compareTo(end); int s =
		 * dd.compareTo(start); if (ee > 0) { num = 5; } else if (ee <= 0 && s >= 0) {
		 * num = 4; } else { num = 3; }
		 */
		num = compareDate(2);
		// capstone구분
		if (arr[3].equals("해당없음")) {
			level = compareDate(6);
			cap = 4;
		} else if (arr[3].equals("이수")) {
			level = compareDate(6);
			cap = 3;
		} else if (arr[3].equals("이수중")) {
			level = compareDate(6);
			cap = 2;
		} else if (arr[3].equals("미이수")) {
			level = 1;
			cap = 1;
		}
		// date구분
		int year = Calendar.getInstance().get(Calendar.YEAR);

		String date = null;
		if (arr[2].contains(Integer.toString(year)))
			date = year + "-08";
		else
			date = (year + 1) + "-02";
		Connection conn = Config.getInstance().sqlLogin();
		List<Map<String, Object>> listOfMaps = null;
		Date today = new Date();
		String nn = dateToString(today);
		try {
			QueryRunner queryRunner = new QueryRunner();// per_id+"-/-/-"+name+"-/-/-"+date+"-/-/-"+capstone+"-/-/-"+professor
			listOfMaps = queryRunner.query(conn, "SELECT * FROM grdu_students WHERE per_id=?;", new MapListHandler(),
					arr[0]);
			if (listOfMaps.size() > 0) {

				queryRunner.update(conn,
						"UPDATE grdu_students SET name=?,prof_name=?,graduation_date=?,current=6, major=? WHERE per_id=?",
						arr[1], arr[4], arr[2], arr[5], arr[0]);
				queryRunner.update(conn,
						"UPDATE grdu_userlog SET log_date=?,user_log=? WHERE per_id=? AND grd_state=1;", nn, 4, arr[0]);
				queryRunner.update(conn, "UPDATE grdu_etc_state SET capstone=? WHERE per_id=?;", arr[3], arr[0]);
			} else {

				queryRunner.update(conn,
						"UPDATE grdu_userlog SET user_log=4,log_date=? WHERE per_id=? AND grd_state=1;", nn, arr[0]);
				queryRunner.update(conn,
						"INSERT grdu_etc_state(per_id,capstone,certi_level_int,confe_level_int,contest_level_int) VALUES(?,?,?,?,?)",
						arr[0], cap, level, level, level);
				queryRunner.update(conn,
						"INSERT grdu_students SET request=7,request_action_date=?,per_id=?,name=?,prof_name=?,graduation_date=?,suggest=?,current=?, major=?",
						nn, arr[0], arr[1], arr[4], arr[2], num, num, arr[5]);
				queryRunner.update(conn, "INSERT grdu_thesis_data SET per_id=?", arr[0]);
				queryRunner.update(conn, "DELETE FROM grdu_req_students WHERE per_id=?", arr[0]);

				// jonghun
				queryRunner.update(conn, "INSERT grdu_certificate_data SET per_id=?", arr[0]);
				queryRunner.update(conn, "INSERT grdu_conference_data SET per_id=?", arr[0]);
				queryRunner.update(conn, "INSERT grdu_contest_data SET per_id=?", arr[0]);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		return arr[0];
	}

	// choi 190209
	public String update_request(String data) {
		String arr[] = data.split("-/-/-");// 0:user.per_id 1:name 2:date 3:anwer 4:major
		Connection conn = Config.getInstance().sqlLogin();
		String selected = "";
		try {
			QueryRunner query = new QueryRunner();
			query.update(conn, "UPDATE grdu_req_students SET graduation_date=?, major=? WHERE per_id=?;", arr[2], arr[4], arr[0]);
			query.update(conn, "UPDATE grdu_userlog SET logetc=? WHERE per_id=? AND grd_state=?;", arr[3], arr[0], 1);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		return selected;
	}

	// choi 190209
	public String req_refuse(String data) {
		String arr[] = data.split("-/-/-");// 0:per_id 1:"신청접수"
		String per_id = arr[0];
		int pid = Integer.parseInt(per_id);
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner que = new QueryRunner();
			que.update(conn, "UPDATE grdu_userlog SET user_log=3 WHERE per_id=? AND grd_state=1", pid);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		return per_id;
	}

	// choi 190209
	public String insert_request(String data) {
		String arr[] = data.split("-/-/-");// 0:user.per_id 1:name 2:date 3:anwer 4:major
		String result = "";
		Connection conn = Config.getInstance().sqlLogin();
		List<Map<String, Object>> check_students = null;
		LocalDate today = LocalDate.now();
		LocalDateTime today1 = LocalDateTime.now();
		Date now = new Date();
		String today3 = dateToString(now);
		int per_id = Integer.parseInt(arr[0]);
		try {
			QueryRunner query = new QueryRunner();
			check_students = query.query(conn, "SELECT * FROM grdu_req_students WHERE per_id=?;", new MapListHandler(),
					arr[0]);
			if (check_students.size() > 0) {
				query.update(conn, "UPDATE grdu_req_students SET graduation_date=? WHERE per_id=?;", arr[2], arr[0]);
				query.update(conn, "UPDATE grdu_userlog SET log_date=?,user_log=? logetc=? WHERE per_id=?;", arr[2], 5,
						arr[3], arr[0]);
				check_students = query.query(conn, "SELECT * FROM grdu_userlog WHERE per_id=? AND grd_state=1",
						new MapListHandler(), arr[0]);
				if (check_students.size() < 1) {
					query.update(conn, "INSERT grdu_userlog SET per_id=?,grd_state=?,user_log=?,logetc=?,log_date=?",
							arr[0], 1, 5, arr[3], now);
				}
			} else {
				if (query.query(conn, "SELECT * FROM grdu_students WHERE per_id=?;", new MapListHandler(), arr[0])
						.size() > 0) {
					query.update(conn,
							"UPDATE grdu_students SET current_state=?,graduation_date=?,current=6 WHERE per_id=?", 1,
							arr[2], arr[0]);
				} else {

					query.update(conn, "INSERT grdu_req_students SET per_id=?,name=?,graduation_date=?, major=?;", arr[0],
							arr[1], arr[2], arr[4]);

					query.update(conn, "INSERT grdu_userlog SET per_id=?,grd_state=?,user_log=?,logetc=?,log_date=?;",
							per_id, 1, 5, arr[3], today3);

				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		return result;
	}

	// choi 190209
	public GraduationUserDTO getUser(int per_id) {
		Gson gson = new Gson();
		Connection conn = Config.getInstance().sqlLogin();
		List<Map<String, Object>> listOfMaps = null;
		ArrayList<GraduationUserDTO> list = null;
		try {
			QueryRunner query = new QueryRunner();
			listOfMaps = query.query(conn, "SELECT * FROM grdu_students WHERE per_id=?;", new MapListHandler(), per_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		list = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GraduationUserDTO>>() {
		}.getType());
		if (list.size() > 0) {
			return list.get(0);
		} else
			return null;
	}

	// choi 190209
	public GraduationLogDTO getUserLog(int per_id, int grd_state) {
		Gson gson = new Gson();
		Connection conn = Config.getInstance().sqlLogin();
		List<Map<String, Object>> listOfMaps = null;
		ArrayList<GraduationLogDTO> list = null;
		try {
			QueryRunner q = new QueryRunner();
			listOfMaps = q.query(conn, "SELECT * FROM grdu_userlog WHERE per_id=? AND grd_state=?;",
					new MapListHandler(), per_id, grd_state);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		list = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GraduationLogDTO>>() {
		}.getType());
		if (list.size() > 0) {
			return list.get(0);
		} else
			return null;
	}

	// choi 190209
	public String getAllProfessor() {
		List<String> profname = null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			profname = queryRunner.query(conn, "SELECT name FROM user WHERE type=?", new ColumnListHandler<String>(),
					"교수1");
		} catch (SQLException se) {
			se.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}

		return new Gson().toJson(profname);
	}

	// 졸업신청자 학번 받아서 리턴 choi190209
	public GraduationReqStudentsDTO getReqStudent(int per_id) {
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		ArrayList<GraduationReqStudentsDTO> student = null;
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn, "SELECT * FROM grdu_req_students WHERE per_id=?", new MapListHandler(),
					per_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		student = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GraduationReqStudentsDTO>>() {
		}.getType());

		if (student.size() > 0) {

			return student.get(0);
		} else {

			return null;
		}
	}

	// choi190209
	public GraduationScheduleDTO getReqSchedule() {
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		ArrayList<GraduationScheduleDTO> schedule = null;
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn,
					"SELECT schedule_name_int,starting_date,end_date FROM grdu_schedule WHERE schedule_name_int=1;",
					new MapListHandler());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		schedule = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GraduationScheduleDTO>>() {
		}.getType());
		schedule.get(0).setSchedule_name(Level.getLevel(schedule.get(0).getSchedule_name_int()));
		schedule.get(0).setStarting_date_str(dateToString(schedule.get(0).getStarting_date()));
		schedule.get(0).setEnd_date_str(endDateToString(schedule.get(0).getEnd_date()));
		return schedule.get(0);
	}

	// choi190209
	public ArrayList<GraduationScheduleDTO> getSchedule() {
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		ArrayList<GraduationScheduleDTO> schedule = null;
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn,
					"SELECT schedule_name_int,starting_date,end_date FROM grdu_schedule WHERE schedule_name_int<7",
					new MapListHandler());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		schedule = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GraduationScheduleDTO>>() {
		}.getType());
		for (GraduationScheduleDTO g : schedule) {
			g.setSchedule_name(Level.getLevel(g.getSchedule_name_int()));
			g.setStarting_date_str(dateToString(g.getStarting_date()));
			g.setEnd_date_str(endDateToString(g.getEnd_date()));
		}
		return schedule;
	}

	// choi190209
	public GraduationUserDTO getGrdUser(int per_id) {
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();

			listOfMaps = queryRunner.query(conn,
					"SELECT gs.per_id,gs.graduation_date,gs.prof_name,gs.name,gs.major,gs.delay_count,gs.current,gs.current_state,ge.capstone FROM grdu_students gs,grdu_etc_state ge where gs.per_id=?;",
					new MapListHandler(), per_id);

		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		ArrayList<GraduationUserDTO> students = gson.fromJson(gson.toJson(listOfMaps),
				new TypeToken<List<GraduationUserDTO>>() {
				}.getType());

		// ge.captone으로 받은거 etc_accept로 바꿔

		if (students.size() > 0) {

			return students.get(0);
		} else {

			return null;
		}
	}

	// choi190209
	public GraduationEtcDTO getEtc(int per_id) {
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		ArrayList<GraduationEtcDTO> list = null;

		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn,
					"SELECT schedule_name_int,starting_date,end_date,certificate_submit,contest_submit,conference_submit,certi_date,contest_date,confe_date,certi_level_int,contest_level_int,confe_level_int,capstone FROM grdu_schedule,grdu_etc_state  WHERE per_id=? and schedule_id>5;",
					new MapListHandler(), per_id);

		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		list = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GraduationEtcDTO>>() {
		}.getType());

		String note;
		int certi = 1;
		int contest = 1;
		int confe = 1;
		for (GraduationEtcDTO g : list) {
			g.setSchedule_name(Level.getLevel(g.getSchedule_name_int()));
			certi = g.getCerti_level_int();
			contest = g.getContest_level_int();
			confe = g.getConfe_level_int();
			if (certi == 6 || certi == 7) {
				g.setNote(dateToString(g.getCerti_date()) + "(" + State.getState(certi) + ")");
			} else {
				g.setNote("(" + State.getState(certi) + ")");
			}
			if (contest == 6 || contest == 7) {
				g.setNote(dateToString(g.getContest_date()) + "(" + State.getState(contest) + ")");
			} else {
				g.setNote("(" + State.getState(contest) + ")");
			}
			if (confe == 6 || contest == 7) {
				g.setNote(dateToString(g.getConfe_date()) + "(" + State.getState(g.getConfe_level_int()) + ")");
			} else {
				g.setNote("(" + State.getState(confe) + ")");
			}
			g.setStarting_date_str(dateToString(g.getStarting_date()));
			g.setEnd_date_str(endDateToString(g.getEnd_date()));
			int cap = g.getCapstone();
			GraduationUserDTO gu = GraduationTestDAO.getInstance().getUser(per_id);
			g.setState_enum(makeEtc_Accept(certi, contest, confe, gu.getThesis_delay()));

			if (cap == 2 || cap == 3 || cap == 4) { // 기타자격 제출 가능 상태
				g.setLevel_num(makeEtc_Accept(g.getCerti_level_int(), g.getConfe_level_int(), g.getContest_level_int(),
						gu.getThesis_delay()));
			}
		}

		return list.get(0);
	}

	// choi190209
	public ArrayList<GraduationStateListDTO> getGrduStateList(int per_id, int who) {
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		ArrayList<GraduationStateListDTO> list = null;
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn,
					"SELECT schedule_name_int,starting_date,end_date,request,request_action_date,suggest,suggest_action_date,interim,interim_action_date,fin,final_action_date,thesis_delay FROM grdu_schedule gs,grdu_students gt WHERE per_id=? and schedule_id<5;",
					new MapListHandler(), per_id);

		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		// 여기서 각단계 버튼과 링크 생성
		Gson gson = new Gson();
		list = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GraduationStateListDTO>>() {
		}.getType());

		int r = list.get(0).getRequest();
		int s = list.get(0).getSuggest();
		int m = list.get(0).getInterim();
		int f = list.get(0).getFin();
		Date temp = list.get(0).getThesis_delay();
		Date now = new Date();
		int nd = 0;
		if (temp != null)
			nd = now.compareTo(temp);
		for (GraduationStateListDTO g : list) {
			g.setSchedule_name(Level.getLevel(g.getSchedule_name_int()));
			g.setStarting_date_str(dateToString(g.getStarting_date()));
			g.setEnd_date_str(endDateToString(g.getEnd_date()));
		}
		// 버튼 이름 1=학생 2=교수,관리자
		if (who == 1) {
			list.get(0).setBtn_name(State.getButtonName(makeStateEnum(temp, r,0)));
			list.get(1).setBtn_name(State.getButtonName(makeStateEnum(temp, s,1)));
			list.get(2).setBtn_name(State.getButtonName(makeStateEnum(temp, m,2)));
			list.get(3).setBtn_name(State.getButtonName(makeStateEnum(temp, f,3)));
		} else {
			list.get(0).setBtn_name(AdminButton.getButtonName(makeStateEnum(temp, r,0)));
			list.get(1).setBtn_name(AdminButton.getButtonName(makeStateEnum(temp, s,1)));
			list.get(2).setBtn_name(AdminButton.getButtonName(makeStateEnum(temp, m,2)));
			list.get(3).setBtn_name(AdminButton.getButtonName(makeStateEnum(temp, f,3)));
		}

		// 비고 이름

		if (r == 6 || r == 7) {
			list.get(0).setNote(dateToString(list.get(0).getRequest_action_date()) + "(" + State.getState(r) + ")");
		} else if (r == 5) {
			if (temp == null) {
				list.get(0).setNote("(" + State.getState(r) + ")");
			} else {
				Calendar cal = Calendar.getInstance();
				cal.setTime(temp);
				cal.add(cal.DATE, -1);
				temp = new Date(cal.getTimeInMillis());
				list.get(0).setNote(dateToString(temp) + "(연장)");
			}
		} else {
			list.get(0).setNote("(" + State.getState(r) + ")");
		}
		if (s == 6 || s == 7) {
			list.get(1).setNote(dateToString(list.get(0).getSuggest_action_date()) + "(" + State.getState(s) + ")");
		} else if (s == 5) {
			if (temp == null) {
				list.get(1).setNote("(" + State.getState(s) + ")");
			} else {
				Calendar cal = Calendar.getInstance();
				cal.setTime(temp);
				cal.add(cal.DATE, -1);
				temp = new Date(cal.getTimeInMillis());
				list.get(1).setNote(dateToString(temp) + "(" + "(연장)");
			}
		} else {
			list.get(1).setNote("(" + State.getState(s) + ")");
		}
		if (m == 6 || m == 7) {
			list.get(2).setNote(dateToString(list.get(0).getInterim_action_date()) + "(" + State.getState(m) + ")");
		} else if (m == 5) {
			if (temp == null) {
				list.get(2).setNote("(" + State.getState(m) + ")");
			} else {
				Calendar cal = Calendar.getInstance();
				cal.setTime(temp);
				cal.add(cal.DATE, -1);
				temp = new Date(cal.getTimeInMillis());
				list.get(2).setNote(dateToString(temp) + "(연장)");
			}
		} else {
			list.get(2).setNote("(" + State.getState(m) + ")");
		}
		if (f == 6 || f == 7) {
			list.get(3).setNote(dateToString(list.get(0).getFinal_action_date()) + "(" + State.getState(f) + ")");
		} else if (f == 5) {
			if (temp == null) {
				list.get(3).setNote("(" + State.getState(f) + ")");
			} else {
				Calendar cal = Calendar.getInstance();
				cal.setTime(temp);
				cal.add(cal.DATE, -1);
				temp = new Date(cal.getTimeInMillis());
				list.get(3).setNote(dateToString(temp) + "(연장)");
			}
		} else {
			list.get(3).setNote("(" + State.getState(f) + ")");
		}

		// state_enum
		Date temp2 = list.get(0).getThesis_delay();
		list.get(0).setState_enum(makeStateEnum(temp2, r,0));
		list.get(1).setState_enum(makeStateEnum(temp2, s,1));
		list.get(2).setState_enum(makeStateEnum(temp2, m,2));
		list.get(3).setState_enum(makeStateEnum(temp2, f,3));

		// action_date
		list.get(0).setAction_date(list.get(0).getRequest_action_date());
		list.get(1).setAction_date(list.get(0).getSuggest_action_date());
		list.get(2).setAction_date(list.get(0).getInterim_action_date());
		list.get(3).setAction_date(list.get(0).getFinal_action_date());

		return list;

	}

	// choi190209
	public ArrayList<GraduationLogDTO> getGrdLog(int per_id) {
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();

		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn,
					"SELECT log_date,grd_state,user_log,logetc FROM grdu_userlog where per_id=? ORDER BY id desc;",
					new MapListHandler(), per_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		ArrayList<GraduationLogDTO> log = gson.fromJson(gson.toJson(listOfMaps),
				new TypeToken<List<GraduationLogDTO>>() {
				}.getType());

		for (GraduationLogDTO g : log) {
			g.setContent(Log.getAction(g.getUser_log()));
			g.setDate(dateToString(g.getLog_date()));
			g.setState(Level.getLevel(g.getGrd_state()));

		}
		return log;
	}

	// choi190209
	public static String dateToString(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(date);
	}

	// choi190209
	public static String endDateToString(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");
		return sdf.format(date);
	}

	// choi190219
	public ArrayList<GraduationScheduleDTO> getScheduleList() {
		ArrayList<GraduationScheduleDTO> result = null;
		List<Map<String, Object>> list = null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner que = new QueryRunner();
			list = que.query(conn, "SELECT * FROM grdu_schedule WHERE schedule_id<7;", new MapListHandler());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		result = gson.fromJson(gson.toJson(list), new TypeToken<List<GraduationScheduleDTO>>() {
		}.getType());
		Date today = new Date();
		int s, e;
		for (GraduationScheduleDTO g : result) {
			g.setSchedule_name(Level.getLevel(g.getSchedule_name_int()));
			g.setStarting_date_str(dateToString(g.getStarting_date()));
			g.setEnd_date_str(endDateToString(g.getEnd_date()));
			s = today.compareTo(g.getStarting_date());
			e = today.compareTo(g.getEnd_date());
			if (e > 0) {
				g.setGrd_state("마감");
			} else if (e <= 0 && s >= 0) {
				g.setGrd_state("진행중");
			} else {
				g.setGrd_state("대기");
			}

		}
		return result;
	}

	// choi190219
	public String modifyContent(String data) {

		String arr[] = data.split("-/-/-"); // 0 content 1 schedulename
		int level = Level.getLevelInt(arr[0]);
		Connection conn = Config.getInstance().sqlLogin();
		List<String> result = null;
		try {
			QueryRunner que = new QueryRunner();
			que.update(conn, "UPDATE grdu_schedule SET schedule_contents=? WHERE schedule_name_int=?;", arr[1], level);
			result = que.query(conn, "SELECT schedule_contents FROM grdu_schedule WHERE schedule_name_int=?",
					new ColumnListHandler<String>(), level);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}

		return result.get(0);
	}

	// choi190827
	public String changeSchedule(String data) throws ParseException {
		String arr[] = data.split("-/-/-");// 0=name 1=start 2=close
		Connection conn = Config.getInstance().sqlLogin();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate start = null;
		LocalDate end = null;
		try {
			start = LocalDate.parse(arr[1], formatter);
			end = LocalDate.parse(arr[2], formatter);
		} catch (Exception e) {
			e.printStackTrace();
		}

		int level = Level.getLevelInt(arr[0]);

		try {
			QueryRunner que = new QueryRunner();
			que.update(conn, "UPDATE grdu_schedule SET starting_date=?,end_date=? WHERE schedule_name_int=?", start,
					end, level);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date today = new Date();

		try {
			GraduationQuartzMain graduationQuartzMain=GraduationQuartzMain.getInstance();
			graduationQuartzMain.offTimer();
			graduationQuartzMain.timeraction(sdf.format(today));
		}catch (Exception e){
			e.printStackTrace();
		}
		return arr[0];
	}

	// choi190219 관리자가 직접 추가
	public String insertgrduser(String data) {
		String arr[] = data.split("-/-/-");// per_id+"-/-/-"+name+"-/-/-"+date+"-/-/-"+capstone+"-/-/-"+professor+"-/-/-"+major
		Gson gson = new Gson();
		Connection conn = Config.getInstance().sqlLogin();
		QueryRunner que = new QueryRunner();
		Date now = new Date();
		String day = dateToString(now);
		int cap = -1;
		int level = 4;

		if (arr[3].equals("해당없음")) {
			level = compareDate(6);
			cap = 4;
		} else if (arr[3].equals("이수")) {
			level = compareDate(6);
			cap = 3;
		} else if (arr[3].equals("이수중")) {
			level = compareDate(6);
			cap = 2;
		} else if (arr[3].equals("미이수")) {
			level = 1;
			cap = 1;
		}

		// ArrayList<GraduationScheduleDTO> sche =
		// GraduationTestDAO.getInstance().getSchedule();
		// Date dd = new Date();
		int num = 0;
		/*
		 * Date start = sche.get(1).getStarting_date(); Date end =
		 * sche.get(1).getEnd_date(); int ee = dd.compareTo(end); int s =
		 * dd.compareTo(start); if (ee > 0) { num = 5; } else if (ee <= 0 && s >= 0) {
		 * num = 4; } else { num = 3; }
		 */
		num = compareDate(2);

		String etc = "자격증/";
		try {
			int per_id = Integer.parseInt(arr[0]);
			String name = arr[1];
			String prof_name = arr[4];
			String graduation_date = arr[2];
			String major = arr[5];
			que.update(conn,
					"INSERT grdu_students SET per_id=?,name=?,prof_name=?,graduation_date=?,suggest=?,current=?,major=?",
					per_id, name, prof_name, graduation_date, num, num, major);
			que.update(conn,
					"INSERT grdu_etc_state SET per_id=?,capstone=?,certi_level_int=?,contest_level_int=?,confe_level_int=?",
					per_id, cap, level, level, level);
			que.update(conn, "INSERT grdu_thesis_data SET per_id=?", per_id);
			que.update(conn, "INSERT grdu_userlog SET per_id=?,log_date=?,grd_state=1,user_log=4,logetc=?", per_id, day,
					etc);
			que.update(conn, "INSERT grdu_certificate_data SET per_id=?", per_id);
			que.update(conn, "INSERT grdu_conference_data SET per_id=?", per_id);
			que.update(conn, "INSERT grdu_contest_data SET per_id=?", per_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		return arr[0];
	}
	
	// jonghun 관리자가 직접 한명 추가
		public String insertgrduser_req(String data) {
			String arr[] = data.split("-/-/-");// per_id+"-/-/-"+name+"-/-/-"+date
			Gson gson = new Gson();
			Connection conn = Config.getInstance().sqlLogin();
			Date now = new Date();
			String day = dateToString(now);
			QueryRunner queryRunner = new QueryRunner();

			try {
				queryRunner.update(conn,
						"INSERT INTO grdu_req_students(per_id, name, prof_name, capstone, graduation_date, major) VALUES(?,?,?,?,?,?)",
						arr[0], arr[1], "미정", 0, arr[2], arr[3]);
				queryRunner.update(conn, "INSERT grdu_userlog SET per_id=?,grd_state=?,user_log=?,logetc=?,log_date=?;",
						arr[0], 1, 5, 5, day);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {
				DbUtils.closeQuietly(conn);
			}
			return arr[0];
		}

	// choi190219
	public String deletegrd_req_user(String data) {// 0220추가된메소드
		String arr[] = data.split("-/-/-");

		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			for (int i = 0; i < arr.length; i++) {
				queryRunner.update(conn, "DELETE FROM grdu_req_students WHERE per_id=?", arr[i]);
				queryRunner.update(conn, "DELETE FROM grdu_userlog WHERE per_id=?", arr[i]);
			}
		} catch (SQLException se) {
			se.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		return Integer.toString(arr.length);
	}

	// choi190219 여기서 기존에 제출한 파일 제거하는거 만들어야 한다.
	public String deletegrduser(String data, HttpServletRequest request) {
		String arr[] = data.split("-/-/-");
		// String
		// path=request.getSession().getServletContext().getRealPath("/uploadFile/graduation");
		Connection conn = Config.getInstance().sqlLogin();

		try {
			QueryRunner queryRunner = new QueryRunner();
			for (int i = 0; i < arr.length; i++) {
				// ArrayList<NoticeFileBean> list=getFilesForDelete(arr[i]);
				// if(list.size()>0) {
				// for(int j=0;j<list.size();j++) {
				// String fileName = list.get(i).filelink;
				// File deleteFile = new File(path,fileName);
				// deleteFile.delete();
				// }
				// }

				queryRunner.update(conn, "DELETE FROM grdu_students WHERE per_id=?", arr[i]);
				queryRunner.update(conn, "DELETE FROM grdu_etc_state WHERE per_id=?", arr[i]);
				queryRunner.update(conn, "DELETE FROM grdu_thesis_data WHERE per_id=?", arr[i]);
				queryRunner.update(conn, "DELETE FROM grdu_userlog WHERE per_id=?", arr[i]);
				queryRunner.update(conn, "DELETE FROM grdu_certificate_data WHERE per_id=?", arr[i]);
				queryRunner.update(conn, "DELETE FROM grdu_contest_data WHERE per_id=?", arr[i]);
				queryRunner.update(conn, "DELETE FROM grdu_conference_data WHERE per_id=?", arr[i]);
			}
		} catch (Exception se) {
			se.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		return Integer.toString(arr.length);
	}

	// jonghun
	public String getEtcFileName(int key, int per_id) { // key=1 자격증 key=2 학술대회1(논문파일) key=3 학술대회2(증명 파일) key=4
														// 공모전1(상장사본) key=5 공모전2(추가자료)
		Connection conn = Config.getInstance().sqlLogin();
		Gson gson = new Gson();
		List<String> temp = null;
		QueryRunner que = new QueryRunner();
		try {
			if (key == 1) {
				temp = que.query(conn, "SELECT cer_filename FROM grdu_certificate_data WHERE per_id=?",
						new ColumnListHandler<String>(), per_id);
			}

			else if (key == 2) {
				temp = que.query(conn, "SELECT thesis_filename FROM grdu_conference_data WHERE per_id=?",
						new ColumnListHandler<String>(), per_id);
			}

			else if (key == 3) {
				temp = que.query(conn, "SELECT proof_filename FROM grdu_conference_data WHERE per_id=?",
						new ColumnListHandler<String>(), per_id);
			}

			else if (key == 4) {
				temp = que.query(conn, "SELECT award_filename FROM grdu_contest_data WHERE per_id=?",
						new ColumnListHandler<String>(), per_id);
			}

			else if (key == 5) {
				temp = que.query(conn, "SELECT add_filename FROM grdu_contest_data WHERE per_id=?",
						new ColumnListHandler<String>(), per_id);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		if (temp.size() > 0) {
			String result = gson.toJson(temp);
			return result;
		} else
			return null;
	}

	// jonghun
	public GraduationCertificateDataDTO getCertiData(int per_id) {
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();

			listOfMaps = queryRunner.query(conn,
					"SELECT per_id, requirement, cer_id, organization, acq_date, cer_filename, file_path from grdu_certificate_data where per_id=?;",
					new MapListHandler(), per_id);

		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		ArrayList<GraduationCertificateDataDTO> certificate = gson.fromJson(gson.toJson(listOfMaps),
				new TypeToken<List<GraduationCertificateDataDTO>>() {
				}.getType());

		if (certificate.size() > 0) {

			return certificate.get(0);
		} else {

			return null;
		}
	}

	// jonghun
	public String delete_certificate(int per_id) {
		Connection conn = Config.getInstance().sqlLogin();
		
		Date temp = new Date();
		String now = dateToString(temp);

		/*
		 * PreparedStatement ppst = null; String selected = "";
		 */

		try {
			QueryRunner queryRunner = new QueryRunner();
			queryRunner.update(conn, "DELETE FROM grdu_certificate_data WHERE per_id=?", per_id);
			queryRunner.update(conn, "insert grdu_certificate_data set per_id = ?", per_id);
			queryRunner.update(conn, "update grdu_etc_state set certificate_submit = ?, certi_level_int = ?", 0, 4);
			// 로그
			queryRunner.update(conn, "INSERT grdu_userlog SET per_id=?,log_date=?,grd_state=?,user_log=?;", per_id, now, 7, 9);
			/*
			 * ppst =
			 * conn.prepareStatement("delete from grdu_certificate_data where per_id = ?");
			 * ppst.setInt(1, per_id);
			 * 
			 * ppst = conn.prepareStatement("insert grdu_certificate_data set per_id = ?");
			 * ppst.setInt(1, per_id);
			 * 
			 * ppst = conn.prepareStatement(
			 * "update grdu_certificate_data set certificate_submit = ?, certi_level_int = ? WHERE per_id=?"
			 * ); ppst.setInt(1, 0); ppst.setInt(2, 4);
			 */
		}

		catch (Exception e) {
			e.printStackTrace();
		}

		finally {
			DbUtils.closeQuietly(conn);
		}

		return null;
	}

	// jonghun(0224)
	public static int makeEtc_Accept(int certi, int confe, int contest, Date delay) {
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat();
		String nowStr = sdf.format(now);
		int result = 0;
		int max = 0;

		if (delay == null) {
			if (certi >= confe)
				max = certi;
			else
				max = confe;

			if (max < contest)
				max = contest;

			result = max;
		} else {
			String delayStr = sdf.format(delay);
			int n = nowStr.compareTo(delayStr);
			if (n > 0) {
				if (certi >= confe)
					max = certi;
				else
					max = confe;

				if (max < contest)
					max = contest;

				result = max;
			} else {
				if (certi == 5 && confe == 5 && contest == 5) {
					result = 4;
				} else {
					if (certi >= confe)
						max = certi;
					else
						max = confe;

					if (max < contest)
						max = contest;

					result = max;
				}
			}
		}

		return result;
	}

	public static int makeStateEnum(Date delay, int state,int stage) {
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		//statg=1제안
		Date stageDate = GraduationTestDAO.getInstance().getSchedule().get(stage).getStarting_date();
		Date stageDateEnd = GraduationTestDAO.getInstance().getSchedule().get(stage).getEnd_date();

		String nowstr = sdf.format(now);
		String startStr=sdf.format(stageDate);
		String endStr=sdf.format(stageDateEnd);
		int result = state;
		if (delay == null) { // 연장 날짜가 없을때

			result = state;
		} else { // 연장 날짜가 있을때
			String delaystr = sdf.format(delay);
			int nd = nowstr.compareTo(delaystr);
			if (nd > 0) { // 연장 날짜 이후이다 -> 연장 효과가 없어진것

				result = state;
			} else if (nd <= 0) { // 연장 날짜 이전이나 같은 날이다 -> 연장 효과가 남아있는것
				if (state == 5) {
					////if(nowstr.compareTo(startStr)<0) {
					//	result=3;
					//}
					//else {
					//	result = 4;
					//}
					result=4;
				} else {
					result = state;
				}

			}
		}

		return result;
	}

	// 엑셀용임
	// jong hun (insertgrduser)
	public String insertgrduser(JsonArray grdArray) throws SQLException {// 02.20
		List<Map<String, Object>> idmap = null; // 졸업대상자 DB 중복 조회
		List<Map<String, Object>> userlist = null; // 유저 DB 유무 조회
		Gson gson = new Gson();
		Connection conn = Config.getInstance().sqlLogin();
		List<String> notuser = new ArrayList<>();// 수정 <List<Map<String,Object>>
		int modify = 0;
		int insert = 0;
		Date now3 = new Date();
		String day = dateToString(now3);
		// 날짜
		LocalDate today = LocalDate.now();
		LocalDateTime today1 = LocalDateTime.now();
		Date now1 = new Date();
		String today3 = dateToString(now1);

		try {
			QueryRunner queryRunner = new QueryRunner();
			idmap = queryRunner.query(conn, "SELECT * FROM grdu_students", new MapListHandler()); // 졸업대상자 DB 중복 조회
			userlist = queryRunner.query(conn, "SELECT * FROM user", new MapListHandler()); // 유저 DB 유무 조회
			ArrayList<GrdUserBean> selected = gson.fromJson(gson.toJson(idmap), new TypeToken<List<GrdUserBean>>() {
			}.getType()); // 졸업대상자 DB 중복 조회
			ArrayList<UserBean> userlist2 = gson.fromJson(gson.toJson(userlist), new TypeToken<List<UserBean>>() {
			}.getType()); // 유저 DB 유무 조회
			boolean tf = false;
			boolean exist = false;

			for (int i = 0; i < grdArray.size(); i++) {
				int cap = -1;
				JsonElement user1 = grdArray.get(i); // json으로 받은 신청자 리스트
				GraduationUserDTO user = gson.fromJson(user1, GraduationUserDTO.class); // user는 gson으로 넘겨받은 정보임
				// GrdUserBean user=gson.fromJson(user1, GrdUserBean.class);
				JsonObject user2 = user1.getAsJsonObject();

				String per_id = Integer.toString(user.getPer_id());
				String name = user.getName();
				String major = user.getMajor();
				String graduation_date = user.getGraduation_date();
				String prof_name = user.getProf_name();
				// jonghun 0308
				String capstone_str = user.getCapstone_str();

				// 실제 존재하는 유저인지 확인
				for (int j = 0; j < userlist2.size(); j++) {
					if (userlist2.get(j).per_id.equals(per_id) && userlist2.get(j).name.equals(name)) {
						exist = true;
						break;
					}
				}

				if (exist == false) {
					notuser.add(name + "[" + per_id + "]");
					continue;
				}
				exist = false;

				if (graduation_date == null) {
					LocalDateTime now = LocalDateTime.now();
					int year = now.getYear();
					graduation_date = Integer.toString(year + 1) + "-02";
				}

				// jonghun 졸업대상자에 맞게 query 수정(0308)
				// 이미 있는 유저인지 확인(존재하는 유저인 경우)
				int num = 0;
				num = compareDate(2);
				String etc = "자격증/";
				int level = 4;

				// jonghun 0308
				if (capstone_str.equals("해당없음")) {
					level = compareDate(6);
					cap = 4;
				} else if (capstone_str.equals("이수")) {
					level = compareDate(6);
					cap = 3;
				} else if (capstone_str.equals("이수중")) {
					level = compareDate(6);
					cap = 2;
				} else if (capstone_str.equals("미이수")) {
					level = 1;
					cap = 1;
				}

				//selected(졸업대상자로 등록된 유저)는 엑셀에 있는게 기존에 있는 유저인지 확인함
				for (int j = 0; j < selected.size(); j++) {
					String id = selected.get(j).per_id;
					if (id.equals(per_id)) {
						/*
						 * queryRunner.update(conn,
						 * "UPDATE grdu_students SET per_id=?, name=?, prof_name=?, capstone=?, graduation_date=?, major=? WHERE per_id=?"
						 * , per_id, name, prof_name, 0, graduation_date, major);
						 * queryRunner.update(conn,
						 * "INSERT grdu_userlog SET per_id=?,grd_state=?,user_log=?,logetc=?,log_date=?;"
						 * , per_id, 1, 5, 5, today3);
						 */

						//기존거는 이미 있는 사람을 넣었을때는 수정하게 되있었음(수정된거는 그냥 중복됬다고 말하고 아무것도 안하게 변경함.) 090310
						/*
						queryRunner.update(conn,
								"INSERT grdu_students SET per_id=?,name=?,prof_name=?,graduation_date=?,suggest=?,current=?",
								per_id, name, prof_name, graduation_date, num, num);
						queryRunner.update(conn,
								"INSERT grdu_etc_state SET per_id=?,capstone=?,certi_level_int=?,contest_level_int=?,confe_level_int=?",
								per_id, cap, level, level, level);
						queryRunner.update(conn, "INSERT grdu_thesis_data SET per_id=?", per_id);
						queryRunner.update(conn,
								"INSERT grdu_userlog SET per_id=?,log_date=?,grd_state=1,user_log=4,logetc=?", per_id,
								day, etc);
						queryRunner.update(conn, "INSERT grdu_certificate_data SET per_id=?", per_id);
						queryRunner.update(conn, "INSERT grdu_conference_data SET per_id=?", per_id);
						queryRunner.update(conn, "INSERT grdu_contest_data SET per_id=?", per_id);
						*/
						modify++;
						tf = true;
						break;
					}
				}
				if (tf == true) {
					tf = false;
					cap = -1;
					continue;
				}

				// 이미 있는 유저인지 확인(존재하지 않는 유저인 경우)
				queryRunner.update(conn,
						"INSERT grdu_students SET per_id=?,name=?,prof_name=?,graduation_date=?,suggest=?,current=?",
						per_id, name, prof_name, graduation_date, num, num);
				queryRunner.update(conn,
						"INSERT grdu_etc_state SET per_id=?,capstone=?,certi_level_int=?,contest_level_int=?,confe_level_int=?",
						per_id, cap, level, level, level);
				queryRunner.update(conn, "INSERT grdu_thesis_data SET per_id=?", per_id);
				queryRunner.update(conn, "INSERT grdu_userlog SET per_id=?,log_date=?,grd_state=1,user_log=4,logetc=?",
						per_id, day, etc);
				queryRunner.update(conn, "INSERT grdu_certificate_data SET per_id=?", per_id);
				queryRunner.update(conn, "INSERT grdu_conference_data SET per_id=?", per_id);
				queryRunner.update(conn, "INSERT grdu_contest_data SET per_id=?", per_id);

				insert++;

				cap = -1;
			}
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.close(conn);
		}
		notuser.add(Integer.toString(modify));
		notuser.add(Integer.toString(insert));
		return gson.toJson(notuser);
	}

	// 엑셀용임
	// jong hun (insertgrduser)
	public String insertgrduser_req(JsonArray grdArray) throws SQLException {// 02.20
		List<Map<String, Object>> idmap = null; // 졸업대상자 DB 중복 조회
		List<Map<String, Object>> userlist = null; // 유저 DB 유무 조회
		Gson gson = new Gson();
		Connection conn = Config.getInstance().sqlLogin();
		List<String> notuser = new ArrayList<>();// 수정 <List<Map<String,Object>>
		int modify = 0;
		int insert = 0;

		// 날짜
		LocalDate today = LocalDate.now();
		LocalDateTime today1 = LocalDateTime.now();
		Date now1 = new Date();
		String today3 = dateToString(now1);

		try {
			QueryRunner queryRunner = new QueryRunner();
			idmap = queryRunner.query(conn, "SELECT * FROM grdu_students", new MapListHandler()); // 졸업대상자 DB 중복 조회
			userlist = queryRunner.query(conn, "SELECT * FROM user", new MapListHandler()); // 유저 DB 유무 조회
			ArrayList<GrdUserBean> selected = gson.fromJson(gson.toJson(idmap), new TypeToken<List<GrdUserBean>>() {
			}.getType()); // 졸업대상자 DB 중복 조회
			ArrayList<UserBean> userlist2 = gson.fromJson(gson.toJson(userlist), new TypeToken<List<UserBean>>() {
			}.getType()); // 유저 DB 유무 조회
			boolean tf = false;
			boolean exist = false;

			for (int i = 0; i < grdArray.size(); i++) {
				int cap = -1;
				JsonElement user1 = grdArray.get(i); // json으로 받은 신청자 리스트
				GraduationUserDTO user = gson.fromJson(user1, GraduationUserDTO.class); // user는 gson으로 넘겨받은 정보임
				// GrdUserBean user=gson.fromJson(user1, GrdUserBean.class);
				JsonObject user2 = user1.getAsJsonObject();

				String per_id = Integer.toString(user.getPer_id());
				String name = user.getName();
				String major = user.getMajor();

				// 실제 존재하는 유저인지 확인
				for (int j = 0; j < userlist2.size(); j++) {
					if (userlist2.get(j).per_id.equals(per_id) && userlist2.get(j).name.equals(name)) {
						exist = true;
						break;
					}
				}

				if (exist == false) {
					notuser.add(name + "[" + per_id + "]");
					continue;
				}
				exist = false;

				String graduation_date = user.getGraduation_date();

				if (graduation_date == null) {
					LocalDateTime now = LocalDateTime.now();
					int year = now.getYear();
					graduation_date = Integer.toString(year + 1) + "-02";
				}

				// 이미 있는 유저인지 확인(존재하는 유저인 경우)
				for (int j = 0; j < selected.size(); j++) {
					String id = selected.get(j).per_id;
					if (id.equals(per_id)) {
						/*
						queryRunner.update(conn,
								"UPDATE grdu_req_students SET per_id=?, name=?, prof_name=?, capstone=?, graduation_date=?, major=? WHERE per_id=?",
								per_id, name, "미정", 0, graduation_date, major);
						queryRunner.update(conn,
								"INSERT grdu_userlog SET per_id=?,grd_state=?,user_log=?,logetc=?,log_date=?;", per_id,
								1, 5, 5, today3);
						*/
						modify++;
						tf = true;
						break;
					}
				}
				if (tf == true) {
					tf = false;
					cap = -1;
					continue;
				}

				// 이미 있는 유저인지 확인(존재하지 않는 유저인 경우)
				queryRunner.update(conn,
						"INSERT INTO grdu_req_students(per_id, name, prof_name, capstone, graduation_date, major) VALUES(?,?,?,?,?,?)",
						per_id, name, "미정", 0, graduation_date, major);
				queryRunner.update(conn, "INSERT grdu_userlog SET per_id=?,grd_state=?,user_log=?,logetc=?,log_date=?;",
						per_id, 1, 5, 5, today3);
				insert++;

				cap = -1;
			}
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.close(conn);
		}
		notuser.add(Integer.toString(modify));
		notuser.add(Integer.toString(insert));
		return gson.toJson(notuser);
	}

	// jonghun
	public GraduationContestDataDTO getConteData(int per_id) {
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();

			listOfMaps = queryRunner.query(conn,
					"SELECT per_id, contest_name, team_type, contest_content, organization, award_date, open_date, award_filename, file_path, add_filename from grdu_contest_data where per_id=?;",
					new MapListHandler(), per_id);

		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		ArrayList<GraduationContestDataDTO> contest = gson.fromJson(gson.toJson(listOfMaps),
				new TypeToken<List<GraduationContestDataDTO>>() {
				}.getType());

		if (contest.size() > 0) {

			return contest.get(0);
		} else {

			return null;
		}
	}

	// jonghun
	public String delete_contest(int per_id) {
		Connection conn = Config.getInstance().sqlLogin();
		
		Date temp = new Date();
		String now = dateToString(temp);

		try {
			QueryRunner queryRunner = new QueryRunner();
			queryRunner.update(conn, "DELETE FROM grdu_contest_data WHERE per_id=?", per_id);
			queryRunner.update(conn, "insert grdu_contest_data set per_id = ?", per_id);
			queryRunner.update(conn, "update grdu_etc_state set contest_submit = ?, contest_level_int = ?", 0, 4);
			
			queryRunner.update(conn, "INSERT grdu_userlog SET per_id=?,log_date=?,grd_state=?,user_log=?;", per_id, now, 9, 9);
		}

		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}

		return null;
	}

	// jonghun
	public GraduationConferenceDataDTO getConfeData(int per_id) {
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();

			listOfMaps = queryRunner.query(conn,
					"SELECT per_id, conference_name, requirement, thesis_title, organization, open_date, thesis_filename, proof_filename, file_path from grdu_conference_data where per_id=?;",
					new MapListHandler(), per_id);

		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		ArrayList<GraduationConferenceDataDTO> contest = gson.fromJson(gson.toJson(listOfMaps),
				new TypeToken<List<GraduationConferenceDataDTO>>() {
				}.getType());

		if (contest.size() > 0) {

			return contest.get(0);
		} else {

			return null;
		}
	}

	// jonghun
	public String delete_conference(int per_id) {
		Connection conn = Config.getInstance().sqlLogin();
		
		Date temp = new Date();
		String now = dateToString(temp);

		try {
			QueryRunner queryRunner = new QueryRunner();
			queryRunner.update(conn, "DELETE FROM grdu_conference_data WHERE per_id=?", per_id);
			queryRunner.update(conn, "insert grdu_conference_data set per_id = ?", per_id);
			queryRunner.update(conn, "update grdu_etc_state set conference_submit = ?, confe_level_int = ?", 0, 4);
			
			queryRunner.update(conn, "INSERT grdu_userlog SET per_id=?,log_date=?,grd_state=?,user_log=?;", per_id, now, 8, 9);
		}

		catch (Exception e) {
			e.printStackTrace();
		}

		finally {
			DbUtils.closeQuietly(conn);
		}

		return null;
	}

	// jong hun
	public String insert_etc2(JsonElement element) {

		JsonObject obj = element.getAsJsonObject();
		String per_id = obj.get("per_id").getAsString();
		String contest_name = obj.get("name").getAsString();
		String team_type = obj.get("license").getAsString();
		String contest_content = obj.get("price").getAsString();
		String organization = obj.get("openorgan").getAsString();
		String award_date = obj.get("receivedate").getAsString();
		String open_date = obj.get("opencontest").getAsString();
		String award_filename = obj.get("file1").getAsString();
		String add_filename = obj.get("file2").getAsString();
		Date temp = new Date();
		String now = dateToString(temp);

		List<Map<String, Object>> listOfMaps = null;
		Gson gson = new Gson();
		if (award_filename == null) {
			award_filename = "default";
		}
		if (add_filename == null) {
			add_filename = "default";
		}

		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner que = new QueryRunner();
			// 공모전
			que.update(conn,
					"UPDATE grdu_contest_data SET contest_name=?, team_type=?, contest_content=?, organization=?, award_date=?, open_date=?, award_filename=?, add_filename=? WHERE per_id=?",
					contest_name, team_type, contest_content, organization, award_date, open_date, award_filename,
					add_filename, per_id);
			// grdu_etc_state
			que.update(conn,
					"UPDATE grdu_etc_state SET contest_submit=?, contest_level_int=?, contest_date=? WHERE per_id=?", 1,
					6, now, per_id);
			// 로그
			que.update(conn, "INSERT grdu_userlog SET per_id=?,log_date=?,grd_state=?,user_log=?;", per_id, now, 9, 5);

		} catch (SQLException se) {
			se.printStackTrace();
		}

		finally {
			DbUtils.closeQuietly(conn);
		}
		return per_id;
	}

	// jonghun
	public String modify_etc2(JsonElement element) {

		JsonObject obj = element.getAsJsonObject();
		String per_id = obj.get("per_id").getAsString();
		String contest_name = obj.get("name").getAsString();
		String team_type = obj.get("license").getAsString();
		String contest_content = obj.get("price").getAsString();
		String organization = obj.get("openorgan").getAsString();
		String award_date = obj.get("receivedate").getAsString();
		String open_date = obj.get("opencontest").getAsString();
		String award_filename = obj.get("file1").getAsString();
		String add_filename = obj.get("file2").getAsString();
		Date temp = new Date();
		String now = dateToString(temp);

		if (award_filename == null) {
			award_filename = "default";
		}
		if (add_filename == null) {
			add_filename = "default";
		}
		Connection conn = Config.getInstance().sqlLogin();

		try {
			QueryRunner que = new QueryRunner();

			// 공모전
			que.update(conn,
					"UPDATE grdu_contest_data SET contest_name=?, team_type=?, contest_content=?, organization=?, award_date=?, open_date=?, award_filename=?, add_filename=? WHERE per_id=?",
					contest_name, team_type, contest_content, organization, award_date, open_date, award_filename,
					add_filename, per_id);
			// grdu_etc_state
			que.update(conn,
					"UPDATE grdu_etc_state SET contest_submit=?, contest_level_int=?, contest_date=? WHERE per_id=?", 1,
					6, now, per_id);
			// 로그
			que.update(conn, "INSERT grdu_userlog SET per_id=?,log_date=?,grd_state=?,user_log=?;", per_id, now, 9, 6);

		} catch (SQLException se) {
			se.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
		return per_id;
	}

	// jong hun
	public String insert_etc3(JsonElement element) {

		JsonObject obj = element.getAsJsonObject();
		String per_id = obj.get("per_id").getAsString();
		String conference_name = obj.get("name").getAsString();
		String requirement = obj.get("check").getAsString();
		String thesis_title = obj.get("thesis").getAsString();
		String organization = obj.get("openplace").getAsString();
		String open_date = obj.get("date").getAsString();
		String thesis_filename = obj.get("upload1").getAsString();
		String proof_filename = obj.get("upload2").getAsString();
		Date temp = new Date();
		String now = dateToString(temp);

		if (thesis_filename == null) {
			thesis_filename = "default";
		}
		if (proof_filename == null) {
			proof_filename = "default";
		}

		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner que = new QueryRunner();

			// 학술대회
			que.update(conn,
					"UPDATE grdu_conference_data SET per_id=?, conference_name=?, requirement=?, thesis_title=?, organization=?, open_date=?, thesis_filename=?, proof_filename=? WHERE per_id=?",
					per_id, conference_name, requirement, thesis_title, organization, open_date, thesis_filename,
					proof_filename, per_id);

			// grdu_etc_state
			que.update(conn,
					"UPDATE grdu_etc_state SET conference_submit=?, confe_level_int=?, confe_date=? WHERE per_id=?", 1,
					6, now, per_id);
			// 로그
			que.update(conn, "INSERT grdu_userlog SET per_id=?,log_date=?,grd_state=?,user_log=?;", per_id, now, 8, 5);

		} catch (SQLException se) {
			se.printStackTrace();
		}

		finally {
			DbUtils.closeQuietly(conn);
		}
		return per_id;
	}

	// jong hun
	public String modify_etc3(JsonElement element) {

		JsonObject obj = element.getAsJsonObject();
		String per_id = obj.get("per_id").getAsString();
		String conference_name = obj.get("name").getAsString();
		String requirement = obj.get("check").getAsString();
		String thesis_title = obj.get("thesis").getAsString();
		String organization = obj.get("openplace").getAsString();
		String open_date = obj.get("date").getAsString();
		String thesis_filename = obj.get("upload1").getAsString();
		String proof_filename = obj.get("upload2").getAsString();
		Date temp = new Date();
		String now = dateToString(temp);

		if (thesis_filename == null) {
			thesis_filename = "default";
		}
		if (proof_filename == null) {
			proof_filename = "default";
		}

		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner que = new QueryRunner();

			// 학술대회
			que.update(conn,
					"UPDATE grdu_conference_data SET per_id=?, conference_name=?, requirement=?, thesis_title=?, organization=?, open_date=?, thesis_filename=?, proof_filename=? WHERE per_id=?",
					per_id, conference_name, requirement, thesis_title, organization, open_date, thesis_filename,
					proof_filename, per_id);

			// grdu_etc_state
			que.update(conn,
					"UPDATE grdu_etc_state SET conference_submit=?, confe_level_int=?, confe_date=? WHERE per_id=?", 1,
					6, now, per_id);
			// 로그
			que.update(conn, "INSERT grdu_userlog SET per_id=?,log_date=?,grd_state=?,user_log=?;", per_id, now, 8, 6);

		} catch (SQLException se) {
			se.printStackTrace();
		}

		finally {
			DbUtils.closeQuietly(conn);
		}
		return per_id;
	}

	public int compareDate(int stage) {
		ArrayList<GraduationScheduleDTO> sche = GraduationTestDAO.getInstance().getSchedule();

		Date dd = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		int num = 0;
		String nowstr = sdf.format(dd);
		Date start = sche.get(stage - 1).getStarting_date();
		Date end = sche.get(stage - 1).getEnd_date();

		String startStr = sdf.format(start);
		String endStr = sdf.format(end);

		int ee = nowstr.compareTo(endStr);
		int s = nowstr.compareTo(startStr);

		if (ee > 0) {
			num = 5;
		} else if (ee <= 0 && s >= 0) {
			num = 4;
		} else {
			num = 3;
		}
		return num;
	}
	
	//임시로 만듬
	public ArrayList<GraduationScheduleDTO> getSchedule2() {
	      List<Map<String, Object>> listOfMaps = null;
	      Connection conn = Config.getInstance().sqlLogin();
	      ArrayList<GraduationScheduleDTO> schedule = null;
	      try {
	         QueryRunner queryRunner = new QueryRunner();
	         listOfMaps = queryRunner.query(conn,
	               "SELECT schedule_name_int,starting_date,end_date FROM grdu_schedule;",
	               new MapListHandler());
	      } catch (SQLException e) {
	         e.printStackTrace();
	      }

	      finally {
			  DbUtils.closeQuietly(conn);
		  }
	      Gson gson = new Gson();
	      schedule = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GraduationScheduleDTO>>() {
	      }.getType());
	      for (GraduationScheduleDTO g : schedule) {
	         g.setSchedule_name(Level.getLevel(g.getSchedule_name_int()));
	         g.setStarting_date_str(dateToString(g.getStarting_date()));
	         g.setEnd_date_str(endDateToString(g.getEnd_date()));
	      }
	      return schedule;
	   }


}
