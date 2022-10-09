package kr.ac.kyonggi.cs.handler.dao.locker;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;
import kr.ac.kyonggi.cs.common.sql.Config;
import kr.ac.kyonggi.cs.handler.dto.locker.*;
import kr.ac.kyonggi.cs.handler.vo.MenuBean;
import kr.ac.kyonggi.cs.handler.vo.TextBean;
import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.ColumnListHandler;
import org.apache.commons.dbutils.handlers.MapListHandler;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

public class LockerDAO {
    public static LockerDAO it;

    public static LockerDAO getInstance() { //인스턴스 생성
        if (it == null)
            it = new LockerDAO();
        return it;
    }

    //공통으로 사용되는 메소드
    public ArrayList<MenuBean> getTabMenu(int id) { //좌측 탭 메뉴를 가져오는 곳.
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            if (id == 0) { //관리자 일때
                listOfMaps = queryRunner.query(conn, "SELECT * FROM `fdb_pages` where `tab_id` = 11 and orderNum>3 ORDER BY orderNum ASC;", new MapListHandler());
//                System.out.println("관리자 탭메뉴 불러옴"); //정상 작동함
            } else if (id == 1) { //사용자 일때
                listOfMaps = queryRunner.query(conn, "SELECT * FROM `fdb_pages` where `tab_id` = 11 and orderNum<4 ORDER BY orderNum ASC;", new MapListHandler());
//                System.out.println("사용자 탭메뉴 불러옴"); //정상 작동함
            } else { //관리자와 사용자 둘 다 아닌 경우
                listOfMaps = null;
            }
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<MenuBean> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<MenuBean>>() {
        }.getType()); //위에서 불러온 DB를 MenuBean 타입으로 만들어서 return 해줌
        return selectedList;
    }


    //여기서부턴 일정 관련 메소드
    public static String dateToString(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(date);
    }

    public static String endDateToString(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");
        return sdf.format(date);
    }

    public ArrayList<LockerScheduleDTO> getScheduleList() { //스케쥴 관련 DB 불러오기
        ArrayList<LockerScheduleDTO> result = null;
        List<Map<String, Object>> list = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner que = new QueryRunner();
            list = que.query(conn, "SELECT * FROM locker_schedule WHERE schedule_id<7;", new MapListHandler());
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        result = gson.fromJson(gson.toJson(list), new TypeToken<List<LockerScheduleDTO>>() {
        }.getType());
        Date today = new Date();
        int s, e;
        for (LockerScheduleDTO g : result) {
//            g.setSchedule_name(Level.getLevel(g.getSchedule_name_int()));
            g.setStarting_date_str(dateToString(g.getStarting_date()));
            g.setEnd_date_str(endDateToString(g.getEnd_date()));
            s = today.compareTo(g.getStarting_date());
            e = today.compareTo(g.getEnd_date());
            if (e > 0) {
                g.setGrd_state("마감");
            } else if (e <= 0 && s >= 0) {
                g.setGrd_state("진행중");
            } else {
                g.setGrd_state("대기");
            }

        }
        return result;
    }

    // 수정필요
    public String modifyContent(String data) { //스케쥴 관련 DB (content) 수정하기

        String arr[] = data.split("-/-/-"); // 0 content 1 schedulename
        String name = arr[0];
        Connection conn = Config.getInstance().sqlLogin();
        List<String> result = null;
        try {
            QueryRunner que = new QueryRunner();
            que.update(conn, "UPDATE locker_schedule SET schedule_contents=? WHERE schedule_name=?;", arr[1], name);
            result = que.query(conn, "SELECT schedule_contents FROM locker_schedule WHERE schedule_name=?",
                    new ColumnListHandler<String>(), name);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }

        return result.get(0);
    }

    // 수정필요
    public String changeSchedule(String data) throws ParseException { //스케쥴 관련 DB (일정) 수정하기
        String arr[] = data.split("-/-/-");// 0=name 1=start 2=close
        String name = arr[0];
        Connection conn = Config.getInstance().sqlLogin();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate start = null;
        LocalDate end = null;
        try {
            start = LocalDate.parse(arr[1], formatter);
            end = LocalDate.parse(arr[2], formatter);
        } catch (Exception e) {
            e.printStackTrace();
        }

//        int level = Level.getLevelInt(arr[0]);

        try {
            QueryRunner que = new QueryRunner();
            que.update(conn, "UPDATE locker_schedule SET starting_date=?,end_date=? WHERE schedule_name=?", start,
                    end, name);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date today = new Date();


        /*
        try { //이건 뭘까?
            GraduationQuartzMain graduationQuartzMain=GraduationQuartzMain.getInstance();
            graduationQuartzMain.offTimer();
            graduationQuartzMain.timeraction(sdf.format(today));
        }catch (Exception e){
            e.printStackTrace();
        }

         */


        return arr[0];
    }


    //여기서부턴 신청관련 메소드
    public LockerAppliedUserDTO getAppliedStudent(int per_id) { //신청자 명단 1개 불러오기
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        ArrayList<LockerAppliedUserDTO> student = null;
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM locker_applied_students WHERE per_id=?", new MapListHandler(),
                    per_id);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        student = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<LockerAppliedUserDTO>>() {
        }.getType());

        if (student.size() > 0) {

            return student.get(0);
        } else {

            return null;
        }
    }

    
    public LockerScheduleDTO getOneSchedule(int schedule_id) { //신청접수 스케쥴 DB 호출하는 메소드
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        ArrayList<LockerScheduleDTO> schedule = null;
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn,
                    "SELECT schedule_name,starting_date,end_date FROM locker_schedule WHERE schedule_id=?;",
                    new MapListHandler(), schedule_id);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        schedule = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<LockerScheduleDTO>>() {
        }.getType());
//        schedule.get(0).setSchedule_name(Level.getLevel(schedule.get(0).getSchedule_name_int()));
        schedule.get(0).setStarting_date_str(dateToString(schedule.get(0).getStarting_date()));
        schedule.get(0).setEnd_date_str(endDateToString(schedule.get(0).getEnd_date()));
        return schedule.get(0);
    }


    public String checkMyDeposit(String data) { //보증금 확인 요청
        Connection conn = Config.getInstance().sqlLogin();
        String selected = "";
        try {
            QueryRunner query = new QueryRunner();
            query.update(conn, "UPDATE locker_applied_students SET deposit='입금완료' WHERE per_id=?;", data);
//            query.update(conn, "UPDATE grdu_userlog SET logetc=? WHERE per_id=? AND grd_state=?;", arr[3], arr[0], 1);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return selected;
    }

    public LockerAssignedUserDTO getLockerUser(int per_id) { //사물함 배정자 명단
        Gson gson = new Gson();
        Connection conn = Config.getInstance().sqlLogin();
        List<Map<String, Object>> listOfMaps = null;
        ArrayList<LockerAssignedUserDTO> list = null;
        try {
            QueryRunner query = new QueryRunner();
            listOfMaps = query.query(conn, "SELECT * FROM locker_assigned_students WHERE per_id=?;", new MapListHandler(), per_id);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        list = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<LockerAssignedUserDTO>>() {
        }.getType());
        if (list.size() > 0) {
            return list.get(0);
        } else
            return null;
    }

    public String insertApply(String data) {
        String arr[] = data.split("-/-/-");// 0:user.per_id 1:name 2:date 3:anwer 4:lockerNum 5: phoneNum 6: bank 7: accountNum 8:major
        String result = "";
        Connection conn = Config.getInstance().sqlLogin();
        List<Map<String, Object>> check_students = null;
        List<Map<String, Object>> check_locker1 = null;
        List<Map<String, Object>> check_locker2 = null;

        String locker[] = arr[4].split(" ");
        String locker_type=locker[0].substring(1, locker[0].length()-1 );
        String locker_num=locker[1].substring(0, locker[1].length()-1 );
        try {
            QueryRunner query = new QueryRunner();
            check_students = query.query(conn, "SELECT * FROM locker_applied_students WHERE per_id=?;", new MapListHandler(), arr[0]);//이미 신청된 학생인지 검사
            check_locker1 =  query.query(conn, "SELECT * FROM locker WHERE locker_num=? and locker_type=? and available='사용중';", new MapListHandler(), locker_num, locker_type);//사물함이 사용중인지 검사
            check_locker2 =  query.query(conn, "SELECT * FROM locker WHERE locker_num=? and locker_type=? and available='사용불가';", new MapListHandler(), locker_num, locker_type);//사물함이 사용불가인지 검사

            if (check_students.size() > 0) {//이미 신청 성공한 학생이라면 입력을 하지 않음.
                result="부정신청";
            }
            else if (check_locker1.size()>0 || check_locker2.size()>0){
                result="중복신청";
            }
            else {//배정안된학생인 경우 || 신청하려는 사물함이 자리가 비어있다면
                query.update(conn, "INSERT locker_applied_students SET per_id=?,name=?, locker_num=?, phoneNum=?, bank=?, accountNum=?,major=?, state='신청접수(심사중)', deposit='미입금';",
                        arr[0], arr[1], arr[4],arr[5],arr[6],arr[7],arr[8]);
                query.update(conn, "UPDATE locker SET available='사용중' WHERE locker_num=? and locker_type=?;", locker_num, locker_type);


                Date now = new Date();
                query.update(conn, "INSERT locker_log SET student_id=?,student_name=?, date=?, state=?, method_name=?, request_query=?;",
                        arr[0], arr[1], now, "사물함신청", "LockerDAO.insertApply", data);

                result="신청성공";
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return result;
    }

    public String updateApply(String data) {
        String arr[] = data.split("-/-/-");// 0:user.per_id 1:name 2:date 3:anwer 4:lockerNum 5: phoneNum 6: bank 7: accountNum 8:major 9:beforeLockerNum
        System.out.println(data);
        Connection conn = Config.getInstance().sqlLogin();
        List<Map<String, Object>> check_locker1 = null;
        List<Map<String, Object>> check_locker2 = null;
        String result = "";
        String newLocker[] = arr[4].split(" ");
        String new_locker_type=newLocker[0].substring(1, newLocker[0].length()-1 );
        String new_locker_num=newLocker[1].substring(0, newLocker[1].length()-1 );
        String originalLocker[] = arr[9].split(" ");
        String original_locker_type=originalLocker[0].substring(1, originalLocker[0].length()-1 );
        String original_locker_num=originalLocker[1].substring(0, originalLocker[1].length()-1 );

        try {
            QueryRunner query = new QueryRunner();
            if(original_locker_type.equals(new_locker_type) && original_locker_num.equals(new_locker_num)){ //사물함은 그대로고 정보 수정만 하게되는 경우
                query.update(conn, "UPDATE locker_applied_students SET phoneNum=?, bank=?, accountNum=? WHERE per_id=?;", arr[5],arr[6],arr[7],arr[0]);
                result="신청성공";

                Date now = new Date();
                query.update(conn, "INSERT locker_log SET student_id=?,student_name=?, date=?, state=?, method_name=?, request_query=?;",
                        arr[0], arr[1], now, "사물함수정1", "LockerDAO.updateApply", data);

                return result;
                //얘는 여기에서 이대로 result 보내버림.
            }
            else{ //사물함을 수정하는 경우
                check_locker1 =  query.query(conn, "SELECT * FROM locker WHERE locker_num=? and locker_type=? and available='사용중';", new MapListHandler(), new_locker_num, new_locker_type);//사물함이 사용중인지 검사
                check_locker2 =  query.query(conn, "SELECT * FROM locker WHERE locker_num=? and locker_type=? and available='사용불가';", new MapListHandler(), new_locker_num, new_locker_type);//사물함이 사용불가인지 검사
                if (check_locker1.size()>0 || check_locker2.size()>0){ //사물함을 수정하지 않고 정보 수정만 하는사람은 check_locker가 null이라서 검사 자체를 하지 않는듯 함. 그냥 위에서 return 처리함.
                    result="중복신청";
                }
                else {//옮기려는 자리가 비어있다면
                    query.update(conn, "UPDATE locker_applied_students SET locker_num=? ,phoneNum=?, bank=?, accountNum=? WHERE per_id=?;", arr[4], arr[5],arr[6],arr[7],arr[0]);
                    query.update(conn, "UPDATE locker SET available='사용가능' WHERE locker_num=? and locker_type=?;", original_locker_num, original_locker_type);
                    query.update(conn, "UPDATE locker SET available='사용중' WHERE locker_num=? and locker_type=?;", new_locker_num, new_locker_type);
                    Date now = new Date();
                    query.update(conn, "INSERT locker_log SET student_id=?,student_name=?, date=?, state=?, method_name=?, request_query=?;",
                            arr[0], arr[1], now, "사물함수정2", "LockerDAO.updateApply", data);
                    result="신청성공";
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return result;
    }

    public ArrayList<LockerAppliedUserDTO> getAllAppliedStudents() { //신청자 명단 (전체)
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        ArrayList<LockerAppliedUserDTO> student = null;
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM locker_applied_students", new MapListHandler());
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<LockerAppliedUserDTO> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<LockerAppliedUserDTO>>() {
        }.getType());
        //System.out.println("userDAO.getAIuser "+selected.size());
        if (selected.size() > 0) {
            return selected;
        } else
            return null;
    }

    public String deleteAppliedStudent(String data) { //사물함 신청 삭제
        String arr[] = data.split("-/-/-");// 0:user.per_id 1:locker_num
        Connection conn = Config.getInstance().sqlLogin();
        String locker[] = arr[1].split(" ");
        String locker_type=locker[0].substring(1, locker[0].length()-1 );
        String locker_num=locker[1].substring(0, locker[1].length()-1 );
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn, "DELETE FROM locker_applied_students WHERE per_id=? ;", arr[0]);
            queryRunner.update(conn, "UPDATE locker SET available='사용가능' WHERE locker_num=? and locker_type=?;", locker_num, locker_type);

        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return data;
    }

    public String allocateLocker(String data) {
        String arr[] = data.split("-/-/-");// 0:locker_num 1:per_id 2:name 3: major 4:phoneNum 5:bank 6:accountNum
        String result = "";
        Connection conn = Config.getInstance().sqlLogin();
        List<Map<String, Object>> check_students = null;
        try {
            QueryRunner query = new QueryRunner();
            check_students = query.query(conn, "SELECT * FROM locker_assigned_students WHERE per_id=?;", new MapListHandler(),
                    arr[1]);
            if (check_students.size() > 0) {

            } else {
                if (query.query(conn, "SELECT * FROM locker_assigned_students WHERE locker_num=?;", new MapListHandler(), arr[0])
                        .size() > 0) {
                } else {
                    query.update(conn, "INSERT locker_assigned_students SET locker_num=?, per_id=?, name=?, major=?, phoneNum=?, bank=?, accountNum=?, state='사물함 사용중', deposit='미환불';", arr[0], arr[1], arr[2], arr[3], arr[4], arr[5], arr[6]);
                    query.update(conn, "UPDATE locker_applied_students SET state='배정완료' WHERE per_id=?;", arr[1]);
                    query.update(conn, "INSERT locker_data SET locker_num=?, per_id=?, name=?;", arr[0], arr[1], arr[2]);
                    query.update(conn, "INSERT locker_data_front SET locker_num=?, per_id=?, name=?;", arr[0], arr[1], arr[2]);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return result;
    }

    public LockerAssignedUserDTO getAssignedStudent(int per_id) { //대상자 명단 1개 불러오기
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        ArrayList<LockerAssignedUserDTO> student = null;
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM locker_assigned_students WHERE per_id=?", new MapListHandler(),
                    per_id);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        student = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<LockerAssignedUserDTO>>() {
        }.getType());

        if (student.size() > 0) {

            return student.get(0);
        } else {

            return null;
        }
    }

    public ArrayList<LockerAssignedUserDTO> getAllAssignedStudents() { //대상자 명단 (전체)
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        ArrayList<LockerAssignedUserDTO> student = null;
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM locker_assigned_students", new MapListHandler());
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<LockerAssignedUserDTO> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<LockerAssignedUserDTO>>() {
        }.getType());
        //System.out.println("userDAO.getAIuser "+selected.size());
        if (selected.size() > 0) {
            return selected;
        } else
            return null;
    }

    public String deleteAssignedStudent(String data) { //사물함 대상자 삭제
        Connection conn = Config.getInstance().sqlLogin();
        //System.out.println("userdao.deleteAIuser");
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn, "DELETE FROM locker_assigned_students WHERE per_id=? ;", data);
            queryRunner.update(conn, "DELETE FROM locker_data WHERE per_id=? ;", data);
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return data;
    }

    public String insertReturnPicture(JsonElement element) { //제출버튼 누르는 경우

        JsonObject obj = element.getAsJsonObject();
        String per_id = obj.get("per_id").getAsString();
        int perid = Integer.parseInt(per_id);
        String name = obj.get("name").getAsString();
//        String locker_num = obj.get("locker_num").getAsString();
//        String content = obj.get("progress").getAsString();
//        String plan = obj.get("plan").getAsString();
        String file = obj.get("file").getAsString();
        String realfile = obj.get("realfile").getAsString();
        Date temp = new Date();
        String now = dateToString(temp);
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner que = new QueryRunner(); // thesis students log
            que.update(conn, "UPDATE locker_data SET filename=?,file_path=? WHERE per_id=?;", file, realfile, perid);
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }

        return per_id;
    }
    public String insertReturnPicture2(JsonElement element) { //제출버튼 누르는 경우

        JsonObject obj = element.getAsJsonObject();
        String per_id = obj.get("per_id").getAsString();
        int perid = Integer.parseInt(per_id);
        String name = obj.get("name").getAsString();
//        String locker_num = obj.get("locker_num").getAsString();
//        String content = obj.get("progress").getAsString();
//        String plan = obj.get("plan").getAsString();
        String file = obj.get("file").getAsString();
        String realfile = obj.get("realfile").getAsString();
        Date temp = new Date();
        String now = dateToString(temp);
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner que = new QueryRunner(); // thesis students log
            que.update(conn, "UPDATE locker_data_front SET filename=?,file_path=? WHERE per_id=?;", file, realfile, perid);
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }

        return per_id;
    }
    public String modifyReturnPicture(JsonElement element) { //수정 버튼 누르는 경우
        JsonObject obj = element.getAsJsonObject();
        String per_id = obj.get("per_id").getAsString();
        int perid = Integer.parseInt(per_id);
        String name = obj.get("name").getAsString();
//        String locker_num = obj.get("locker_num").getAsString();
//        String content = obj.get("progress").getAsString();
//        String plan = obj.get("plan").getAsString();
        String file = obj.get("file").getAsString();
        String realfile = obj.get("realfile").getAsString();
        Date temp = new Date();
        String now = dateToString(temp);
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner que = new QueryRunner(); // thesis students log
            que.update(conn,
                    "UPDATE locker_data SET filename=?,file_path=? WHERE per_id=?;",
                    file, realfile, perid);
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return per_id;
    }
    public String modifyReturnPicture2(JsonElement element) { //수정 버튼 누르는 경우
        JsonObject obj = element.getAsJsonObject();
        String per_id = obj.get("per_id").getAsString();
        int perid = Integer.parseInt(per_id);
        String name = obj.get("name").getAsString();
//        String locker_num = obj.get("locker_num").getAsString();
//        String content = obj.get("progress").getAsString();
//        String plan = obj.get("plan").getAsString();
        String file = obj.get("file").getAsString();
        String realfile = obj.get("realfile").getAsString();
        Date temp = new Date();
        String now = dateToString(temp);
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner que = new QueryRunner(); // thesis students log
            que.update(conn,
                    "UPDATE locker_data_front SET filename=?,file_path=? WHERE per_id=?;",
                    file, realfile, perid);
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return per_id;
    }
    public void insertFile(String filename, int per_id) { //업로드 버튼 누르는 경우

        Connection conn = Config.getInstance().sqlLogin();
        try {
            System.out.println("insertFile is working");
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn, "UPDATE locker_data SET filename=? WHERE per_id=?;", filename, per_id);
            queryRunner.update(conn, "UPDATE locker_assigned_students SET img_inside='사진제출완료' WHERE per_id=?;", per_id);

        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
    }
    public void insertFile2(String filename, int per_id) { //업로드 버튼 누르는 경우

        Connection conn = Config.getInstance().sqlLogin();
        try {
            System.out.println("insertFile is working");
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn, "UPDATE locker_data_front SET filename=? WHERE per_id=?;", filename, per_id);
            queryRunner.update(conn, "UPDATE locker_assigned_students SET img_front='사진제출완료' WHERE per_id=?;", per_id);

        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
    }

    public String allowReturnLocker(String per_id) {

        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn, "UPDATE locker_assigned_students SET state='반납완료', deposit='환불완료' WHERE per_id=?;", per_id);

        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "";
    }

    public LockerFileDTO getFile(int per_id) { //대상자 명단 1개 불러오기
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        ArrayList<LockerFileDTO> student = null;
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM locker_data WHERE per_id=?", new MapListHandler(),
                    per_id);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        student = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<LockerFileDTO>>() {
        }.getType());

        if (student.size() > 0) {

            return student.get(0);
        } else {

            return null;
        }
    }
    public LockerFileDTO getFile2(int per_id) { //대상자 명단 1개 불러오기
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        ArrayList<LockerFileDTO> student = null;
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM locker_data_front WHERE per_id=?", new MapListHandler(),
                    per_id);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        student = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<LockerFileDTO>>() {
        }.getType());

        if (student.size() > 0) {

            return student.get(0);
        } else {

            return null;
        }
    }


    public ArrayList<LockerManagerDTO> getlockers(int location) { //사물함 목록 불러오기. location은 사물함 번호를 의미함. 전체:location=0
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        ArrayList<LockerManagerDTO> student = null;
        try {
            QueryRunner queryRunner = new QueryRunner();
            if (location==0){
                listOfMaps = queryRunner.query(conn, "SELECT * FROM locker", new MapListHandler());
            }
            else{
                listOfMaps = queryRunner.query(conn, "SELECT * FROM locker WHERE locker_location=? order by locker_num asc", new MapListHandler(), location);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<LockerManagerDTO> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<LockerManagerDTO>>() {
        }.getType());
        //System.out.println("userDAO.getAIuser "+selected.size());
        if (selected.size() > 0) {
            return selected;
        } else
            return null;
    }
    public String deleteLocker(String data) { //사물함삭제
        Connection conn = Config.getInstance().sqlLogin();
        //System.out.println("userdao.deleteAIuser");
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn, "DELETE FROM locker WHERE locker_num=? ;", data);
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return data;
    }

    public String changeAvailable(String data) { //스케쥴 관련 DB (일정) 수정하기
        String arr[] = data.split("-/-/-");// 0=name 1=start 2=close
        String name = arr[0];
        Connection conn = Config.getInstance().sqlLogin();

        try {
            QueryRunner que = new QueryRunner();
            que.update(conn, "UPDATE locker SET available=? WHERE locker_num=?", arr[2], name);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return arr[2];
    }

    public String setAllLockerAvailableTrue() { //스케쥴 관련 DB (일정) 수정하기
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner que = new QueryRunner();
            que.update(conn, "UPDATE locker SET available='사용가능'");
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "";
    }

    public String deleteAllAssignedStudents() { //대상자 전체삭제
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner que = new QueryRunner();
            que.update(conn, "DELETE FROM locker_assigned_students");
            que.update(conn, "DELETE FROM locker_data");
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "";
    }


    public ArrayList<TextBean> getinfo() { //학생회 계좌정보
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        ArrayList<TextBean> student = null;
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM text WHERE text_id >=100 and text_id<103" , new MapListHandler());
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<TextBean> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<TextBean>>() {
        }.getType());
        //System.out.println("userDAO.getAIuser "+selected.size());
        if (selected.size() > 0) {
            return selected;
        } else
            return null;
    }

    public String modifyInfo(String data) { //학생회정보 수정
        String arr[] = data.split("-/-/-"); // 0: bank 1: account 2:contact
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner que = new QueryRunner();
            que.update(conn, "UPDATE text SET content=? WHERE text_id=100;", arr[0]);
            que.update(conn, "UPDATE text SET content=? WHERE text_id=101;", arr[1]);
            que.update(conn, "UPDATE text SET content=? WHERE text_id=102;", arr[2]);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }

        return "";
    }

    public void requestLog(String data) {
        String arr[] = data.split("-/-/-");//
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner query = new QueryRunner();
            query.update(conn, "INSERT locker_log SET student_id=?,student_name=?, date=?, state=?, method_name=?, request_query=?;",
                    arr[0], arr[1], arr[2],arr[3],arr[4],arr[5]);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
    }
}
