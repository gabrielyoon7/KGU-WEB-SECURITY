package kr.ac.kyonggi.cs.handler.action.graduation;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.graduation.GraduationTestDAO;
import kr.ac.kyonggi.cs.handler.dao.graduation.graduationDAO;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.dao.user.UserDAO;
import kr.ac.kyonggi.cs.handler.dto.graduation.GraduationThesisDataDTO;
import kr.ac.kyonggi.cs.handler.dto.graduation.GraduationUserDTO;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;

public class GraduationFormSuggestAction implements Action{
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception{
		int schedule_name=2;
		Gson gson = new Gson();
		String num =request.getParameter("num");
		String modify=request.getParameter("modify");
		String per_id = request.getParameter("per_id");
		int perid = Integer.parseInt(per_id);
		UserBean user = UserDAO.getInstance().getUser(per_id);
		String userr=(String)request.getSession().getAttribute("user");
		UserBean user2 = gson.fromJson(userr, UserBean.class);
		if (user2.type.equals("졸업논문관리자")) {
			request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num, 4)));
		} else if (user2.type.contains("교수")) {
			request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num, 3)));
		} else if (user2.type.equals("학부생") || user2.type.equals("복수전공생")) {
			request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num, 2)));
		} else
			return "RequestDispatcher:jsp/main/error.jsp";
		
		GraduationUserDTO grduser = GraduationTestDAO.getInstance().getUser(perid); //suggest
		
		GraduationThesisDataDTO stage_data = GraduationTestDAO.getInstance().getThesisData(perid, schedule_name);
		
		request.setAttribute("num", num);
		request.setAttribute("modify", modify);
		request.setAttribute("per_id", per_id);
		//request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num, 2)));
		request.setAttribute("grduser", gson.toJson(user));
		request.setAttribute("graduationuser", gson.toJson(grduser));
		request.setAttribute("stage_data", gson.toJson(stage_data));
		request.setAttribute("grduseretc", gson.toJson(GraduationTestDAO.getInstance().getUserEtc(perid)));
		
		return "RequestDispatcher:jsp/graduation/form_suggest_test.jsp";
	}
	
	

}
