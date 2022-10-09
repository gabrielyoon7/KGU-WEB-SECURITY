package kr.ac.kyonggi.cs.v2.handler.action.gallery_boards;

import com.google.gson.Gson;
import kr.ac.kyonggi.cs.v2.common.controller.CustomAction;
import kr.ac.kyonggi.cs.v2.handler.dao.main.HomeDAO;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GalleryWriterAction extends CustomAction {

   @Override
   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      super.execute(request, response);
      Gson gson=new Gson();
      UserTypeBean type = gson.fromJson((String)request.getSession().getAttribute("type"),UserTypeBean.class);
      if(type.board_level > 7)
         return "RequestDispatcher:jsp/main/error.jsp";
      String num=request.getParameter("num");
      request.setAttribute("num", num);
      request.setAttribute("tabmenulist", gson.toJson( HomeDAO.getInstance().getTabMenu(num)));
      request.setAttribute("jsp", gson.toJson("gallery_board_writer"));
      return "RequestDispatcher:jsp_v2/page/page.jsp";
   }

}