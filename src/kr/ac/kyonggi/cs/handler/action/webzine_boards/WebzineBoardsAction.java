package kr.ac.kyonggi.cs.handler.action.webzine_boards;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.boards.NoticeBoardsDAO;
import kr.ac.kyonggi.cs.handler.dao.boards.WebzineBoardsDAO;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.vo.BoardLevelBean;
import kr.ac.kyonggi.cs.handler.vo.MenuBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

public class WebzineBoardsAction implements Action {
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String num= request.getParameter("num");
		Gson gson = new Gson();
		HomeDAO homedao = HomeDAO.getInstance();
		WebzineBoardsDAO webdao = WebzineBoardsDAO.getInstance();
		request.setAttribute("tabmenulist", gson.toJson(homedao.getTabMenu(num)));
		request.setAttribute("num", num);
		MenuBean it = new HomeDAO().getMenuBean(num);
		UserTypeBean type = gson.fromJson((String)request.getSession().getAttribute("type"), UserTypeBean.class);
		if(it.min_level > type.board_level || type.board_level > it.max_level)
			return "RequestDispatcher:jsp/main/error.jsp";
		BoardLevelBean checklevel = homedao.getBoardLevel(it.id);
		request.setAttribute("readLevel", Integer.toString(checklevel.read_level));
		request.setAttribute("writeLevel", Integer.toString(checklevel.write_level));
		request.setAttribute("menu", gson.toJson(it));
		request.setAttribute("fileBoardId", gson.toJson(webdao.getFileBoardId()));
		request.setAttribute("boardslist", gson.toJson(webdao.getBoards(Integer.toString(it.id))));
		return "RequestDispatcher:jsp/webzine/webzine_list.jsp";
	}

}
