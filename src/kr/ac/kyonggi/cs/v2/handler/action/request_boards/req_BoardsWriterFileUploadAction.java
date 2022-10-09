package kr.ac.kyonggi.cs.v2.handler.action.request_boards;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.boards.req_BoardsDAO;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class req_BoardsWriterFileUploadAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//30MB 제한
		int maxSize  = 1024*1024*50;       
		
		// 웹서버 컨테이너 경로
		String path = request.getSession().getServletContext().getRealPath("/uploadFile/reqBoards");
		// 파일 저장 경로(ex : /home/tour/web/ROOT/upload)
		String savePath = path;

		// 업로드 파일명
		String uploadFile = "";

		// 실제 저장할 파일명
		String newFileName = "";

		String idForJson = "";

		int read = 0;
		byte[] buf = new byte[1024];
		FileInputStream fin = null;
		FileOutputStream fout = null;
		long currentTime = System.currentTimeMillis(); 
		SimpleDateFormat simDf = new SimpleDateFormat("yyyyMMddHHmmss"); 
		Gson gson = new Gson();
		req_BoardsDAO dao = req_BoardsDAO.getInstance();
		int checkingImage = 0;
		try{
			MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
			String writer = multi.getParameter("writer");
			uploadFile = multi.getFilesystemName("file_data");
			String check = uploadFile.substring(uploadFile.lastIndexOf(".")+1,uploadFile.length());
			if(check.equals("jsp") || check.equals("php") || check.equals("js") || check.equals("css") || check.equals("war")) {
				JsonObject forError = new JsonObject();
				forError.addProperty("error", "올릴 수 없는 확장자입니다.");
				File deleteFile = new File(path, uploadFile);
				deleteFile.delete();
				return gson.toJson(forError);
			}
			 if(check.equals("jpg") || check.equals("jpeg") || check.equals("png") || check.equals("bmp") || check.equals("gif")) 
		        	checkingImage = 1;
			UserTypeBean type = gson.fromJson((String) request.getSession().getAttribute("type"), UserTypeBean.class);
			if(type.board_level > 3) {
				JsonObject forError = new JsonObject();
				forError.addProperty("error", "파일 업로드가 불가능한 사람입니다.");
				File deleteFile = new File(path, uploadFile);
				deleteFile.delete();
				return gson.toJson(forError);
			}
			newFileName = simDf.format(new Date(currentTime))+"-"+uploadFile;
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
				e.printStackTrace();
			}
			idForJson = hexString.toString();

			dao.uploadWriterFile(hexString.toString(), uploadFile, newFileName, writer);

			// 업로드된 파일 객체 생성
			File oldFile = new File(savePath, uploadFile);

			// 실제 저장될 파일 객체 생성
			File newFile = new File(savePath, newFileName);

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
			JsonObject forError = new JsonObject();
			forError.addProperty("error", "알 수 없는 오류입니다.");
			return gson.toJson(forError);
		}
		JsonObject forFinish = new JsonObject();
		JsonArray forArray = new JsonArray();
		JsonObject intoArray = new JsonObject();
		intoArray.addProperty("url", "req_writer_delete_file.do");
		JsonObject forIntoArray = new JsonObject();
		forIntoArray.addProperty("id", idForJson);
		intoArray.add("extra", forIntoArray);
		forArray.add(intoArray);
		forFinish.add("initialPreviewConfig", forArray);
		JsonArray forArray2 = new JsonArray();
		if(checkingImage == 0)
			forArray2.add("<span style='font-size : 14px; font-family : NanumSquare ;'>" + uploadFile + " 업로드 성공</span>");
		else
			forArray2.add("<img src='uploadFile/reqBoards/" + newFileName + "' style='width : 200px'><span style='font-size : 12px'> " + uploadFile + " 업로드 성공</span>");
		forFinish.add("initialPreview", forArray2);
		Gson gson2 = new GsonBuilder().disableHtmlEscaping().create();
		return gson2.toJson(forFinish);
	}
}