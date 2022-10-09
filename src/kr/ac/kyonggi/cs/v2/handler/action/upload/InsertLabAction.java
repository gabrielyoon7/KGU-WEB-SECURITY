package kr.ac.kyonggi.cs.v2.handler.action.upload;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.vo.LaboratoryBean;
import kr.ac.kyonggi.cs.v2.handler.dao.main.LaboratoryDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

public class InsertLabAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 10Mbyte 제한
        int maxSize  = 1024*1024*10;

        // 웹서버 컨테이너 경로
        String path = request.getSession().getServletContext().getRealPath("/");
        // 파일 저장 경로(ex : /home/tour/web/ROOT/upload)
        String savePath = path + "img/laboratory/";
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
        Gson gson = new Gson();
        LaboratoryDAO dao = LaboratoryDAO.getInstance();
        LaboratoryBean result = null;
        try{
            MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());

            String lab_name = multi.getParameter("lab_name");
            String lab_location = multi.getParameter("lab_location");
            String lab_homepage = multi.getParameter("lab_homepage");
            String data = lab_name +"-/-/-"+ lab_location +"-/-/-"+ lab_homepage;

            // 파일업로드
            uploadFile = multi.getFilesystemName("lab_img");

            result = dao.insertLaboratory(data);
            LaboratoryBean it = result;
            // 실제 저장할 파일명(ex : 20140819151221.zip)
            newFileName = simDf.format(new Date(currentTime))+"-"+it.lab_name+"."+ uploadFile.substring(uploadFile.lastIndexOf(".")+1);

            // 업로드된 파일 객체 생성
            File oldFile = new File(savePath + uploadFile);
            try {
                File deleteFile = new File(path + it.lab_img);
                deleteFile.delete();
            } catch(Exception e) {
            }

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
            result = dao.getOneLaboratory(Integer.toString(it.id));
        }catch(Exception e){
            e.printStackTrace();
        }

        return gson.toJson(result);

    }
}