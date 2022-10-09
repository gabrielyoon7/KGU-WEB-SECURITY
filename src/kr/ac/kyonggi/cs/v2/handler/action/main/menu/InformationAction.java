package kr.ac.kyonggi.cs.v2.handler.action.main.menu;
import com.google.gson.Gson;
import kr.ac.kyonggi.cs.handler.vo.MenuBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;
import kr.ac.kyonggi.cs.v2.common.controller.CustomAction;
import kr.ac.kyonggi.cs.v2.handler.dao.main.HomeDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * V2 버전
 *
 * */
public class InformationAction extends CustomAction {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        super.execute(request,response);
        Gson gson = new Gson();
        HttpSession session = request.getSession();

        /**
         * Java에서 subdomain 받는 방법 시작 (제어를 하고 싶으면 SFilter 클래스에서 하세요)
         * */
        String subdomainJSON = (String) session.getAttribute("subdomain"); // ai 또는 cs로 도착함
        String subdomain = subdomainJSON.substring(1, subdomainJSON.length()-1 ); //JSON 형태를 Java 형식으로 만들어주기 위한 작업
        /**
         * Java에서 subdomain 받는 방법 끝 (JS에서는 그냥 쓰면 됩니다.)
         * */

        String menu = request.getParameter("num");
        request.setAttribute("num",menu);
        request.setAttribute("text", gson.toJson(HomeDAO.getInstance().getMain(menu,subdomain)));
        request.setAttribute("jsp", gson.toJson("information")); //*.jsp
        return "RequestDispatcher:jsp_v2/page/page.jsp";
    }
}
