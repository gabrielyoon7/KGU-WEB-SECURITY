package kr.ac.kyonggi.cs.handler.action.req_boards;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.dao.user.UserDAO;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

public class req_BoardsWriterAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Gson gson=new Gson();
		UserTypeBean type = gson.fromJson((String) request.getSession().getAttribute("type"), UserTypeBean.class);
		if(type.board_level > 3)
			return "RequestDispatcher:jsp/main/error.jsp";
		request.setAttribute("typecount", gson.toJson(UserDAO.getInstance().getAllType()));
		request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getTabMenu("51")));
		return "RequestDispatcher:jsp/request_article/req_article_writer.jsp";
	}
	
}
