package kr.ac.kyonggi.cs.handler.excel;
 
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import kr.ac.kyonggi.cs.handler.dto.grdBack.BackStudentDTO;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import kr.ac.kyonggi.cs.handler.vo.GrdUserBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;
import kr.ac.kyonggi.cs.handler.dto.graduation.GraduationEtcDTO;
import kr.ac.kyonggi.cs.handler.dto.graduation.GraduationUserDTO;
import kr.ac.kyonggi.cs.handler.stateenum.Capstone;
import kr.ac.kyonggi.cs.handler.stateenum.Level;
import kr.ac.kyonggi.cs.handler.stateenum.State;
 
 
public class ExcelWriter {
    
  

   public String xlsWriter(ArrayList<UserBean> arraylist,String path) throws IOException, NoSuchAlgorithmException {
       //DB조회후 데이터를 담았다는 가상의 데이터
       ArrayList<ArrayList<String>> array=new ArrayList<>();
       for(int i=0;i<arraylist.size();i++) {
          UserBean user = arraylist.get(i);
          if(user.type.equals("관리자")) {
             continue;
          }
       
          ArrayList<String> a = new ArrayList<>();
          a.add(user.id);
          a.add(user.name);
          a.add(user.birth);
          a.add(user.type);
          a.add(user.email);
          a.add(user.phone);
          a.add(user.major);
          a.add(user.per_id);
          a.add(user.grade);
          a.add(user.state);
          array.add(a);
       }
       
       
       //1차로 workbook을 생성
       HSSFWorkbook workbook=new HSSFWorkbook();
       //2차는 sheet생성
       HSSFSheet sheet=workbook.createSheet("등록 현황");
       //엑셀의 행
       HSSFRow row=null;
       //엑셀의 셀
       HSSFCell cell=null;
       //임의의 DB데이터 조회
       row=sheet.createRow(0);
       String header[]= {"ID","이름","생일","타입","이메일","휴대폰","전공","학번","학년","학적상태"};
       for(int k=0;k<header.length;k++) {
         cell=row.createCell(k);
         cell.setCellValue(header[k]);
      }
       
       if(array !=null &&array.size() >0){
           for(int i=0;i<array.size();i++){
              ArrayList<String> user = array.get(i);
               row=sheet.createRow((short)i+1);
               if(user !=null &&user.size() >0){
                   for(int j=0;j<user.size();j++){
                       //생성된 row에 컬럼을 생성한다
                       cell=row.createCell(j);
                       //map에 담긴 데이터를 가져와 cell에 add한다
                       cell.setCellValue(user.get(j));
                       
                   }
               }
           }
       }
       FileOutputStream fileoutputstream=new FileOutputStream(path+"/컴퓨터공학부회원관리.xls");
       //파일을 쓴다
       workbook.write(fileoutputstream);
       //필수로 닫아주어야함
       fileoutputstream.close();
       return "컴퓨터공학부회원관리.xls";

    }
    
    public String xlsxWriter(ArrayList<UserBean> arraylist) throws IOException, NoSuchAlgorithmException {
       //DB조회후 데이터를 담았다는 가상의 데이터
       ArrayList<ArrayList<String>> array=new ArrayList<>();
       for(int i=0;i<arraylist.size();i++) {
          UserBean user = arraylist.get(i);
          if(user.type.equals("관리자")) {
             continue;
          }
          ArrayList<String> a = new ArrayList<>();
          a.add(user.id);
          a.add(user.name);
          a.add(user.birth);
          a.add(user.type);
          a.add(user.email);
          a.add(user.phone);
          a.add(user.major);
          a.add(user.per_id);
          a.add(user.grade);
          a.add(user.state);
          
          array.add(a);
       }
       
       
       //1차로 workbook을 생성
       XSSFWorkbook workbook=new XSSFWorkbook();
       //2차는 sheet생성
       XSSFSheet sheet=workbook.createSheet("등록 현황");
       //엑셀의 행
       XSSFRow row=null;
       //엑셀의 셀
       XSSFCell cell=null;
       //임의의 DB데이터 조회
       row=sheet.createRow(0);
       String header[]= {"ID","이름","생일","타입","이메일","휴대폰","전공","학번","학년","학적상태"};
       for(int k=0;k<header.length;k++) {
         cell=row.createCell(k);
         cell.setCellValue(header[k]);
      }
       
       if(array !=null &&array.size() >0){
           for(int i=0;i<array.size();i++){
              ArrayList<String> user = array.get(i);
               row=sheet.createRow((short)i+1);
               if(user !=null &&user.size() >0){
                   for(int j=0;j<user.size();j++){
                       //생성된 row에 컬럼을 생성한다
                       cell=row.createCell(j);
                       //map에 담긴 데이터를 가져와 cell에 add한다
                       cell.setCellValue(user.get(j));
                       
                   }
               }
           }
       }
       FileOutputStream fileoutputstream=new FileOutputStream("D:\\회원관리.xls");
       //파일을 쓴다
       workbook.write(fileoutputstream);
       //필수로 닫아주어야함
       fileoutputstream.close();
       return Integer.toString(array.size())+"명의 Excel이 생성되었습니다.";

    }
//GraduationUserDTO
   public String grdExcelWrtier(ArrayList<GraduationUserDTO> userlist,ArrayList<GraduationEtcDTO> elist,String path) throws IOException {
       //DB조회후 데이터를 담았다는 가상의 데이터
       ArrayList<ArrayList<String>> array=new ArrayList<>();
       for(int i=0;i<userlist.size();i++) {
    	   GraduationUserDTO user = userlist.get(i);
    	   GraduationEtcDTO usere = elist.get(i);
          ArrayList<String> a = new ArrayList<>();
          a.add(String.valueOf(user.getPer_id()));
          a.add(user.getName());
          a.add(user.getProf_name());
       user.setEtc_accept(Capstone.getCapstone(usere.getCapstone()));
       int c = usere.getCapstone();
       String cs="";
       if(c==4) {
    	   cs="해당없음";
       }
       else if(c==3) {
    	   cs="이수";
       }
       else if(c==2) {
    	   cs="이수중";
       }
       else {
    	   cs="미이수";
       }
          a.add(cs);
          
          user.setCurrent_state_string(Level.getLevel(user.getCurrent_state()));
          user.setCurrent_str(State.getState(user.getCurrent()));
          a.add(user.getCurrent_state_string());
          a.add(user.getCurrent_str());
          if(usere.getCertificate_submit()==1 || usere.getConference_submit()==1||usere.contest_submit==1) {
        	  a.add("제출");
          }
          else {
        	  a.add("미제출");
          }
          a.add(String.valueOf(user.getDelay_count()));

          array.add(a);
       }
       
       //1차로 workbook을 생성
       HSSFWorkbook workbook=new HSSFWorkbook();
       //2차는 sheet생성
       HSSFSheet sheet=workbook.createSheet("졸업자 대상");
       //엑셀의 행
       HSSFRow row=null;
       //엑셀의 셀
       HSSFCell cell=null;
       //임의의 DB데이터 조회
       row=sheet.createRow(0);
       String header[]= {"학번","이름","지도교수","캡스톤여부","단계","상태","기타제출여부","지연횟수"};
       for(int k=0;k<header.length;k++) {
         cell=row.createCell(k);
         cell.setCellValue(header[k]);
      }
       
       if(array !=null &&array.size() >0){
           for(int i=0;i<array.size();i++){
              ArrayList<String> user = array.get(i);
               row=sheet.createRow((short)i+1);
               if(user !=null &&user.size() >0){
                   for(int j=0;j<user.size();j++){
                       //생성된 row에 컬럼을 생성한다
                       cell=row.createCell(j);
                       //map에 담긴 데이터를 가져와 cell에 add한다
                       cell.setCellValue(user.get(j));
                       
                   }
               }
           }
       }
       FileOutputStream fileoutputstream=new FileOutputStream(path+"/졸업자대상관리.xls");
       //파일을 쓴다
       workbook.write(fileoutputstream);
       //필수로 닫아주어야함
       fileoutputstream.close();
       return "졸업자대상관리.xls";
      
   }

   //190724(졸업자 리스트 엑셀)
    public String xlsGraduate(JsonArray jsonArray, String path) throws IOException{
       ArrayList<ArrayList<String>> array = new ArrayList<>();

       for(int i = 0; i < jsonArray.size(); i++){
           JsonObject object = (JsonObject)jsonArray.get(i);
           ArrayList<String> a = new ArrayList<>();

           a.add(object.get("per_id").getAsString());                  //학번
           a.add(object.get("name").getAsString());                    //이름
           a.add(object.get("prof_name").getAsString());               //교수
           a.add(object.get("graduation_date").getAsString());         //졸업날짜
           a.add(object.get("major").getAsString());                   //전공
           a.add(object.get("graduation_type").getAsString());         //졸업타입
           a.add(object.get("final_action_date").getAsString());       //승인날짜
           array.add(a);
       }

        //1차로 workbook을 생성
        HSSFWorkbook workbook=new HSSFWorkbook();
        //2차는 sheet생성
        HSSFSheet sheet=workbook.createSheet("졸업자");
        //엑셀의 행
        HSSFRow row=null;
        //엑셀의 셀
        HSSFCell cell=null;
        //임의의 DB데이터 조회
        row=sheet.createRow(0);
        String header[]= {"학번", "이름", "담당교수", "졸업날짜", "전공", "졸업종류", "승인날짜"};

        for(int k=0;k<header.length;k++) {
            cell=row.createCell(k);
            cell.setCellValue(header[k]);
        }

        if(array !=null &&array.size() >0){
            for(int i=0;i<array.size();i++){
                ArrayList<String> user = array.get(i);
                row=sheet.createRow((short)i+1);
                if(user !=null &&user.size() >0){
                    for(int j=0;j<user.size();j++){
                        //생성된 row에 컬럼을 생성한다
                        cell=row.createCell(j);
                        //map에 담긴 데이터를 가져와 cell에 add한다
                        cell.setCellValue(user.get(j));

                    }
                }
            }
        }

        FileOutputStream fileoutputstream=new FileOutputStream(path+"/졸업자조회.xls");
        //파일을 쓴다
        workbook.write(fileoutputstream);
        //필수로 닫아주어야함
        fileoutputstream.close();
        return "졸업자조회.xls";

    }
}
