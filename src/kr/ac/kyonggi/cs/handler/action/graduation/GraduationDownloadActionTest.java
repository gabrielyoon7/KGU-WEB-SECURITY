package kr.ac.kyonggi.cs.handler.action.graduation;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.reflect.Type;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.graduation.GraduationTestDAO;
import kr.ac.kyonggi.cs.handler.dao.graduation.graduationDAO;
import kr.ac.kyonggi.cs.handler.vo.NoticeFileBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

public class GraduationDownloadActionTest implements Action{
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	      Gson gson = new Gson();
	      //권한 체크 추가 필요
	      String per_id = request.getParameter("id"); //학번
	      String stage = request.getParameter("stage");
	      int s= Integer.parseInt(stage);
	      String folder="";

	      System.out.println(per_id + ", " + stage);
		  if(s==3) {
			  folder="/uploadFile/graduation/mid/"+per_id;
		  }
		  else if(s==4) {
			  folder="/uploadFile/graduation/final/"+per_id;
		  }
		  else if(s==5) { //자공학
			  folder="/uploadFile/graduation/certificate/"+per_id;
		  }
		  //공모전 상장사본
		  else if(s==6) {
			  folder="/uploadFile/graduation/contest/award/"+per_id;		  
		  }
		  //공모전 추가자료
		  else if(s==7) {
			  folder="/uploadFile/graduation/contest/add/"+per_id;
		  }
		  //학술대회 논문자료
		  else if(s==8){
			  folder="/uploadFile/graduation/conference/thesis/"+per_id; 
		  }
		  //학술대회 추가자료
		  else if(s==9) {
			  folder="/uploadFile/graduation/conference/add/"+per_id; 
		  }
		  
	       String root = request.getSession().getServletContext().getRealPath(folder);
	       UserTypeBean userType = gson.fromJson((String) request.getSession().getAttribute("type"), UserTypeBean.class);
	       if(userType.board_level>6)
	          return "RequestDispatcher:jsp/main/error.jsp";
	   
	   
	   String realfile=null;
	   
	   if(s==3) {
		   realfile = GraduationTestDAO.getInstance().getDownloadFileName(1, Integer.parseInt(per_id));
	   }
	   else if(s==4){
		   realfile = GraduationTestDAO.getInstance().getDownloadFileName(2, Integer.parseInt(per_id));
	   }
	   else if(s==5) {
		   realfile = GraduationTestDAO.getInstance().getEtcFileName(1, Integer.parseInt(per_id));
	   }
	   else if(s==6) {
		   realfile = GraduationTestDAO.getInstance().getEtcFileName(4, Integer.parseInt(per_id));
	   }
	   else if(s==7){
		   realfile = GraduationTestDAO.getInstance().getEtcFileName(5, Integer.parseInt(per_id));
	   }
	   
	   else if(s==8) {
		   realfile = GraduationTestDAO.getInstance().getEtcFileName(2, Integer.parseInt(per_id));
	   }
	   
	   else if(s==9) {
		   realfile = GraduationTestDAO.getInstance().getEtcFileName(3, Integer.parseInt(per_id));
	   }
		   
	       
	      List< String> array = gson.fromJson((String) realfile, new TypeToken<List<String>>() {}.getType());
	      
	       String savePath = root;
	      
	       String filename = array.get(0);
	       System.out.println(savePath);
	        System.out.println(filename);
	      
	       String orgfilename =array.get(0);
	         
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
	         //      IE
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
	        //  os.close();
	    
	       }catch(Exception e){
	         e.printStackTrace();
	       }

	      return null;
	   }

	}