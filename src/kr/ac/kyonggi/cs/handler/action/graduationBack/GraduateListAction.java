package kr.ac.kyonggi.cs.handler.action.graduationBack;

import com.google.gson.Gson;
import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.grdBack.GrdBackDAO;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GraduateListAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception{
        Gson gson = new Gson();
        String num=(request.getParameter("num"));

        if(num==null)
            return "RequestDispatcher:jsp/main/error.jsp";

        String orderNum = Integer.toString((Integer.parseInt(num)%10));
        request.setAttribute("ordernum", orderNum);//5:유저관리 6:신청자관리
        String type = (String)request.getSession().getAttribute("type");
        String user=(String)request.getSession().getAttribute("user");
        UserTypeBean type2=gson.fromJson(type,UserTypeBean.class);
        UserBean userbean=gson.fromJson(user,UserBean.class);

        if(type2.type_name.equals("졸업논문관리자")) {
            request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num,4)));
        }
        else if(type2.type_name.equals("교수1"))
            request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num,3)));

        if(type2.type_name.equals("졸업논문관리자") || type2.type_name.contains("교수")){
            request.setAttribute("userlist", gson.toJson(GrdBackDAO.getInstance().getAllRecentStudent()));
            request.setAttribute("proflist", gson.toJson(GrdBackDAO.getInstance().getAllProf()));
            request.setAttribute("semesterlist", gson.toJson(GrdBackDAO.getInstance().getAllSemester()));
            request.setAttribute("admissionlist", gson.toJson(GrdBackDAO.getInstance().getAllAdmission()));

            return "RequestDispatcher:jsp/graduationBackup/graduate_list.jsp";
        }

        else
            return "RequestDispatcher:jsp/main/error.jsp";
    }
}
