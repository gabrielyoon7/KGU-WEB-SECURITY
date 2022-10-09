package kr.ac.kyonggi.cs.v2.handler.action.gallery_boards;

import com.google.gson.Gson;
import kr.ac.kyonggi.cs.v2.common.controller.CustomAction;
import kr.ac.kyonggi.cs.v2.handler.dao.boards.GalleryBoardsDAO;
import kr.ac.kyonggi.cs.v2.handler.dao.main.HomeDAO;
import kr.ac.kyonggi.cs.handler.vo.BoardLevelBean;
import kr.ac.kyonggi.cs.handler.vo.GalleryBoardsBean;
import kr.ac.kyonggi.cs.handler.vo.GalleryImageBean;
import kr.ac.kyonggi.cs.handler.vo.MenuBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;

public class GalleryReaderAction extends CustomAction {
   @Override
   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      super.execute(request, response);
      int id = Integer.parseInt(request.getParameter("id"));
      String num = request.getParameter("num");
      Gson gson = new Gson();
      GalleryBoardsBean checkBoard = GalleryBoardsDAO.getInstance().getBoard(Integer.toString(id));
      MenuBean itsMenu = gson.fromJson(HomeDAO.getInstance().getOneMenu(Integer.toString(checkBoard.category)), MenuBean.class);
      BoardLevelBean checklevel = HomeDAO.getInstance().getBoardLevel(itsMenu.id);
      UserTypeBean type = gson.fromJson((String)request.getSession().getAttribute("type"), UserTypeBean.class);
      if(type.board_level > checklevel.read_level)
         return "RequestDispatcher:jsp/main/error.jsp";
      
      String whatISeen = (String)request.getSession().getAttribute("galleryBoard");
      String check = "|" + id + "|";
      if(whatISeen == null) {
         String newWhatISeen = "|" + id + "|";
         request.getSession().setAttribute("galleryBoard", newWhatISeen);
         GalleryBoardsDAO.getInstance().plusViews(id);
      }
      else {
         if(!whatISeen.contains(check)) {
            whatISeen += check;
            request.getSession().setAttribute("galleryBoard", whatISeen);
            GalleryBoardsDAO.getInstance().plusViews(id);
          }
      }
      
      request.setAttribute("boardLevel",gson.toJson(checklevel));
      request.setAttribute("boards", gson.toJson(new GalleryBoardsDAO().getBoard(Integer.toString(id))));
      request.setAttribute("tabmenulist", gson.toJson(new HomeDAO().getTabMenu(num)));
      request.setAttribute("num", num);
      request.setAttribute("id", Integer.toString(id));
      ArrayList<GalleryImageBean> it = GalleryBoardsDAO.getInstance().getImages(GalleryBoardsDAO.getInstance().getBoard(Integer.toString(id)).id);

      if(it != null) {
         request.setAttribute("images", gson.toJson(it));
      }
      request.setAttribute("nextlist", gson.toJson(GalleryBoardsDAO.getInstance().getNextPrevious(Integer.toString(id))));
      request.setAttribute("jsp", gson.toJson("gallery_board_reader"));
      return "RequestDispatcher:jsp_v2/page/page.jsp";
   }

}