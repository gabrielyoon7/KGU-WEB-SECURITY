package kr.ac.kyonggi.cs.v2.handler.action.webzine_boards;

import com.google.gson.Gson;
import kr.ac.kyonggi.cs.handler.dao.boards.WebzineBoardsDAO;
import kr.ac.kyonggi.cs.handler.vo.BoardLevelBean;
import kr.ac.kyonggi.cs.handler.vo.MenuBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;
import kr.ac.kyonggi.cs.v2.common.controller.Action;
import kr.ac.kyonggi.cs.v2.handler.dao.main.HomeDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class WebzineBoardsAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String num= request.getParameter("num");
        Gson gson = new Gson();
        HomeDAO homedao = HomeDAO.getInstance();
        WebzineBoardsDAO webdao = WebzineBoardsDAO.getInstance();
        request.setAttribute("pageMenuList", gson.toJson(homedao.getTabMenu(num)));
        request.setAttribute("num", num);
        MenuBean it = new HomeDAO().getMenuBean(num);
        UserTypeBean type = gson.fromJson((String)request.getSession().getAttribute("type"), UserTypeBean.class);
        if(it.min_level > type.board_level || type.board_level > it.max_level)
            return "RequestDispatcher:jsp/main/error.jsp";
        BoardLevelBean checklevel = homedao.getBoardLevel(it.id);
        request.setAttribute("readLevel", Integer.toString(checklevel.read_level));
        request.setAttribute("writeLevel", Integer.toString(checklevel.write_level));
        request.setAttribute("menu", gson.toJson(it));
        request.setAttribute("fileBoardId", gson.toJson(webdao.getFileBoardId()));
        request.setAttribute("boardslist", gson.toJson(webdao.getBoards(Integer.toString(it.id))));
        request.setAttribute("jsp", gson.toJson("webzine_list"));
        return "RequestDispatcher:jsp_v2/page/page.jsp";
    }

}
