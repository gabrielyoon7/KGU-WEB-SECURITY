package kr.ac.kyonggi.cs.handler.action.req_boards;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.boards.req_BoardsDAO;
import kr.ac.kyonggi.cs.handler.excel.ReqExcelWriter;
import kr.ac.kyonggi.cs.handler.vo.req_AnswerBean;
import kr.ac.kyonggi.cs.handler.vo.req_BoardsBean;
import kr.ac.kyonggi.cs.handler.vo.req_QuestionBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

public class req_BoardsExcelAction implements Action{

	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Gson gson = new Gson();
		UserTypeBean type = gson.fromJson((String)request.getSession().getAttribute("type"), UserTypeBean.class);
		if(type.type_name.equals("게스트"))
			return "RequestDispatcher:jsp/main/error.jsp";
		String path = request.getServletContext().getRealPath("/uploadFile");
		String boardId = request.getParameter("id");
		req_BoardsDAO dao = req_BoardsDAO.getInstance();
		req_BoardsBean checkBoard = dao.getBoardRead(Integer.valueOf(boardId));
		UserBean user= gson.fromJson((String) request.getSession().getAttribute("user"), UserBean.class);
		String name = dao.getBoardRead(Integer.valueOf(boardId)).title;
		ArrayList<req_QuestionBean> questionCount = dao.getQuestions(boardId + "-/-/-" + type.for_header + "-/-/-" + user.id + "-/-/-" + type.board_level);
		if(type.board_level != 0 && !checkBoard.student_id.equals(user.id))
			return "RequestDispatcher:jsp/main/error.jsp";
		ArrayList<req_AnswerBean> list = dao.getResult(boardId);
		ReqExcelWriter excel = new ReqExcelWriter();
		excel.xlsWriter(list,questionCount,path);
		
	    String savePath = path; //저장경로
	    String filename = "신청관리.xls";// 서버에 실제 저장된 파일명
	    String orgfilename = name +".xls"; // 실제 내보낼 파일명
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
	        response.setHeader("Content-Description","JSP Generated Data");
	 
	 
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
	    
	    try {
	    	File deleteFile = new File(savePath, filename);
	    	deleteFile.delete();
	    }catch(Exception e) {
	    	e.printStackTrace();
	    }
	    
		return null;
	}

}
