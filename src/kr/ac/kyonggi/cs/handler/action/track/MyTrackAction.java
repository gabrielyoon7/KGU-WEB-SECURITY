package kr.ac.kyonggi.cs.handler.action.track;

import com.google.gson.Gson;
import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.dao.track.TrackDao;
import kr.ac.kyonggi.cs.handler.dto.track.TrackUserDto;
import kr.ac.kyonggi.cs.handler.dto.track.TrackUserSubjectDto;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

public class MyTrackAction implements Action {


    //gitgub commit test...

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String num= request.getParameter("num");
        Gson gson = new Gson();
        TrackDao trackDao = TrackDao.getInstance();

        /*
        * 이부분은 세션에서 로그인한 유제의 정보를 가져오는 부분입니다
        * 가져와서 아래 보이는 UserBean에 그 정보를 저장합니다*/
        String user = (String) request.getSession().getAttribute("user");
        UserBean user2 = gson.fromJson(user, UserBean.class);

//        System.out.println(user2.id); // 콘솔에 자신의 정보가 있는지 확인해 주세요
        /*
        * 위에서 가져온 로그인한 유저의 정보를 통해서 track_user 테이블에 있는 유저 정보를 가죠옵니다
        * TrackDao에 이런식으로 데이터를 가져올 수 있는 메서드를 만들어서 사용하면 됩니다
        * */
//        ArrayList<TrackUserDto> trackUserDto = trackDao.getTrackUserByID(user2.id);
        TrackUserDto trackUserDto = trackDao.getTrackUserByID(user2.id);
//        System.out.println(trackUserDto);
        request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getTrackMenu(num)));
        request.setAttribute("num", num);
        if (trackDao.getTrackUserByID(user2.id)==null){
            request.setAttribute("user_id",gson.toJson(user2.id));
            request.setAttribute("user_per_id",gson.toJson(user2.per_id));
            request.setAttribute("user_name",gson.toJson(user2.name));
            return "RequestDispatcher:jsp/track/signup.jsp";
        }

        trackUserDto.setLogDateString(new SimpleDateFormat("yyyy/MM/dd")
                .format(trackUserDto.getLog_date()));



        request.setAttribute("user_info", gson.toJson(trackUserDto));

        //User가 신청한 모든 과목정보
        request.setAttribute("total_subject", gson.toJson(TrackDao.getInstance().getTotalSubject(user2.id)));
        return "RequestDispatcher:jsp/track/mytrack.jsp";
    }
}
