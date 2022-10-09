package kr.ac.kyonggi.cs.handler.action.main;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.boards.GalleryBoardsDAO;
import kr.ac.kyonggi.cs.handler.dao.boards.NoticeBoardsDAO;
import kr.ac.kyonggi.cs.handler.dao.boards.WebzineBoardsDAO;
import kr.ac.kyonggi.cs.handler.dao.boards.req_BoardsDAO;
import kr.ac.kyonggi.cs.handler.dao.graduation.GraduationTestDAO;
import kr.ac.kyonggi.cs.handler.dao.graduation.graduationDAO;
import kr.ac.kyonggi.cs.handler.dao.locker.LockerDAO;
import kr.ac.kyonggi.cs.handler.dao.professor.LaboratoryDAO;
import kr.ac.kyonggi.cs.handler.dao.professor.ProfessorDAO;
import kr.ac.kyonggi.cs.handler.dao.setting.ClubDAO;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.dao.setting.ScheduleDAO;
import kr.ac.kyonggi.cs.handler.dao.track.TrackDao;
import kr.ac.kyonggi.cs.handler.dao.user.UserDAO;
import kr.ac.kyonggi.cs.handler.vo.req_BoardsBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;

public class AjaxAction implements Action{

   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      Gson gson = new Gson();
      String modify = null;
      String req = request.getParameter("req");
      String data = request.getParameter("data");
      HttpSession session = request.getSession();
      UserBean user = gson.fromJson((String)session.getAttribute("user"), UserBean.class);
      UserTypeBean type = gson.fromJson((String)session.getAttribute("type"), UserTypeBean.class);
      String result=null;
      switch(req) {
         case "submitHomeId":
            if (type.board_level > 6)
               return "fail";
            if ("|kknock|hadoop|hadoop2|ssf|blee".contains("|" + data))
               return "fail";
            if (HomeDAO.getInstance().checkHomeId(data).equals("fail"))
               return "fail";
            data = data.concat("-/-/-" + user.id);
            result = HomeDAO.getInstance().submitHomeId(data);
            if (result.equals("success"))
               session.setAttribute("user", gson.toJson(UserDAO.getInstance().getUser(user.id)));
            break;
         case "checkHomeId":
            if ("|kknock|hadoop|hadoop2|ssf|blee".contains("|" + data))
               return "fail";
            result = HomeDAO.getInstance().checkHomeId(data);
            break;
         case "deleteLog":
            File forDeleteLog = new File(request.getServletContext().getRealPath("/WEB-INF"), "log.txt");
            FileWriter fw = new FileWriter(forDeleteLog);
            fw.write("");
            fw.close();
            return "success";
         case "getMainReq":
            result = req_BoardsDAO.getInstance().getMainBoards();
            break;
         case "getGoodWebzine":
            result = WebzineBoardsDAO.getInstance().getMainWebzine();
            break;
         case "getMessageBoard":
            result = WebzineBoardsDAO.getInstance().getMainMessage();
            break;
         case "deleteSlider":   //직접 권한 확인
            if (type.board_level != 0)
               return "Who are You?";
            data = data.concat("-/-/-" + request.getServletContext().getRealPath("img/slider"));
            result = HomeDAO.getInstance().deleteSlider(data);
            break;
         case "getSlider":
            result = HomeDAO.getInstance().getSliders();
            break;
         case "noticegetcomment":      //DAO에서 권한 확인
            data = data.concat("-/-/-" + type.board_level);
            result = NoticeBoardsDAO.getInstance().getComments(data);
            break;
         case "noticecommentInsert":   //직접 권한 확인
            if (Integer.valueOf(data.split("-/-/-")[4]) < type.board_level)
               return null;
            result = NoticeBoardsDAO.getInstance().insertComments(data);
            break;
         case "noticemodifycomment":   //DAO에서 권한확인
            data = data.concat("-/-/-" + user.id + "-/-/-" + type.type_name);
            result = NoticeBoardsDAO.getInstance().updateComments(data);
            break;
         case "noticedeletecomment": //DAO에서 권한확인
            data = data.concat("-/-/-" + user.id + "-/-/-" + type.type_name);
            result = NoticeBoardsDAO.getInstance().deleteComments(data);
            break;
         case "noticeinsertboard":   //DAO에서 권한확인
            data = data.concat("-/-/-" + type.board_level);
            result = NoticeBoardsDAO.getInstance().insertBoards(data);
            break;
         case "noticemodifyboard":   //DAO에서 권한 확인
            NoticeBoardsDAO.getInstance().insertFileId(user.id, data.split("-/-/-")[0]);
            data = data.concat("-/-/-" + user.id + "-/-/-" + type.type_name + "-/-/-" + request.getSession().getServletContext().getRealPath("/uploadFile"));
            result = NoticeBoardsDAO.getInstance().modifyBoards(data);
            break;
         case "notice_board_delete_already_file":   //DAO에서 권한 확인
            data = data.concat("-/-/-" + user.id + "-/-/-" + type.type_name);
            result = NoticeBoardsDAO.getInstance().deleteAlreadyFile(data);
            break;
         case "notice_board_already_file_done":
            data = data.concat("-/-/-" + user.id);
            result = NoticeBoardsDAO.getInstance().alreadyFileDone(data);
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
         case "likeBoard":   //직접 권한 확인
            if (type.board_level > 7)
               return "fail";
            data = data.concat("-/-/-" + user.id);
            result = WebzineBoardsDAO.getInstance().likeBoards(data);
            break;
         case "getMainNote":   //권한 확인 필요 없음(메인화면 띄우는 용)
            result = NoticeBoardsDAO.getInstance().getMainNotes(data);
            break;
         //community
         case "modifyclub":   //직접 권한 확인
            if (type.board_level == 0)
               result = ClubDAO.getInstance().modifyclub(data);
            break;
         case "insertclub":   //직접 권한 확인
            if (type.board_level == 0)
               result = ClubDAO.getInstance().insertclub(data);
            break;
         case "deleteclub":   //직접 권한 확인
            if (type.board_level == 0)
               result = ClubDAO.getInstance().deleteclub(data);
            break;
         case "modifypro":   //직접 권한 확인
            if (type.board_level == 0)
               result = ProfessorDAO.getInstance().modifyProfessor(data);
            break;
         case "checkid":      //권한 확인 필요 없음(회원가입 중복아이디 체크)
            if (UserDAO.getInstance().checkID(data))
               result = "";
            else
               result = "dup";
            break;
         case "registersmallid":
            String small[] = data.split("-/-/-");
            if (UserDAO.getInstance().checkID(small[0]))
               result = UserDAO.getInstance().registerSmallID(data);
            if (result.equals("success")) {
               File log = new File(request.getServletContext().getRealPath("/WEB-INF"), "log.txt");
               BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(log, true));
               bufferedWriter.write(new Date().toString() + "] 회원가입! " + "ID : " + small[0] + " 이름 :" + small[2] + " 타입 : " + small[7] + "\r\n");
               bufferedWriter.close();
            } else
               result = "fail";
            break;
         case "registerbigid":
            String big[] = data.split("-/-/-");
            if (UserDAO.getInstance().checkID(big[0])) {
               result = UserDAO.getInstance().registerBigID(data);
               if (result.equals("success")) {
                  File log = new File(request.getServletContext().getRealPath("/WEB-INF"), "log.txt");
                  BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(log, true));
                  bufferedWriter.write(new Date().toString() + "] 회원가입! " + "ID : " + big[0] + " 이름 :" + big[2] + " 타입 : " + big[7] + "\r\n");
                  bufferedWriter.close();
               }
            } else
               result = "fail";
            break;
         case "checkPassword":
            if (UserDAO.getInstance().checkPassword(data))
               result = "true";
            else
               result = "false";
            break;
         case "getoneprofessor":   //직접 권한 확인
            if (type.board_level == 0)
               result = gson.toJson(ProfessorDAO.getInstance().getOneProfessor(data));
            break;
         case "modifyinfo":   //직접 권한 확인
            if (type.board_level != 0)
               return "fail";
            result = HomeDAO.getInstance().modifyinfo(data);
            break;
         case "getoneschedule":   //직접 권한 확인
            if (type.board_level == 0)
               result = ScheduleDAO.getInstance().getOneSchedule(data);
            break;
         case "modifyschedule":   //직접 권한 확인
            if (type.board_level == 0) {
               result = ScheduleDAO.getInstance().modifySchedule(data);
               session.setAttribute("schedulelist", gson.toJson(ScheduleDAO.getInstance().getSchedule()));
            }
            break;
         case "insertschedule":   //직접 권한 확인
            if (type.board_level == 0) {
               result = ScheduleDAO.getInstance().insertSchedule(data);
               session.setAttribute("schedulelist", gson.toJson(ScheduleDAO.getInstance().getSchedule()));
            }
            break;
         case "deleteschedule":   //직접 권한 확인
            if (type.board_level == 0) {
               result = ScheduleDAO.getInstance().deleteSchedule(data);
               session.setAttribute("schedulelist", gson.toJson(ScheduleDAO.getInstance().getSchedule()));
            }
            break;
         case "getonemenu":
            result = HomeDAO.getInstance().getOneMenu(data);
            break;
         case "getonemenulevel":
            result = gson.toJson(HomeDAO.getInstance().getBoardLevel(Integer.valueOf(data)));
            break;
         case "modify_notice_menu":   //직접 권한 확인
            if (type.board_level == 0) {
               result = HomeDAO.getInstance().modifyNoticeMenu(data);
               session.setAttribute("menulist", gson.toJson(HomeDAO.getInstance().getMenu()));
               session.setAttribute("headermenulist", gson.toJson(HomeDAO.getInstance().getHeaderMenu()));
            }
            break;
         case "modify_menu":   //직접 권한 확인
            if (type.board_level == 0) {
               result = HomeDAO.getInstance().modifyMenu(data);
               session.setAttribute("menulist", gson.toJson(HomeDAO.getInstance().getMenu()));
               session.setAttribute("headermenulist", gson.toJson(HomeDAO.getInstance().getHeaderMenu()));
            }
            break;
         case "getnumorder":
            result = HomeDAO.getInstance().getNumOrder(data);
            break;
         case "insert_notice_menu":   //직접 권한 확인
            if (type.board_level == 0) {
               result = HomeDAO.getInstance().insertNoticeMenu(data);
               session.setAttribute("menulist", gson.toJson(HomeDAO.getInstance().getMenu()));
               session.setAttribute("headermenulist", gson.toJson(HomeDAO.getInstance().getHeaderMenu()));
            }
            break;
         case "insert_menu":   //직접 권한 확인
            if (type.board_level == 0) {
               result = HomeDAO.getInstance().insertMenu(data);
               session.setAttribute("menulist", gson.toJson(HomeDAO.getInstance().getMenu()));
               session.setAttribute("headermenulist", gson.toJson(HomeDAO.getInstance().getHeaderMenu()));
            }
            break;
         case "delete_notice_menu":   //직접 권한 확인
            if (type.board_level == 0) {
               result = HomeDAO.getInstance().deleteNoticeMenu(data);
               session.setAttribute("menulist", gson.toJson(HomeDAO.getInstance().getMenu()));
               session.setAttribute("headermenulist", gson.toJson(HomeDAO.getInstance().getHeaderMenu()));
            }
            break;
         case "delete_menu":
            if (type.board_level == 0) {   //직접 권한 확인
               result = HomeDAO.getInstance().deleteMenu(data);
               session.setAttribute("menulist", gson.toJson(HomeDAO.getInstance().getMenu()));
               session.setAttribute("headermenulist", gson.toJson(HomeDAO.getInstance().getHeaderMenu()));
            }
            break;
         case "insertReqBoard":   //DAO에서 권한 확인
            data = data.concat("-/-/-" + type.board_level);
            result = req_BoardsDAO.getInstance().insertBoards(data);
            break;
         case "modifyReqBoard":   //DAO에서 권한 확인
            data = (user.id + "-/-/-").concat(data);
            data = data.concat("-/-/-" + type.type_name + "-/-/-" + request.getSession().getServletContext().getRealPath("/uploadFile/reqBoards"));
            result = req_BoardsDAO.getInstance().modifyBoards(data);
            break;
         case "makeReqFile":
            String path = request.getSession().getServletContext().getRealPath("/uploadFile/reqBoards");
            String realPath = path + "/" + data;
            File forRequest = new File(realPath);
            forRequest.mkdir();
            result = "success";
            break;
         case "req_board_delete_already_file":   //DAO에서 권한 확인
            String forAlreadyFileUser = "-/-/-" + user.id + "-/-/-" + type.type_name;
            data = data.concat(forAlreadyFileUser);
            result = req_BoardsDAO.getInstance().deleteAlreadyFile(data);
            break;
         case "req_board_already_file_exit":      //DAO에서 권한 확인
            data = data.concat("-/-/-" + user.id + "-/-/-" + type.type_name);
            result = req_BoardsDAO.getInstance().alreadyFileExit(data);
            break;
         case "insertAnswer":               //직접 권한 확인
            req_BoardsBean req_BoardsCheck = req_BoardsDAO.getInstance().getBoardRead(Integer.valueOf(data.split("-/-/-")[0]));
            if (!req_BoardsCheck.level.contains(type.for_header))
               return "fail";
            if (new Date().getTime() > (req_BoardsCheck.closing_date.getTime() + 60 * 60 * 1000 * 24) || new Date().getTime() < req_BoardsCheck.starting_date.getTime())
               return "timeout";
            data = (user.name + "-/-/-" + user.id + "-/-/-" + user.per_id + "-/-/-" + user.grade + "-/-/-" + user.type + "-/-/-").concat(data);
            result = req_BoardsDAO.getInstance().insertAnswers(data);
            System.out.println(result);
            break;
         case "getUserType":
            result = gson.toJson(UserDAO.getInstance().getType(data));
            break;
         case "whoAnswerIt":      //권한 확인 필요 없음(내가 이 신청 및 접수 글에 답변을 하였는지 확인하는 메소드)
            data = data.concat("-/-/-" + user.id);
            result = req_BoardsDAO.getInstance().whoAnswerIt(data);
            break;
         case "getQuestions":   //DAO에서 권한 확인
            data = data.concat("-/-/-" + type.for_header + "-/-/-" + user.id + "-/-/-" + type.board_level);
            result = gson.toJson(req_BoardsDAO.getInstance().getQuestions(data));
            break;
         case "deleteWhoAnswer":   //DAO에서 권한 확인
            data = data.concat("-/-/-" + user.name + "-/-/-" + user.per_id + "-/-/-" + user.grade + "-/-/-" + user.id);
            String deletePath = request.getSession().getServletContext().getRealPath("/uploadFile/reqBoards");
            String realDeletePath = deletePath + "/" + data.split("-/-/-")[0];
            data = data.concat("-/-/-" + realDeletePath);
            result = req_BoardsDAO.getInstance().deleteWhoAnswer(data);
            break;
         case "removeQuestion":   //직접 권한 확인
            String removePath = request.getSession().getServletContext().getRealPath("/uploadFile/reqBoards");
            req_BoardsBean removeReq = req_BoardsDAO.getInstance().getBoardRead(Integer.valueOf(data));
            if (!removeReq.student_id.equals(user.id) && !type.type_name.equals("관리자") && !type.type_name.equals("홈페이지관리자")) {
               result = "fail";
               break;
            }
            data = data.concat("-/-/-" + removePath);
            result = req_BoardsDAO.getInstance().removeQuestion(data);
            break;
         case "modifyuserdata":   //직접 권한 확인
            String arr[] = data.split("-/-/-");//0:id 1:phone 2:birth 3:email
            if (!arr[0].equals(user.id))
               return "fail";
            result = UserDAO.getInstance().modifydata(data);
            session.setAttribute("user", gson.toJson(UserDAO.getInstance().getUser(arr[0])));
            break;
         case "updateSchedule":   //직접 권한 확인
            if (type.board_level == 0) {
               result = ScheduleDAO.getInstance().updateSchedule();
            }
            //request.getSession().setAttribute("schedulelist",gson.toJson(ScheduleDAO.getInstance().getSchedule()));
            break;
         case "getMainSchedule":
            result = gson.toJson(ScheduleDAO.getInstance().getSchedule());
            break;
         case "getHeaderMenu":
            result = gson.toJson(HomeDAO.getInstance().getHeaderMenu());
            break;
         case "getSmallMenu":
            result = gson.toJson(HomeDAO.getInstance().getMenu());
            break;
         case "galleryInsertBoard":   //DAO에서 권한 확인
            String forGalleryInsert = user.id + "-/-/-" + user.name + "-/-/-";
            data = forGalleryInsert.concat(data);
            data = data.concat("-/-/-" + type.board_level);
            result = GalleryBoardsDAO.getInstance().insertGalleryBoards(data);
            break;
         case "galleryInsertComment":   //직접 권한 확인
            if (Integer.valueOf(data.split("-/-/-")[4]) < type.board_level)
               return null;
            result = GalleryBoardsDAO.getInstance().insertComments(data);
            break;
         case "galleryGetComment":      //DAO에서 권한 확인
            data = data.concat("-/-/-" + type.board_level);
            result = GalleryBoardsDAO.getInstance().getComments(data);
            break;
         case "galleryDeleteComment":   //DAO에서 권한 확인
            data = data.concat("-/-/-" + user.id + "-/-/-" + type.type_name);
            result = GalleryBoardsDAO.getInstance().deleteComments(data);
            break;
         case "galleryModifyComment":   //DAO에서 권한 확인
            data = data.concat("-/-/-" + user.id + "-/-/-" + type.type_name);
            result = GalleryBoardsDAO.getInstance().updateComments(data);
            break;
         case "gallery_image_delete_modify":   //DAO에서 권한 확인
            data = data.concat("-/-/-" + user.id + "-/-/-" + type.type_name);
            result = GalleryBoardsDAO.getInstance().deleteImageModify(data);
            break;
         case "gallery_image_modify_exit":   //DAO에서 권한 확인
            data = data.concat("-/-/-" + user.id + "-/-/-" + type.type_name);
            result = GalleryBoardsDAO.getInstance().deleteImageModifyExit(data);
            break;
         case "gallery_modify_board":      //DAO에서 권한 확인
            String plusData = "-/-/-" + user.id + "-/-/-" + type.type_name + "-/-/-" + request.getSession().getServletContext().getRealPath("/img/gallery");
            data = data.concat(plusData);
            result = GalleryBoardsDAO.getInstance().modifyBoard(data);
            break;
         case "getonelaboratory":   //직접 권한 확인
            if (type.board_level == 0)
               result = gson.toJson(LaboratoryDAO.getInstance().getOneLaboratory(data));
            break;
         case "modifylab":      //직접 권한 확인
            if (type.board_level == 0)
               result = LaboratoryDAO.getInstance().modifyLaboratory(data);
            break;


         //사물함 관련 기능
         case "modifyLockerCon":   //직접 권한 확인
            if (type.type_name.equals("사물함관리자")) //관리자만 수정할 수 있게 월권 방지함.
               result = LockerDAO.getInstance().modifyContent(data);
            break;
         case "insertLockerSchedule":
            result = LockerDAO.getInstance().changeSchedule(data); //앞서 받은 data를 해당 메소드로 넘겨준 후 result에 반환값(데이터)를 받아서 jsp로 다시 돌려줌.
            break;
         case "submit_apply":// 사물함 신청 제출
            result = LockerDAO.getInstance().insertApply(data);
            return result;

         case "submit_update_apply": //사물함 신청 수정
            result = LockerDAO.getInstance().updateApply(data);
            return result;

         case "checkMyDeposit": //보증금 입금 확인 요청 (사용자 -> 관리자)
            result = LockerDAO.getInstance().checkMyDeposit(data);
            break;
         case "return_picture":// 반환사진
            modify = request.getParameter("modify");
            JsonParser parser0 = new JsonParser();
            JsonElement element0 = parser0.parse(data);
            if (modify.equals("modify")) {
               result = LockerDAO.getInstance().modifyReturnPicture(element0);
               break;
            } else
               result = LockerDAO.getInstance().insertReturnPicture(element0);
            break;

         case "return_picture2":// 반환사진
            modify = request.getParameter("modify");
            JsonParser parser9 = new JsonParser();
            JsonElement element9 = parser9.parse(data);
            if (modify.equals("modify")) {
               result = LockerDAO.getInstance().modifyReturnPicture2(element9);
               break;
            } else
               result = LockerDAO.getInstance().insertReturnPicture2(element9);
            break;

         case "deleteAppliedStudent": //사물함 신청 삭제
            result = LockerDAO.getInstance().deleteAppliedStudent(data);
            return result;
         case "allocateLocker":// 사물함 배정
            System.out.println(data);
            result = LockerDAO.getInstance().allocateLocker(data);
            break;
            
         case "deleteAssignedStudent": //사물함 배정 삭제
            String arr3[] = data.split("-/-/-");
            for (int i = 0; i < arr3.length; i++)
               result = LockerDAO.getInstance().deleteAssignedStudent(arr3[i]);
            return result;

         case "allowReturnLocker":// 사물함 반납처리
            System.out.println(data);
            result = LockerDAO.getInstance().allowReturnLocker(data);
            break;
         case "deleteLocker": //사물함 삭제
            result = LockerDAO.getInstance().deleteLocker(data);
            return result;
         case "changeAvailable":
            result = LockerDAO.getInstance().changeAvailable(data);
            break;
         case "modifyInfo":
            result = LockerDAO.getInstance().modifyInfo(data);
            break;


         case "setAllLockerAvailableTrue":
            result=LockerDAO.getInstance().setAllLockerAvailableTrue();
            break;

         case "deleteAllAssignedStudents":
            result=LockerDAO.getInstance().deleteAllAssignedStudents();
            break;

         //졸업논문 기능
         // graduation
         case "modifygracon":   //직접 권한 확인
            if (type.type_name.equals("졸업논문관리자"))
               result = GraduationTestDAO.getInstance().modifyContent(data);
            break;
         case "insertgradschedule":
            result = GraduationTestDAO.getInstance().changeSchedule(data);
            break;
         case "checkper_id":// 바꿈
            result = UserDAO.getInstance().checkper_id(data);
            break;
         case "checkper_id_req":// 바꿈
            result = UserDAO.getInstance().checkper_id_req(data);
            break;
         case "submit_request"://
            result = GraduationTestDAO.getInstance().insert_request(data);
            break;
         case "submit_update_request":
            result = GraduationTestDAO.getInstance().update_request(data);
            break;
         case "submit_suggest":
            modify = request.getParameter("modify");
            if (modify.equals("modify")) { //수정
               result = GraduationTestDAO.getInstance().modify_suggest(data);
               break;
            } else //처음 제출
               result = GraduationTestDAO.getInstance().insert_suggest(data);
            break;//
         case "insert_mid":// 2.18
            modify = request.getParameter("modify");
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(data);
            if (modify.equals("modify")) {
               result = GraduationTestDAO.getInstance().modify_mid(element);
               break;
            } else
               result = GraduationTestDAO.getInstance().insert_mid(element);
            break;
         case "insert_final":// 2.18
            modify = request.getParameter("modify");
            JsonParser parser1 = new JsonParser();
            JsonElement element1 = parser1.parse(data);
            if (modify.equals("modify")) {
               result = GraduationTestDAO.getInstance().modify_final(element1);
               break;
            } else
               result = GraduationTestDAO.getInstance().insert_final(element1);
            break;
         //jonghun
         case "insert_license":
            JsonParser parser2 = new JsonParser();
            JsonElement element2 = parser2.parse(data);
            modify = request.getParameter("modify");
            if (modify.equals("modify")) {
               result = GraduationTestDAO.getInstance().modify_license(element2);
            } else {
               result = GraduationTestDAO.getInstance().insert_license(element2);
            }
            break;
         case "insert_etc2":
            modify = request.getParameter("modify");
            JsonParser parser3 = new JsonParser();
            JsonElement element3 = parser3.parse(data);
            if (modify.equals("modify")) {
               result = GraduationTestDAO.getInstance().modify_etc2(element3);
               break;
            } else
               result = GraduationTestDAO.getInstance().insert_etc2(element3);
            break;
         case "insert_etc3":
            modify = request.getParameter("modify");
            JsonParser parser4 = new JsonParser();
            JsonElement element4 = parser4.parse(data);
            if (modify.equals("modify")) {
               result = GraduationTestDAO.getInstance().modify_etc3(element4);
               break;
            } else
               result = GraduationTestDAO.getInstance().insert_etc3(element4);
            break;//02.20 추가
         case "success_grd"://02.21추가
            modify = request.getParameter("state");//상태
            result = GraduationTestDAO.getInstance().success(data, modify);
            break;

         case "req_refuse":
            result = GraduationTestDAO.getInstance().req_refuse(data);
            break;
         case "refuse_grd":
            modify = request.getParameter("state");
            result = GraduationTestDAO.getInstance().refuse(data, modify);
            break;

         case "delay_open":
            result = GraduationTestDAO.getInstance().delayThesis(data);
            break;      //joohyung 추가

         case "submit_track_request":
            result = TrackDao.getInstance().insert_request(user.id, data);
            break;
         case "delete_last_semester_table":
            result = TrackDao.getInstance().delete_last_sem(user.id, data);
            break;
         case "delete_all_semester_table"://추가, 0119
            result = TrackDao.getInstance().delete_all_sem(user.id, data);
            break;
         case "enroll_new_user":
            result = TrackDao.getInstance().enrollNewUser(data);
            break;
         case "add_user_compSem":
            result = TrackDao.getInstance().addUserCompSem(user.id, data);
      }
      return result;
   }

}