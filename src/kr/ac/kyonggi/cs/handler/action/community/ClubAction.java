package kr.ac.kyonggi.cs.handler.action.community;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.setting.ClubDAO;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;


public class ClubAction implements Action {

   @Override
   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      Gson gson=new Gson();
      String menu = request.getParameter("num");
      request.setAttribute("club", gson.toJson(ClubDAO.getInstance().getClub()));
      request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getTabMenu(menu)));
      request.setAttribute("num", menu);
      return "RequestDispatcher:jsp/page/community_club.jsp";
   }

}