package kr.ac.kyonggi.cs.handler.action.webzine_boards;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.boards.WebzineBoardsDAO;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.vo.WebzineBoardsBean;
import kr.ac.kyonggi.cs.handler.vo.WebzineFileBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

public class WebzineModifierAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Gson gson = new Gson();
		WebzineBoardsDAO webdao = WebzineBoardsDAO.getInstance();
		int id=Integer.parseInt(request.getParameter("id"));
		WebzineBoardsBean checkBoard = webdao.getBoardRead(id);
		UserTypeBean userType = gson.fromJson((String)request.getSession().getAttribute("type"), UserTypeBean.class);
		UserBean user = gson.fromJson((String) request.getSession().getAttribute("user"), UserBean.class);
		if(user == null)
			return "RequestDispatcher:jsp/main/error.jsp";
		if(!checkBoard.student_id.equals(user.id) && !userType.for_header.equals("관리자"))
			return "RequestDispatcher:jsp/main/error.jsp";
		
		String num=request.getParameter("num");
		request.setAttribute("boards", gson.toJson(webdao.getBoardRead(id)));
		request.setAttribute("num", num);
		request.setAttribute("id", Integer.toString(id));
		request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getTabMenu(num)));
		ArrayList<WebzineFileBean> it = webdao.readFile(id);
		if(it != null) {
			request.setAttribute("file", gson.toJson(it));
		}
		
		return "RequestDispatcher:jsp/webzine/webzine_modifier.jsp";
	}

}
