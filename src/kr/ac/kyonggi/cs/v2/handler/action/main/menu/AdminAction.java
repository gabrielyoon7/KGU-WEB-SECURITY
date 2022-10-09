package kr.ac.kyonggi.cs.v2.handler.action.main.menu;

import com.google.gson.Gson;
import kr.ac.kyonggi.cs.v2.common.controller.Action;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;
import kr.ac.kyonggi.cs.v2.handler.dao.main.HomeDAO;
import kr.ac.kyonggi.cs.v2.handler.dao.main.NoticeBoardsDAO;
import kr.ac.kyonggi.cs.v2.handler.dao.main.ScheduleDAO;
import kr.ac.kyonggi.cs.v2.handler.dao.user.UserDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.ArrayList;
import java.util.Scanner;

public class AdminAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        Gson gson = new Gson();
        String menu = request.getParameter("num");
        String result="";
        UserTypeBean type = gson.fromJson((String) request.getSession().getAttribute("type"), UserTypeBean.class);
        if(type.board_level != 0)
            return "RequestDispatcher:jsp/main/error.jsp";
        if(menu.substring(1,2).equals("1")) {
            request.setAttribute("schedulelist", gson.toJson(new ScheduleDAO().getSchedule()));
            request.setAttribute("images", HomeDAO.getInstance().getSliders());
            request.setAttribute("jsp", gson.toJson("admin_main"));
            result = "RequestDispatcher:jsp_v2/page/page.jsp";
        }
        else if(menu.substring(1,2).equals("2")) {
            request.setAttribute("jsp", gson.toJson("admin_menu"));
            result = "RequestDispatcher:jsp_v2/page/page.jsp";
        }
        else if(menu.substring(1,2).equals("3")) {
            request.setAttribute("alluser", gson.toJson(UserDAO.getInstance().getAlluser()));
            request.setAttribute("AIuser", gson.toJson(UserDAO.getInstance().getAIuser()));
            request.setAttribute("jsp", gson.toJson("admin_user"));
            result = "RequestDispatcher:jsp_v2/page/page.jsp";
        }
        else if(menu.substring(1,2).equals("4")) {
            request.setAttribute("alluser", gson.toJson(UserDAO.getInstance().getAlluser()));
            request.setAttribute("jsp", gson.toJson("admin_excel"));
            result = "RequestDispatcher:jsp_v2/page/page.jsp";
        }
        else if(menu.substring(1,2).equals("5")) {
            File log = new File(request.getServletContext().getRealPath("/WEB-INF"), "log.txt");
            Scanner forlogs = new Scanner(log);
            ArrayList<String> logs = new ArrayList<>();
            while(forlogs.hasNextLine())
                logs.add(forlogs.nextLine());
            forlogs.close();
            request.setAttribute("logs", gson.toJson(logs));
            request.setAttribute("jsp", gson.toJson("admin_log"));
            result = "RequestDispatcher:jsp_v2/page/page.jsp";
        }
        else if(menu.substring(1,2).equals("6")) {
            request.setAttribute("boardslist", gson.toJson(NoticeBoardsDAO.getInstance().getBoards("80")));
            request.setAttribute("menu", gson.toJson(HomeDAO.getInstance().getMenuBean("86")));
            request.setAttribute("fileBoardId", gson.toJson(NoticeBoardsDAO.getInstance().getFileBoardId()));
            request.setAttribute("num", "86");
            request.setAttribute("jsp", gson.toJson("notice_list"));
            result = "RequestDispatcher:jsp_v2/page/page.jsp";
        }
        else if(menu.substring(1,2).equals("7")) {
            request.setAttribute("alluser", gson.toJson(UserDAO.getInstance().getAlluser()));
            request.setAttribute("AIuser", gson.toJson(UserDAO.getInstance().getAIuser()));
            request.setAttribute("jsp", gson.toJson("admin_user_ai"));
            result = "RequestDispatcher:jsp_v2/page/page.jsp";
        }
        request.setAttribute("typelist", gson.toJson(UserDAO.getInstance().getAllType()));
        request.setAttribute("pageMenuList", gson.toJson(HomeDAO.getInstance().getTabMenu(menu)));
        request.setAttribute("menulist", gson.toJson(HomeDAO.getInstance().getMenu()));
        return result;
    }
}
