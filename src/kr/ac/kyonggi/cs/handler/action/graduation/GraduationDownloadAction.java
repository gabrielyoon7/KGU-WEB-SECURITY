package kr.ac.kyonggi.cs.handler.action.graduation;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.graduation.GraduationTestDAO;
import kr.ac.kyonggi.cs.handler.dao.graduation.graduationDAO;
import kr.ac.kyonggi.cs.handler.vo.NoticeFileBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

public class GraduationDownloadAction implements Action {

   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      Gson gson = new Gson();
      //권한 체크 추가 필요
      String id = request.getParameter("id"); //학번
       String root = request.getSession().getServletContext().getRealPath("/uploadFile/graduation");
       UserTypeBean userType = gson.fromJson((String) request.getSession().getAttribute("type"), UserTypeBean.class);
       if(userType.board_level>6)
          return "RequestDispatcher:jsp/main/error.jsp";
       NoticeFileBean it = graduationDAO.getInstance().getFile(id);
       String realfile = GraduationTestDAO.getInstance().getDownloadFileName(1, Integer.parseInt(id));

       String savePath = root;
       // �꽌踰꾩뿉 �떎�젣 ���옣�맂 �뙆�씪紐�
       String filename = realfile;
        
       // �떎�젣 �궡蹂대궪 �뙆�씪紐�
       String orgfilename = it.filename;
         
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