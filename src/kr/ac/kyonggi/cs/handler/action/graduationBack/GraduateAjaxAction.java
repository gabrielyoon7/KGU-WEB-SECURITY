package kr.ac.kyonggi.cs.handler.action.graduationBack;

import com.google.gson.Gson;
import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.grdBack.GrdBackDAO;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class GraduateAjaxAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception{
        Gson gson = new Gson();
        String req = request.getParameter("req");
        String data = request.getParameter("data");
        HttpSession session = request.getSession();
        UserBean user = gson.fromJson((String)session.getAttribute("user"), UserBean.class);
        UserTypeBean type = gson.fromJson((String)session.getAttribute("type"), UserTypeBean.class);
        String result=null;
        System.out.println("asd");
        switch(req){
            case("grd_search"):
                result = gson.toJson(GrdBackDAO.getInstance().getSearchStudent(data));
                break;

            case("grd_excel_down"):
                result = new GraduateExcelInsertAction().execute(request, response);
                result = gson.toJson(result);
                break;

        }
        return result;
    }
}
