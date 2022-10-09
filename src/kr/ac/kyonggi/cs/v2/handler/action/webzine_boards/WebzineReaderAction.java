package kr.ac.kyonggi.cs.v2.handler.action.webzine_boards;

import com.google.gson.Gson;
import kr.ac.kyonggi.cs.handler.vo.BoardLevelBean;
import kr.ac.kyonggi.cs.handler.vo.MenuBean;
import kr.ac.kyonggi.cs.handler.vo.WebzineBoardsBean;
import kr.ac.kyonggi.cs.handler.vo.WebzineFileBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;
import kr.ac.kyonggi.cs.v2.common.controller.Action;
import kr.ac.kyonggi.cs.v2.handler.dao.boards.WebzineBoardsDAO;
import kr.ac.kyonggi.cs.v2.handler.dao.main.HomeDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;

public class WebzineReaderAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        Gson gson = new Gson();
        WebzineBoardsDAO webdao = WebzineBoardsDAO.getInstance();
        HomeDAO homedao = HomeDAO.getInstance();
        UserTypeBean userType = gson.fromJson((String)request.getSession().getAttribute("type"), UserTypeBean.class);
        WebzineBoardsBean checkBoard = webdao.getBoardRead(id);
        MenuBean itsMenu = gson.fromJson(homedao.getOneMenu(checkBoard.category), MenuBean.class);
        BoardLevelBean checklevel = homedao.getBoardLevel(itsMenu.id);
        if(checklevel.read_level < userType.board_level )
            return "RequestDispatcher:jsp/main/error.jsp";

        String whatISeen = (String)request.getSession().getAttribute("normalBoard");
        String check = "|" + id + "|";
        if(whatISeen == null) {
            String newWhatISeen = "|" + id + "|";
            request.getSession().setAttribute("normalBoard", newWhatISeen);
            webdao.plusBoardView(id);
        }
        else {
            if(!whatISeen.contains(check)) {
                whatISeen += check;
                request.getSession().setAttribute("normalBoard", whatISeen);
                webdao.plusBoardView(id);
            }
        }

        String num = request.getParameter("num");
        request.setAttribute("boards", gson.toJson(webdao.getBoardRead(id)));
        request.setAttribute("pageMenuList", gson.toJson(homedao.getTabMenu(num)));
        request.setAttribute("num", num);
        request.setAttribute("id", Integer.toString(id));
        request.setAttribute("nextlist", gson.toJson(webdao.getNextPrevious(Integer.toString(id))));
        request.setAttribute("boardLevel",gson.toJson(checklevel));
        ArrayList<WebzineFileBean> it = webdao.readFile(id);
        if(it != null) {
            request.setAttribute("file", gson.toJson(it));
        }
        request.setAttribute("jsp", gson.toJson("webzine_reader"));
        return "RequestDispatcher:jsp_v2/page/page.jsp";
    }

}
