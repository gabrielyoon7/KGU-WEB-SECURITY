package kr.ac.kyonggi.cs.handler.action.graduation;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.graduation.graduationDAO;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.dao.user.UserDAO;
import kr.ac.kyonggi.cs.handler.vo.GrdUserBean;
import kr.ac.kyonggi.cs.handler.vo.GrdlogBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;

public class GraduationFormAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {// 마이페이지=>폼 액션
		Gson gson = new Gson();
		String num = request.getParameter("num");
		String per_id = request.getParameter("per_id");
		String user = (String) request.getSession().getAttribute("user");// 오류날듯 싶다
		String stage1 = request.getParameter("stage");
		String modify = request.getParameter("modify");

		if (num == null || per_id == null || user == null || stage1 == null)
			return "RequestDispatcher:jsp/main/error.jsp";
		int stage = 0;// 예외처리
		try {
			stage = Integer.parseInt(stage1);
		} catch (NumberFormatException e) {
			return "RequestDispatcher:jsp/main/error.jsp";
		}
		GrdlogBean log = null;
		
		if (stage != 6) {
			log = graduationDAO.getInstance().findGrdStudents_log(per_id, stage_name(stage));
		}
		else {
			GrdlogBean temp = null;
			for (int i = 5; i < 8; i++) {
				temp = graduationDAO.getInstance().findGrdStudents_log(per_id, stage_name(i));
				if (temp != null) {
					log = temp;
					break;
				}
			}
		}
			
		if (log == null)
			modify = "0";
		
		GrdlogBean beforelog = null;
		if (stage >= 2 && stage <= 4) {// 예외처리
			beforelog = graduationDAO.getInstance().findGrdStudents_log(per_id, stage_name(stage - 1));
			if (beforelog == null)
				return "RequestDispatcher:jsp/main/error.jsp";
			else if (beforelog.success_date == null)
				return "RequestDispatcher:jsp/main/error.jsp";
		} else if (stage >= 5) {
			beforelog = graduationDAO.getInstance().findGrdStudents_log(per_id, stage_name(1));
			if (beforelog == null)
				return "RequestDispatcher:jsp/main/error.jsp";
			else if (beforelog.success_date == null)
				return "RequestDispatcher:jsp/main/error.jsp";
		}
		GrdUserBean student = graduationDAO.getInstance().getGrdStudent(per_id);// 본 디비에서 찾은 유저
		UserBean user2 = gson.fromJson(user, UserBean.class);
		if (user2.type.equals("졸업논문관리자")) {
			request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num, 4)));
			request.setAttribute("proflist", graduationDAO.getInstance().getAllProfessor());
		} else if (user2.type.contains("교수")) {
			request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num, 3)));
			request.setAttribute("proflist", graduationDAO.getInstance().getAllProfessor());
		} else if (user2.type.equals("학부생") || user2.type.equals("복수전공생")) {
			request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num, 2)));
		} else
			return "RequestDispatcher:jsp/main/error.jsp";
		if (student != null) {
			request.setAttribute("graduationuser", gson.toJson(graduationDAO.getInstance().getGrdStudent(per_id)));// 정식
																													// 디비에서
																													// 찾은
																													// 유저
		} else {
			request.setAttribute("graduationuser", gson.toJson(graduationDAO.getInstance().getReqGrdUsers(per_id)));// 서브
																													// 디비에서
																													// 찾은
																													// 유저
		}
		
		if (!modify.equals("0") && stage >= 5) {// 기타자격 (5~7)번 중 하나라도 제출이 될경우 그쪽으로만 이동하게 만듬
			GrdlogBean logarray = null;
			for (int i = 5; i < 8; i++) {
				logarray = graduationDAO.getInstance().findGrdStudents_log(per_id, stage_name(i));
				if (logarray != null) {
					stage = i;
					break;
				}
			}
		}

		request.setAttribute("stage_data", gson.toJson(log));// 교수,관리자일때, 유저의 log를 받아오기위함.
		request.setAttribute("grduser", gson.toJson(UserDAO.getInstance().getUserperid(per_id)));// user디비에서 찾은 유저객체
		request.setAttribute("schedulelist", gson.toJson(graduationDAO.getInstance().getGrdSchedule()));// 일정리스트 셋

		if ((user2.type.equals("졸업논문관리자") || user2.type.contains("교수")) || (user2 != null && user2.per_id != null)) {
			request.setAttribute("modify", modify);
			if (!modify.equals("0") && stage >= 3) {// mid부터는 파일 제출이 있음
				request.setAttribute("download", graduationDAO.getInstance().downloadfile(log, stage_name(stage)));// download파일
																													// 이름
			}
		} else {
			return "RequestDispatcher:jsp/main/error.jsp";// 관리자일경우 따로 구분 해주는게 좋을 것 같습니다.
		}
		if (stage == 1)
			return "RequestDispatcher:jsp/graduation/form_request.jsp";
		else if (stage == 2)
			return "RequestDispatcher:jsp/graduation/form_suggest.jsp";
		else if (stage == 3)
			return "RequestDispatcher:jsp/graduation/form_mid.jsp";
		else if (stage == 4)
			return "RequestDispatcher:jsp/graduation/form_final.jsp";
		else if (stage == 5)
			return "RequestDispatcher:jsp/graduation/form_etc2.jsp";
		else if (stage == 6)
			return "RequestDispatcher:jsp/graduation/form_etc1.jsp";
		else if (stage == 7) {
			return "RequestDispatcher:jsp/graduation/form_etc3.jsp";
		}
		else {
			if (graduationDAO.getInstance().getGrdStudent(per_id) != null) {
				return "RequestDispatcher:jsp/graduation/graduation_mypage.jsp";
			} else {
				return "RequestDispatcher:jsp/graduation/no_graduation_mypage.jsp";
			}
		}
	}

	public String stage_name(int stage) {
		String selected = "";
		switch (stage) {
		case 1:
			selected = "신청접수";
			break;
		case 2:
			selected = "제안서";
			break;
		case 3:
			selected = "중간보고서";
			break;
		case 4:
			selected = "최종보고서";
			break;
		case 5:
			selected = "공모전";
			break;
		case 6:
			selected = "자격증";
			break;
		case 7:
			selected = "학술대회";
			break;
		default:
			break;
		}
		return selected;
	}
}