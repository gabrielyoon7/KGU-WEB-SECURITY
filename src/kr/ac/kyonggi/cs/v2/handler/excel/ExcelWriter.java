package kr.ac.kyonggi.cs.v2.handler.excel;

import java.io.FileOutputStream;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;

import kr.ac.kyonggi.cs.handler.vo.user.UserBean;
import kr.ac.kyonggi.cs.v2.handler.dto.graduation_checking_system.LectureDTO;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;


public class ExcelWriter {

    public String xlsWriter(ArrayList<LectureDTO> arraylist, String path) throws IOException, NoSuchAlgorithmException {
        //DB조회후 데이터를 담았다는 가상의 데이터
        ArrayList<ArrayList<String>> array=new ArrayList<>();
        for(int i=0;i<arraylist.size();i++) {
            LectureDTO lecture = arraylist.get(i);
//          if(user.type.equals("관리자")) {
//             continue;
//          }

            ArrayList<String> a = new ArrayList<>();
            a.add(lecture.id);
            a.add(lecture.year);
            a.add(lecture.semester);
            a.add(lecture.grade);
            a.add(lecture.lecture_id);
            a.add(lecture.big_type);
            a.add(lecture.small_type);
            a.add(lecture.major);
            a.add(lecture.credit);
            a.add(lecture.design_credit);
            a.add(lecture.name);
//            a.add(lecture.selective_essential);
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
        String header[]= {"ID","연도","학기","학년","학수코드","대분류(교양/전공)","소분류(이수구분)","전공","학점","설계점수","과목명"};
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
        FileOutputStream fileoutputstream=new FileOutputStream(path+"/학과강좌관리.xls");
        //파일을 쓴다
        workbook.write(fileoutputstream);
        //필수로 닫아주어야함
        fileoutputstream.close();
        return "학과강좌관리.xls";

    }

}
