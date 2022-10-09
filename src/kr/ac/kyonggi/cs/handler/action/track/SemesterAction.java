package kr.ac.kyonggi.cs.handler.action.track;

import com.google.gson.Gson;
import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.dao.track.TrackDao;
import kr.ac.kyonggi.cs.handler.dto.track.TrackUserDto;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;

import static kr.ac.kyonggi.cs.handler.dao.track.TrackDao.trackDao;

public class SemesterAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String num= request.getParameter("num");
        Gson gson = new Gson();

        TrackDao trackDao = TrackDao.getInstance();
        String user = (String) request.getSession().getAttribute("user");
        UserBean user2 = gson.fromJson(user, UserBean.class);
        request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getTrackMenu(num)));
        request.setAttribute("num", num);
//        System.out.println(user2.id);
        TrackUserDto trackUserDto = trackDao.getTrackUserByID(user2.id);
        if (trackDao.getTrackUserByID(user2.id)==null){
            request.setAttribute("user_id",gson.toJson(user2.id));
            request.setAttribute("user_per_id",gson.toJson(user2.per_id));
            request.setAttribute("user_name",gson.toJson(user2.name));
            return "RequestDispatcher:jsp/track/signup.jsp";
        }
//        System.out.println(trackUserDto);
        trackUserDto.setLogDateString(new SimpleDateFormat("yyyy/MM/dd")
                .format(trackUserDto.getLog_date()));

        request.setAttribute("user_info", gson.toJson(trackUserDto));



        //User가 신청한 과목정보(학년 학기별)
        request.setAttribute("user_subject_11", gson.toJson(TrackDao.getInstance().getUserSubjectByIDAndGradeSem(user2.id, "11")));
        request.setAttribute("user_subject_12", gson.toJson(TrackDao.getInstance().getUserSubjectByIDAndGradeSem(user2.id, "12")));
        request.setAttribute("user_subject_21", gson.toJson(TrackDao.getInstance().getUserSubjectByIDAndGradeSem(user2.id, "21")));
        request.setAttribute("user_subject_22", gson.toJson(TrackDao.getInstance().getUserSubjectByIDAndGradeSem(user2.id, "22")));
        request.setAttribute("user_subject_31", gson.toJson(TrackDao.getInstance().getUserSubjectByIDAndGradeSem(user2.id, "31")));
        request.setAttribute("user_subject_32", gson.toJson(TrackDao.getInstance().getUserSubjectByIDAndGradeSem(user2.id, "32")));
        request.setAttribute("user_subject_41", gson.toJson(TrackDao.getInstance().getUserSubjectByIDAndGradeSem(user2.id, "41")));
        request.setAttribute("user_subject_42", gson.toJson(TrackDao.getInstance().getUserSubjectByIDAndGradeSem(user2.id, "42")));
        request.setAttribute("user_subject_51", gson.toJson(TrackDao.getInstance().getUserSubjectByIDAndGradeSem(user2.id, "51")));
        request.setAttribute("user_subject_52", gson.toJson(TrackDao.getInstance().getUserSubjectByIDAndGradeSem(user2.id, "52")));

        //User가 신청한 학기 과목의 수강연도
        request.setAttribute("user_year_11", gson.toJson(TrackDao.getInstance().getYearAndSemByGradeSem(user2.id, "11")));
        request.setAttribute("user_year_12", gson.toJson(TrackDao.getInstance().getYearAndSemByGradeSem(user2.id, "12")));
        request.setAttribute("user_year_21", gson.toJson(TrackDao.getInstance().getYearAndSemByGradeSem(user2.id, "21")));
        request.setAttribute("user_year_22", gson.toJson(TrackDao.getInstance().getYearAndSemByGradeSem(user2.id, "22")));
        request.setAttribute("user_year_31", gson.toJson(TrackDao.getInstance().getYearAndSemByGradeSem(user2.id, "31")));
        request.setAttribute("user_year_32", gson.toJson(TrackDao.getInstance().getYearAndSemByGradeSem(user2.id, "32")));
        request.setAttribute("user_year_41", gson.toJson(TrackDao.getInstance().getYearAndSemByGradeSem(user2.id, "41")));
        request.setAttribute("user_year_42", gson.toJson(TrackDao.getInstance().getYearAndSemByGradeSem(user2.id, "42")));
        request.setAttribute("user_year_51", gson.toJson(TrackDao.getInstance().getYearAndSemByGradeSem(user2.id, "51")));
        request.setAttribute("user_year_52", gson.toJson(TrackDao.getInstance().getYearAndSemByGradeSem(user2.id, "52")));
        return "RequestDispatcher:jsp/track/semester.jsp";
    }
}