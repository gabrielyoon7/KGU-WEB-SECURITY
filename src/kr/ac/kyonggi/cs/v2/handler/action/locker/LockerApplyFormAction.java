package kr.ac.kyonggi.cs.v2.handler.action.locker;

import com.google.gson.Gson;
import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.graduation.GraduationTestDAO;
/*import kr.ac.kyonggi.cs.handler.dao.locker.LockerDAO;*/ // 기존 임포트 입니다.
import kr.ac.kyonggi.cs.v2.handler.dao.locker.LockerDAO;
import kr.ac.kyonggi.cs.handler.dao.user.UserDAO;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;
import kr.ac.kyonggi.cs.v2.common.controller.CustomAction;
import kr.ac.kyonggi.cs.v2.handler.dto.locker.LockerAssignedUserDTO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;

public class    LockerApplyFormAction extends CustomAction {


    String thisperid;


    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception{
        String num=request.getParameter("num");
        thisperid=request.getParameter("per_id");
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

        String modify=request.getParameter("modify");
        int per_id=Integer.parseInt(thisperid);
        UserBean u = UserDAO.getInstance().getUser(thisperid); //학생의 학번!
        System.out.println(modify);

        String usertype=u.type;
        //제출전: 제출 취소,  제출: 수정 취소,  승인: 뒤로, 관리자: 뒤로
        //modify 0=제출 2=보기 1=수정
//        GraduationLogDTO log = GraduationTestDAO.getInstance().getUserLog(per_id, 1);
        LockerAssignedUserDTO guser = LockerDAO.getInstance().getLockerUser(per_id);
        request.setAttribute("num", num);
        //request.setAttribute("tabMenu", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num, 2)));
        //UserBean에서 학번 이름 가져와도
        //신청접수까지한 학생,   신청접수 이후인 학생을 이안에서 구분 -> DB
        if(usertype.equals("학부생")){
            if(guser!=null)
                request.setAttribute("graduationuser",gson.toJson(guser)); //학번 이름 학과 졸업시기
            else
                request.setAttribute("graduationuser",gson.toJson(LockerDAO.getInstance().getAppliedStudent(per_id)));
            request.setAttribute("schedulelist",gson.toJson(GraduationTestDAO.getInstance().getSchedule())); //단계 이름 시작 마감 날짜
            request.setAttribute("modify",modify);
            request.setAttribute("user",UserDAO.getInstance().getUserperid(thisperid));
//            request.setAttribute("stage_data",gson.toJson(log));
            request.setAttribute("grduser", gson.toJson(guser));
            request.setAttribute("proflist",GraduationTestDAO.getInstance().getAllProfessor());
            request.setAttribute("reqstudent",gson.toJson(LockerDAO.getInstance().getAppliedStudent(per_id)));
            request.setAttribute("lockerList1", gson.toJson(LockerDAO.getInstance().getlockers(1)));
            request.setAttribute("lockerList2", gson.toJson(LockerDAO.getInstance().getlockers(2)));
            request.setAttribute("lockerList3", gson.toJson(LockerDAO.getInstance().getlockers(3)));
            request.setAttribute("lockerList4", gson.toJson(LockerDAO.getInstance().getlockers(4)));
            request.setAttribute("lockerList5", gson.toJson(LockerDAO.getInstance().getlockers(5)));
            request.setAttribute("lockerList6", gson.toJson(LockerDAO.getInstance().getlockers(6)));
            request.setAttribute("lockerList7", gson.toJson(LockerDAO.getInstance().getlockers(7)));
        }
        else if(usertype.equals("사물함관리자")) {
            request.setAttribute("graduationuser",gson.toJson(gson.toJson(guser))); //학번 이름 학과 졸업시기
            request.setAttribute("schedulelist",gson.toJson(GraduationTestDAO.getInstance().getSchedule())); //단계 이름 시작 마감 날짜
            request.setAttribute("modify",modify);
            request.setAttribute("user",UserDAO.getInstance().getUserperid(thisperid));
            request.setAttribute("proflist",GraduationTestDAO.getInstance().getAllProfessor());
            request.setAttribute("num",num);
            request.setAttribute("grduser",gson.toJson(guser));
            request.setAttribute("reqstudent",gson.toJson(LockerDAO.getInstance().getAppliedStudent(per_id)));
            request.setAttribute("lockerList1", gson.toJson(LockerDAO.getInstance().getlockers(1)));
            request.setAttribute("lockerList2", gson.toJson(LockerDAO.getInstance().getlockers(2)));
            request.setAttribute("lockerList3", gson.toJson(LockerDAO.getInstance().getlockers(3)));
            request.setAttribute("lockerList4", gson.toJson(LockerDAO.getInstance().getlockers(4)));
            request.setAttribute("lockerList5", gson.toJson(LockerDAO.getInstance().getlockers(5)));
            request.setAttribute("lockerList6", gson.toJson(LockerDAO.getInstance().getlockers(6)));
            request.setAttribute("lockerList7", gson.toJson(LockerDAO.getInstance().getlockers(7)));
        }
        Date now = new Date();
        String logData=user2.per_id+"-/-/-"+user2.name+"-/-/-"+now+"-/-/-"+"신청페이지요청"+"-/-/-"+"LockerApplyFormAction"+"-/-/-"+"단순 페이지 요청";
        LockerDAO.getInstance().requestLog(logData);
        return "RequestDispatcher:jsp_v2/locker/locker_apply_form.jsp";
    }


}
