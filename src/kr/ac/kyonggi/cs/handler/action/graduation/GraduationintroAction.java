package kr.ac.kyonggi.cs.handler.action.graduation;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.graduation.GraduationTestDAO;
import kr.ac.kyonggi.cs.handler.dao.graduation.graduationDAO;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.dao.user.UserDAO;
import kr.ac.kyonggi.cs.handler.dto.graduation.GraduationStateListDTO;
import kr.ac.kyonggi.cs.handler.vo.GrdUserBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;


public class GraduationintroAction implements Action {

   @Override
   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {// 나의졸업논문=>액션
      Gson gson = new Gson();
      String num = request.getParameter("num"); //페이지 넘버 그대로 유지
      String user = (String) request.getSession().getAttribute("user");// 오류날듯 싶다
      
      if(user==null||num==null) {
         return "RequestDispatcher:jsp/main/error.jsp";
      }
      
      
      
      
      UserBean user2 = gson.fromJson(user, UserBean.class);
      if(!(user2.type.equals("학부생")||user2.type.equals("복수전공생")))
         return "RequestDispatcher:jsp/main/error.jsp";
      String per_id = user2.per_id;
      GrdUserBean student = graduationDAO.getInstance().getReqGrdUsers(per_id);
      GrdUserBean real_student = graduationDAO.getInstance().getGrdStudent(per_id);
      String stage = "-1";
      
      ArrayList<GraduationStateListDTO> temp = GraduationTestDAO.getInstance().getGrduStateList(Integer.parseInt(per_id),1);
     
    
      if (student != null) {
         stage = "2";
         request.setAttribute("graduationuser", gson.toJson(student));
         request.setAttribute("stage", "0");
      }
      if (real_student != null) {
         stage = "1"; 
         if(!(real_student.grd_state.equals("최종통과") || real_student.grd_state.equals("기타자격")))
           graduationDAO.getInstance().compareDate(real_student.grd_state,per_id);//날짜 비교
         graduationDAO.getInstance().compareDateETC("기타자격",per_id);
         real_student = graduationDAO.getInstance().getGrdStudent(per_id);
         request.setAttribute("graduationuser", gson.toJson(real_student));
         request.setAttribute("stage", "1");
      }
  
     request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num,2)));
      request.setAttribute("schedulelist", gson.toJson(graduationDAO.getInstance().getGrdSchedule()));// 일정리스트 셋
      request.setAttribute("num", num);// num 셋= tabMenulist 받아오기위함
      request.setAttribute("grduser", gson.toJson(UserDAO.getInstance().getUserperid(per_id)));
      request.setAttribute("userlog", gson.toJson(graduationDAO.getInstance().userloglist(per_id)));
      if (stage.equals("-1")) {
         return "RequestDispatcher:jsp/graduation/no_graduation_mypage.jsp";
      }
            request.setAttribute("suggest_file", gson.toJson(graduationDAO.getInstance().Allgrdlog(per_id)));
         return "RequestDispatcher:jsp/graduation/graduation_mypage.jsp";
      }
   }