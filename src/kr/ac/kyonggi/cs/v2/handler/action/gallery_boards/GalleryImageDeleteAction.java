package kr.ac.kyonggi.cs.v2.handler.action.gallery_boards;

import com.google.gson.Gson;
import kr.ac.kyonggi.cs.v2.common.controller.CustomAction;
import kr.ac.kyonggi.cs.v2.handler.dao.boards.GalleryBoardsDAO;
import kr.ac.kyonggi.cs.handler.vo.GalleryImageBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;

public class GalleryImageDeleteAction extends CustomAction {
   @Override
   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      super.execute(request, response);
      String imageName = request.getParameter("imageName");
      Gson gson = new Gson();
      UserBean user = gson.fromJson((String)request.getSession().getAttribute("user"),UserBean.class);
      GalleryBoardsDAO dao = GalleryBoardsDAO.getInstance();
      GalleryImageBean it = dao.getImage(imageName);
      if(user == null)
    	  return "RequestDispatcher:jsp/main/error.jsp";
      if(!it.writer_id.equals(user.id) && !user.type.equals("관리자") && !user.type.equals("홈페이지관리자"))
         return "RequestDispatcher:jsp/main/error.jsp";
      String path = request.getSession().getServletContext().getRealPath("/img/gallery");
      try {
         String result = dao.deleteImage(imageName);
         if(result.equals("fail"))
            return "fail";
         File deleteFile = new File(path,imageName);
         deleteFile.delete();
      }catch(Exception e) {
         e.printStackTrace();
         return "fail";
      }
      return "success";
   }

}