package kr.ac.kyonggi.cs.handler.action.main.menu;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

public class RegisterAction implements Action{

	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		if(session.getAttribute("user") != null)
			return "RequestDispatcher:jsp/main/error.jsp";
		String result;
			result = "RequestDispatcher:jsp/main/register.jsp";
		return result;
	}

}
