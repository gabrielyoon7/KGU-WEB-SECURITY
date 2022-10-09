package kr.ac.kyonggi.cs.v2.handler.action.notice_article;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.v2.common.controller.Action;
import kr.ac.kyonggi.cs.v2.handler.dao.main.NoticeBoardsDAO;
import kr.ac.kyonggi.cs.v2.handler.dao.main.HomeDAO;
import kr.ac.kyonggi.cs.handler.vo.NoticeBoardsBean;
import kr.ac.kyonggi.cs.handler.vo.NoticeFileBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

public class NoticeArticleModifierAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Gson gson = new Gson();
        int id=Integer.parseInt(request.getParameter("id"));
        NoticeBoardsDAO nodao = NoticeBoardsDAO.getInstance();
        HomeDAO homedao = HomeDAO.getInstance();
        NoticeBoardsBean checkBoard = nodao.getBoardRead(id);
        UserTypeBean userType = gson.fromJson((String)request.getSession().getAttribute("type"), UserTypeBean.class);
        if(userType.type_name.equals("게스트"))
            return "RequestDispatcher:jsp/main/error.jsp";
        UserBean user = gson.fromJson((String) request.getSession().getAttribute("user"), UserBean.class);
        if(!checkBoard.student_id.equals(user.id) && !userType.for_header.equals("관리자"))
            return "RequestDispatcher:jsp/main/error.jsp";

        String num=request.getParameter("num");
        request.setAttribute("boards", gson.toJson(nodao.getBoardRead(id)));
        request.setAttribute("num", num);
        request.setAttribute("id", Integer.toString(id));
        if (userType.type_name.equals("졸업논문관리자"))
            request.setAttribute("pageMenuList", gson.toJson(homedao.getGrdTabMenu(num,4)));
        else if(userType.type_name.contains("교수")) {
            request.setAttribute("pageMenuList", gson.toJson(homedao.getGrdTabMenu(num,3)));
        }
        else if(userType.type_name.equals("학부생") || userType.type_name.equals("복수전공생"))
            request.setAttribute("pageMenuList", gson.toJson(homedao.getGrdTabMenu(num,2)));
        else {
            request.setAttribute("pageMenuList", gson.toJson(homedao.getGrdTabMenu(num,1)));
        }
        ArrayList<NoticeFileBean> it = nodao.readFile(id);
        if(it != null) {
            request.setAttribute("file", gson.toJson(it));
        }
        request.setAttribute("jsp", gson.toJson("notice_modify")); //*.jsp
        return "RequestDispatcher:jsp_v2/page/page.jsp";
    }

}
