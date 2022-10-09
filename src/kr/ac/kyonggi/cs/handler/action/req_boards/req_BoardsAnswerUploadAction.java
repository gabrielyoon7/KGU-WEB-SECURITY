package kr.ac.kyonggi.cs.handler.action.req_boards;

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
import kr.ac.kyonggi.cs.handler.dao.boards.req_BoardsDAO;
import kr.ac.kyonggi.cs.handler.vo.req_BoardsBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class req_BoardsAnswerUploadAction implements Action{

	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//30MB 제한
		int maxSize  = 1024*1024*30;       
		
	    // 웹서버 컨테이너 경로
	    String path = request.getSession().getServletContext().getRealPath("/uploadFile/reqBoards");
	    // 파일 저장 경로(ex : /home/tour/web/ROOT/upload)
	    String savePath = path;
	    // 업로드 파일명
	    String uploadFile = "";
	 
	    // 실제 저장할 파일명
	    String newFileName = "";
	    String id = "fail";
	    
	    int read = 0;
	    byte[] buf = new byte[1024];
	    FileInputStream fin = null;
	    FileOutputStream fout = null;
	    long currentTime = System.currentTimeMillis(); 
	    SimpleDateFormat simDf = new SimpleDateFormat("yyyyMMddHHmmss"); 
	    Gson gson = new Gson();
	    req_BoardsDAO dao = req_BoardsDAO.getInstance();
	    try{
	        MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
	        String userName = multi.getParameter("userName");
	        String FileSequence = multi.getParameter("fileSequence");
	        String boardNumber = multi.getParameter("boardID");
	        UserTypeBean type = gson.fromJson((String)request.getSession().getAttribute("type") , UserTypeBean.class);
	        UserBean user = gson.fromJson((String) request.getSession().getAttribute("user"), UserBean.class);
	        req_BoardsBean it = dao.getBoardRead(Integer.valueOf(boardNumber));
	        if(!it.level.contains(type.for_header))
	        	return "not good level";
	        
	        uploadFile = multi.getFilesystemName("uploadFile");
	        if(uploadFile == null)
	        	return "null";
	        String check = uploadFile.substring(uploadFile.lastIndexOf(".")+1,uploadFile.length());
	        if(check.equals("jsp") || check.equals("php") || check.equals("js") || check.equals("css") || check.equals("xml"))
	        	return "not good file";
	        newFileName = userName + "_" + FileSequence + "_" + uploadFile;
	        StringBuffer hexString = new StringBuffer();
	        try {
		        MessageDigest digest = MessageDigest.getInstance("SHA-256");
		        byte[] hash = digest.digest(newFileName.getBytes("UTF-8"));
	 
	            for (int i = 0; i < hash.length; i++) {
	                String hex = Integer.toHexString(0xff & hash[i]);
	                if(hex.length() == 1) hexString.append('0');
	                hexString.append(hex);
	            }
	        } catch(NoSuchAlgorithmException e) {
	        }
	        
	        dao.uploadAnswerFile(hexString.toString(),uploadFile,newFileName,user.id, boardNumber);
	        id = hexString.toString();
	        
	        // 업로드된 파일 객체 생성
	        File oldFile = new File(savePath, uploadFile);
	        
	        // 실제 저장될 파일 객체 생성
	        File newFile = new File(savePath + "/" + boardNumber + "/" + newFileName);
	 
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
	    
	    return id;
}
}