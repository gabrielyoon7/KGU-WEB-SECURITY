package kr.ac.kyonggi.cs.handler.action.upload;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.professor.ProfessorDAO;
import kr.ac.kyonggi.cs.handler.vo.ProfessorBean;


public class ChangeProImageAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		 // 10Mbyte 제한
	    int maxSize  = 1024*1024*20;       
	 
	    // 웹서버 컨테이너 경로
	    String path = request.getSession().getServletContext().getRealPath("/");
	    // 파일 저장 경로(ex : /home/tour/web/ROOT/upload)
	    String savePath = path + "img/professor/";
	    // 업로드 파일명
	    String uploadFile = "";
	 
	    // 실제 저장할 파일명
	    String newFileName = "";
	 
	 
	    int read = 0;
	    byte[] buf = new byte[1024];
	    FileInputStream fin = null;
	    FileOutputStream fout = null;
	    long currentTime = System.currentTimeMillis(); 
	    SimpleDateFormat simDf = new SimpleDateFormat("yyyyMMddHHmmss"); 
	 
	    try{
	        MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
	        
	        String ProfessorID = multi.getParameter("ProfessorID");
	        // 파일업로드
	        uploadFile = multi.getFilesystemName("uploadFile");
	        ProfessorDAO dao = ProfessorDAO.getInstance();
	        ProfessorBean it = dao.getOneProfessor(ProfessorID);
	        // 실제 저장할 파일명(ex : 20140819151221.zip)
	        newFileName = simDf.format(new Date(currentTime))+"-"+it.prof_name+"."+ uploadFile.substring(uploadFile.lastIndexOf(".")+1);
	        
	        
	        // 업로드된 파일 객체 생성
	        File oldFile = new File(savePath + uploadFile);
	        File deleteFile = new File(savePath + it.prof_img);
	        deleteFile.delete();
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
	        
	        dao.changeImage(it.id, newFileName);
	        
	    }catch(Exception e){
	        e.printStackTrace();
	    }
	    
	    return newFileName;

}
}