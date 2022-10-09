package kr.ac.kyonggi.cs.handler.action.main.menu;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.boards.NoticeBoardsDAO;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.dao.setting.ScheduleDAO;
import kr.ac.kyonggi.cs.handler.dao.user.UserDAO;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

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
            result = "RequestDispatcher:jsp/admin/admin_main.jsp";
      }
            else if(menu.substring(1,2).equals("2"))
               result = "RequestDispatcher:jsp/admin/admin_menu.jsp";
            else if(menu.substring(1,2).equals("3")) {
              request.setAttribute("alluser", gson.toJson(UserDAO.getInstance().getAlluser()));
              request.setAttribute("AIuser", gson.toJson(UserDAO.getInstance().getAIuser()));
               result = "RequestDispatcher:jsp/admin/admin_user.jsp";
            }
            else if(menu.substring(1,2).equals("4")) {
                request.setAttribute("alluser", gson.toJson(UserDAO.getInstance().getAlluser()));
               result = "RequestDispatcher:jsp/admin/admin_excel.jsp";
            }
            else if(menu.substring(1,2).equals("5")) {
               File log = new File(request.getServletContext().getRealPath("/WEB-INF"), "log.txt");
               Scanner forlogs = new Scanner(log);
               ArrayList<String> logs = new ArrayList<>();
               while(forlogs.hasNextLine())
                  logs.add(forlogs.nextLine());
               forlogs.close();
               request.setAttribute("logs", gson.toJson(logs));
               result = "RequestDispatcher:jsp/admin/admin_log.jsp";
            }
            else if(menu.substring(1,2).equals("6")) {
            	request.setAttribute("boardslist", gson.toJson(NoticeBoardsDAO.getInstance().getBoards("80")));
            	request.setAttribute("menu", gson.toJson(HomeDAO.getInstance().getMenuBean("86")));
            	request.setAttribute("fileBoardId", gson.toJson(NoticeBoardsDAO.getInstance().getFileBoardId()));
            	request.setAttribute("num", "86");
            	result = "RequestDispatcher:jsp/notice_article/notice_article_list.jsp";
            }
      else if(menu.substring(1,2).equals("7")) {
          request.setAttribute("alluser", gson.toJson(UserDAO.getInstance().getAlluser()));
          request.setAttribute("AIuser", gson.toJson(UserDAO.getInstance().getAIuser()));
          result = "RequestDispatcher:jsp/admin/admin_user_ai.jsp";
      }
      request.setAttribute("typelist", gson.toJson(UserDAO.getInstance().getAllType()));
      request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getTabMenu(menu)));
      request.setAttribute("menulist", gson.toJson(HomeDAO.getInstance().getMenu()));
      return result;
   }

}