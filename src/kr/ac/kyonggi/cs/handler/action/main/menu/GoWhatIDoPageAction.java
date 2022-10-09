package kr.ac.kyonggi.cs.handler.action.main.menu;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.boards.GalleryBoardsDAO;
import kr.ac.kyonggi.cs.handler.dao.boards.NoticeBoardsDAO;
import kr.ac.kyonggi.cs.handler.dao.boards.WebzineBoardsDAO;
import kr.ac.kyonggi.cs.handler.dao.boards.req_BoardsDAO;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;

public class GoWhatIDoPageAction implements Action {

	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		if(request.getSession().getAttribute("user") == null)
			return "RequestDispatcher:jsp/main/login.jsp";
		Gson gson = new Gson();
		UserBean who = gson.fromJson((String)request.getSession().getAttribute("user"), UserBean.class);
		request.setAttribute("notice_notes", gson.toJson(NoticeBoardsDAO.getInstance().getBoardsFromWho(who.id)));
		request.setAttribute("webzine_notes",gson.toJson(WebzineBoardsDAO.getInstance().getBoardsFromWho(who.id)));
		request.setAttribute("gallery_notes",gson.toJson(GalleryBoardsDAO.getInstance().getBoardsFromWho(who.id)));

		request.setAttribute("notice_comments", gson.toJson(NoticeBoardsDAO.getInstance().getCommentsFromWho(who.id)));
		request.setAttribute("webzine_comments",gson.toJson(WebzineBoardsDAO.getInstance().getCommentsFromWho(who.id)));
		request.setAttribute("gallery_comments",gson.toJson(GalleryBoardsDAO.getInstance().getCommentsFromWho(who.id)));

		request.setAttribute("likeNotes", gson.toJson(WebzineBoardsDAO.getInstance().getLikesFromWho(who.id)));
		request.setAttribute("answers", gson.toJson(req_BoardsDAO.getInstance().getBoardsWhatIDone(who.id)));

		return "RequestDispatcher:jsp/page/what_i_do.jsp";
	}

}