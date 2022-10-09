package kr.ac.kyonggi.cs.handler.action.graduationBack;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.graduation.GraduationTestDAO;
import kr.ac.kyonggi.cs.handler.dao.grdBack.GrdBackupDao;
import kr.ac.kyonggi.cs.handler.dao.user.UserDAO;
import kr.ac.kyonggi.cs.handler.dto.grdBack.TargetStudentDto;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class GraduationBackupAjaxAction implements Action {

    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception{
        UserDAO userDao = UserDAO.getInstance();
        Gson gson = new Gson();
        JsonParser parser = new JsonParser();
        String data = request.getParameter("data"); //학번들
        String[] arr=data.split("-/-/-");
        List<String> per_id_list=Arrays.asList(arr);
        for(String str:per_id_list){
            System.out.println(str);
        }
        String users=request.getParameter("users");
        TargetStudentDto[] tmp=gson.fromJson(users,TargetStudentDto[].class);
        List<TargetStudentDto> list= Arrays.asList(tmp);

        String hashv=request.getParameter("hashv");
        String gpmgr=userDao.getUser("gpmgr").password;


        if(!gpmgr.equals(hashv)){
            return gson.toJson("fail");
        }
        GrdBackupDao grdBackupDao = GrdBackupDao.getInstance();
        GraduationTestDAO graduationTestDAO =GraduationTestDAO.getInstance();
        grdBackupDao.insertBackupTable(list,per_id_list);
        String many2=graduationTestDAO.deletegrduser(data,request);

        return gson.toJson(many2);
    }
}
