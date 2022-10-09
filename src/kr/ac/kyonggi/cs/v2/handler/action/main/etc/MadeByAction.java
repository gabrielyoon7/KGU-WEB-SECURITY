package kr.ac.kyonggi.cs.v2.handler.action.main.etc;

import com.google.gson.Gson;
import kr.ac.kyonggi.cs.v2.common.controller.CustomAction;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MadeByAction extends CustomAction {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        super.execute(request,response);
        Gson gson = new Gson();
        request.setAttribute("jsp", gson.toJson("madeby")); //*.jsp
        return "RequestDispatcher:jsp_v2/page_stand_alone/page_stand_alone.jsp";
    }
}
