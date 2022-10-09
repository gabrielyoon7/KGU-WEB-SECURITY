package kr.ac.kyonggi.cs.handler.action.graduation;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dto.graduation.*;
import kr.ac.kyonggi.cs.handler.stateenum.Capstone;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;
import kr.ac.kyonggi.cs.handler.dao.graduation.*;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;

import com.google.gson.Gson;

public class GraduationIntroActionTest implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		Gson gson = new Gson();
		String num = request.getParameter("num"); // 페이지 넘버 그대로 유지
		String user = (String) request.getSession().getAttribute("user");
		String stage="-1";
		
		UserBean user2 = gson.fromJson(user, UserBean.class);
		String sper_id = user2.per_id;
		int per_id = Integer.parseInt(sper_id);
		
		GraduationReqStudentsDTO reqstudent = GraduationTestDAO.getInstance().getReqStudent(per_id);
		
		GraduationUserDTO grduser = GraduationTestDAO.getInstance().getGrdUser(per_id);
		
	
		
		request.setAttribute("num", num);
		
		int user_t=2;
		
		//신청접수 이후
		if(grduser!=null) {
			request.setAttribute("tabMenu", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num, 2)));
			grduser.setEtc_accept(Capstone.getCapstone(grduser.getCapstone())); 
			request.setAttribute("grdu_student",gson.toJson(grduser));
			request.setAttribute("grdu_students_state_list", gson.toJson(GraduationTestDAO.getInstance().getGrduStateList(per_id,1))); // 요거
			request.setAttribute("etc_state", gson.toJson(GraduationTestDAO.getInstance().getEtc(per_id)));
			request.setAttribute("log_list", gson.toJson(GraduationTestDAO.getInstance().getGrdLog(per_id)));
			//request.setAttribute("user",gson.fromJson(user, UserBean.class));
			
			
			
			return "RequestDispatcher:jsp/graduation/graduation_mypage_test.jsp";
		}
		request.setAttribute("tabMenu",(HomeDAO.getInstance().getGrdTabMenu(num, 2)));
		//신청접수 이전, 신청접수
		request.setAttribute("reqstudent", reqstudent);
		request.setAttribute("user",gson.fromJson(user, UserBean.class));
		request.setAttribute("request", GraduationTestDAO.getInstance().getReqSchedule());
		
		return "RequestDispatcher:jsp/graduation/no_graduation_mypage_test.jsp";
		
	}

}
