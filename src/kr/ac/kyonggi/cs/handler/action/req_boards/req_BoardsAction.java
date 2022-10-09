package kr.ac.kyonggi.cs.handler.action.req_boards;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.boards.req_BoardsDAO;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.vo.MenuBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

public class req_BoardsAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Gson gson = new Gson();
		String num = request.getParameter("num");
		MenuBean it = HomeDAO.getInstance().getMenuBean(num);
		UserTypeBean type = gson.fromJson((String) request.getSession().getAttribute("type"), UserTypeBean.class);
		if (it.min_level > type.board_level || type.board_level > it.max_level)
			return "RequestDispatcher:jsp/main/error.jsp";
		request.setAttribute("num", num);
		request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getTabMenu(num)));
		request.setAttribute("boardslist", gson.toJson(req_BoardsDAO.getInstance().getBoards()));
		return "RequestDispatcher:jsp/request_article/req_article_list.jsp";
	}

}
