package kr.ac.kyonggi.cs.v2.handler.action.request_boards;

import com.google.gson.Gson;
import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.boards.req_BoardsDAO;
import kr.ac.kyonggi.cs.handler.vo.req_WriterFileBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.ArrayList;

public class req_BoardsWriterExitFileAction implements Action{
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String writer = request.getParameter("data");//user _ id
		Gson gson = new Gson();
		UserTypeBean type = gson.fromJson((String) request.getSession().getAttribute("type"), UserTypeBean.class);
		if(type.board_level > 3)
			return "RequestDispatcher:jsp/main/error.jsp";
		req_BoardsDAO dao = req_BoardsDAO.getInstance();
		ArrayList<req_WriterFileBean> list = dao.getWriterFiles(writer, "0");
		String path = request.getSession().getServletContext().getRealPath("/uploadFile/reqBoards");
		try {
			for(int i = 0 ; i < list.size() ; ++i) {
				String fileName = list.get(i).real_name;
				File deleteFile = new File(path,fileName);
				deleteFile.delete();
				dao.deleteWriterFile(list.get(i).id);
			}
		}catch(Exception e) {
			e.printStackTrace();
			return "fail";
		}
		return "success";
	}

}
