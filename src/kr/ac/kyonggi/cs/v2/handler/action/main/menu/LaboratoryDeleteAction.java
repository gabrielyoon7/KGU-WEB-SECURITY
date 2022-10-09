package kr.ac.kyonggi.cs.v2.handler.action.main.menu;

import com.google.gson.Gson;
import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.vo.LaboratoryBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;
import kr.ac.kyonggi.cs.v2.handler.dao.main.LaboratoryDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;

public class LaboratoryDeleteAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        LaboratoryDAO dao = LaboratoryDAO.getInstance();
        Gson gson = new Gson();
        String id = request.getParameter("data");
        LaboratoryBean it = dao.getOneLaboratory(id);
        UserBean user = gson.fromJson((String)request.getSession().getAttribute("user"), UserBean.class);
        if(!user.type.equals("관리자"))
            return "";
        try {
            String path = request.getSession().getServletContext().getRealPath("/");
            File deleteFile = new File(path, it.lab_img);
            deleteFile.delete();
        } catch(Exception e) {
            e.printStackTrace();
        }
        dao.deleteLaboratory(id);
        return "";
    }

}