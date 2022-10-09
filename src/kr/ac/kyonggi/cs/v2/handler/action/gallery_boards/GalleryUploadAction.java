package kr.ac.kyonggi.cs.v2.handler.action.gallery_boards;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import kr.ac.kyonggi.cs.v2.common.controller.CustomAction;
import kr.ac.kyonggi.cs.v2.handler.dao.boards.GalleryBoardsDAO;
import kr.ac.kyonggi.cs.v2.handler.dao.main.HomeDAO;
import kr.ac.kyonggi.cs.handler.vo.BoardLevelBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

public class GalleryUploadAction extends CustomAction {
    @Override
   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        super.execute(request, response);
      //500MB 제한
      int maxSize  = 1024*1024*500;       
      
       // 웹서버 컨테이너 경로
       String path = request.getSession().getServletContext().getRealPath("/");
       // 파일 저장 경로(ex : /home/tour/web/ROOT/upload)
       String savePath = path + "img/gallery/";
       // 업로드 파일명
       String uploadFile = "";
    
       // 실제 저장할 파일명
       String newFileName = "";
       String text = "";
       String file = "";
    
       int read = 0;
       byte[] buf = new byte[1024];
       FileInputStream fin = null;
       FileOutputStream fout = null;
       long currentTime = System.currentTimeMillis(); 
       SimpleDateFormat simDf = new SimpleDateFormat("yyyyMMddHHmmss"); 
       Gson gson = new Gson();
       GalleryBoardsDAO dao = GalleryBoardsDAO.getInstance();

       try{
           MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
           String writer_id = gson.fromJson((String)request.getSession().getAttribute("user"), UserBean.class).id;
           String num = multi.getParameter("num");
           text = multi.getParameter("text");
           HomeDAO hDao = HomeDAO.getInstance();
           BoardLevelBean level = hDao.getBoardLevel(hDao.getMenuBean(num).id);
           if(level.write_level < gson.fromJson((String)request.getSession().getAttribute("type"), UserTypeBean.class).board_level)
              return null;
           uploadFile = multi.getFilesystemName("uploadFile");
           String check = uploadFile.substring(uploadFile.lastIndexOf(".")+1,uploadFile.length());
           if(!check.equals("jpg") && !check.equals("jpeg") && !check.equals("png") && !check.equals("gif") && !check.equals("swf"))
              return null;
           newFileName = simDf.format(new Date(currentTime))+"_"+writer_id+"_"+uploadFile;
          
           dao.uploadImage(writer_id, newFileName, text);

           
           // 업로드된 파일 객체 생성
           File oldFile = new File(savePath + uploadFile);
           
           // 실제 저장될 파일 객체 생성
           File newFile = new File(savePath + newFileName);
           
           
    
           // 파일명 rename
           if(!oldFile.renameTo(newFile)){
    
               // rename이 되지 않을경우 강제로 파일을 복사하고 기존파일은 삭제
    
               buf = new byte[1024];
               fin = new FileInputStream(oldFile);
               fout = new FileOutputStream(newFile);
               read = 0;
               while((read=fin.read(buf,0,buf.length))!=-1){
                   fout.write(buf, 0, read);
               }
               
               
               fin.close();
               fout.close();
               oldFile.delete();
           }  
           
       }catch(Exception e){
           e.printStackTrace();
           return "fail";
       }
       
       return newFileName + "-/-/-" + text;

}
}