package kr.ac.kyonggi.cs.handler.action.webzine_boards;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.boards.WebzineBoardsDAO;
import kr.ac.kyonggi.cs.handler.vo.WebzineFileBean;

public class WebzineFileDeleteAction implements Action{
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String writer = request.getParameter("data");
		WebzineBoardsDAO dao = WebzineBoardsDAO.getInstance();
		ArrayList<WebzineFileBean> list = dao.getFilesForDelete(writer);
		String path = request.getSession().getServletContext().getRealPath("/uploadFile/webzineBoards");
		try {
			for(int i = 0 ; i < list.size() ; ++i) {
				String fileName = list.get(i).filelink;
				File deleteFile = new File(path,fileName);
				deleteFile.delete();
				dao.deleteFileWithName(fileName);
			}
		}catch(Exception e) {
			e.printStackTrace();
			return "fail";
		}
		return "success";
	}
}
