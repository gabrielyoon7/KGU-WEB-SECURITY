package kr.ac.kyonggi.cs.handler.action.graduationBack;

import com.google.gson.Gson;
import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.action.graduation.GraduationIntroActionTest;
import kr.ac.kyonggi.cs.handler.dao.grdBack.GrdBackDAO;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.dto.grdBack.BackStudentDTO;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GraduateMyInfoAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Gson gson = new Gson();
        String num = request.getParameter("num"); // 페이지 넘버 그대로 유지
        String user = (String) request.getSession().getAttribute("user");
        String stage="-1";

        UserBean user2 = gson.fromJson(user, UserBean.class);
        String sper_id = user2.per_id;
        int per_id = Integer.parseInt(sper_id);

        String type = (String)request.getSession().getAttribute("type");
        UserTypeBean type2=gson.fromJson(type,UserTypeBean.class);
        UserBean userbean=gson.fromJson(user,UserBean.class);

        request.setAttribute("num", num);

        if(type2.type_name.equals("학부생")){

            if(!GrdBackDAO.getInstance().isGraduate(per_id)){
                GraduationIntroActionTest graduationIntroActionTest = new GraduationIntroActionTest();
                return graduationIntroActionTest.execute(request, response);
            }

            BackStudentDTO backStudentDTO = GrdBackDAO.getInstance().getStudent(per_id).get(0);

            if(backStudentDTO.getGraduation_type().contains("졸업논문")){
                request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num,2)));
                request.setAttribute("back_student", gson.toJson(GrdBackDAO.getInstance().getStudent(per_id).get(0)));
                request.setAttribute("stage_data", gson.toJson(GrdBackDAO.getInstance().getThesis(per_id).get(0)));
                request.setAttribute("interim_download", gson.toJson(GrdBackDAO.getInstance().getThesis(per_id).get(0).getInterimFileName()));
                request.setAttribute("final_download", gson.toJson(GrdBackDAO.getInstance().getThesis(per_id).get(0).getFinalFileName()));
                return "RequestDispatcher:jsp/graduationBackup/form_thesis_back.jsp";
            }

            else if(backStudentDTO.getGraduation_type().contains("자격증")){
                request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num,2)));
                request.setAttribute("stage_data", gson.toJson(GrdBackDAO.getInstance().getCertificate(per_id).get(0)));
                request.setAttribute("back_student", gson.toJson(GrdBackDAO.getInstance().getStudent(per_id).get(0)));
                request.setAttribute("sc",GrdBackDAO.getInstance().getCertificate(per_id).get(0).getAcqDate().getTime());
                request.setAttribute("download",gson.toJson(GrdBackDAO.getInstance().getCertificate(per_id).get(0).getCerFileName()));
                return "RequestDispatcher:jsp/graduationBackup/form_etc1_back.jsp";

            }

            else if(backStudentDTO.getGraduation_type().contains("공모전")){
                request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num,2)));
                request.setAttribute("stage_data", gson.toJson(GrdBackDAO.getInstance().getContest(per_id).get(0)));
                request.setAttribute("back_student", gson.toJson(GrdBackDAO.getInstance().getStudent(per_id).get(0)));
                request.setAttribute("sc1",GrdBackDAO.getInstance().getContest(per_id).get(0).getAwardDate().getTime());
                request.setAttribute("sc2",GrdBackDAO.getInstance().getContest(per_id).get(0).getOpenDate().getTime());

                return "RequestDispatcher:jsp/graduationBackup/form_etc2_back.jsp";

            }

            else if(backStudentDTO.getGraduation_type().contains("학술대회")){
                request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num,2)));
                request.setAttribute("stage_data", gson.toJson(GrdBackDAO.getInstance().getConference(per_id).get(0)));
                request.setAttribute("back_student", gson.toJson(GrdBackDAO.getInstance().getStudent(per_id).get(0)));
                request.setAttribute("sc",GrdBackDAO.getInstance().getConference(per_id).get(0).getOpenDate().getTime());
                return "RequestDispatcher:jsp/graduationBackup/form_etc3_back.jsp";
            }

            else{
                return "RequestDispatcher:jsp/main/error.jsp";
            }
        }

        else{
            return "RequestDispatcher:jsp/main/error.jsp";
        }
    }
}
