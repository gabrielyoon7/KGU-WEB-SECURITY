package kr.ac.kyonggi.cs.handler.dao.track;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
//import jdk.nashorn.internal.parser.TokenType;
import kr.ac.kyonggi.cs.common.sql.Config;
import kr.ac.kyonggi.cs.handler.dto.grdBack.BackStudentDTO;
import kr.ac.kyonggi.cs.handler.dto.track.TrackSubjectDto;
import kr.ac.kyonggi.cs.handler.dto.track.TrackUserDto;
import kr.ac.kyonggi.cs.handler.dto.track.TrackUserSubjectDto;
import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.ArrayHandler;
import org.apache.commons.dbutils.handlers.MapHandler;
import org.apache.commons.dbutils.handlers.MapListHandler;

import javax.management.Query;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.*;

public class TrackDao {
    public static TrackDao trackDao;

    /*
    * 이부분은 객체를 싱글톤범위로 생성하게 하는 부분입니다.
    * 객체 생성을 직접 new TrackDao() 이렇게 하는게 아니라
    * TrackDao trackDao = TrackDao.getInstance();
    * 이렇게 하시면 됩니다
    * */
    private TrackDao(){}
    public static TrackDao getInstance(){
        if(trackDao==null){
            trackDao = new TrackDao();
        }
        return trackDao;
    }

    public String enrollNewUser(String msg){
        String[] m = msg.split("/"); // 이름 학번 트랙여부(yes, no) 아이디
        Connection conn = Config.getInstance().sqlLogin();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        int num = 0;
        if(m[2].equals("yes")){
            num = 1;
        }

        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,String.format("INSERT INTO track_user(id,per_id,name,track_ex,log_date,adm_year) VALUES('%s','%s','%s',%d,'%s',%d)",
                    m[3],m[1],m[0],num,sdf.format(new Date()),Integer.parseInt(m[1]) / 100000));

        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "";
    }


//    User ID를 통해 User정보 반환
    public TrackUserDto getTrackUserByID(String id){
//        System.out.println("User new method");
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        ArrayList<TrackUserDto> user = null;
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM track_user WHERE id = ?", new MapListHandler(), id);
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        user = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<TrackUserDto>>() {}.getType());
        if (user.size() > 0)
            return user.get(0);
        else
            return null;
    }
    //교육과정연도, 학년, 학기정보로 과목배열 생성하여 반환
    public ArrayList<TrackSubjectDto> getTrackSubjectByYear(int year, int grade, int sem){
//        System.out.println("Subject new method");
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        ArrayList<TrackSubjectDto> subjectList = null;

        String query = "SELECT * FROM track_subject WHERE (found_year <= " + year + ") AND (sub_grade = " + grade
                + ") AND (sub_semester = " + sem + ") AND (repeal_year > " + year + " OR repeal_year IS NULL)";
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, query, new MapListHandler());
        } catch (Exception e){
            e.printStackTrace();
        }
        finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        subjectList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<TrackSubjectDto>>() {}.getType());
        subjectList.sort(new Comparator<TrackSubjectDto>() {
            @Override
            public int compare(TrackSubjectDto o1, TrackSubjectDto o2) {
                if (o1.getSub_class_ex().compareTo(o2.getSub_class_ex()) == -1)
                    return -1;
                else if (o1.getSub_class_ex().equals(o2.getSub_class_ex()))
                    return o1.getSub_title().compareTo(o2.getSub_title());
                else
                    return 1;
            }
        });
        if (subjectList.size() > 0)
            return subjectList;
        else
            return null;
    }
    //enroll_popup에서 저장버튼 누르면 실행되는 함수
    //track_user에 새로 수정된 User의 이수 학기정보 업데이트
    //track_user_subject에 기존 정보 삭제, 새로 신청한 과목 저장
//    var answer = clicked_subject + ":" + selected_year+""+selected_sem + "-" + global_grade + "" + global_sem + "-" + comp_sem;
//    Answer: 6,77,81:20152-12-2
    public String insert_request(String uid, String data) {
        String[] subjectArr = data.substring(0, data.indexOf(':')).split(",");
        String year = data.substring(data.indexOf(":") + 1, data.indexOf(":") + 5);
        String sem = data.substring(data.indexOf(":") + 5, data.indexOf(":") + 6);
        String grade_sem = data.substring(data.indexOf("-") + 1, data.indexOf("-") + 3);
        String comp_sem = data.substring(data.lastIndexOf("-") + 1, data.lastIndexOf("-") + 2);

        int dateVal = Integer.parseInt(year)*2 + Integer.parseInt(sem);
        int grade_semVal = Integer.parseInt(grade_sem);
        int grade_semVal_bef, grade_semVal_aft;
        if (grade_semVal % 10 == 1) {
            if (grade_semVal <= 11) {
                grade_semVal_bef = 0;
                grade_semVal_aft = grade_semVal + 1;
            } else {
                grade_semVal_bef = grade_semVal - 10 + 1;
                grade_semVal_aft = grade_semVal + 1;
            }
        }
        else {
            if (grade_semVal >= 52) {
                grade_semVal_bef = grade_semVal - 1;
                grade_semVal_aft = 0;
            } else {
                grade_semVal_bef = grade_semVal - 1;
                grade_semVal_aft = grade_semVal + 10 - 1;
            }
        }
        String grade_semVal_bef_tmp = getYearAndSemByGradeSem(uid, Integer.toString(grade_semVal_bef));
        String grade_semVal_aft_tmp = getYearAndSemByGradeSem(uid, Integer.toString(grade_semVal_aft));
        if (grade_semVal_bef_tmp != null) {
            int dateVal_tmp = Integer.parseInt(grade_semVal_bef_tmp.substring(0, 4))*2 + Integer.parseInt(grade_semVal_bef_tmp.substring(4, 5));
            if (dateVal <= dateVal_tmp) {
                return "fail_date_low-" + grade_semVal_bef_tmp;
            }
        }
        if (grade_semVal_aft_tmp != null) {
            int dateVal_tmp = Integer.parseInt(grade_semVal_aft_tmp.substring(0, 4))*2 + Integer.parseInt(grade_semVal_aft_tmp.substring(4, 5));
            if (dateVal >= dateVal_tmp) {
                return "fail_date_high-" + grade_semVal_aft_tmp;
            }
        }

        String id = uid;
        SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd");
        Date now = new Date();
        String now_date = format1.format(now);

        List<Map<String, Object>> listOfMaps = null;
        ArrayList<TrackUserSubjectDto> user_subjectList = null;
        String dupl_list = "";
        Connection conn = Config.getInstance().sqlLogin();

        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM track_user_subject WHERE (id=?) AND (grade_sem != ?);", new MapListHandler(), uid, grade_sem);
        } catch(Exception e) {

        }
//        finally {
//            DbUtils.closeQuietly(conn);
//        }
        Gson gson = new Gson();
        user_subjectList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<TrackUserSubjectDto>>() {}.getType());
//        System.out.println("user_subjectList: " + user_subjectList);
//        System.out.print("subjectArr: ");
//        for (int i=0; i<subjectArr.length; ++i) {
//            System.out.print(subjectArr[i] + " ");
//        }
        for (int i=0; i<user_subjectList.size(); ++i) {
            for (int j=0; j<subjectArr.length; ++j) {
//                System.out.println(user_subjectList.get(i).getSub_id() + "-" + subjectArr[j]);
                if (user_subjectList.get(i).getSub_id().equals(subjectArr[j])) {
                    dupl_list += "-" + (subjectArr[j]);
                }
            }
        }
        if (dupl_list.length() > 1)
            return "fail_dupl" + dupl_list;
//        System.out.println("\n" + dupl_list);
//        System.out.println("[SubjectArr]");
//        for (int i=0; i<subjectArr.length; ++i)
//            System.out.print(subjectArr[i] + " ");
//        System.out.println("\n[User_subjectList]");
//        for (int i=0; i<user_subjectList.size(); ++i)
//            System.out.print(user_subjectList.get(i).getSub_id() + " ");
//        System.out.println("\n[Dupl_list]");
//        System.out.println(dupl_list);

        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn, "DELETE FROM track_user_subject WHERE (id=?) AND (grade_sem=?)", uid, grade_sem);
            if (subjectArr.length == 1 && subjectArr[0].equals("")) {
                return "";
            }
            for (int i=0; i<subjectArr.length; ++i) {
                queryRunner.update(conn, "INSERT track_user_subject SET id=?,sub_id=?,year=?,sem=?,grade_sem=?", id, subjectArr[i], year, sem, grade_sem);
            }
            queryRunner.update(conn, "UPDATE track_user SET comp_sem=? WHERE id=" + uid, comp_sem);
            queryRunner.update(conn, String.format("UPDATE track_user SET log_date='%s' WHERE id='%s'",now_date,uid));
            queryRunner.update(conn, "UPDATE track_user SET last_modi_year=? WHERE id=" + uid, year);
        } catch(Exception e) {
            delete_sem(uid, grade_sem);
//            e.printStackTrace();
//            System.out.println("Duplicate Entry => ERROR!!!");
//            return "fail_dupl" + dupl_list;
            return "fail_unknown";
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "";
    }
    public String delete_sem(String uid, String grade_sem) {
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn, "DELETE FROM track_user_subject WHERE (id=?) AND (grade_sem=?)", uid, grade_sem);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "";
    }
    public String addUserCompSem(String uid, String data) {
        Connection conn = Config.getInstance().sqlLogin();

        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn, "UPDATE track_user SET comp_sem=? WHERE id=?", data, uid);
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "";
    }
    //유저의 마지막 학기 테이블 데이터 제거
    public String delete_last_sem(String uid, String data) {
        String new_comp_sem = data.substring(0, 1);
        String grade_sem = data.substring(data.indexOf("-") + 1, data.indexOf("-") + 3);
//        System.out.println("Delete Semester Table: " + new_comp_sem + ", " + grade_sem);
        Connection conn = Config.getInstance().sqlLogin();

        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn, "UPDATE track_user SET comp_sem=? WHERE id=" + uid, new_comp_sem);
            queryRunner.update(conn, "DELETE FROM track_user_subject WHERE (id=?) AND (grade_sem=?)", uid, grade_sem);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "";
    }

    //추가 200119
    //유저의 모든데이터 제거
    public String delete_all_sem(String uid, String data) {
        String new_comp_sem = data.substring(0, 1);  //설정한 이수학기를 변수 저장
        String grade_sem = data.substring(data.indexOf("-") + 1, data.indexOf("-") + 3); //필요없음 안쓸것임.
        Connection conn = Config.getInstance().sqlLogin();

        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn, "UPDATE track_user SET comp_sem=? WHERE id=" + uid, new_comp_sem);  //트랙 유저 테이블 이수학기변경
            queryRunner.update(conn, "DELETE FROM track_user_subject WHERE (id=?)", uid); // 해당 테이블 내에 내 학번이면 다 지움
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "";
    }
    //추가끝

    //User ID, 학년 학기 정보로 track_user_subject에서 정보를 가져온후 track_subject에서 매칭시켜 과목정보 리턴
    public ArrayList<TrackSubjectDto> getUserSubjectByIDAndGradeSem(String uid, String grade_sem) {
        List<Map<String, Object>> listOfMaps = new ArrayList<>();
        List<Map<String, Object>> subIDList = null;
//        Object[] subIDList = null;
        Connection conn = Config.getInstance().sqlLogin();
        ArrayList<TrackSubjectDto> user_subjectList = null;

        try {
            QueryRunner queryRunner = new QueryRunner();
//            subIDList = queryRunner.query(conn, "SELECT sub_id FROM track_user_subject WHERE grade_sem=?", new ArrayHandler(), grade_sem);
            subIDList = queryRunner.query(conn, "SELECT sub_id FROM track_user_subject WHERE (id=?) AND (grade_sem=?)", new MapListHandler(), uid, grade_sem);

            if (subIDList == null)
                return null;
            for (int i=0; i<subIDList.size(); ++i) {
                Map<String, Object> mapTmp = new HashMap<>();
                mapTmp = queryRunner.query(conn, "SELECT * FROM track_subject WHERE id=?", new MapHandler(), Integer.valueOf((String)subIDList.get(i).get("sub_id")));
                listOfMaps.add(mapTmp);
//                listOfMaps.add(queryRunner.query(conn, "SELECT * FROM track_subject WHERE id=?", new MapHandler(), Integer.valueOf((String)subIDList[i])));
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        user_subjectList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<TrackSubjectDto>>() {}.getType());
        user_subjectList.sort(new Comparator<TrackSubjectDto>() {
            @Override
            public int compare(TrackSubjectDto o1, TrackSubjectDto o2) {
                if (o1.getSub_class_ex().compareTo(o2.getSub_class_ex()) == -1)
                    return -1;
                else if (o1.getSub_class_ex().equals(o2.getSub_class_ex()))
                    return o1.getSub_title().compareTo(o2.getSub_title());
                else
                    return 1;
            }
        });
        if (user_subjectList.size() > 0)
            return user_subjectList;
        else
            return null;
    }
    public String getYearAndSemByGradeSem(String uid, String grade_sem) {
        Connection conn = Config.getInstance().sqlLogin();
        List<Map<String, Object>> listOfMaps = null;
        ArrayList<TrackUserSubjectDto> yearList = null;
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM track_user_subject WHERE (id=?) AND (grade_sem=?)", new MapListHandler(), uid, grade_sem);
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        yearList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<TrackUserSubjectDto>>() {}.getType());
        if (yearList.size() == 0)
            return null;
        String tmp = yearList.get(0).getYear() + "" +  yearList.get(0).getSem();
        for (int i=0; i<yearList.size(); ++i) {
            if ( !(yearList.get(i).getYear()+""+yearList.get(i).getSem()).equals(tmp) )
                return null;
        }
        return tmp;
    }
    //모든 수리와과학 과목 정보 가져옴
    public ArrayList<TrackSubjectDto> getMathScienceSubject() {
        List<Map<String, Object>> listOfMaps = new ArrayList<>();
        Connection conn = Config.getInstance().sqlLogin();
        ArrayList<TrackSubjectDto> math_science_subjectList = null;

        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM track_subject WHERE sub_class_ex=?", new MapListHandler(), "수과");
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        math_science_subjectList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<TrackSubjectDto>>() {}.getType());
        return math_science_subjectList;
    }
    //특정 User가 신청한 수리와과학 과목 정보 가져옴
    public ArrayList<TrackSubjectDto> getMathScienceSubjectByUserID(String uid) {
        List<Map<String, Object>> user_subject_list = null;
        List<Map<String, Object>> listOfMaps = new ArrayList<>();
        Connection conn = Config.getInstance().sqlLogin();
        ArrayList<TrackSubjectDto> math_science_subjectList = null;

        try {
            QueryRunner queryRunner = new QueryRunner();
            user_subject_list = queryRunner.query(conn, "SELECT sub_id FROM track_user_subject WHERE id=?", new MapListHandler(), uid);
            if (user_subject_list == null)
                return null;
            for (int i=0; i<user_subject_list.size(); ++i) {
                Map<String, Object> mapTmp = new HashMap<>();
                mapTmp = queryRunner.query(conn, "SELECT * FROM track_subject WHERE (sub_class_ex=?) AND (id=?)", new MapHandler(), "수과", Integer.valueOf((String)user_subject_list.get(i).get("sub_id")));
                listOfMaps.add(mapTmp);
//                listOfMaps.add(queryRunner.query(conn, "SELECT * FROM track_subject WHERE id=?", new MapHandler(), Integer.valueOf((String)subIDList[i])));
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        math_science_subjectList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<TrackSubjectDto>>() {}.getType());
        return math_science_subjectList;
    }

    //User가 선택한 모든 과목 정보 가져옴
    public ArrayList<TrackSubjectDto> getTotalSubject(String uid) {
        List<Map<String, Object>> listOfMapsTmp = null;
        Connection conn = Config.getInstance().sqlLogin();

        List<Map<String, Object>> listOfMaps = new ArrayList<>();
        ArrayList<TrackSubjectDto> total_subjectList = null;

        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMapsTmp = queryRunner.query(conn, "SELECT sub_id FROM track_user_subject WHERE id=?", new MapListHandler(), uid);
            if (listOfMapsTmp == null)
                return null;
            for (int i=0; i<listOfMapsTmp.size(); ++i) {
                Map<String, Object> mapTmp = new HashMap<>();
                mapTmp = queryRunner.query(conn, "SELECT * FROM track_subject WHERE id=?", new MapHandler(), Integer.valueOf((String)listOfMapsTmp.get(i).get("sub_id")));
                if (mapTmp != null) {
                    listOfMaps.add(mapTmp);
                }
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        total_subjectList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<TrackSubjectDto>>(){}.getType());
        total_subjectList.sort(new Comparator<TrackSubjectDto>() {
            @Override
            public int compare(TrackSubjectDto o1, TrackSubjectDto o2) {
                if (o1.getSub_class_ex().compareTo(o2.getSub_class_ex()) == -1)
                    return -1;
                else if (o1.getSub_class_ex().equals(o2.getSub_class_ex()))
                    return o1.getSub_title().compareTo(o2.getSub_title());
                else
                    return 1;
            }
        });
        return total_subjectList;
    }
}
