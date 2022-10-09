package kr.ac.kyonggi.cs.handler.action.gallery_boards;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.boards.NoticeBoardsDAO;
import kr.ac.kyonggi.cs.handler.dao.boards.GalleryBoardsDAO;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.vo.MenuBean;

public class GalleryBoardsAction implements Action{
   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      String num= request.getParameter("num");
      Gson gson = new Gson();
      request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getTabMenu(num)));
      request.setAttribute("num", num);
      MenuBean it = new HomeDAO().getMenuBean(num);
      request.setAttribute("boardslist", gson.toJson(GalleryBoardsDAO.getInstance().getBoards(Integer.toString(it.id))));
      return "RequestDispatcher:jsp/gallery/gallery_list.jsp";
   }

}