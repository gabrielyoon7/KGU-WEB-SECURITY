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

public class GraduateExcelInsertAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Gson gson = new Gson();
        String path = request.getServletContext().getRealPath("/uploadFile");

        UserTypeBean type = gson.fromJson((String)request.getSession().getAttribute("type"), UserTypeBean.class);
        if(!type.type_name.equals("졸업논문관리자"))
            return "RequestDispatcher:jsp/main/error.jsp";


        String data = request.getParameter("data");

        JsonParser jsonParser = new JsonParser();
        JsonArray jsonArray = (JsonArray)jsonParser.parse(data);

        ExcelWriter excelWriter = new ExcelWriter();
        String file_name = excelWriter.xlsGraduate(jsonArray, request.getServletContext().getRealPath("/uploadFile"));

        return file_name;
    }
}
