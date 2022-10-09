package kr.ac.kyonggi.cs.handler.action.main.menu;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.professor.ProfessorDAO;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;

public class ProfessorAction implements Action{

	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		String menu = request.getParameter("num");
		String result = "RequestDispatcher:jsp/page/professor.jsp";
		Gson gson = new Gson();
		request.setAttribute("num",menu);
		request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getTabMenu(menu)));
		request.setAttribute("professorlist", gson.toJson(ProfessorDAO.getInstance().getProfessor()));
		return result;
	}
}