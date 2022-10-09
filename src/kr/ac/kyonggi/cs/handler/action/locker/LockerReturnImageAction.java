package kr.ac.kyonggi.cs.handler.action.locker;

import com.google.gson.Gson;
import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.locker.LockerDAO;
import kr.ac.kyonggi.cs.handler.dto.locker.LockerAssignedUserDTO;
import kr.ac.kyonggi.cs.handler.dto.locker.LockerFileDTO;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LockerReturnImageAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String num=request.getParameter("num");
        int per_id = Integer.parseInt(num); //학번 불러오기
        LockerAssignedUserDTO assignedStudent = LockerDAO.getInstance().getAssignedStudent(per_id);
        LockerFileDTO file = LockerDAO.getInstance().getFile(per_id);
        LockerFileDTO file2 = LockerDAO.getInstance().getFile2(per_id);
        request.setAttribute("assignedStudent", assignedStudent); //배정자 정보 불러오기
        request.setAttribute("file", file); //반납사진파일data 불러오기
        request.setAttribute("file2", file2); //반납사진파일data 불러오기
        return "RequestDispatcher:jsp/locker/locker_return_image.jsp";
    }
}
