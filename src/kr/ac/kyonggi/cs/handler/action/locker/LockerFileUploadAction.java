package kr.ac.kyonggi.cs.handler.action.locker;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.locker.LockerDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;

//GraduationUploadAction 참조 및 class.properties 업데이트 필요. stage를 삭제했는데 이를 어떻게 보완할건지 고민해야함.
public class LockerFileUploadAction implements Action {
//NoticeInsertBoardFileAction에서 더 많이 참고해야 할것 같음..

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception{
        //30MB 제한
        int maxSize  = 1024*1024*50;
        String per_id = request.getParameter("writer"); //학번

        // 웹서버 컨테이너 경로
        String folder="";
        folder="/uploadFile/locker/return/"+per_id;

        String path = request.getSession().getServletContext().getRealPath(folder);
        //폴더가 없다면 생성
        File dircheck = new File(path);
        if(!dircheck.exists()) {
            dircheck.mkdirs();
        }

        String savePath = path;
        System.out.println(savePath);
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

        LockerDAO newdao = LockerDAO.getInstance();
        try{
            MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
            String writer = multi.getParameter("writer");
            String stage = multi.getParameter("stage");
            uploadFile = multi.getFilesystemName("file_data");
            String check = uploadFile.substring(uploadFile.lastIndexOf(".")+1,uploadFile.length());
            if(check.equals("jsp") || check.equals("php") || check.equals("js") || check.equals("css") || check.equals("xml")) {
                return "fail";
            }

            //newFileName = simDf.format(new Date(currentTime))+"-"+uploadFile;
            newFileName = uploadFile;
//            newFileName = per_id;
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
//
  //          int sta = Integer.parseInt(stage);
            // newdao.insertFile(newFileName,Integer.parseInt(writer), sta);
            newdao.insertFile(uploadFile,Integer.parseInt(writer));

            // 업로드된 파일 객체 생성
            File oldFile = new File(savePath, uploadFile);

            // 실제 저장될 파일 객체 생성
//            File newFile = new File(savePath, uploadFile);
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
        }

        String obj = uploadFile+"-/-/-"+newFileName;
        //String obj = uploadFile+"-/-/-"+testSHA256(newFileName);

        return  obj;

    }
    //jonghun sha256뺌
    public String testSHA256(String str){

        String SHA = "";

        try{

            MessageDigest sh = MessageDigest.getInstance("SHA-256");

            sh.update(str.getBytes());

            byte byteData[] = sh.digest();

            StringBuffer sb = new StringBuffer();

            for(int i = 0 ; i < byteData.length ; i++){

                sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));

            }

            SHA = sb.toString();



        }catch(NoSuchAlgorithmException e){

            e.printStackTrace();

            SHA = null;

        }

        return SHA;

    }

}
