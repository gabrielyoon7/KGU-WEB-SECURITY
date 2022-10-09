package kr.ac.kyonggi.cs.handler.action.req_boards;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.boards.req_BoardsDAO;
import kr.ac.kyonggi.cs.handler.vo.req_BoardsBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

public class req_BoardsAllDownloadAction implements Action {


	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Gson gson = new Gson();
		String id = request.getParameter("id");
		String root = request.getSession().getServletContext().getRealPath("/uploadFile/reqBoards");
		UserTypeBean userType = gson.fromJson((String) request.getSession().getAttribute("type"), UserTypeBean.class);
		UserBean user = gson.fromJson((String)request.getSession().getAttribute("user"), UserBean.class);
		if(user == null)
			return "RequestDispatcher:jsp/main/error.jsp";
		req_BoardsDAO dao = req_BoardsDAO.getInstance();
		req_BoardsBean board = dao.getBoardRead(Integer.valueOf(id));
		if(!board.student_id.equals(user.id) && !userType.for_header.equals("관리자"))
			return null;

		String savePath = root +"/"+ board.id;

		File dir = new File(savePath);
		File[] counts = dir.listFiles();
		if(counts.length == 0)
			return null;
		String[] list = dir.list();
		String _path;
		if (!dir.canRead() || !dir.canWrite())
			return null;
		int len = list.length;
		if (savePath.charAt(savePath.length() - 1) != '/')
			_path = savePath + "/";
		else
			_path = savePath;
		try {
			ZipOutputStream zip_out = new ZipOutputStream(new BufferedOutputStream(new FileOutputStream(root+"/"+board.title+"_파일모음.zip"), 2048));
			for (int i = 0; i < len; i++)
				zip_folder("",new File(_path + list[i]), zip_out);
			zip_out.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
		}


		/**
		 * ZipOutputStream를 넘겨 받아서 하나의 압축파일로 만든다.
		 * @param parent 상위폴더명
		 * @param file 압축할 파일
		 * @param zout 압축전체스트림
		 * @throws IOException
		 */




		// 서버에 실제 저장된 파일명
		String filename = board.title + "_파일모음.zip";

		// 실제 내보낼 파일명
		String orgfilename = board.title + "_파일모음.zip";

		InputStream in = null;
		OutputStream os = null;
		File file = null;
		boolean skip = false;
		String client = "";

		try{
			// 파일을 읽어 스트림에 담기
			try{
				file = new File(root, filename);
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
			File deleteFile = new File(root, filename);
			deleteFile.delete();
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}

	void zip_folder(String parent, File file, ZipOutputStream zout) throws IOException {
		byte[] data = new byte[2048];
		int read;
		if (file.isFile()) {
			ZipEntry entry = new ZipEntry(parent + file.getName());
			zout.putNextEntry(entry);
			BufferedInputStream instream = new BufferedInputStream(new FileInputStream(file));
			while ((read = instream.read(data, 0, 2048)) != -1)
				zout.write(data, 0, read);
			zout.flush();
			zout.closeEntry();
			instream.close();
		} else if (file.isDirectory()) {
			String parentString = file.getPath();//.replace(root,"");
			parentString = parentString.substring(0,parentString.length() - file.getName().length());
			ZipEntry entry = new ZipEntry(parentString+file.getName()+"/");
			zout.putNextEntry(entry);

			String[] list = file.list();
			if (list != null) {
				int len = list.length;
				for (int i = 0; i < len; i++) {
					zip_folder(entry.getName(),new File(file.getPath() + "/" + list[i]), zout);
				}
			}
		}
	}
}

