package kr.ac.kyonggi.cs.handler.action.graduation;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.graduation.graduationDAO;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.dao.user.UserDAO;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

public class GraduationAdminAction implements Action {

   @Override
   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      String num=(request.getParameter("num"));
      if(num==null)
         return "RequestDispatcher:jsp/main/error.jsp";
      String orderNum = Integer.toString((Integer.parseInt(num)%10));
      request.setAttribute("ordernum", orderNum);//5:유저관리 6:신청자관리
      Gson gson = new Gson();
      String user=(String)request.getSession().getAttribute("user");
      String type = (String)request.getSession().getAttribute("type");
      UserTypeBean type2=gson.fromJson(type,UserTypeBean.class);
      UserBean userbean=gson.fromJson(user,UserBean.class);
      if(type2.type_name.equals("졸업논문관리자"))
         request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num,4)));
      else if(type2.type_name.equals("교수1"))
         request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num,3)));
      
    //대상자전체관리
      if(orderNum.equals("5")) { 
         if(type2.type_name.equals("졸업논문관리자")) {
            request.setAttribute("proflist", graduationDAO.getInstance().getAllProfessor());
            request.setAttribute("userlist", gson.toJson(graduationDAO.getInstance().getAllGrdUsers()));
            return "RequestDispatcher:jsp/graduation/user_list.jsp";
         }else if(type2.type_name.contains("교수")) {//수정필요
            request.setAttribute("userlist", gson.toJson(graduationDAO.getInstance().getmyGrdUsers(userbean.name)));//이걸 교수의 졸업대상자만 보이게 바꿔야함
           
            return "RequestDispatcher:jsp/graduation/user_list.jsp";
         }
         else return "RequestDispatcher:jsp/main/error.jsp";
      }
      else { //신청접수관리
         if(type2.type_name.equals("졸업논문관리자")) {
            request.setAttribute("userlist", gson.toJson(graduationDAO.getInstance().getAllReqGrdUsers()));
            return "RequestDispatcher:jsp/graduation/user_list.jsp";
         }else if(type2.type_name.contains("교수")) {//수정필요
            request.setAttribute("userlist", gson.toJson(graduationDAO.getInstance().getProfessorReqGrdUsers(userbean)));//이걸 교수의 졸업대상자만 보이게 바꿔야함
            return "RequestDispatcher:jsp/graduation/user_list.jsp";
         }
         else return "RequestDispatcher:jsp/main/error.jsp";
      }
      

   }
}