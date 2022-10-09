package kr.ac.kyonggi.cs.handler.action.track;

import com.google.gson.Gson;
import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.dao.track.TrackDao;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CourseViewAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String num= request.getParameter("num");
        Gson gson = new Gson();
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

        request.setAttribute("subject_17_1_1", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2017, 1, 1)));
        request.setAttribute("subject_17_1_2", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2017, 1, 2)));
        request.setAttribute("subject_17_2_1", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2017, 2, 1)));
        request.setAttribute("subject_17_2_2", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2017, 2, 2)));
        request.setAttribute("subject_17_3_1", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2017, 3, 1)));
        request.setAttribute("subject_17_3_2", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2017, 3, 2)));
        request.setAttribute("subject_17_4_1", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2017, 4, 1)));
        request.setAttribute("subject_17_4_2", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2017, 4, 2)));

        request.setAttribute("subject_18_1_1", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2018, 1, 1)));
        request.setAttribute("subject_18_1_2", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2018, 1, 2)));
        request.setAttribute("subject_18_2_1", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2018, 2, 1)));
        request.setAttribute("subject_18_2_2", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2018, 2, 2)));
        request.setAttribute("subject_18_3_1", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2018, 3, 1)));
        request.setAttribute("subject_18_3_2", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2018, 3, 2)));
        request.setAttribute("subject_18_4_1", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2018, 4, 1)));
        request.setAttribute("subject_18_4_2", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2018, 4, 2)));

        //21년도 교육과정 추가
        request.setAttribute("subject_21_1_1", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2021, 1, 1)));
        request.setAttribute("subject_21_1_2", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2021, 1, 2)));
        request.setAttribute("subject_21_2_1", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2021, 2, 1)));
        request.setAttribute("subject_21_2_2", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2021, 2, 2)));
        request.setAttribute("subject_21_3_1", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2021, 3, 1)));
        request.setAttribute("subject_21_3_2", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2021, 3, 2)));
        request.setAttribute("subject_21_4_1", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2021, 4, 1)));
        request.setAttribute("subject_21_4_2", gson.toJson(TrackDao.getInstance().getTrackSubjectByYear(2021, 4, 2)));


        return "RequestDispatcher:jsp/track/course.jsp";
    }
}