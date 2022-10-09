package kr.ac.kyonggi.cs.handler.action.track;

import com.google.gson.Gson;
import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.dao.track.TrackDao;
import kr.ac.kyonggi.cs.handler.dto.track.TrackSubjectDto;
import kr.ac.kyonggi.cs.handler.dto.track.TrackUserDto;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sound.midi.Track;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

public class EnrollPopupAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String num= request.getParameter("num");
        Gson gson = new Gson();

        TrackDao trackDao = TrackDao.getInstance();
        String user = (String) request.getSession().getAttribute("user");
        UserBean user2 = gson.fromJson(user, UserBean.class);
//        System.out.println(user2.id);
        TrackUserDto trackUserDto = trackDao.getTrackUserByID(user2.id);
//        System.out.println(trackUserDto);

        trackUserDto.setLogDateString(new SimpleDateFormat("yyyy/MM/dd")
                .format(trackUserDto.getLog_date()));

        request.setAttribute("user_info", gson.toJson(trackUserDto));
        request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getTrackMenu(num)));
        request.setAttribute("num", num);

        //모든 과목정보(교육과정, 학년, 학기별)
        request.setAttribute("subject_math_science", gson.toJson(TrackDao.getInstance().getMathScienceSubject()));
        request.setAttribute("subject_12_1_1", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2012, 1, 1)));
        request.setAttribute("subject_12_1_2", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2012, 1, 2)));
        request.setAttribute("subject_12_2_1", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2012, 2, 1)));
        request.setAttribute("subject_12_2_2", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2012, 2, 2)));
        request.setAttribute("subject_12_3_1", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2012, 3, 1)));
        request.setAttribute("subject_12_3_2", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2012, 3, 2)));
        request.setAttribute("subject_12_4_1", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2012, 4, 1)));
        request.setAttribute("subject_12_4_2", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2012, 4, 2)));
        request.setAttribute("subject_12_5_1", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2012, 5, 1)));
        request.setAttribute("subject_12_5_2", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2012, 5, 2)));

        request.setAttribute("subject_17_1_1", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2017, 1, 1)));
        request.setAttribute("subject_17_1_2", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2017, 1, 2)));
        request.setAttribute("subject_17_2_1", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2017, 2, 1)));
        request.setAttribute("subject_17_2_2", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2017, 2, 2)));
        request.setAttribute("subject_17_3_1", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2017, 3, 1)));
        request.setAttribute("subject_17_3_2", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2017, 3, 2)));
        request.setAttribute("subject_17_4_1", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2017, 4, 1)));
        request.setAttribute("subject_17_4_2", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2017, 4, 2)));
        request.setAttribute("subject_17_5_1", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2017, 5, 1)));
        request.setAttribute("subject_17_5_2", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2017, 5, 2)));

        request.setAttribute("subject_18_1_1", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2018, 1, 1)));
        request.setAttribute("subject_18_1_2", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2018, 1, 2)));
        request.setAttribute("subject_18_2_1", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2018, 2, 1)));
        request.setAttribute("subject_18_2_2", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2018, 2, 2)));
        request.setAttribute("subject_18_3_1", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2018, 3, 1)));
        request.setAttribute("subject_18_3_2", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2018, 3, 2)));
        request.setAttribute("subject_18_4_1", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2018, 4, 1)));
        request.setAttribute("subject_18_4_2", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2018, 4, 2)));
        request.setAttribute("subject_18_5_1", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2018, 5, 1)));
        request.setAttribute("subject_18_5_2", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2018, 5, 2)));

        //21년도 교육과정 추가
        request.setAttribute("subject_21_1_1", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2021, 1, 1)));
        request.setAttribute("subject_21_1_2", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2021, 1, 2)));
        request.setAttribute("subject_21_2_1", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2021, 2, 1)));
        request.setAttribute("subject_21_2_2", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2021, 2, 2)));
        request.setAttribute("subject_21_3_1", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2021, 3, 1)));
        request.setAttribute("subject_21_3_2", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2021, 3, 2)));
        request.setAttribute("subject_21_4_1", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2021, 4, 1)));
        request.setAttribute("subject_21_4_2", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2021, 4, 2)));
        request.setAttribute("subject_21_5_1", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2021, 5, 1)));
        request.setAttribute("subject_21_5_2", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2021, 5, 2)));

        //User가 학년, 학기별로 선택한 과목 정보
        request.setAttribute("user_subject_total", gson.toJson(TrackDao.getInstance().getTotalSubject(user2.id)));
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
        request.setAttribute("user_subject_math_science", gson.toJson(TrackDao.getInstance().getMathScienceSubjectByUserID(user2.id)));

        return "RequestDispatcher:jsp/track/enroll_popup.jsp";
    }
}