package kr.ac.kyonggi.cs.handler.action.main.menu;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.user.UserDAO;
import kr.ac.kyonggi.cs.handler.vo.user.*;

public class ChangePasswordAction implements Action{


   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      UserDAO dao = new UserDAO();
      String id = request.getParameter("id");
      String password = request.getParameter("password_hash"); // 원래 비밀번호 액션에서 맞는지 다시 재확인
      String data = password + "-/-/-" + id;
      if(!dao.checkPassword(data))
         return "RequestDispatcher:jsp/main/error.jsp";

      String newPassword = request.getParameter("password_hash2"); // 바꿀 비밀번호
      dao.changePassword(id, newPassword);
      
      HttpSession session = request.getSession();
      session.invalidate();
      response.sendRedirect("Index");
      
      return null;
   }




}