package kr.ac.kyonggi.cs.handler.action.graduationBack;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;
import kr.ac.kyonggi.cs.common.controller.Action;

import kr.ac.kyonggi.cs.handler.dto.grdBack.BackStudentDTO;
import kr.ac.kyonggi.cs.handler.excel.ExcelWriter;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;

public class GraduateExcelDownAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Gson gson = new Gson();
        String path = request.getServletContext().getRealPath("/uploadFile");

        UserTypeBean type = gson.fromJson((String)request.getSession().getAttribute("type"), UserTypeBean.class);
        if(!type.type_name.equals("졸업논문관리자"))
            return "RequestDispatcher:jsp/main/error.jsp";

        String file_name = request.getParameter("fileName");
        System.out.println(file_name);

        String savePath = path; //저장경로
        String filename = file_name;// 서버에 실제 저장된 파일명
        String orgfilename = file_name; // 실제 내보낼 파일명
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
