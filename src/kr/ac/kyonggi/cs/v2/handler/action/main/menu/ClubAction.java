package kr.ac.kyonggi.cs.v2.handler.action.main.menu;
import com.google.gson.Gson;
import kr.ac.kyonggi.cs.v2.handler.dao.main.ClubDAO;
import kr.ac.kyonggi.cs.handler.vo.MenuBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;
import kr.ac.kyonggi.cs.v2.common.controller.CustomAction;
import kr.ac.kyonggi.cs.v2.handler.dao.main.HomeDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/**
 * V2 버전
 *
 * */
public class ClubAction extends CustomAction {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        super.execute(request,response);
        Gson gson = new Gson();

        String menu = request.getParameter("num");
        request.setAttribute("num",menu);
        request.setAttribute("club", gson.toJson(ClubDAO.getInstance().getClub()));
        request.setAttribute("jsp", gson.toJson("community_club")); //*.jsp
        return "RequestDispatcher:jsp_v2/page/page.jsp";
    }
}
