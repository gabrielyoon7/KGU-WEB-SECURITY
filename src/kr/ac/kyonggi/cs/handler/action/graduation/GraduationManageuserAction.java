package kr.ac.kyonggi.cs.handler.action.graduation;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.graduation.graduationDAO;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.dao.user.UserDAO;
import kr.ac.kyonggi.cs.handler.vo.GrdUserBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;

public class GraduationManageuserAction implements Action{

   @Override
   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
       Gson gson = new Gson();
      String num= request.getParameter("num");
      String per_id=request.getParameter("perid");
      request.setAttribute("schedulelist", gson.toJson(graduationDAO.getInstance().getGrdSchedule()));//일정리스트 셋
      String user = (String) request.getSession().getAttribute("user");// 오류날듯 싶다
      if(user==null||num==null||per_id==null) {//guest
         return "RequestDispatcher:jsp/main/error.jsp";
      }
      UserBean user2 = gson.fromJson(user, UserBean.class);
      
      if (user2.type.equals("졸업논문관리자")) {
         request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num,4)));
      }else if(user2.type.contains("교수")) 
         request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num, 3)));
      else {
            return "RequestDispatcher:jsp/main/error.jsp";//교수, 졸업논문관리자 아니면 무조건 에러표시
         
      }
      
      request.setAttribute("grduser", gson.toJson(UserDAO.getInstance().getUserperid(per_id)));
      request.setAttribute("userlog", gson.toJson(graduationDAO.getInstance().userloglist(per_id)));
      GrdUserBean student = graduationDAO.getInstance().getGrdStudent(per_id);
      GrdUserBean student2 = graduationDAO.getInstance().getReqGrdUsers(per_id);//session_user(X) . selected_user(o)
    
     
      if(student!=null) {
        
         if(!(student.grd_state.equals("최종통과")||student.grd_state.equals("기타자격"))) {
                new graduationDAO().compareDate(student.grd_state,per_id);//날짜 비교
         }
         new graduationDAO().compareDateETC("기타자격", per_id);
         request.setAttribute("suggest_file", gson.toJson(graduationDAO.getInstance().Allgrdlog(per_id)));
         request.setAttribute("graduationuser", gson.toJson(graduationDAO.getInstance().getGrdStudent(per_id)));
      }
      else if(student2!=null) {
         request.setAttribute("graduationuser", gson.toJson(student2));
      }
      else {
       return "RequestDispatcher:jsp/main/error.jsp";
      }
      return "RequestDispatcher:jsp/graduation/graduation_mypage.jsp";
   }

}