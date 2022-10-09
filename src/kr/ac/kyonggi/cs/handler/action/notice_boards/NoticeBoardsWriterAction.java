package kr.ac.kyonggi.cs.handler.action.notice_boards;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.boards.NoticeBoardsDAO;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.vo.BoardLevelBean;
import kr.ac.kyonggi.cs.handler.vo.MenuBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

public class NoticeBoardsWriterAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Gson gson=new Gson();
		UserTypeBean type = gson.fromJson((String)request.getSession().getAttribute("type"), UserTypeBean.class);
		String num=request.getParameter("num");
		HomeDAO homedao = HomeDAO.getInstance();
		MenuBean it = HomeDAO.getInstance().getMenuBean(num);
		BoardLevelBean checklevel = HomeDAO.getInstance().getBoardLevel(it.id);
		if(checklevel.write_level < type.board_level)
			return "RequestDispatcher:jsp/main/error.jsp";
		request.setAttribute("num", num);
		if (type.type_name.equals("졸업논문관리자")) 
			request.setAttribute("tabmenulist", gson.toJson(homedao.getGrdTabMenu(num,4)));
		else if(type.type_name.contains("교수")) {
			request.setAttribute("tabmenulist", gson.toJson(homedao.getGrdTabMenu(num,3)));
		}
		else if(type.type_name.equals("학부생") || type.type_name.equals("복수전공생"))
			request.setAttribute("tabmenulist", gson.toJson(homedao.getGrdTabMenu(num,2)));
		else {
			request.setAttribute("tabmenulist", gson.toJson(homedao.getGrdTabMenu(num,1)));
		}
		return "RequestDispatcher:jsp/notice_article/notice_article_writer.jsp";
	}

}
