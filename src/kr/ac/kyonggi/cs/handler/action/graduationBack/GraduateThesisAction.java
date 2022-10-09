package kr.ac.kyonggi.cs.handler.action.graduationBack;

import com.google.gson.Gson;
import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.grdBack.GrdBackDAO;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GraduateThesisAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception{
        String perid = request.getParameter("perid");
        String num = request.getParameter("num");
        String grdType = request.getParameter("grdType");

        Gson gson = new Gson();

        if(num==null)
            return "RequestDispatcher:jsp/main/error.jsp";

        String orderNum = Integer.toString((Integer.parseInt(num)%10));
        request.setAttribute("ordernum", orderNum);//5:유저관리 6:신청자관리
        String type = (String)request.getSession().getAttribute("type");
        String user=(String)request.getSession().getAttribute("user");
        UserTypeBean type2=gson.fromJson(type,UserTypeBean.class);
        UserBean userbean=gson.fromJson(user,UserBean.class);

        if(type2.type_name.equals("졸업논문관리자") || type2.type_name.contains("교수")){
            request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num,4)));
            request.setAttribute("back_student", gson.toJson(GrdBackDAO.getInstance().getStudent(Integer.parseInt(perid)).get(0)));
            request.setAttribute("stage_data", gson.toJson(GrdBackDAO.getInstance().getThesis(Integer.parseInt(perid)).get(0)));
            request.setAttribute("interim_download", gson.toJson(GrdBackDAO.getInstance().getThesis(Integer.parseInt(perid)).get(0).getInterimFileName()));
            request.setAttribute("final_download", gson.toJson(GrdBackDAO.getInstance().getThesis(Integer.parseInt(perid)).get(0).getFinalFileName()));
            return "RequestDispatcher:jsp/graduationBackup/form_thesis_back.jsp";
        }

        else{
            return "RequestDispatcher:jsp/main/error.jsp";
        }
    }
}
