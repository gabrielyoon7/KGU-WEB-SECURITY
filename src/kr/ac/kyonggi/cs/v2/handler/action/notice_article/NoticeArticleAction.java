package kr.ac.kyonggi.cs.v2.handler.action.notice_article;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.v2.common.controller.Action;
import kr.ac.kyonggi.cs.v2.handler.dao.main.NoticeBoardsDAO;
import kr.ac.kyonggi.cs.v2.handler.dao.main.HomeDAO;
import kr.ac.kyonggi.cs.handler.vo.BoardLevelBean;
import kr.ac.kyonggi.cs.handler.vo.MenuBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;
import kr.ac.kyonggi.cs.handler.vo.*;

public class NoticeArticleAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String num = request.getParameter("num");
        System.out.println(num);
        Gson gson = new Gson();
        request.setAttribute("num", num);
        HomeDAO homedao = HomeDAO.getInstance();
        NoticeBoardsDAO nodao = NoticeBoardsDAO.getInstance();
        MenuBean it = homedao.getMenuBean(num);
        System.out.println("it : "+it);
        UserTypeBean type = gson.fromJson((String) request.getSession().getAttribute("type"), UserTypeBean.class);
        System.out.println("type : "+type.type_name);
        if (it.min_level > type.board_level || type.board_level > it.max_level)
            return "RequestDispatcher:jsp/main/error.jsp";
        BoardLevelBean checklevel = homedao.getBoardLevel(it.id);
// 여기 위에서 오류 나는 것으로 추정됨
        System.out.println("ㄱㄱㄱ");
        UserBean user = gson.fromJson((String) request.getSession().getAttribute("user"),UserBean.class);// 오류날듯 싶다
        System.out.println("user : "+user);
        if(user != null) {
            if (user.type.equals("졸업논문관리자"))
                request.setAttribute("pageMenuList", gson.toJson(homedao.getGrdTabMenu(num,4)));
            else if(user.type.contains("교수")) {
                request.setAttribute("pageMenuList", gson.toJson(homedao.getGrdTabMenu(num,3)));
            }
            else if(user.type.equals("학부생") || user.type.equals("복수전공생"))
                request.setAttribute("pageMenuList", gson.toJson(homedao.getGrdTabMenu(num,2)));
            else {
                request.setAttribute("pageMenuList", gson.toJson(homedao.getGrdTabMenu(num,1)));
            }
        }else
            request.setAttribute("pageMenuList", gson.toJson(homedao.getGrdTabMenu(num,2)));
        request.setAttribute("readLevel", Integer.toString(checklevel.read_level));
        request.setAttribute("writeLevel", Integer.toString(checklevel.write_level));
        request.setAttribute("menu", gson.toJson(it));
        request.setAttribute("fileBoardId", gson.toJson(nodao.getFileBoardId()));
        System.out.println("ㄹㄹㄹㄹㄹ");
        if (it.page_title.equals("전체공지")) {
            request.setAttribute("boardslist", gson.toJson(nodao.getAllBoards()));
        } else {
            request.setAttribute("boardslist", gson.toJson(nodao.getBoards(Integer.toString(it.id))));
        }
        System.out.println("ㅇㅇ");
        request.setAttribute("jsp", gson.toJson("notice_list")); //*.jsp
        return "RequestDispatcher:jsp_v2/page/page.jsp";
    }

}