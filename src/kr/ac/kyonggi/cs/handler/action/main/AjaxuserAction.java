package kr.ac.kyonggi.cs.handler.action.main;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.graduation.GraduationTestDAO;
import kr.ac.kyonggi.cs.handler.dao.graduation.graduationDAO;
import kr.ac.kyonggi.cs.handler.dao.user.UserDAO;
import kr.ac.kyonggi.cs.handler.excel.ExcelReader;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

public class AjaxuserAction implements Action {

	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Gson gson = new Gson();
		String req = request.getParameter("req");
		String data = request.getParameter("data");
		HttpSession session = request.getSession();
		UserBean user = gson.fromJson((String) session.getAttribute("user"), UserBean.class);
		UserTypeBean type = gson.fromJson((String) session.getAttribute("type"), UserTypeBean.class);
		String address = null;
		String result = null;
		switch (req) {
		case "deleteuser":
			if (type.board_level == 0) // 유저 삭제
			{
				result = UserDAO.getInstance().deleteUser(data);
				File log = new File(request.getServletContext().getRealPath("/WEB-INF"), "log.txt");
				BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(log, true));
				bufferedWriter.write(new Date().toString() + "] 아이디 삭제! " + "ID : " + data + "\r\n");
				bufferedWriter.close();
			}
			break;
		case "registeradmin":
			if (!type.type_name.equals("관리자"))
				break;
			result = UserDAO.getInstance().insertAdmin(data);
			if (!result.equals("fail")) {
				File log = new File(request.getServletContext().getRealPath("/WEB-INF"), "log.txt");
				BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(log, true));
				String arr[] = result.split("-/-/-"); // 0 아디 1 이름 2 타입
				bufferedWriter.write(new Date().toString() + "] 관리자 생성! " + "ID : " + arr[0] + " 이름 :" + arr[1]
						+ " 타입 : " + arr[2] + "\r\n");
				bufferedWriter.close();
			}
			break;

			case "enrollAIuser": //AI권한 추가
				result = UserDAO.getInstance().enrollAIuser(data);
				//System.out.println(result+"ajaxuseraction.enrollAIuser");
				return result;

			case "deleteAIuser": //AI권한 삭제
				if (type.board_level == 0) {
					String arr[] = data.split("-/-/-");
					for (int i = 0; i < arr.length; i++)
						result = UserDAO.getInstance().deleteAIUser(arr[i]);
				}
				return result;

		case "deleteselectuser": // 선택 유저 삭제
			if (type.board_level == 0) {
				String arr[] = data.split("-/-/-");
				for (int i = 0; i < arr.length; i++)
					result = UserDAO.getInstance().deleteUser(arr[i]);
			}
			break;
		case "modifytype": // 관리자의 유저권한수정
			if (type.board_level == 0)
				result = UserDAO.getInstance().modifyType(data);
			break;
		case "modifypw": // 관리자 pw초기화
			if (type.board_level == 0)
				result = UserDAO.getInstance().modifypw(data);
			break;
		case "insertexceluser": // 엑셀 유저 추가
			if (type.board_level == 0) {
				address = request.getParameter("address");
				List<Map<String, Object>> insertmap = null;
				String xls = address.substring(address.lastIndexOf(".") + 1);
				if (xls.equals("xlsx"))
					insertmap = new ExcelReader().xlsxUserReader(address);
				else
					insertmap = new ExcelReader().xlsUserReader(address);
				result = UserDAO.getInstance().insertexceluser(insertmap);
				String path = request.getSession().getServletContext().getRealPath("/") + "excel";
				File deleteFile = new File(path, address);
				deleteFile.delete();
			}
			break;

		case "modifyexceluser": // 엑셀 유저 수정
			if (type.board_level == 0) {
				address = request.getParameter("address");
				String xlsx = address.substring(address.lastIndexOf(".") + 1);
				List<Map<String, Object>> modifymap = null;
				if (xlsx.equals("xlsx"))
					modifymap = new ExcelReader().xlsxUserReadermodify(data, address);
				else
					modifymap = new ExcelReader().xlsUserReadermodify(data, address);
				result = UserDAO.getInstance().modifyexceluser(modifymap);
				String path2 = request.getSession().getServletContext().getRealPath("/") + "excel";
				File deleteFile2 = new File(path2, address);
				deleteFile2.delete();
			}
			break;
		// jong hun
		case "insertgrduser":// 바꿈
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(data);
			JsonArray grdArray = element.getAsJsonArray();
			result = GraduationTestDAO.getInstance().insertgrduser(grdArray);
			break;

		// jong hun
		case "insertgrduser_req":// 바꿈
			JsonParser parser2 = new JsonParser();
			JsonElement element2 = parser2.parse(data);
			JsonArray grdArray2 = element2.getAsJsonArray();
			result = GraduationTestDAO.getInstance().insertgrduser_req(grdArray2);
			break;
		case "deletegrduser":// 바꿈
			result = GraduationTestDAO.getInstance().deletegrduser(data, request);
			break;
		case "deletegrdrequser":// 바꿈
			result = GraduationTestDAO.getInstance().deletegrd_req_user(data);
			break;
		case "insertonegrduser":// 바꿈
			result = GraduationTestDAO.getInstance().insertgrduser(data);
			break;
		case "insertonegrduser_req":
			result = GraduationTestDAO.getInstance().insertgrduser_req(data);
			break;
		case "req_insertgrduser":// 바꿈
			result = GraduationTestDAO.getInstance().req_insertgrduser(data);
			break;
		case "thesis_what":// 뭐가들어오지?
			result = GraduationTestDAO.getInstance().findThesis(data);
			break;
		}

		/*
		 * String result = null;
		 * 
		 * switch(req) { case "logout":
		 * if(request.getSession().getAttribute("user")!=null) {
		 * request.getSession().invalidate(); result = "200"; } }
		 * 
		 * return result;
		 */
		return result;

	}

	public String testSHA256(String str) {

		String SHA = "";

		try {

			MessageDigest sh = MessageDigest.getInstance("SHA-256");

			sh.update(str.getBytes());

			byte byteData[] = sh.digest();

			StringBuffer sb = new StringBuffer();

			for (int i = 0; i < byteData.length; i++) {

				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));

			}

			SHA = sb.toString();

		} catch (NoSuchAlgorithmException e) {

			e.printStackTrace();

			SHA = null;

		}

		return SHA;

	}
}