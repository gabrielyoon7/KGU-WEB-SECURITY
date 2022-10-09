package kr.ac.kyonggi.cs.v2.handler.excel;

import kr.ac.kyonggi.cs.handler.dao.user.UserDAO;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.FileInputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ExcelReader {
	public static ExcelReader it;
	
	public static ExcelReader getInstance() {
		if(it == null)
			it = new ExcelReader();
		return it;
	}
	
	
	public List<Map<String,Object>> xlsLectureReader(String address) throws IOException {//모두 읽기
		FileInputStream fis=new FileInputStream(address);
		HSSFWorkbook workbook=new HSSFWorkbook(fis);
		ArrayList<String> header=new ArrayList<>();
		int rowindex=0;
		int columnindex=0;
		//시트 수 (첫번째에만 존재하므로 0을 준다)
		//만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
		HSSFSheet sheet=workbook.getSheetAt(0);
		//행의 수
		int rows=sheet.getPhysicalNumberOfRows();
		List<Map<String,Object>> list= new ArrayList<Map<String,Object>>();
		for(rowindex=0;rowindex<rows;rowindex++){ //행을 읽는다

			HSSFRow row=sheet.getRow(rowindex);
			if(row !=null){
				//셀의 수
				int cells=row.getPhysicalNumberOfCells();
				Map<String,Object> map = new HashMap<>();
				for(columnindex=0;columnindex<cells;columnindex++){//셀값을 읽는다

					HSSFCell cell=row.getCell(columnindex);
					String value="";
					//셀이 빈값일경우를 위한 널체크
					if(cell==null){
						continue;
					}else{
						//타입별로 내용 읽기
						switch (cell.getCellType()){
							case HSSFCell.CELL_TYPE_FORMULA:
								value=cell.getCellFormula();
								break;
							case HSSFCell.CELL_TYPE_NUMERIC:
//								if(HSSFDateUtil.isCellDateFormatted(cell)) {
//									SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
//									value=formatter.format(cell.getDateCellValue());
//								}
//								else
								if(cell.getNumericCellValue() - (int)cell.getNumericCellValue() == 0.5){
									value=cell.getNumericCellValue()+"";
								} else{
									value=(int)cell.getNumericCellValue()+"";
								}
								break;
							case HSSFCell.CELL_TYPE_STRING:
								value=cell.getStringCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_BLANK:
								value=cell.getBooleanCellValue()+"";
								break;
							case HSSFCell.CELL_TYPE_ERROR:
								value=cell.getErrorCellValue()+"";
								break;
						}
					}
					if(rowindex==0) {
						String val = null;
						switch(value) {
							case "ID":
								val="id";
								break;
							case "연도":
								val="year";
								break;
							case "학기":
								val="semester";
								break;
							case "학년":
								val="grade";
								break;
							case "학수코드":
								val="lecture_id";
								break;
							case "대분류(교양/전공)":
								val="big_type";
								break;
							case "소분류(이수구분)":
								val="small_type";
								break;
							case "전공":
								val="major";
								break;
							case "학점":
								val="credit";
								break;
							case "설계점수":
								val="design_credit";
								break;
							case "과목명":
								val="name";
								break;
							default :
								val="Danger";
						}
						header.add(val);
						continue;
					}
					map.put(header.get(columnindex), value);

				}
				if(rowindex!=0)
					list.add(map);
			}
		}
		workbook.close();
		fis.close();
		return list;
	}
	public List<Map<String,Object>> xlsxLectureReader(String address) throws IOException {//모두 읽기
		FileInputStream fis=new FileInputStream(address);
		XSSFWorkbook workbook=new XSSFWorkbook(fis);
		ArrayList<String> header=new ArrayList<>();
		int rowindex=0;
		int columnindex=0;
		//시트 수 (첫번째에만 존재하므로 0을 준다)
		//만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
		XSSFSheet sheet=workbook.getSheetAt(0);
		//행의 수
		int rows=sheet.getPhysicalNumberOfRows();

		  List<Map<String,Object>> list= new ArrayList<Map<String,Object>>();
		for(rowindex=0;rowindex<rows;rowindex++){ //행을 읽는다
		   
		    XSSFRow row=sheet.getRow(rowindex);
		    if(row !=null){
		        //셀의 수
		        int cells=row.getPhysicalNumberOfCells()+1;
		        Map<String,Object> map = new HashMap<>();
		        for(columnindex=0;columnindex<=cells;columnindex++){//셀값을 읽는다
		        	
		            XSSFCell cell=row.getCell(columnindex);
		            String value="";
		            //셀이 빈값일경우를 위한 널체크
		            if(cell==null){
		                continue;
		            }else{
		                //타입별로 내용 읽기
		                switch (cell.getCellType()){
		                case XSSFCell.CELL_TYPE_FORMULA:
		                    value=cell.getCellFormula();
		                    break;
		                    case HSSFCell.CELL_TYPE_NUMERIC:
		                    	if(cell.getNumericCellValue() - (int)cell.getNumericCellValue() == 0.5){
									value=cell.getNumericCellValue()+"";
								} else{
									value=(int)cell.getNumericCellValue()+"";
								}
								break;
		                case XSSFCell.CELL_TYPE_STRING:
		                    value=cell.getStringCellValue()+"";
		                    break;
		                case XSSFCell.CELL_TYPE_BLANK:
		                    value=cell.getBooleanCellValue()+"";
		                    break;
		                case XSSFCell.CELL_TYPE_ERROR:
		                    value=cell.getErrorCellValue()+"";
		                    break;
		                }
		            }
		            if(rowindex==0) {
		            	String val = null;
		            	if(!value.equals("false")) {


							switch (value) {
								case "ID":
									val = "id";
									break;
								case "연도":
									val = "year";
									break;
								case "학기":
									val = "semester";
									break;
								case "학년":
									val = "grade";
									break;
								case "학수코드":
									val = "lecture_id";
									break;
								case "대분류(교양/전공)":
									val = "big_type";
									break;
								case "소분류(이수구분)":
									val = "small_type";
									break;
								case "전공":
									val = "major";
									break;
								case "학점":
									val = "credit";
									break;
								case "설계점수":
									val = "design_credit";
									break;
								case "과목명":
									val = "name";
									break;
								default:
									val = "Danger";
							}
						}
						header.add(val);
		            	continue;
		            }
//		           System.out.println(value);
					if(!value.equals("false")){
						map.put(header.get(columnindex), value);
						map.get("-");
					}
					if(value.equals(""))
						map.put(header.get(columnindex), "-");

		        }
		        if(rowindex!=0)
		        list.add(map);
		        }
		}
		return list;
	}
//	public List<Map<String,Object>> xlsUserReadermodify(String data,String address) throws IOException {//수정
//		String arr[]=data.split("-/-/-");
//		FileInputStream fis=new FileInputStream(address);
//		HSSFWorkbook workbook=new HSSFWorkbook(fis);
//		ArrayList<String> header=new ArrayList<>();
//		UserDAO userdao=new UserDAO();
//		List<Map<String,Object>> list= new ArrayList<>();
//		int rowindex=0;
//		int columnindex=0;
//		 String id=null;
//		//시트 수 (첫번째에만 존재하므로 0을 준다)
//		//만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
//		HSSFSheet sheet=workbook.getSheetAt(0);
//		//행의 수
//		int rows=sheet.getPhysicalNumberOfRows();
//
//		for(rowindex=0;rowindex<rows;rowindex++){ //행을 읽는다
//
//		    HSSFRow row=sheet.getRow(rowindex);
//		    if(row !=null){
//		        //셀의 수
//		        int cells=row.getPhysicalNumberOfCells()+1;
//		        Map<String,Object> map = new HashMap<>();
//		        for(columnindex=0;columnindex<=cells;columnindex++){//셀값을 읽는다
//
//		            HSSFCell cell=row.getCell(columnindex);
//		            String value="";
//		            //셀이 빈값일경우를 위한 널체크
//		            if(cell==null){
//
//		                continue;
//		            }else{
//		                //타입별로 내용 읽기
//		                switch (cell.getCellType()){
//		                case HSSFCell.CELL_TYPE_FORMULA:
//		                    value=cell.getCellFormula();
//		                    break;
//		                case HSSFCell.CELL_TYPE_NUMERIC:
//		                    if(HSSFDateUtil.isCellDateFormatted(cell)) {
//		                    	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
//		                    	value=formatter.format(cell.getDateCellValue());
//		                    }
//		                    else
//		                	value=Integer.toString((int)cell.getNumericCellValue())+"";
//		                    break;
//		                case HSSFCell.CELL_TYPE_STRING:
//		                    value=cell.getStringCellValue()+"";
//		                    break;
//		                case HSSFCell.CELL_TYPE_BLANK:
//		                    value=cell.getBooleanCellValue()+"";
//		                    break;
//		                case HSSFCell.CELL_TYPE_ERROR:
//		                    value=cell.getErrorCellValue()+"";
//		                    break;
//		                }
//		            }
//		            if(rowindex==0) {
//		            	String val = null;
//						switch(value) {
//							case "ID":
//								val="id";
//								break;
//							case "연도":
//								val="year";
//								break;
//							case "학기":
//								val="semester";
//								break;
//							case "학년":
//								val="grade";
//								break;
//							case "학수코드":
//								val="lecture_id";
//								break;
//							case "대분류(교양/전공)":
//								val="big_type";
//								break;
//							case "소분류(이수구분)":
//								val="small_type";
//								break;
//							case "전공":
//								val="major";
//								break;
//							case "학점":
//								val="credit";
//								break;
//							case "설계점수":
//								val="design_credit";
//								break;
//							case "과목명":
//								val="name";
//								break;
//							case "선필여부":
//								val="selective_essential";
//								break;
//							default :
//								val="Danger";
//						}
//		            	header.add(val);
//		            	continue;
//		            }
//		          String haveId=null;
//		           if(header.get(columnindex).equals("id")) {
//       					haveId=userdao.compareUser(header.get(columnindex), value);
//       					if(haveId!=null) {
//       						map.put(header.get(columnindex), value);
//       						id=value;//수정할경우 문제가있네(id가 없는데?)
//       					}else {
//       						id=null;
//       						break;
//       					}
//       				}
//		        		for(int i=0;i<arr.length;i++) {
//		        		  if(arr[i].equals(header.get(columnindex))) {
//		        			map.put(header.get(columnindex), value);
//		        		  String modify=null;
//		        		  if(!header.get(columnindex).equals("id")) {
//		        			  modify=userdao.compareUser(header.get(columnindex),id);
//		        		  	map.put(header.get(columnindex)+"before", modify);
//
//		        		  }
//
//		        		  }
//
//		        		}
//
//		        }
//
//		        if(rowindex!=0 && id!=null) {
//		        	list.add(map);
//		        }
//		        }
//		}
//		return list;
//	}
//	public List<Map<String,Object>> xlsxUserReadermodify(String data,String address) throws IOException {//수정
//		String arr[]=data.split("-/-/-");
//		FileInputStream fis=new FileInputStream(address);
//		XSSFWorkbook workbook=new XSSFWorkbook(fis);
//		ArrayList<String> header=new ArrayList<>();
//		UserDAO userdao=new UserDAO();
//		List<Map<String,Object>> list= new ArrayList<>();
//		int rowindex=0;
//		int columnindex=0;
//		 String id=null;
//		//시트 수 (첫번째에만 존재하므로 0을 준다)
//		//만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
//		XSSFSheet sheet=workbook.getSheetAt(0);
//		//행의 수
//		int rows=sheet.getPhysicalNumberOfRows()+1;
//
//		for(rowindex=0;rowindex<rows;rowindex++){ //행을 읽는다
//
//		    XSSFRow row=sheet.getRow(rowindex);
//		    if(row !=null){
//		        //셀의 수
//		        int cells=row.getPhysicalNumberOfCells();
//		        Map<String,Object> map = new HashMap<>();
//		        for(columnindex=0;columnindex<=cells;columnindex++){//셀값을 읽는다
//
//		            XSSFCell cell=row.getCell(columnindex);
//		            String value="";
//		            //셀이 빈값일경우를 위한 널체크
//		            if(cell==null){
//		                continue;
//		            }else{
//		                //타입별로 내용 읽기
//		                switch (cell.getCellType()){
//		                case XSSFCell.CELL_TYPE_FORMULA:
//		                    value=cell.getCellFormula();
//		                    break;
//		                case XSSFCell.CELL_TYPE_NUMERIC:
//		                    if(HSSFDateUtil.isCellDateFormatted(cell)) {
//		                    	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
//		                    	value=formatter.format(cell.getDateCellValue());
//		                    }
//		                    else
//		                	value=Integer.toString((int)cell.getNumericCellValue())+"";
//		                    break;
//		                case XSSFCell.CELL_TYPE_STRING:
//		                    value=cell.getStringCellValue()+"";
//		                    break;
//		                case XSSFCell.CELL_TYPE_BLANK:
//		                    value=cell.getBooleanCellValue()+"";
//		                    break;
//		                case XSSFCell.CELL_TYPE_ERROR:
//		                    value=cell.getErrorCellValue()+"";
//		                    break;
//		                }
//		            }
//		            if(rowindex==0) {
//		            	String val = null;
//						switch(value) {
//							case "ID":
//								val="id";
//								break;
//							case "연도":
//								val="year";
//								break;
//							case "학기":
//								val="semester";
//								break;
//							case "학년":
//								val="grade";
//								break;
//							case "학수코드":
//								val="lecture_id";
//								break;
//							case "대분류(교양/전공)":
//								val="big_type";
//								break;
//							case "소분류(이수구분)":
//								val="small_type";
//								break;
//							case "전공":
//								val="major";
//								break;
//							case "학점":
//								val="credit";
//								break;
//							case "설계점수":
//								val="design_credit";
//								break;
//							case "과목명":
//								val="name";
//								break;
//							case "선필여부":
//								val="selective_essential";
//								break;
//							default :
//								val="Danger";
//						}
//		            	header.add(val);
//		            	continue;
//		            }
//		          String haveId=null;
//		           if(header.get(columnindex).equals("id")) {
//       					haveId=userdao.compareUser(header.get(columnindex), value);
//       					if(haveId!=null) {
//       						map.put(header.get(columnindex), value);
//       						id=value;//수정할경우 문제가있네(id가 없는데?)
//       					}else {
//       						id=null;
//       						break;
//       					}
//       				}
//		        		for(int i=0;i<arr.length;i++) {
//		        		  if(arr[i].equals(header.get(columnindex))) {
//		        			map.put(header.get(columnindex), value);
//		        		  String modify=null;
//		        		  if(!header.get(columnindex).equals("id")) {
//		        			  modify=userdao.compareUser(header.get(columnindex),id);
//		        		  	map.put(header.get(columnindex)+"before", modify);
//
//		        		  }
//
//		        		  }
//
//		        		}
//
//		        }
//
//		        if(rowindex!=0 && id!=null) {
//		        	list.add(map);
//		        }
//		        }
//		}
//		return list;
//	}

}
