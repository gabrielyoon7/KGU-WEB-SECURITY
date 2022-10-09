package kr.ac.kyonggi.cs.handler.action.locker;

import com.google.gson.Gson;
import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.locker.LockerDAO;
import kr.ac.kyonggi.cs.handler.dao.user.UserDAO;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LockerAssignedListAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String num=request.getParameter("num");
        Gson gson = new Gson();
        String user = (String) request.getSession().getAttribute("user"); //user 정보를 jsp로부터 받(getAttribute)아옴.
        if(user==null) {//로그인 하지 않은 사용자가 임의로 url 접근시 error page 출력
            return"RequestDispatcher:jsp/main/error.jsp";
        }

        UserBean user2 = gson.fromJson(user, UserBean.class);
        if (user2.type.contains("사물함관리자")) {//사물함 관리자 명칭 혹은 분류 방법 필요할듯. 일단은 관리자 아이디 cssitemgr로 접속하는걸로 개발 시작. 관리자로 접속 시 탭메뉴는 이걸로 불러옴
            request.setAttribute("tabmenulist", gson.toJson(LockerDAO.getInstance().getTabMenu(0))); //관리자 id = 0
        }
//        else if (user2.type.contains("학부생")) {//사용자가 접속시 좌측 탭메뉴는 이걸로 불러온다
//            request.setAttribute("tabmenulist", gson.toJson(LockerDAO.getInstance().getTabMenu(1))); //사용자 id = 1
//        }
        else { //관리자도 학부생도 아닌 경우에는 error
            return "RequestDispatcher:jsp/main/error.jsp";
        }
        //여기까지는 다른 Action에도 공통으로 들어가야 하는 사항임. 위로 복붙

        //여기서 부터는 이 jsp에 맞는 설정임.

        request.setAttribute("num", num);
        request.setAttribute("alluser", gson.toJson(UserDAO.getInstance().getAlluser()));
        request.setAttribute("AIuser", gson.toJson(UserDAO.getInstance().getAIuser()));
        request.setAttribute("allAssignedStudents", gson.toJson(LockerDAO.getInstance().getAllAssignedStudents()));
        return "RequestDispatcher:jsp/locker/locker_assigned_list.jsp";
    }
}
