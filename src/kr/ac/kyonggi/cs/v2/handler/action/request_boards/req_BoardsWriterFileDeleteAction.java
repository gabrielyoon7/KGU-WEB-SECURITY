package kr.ac.kyonggi.cs.v2.handler.action.request_boards;

import com.google.gson.Gson;
import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.boards.req_BoardsDAO;
import kr.ac.kyonggi.cs.handler.vo.req_WriterFileBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;

public class req_BoardsWriterFileDeleteAction implements Action{
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String fileID = request.getParameter("id");
		Gson gson = new Gson();
		UserTypeBean type = gson.fromJson((String) request.getSession().getAttribute("type"), UserTypeBean.class);
		if(type.board_level > 3)
			return "RequestDispatcher:jsp/main/error.jsp";
		req_BoardsDAO dao =req_BoardsDAO.getInstance();
		req_WriterFileBean it = dao.deleteWriterFile(fileID);
		String path = request.getSession().getServletContext().getRealPath("/uploadFile/reqBoards");
		File deleteFile = new File(path, it.real_name);
		deleteFile.delete();
		return gson.toJson(null);
	}
}
