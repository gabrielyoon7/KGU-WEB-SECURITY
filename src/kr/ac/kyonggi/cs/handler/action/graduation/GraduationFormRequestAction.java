package kr.ac.kyonggi.cs.handler.action.graduation;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.graduation.GraduationTestDAO;
import kr.ac.kyonggi.cs.handler.dao.graduation.graduationDAO;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.dao.user.UserDAO;
import kr.ac.kyonggi.cs.handler.dto.graduation.GraduationLogDTO;
import kr.ac.kyonggi.cs.handler.dto.graduation.GraduationUserDTO;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;

public class GraduationFormRequestAction implements Action{
	
	//학생중 누구인지를 파악하기 위해 학번을 가져와야한다 -> 주소에 perid추가 할것
	
	
	String thisperid;
	
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		Gson gson = new Gson();
		String num =request.getParameter("num");
		String modify=request.getParameter("modify");
		String user=(String)request.getSession().getAttribute("user");
		UserBean user2 = gson.fromJson(user, UserBean.class);
		if (user2.type.equals("졸업논문관리자")) {
			request.setAttribute("tabMenu", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num, 4)));
		} else if (user2.type.contains("교수")) {
			request.setAttribute("tabMenu", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num, 3)));
		} else if (user2.type.equals("학부생") || user2.type.equals("복수전공생")) {
			request.setAttribute("tabMenu", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num, 2)));
		} else
			return "RequestDispatcher:jsp/main/error.jsp";
		int per_id=Integer.parseInt(thisperid);
		
		UserBean u = UserDAO.getInstance().getUser(thisperid); //학생의 학번!
		System.out.println(modify);
		
		String usertype=u.type; 
		//제출전: 제출 취소,  제출: 수정 취소,  승인: 뒤로, 관리자: 뒤로   
		//modify 0=제출 2=보기 1=수정
		GraduationLogDTO log =GraduationTestDAO.getInstance().getUserLog(per_id, 1);
		GraduationUserDTO guser = GraduationTestDAO.getInstance().getUser(per_id);
		request.setAttribute("num", num);
		//request.setAttribute("tabMenu", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num, 2)));
		//UserBean에서 학번 이름 가져와도
		//신청접수까지한 학생,   신청접수 이후인 학생을 이안에서 구분 -> DB
		if(usertype.equals("학부생") || usertype.equals("복수전공생")){ 
			if(guser!=null)
				request.setAttribute("graduationuser",gson.toJson(guser)); //학번 이름 학과 졸업시기
			else
				request.setAttribute("graduationuser",gson.toJson(GraduationTestDAO.getInstance().getReqStudent(per_id)));
			request.setAttribute("schedulelist",gson.toJson(GraduationTestDAO.getInstance().getSchedule())); //단계 이름 시작 마감 날짜
			request.setAttribute("modify",modify);
			request.setAttribute("user",UserDAO.getInstance().getUserperid(thisperid));
			request.setAttribute("stage_data",gson.toJson(log));
			request.setAttribute("grduser", gson.toJson(guser));
			request.setAttribute("proflist",GraduationTestDAO.getInstance().getAllProfessor());
			request.setAttribute("reqstudent",gson.toJson(GraduationTestDAO.getInstance().getReqStudent(per_id)));
		}
		else if(usertype.equals("졸업논문관리자")||usertype.contains("교수")) {
			request.setAttribute("graduationuser",gson.toJson(gson.toJson(guser))); //학번 이름 학과 졸업시기
			request.setAttribute("schedulelist",gson.toJson(GraduationTestDAO.getInstance().getSchedule())); //단계 이름 시작 마감 날짜
			request.setAttribute("modify",modify);
			request.setAttribute("user",UserDAO.getInstance().getUserperid(thisperid));
			request.setAttribute("proflist",GraduationTestDAO.getInstance().getAllProfessor());
			request.setAttribute("num",num);
			request.setAttribute("grduser",gson.toJson(guser));
			request.setAttribute("reqstudent",gson.toJson(GraduationTestDAO.getInstance().getReqStudent(per_id)));
		}
		
		
		return "RequestDispatcher:jsp/graduation/form_request_test.jsp";
	}
	
	

}
