package kr.ac.kyonggi.cs.handler.action.graduationBack;

import com.google.gson.Gson;
import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.grdBack.GrdBackupDao;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.dto.grdBack.TargetStudentDto;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.TreeSet;

public class GraduateBackupAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception{
        Gson gson = new Gson();
        String num = request.getParameter("num");
        String userr=(String)request.getSession().getAttribute("user");
        UserBean user2 = gson.fromJson(userr, UserBean.class);
        System.out.println(user2.type);
        if (user2.type.equals("졸업논문관리자")) {

            request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num, 4)));
        } else if (user2.type.contains("교수")) {
            request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num, 3)));
        } else if (user2.type.equals("학부생") || user2.type.equals("복수전공생")) {
            request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num, 2)));
        } else
            return "RequestDispatcher:jsp/main/error.jsp";

        List<TargetStudentDto> userList = GrdBackupDao.getInstance().getAllTargetStudent();

        TreeSet<String> yearList = new TreeSet<>();
        for(TargetStudentDto targetStudentDto:userList){
            yearList.add(targetStudentDto.getGraduation_date());
        }

        request.setAttribute("userList",gson.toJson(userList));
        //request.setAttribute("yearList",gson.toJson(yearList.iterator()));
        request.setAttribute("yearList",gson.toJson(yearList));
        return "RequestDispatcher:jsp/graduationBackup/graduation_backup.jsp";
    }
}
