package kr.ac.kyonggi.cs.v2.handler.action.locker;

import com.google.gson.Gson;
import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.v2.handler.dao.locker.LockerDAO;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;
import kr.ac.kyonggi.cs.v2.common.controller.CustomAction;
import kr.ac.kyonggi.cs.v2.handler.dto.locker.LockerAssignedUserDTO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LockerReturnAction2  extends CustomAction {
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
            request.setAttribute("tabMenu", gson.toJson(LockerDAO.getInstance().getTabMenu(0))); //관리자 id = 0
        }
        else if (user2.type.contains("학부생")) {//사용자가 접속시 좌측 탭메뉴는 이걸로 불러온다
            request.setAttribute("tabMenu", gson.toJson(LockerDAO.getInstance().getTabMenu(1))); //사용자 id = 1
        }
        else { //관리자도 학부생도 아닌 경우에는 error
            return "RequestDispatcher:jsp/main/error.jsp";
        }
        //여기까지는 다른 Action에도 공통으로 들어가야 하는 사항임. 위로 복붙


        String sper_id = user2.per_id;
        int per_id = Integer.parseInt(sper_id); //학번 불러오기
        LockerAssignedUserDTO assignedStudent = LockerDAO.getInstance().getAssignedStudent(per_id);

//        GraduationUserDTO grduser = GraduationTestDAO.getInstance().getGrdUser(per_id); //수정필요



        request.setAttribute("num", num);

        request.setAttribute("assignedStudent", assignedStudent); //배정자 정보 불러오기

        request.setAttribute("user",gson.fromJson(user, UserBean.class));

        return "RequestDispatcher:jsp_v2/page/locker/locker_return_form2.jsp";
    }
}
