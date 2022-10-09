package kr.ac.kyonggi.cs.v2.handler.action.main.menu;

import com.google.gson.Gson;
import kr.ac.kyonggi.cs.v2.common.controller.CustomAction;
import kr.ac.kyonggi.cs.v2.handler.dao.main.HomeDAO;
import kr.ac.kyonggi.cs.v2.handler.dao.main.ProfessorDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ProfessorAction extends CustomAction {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        super.execute(request, response);
        Gson gson = new Gson();

        String menu = request.getParameter("num");
        request.setAttribute("num",menu);

        request.setAttribute("professorlist", gson.toJson(ProfessorDAO.getInstance().getProfessor()));

        request.setAttribute("jsp", gson.toJson("professor")); //*.jsp
        return "RequestDispatcher:jsp_v2/page/page.jsp";
    }
}