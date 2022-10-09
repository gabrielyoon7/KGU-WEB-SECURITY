package kr.ac.kyonggi.cs.v2.handler.action.gallery_boards;

import com.google.gson.Gson;
import kr.ac.kyonggi.cs.v2.common.controller.CustomAction;
import kr.ac.kyonggi.cs.v2.handler.dao.boards.GalleryBoardsDAO;
import kr.ac.kyonggi.cs.handler.vo.GalleryBoardsBean;
import kr.ac.kyonggi.cs.handler.vo.GalleryImageBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.ArrayList;

public class GalleryBoardsDeleteAction extends CustomAction {

   @Override
   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
       super.execute(request, response);
      GalleryBoardsDAO dao = GalleryBoardsDAO.getInstance();
      Gson gson = new Gson();
      String id = request.getParameter("data");
      GalleryBoardsBean check = dao.getBoard(id);
      UserBean user = gson.fromJson((String)request.getSession().getAttribute("user"), UserBean.class);
      if(user == null)
		return "RequestDispatcher:jsp/main/error.jsp";
      if(!check.writer_id.equals(user.id) && !user.type.contains("관리자"))
         return "error";
      ArrayList<GalleryImageBean> images = null;
       try {
             images = dao.getImages(Integer.valueOf(id));
             GalleryImageBean it = null;
             String path = request.getSession().getServletContext().getRealPath("/") + "img/gallery";
             if(images != null) {
                for(int i = 0 ; i < images.size() ; ++i) {
                   it = images.get(i);
                   File deleteFile = new File(path, it.src);
                   deleteFile.delete();
                }
             }
             dao.deleteBoards(id);
              } catch(Exception e) {
                 return "fail";
              }
       
      return "success";
   }

}