package kr.ac.kyonggi.cs.handler.action.req_boards;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.boards.req_BoardsDAO;
import kr.ac.kyonggi.cs.handler.vo.req_AnswerFileBean;
import kr.ac.kyonggi.cs.handler.vo.req_BoardsBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

public class req_BoardsDownloadAction implements Action {

	
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Gson gson = new Gson();
		String id = request.getParameter("id");
	    String root = request.getSession().getServletContext().getRealPath("/uploadFile/reqBoards");
	    UserTypeBean userType = gson.fromJson((String) request.getSession().getAttribute("type"), UserTypeBean.class);
	    UserBean user = gson.fromJson((String)request.getSession().getAttribute("user"), UserBean.class);
	    req_BoardsDAO dao = req_BoardsDAO.getInstance();
	    req_AnswerFileBean it = dao.getFile(id);
	    req_BoardsBean board = dao.getBoardRead(Integer.valueOf(it.board_id));
	    if(it == null)
	    	return null;
	    if(!it.user_id.equals(user.id) && !userType.for_header.equals("관리자") && board.for_who != 1)
	    	return null;
	
	    String savePath = root +"/"+ board.id;
	    // 서버에 실제 저장된 파일명
	    String filename = it.real_name;
	     
	    // 실제 내보낼 파일명
	    String orgfilename = it.original_name;
	      
	    InputStream in = null;
	    OutputStream os = null;
	    File file = null;
	    boolean skip = false;
	    String client = "";
	 
	    try{
	        // 파일을 읽어 스트림에 담기
	        try{
	            file = new File(savePath, filename);
	            in = new FileInputStream(file);
	        }catch(FileNotFoundException fe){
	            skip = true;
	        }
	         
	        client = request.getHeader("User-Agent");
	 
	        // 파일 다운로드 헤더 지정
	        response.reset() ;
	        response.setContentType("application/octet-stream");
	        response.setHeader("Content-Description", "JSP Generated Data");
	 
	        if(!skip){
	            // IE
	            if(client.indexOf("MSIE") != -1){
	                response.setHeader ("Content-Disposition", "attachment;filename="+new String(orgfilename.getBytes("KSC5601"),"ISO8859_1"));
	            }else{
	                // 한글 파일명 처리
	                orgfilename = new String(orgfilename.getBytes("utf-8"),"iso-8859-1");
	 
	                response.setHeader("Content-Disposition", ("attachment; filename=\"" + orgfilename + "\""));
	                response.setHeader("Content-Type", "application/octet-stream;charset=utf-8");
	            } 
	             
	            response.setHeader ("Content-Length", ""+file.length());
	       
	            os = response.getOutputStream();
	            byte b[] = new byte[(int)file.length()];
	            int leng = 0;
	             
	            while( (leng = in.read(b)) > 0 ){
	                os.write(b,0,leng);
	            }
	 
	        }
	         
	        in.close();
	        os.close();
	 
	    }catch(Exception e){
	      e.printStackTrace();
	    }

		return null;
	}

}
