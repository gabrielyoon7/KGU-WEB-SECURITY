package kr.ac.kyonggi.cs.v2.handler.action.webzine_boards;

import com.google.gson.Gson;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.vo.BoardLevelBean;
import kr.ac.kyonggi.cs.handler.vo.MenuBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;
import kr.ac.kyonggi.cs.v2.common.controller.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class WebzineWriterAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Gson gson=new Gson();
        HomeDAO dao = HomeDAO.getInstance();
        UserTypeBean type = gson.fromJson((String)request.getSession().getAttribute("type"), UserTypeBean.class);
        String num=request.getParameter("num");
        MenuBean it = dao.getMenuBean(num);
        BoardLevelBean checklevel = dao.getBoardLevel(it.id);
        if(checklevel.write_level < type.board_level)
            return "RequestDispatcher:jsp/main/error.jsp";
        request.setAttribute("num", num);
        request.setAttribute("pageMenuList", gson.toJson(dao.getTabMenu(num)));
        request.setAttribute("jsp", gson.toJson("webzine_writer"));
        return "RequestDispatcher:jsp_v2/page/page.jsp";
    }
}
