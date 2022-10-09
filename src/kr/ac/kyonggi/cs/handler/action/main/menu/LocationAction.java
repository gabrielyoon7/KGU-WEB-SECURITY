package kr.ac.kyonggi.cs.handler.action.main.menu;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;

public class LocationAction implements Action{

	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Gson gson = new Gson();
		request.setAttribute("text", gson.toJson(HomeDAO.getInstance().getText("1")));   
		String result = "RequestDispatcher:jsp/main/location.jsp";
		return result;
	}

}
