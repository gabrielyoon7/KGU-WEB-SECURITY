package kr.ac.kyonggi.cs.handler.action.main.menu;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.vo.MenuBean;
import kr.ac.kyonggi.cs.handler.vo.TextBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;

public class InformationAction implements Action{

   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      response.setContentType("text/html;charset=UTF-8");
      request.setCharacterEncoding("UTF-8");
      String menu = request.getParameter("num");
      String result = "RequestDispatcher:jsp/page/information.jsp";
      Gson gson = new Gson();
      MenuBean it = HomeDAO.getInstance().getMenuBean(menu);
      request.setAttribute("num",menu);
      String user = (String) request.getSession().getAttribute("user");// 오류날듯 싶다
      UserBean user2 = gson.fromJson(user, UserBean.class);
      if(user2 != null) {
         if (user2.type.equals("졸업논문관리자") ) 
            request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(menu,4)));
         else if(user2.type.contains("교수")) {
            request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(menu,3)));
         }
         else if(user2.type.equals("학부생") || user2.type.equals("복수전공생"))
            request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(menu,2)));
         else {
            request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(menu,1)));
         }
      }else
         request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(menu,2)));
      
      request.setAttribute("text", gson.toJson(HomeDAO.getInstance().getText(Integer.toString(it.id))));   
      return result;
   }
}