package kr.ac.kyonggi.cs.handler.action.graduation;

import com.google.gson.Gson;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.graduation.GraduationTestDAO;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

public class GraduationAdminActionTest implements Action{
	
	 @Override
	   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception{
		 Gson gson = new Gson();
		 String num=(request.getParameter("num"));
	      if(num==null)
	         return "RequestDispatcher:jsp/main/error.jsp";
	      String orderNum = Integer.toString((Integer.parseInt(num)%10));
	      request.setAttribute("ordernum", orderNum);//5:유저관리 6:신청자관리
	      String type = (String)request.getSession().getAttribute("type");
	      String user=(String)request.getSession().getAttribute("user");
	      UserTypeBean type2=gson.fromJson(type,UserTypeBean.class);
	      UserBean userbean=gson.fromJson(user,UserBean.class);
	      if(type2.type_name.equals("졸업논문관리자")) {
	          request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num,4)));
	      }
	       else if(type2.type_name.equals("교수1"))
	          request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num,3)));
	      //대상자 전체 교수님일경우 교수님 지도학생만
	      if(orderNum.equals("5")) {
	    	  if(type2.type_name.equals("졸업논문관리자")) {
	    		  request.setAttribute("reqorgrd",gson.toJson(0));
	    		  request.setAttribute("proflist",(GraduationTestDAO.getInstance().getAllProfessor()));
	    		  request.setAttribute("userlist",gson.toJson(GraduationTestDAO.getInstance().getAllGrdUser()));
	    		  request.setAttribute("etclist", gson.toJson(GraduationTestDAO.getInstance().getAllUserEtcState()));
	    		  return "RequestDispatcher:jsp/graduation/user_list_test.jsp";
	    	  }
	    	  else if(type2.type_name.contains("교수")) {
	    		  request.setAttribute("reqorgrd",gson.toJson(0));
	    		  request.setAttribute("userlist",gson.toJson(GraduationTestDAO.getInstance().getMyGrdUser(userbean.name)));
	    		  request.setAttribute("etclist",gson.toJson(GraduationTestDAO.getInstance().getMyStudentEtc(userbean.name)));
	    		  return "RequestDispatcher:jsp/graduation/user_list_test.jsp";
	    	  }
	    	  else 
	    		  return "RequestDispatcher:jsp/main/error.jsp";
	      }
	      else { //신청접수 관리
	    	  if(type2.type_name.equals("졸업논문관리자")) {
	    		  request.setAttribute("reqorgrd",gson.toJson(1));
	    		  request.setAttribute("userlist", gson.toJson(GraduationTestDAO.getInstance().getAllReqStudents()));
	    		  request.setAttribute("etclist", gson.toJson(GraduationTestDAO.getInstance().getAllUserEtcState()));
	    		  return "RequestDispatcher:jsp/graduation/user_list_test.jsp";
	    	  }
	    	  else if(type2.type_name.contains("교수")){
	    		  request.setAttribute("reqorgrd",gson.toJson(1));
	    		  request.setAttribute("userlist", gson.toJson(GraduationTestDAO.getInstance().getMyReqStudents(userbean.name)));
	    		  request.setAttribute("etclist",gson.toJson(GraduationTestDAO.getInstance().getMyStudentEtc(userbean.name)));
	    		  return "RequestDispatcher:jsp/graduation/user_list_test.jsp";
	    	  }
	    	  else return "RequestDispatcher:jsp/main/error.jsp";
	    	  
	      }
		 
	 }

}
