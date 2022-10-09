package kr.ac.kyonggi.cs.handler.action.graduationBack;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.grdBack.GrdBackDAO;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.List;

public class GraduateDownloadBack implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Gson gson = new Gson();
        //권한 체크 추가 필요
        String per_id = request.getParameter("id"); //학번
        String stage = request.getParameter("stage");
        int s= Integer.parseInt(stage);
        String folder="";

        //중간보고서 파일
        if(s==1) {
            folder="/uploadFile/graduation/thesis/"+per_id;
        }

        //최종보고서 파일
        else if(s==2) {
            folder="/uploadFile/graduation/thesis/"+per_id;
        }

        //자격증
        else if(s==3) {
            folder="/uploadFile/graduation/certificate/"+per_id;
        }

        //공모전 수상 파일
        else if(s==4) {
            folder="/uploadFile/graduation/contest/"+per_id;
        }

        //공모전 추가 파일
        else if(s==5) {
            folder="/uploadFile/graduation/contest/"+per_id;
        }

        //학술대회 논문 파일
        else if(s==6) {
            folder="/uploadFile/graduation/conference/"+per_id;
        }

        //학술대회 증명 파일
        else if(s==7) {
            folder="/uploadFile/graduation/conference/"+per_id;
        }



        String root = request.getSession().getServletContext().getRealPath(folder);
        UserTypeBean userType = gson.fromJson((String) request.getSession().getAttribute("type"), UserTypeBean.class);
        if(userType.board_level>6)
            return "RequestDispatcher:jsp/main/error.jsp";

        String realfile=null;

        //중간보고서 파일
        if(s==1) {
            realfile = GrdBackDAO.getInstance().getThesis(Integer.parseInt(per_id)).get(0).getInterimFileName();
        }

        //최종보고서 파일
        else if(s==2){
            realfile = GrdBackDAO.getInstance().getThesis(Integer.parseInt(per_id)).get(0).getFinalFileName();
        }

        //자격증
        else if(s==3) {
            realfile = GrdBackDAO.getInstance().getCertificate(Integer.parseInt(per_id)).get(0).getCerFileName();
        }

        //공모전 수상 파일
        else if(s==4) {
            realfile = GrdBackDAO.getInstance().getContest(Integer.parseInt(per_id)).get(0).getAwardFileName();
        }

        //공모전 추가 파일
        else if(s==5) {
            realfile = GrdBackDAO.getInstance().getContest(Integer.parseInt(per_id)).get(0).getAddFileName();
        }

        //학술대회 논문 파일
        else if(s==6) {
            realfile = GrdBackDAO.getInstance().getConference(Integer.parseInt(per_id)).get(0).getThesisFileName();
        }

        //학술대회 증명 파일
        else if(s==7) {
            realfile = GrdBackDAO.getInstance().getConference(Integer.parseInt(per_id)).get(0).getProofFileName();
        }


        String savePath = root;
        String filename = realfile;
        String orgfilename =realfile;

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
