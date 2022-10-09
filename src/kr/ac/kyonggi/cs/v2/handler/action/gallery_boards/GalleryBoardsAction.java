package kr.ac.kyonggi.cs.v2.handler.action.gallery_boards;

import com.google.gson.Gson;
import kr.ac.kyonggi.cs.v2.common.controller.CustomAction;
import kr.ac.kyonggi.cs.v2.handler.dao.boards.GalleryBoardsDAO;
import kr.ac.kyonggi.cs.v2.handler.dao.main.HomeDAO;
import kr.ac.kyonggi.cs.handler.vo.MenuBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GalleryBoardsAction extends CustomAction {
   @Override
   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      super.execute(request, response);
      String num= request.getParameter("num");
      Gson gson = new Gson();
      request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getTabMenu(num)));
      request.setAttribute("num", num);
      MenuBean it = new HomeDAO().getMenuBean(num);
      request.setAttribute("boardslist", gson.toJson(GalleryBoardsDAO.getInstance().getBoards(Integer.toString(it.id))));
      request.setAttribute("jsp", gson.toJson("gallery_board_list"));
      return "RequestDispatcher:jsp_v2/page/page.jsp";
   }

}