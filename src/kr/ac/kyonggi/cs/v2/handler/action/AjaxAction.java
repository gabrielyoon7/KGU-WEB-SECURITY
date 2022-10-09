package kr.ac.kyonggi.cs.v2.handler.action;


import com.google.gson.Gson;
import kr.ac.kyonggi.cs.handler.dao.boards.NoticeBoardsDAO;
import kr.ac.kyonggi.cs.handler.dao.boards.WebzineBoardsDAO;
import kr.ac.kyonggi.cs.handler.dao.setting.ScheduleDAO;
import kr.ac.kyonggi.cs.handler.dao.user.UserDAO;
import kr.ac.kyonggi.cs.v2.handler.dao.main.CurriculumDAO;
import kr.ac.kyonggi.cs.v2.handler.dao.main.HomeDAO;
import kr.ac.kyonggi.cs.v2.handler.dao.main.LaboratoryDAO;
import kr.ac.kyonggi.cs.v2.handler.excel.ExcelReader;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;
import kr.ac.kyonggi.cs.v2.common.controller.Action;
import kr.ac.kyonggi.cs.v2.handler.dao.graduation_checking_system.GraduationCheckingSystemDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileWriter;
import java.util.Date;
import java.util.List;
import java.util.Map;

public class AjaxAction implements Action {
    /**
     * DB를 JSP에서 JAVA로 보낼 때 사용하는 클래스입니다.
     * JSP의 ajax에서 정해준 req, data 값을 가지고 작업을 하게됩니다.
     * req는 필요한 case문을 찾아 들어가는데 사용하고
     * data는 DAO로 넘길 데이터를 의미합니다.
     * data의 경우에는 "일반적으로" JS가 여러 데이터 값을 한줄로 합쳐놓은 상태입니다.
     * 따라서 마지막으로 받는 메소드는 항상 split해줘야 하는지 고민해야 합니다.
     * */


    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Gson gson = new Gson();
        String req = request.getParameter("req"); //JSP에서 넘겨준 req
        HttpSession session = request.getSession(); //Session에 있는 정보로 뭔가 해야할 때 사용
        String data = request.getParameter("data"); //JSP에서 넘겨준 data
        UserBean user = gson.fromJson((String)session.getAttribute("user"), UserBean.class);
        UserTypeBean type = gson.fromJson((String)session.getAttribute("type"), UserTypeBean.class);
        String result=null;
        String address = null;
        String num= request.getParameter("num");
        StringBuffer url = request.getRequestURL();
        String major=url.substring(7, 9);
        if(major.equals("lo")){ //로컬에서 아무것도 안뜰까봐 추가
            major="ai";
        }
        switch(req) {
            case "fixed_button":   //
                result = NoticeBoardsDAO.getInstance().fixedButton(data); //
                break;
            case "insertexcellecture": // 엑셀 강좌 추가
                if (type.board_level == 0) {
                    address = request.getParameter("address");
                    List<Map<String, Object>> insertmap = null;
                    String xls = address.substring(address.lastIndexOf(".") + 1);
                    if (xls.equals("xlsx"))
                        insertmap = new ExcelReader().xlsxLectureReader(address);
                    else
                        insertmap = new ExcelReader().xlsLectureReader(address);
                    result = GraduationCheckingSystemDAO.getInstance().insertexcellecture(insertmap);
                    String path = request.getSession().getServletContext().getRealPath("/") + "excel";
                    File deleteFile = new File(path, address);
                    deleteFile.delete();
                }
                break;
            case "deleteselectlecture": // 선택 과목 삭제
                if (type.board_level == 0) {
                    String arr[] = data.split("-/-/-");
                    for (int i = 0; i < arr.length; i++)
                        result = GraduationCheckingSystemDAO.getInstance().deleteLecture(arr[i]);
                }
                break;
            case "addLecture":
                if (type.board_level != 0){
                    return "fail";
                }
                result=GraduationCheckingSystemDAO.getInstance().addLecture(data);
                break;
            case "modifylecture":
                if (type.board_level != 0){
                    return "fail";
                }
                result=GraduationCheckingSystemDAO.getInstance().modifyLecture(data);
                break;
            case "addGcsStudent":
                result = GraduationCheckingSystemDAO.getInstance().addGcsStudent(data);
                break;
            case "modifyGcsStudent":
                result = GraduationCheckingSystemDAO.getInstance().modifyGcsStudent(data);
                break;
            case "addExternalLecture":
                result = GraduationCheckingSystemDAO.getInstance().addExternalLecture(data);
                break;
//            case "modifyExternallecture":
//                result = GraduationCheckingSystemDAO.getInstance().modifyExternalLecture(data);
//                break;
            case "deleteExternalLecture":
                result = GraduationCheckingSystemDAO.getInstance().deleteExternalLecture(data);
                break;
            case "addLectureHistory":
                result = GraduationCheckingSystemDAO.getInstance().addLectureHistory(data);
                break;
            case "insertGraduationRequirement":
                result = GraduationCheckingSystemDAO.getInstance().insertGraduationRequirement(data);
                break;
            case "deleteGraduationRequirement":
                result = GraduationCheckingSystemDAO.getInstance().deleteGraduationRequirement(data);
                break;
            case "modifyGraduationRequirement":
                result = GraduationCheckingSystemDAO.getInstance().modifyGraduationRequirement(data);
                break;
            case "insertSimilarSub":
                result = GraduationCheckingSystemDAO.getInstance().insertSimilarSub(data);
                break;
            case "ModifySimilarSub":
                result = GraduationCheckingSystemDAO.getInstance().ModifySimilarSub(data);
                break;
            case "modifyEngineeringRequirement":
                result = GraduationCheckingSystemDAO.getInstance().modifyEngineeringRequirement(data);
                break;
            case "addTrackRequirement":
                result = GraduationCheckingSystemDAO.getInstance().addTrackRequirement(data);
                break;
            case "deleteTrackRequirement":
                result = GraduationCheckingSystemDAO.getInstance().deleteTrackRequirement(data);
                break;
            case "modifyElectiveLectures":
                result = GraduationCheckingSystemDAO.getInstance().modifyElectiveLectures(data);
                break;
            case "modifyLectureOrder":
                result = GraduationCheckingSystemDAO.getInstance().modifyLectureOrder(data);
                break;
            case "deleteTakenLecture":
                result = GraduationCheckingSystemDAO.getInstance().deleteTakenLecture(data);
                break;
            case "deleteStudent":
                result = GraduationCheckingSystemDAO.getInstance().deleteStudentData(data);
                break;
            case "addSpecialLecture":
                result = GraduationCheckingSystemDAO.getInstance().addSpecialLecture(data);
                break;
            case "deletealllecture":
                result = GraduationCheckingSystemDAO.getInstance().deleteAllLecture();
                break;
            case "modifyinfo":
                if (type.board_level != 0){
                    return "fail";
                }
                result= HomeDAO.getInstance().modifyinfo(data);
                break;
            case "getonelaboratory":   //직접 권한 확인
                if (type.board_level == 0)
                    result = gson.toJson(LaboratoryDAO.getInstance().getOneLaboratory(data));
                break;
            case "modifylab":      //직접 권한 확인
                if (type.board_level == 0)
                    result = LaboratoryDAO.getInstance().modifyLaboratory(data);
                break;
            case "modifyCurriculumText":
                if (type.board_level == 0)
                    result = CurriculumDAO.getInstance().modifyCurriculumText(data);
//                System.out.println(result);
                break;
            case "modifyCurriculum":
                if(type.board_level==0)
                    result=CurriculumDAO.getInstance().modifyCurriculum(data);
                break;
            case "insertCurriculum":
                if(type.board_level==0)
                    result=CurriculumDAO.getInstance().insertCurriculum(data);
                break;
            case "deleteCurriculum":
                if(type.board_level==0)
                    result=CurriculumDAO.getInstance().deleteCurriculum(data);
                break;
            case "webzinegetcomment":      //DAO에서 권한 확인
                data = data.concat("-/-/-" + type.board_level);
                result = WebzineBoardsDAO.getInstance().getComments(data);
                break;
            case "webzinecommentInsert":   //직접 권한 확인
                if (Integer.valueOf(data.split("-/-/-")[4]) < type.board_level)
                    return null;
                result = WebzineBoardsDAO.getInstance().insertComments(data);
                break;
            case "webzinemodifycomment":   //DAO에서 권한 확인
                data = data.concat("-/-/-" + user.id + "-/-/-" + type.type_name);
                result = WebzineBoardsDAO.getInstance().updateComments(data);
                break;
            case "webzinedeletecomment":   //DAO에서 권한 확인
                data = data.concat("-/-/-" + user.id + "-/-/-" + type.type_name);
                result = WebzineBoardsDAO.getInstance().deleteComments(data);
                break;
            case "likeBoard":   //직접 권한 확인
                if (type.board_level > 7)
                    return "fail";
                data = data.concat("-/-/-" + user.id);
                result = WebzineBoardsDAO.getInstance().likeBoards(data);
                break;
            case "insertwebzine":         //DAO에서 권한 확인
                data = data.concat("-/-/-" + type.board_level);
                result = WebzineBoardsDAO.getInstance().insertBoards(data);
                break;
            case "modifywebzine":         //DAO에서 권한 확인
                NoticeBoardsDAO.getInstance().insertFileId(user.id, data.split("-/-/-")[0]);
                data = data.concat("-/-/-" + user.id + "-/-/-" + type.type_name + "-/-/-" + request.getSession().getServletContext().getRealPath("/uploadFile"));
                result = WebzineBoardsDAO.getInstance().modifyBoards(data);
                break;
            case "webzine_delete_already_file":   //DAO에서 권한 확인
                data = data.concat("-/-/-" + user.id + "-/-/-" + type.type_name);
                result = WebzineBoardsDAO.getInstance().deleteAlreadyFile(data);
                break;
            case "webzine_already_file_done":
                data = data.concat("-/-/-" + user.id);
                result = WebzineBoardsDAO.getInstance().alreadyFileDone(data);
                break;
            case "deleteLog":
                File forDeleteLog = new File(request.getServletContext().getRealPath("/WEB-INF"), "log.txt");
                FileWriter fw = new FileWriter(forDeleteLog);
                fw.write("");
                fw.close();
                return "success";
            case "updateSchedule":   //직접 권한 확인
                if (type.board_level == 0) {
                    result = ScheduleDAO.getInstance().updateSchedule();
                }
                //request.getSession().setAttribute("schedulelist",gson.toJson(ScheduleDAO.getInstance().getSchedule()));
                break;
            case "insertschedule":   //직접 권한 확인
                if (type.board_level == 0) {
                    result = ScheduleDAO.getInstance().insertSchedule(data);
                    session.setAttribute("schedulelist", gson.toJson(ScheduleDAO.getInstance().getSchedule()));
                }
                break;
            case "getoneschedule":   //직접 권한 확인
                if (type.board_level == 0)
                    result = ScheduleDAO.getInstance().getOneSchedule(data);
                break;
            case "deleteschedule":   //직접 권한 확인
                if (type.board_level == 0) {
                    result = ScheduleDAO.getInstance().deleteSchedule(data);
                    session.setAttribute("schedulelist", gson.toJson(ScheduleDAO.getInstance().getSchedule()));
                }
                break;
            case "modifyschedule":   //직접 권한 확인
                if (type.board_level == 0) {
                    result = ScheduleDAO.getInstance().modifySchedule(data);
                    session.setAttribute("schedulelist", gson.toJson(ScheduleDAO.getInstance().getSchedule()));
                }
                break;
            case "deleteSlider":   //직접 권한 확인
                if (type.board_level != 0)
                    return "Who are You?";
                data = data.concat("-/-/-" + request.getServletContext().getRealPath("img/slider"));
                result = kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO.getInstance().deleteSlider(data);
                break;
            case "getonemenu":
                result = kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO.getInstance().getOneMenu(data);
                break;
            case "getonemenulevel":
                result = gson.toJson(kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO.getInstance().getBoardLevel(Integer.valueOf(data)));
                break;
            case "modify_notice_menu":   //직접 권한 확인
                if (type.board_level == 0) {
                    result = kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO.getInstance().modifyNoticeMenu(data);
                    session.setAttribute("menulist", gson.toJson(kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO.getInstance().getMenu()));
                    session.setAttribute("headermenulist", gson.toJson(kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO.getInstance().getHeaderMenu()));
                }
                break;
            case "modify_menu":   //직접 권한 확인
                if (type.board_level == 0) {
                    result = kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO.getInstance().modifyMenu(data);
                    session.setAttribute("menulist", gson.toJson(kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO.getInstance().getMenu()));
                    session.setAttribute("headermenulist", gson.toJson(kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO.getInstance().getHeaderMenu()));
                }
                break;
            case "insert_notice_menu":   //직접 권한 확인
                if (type.board_level == 0) {
                    result = kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO.getInstance().insertNoticeMenu(data);
                    session.setAttribute("menulist", gson.toJson(kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO.getInstance().getMenu()));
                    session.setAttribute("headermenulist", gson.toJson(kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO.getInstance().getHeaderMenu()));
                }
                break;
            case "insert_menu":   //직접 권한 확인
                if (type.board_level == 0) {
                    result = kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO.getInstance().insertMenu(data);
                    session.setAttribute("menulist", gson.toJson(kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO.getInstance().getMenu()));
                    session.setAttribute("headermenulist", gson.toJson(kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO.getInstance().getHeaderMenu()));
                }
                break;
            case "getnumorder":
                result = kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO.getInstance().getNumOrder(data);
                break;
            case "delete_notice_menu":   //직접 권한 확인
                if (type.board_level == 0) {
                    result = kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO.getInstance().deleteNoticeMenu(data);
                    session.setAttribute("menulist", gson.toJson(kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO.getInstance().getMenu()));
                    session.setAttribute("headermenulist", gson.toJson(kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO.getInstance().getHeaderMenu()));
                }
                break;
            case "delete_menu":
                if (type.board_level == 0) {   //직접 권한 확인
                    result = kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO.getInstance().deleteMenu(data);
                    session.setAttribute("menulist", gson.toJson(kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO.getInstance().getMenu()));
                    session.setAttribute("headermenulist", gson.toJson(kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO.getInstance().getHeaderMenu()));
                }
                break;
            case "checkid":      //권한 확인 필요 없음(회원가입 중복아이디 체크)
                if (UserDAO.getInstance().checkID(data))
                    result = "";
                else
                    result = "dup";
                break;
        }

        return result;
    }
}