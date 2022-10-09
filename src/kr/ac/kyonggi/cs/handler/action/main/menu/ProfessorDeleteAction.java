package kr.ac.kyonggi.cs.handler.action.main.menu;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.boards.NoticeBoardsDAO;
import kr.ac.kyonggi.cs.handler.dao.professor.ProfessorDAO;
import kr.ac.kyonggi.cs.handler.vo.NoticeFileBean;
import kr.ac.kyonggi.cs.handler.vo.ProfessorBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;
import kr.ac.kyonggi.cs.handler.vo.NoticeBoardsBean;

public class ProfessorDeleteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ProfessorDAO dao = ProfessorDAO.getInstance();
		Gson gson = new Gson();
		String id = request.getParameter("data");
		ProfessorBean it = dao.getOneProfessor(id);
		UserBean user = gson.fromJson((String)request.getSession().getAttribute("user"), UserBean.class);
		if(!user.type.equals("관리자"))
			return "";
		 try {
			 	String path = request.getSession().getServletContext().getRealPath("/img/professor");
			 	File deleteFile = new File(path, it.prof_img);
			 	deleteFile.delete();
		        } catch(Exception e) {
		        }
		 dao.deleteProfessor(id);
		return "";
	}

}
