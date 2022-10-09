package kr.ac.kyonggi.cs.v2.handler.dao.graduation_checking_system;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.ac.kyonggi.cs.common.sql.Config;
import kr.ac.kyonggi.cs.handler.vo.MenuBean;
import kr.ac.kyonggi.cs.v2.handler.dto.graduation_checking_system.*;
import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.ColumnListHandler;
import org.apache.commons.dbutils.handlers.MapListHandler;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class GraduationCheckingSystemDAO {
    /**
     * 싱글톤
     * */
    public static GraduationCheckingSystemDAO it;
    public static GraduationCheckingSystemDAO getInstance() {
        if(it == null)
            it = new GraduationCheckingSystemDAO();
        return it;
    }
    /**
     * DAO 메소드 시작
     * */

    public ArrayList<MenuBean> getGcsPageMenu(String type_name){
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            if(type_name.equals("홈페이지관리자")){
                listOfMaps = queryRunner.query(conn, "SELECT * FROM `fdb_pages` where `tab_id` = 12 ORDER BY orderNum ASC;", new MapListHandler());
            }
            else if(type_name.equals("게스트")){
                listOfMaps = queryRunner.query(conn, "SELECT * FROM `fdb_pages` where `tab_id` = 12 and orderNum<2 ORDER BY orderNum ASC;", new MapListHandler());
            }
            else {
                listOfMaps = queryRunner.query(conn, "SELECT * FROM `fdb_pages` where `tab_id` = 12 and orderNum<3 ORDER BY orderNum ASC;", new MapListHandler());
            }
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<MenuBean> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<MenuBean>>() {}.getType());
        return selectedList;
    }


    public StudentDTO getOneStudent(String user_id) {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM `gcs_student` WHERE `per_id` = ? ;", new MapListHandler(), user_id);
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<StudentDTO> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<StudentDTO>>() {}.getType());
        if(selectedList.isEmpty())
            return null;
        return selectedList.get(0);
    }

    public ArrayList<StudentDTO> getAllStudent() {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM `gcs_student` ", new MapListHandler());
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<StudentDTO> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<StudentDTO>>() {}.getType());
//        for(StudentDTO st : selectedList){
//            System.out.println(st.name);
//        }
        return selectedList;
    }

//    public ArrayList<StudentDTO> getAllStudent(String type_name){
//        List<Map<String, Object>> listOfMaps = null;
//        Connection conn = Config.getInstance().sqlLogin();
//        try {
//            QueryRunner queryRunner = new QueryRunner();
//            listOfMaps = queryRunner.query(conn, "SELECT * FROM `gcs_student` ", new MapListHandler());
//        } catch (SQLException se) {
//            se.printStackTrace();
//        } finally {
//            DbUtils.closeQuietly(conn);
//        }
//        Gson gson = new Gson();
//        ArrayList<StudentDTO> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<StudentDTO>>() {}.getType());
////        System.out.println(selectedList);
//        return selectedList;
//    }
//
//    public ArrayList<BsmDTO> getBSM() {
//        List<Map<String, Object>> listOfMaps = null;
//        Connection conn = Config.getInstance().sqlLogin();
//        try {
//            QueryRunner queryRunner = new QueryRunner();
//            listOfMaps = queryRunner.query(conn, "SELECT * FROM `gcs_bsm` ", new MapListHandler());
//        } catch (SQLException se) {
//            se.printStackTrace();
//        } finally {
//            DbUtils.closeQuietly(conn);
//        }
//        Gson gson = new Gson();
//        ArrayList<BsmDTO> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<BsmDTO>>() {}.getType());
//        return selectedList;
//    }

//    public ArrayList<MscDTO> getMSC() {
//        List<Map<String, Object>> listOfMaps = null;
//        Connection conn = Config.getInstance().sqlLogin();
//        try {
//            QueryRunner queryRunner = new QueryRunner();
//            listOfMaps = queryRunner.query(conn, "SELECT * FROM `gcs_msc` ", new MapListHandler());
//        } catch (SQLException se) {
//            se.printStackTrace();
//        } finally {
//            DbUtils.closeQuietly(conn);
//        }
//        Gson gson = new Gson();
//        ArrayList<MscDTO> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<MscDTO>>() {}.getType());
//        return selectedList;
//    }

    public ArrayList<SpecialLectureDTO> getSpecialLecture(String major, String year) {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM `gcs_special_lecture` WHERE major=? AND year=?", new MapListHandler(), major, year);
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<SpecialLectureDTO> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<SpecialLectureDTO>>() {}.getType());
        return selectedList;
    }

    public ArrayList<LectureDTO> getLecture() {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM `gcs_lecture` ", new MapListHandler());
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<LectureDTO> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<LectureDTO>>() {}.getType());
        return selectedList;
    }

    public EngineeringRequirementDTO getOneEngineeringRequirement(String major, String year) {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM `gcs_engineering_requirement` WHERE major = ? AND year = ? ; ", new MapListHandler(), major, year);
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<EngineeringRequirementDTO> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<EngineeringRequirementDTO>>() {}.getType());
        if(selectedList.isEmpty())
            return null;
        return selectedList.get(0);
    }

    public ArrayList<GraduationRequirementDTO> getGraduationRequirement() {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM `gcs_graduation_requirement` ", new MapListHandler());
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<GraduationRequirementDTO> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GraduationRequirementDTO>>() {}.getType());
        return selectedList;
    }

    public GraduationRequirementDTO getOneGraduationRequirement(String major, String year) {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM `gcs_graduation_requirement` WHERE major=? AND year=? ;", new MapListHandler(), major, year);
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<GraduationRequirementDTO> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GraduationRequirementDTO>>() {}.getType());
        if(selectedList.isEmpty())
            return null;
        return selectedList.get(0);
    }


    public ArrayList<ExternalLectureDTO> getExternalLecture() {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM `gcs_external_lecture` ORDER BY year, semester", new MapListHandler());
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<ExternalLectureDTO> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<ExternalLectureDTO>>() {}.getType());
        return selectedList;
    }

    public String insertexcellecture(List<Map<String, Object>> xlsLectureReader) {
        Connection conn = Config.getInstance().sqlLogin();
        boolean die=false;
        int dieid =0;
        try {
            QueryRunner queryRunner = new QueryRunner();

            for(int i=0;i<xlsLectureReader.size();i++) {
                LectureDTO lecture=new LectureDTO();
                lecture.id=(String) xlsLectureReader.get(i).get("id");//id
                if(lecture.id==null)
                    lecture.id="-";

                lecture.year=(String) xlsLectureReader.get(i).get("year");//연도
                if(lecture.year==null)
                    lecture.year="-";

                lecture.semester=(String) xlsLectureReader.get(i).get("semester");//학기
                if(lecture.semester==null)
                    lecture.semester="-";

                lecture.grade=(String) xlsLectureReader.get(i).get("grade");//학년
                if(lecture.grade==null)
                    lecture.grade="-";

                List<String> idlist=queryRunner.query(conn,"SELECT id FROM gcs_lecture ",new ColumnListHandler<String>());

                for(int j=0;j<idlist.size();j++) {
                    if(lecture.id.equals(idlist.get(j))) {
                        die=true;
                        dieid++;
                        break;
                    }
                }
                if(die) {
                    die=false;
                    continue;
                }
                lecture.lecture_id=(String) xlsLectureReader.get(i).get("lecture_id");//학수코드
                if(lecture.lecture_id=="")
                    lecture.lecture_id="-";

                lecture.big_type=(String) xlsLectureReader.get(i).get("big_type");//대분류(교양//전공)
                if(lecture.big_type==null)
                    lecture.big_type="-";

                lecture.small_type=(String) xlsLectureReader.get(i).get("small_type");//소분류(이수구분)
                if(lecture.small_type==null)
                    lecture.small_type="-";//소분류(이수구분)

               lecture.major=(String) xlsLectureReader.get(i).get("major");//전공
                if(lecture.major==null)
                    lecture.major="-";

                lecture.credit=(String) xlsLectureReader.get(i).get("credit");//학점
                if(lecture.credit==null)
                    lecture.credit="-";

                lecture.design_credit=(String) xlsLectureReader.get(i).get("design_credit");//설계점수
                if(lecture.design_credit==null)
                    lecture.design_credit="-";

                lecture.name=(String) xlsLectureReader.get(i).get("name");//과목명
                if(lecture.name==null)
                    lecture.name="-";

//                lecture.selective_essential=(String) xlsLectureReader.get(i).get("selective_essential");//선필여부
//                if(lecture.selective_essential==null)
//                    lecture.selective_essential="-";

//                List<String> namelist=queryRunner.query(conn,"SELECT name FROM user ",new ColumnListHandler<String>());
//                List<String> birthlist=queryRunner.query(conn,"SELECT birth FROM user ",new ColumnListHandler<String>());
//                for(int k=0;k<namelist.size();k++) {
//                    if(lecture.name.equals(namelist.get(k))&&lecture.birth.equals(birthlist.get(k))) {
//                        queryRunner.update(conn,"UPDATE user SET major=?,per_id=?,type=?,state=? WHERE name=? and birth=?",namelist.get(k),birthlist.get(k));//전공,학번,타입,재적상태
//                        die=true;
//                        break;
//                    }
//                }
                if(die) {
                    die=false;
                }
//                String[] p =user.birth.split("-");
//                String password=p[0].substring(2, 4)+p[1]+p[2];//yymmdd
//                String toSha = user.id + password;
//                user.password=SHA256(toSha);
//                Date date=new Date();
                queryRunner.update(conn,"REPLACE INTO gcs_lecture(id,year,semester,grade,lecture_id,big_type,small_type,major,credit,design_credit,name) VALUE(?,?,?,?,?,?,?,?,?,?,?)",lecture.id,lecture.year,lecture.semester,lecture.grade,lecture.lecture_id,lecture.big_type,lecture.small_type,lecture.major,lecture.credit,lecture.design_credit,lecture.name);//id 중복될경우
            }
        }catch(SQLException se) {
            se.printStackTrace();
        }finally {
            DbUtils.closeQuietly(conn);
        }

        return Integer.toString(xlsLectureReader.size()-dieid);
    }

    public String deleteLecture(String data) {
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"DELETE FROM gcs_lecture WHERE id=? ;",data);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return data;

    }
    public String addLecture(String data) {
        String arr[] = data.split("-/-/-");
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT COUNT(*) FROM `gcs_lecture` ", new MapListHandler());
            System.out.print(listOfMaps);
            queryRunner.update(conn,"INSERT INTO gcs_lecture(year,semester,grade,lecture_id,big_type,small_type,major,credit,design_credit,name) VALUE(?,?,?,?,?,?,?,?,?,?);", arr[0],arr[1],arr[2],arr[3],arr[4],arr[5],arr[6],arr[7],arr[8],arr[9]);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public String modifyLecture(String data) {
        String arr[] = data.split("-/-/-");
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"UPDATE gcs_lecture SET year=?,semester=?,grade=?,lecture_id=?,big_type=?,small_type=?,major=?,credit=?,design_credit=?,name=? WHERE id=?;",arr[1],arr[2],arr[3],arr[4],arr[5],arr[6],arr[7],arr[8],arr[9],arr[10],arr[0]);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";

    }

    public ArrayList<LectureDTO> getAllYear() {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM gcs_lecture group by year;", new MapListHandler());
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<LectureDTO> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<LectureDTO>>() {}.getType());
        return selectedList;
    }

    public String addExternalLecture(String data) {
        String arr[] = data.split("-/-/-"); //per_id add_year add_semester add_name add_credit add_big_type history
        String history[] = arr[6].split("-/@/-");
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"INSERT INTO gcs_external_lecture(per_id,year,semester,name,credit,big_type) VALUE(?,?,?,?,?,?);", arr[0],arr[1],arr[2],arr[3],arr[4],arr[5]);
            if(history[0].equals(arr[3])){  //해당 학년, 학기에 추가된 첫 외부 강의 따라서 새 로우 추가
                queryRunner.update(conn,"INSERT INTO gcs_external_lecture_history(per_id,year,semester,history) VALUE(?,?,?,?);", arr[0],arr[1],arr[2],arr[6]);
            }
            else {
                queryRunner.update(conn, "UPDATE gcs_external_lecture_history SET history=? WHERE per_id=? AND year=? AND semester=?;", arr[6], arr[0], arr[1], arr[2]);
            }
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

//    public String modifyExternalLecture(String data) {
//        String arr[] = data.split("-/-/-"); //per_id add_year add_semester add_grade add_name history credit big_type
//        Connection conn = Config.getInstance().sqlLogin();
//        try {
//            QueryRunner queryRunner = new QueryRunner();
//            //우선 기존 이수 기록에서 삭제
//            queryRunner.update(conn,"DELETE FROM gcs_external_lecture WHERE per_id=? AND year=? AND semester=? AND grade=? AND name=?;",arr[0],arr[1],arr[2],arr[3],arr[4]);
//            queryRunner.update(conn,"UPDATE gcs_external_lecture_history SET history=? WHERE per_id=? AND year=? AND semester=? AND grade=?;",arr[5],arr[0],arr[1],arr[2],arr[3]);
//        } catch(SQLException se) {
//            se.printStackTrace();
//        } finally {
//            DbUtils.closeQuietly(conn);
//        }
//        return "success";
//    }

    public String deleteExternalLecture(String data) {
        String arr[] = data.split("-/-/-"); //per_id add_year add_semester add_name history
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"DELETE FROM gcs_external_lecture WHERE per_id=? AND year=? AND semester=? AND name=?;",arr[0],arr[1],arr[2],arr[3]);
            if(arr[4].equals("empty"))
                queryRunner.update(conn,"DELETE FROM gcs_external_lecture_history WHERE per_id=? AND year=? AND semester=?;",arr[0],arr[1],arr[2]);
            else
                queryRunner.update(conn,"UPDATE gcs_external_lecture_history SET history=? WHERE per_id=? AND year=? AND semester=?;",arr[5],arr[0],arr[1],arr[2]);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public String addLectureHistory(String data) {
        String arr[] = data.split("-/-/-"); //student_id-/-/-연도-/-/-학기-/-/-학수코드1-/@/-학수코드2-/@/-...
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM `gcs_lecture_history` WHERE per_id=? AND year=? AND semester=?", new MapListHandler(), arr[0], arr[1], arr[2]);
            if(listOfMaps.isEmpty())
                queryRunner.update(conn,"INSERT INTO gcs_lecture_history(per_id,year,semester,history) VALUE(?,?,?,?);", arr[0],arr[1],arr[2],arr[3]);
            else if(arr[3].isEmpty())
                queryRunner.update(conn,"DELETE FROM gcs_lecture_history WHERE per_id=? AND year=? AND semester=?;", arr[0], arr[1], arr[2]);
            else
                queryRunner.update(conn,"UPDATE gcs_lecture_history SET history=? WHERE per_id=? AND year=? AND semester=?", arr[3],arr[0],arr[1],arr[2]);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public String addGcsStudent(String data) {
        String arr[] = data.split("-/-/-"); //per_id name phone major grade enter_year
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"INSERT INTO gcs_student(per_id,name,phone,major,grade,enter_year) VALUE(?,?,?,?,?,?);", arr[0],arr[1],arr[2],arr[3],arr[4],arr[5]);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public String modifyGcsStudent(String data) {
        String arr[] = data.split("-/-/-"); //per_id name phone major grade enter_year
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"UPDATE gcs_student SET name=?,phone=?,major=?,grade=?,enter_year=? WHERE per_id=?;",arr[1],arr[2],arr[3],arr[4],arr[5],arr[0]);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public ArrayList<LectureHistoryDTO> getLectureHistory(String user_id) {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM `gcs_lecture_history` WHERE per_id=?", new MapListHandler(), user_id);
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<LectureHistoryDTO> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<LectureHistoryDTO>>() {}.getType());
        return selectedList;
    }

    public ArrayList<ExternalLectureHistoryDTO> getExternalLectureHistory(String user_id) {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM `gcs_external_lecture_history` WHERE per_id=?", new MapListHandler(), user_id);
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<ExternalLectureHistoryDTO> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<ExternalLectureHistoryDTO>>() {}.getType());
        return selectedList;
    }
    public String deleteGraduationRequirement(String data) {
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"DELETE FROM gcs_graduation_requirement WHERE id=? ;",data);
            queryRunner.update(conn,"DELETE FROM gcs_engineering_requirement WHERE id=? ;",data);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }
    public String insertGraduationRequirement(String data) {
        String arr[] = data.split("-/-/-");
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn, "INSERT INTO gcs_graduation_requirement(year,major,all_credit,major_credit,major_essential,major_selective,elective_credit,jin_seong_ae_credit,msc_credit,major_lecture) VALUE(?,?,?,?,?,?,?,?,?,'');", arr[0], arr[1], arr[2], arr[3], arr[4], arr[5], arr[6], arr[7], arr[8]);
            queryRunner.update(conn, "INSERT INTO gcs_engineering_requirement(year,bsm_credit,elective_credit,design_credit,major_credit,lecture_order,major) VALUE(?,?,?,?,?,'',?);", arr[0], arr[9], arr[10], arr[11], arr[12], arr[1]);

        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }
    public String modifyGraduationRequirement(String data){
//        all_credit +'-/-/-'+major_credit+'-/-/-'+elective_credit+'-/-/-'+major_essential +'-/-/-'+major_selective+'-/-/-'+jin_seong_ae_credit+'-/-/-'+ msc_credit ;
        String arr[] = data.split("-/-/-");
        String major = arr[0];
        String year = arr[1];
        String all_credit = arr[2];
        String major_credit = arr[3];
        String elective_credit = arr[4];
        String major_essential = arr[5];
        String major_selective = arr[6];
        String jin_seong_ae_credit = arr[7];
        String msc_credit = arr[8];

        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,
                    "UPDATE gcs_graduation_requirement SET all_credit=?,major_credit=?,elective_credit=?,major_essential=?,major_selective=?,jin_seong_ae_credit=?,msc_credit=? WHERE major=? AND year=?;",
                    all_credit, major_credit, elective_credit, major_essential, major_selective, jin_seong_ae_credit, msc_credit, major, year);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "";
    }
    public String modifyEngineeringRequirement(String data) {
        //        all_credit +'-/-/-'+major_credit+'-/-/-'+elective_credit+'-/-/-'+major_essential +'-/-/-'+major_selective+'-/-/-'+jin_seong_ae_credit+'-/-/-'+ msc_credit ;
        String arr[] = data.split("-/-/-");
        String major = arr[0];
        String year = arr[1];
        String bsm_credit = arr[2];
        String elective_credit = arr[3];
        String design_credit = arr[4];
        String major_credit = arr[5];

        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,
                    "UPDATE gcs_engineering_requirement SET bsm_credit=?, elective_credit=?, design_credit=?, major_credit=? WHERE major=? AND year=?;",
                    bsm_credit,elective_credit,design_credit,major_credit, major, year);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "";
    }

    public String deleteTakenLecture(String data) {
        String arr[] = data.split("-/-/-"); //user.id + '-/-/-' + selectedYear + '-/-/-' + selectedSemester
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"DELETE FROM gcs_lecture_history WHERE per_id=? AND year=? AND semester=?;",arr[0],arr[1],arr[2]);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public String modifyElectiveLectures(String data) {
        String arr[] = data.split("-/-/-");
        String major = arr[0];
        String year = arr[1];
        String lectures = arr[2];
        if(lectures.equals("#")){
            lectures="";
        }
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,
                    "UPDATE gcs_engineering_requirement SET elective_lectures=? WHERE major=? AND year=?;",
                    lectures, major, year);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "";
    }

    public String modifyLectureOrder(String data) {
        String arr[] = data.split("-/-/-");
        String major = arr[0];
        String year = arr[1];
        String lectures = arr[2];
        if(lectures.equals("#")){
            lectures="";
        }
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,
                    "UPDATE gcs_engineering_requirement SET lecture_order=? WHERE major=? AND year=?;",
                    lectures, major, year);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "";
    }
    public String deleteStudentData(String data) {
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"DELETE FROM gcs_student WHERE per_id=?;",data);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }


    public ArrayList<LectureDTO> getLectureByCode() {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM `gcs_lecture` GROUP BY `lecture_id` ORDER BY `name`", new MapListHandler());
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<LectureDTO> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<LectureDTO>>() {}.getType());
        return selectedList;
    }

    public String addSpecialLecture(String data) {
        String arr[] = data.split("-/-/-"); //연도-/-/-전공-/-/-타입-/-/-학수코드1-/@/-학수코드2-/@/-...
        List<Map<String, Object>> listOfMaps = null;
        String lectures[] = arr[3].split("-/@/-");
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"DELETE FROM gcs_special_lecture WHERE year=? AND major=? AND type=?;", arr[0],arr[1],arr[2]);
            for(int i=0;i<lectures.length;i++){
                queryRunner.update(conn,"INSERT INTO gcs_special_lecture(year,major,type,lecture_id) VALUE(?,?,?,?);", arr[0],arr[1],arr[2],lectures[i]);
            }
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public String deleteAllLecture() {
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"DELETE FROM gcs_lecture;");
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public ArrayList<SimilarSubjectDTO> getSimilarSub() {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM `gcs_similar_subject` ", new MapListHandler());
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<SimilarSubjectDTO> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<SimilarSubjectDTO>>() {}.getType());
        return selectedList;
    }

    public String insertSimilarSub(String data) {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"INSERT INTO gcs_similar_subject(lectures) VALUE(?);", data);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public ArrayList<TrackRequirementDTO> getTrackRequirement(String major, String year) {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM `gcs_track_requirement` WHERE major =? AND year=?", new MapListHandler(), major, year);
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<TrackRequirementDTO> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<TrackRequirementDTO>>() {}.getType());
        return selectedList;
    }


    public String ModifySimilarSub(String data) {
        String arr[] = data.split("-/-/-"); // oid lectures[]
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            if(arr[1].equals("empty"))
                queryRunner.update(conn, "DELETE FROM gcs_similar_subject WHERE oid=?;", arr[0]);
            queryRunner.update(conn, "UPDATE gcs_similar_subject SET lectures=? WHERE oid=?;", arr[1], arr[0]);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public String addTrackRequirement(String data) {
        String arr[] = data.split("-/-/-"); //연도-/-/-전공-/-/-코드-/-/-차트ID-/-/-이름-/-/-학점
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"INSERT INTO gcs_track_requirement(year,major,code,chart_id,name,credit) VALUE(?,?,?,?,?,?);", arr[0],arr[1],arr[2],arr[3],arr[4],arr[5]);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public String deleteTrackRequirement(String data) {
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"DELETE FROM gcs_track_requirement WHERE oid=?;",data);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public ArrayList<ExternalLectureDTO> getUserExternalLecture(String user_id) {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM `gcs_external_lecture` WHERE per_id = ? ORDER BY year, semester", new MapListHandler(), user_id);
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<ExternalLectureDTO> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<ExternalLectureDTO>>() {}.getType());
        return selectedList;
    }
}
