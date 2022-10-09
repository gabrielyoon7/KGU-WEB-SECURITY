package kr.ac.kyonggi.cs.handler.action.graduation;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.graduation.GraduationTestDAO;
import kr.ac.kyonggi.cs.handler.dao.graduation.graduationDAO;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;

public class GraduationscheduleAction implements Action{

   @Override
   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      String num=request.getParameter("num");
      Gson gson = new Gson();
      String user = (String) request.getSession().getAttribute("user");// 오류날듯 싶다
      if(user==null) {//추가
         return"RequestDispatcher:jsp/main/error.jsp";
      }
      UserBean user2 = gson.fromJson(user, UserBean.class);
      if (user2.type.equals("졸업논문관리자")) {
         request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num,4)));
      } else if (user2.type.contains("교수")) {
         request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num,3)));
      }
      else if(user2.type.equals("학부생") || user2.type.equals("복수전공생"))
          request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num,2)));
       else if(user2.type.equals("관리자") || user2.type.equals("홈페이지관리자")){
          request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num,1)));
       }
       else
    	   return "RequestDispatcher:jsp/main/error.jsp";
       request.setAttribute("schedulelist", gson.toJson(GraduationTestDAO.getInstance().getScheduleList()));
       request.setAttribute("num", num);
         //request.setAttribute("menulist", gson.toJson(HomeDAO.getInstance().getMenu()));
      return "RequestDispatcher:jsp/graduation/graduation_schedule.jsp";
   }

}