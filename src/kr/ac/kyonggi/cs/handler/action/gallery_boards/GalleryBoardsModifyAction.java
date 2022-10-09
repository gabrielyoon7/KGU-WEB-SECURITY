package kr.ac.kyonggi.cs.handler.action.gallery_boards;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.boards.NoticeBoardsDAO;
import kr.ac.kyonggi.cs.handler.dao.boards.GalleryBoardsDAO;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.vo.NoticeBoardsBean;
import kr.ac.kyonggi.cs.handler.vo.NoticeFileBean;
import kr.ac.kyonggi.cs.handler.vo.GalleryBoardsBean;
import kr.ac.kyonggi.cs.handler.vo.GalleryImageBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

public class GalleryBoardsModifyAction implements Action{

   @Override
   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
      
      return "RequestDispatcher:jsp/gallery/gallery_modifier.jsp";
   }

}