package kr.ac.kyonggi.cs.v2.handler.action.notice_article;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.v2.common.controller.Action;
import kr.ac.kyonggi.cs.v2.handler.dao.main.NoticeBoardsDAO;
import kr.ac.kyonggi.cs.handler.vo.NoticeFileBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;
import kr.ac.kyonggi.cs.handler.vo.NoticeBoardsBean;

public class NoticeArticleDeleteAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        NoticeBoardsDAO dao = NoticeBoardsDAO.getInstance();
        Gson gson = new Gson();
        String id = request.getParameter("data");
        NoticeBoardsBean check = dao.getBoardRead(Integer.valueOf(id));
        UserBean user = gson.fromJson((String)request.getSession().getAttribute("user"), UserBean.class);
        if(user == null)
            return "RequestDispatcher:jsp/main/error.jsp";
        if(!check.student_id.equals(user.id) && !user.type.contains("관리자"))
            return "";
        ArrayList<NoticeFileBean> them = null;
        try {
            them = dao.readFile(Integer.valueOf(id));
            NoticeFileBean it = null;
            String path = request.getSession().getServletContext().getRealPath("/uploadFile/noticeBoards");
            if(them != null) {
                for(int i = 0 ; i < them.size() ; ++i) {
                    it = them.get(i);
                    File deleteFile = new File(path, it.filelink);
                    deleteFile.delete();
                }
                dao.deleteFile(id);
            }
            dao.deleteBoards(id);
        } catch(Exception e) {
        }

        return "";
    }

}
