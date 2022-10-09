package kr.ac.kyonggi.cs.handler.action.graduation;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.graduation.GraduationTestDAO;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.dao.user.UserDAO;
import kr.ac.kyonggi.cs.handler.dto.graduation.GraduationEtcDTO;
import kr.ac.kyonggi.cs.handler.dto.graduation.GraduationReqStudentsDTO;
import kr.ac.kyonggi.cs.handler.dto.graduation.GraduationUserDTO;
import kr.ac.kyonggi.cs.handler.stateenum.Capstone;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;

public class GraduationManageUserActionTest implements Action{
	
	 @Override
	   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception{
		  Gson gson = new Gson();
	      String num= request.getParameter("num");
	      request.setAttribute("num",num);
	      String per_id=request.getParameter("perid");
	      request.setAttribute("schedulelist", gson.toJson(GraduationTestDAO.getInstance().getSchedule()));
	      String user = (String) request.getSession().getAttribute("user");
	      if(user==null||num==null||per_id==null) {//guest
	          return "RequestDispatcher:jsp/main/error.jsp";
	       }
	       UserBean user2 = gson.fromJson(user, UserBean.class);
	       int pid = Integer.parseInt(per_id);
	      
	       GraduationUserDTO grduser = GraduationTestDAO.getInstance().getGrdUser(pid);
	       UserBean ub = UserDAO.getInstance().getUser(per_id);
	       GraduationReqStudentsDTO reqstudent = GraduationTestDAO.getInstance().getReqStudent(pid);
	       String usertype=gson.toJson(user2);
	       int user_type_int = 1;
	      
	      String temp = gson.toJson(ub);
	       if(grduser!=null) {
	    	   GraduationEtcDTO usere = GraduationTestDAO.getInstance().getEtc(pid);
	    	   grduser.setEtc_accept(Capstone.getCapstone(usere.getCapstone()));
	    	   request.setAttribute("grdu_student", gson.toJson(grduser));
				request.setAttribute("grdu_students_state_list", gson.toJson(GraduationTestDAO.getInstance().getGrduStateList(pid,2))); // 요거
				request.setAttribute("etc_state", gson.toJson(usere));
				request.setAttribute("log_list", gson.toJson(GraduationTestDAO.getInstance().getGrdLog(pid)));
				
				 if (user2.type.equals("졸업논문관리자")) {
			    	   request.setAttribute("tabMenu", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num, 4)));
			       }else if(user2.type.contains("교수")) 
			    	   request.setAttribute("tabMenu", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num, 3)));
			       else {
			             return "RequestDispatcher:jsp/main/error.jsp";//교수, 졸업논문관리자 아니면 무조건 에러표시
			       }
				
				return "RequestDispatcher:jsp/graduation/graduation_mypage_test.jsp";
	       }
	       if (user2.type.equals("졸업논문관리자")) {
	    	   request.setAttribute("tabMenu", (HomeDAO.getInstance().getGrdTabMenu(num, 4)));
	       }else if(user2.type.contains("교수")) 
	    	   request.setAttribute("tabMenu", (HomeDAO.getInstance().getGrdTabMenu(num, 3)));
	       else {
	             return "RequestDispatcher:jsp/main/error.jsp";//교수, 졸업논문관리자 아니면 무조건 에러표시
	       }
	       
	       request.setAttribute("reqstudent", reqstudent);
			request.setAttribute("user",gson.fromJson(temp, UserBean.class));
			request.setAttribute("request", GraduationTestDAO.getInstance().getReqSchedule());
			
			return "RequestDispatcher:jsp/graduation/no_graduation_mypage_test.jsp";
		 
		 
		 
	 }

}
