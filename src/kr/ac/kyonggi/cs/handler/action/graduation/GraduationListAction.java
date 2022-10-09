// 졸업논문 조회 기능 사용 x
//package kr.ac.kyonggi.cs.handler.action.graduation;
//
//import java.util.ArrayList;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import com.google.gson.Gson;
//
//import kr.ac.kyonggi.cs.common.controller.Action;
//import kr.ac.kyonggi.cs.handler.dao.graduation.graduationDAO;
//import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
//import kr.ac.kyonggi.cs.handler.vo.GrdlogBean;
//import kr.ac.kyonggi.cs.handler.vo.user.UserBean;
//
//public class GraduationListAction implements Action {
//
//   @Override
//   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//      Gson gson = new Gson();
//      String num = request.getParameter("num");
//      String orderNum = Integer.toString((Integer.parseInt(num) % 10));
//      String user = (String) request.getSession().getAttribute("user");// 오류날듯 싶다
//      if(user==null) {
//         return "RequestDispatcher:jsp/main/error.jsp";// 관리자일경우 따로 구분 해주는게 좋을 것 같습니다.
//      }
//      UserBean user2 = gson.fromJson(user, UserBean.class);
//
//      if (user2.type.equals("졸업논문관리자")) {
//         request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num, 4)));
//      } else if(user2.type.contains("교수")){
//         request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num, 3)));
//      }
//      else {
//         return "RequestDispatcher:jsp/main/error.jsp";// 관리자일경우 따로 구분 해주는게 좋을 것 같습니다.
//
//      }
//
//      request.setAttribute("ordernum", orderNum);// 5:대상자유저관리 6:신청자관리 7:졸업논문관리
//      request.setAttribute("request_list", gson.toJson(graduationDAO.getInstance().getLoglist("신청접수")));
//      request.setAttribute("suggest_list", gson.toJson(graduationDAO.getInstance().getLoglist("제안서")));
//      request.setAttribute("mid_list", gson.toJson(graduationDAO.getInstance().getLoglist("중간보고서")));
//      request.setAttribute("final_list", gson.toJson(graduationDAO.getInstance().getLoglist("최종보고서")));
//
//      ArrayList<GrdlogBean> etc_list = new ArrayList<>();
//      etc_list.addAll(new graduationDAO().getLoglist("자격증"));
//      etc_list.addAll(new graduationDAO().getLoglist("공모전"));
//      etc_list.addAll(new graduationDAO().getLoglist("학술대회"));
//      request.setAttribute("etc_list", gson.toJson(etc_list));
//
//      if (user2.type.equals("졸업논문관리자")) {
//         request.setAttribute("userlist", gson.toJson(graduationDAO.getInstance().getAllGrdUsers()));
//         return "RequestDispatcher:jsp/graduation/manage_list.jsp";
//      } else if (user2.type.contains("교수")) {// 수정필요
//         request.setAttribute("userlist", gson.toJson(graduationDAO.getInstance().getmyGrdUsers(user2.name)));
//         return "RequestDispatcher:jsp/graduation/manage_list.jsp";
//      } else {
//         return "RequestDispatcher:jsp/main/error.jsp";
//      }
//   }
//
//}