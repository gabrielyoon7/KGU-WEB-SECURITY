package kr.ac.kyonggi.cs.handler.action.graduation;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.graduation.GraduationTestDAO;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;

public class GraduationListActionTest implements Action{
	
	@Override
	public  String execute(HttpServletRequest request,HttpServletResponse respone)throws Exception{
		Gson gson = new Gson();
	      String num = request.getParameter("num");
	      String orderNum = Integer.toString((Integer.parseInt(num) % 10));
	      String user = (String) request.getSession().getAttribute("user");// 오류날듯 싶다
	      if(user==null) {
	         return "RequestDispatcher:jsp/main/error.jsp";// 관리자일경우 따로 구분 해주는게 좋을 것 같습니다.
	      }
	      UserBean user2 = gson.fromJson(user, UserBean.class);
	      
	      
	      if (user2.type.equals("졸업논문관리자")) {
	    	  
	    	   request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num, 4)));
	    	   request.setAttribute("userlist",gson.toJson(GraduationTestDAO.getInstance().getAllStudent()));
	    	 
	       }else if(user2.type.contains("교수")) {
	    	   request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num, 3)));
	    	   request.setAttribute("userlist", gson.toJson(GraduationTestDAO.getInstance().getAllMyStudents(user2.name)));
	    	  
	       }
	       else {
	             return "RequestDispatcher:jsp/main/error.jsp";//교수, 졸업논문관리자 아니면 무조건 에러표시
	       }
	      
	      
	      
		
		return "RequestDispatcher:jsp/graduation/manage_list_test.jsp";
	}

}
