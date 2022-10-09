package kr.ac.kyonggi.cs.handler.action.graduation;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;



public class GraduationBackUpAction implements Action{
	
	@Override
	public String execute(HttpServletRequest request,HttpServletResponse response)throws Exception{
		Gson gson = new Gson();
		 String num=(request.getParameter("num"));
	      if(num==null)
	         return "RequestDispatcher:jsp/main/error.jsp";
	      
	      String type = (String)request.getSession().getAttribute("type");
	      UserTypeBean type2=gson.fromJson(type,UserTypeBean.class);
	      if(type2.type_name.equals("졸업논문관리자"))
	          request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num,4)));
	       else if(type2.type_name.equals("교수1"))
	          request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num,3)));
	
	   
	   
		 
		 return "RequestDispatcher:jsp/graduation/graduation_backup.jsp";
	 }

}
