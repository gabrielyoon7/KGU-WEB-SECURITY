package kr.ac.kyonggi.cs.handler.action.webzine_boards;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.boards.WebzineBoardsDAO;
import kr.ac.kyonggi.cs.handler.vo.WebzineFileBean;

public class WebzineFileUploadDeleteAction implements Action {
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String fileID = request.getParameter("id");
		Gson gson = new Gson();
		WebzineBoardsDAO dao = WebzineBoardsDAO.getInstance();
		WebzineFileBean it = dao.getFile(fileID);
		String path = request.getSession().getServletContext().getRealPath("/uploadFile/webzineBoards");
		File deleteFile = new File(path, it.filelink);
		deleteFile.delete();
		return gson.toJson(null);
	}
}
