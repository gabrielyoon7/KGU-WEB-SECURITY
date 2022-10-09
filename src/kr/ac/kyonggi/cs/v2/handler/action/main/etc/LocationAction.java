package kr.ac.kyonggi.cs.v2.handler.action.main.etc;

import com.google.gson.Gson;
import kr.ac.kyonggi.cs.v2.common.controller.CustomAction;
import kr.ac.kyonggi.cs.v2.handler.dao.main.HomeDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LocationAction extends CustomAction {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        super.execute(request,response);
        Gson gson = new Gson();
        request.setAttribute("text", gson.toJson(HomeDAO.getInstance().getText("1")));
        request.setAttribute("jsp", gson.toJson("location")); //*.jsp
        return "RequestDispatcher:jsp_v2/page_stand_alone/page_stand_alone.jsp";
    }

}
