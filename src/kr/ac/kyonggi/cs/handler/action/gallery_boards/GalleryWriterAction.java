package kr.ac.kyonggi.cs.handler.action.gallery_boards;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.boards.NoticeBoardsDAO;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.vo.MenuBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

public class GalleryWriterAction implements Action{

   @Override
   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      Gson gson=new Gson();
      UserTypeBean type = gson.fromJson((String)request.getSession().getAttribute("type"),UserTypeBean.class);
      if(type.board_level > 7)
         return "RequestDispatcher:jsp/main/error.jsp";
      String num=request.getParameter("num");
      request.setAttribute("num", num);
      request.setAttribute("tabmenulist", gson.toJson( HomeDAO.getInstance().getTabMenu(num)));
      return "RequestDispatcher:jsp/gallery/gallery_writer.jsp";
   }

}