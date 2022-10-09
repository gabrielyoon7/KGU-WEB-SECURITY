package kr.ac.kyonggi.cs.handler.action.req_boards;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.boards.req_BoardsDAO;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.dao.user.UserDAO;
import kr.ac.kyonggi.cs.handler.vo.req_BoardsBean;
import kr.ac.kyonggi.cs.handler.vo.req_WriterFileBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

public class req_BoardsModifierAction implements Action{
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Gson gson = new Gson();
		int id=Integer.parseInt(request.getParameter("id"));
		req_BoardsDAO dao = req_BoardsDAO.getInstance();
		req_BoardsBean checkBoard = dao.getBoardRead(id);
		UserTypeBean userType = gson.fromJson((String)request.getSession().getAttribute("type"), UserTypeBean.class);
		UserBean user = gson.fromJson((String) request.getSession().getAttribute("user"), UserBean.class);
		if(user == null)
			return "RequestDispatcher:jsp/main/error.jsp";
		if(!checkBoard.student_id.equals(user.id) && !userType.for_header.equals("관리자"))
			return "RequestDispatcher:jsp/main/error.jsp";
		
		String num=request.getParameter("num");
		request.setAttribute("board", gson.toJson(dao.getBoardRead(id)));
		request.setAttribute("num", num);
		request.setAttribute("id", Integer.toString(id));
		request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getTabMenu(num)));
		request.setAttribute("typecount", gson.toJson(UserDAO.getInstance().getAllType()));
		ArrayList<req_WriterFileBean> it = dao.readFile(id);
		if(it != null) {
			request.setAttribute("file", gson.toJson(it));
		}
		return "RequestDispatcher:jsp/request_article/req_article_modifier.jsp";
	}
}
