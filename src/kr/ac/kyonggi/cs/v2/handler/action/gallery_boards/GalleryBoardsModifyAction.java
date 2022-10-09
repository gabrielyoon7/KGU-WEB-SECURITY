package kr.ac.kyonggi.cs.v2.handler.action.gallery_boards;

import com.google.gson.Gson;
import kr.ac.kyonggi.cs.v2.common.controller.CustomAction;
import kr.ac.kyonggi.cs.v2.handler.dao.boards.GalleryBoardsDAO;
import kr.ac.kyonggi.cs.v2.handler.dao.main.HomeDAO;
import kr.ac.kyonggi.cs.handler.vo.GalleryBoardsBean;
import kr.ac.kyonggi.cs.handler.vo.GalleryImageBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;

public class GalleryBoardsModifyAction extends CustomAction {

   @Override
   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      super.execute(request, response);
      Gson gson = new Gson();
      String id=request.getParameter("id");
      GalleryBoardsBean checkBoard = GalleryBoardsDAO.getInstance().getBoard(id);
      UserTypeBean userType = gson.fromJson((String)request.getSession().getAttribute("type"), UserTypeBean.class);
      UserBean user = gson.fromJson((String) request.getSession().getAttribute("user"), UserBean.class);
      if(user == null)
    	  return "RequestDispatcher:jsp/main/error.jsp";
      if(!checkBoard.writer_id.equals(user.id) && !userType.for_header.equals("관리자"))
         return "RequestDispatcher:jsp/main/error.jsp";
      
      String num=request.getParameter("num");
      request.setAttribute("boards", gson.toJson(checkBoard));
      request.setAttribute("num", num);
      request.setAttribute("id", id);
      request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getTabMenu(num)));
      ArrayList<GalleryImageBean> it =GalleryBoardsDAO.getInstance().getImages(Integer.valueOf(id));
      if(it != null) {
         request.setAttribute("images", gson.toJson(it));
      }

      request.setAttribute("jsp", gson.toJson("gallery_board_modifier"));
      return "RequestDispatcher:jsp_v2/page/page.jsp";
   }

}