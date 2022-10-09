package kr.ac.kyonggi.cs.v2.handler.action.main.menu;

import com.google.gson.Gson;
import kr.ac.kyonggi.cs.v2.common.controller.CustomAction;
import kr.ac.kyonggi.cs.v2.handler.dao.main.LaboratoryDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LaboratoryAction extends CustomAction {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        super.execute(request,response);
        String menu = request.getParameter("num");
        Gson gson = new Gson();
        request.setAttribute("num",menu);
        request.setAttribute("laboratorylist", gson.toJson(LaboratoryDAO.getInstance().getLaboratory()));
        request.setAttribute("jsp", gson.toJson("laboratory")); //*.jsp
        return "RequestDispatcher:jsp_v2/page/page.jsp";
    }
}
