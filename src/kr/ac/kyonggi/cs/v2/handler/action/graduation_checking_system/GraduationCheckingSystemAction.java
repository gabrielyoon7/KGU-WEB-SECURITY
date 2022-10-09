package kr.ac.kyonggi.cs.v2.handler.action.graduation_checking_system;

import com.google.gson.Gson;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;
import kr.ac.kyonggi.cs.v2.common.controller.CustomAction;
import kr.ac.kyonggi.cs.v2.handler.dao.graduation_checking_system.GraduationCheckingSystemDAO;
import kr.ac.kyonggi.cs.v2.handler.dto.graduation_checking_system.StudentDTO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * MySQL에서 Group by 관련 오류 발생 시 다음과 같은 명령어를 입력하면 해결됨
 * SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
 *
 * */

public class GraduationCheckingSystemAction extends CustomAction {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        super.execute(request,response);
        Gson gson = new Gson();
        String type = (String) request.getSession().getAttribute("type");
        UserTypeBean type2=gson.fromJson(type,UserTypeBean.class);
        String type_name = type2.type_name;
//        System.out.println(type_name);
        request.setAttribute("pageMenuList", gson.toJson(GraduationCheckingSystemDAO.getInstance().getGcsPageMenu(type_name)));

        UserBean user = gson.fromJson((String)request.getSession().getAttribute("user"), UserBean.class);
        String user_id = null;
        if (user != null) {
            user_id = user.id;
        }

        String num = request.getParameter("num");
        String student_id = request.getParameter("id");

        if(num==null){
            num="121";
        }


        StudentDTO student = null;
        if((type_name.equals("홈페이지관리자") && student_id!=null)){
            student = GraduationCheckingSystemDAO.getInstance().getOneStudent(student_id);
        }
        else {
            student = GraduationCheckingSystemDAO.getInstance().getOneStudent(user_id);
        }


        if(num.equals("121")){ // 졸업요건 진단
            if (user != null) {
                request.setAttribute("getStudent", gson.toJson(student)); //학생정보 불러오기
                if(student!=null){
                    request.setAttribute("getOneGraduationRequirement", gson.toJson(GraduationCheckingSystemDAO.getInstance().getOneGraduationRequirement(student.major, student.enter_year)));
                    request.setAttribute("getOneEngineeringRequirement", gson.toJson(GraduationCheckingSystemDAO.getInstance().getOneEngineeringRequirement(student.major, student.enter_year)));
                    request.setAttribute("getLectureHistory", gson.toJson(GraduationCheckingSystemDAO.getInstance().getLectureHistory(student.per_id)));
                    request.setAttribute("getLecture", gson.toJson(GraduationCheckingSystemDAO.getInstance().getLecture()));
                    request.setAttribute("getSpecialLecture",  gson.toJson(GraduationCheckingSystemDAO.getInstance().getSpecialLecture(student.major, student.enter_year)));
                    request.setAttribute("getTrackRequirement", gson.toJson(GraduationCheckingSystemDAO.getInstance().getTrackRequirement(student.major, student.enter_year)));
                    request.setAttribute("getLectureByCode", gson.toJson(GraduationCheckingSystemDAO.getInstance().getLectureByCode()));
                    request.setAttribute("getUserExternalLecture", gson.toJson(GraduationCheckingSystemDAO.getInstance().getUserExternalLecture(user_id))); // 관리자 모드로 접속 시 user_id가 관리자 것으로 적용되는 문제가 있어 조치가 필요함.
                    request.setAttribute("getSimilarSub",gson.toJson(GraduationCheckingSystemDAO.getInstance().getSimilarSub()));
                }
            }
            else {
                return "RequestDispatcher:jsp/main/error.jsp";
            }
            request.setAttribute("jsp", gson.toJson("student_main")); //*.jsp
        }
        else if(num.equals("122")){ //수강이력 입력하기
            request.setAttribute("getLecture", gson.toJson(GraduationCheckingSystemDAO.getInstance().getLecture()));
            request.setAttribute("getExternalLecture", gson.toJson(GraduationCheckingSystemDAO.getInstance().getExternalLecture()));
            request.setAttribute("getStudent", gson.toJson(GraduationCheckingSystemDAO.getInstance().getOneStudent(user_id))); //학생정보 불러오기
            request.setAttribute("getAllYear", gson.toJson(GraduationCheckingSystemDAO.getInstance().getAllYear()));
            request.setAttribute("getLectureHistory", gson.toJson(GraduationCheckingSystemDAO.getInstance().getLectureHistory(user_id)));
            request.setAttribute("getExternalLectureHistory", gson.toJson(GraduationCheckingSystemDAO.getInstance().getExternalLectureHistory(user_id)));
            request.setAttribute("getGraduationRequirement",  gson.toJson(GraduationCheckingSystemDAO.getInstance().getGraduationRequirement())); //only for menu
            if(student!=null){
                request.setAttribute("getSpecialLecture",  gson.toJson(GraduationCheckingSystemDAO.getInstance().getSpecialLecture(student.major, student.enter_year)));
            }
            request.setAttribute("getLectureByCode", gson.toJson(GraduationCheckingSystemDAO.getInstance().getLectureByCode()));
            request.setAttribute("jsp", gson.toJson("student_lecture_insert")); //*.jsp
        }
        else if(num.equals("123") && type_name.equals("홈페이지관리자")){ //졸업요건 관리
            request.setAttribute("getGraduationRequirement",  gson.toJson(GraduationCheckingSystemDAO.getInstance().getGraduationRequirement())); //only for menu
            request.setAttribute("getLectureByCode", gson.toJson(GraduationCheckingSystemDAO.getInstance().getLectureByCode()));
            request.setAttribute("getSimilarSubject", gson.toJson(GraduationCheckingSystemDAO.getInstance().getSimilarSub()));
            String major = request.getParameter("major");
            String year = request.getParameter("year");
            if(major==null || year==null){
                request.setAttribute("jsp", gson.toJson("admin_requirement_main"));
            }
            else {
                request.setAttribute("getEngineeringRequirement",  gson.toJson(GraduationCheckingSystemDAO.getInstance().getOneEngineeringRequirement(major, year)));
                request.setAttribute("getOneGraduationRequirement",  gson.toJson(GraduationCheckingSystemDAO.getInstance().getOneGraduationRequirement(major, year)));
                request.setAttribute("getSpecialLecture",  gson.toJson(GraduationCheckingSystemDAO.getInstance().getSpecialLecture(major, year)));
                request.setAttribute("getLecture", gson.toJson(GraduationCheckingSystemDAO.getInstance().getLecture()));
                request.setAttribute("getTrackRequirement", gson.toJson(GraduationCheckingSystemDAO.getInstance().getTrackRequirement(major, year)));

                request.setAttribute("major",  gson.toJson(major));
                request.setAttribute("year",  gson.toJson(year));
                request.setAttribute("jsp", gson.toJson("admin_requirement_manager")); //*.jsp
            }
        }
        else if(num.equals("124") && type_name.equals("홈페이지관리자")){ //학과강좌 관리
            request.setAttribute("getLecture",  gson.toJson(GraduationCheckingSystemDAO.getInstance().getLecture()));
            request.setAttribute("jsp", gson.toJson("admin_lecture_manager")); //*.jsp
        }
        else if(num.equals("125") && type_name.equals("홈페이지관리자")){ //학생DB 조회
            request.setAttribute("getAllStudent",  gson.toJson(GraduationCheckingSystemDAO.getInstance().getAllStudent())); //학생 전체 데이터 불러오기
            request.setAttribute("jsp", gson.toJson("admin_student_list")); //*.jsp
        }
        else{
            return "RequestDispatcher:jsp/main/error.jsp";
        }

        return "RequestDispatcher:jsp_v2/page/page.jsp";
    }
}