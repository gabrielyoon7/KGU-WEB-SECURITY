package kr.ac.kyonggi.cs.handler.action.main.menu;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.ac.kyonggi.cs.common.controller.Action;

public class GoChangePasswordAction implements Action {

   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      String result;
      if(request.getSession().getAttribute("user") != null)
         result = "RequestDispatcher:jsp/main/changePassword.jsp";
      else
         result = "RequestDispatcher:jsp/main/login.jsp";
      return result;
   }

}