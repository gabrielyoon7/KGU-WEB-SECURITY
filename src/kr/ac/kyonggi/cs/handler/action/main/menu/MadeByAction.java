package kr.ac.kyonggi.cs.handler.action.main.menu;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import kr.ac.kyonggi.cs.common.controller.Action;

public class MadeByAction implements Action{

   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      String result = "RequestDispatcher:jsp/main/madeby.jsp";
      return result;
   }

}