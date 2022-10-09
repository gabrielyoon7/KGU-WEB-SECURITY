package kr.ac.kyonggi.cs.v2.handler.action.webzine_boards;

import com.google.gson.Gson;
import kr.ac.kyonggi.cs.handler.vo.WebzineBoardsBean;
import kr.ac.kyonggi.cs.handler.vo.WebzineFileBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;
import kr.ac.kyonggi.cs.v2.common.controller.Action;
import kr.ac.kyonggi.cs.v2.handler.dao.boards.WebzineBoardsDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.ArrayList;

public class WebzineDeleteAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        WebzineBoardsDAO dao = WebzineBoardsDAO.getInstance();
        Gson gson = new Gson();

        String id = request.getParameter("data");
        WebzineBoardsBean check = dao.getBoardRead(Integer.valueOf(id));
        UserBean user = gson.fromJson((String)request.getSession().getAttribute("user"), UserBean.class);
        if(user == null)
            return "RequestDispatcher:jsp/main/error.jsp";
        if(!check.student_id.equals(user.id) && !user.type.contains("관리자"))
            return "";
        ArrayList<WebzineFileBean> them = null;
        try {
            them = dao.readFile(Integer.valueOf(id));
            WebzineFileBean it = null;
            String path = request.getSession().getServletContext().getRealPath("/uploadFile/webzineBoards");
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
