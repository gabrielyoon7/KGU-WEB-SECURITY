package kr.ac.kyonggi.cs.v2.handler.action.notice_article;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.v2.common.controller.Action;
import kr.ac.kyonggi.cs.v2.handler.dao.main.NoticeBoardsDAO;
import kr.ac.kyonggi.cs.v2.handler.dao.main.HomeDAO;
import kr.ac.kyonggi.cs.handler.vo.BoardLevelBean;
import kr.ac.kyonggi.cs.handler.vo.NoticeBoardsBean;
import kr.ac.kyonggi.cs.handler.vo.NoticeFileBean;
import kr.ac.kyonggi.cs.handler.vo.MenuBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

public class NoticeArticleReaderAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        Gson gson = new Gson();
        HomeDAO homedao = HomeDAO.getInstance();
        NoticeBoardsDAO nodao = NoticeBoardsDAO.getInstance();
        UserTypeBean userType = gson.fromJson((String)request.getSession().getAttribute("type"), UserTypeBean.class);
        NoticeBoardsBean checkBoard = nodao.getBoardRead(id);
        MenuBean itsMenu = gson.fromJson(homedao.getOneMenu(checkBoard.category), MenuBean.class);
        BoardLevelBean checklevel = homedao.getBoardLevel(itsMenu.id);
        if(checklevel.read_level < userType.board_level )
            return "RequestDispatcher:jsp/main/error.jsp";

        String whatISeen = (String)request.getSession().getAttribute("normalBoard");
        String check = "|" + id + "|";
        if(whatISeen == null) {
            String newWhatISeen = "|" + id + "|";
            request.getSession().setAttribute("normalBoard", newWhatISeen);
            new NoticeBoardsDAO().plusBoardView(id);
        }
        else {
            if(!whatISeen.contains(check)) {
                whatISeen += check;
                request.getSession().setAttribute("normalBoard", whatISeen);
                new NoticeBoardsDAO().plusBoardView(id);
            }
        }

        String num = request.getParameter("num");
        request.setAttribute("boards", gson.toJson(nodao.getBoardRead(id)));
        if (userType.type_name.equals("졸업논문관리자"))
            request.setAttribute("pageMenuList", gson.toJson(homedao.getGrdTabMenu(num,4)));
        else if(userType.type_name.contains("교수")) {
            request.setAttribute("pageMenuList", gson.toJson(homedao.getGrdTabMenu(num,3)));
        }
        else if(userType.type_name.equals("학부생") || userType.type_name.equals("복수전공생"))
            request.setAttribute("pageMenuList", gson.toJson(homedao.getGrdTabMenu(num,2)));
        else {
            request.setAttribute("pageMenuList", gson.toJson(homedao.getGrdTabMenu(num,1)));
        }
        request.setAttribute("num", num);
        request.setAttribute("id", Integer.toString(id));
        request.setAttribute("nextlist", gson.toJson(nodao.getNextPrevious(Integer.toString(id))));
        request.setAttribute("boardLevel",gson.toJson(checklevel));
        ArrayList<NoticeFileBean> it = nodao.readFile(id);
        if(it != null) {
            request.setAttribute("file", gson.toJson(it));
        }
        request.setAttribute("jsp", gson.toJson("notice_view")); //*.jsp
        return "RequestDispatcher:jsp_v2/page/page_new_theme.jsp";
    }

}
