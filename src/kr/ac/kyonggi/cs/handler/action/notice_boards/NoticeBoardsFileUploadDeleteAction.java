package kr.ac.kyonggi.cs.handler.action.notice_boards;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.boards.NoticeBoardsDAO;
import kr.ac.kyonggi.cs.handler.dao.boards.GalleryBoardsDAO;
import kr.ac.kyonggi.cs.handler.dao.boards.req_BoardsDAO;
import kr.ac.kyonggi.cs.handler.vo.NoticeFileBean;
import kr.ac.kyonggi.cs.handler.vo.GalleryImageBean;
import kr.ac.kyonggi.cs.handler.vo.req_WriterFileBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;

public class NoticeBoardsFileUploadDeleteAction implements Action{
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String fileID = request.getParameter("id");
		Gson gson = new Gson();
		NoticeBoardsDAO dao = NoticeBoardsDAO.getInstance();
		NoticeFileBean it = dao.getFile(fileID);
		String path = request.getSession().getServletContext().getRealPath("/uploadFile/noticeBoards");
		File deleteFile = new File(path, it.filelink);
		deleteFile.delete();
		dao.deleteFileWithName(it.filelink);
		return gson.toJson(null);
	}
}
