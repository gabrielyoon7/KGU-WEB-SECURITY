package kr.ac.kyonggi.cs.v2.handler.action.request_boards;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import kr.ac.kyonggi.cs.handler.vo.MenuBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;
import kr.ac.kyonggi.cs.v2.common.controller.CustomAction;
import kr.ac.kyonggi.cs.v2.handler.dao.main.HomeDAO;
import kr.ac.kyonggi.cs.v2.handler.dao.boards.req_BoardsDAO;

public class req_BoardsAction extends CustomAction {
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		super.execute(request, response);
		Gson gson = new Gson();

		String num = request.getParameter("num");
		request.setAttribute("num", num);
		MenuBean it = kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO.getInstance().getMenuBean(num);
		UserTypeBean type = gson.fromJson((String) request.getSession().getAttribute("type"), UserTypeBean.class);
        if (it.min_level > type.board_level || type.board_level > it.max_level)
            return "RequestDispatcher:jsp/main/error.jsp";
		request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getTabMenu(num)));
		request.setAttribute("boardslist", gson.toJson(req_BoardsDAO.getInstance().getBoards()));
		request.setAttribute("jsp", gson.toJson("req_article_list"));
		return "RequestDispatcher:jsp_v2/page/page.jsp";
	}

}


