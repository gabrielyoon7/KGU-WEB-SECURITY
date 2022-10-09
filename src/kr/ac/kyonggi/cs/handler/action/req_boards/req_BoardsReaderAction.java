package kr.ac.kyonggi.cs.handler.action.req_boards;


import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.boards.req_BoardsDAO;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.vo.req_BoardsBean;
import kr.ac.kyonggi.cs.handler.vo.req_WriterFileBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

public class req_BoardsReaderAction implements Action{

	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Gson gson = new Gson();
		UserTypeBean userType = gson.fromJson((String )request.getSession().getAttribute("type"), UserTypeBean.class);
		if(userType.type_name.equals("게스트"))
			return "RequestDispatcher:jsp/main/error.jsp";
		UserBean who = gson.fromJson((String)request.getSession().getAttribute("user"), UserBean.class);
		int id = Integer.parseInt(request.getParameter("id"));
		req_BoardsDAO dao = req_BoardsDAO.getInstance();
		String num = request.getParameter("num");
		req_BoardsBean board = dao.getBoardRead(id);
		if(!board.level.contains(userType.for_header) && !userType.for_header.equals("관리자") && !board.student_id.equals(who.id))
			return "RequestDispatcher:jsp/main/error.jsp";// 이상한 경로로 접근시에도 서버에서 레벨 비교 후 읽을 수 있게 함
		if(board.for_who == 1 || board.student_id.equals(who.id) || userType.for_header.equals("관리자")|| userType.for_header.equals("교수"))
			request.setAttribute("AnswerWhoDone", gson.toJson(dao.getResult(Integer.toString(id))));
		else
			request.setAttribute("AnswerWhoDone", Integer.toString(dao.getResult(Integer.toString(id)).size()));
		request.setAttribute("board", gson.toJson(dao.getBoardRead(id)));
		request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getTabMenu("51")));
		request.setAttribute("num", num);
		ArrayList<req_WriterFileBean> it = dao.readFile(id);
		if(it != null) {
			request.setAttribute("file", gson.toJson(it));
		}
		return "RequestDispatcher:jsp/request_article/req_article_reader.jsp";
	}

}
