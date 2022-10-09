package kr.ac.kyonggi.cs.handler.action.main.menu;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.vo.MenuBean;
import kr.ac.kyonggi.cs.handler.vo.TextBean;

public class CurriculumAction implements Action{

   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      response.setContentType("text/html;charset=UTF-8");
      request.setCharacterEncoding("UTF-8");
      String menu = request.getParameter("num");
      String result = "RequestDispatcher:jsp/page/curriculum.jsp";
      Gson gson = new Gson();
      MenuBean it = HomeDAO.getInstance().getMenuBean(menu);
      request.setAttribute("num",menu);
      request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getTabMenu(menu)));
      request.setAttribute("text", gson.toJson(HomeDAO.getInstance().getText(Integer.toString(it.id))));
      
      return result;
   }
}