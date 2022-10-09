package kr.ac.kyonggi.cs.handler.action.graduation;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.excel.ExcelReader;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

public class GraduationExcelReqAction implements Action {
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("GraduationExcelReqAction");
		
		String address = request.getParameter("address");
		String xls = address.substring(address.lastIndexOf(".") + 1);
		Gson gson = new Gson();
		String userx = (String) request.getSession().getAttribute("user");
		if (userx == null)
			return "RequestDispatcher:jsp/main/error.jsp";
		UserBean user = gson.fromJson(userx, UserBean.class);
		if (!user.type.equals("졸업논문관리자"))
			return "RequestDispatcher:jsp/main/error.jsp";
		ExcelReader ex = ExcelReader.getInstance();

		String result = null;
		if (xls.equals("xlsx")) {
			result = gson.toJson(ex.xlsxGrdReqReader(address));
		} else
			result = gson.toJson(ex.xlsGrdReqReader(address));

		File deleteFile = new File(address);
		deleteFile.delete();
		System.out.println(result);
		return result;
	}

}
