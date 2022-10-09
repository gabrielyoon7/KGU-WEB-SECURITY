package kr.ac.kyonggi.cs.v2.handler.action.request_boards;

import com.google.gson.Gson;
import kr.ac.kyonggi.cs.v2.handler.dao.main.HomeDAO;
import kr.ac.kyonggi.cs.v2.handler.dao.user.UserDAO;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;
import kr.ac.kyonggi.cs.v2.common.controller.CustomAction;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class req_BoardsWriterAction extends CustomAction {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		super.execute(request, response);
		Gson gson=new Gson();
		UserTypeBean type = gson.fromJson((String) request.getSession().getAttribute("type"), UserTypeBean.class);
		if(type.board_level > 3)
			return "RequestDispatcher:jsp/main/error.jsp";
		request.setAttribute("typecount", gson.toJson(UserDAO.getInstance().getAllType()));
		request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getTabMenu("51")));
		request.setAttribute("jsp", gson.toJson("req_article_writer"));
		return "RequestDispatcher:jsp_v2/page/page.jsp";
	}
	
}
