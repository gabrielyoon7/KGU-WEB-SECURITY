package kr.ac.kyonggi.cs.v2.handler.action.notice_article;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.v2.common.controller.Action;
import kr.ac.kyonggi.cs.v2.handler.dao.main.NoticeBoardsDAO;
import kr.ac.kyonggi.cs.handler.dao.boards.GalleryBoardsDAO;
import kr.ac.kyonggi.cs.handler.vo.NoticeFileBean;
import kr.ac.kyonggi.cs.handler.vo.GalleryImageBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;

public class NoticeArticleFileDeleteAction implements Action{
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String writer = request.getParameter("data");
        NoticeBoardsDAO dao = NoticeBoardsDAO.getInstance();
        ArrayList<NoticeFileBean> list = dao.getFilesForDelete(writer);
        String path = request.getSession().getServletContext().getRealPath("/uploadFile/noticeBoards");
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
