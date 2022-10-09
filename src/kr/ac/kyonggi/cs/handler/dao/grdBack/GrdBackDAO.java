package kr.ac.kyonggi.cs.handler.dao.grdBack;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.ac.kyonggi.cs.common.sql.Config;
import kr.ac.kyonggi.cs.handler.dto.grdBack.*;
import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

public class GrdBackDAO {
    public static GrdBackDAO grdBackDAO = null;

    public static GrdBackDAO getInstance(){
        if(grdBackDAO == null){
            grdBackDAO = new GrdBackDAO();
        }
        return grdBackDAO;
    }

    //userlist 리턴(현재 연도의 직전 연도) 메소드
    public ArrayList<BackStudentDTO> getAllRecentStudent(){
        ArrayList<BackStudentDTO> result = new ArrayList<>();
        Connection conn = Config.getInstance().sqlLogin();
        Gson gson = new Gson();
        Statement stmt = null;
        ResultSet rs = null;

        int currentYear = Calendar.getInstance().get(Calendar.YEAR);
        String query = "SELECT * FROM back_students WHERE graduation_date = \'" +
                Integer.toString(currentYear - 1) + "-02\' OR graduation_date = \'" +
                Integer.toString(currentYear - 1) + "-08\'";

        try {
            stmt = conn.createStatement();
            rs = stmt.executeQuery(query);

            while(rs.next()){
                int per_id = rs.getInt("per_id");
                String name = rs.getString("name");
                String prof_name = rs.getString("prof_name");
                String graduation_date = rs.getString("graduation_date");
                String major = rs.getString("major");
                String graduation_type = null;
                Date final_action_date = rs.getDate("final_action_date");
                String grdType = null;

                if(rs.getString("graduation_type").equals("기타자격(자격증)"))
                    graduation_type = "자격증";

                else if(rs.getString("graduation_type").equals("기타자격(학술대회)"))
                    graduation_type = "학술대회";

                else if(rs.getString("graduation_type").equals("기타자격(공모전)"))
                    graduation_type = "공모전";

                else if(rs.getString("graduation_type").equals("최종보고서"))
                    graduation_type = "졸업논문";

                if(rs.getString("graduation_type").equals("기타자격(자격증)"))
                    grdType = "certificate";

                else if(rs.getString("graduation_type").equals("기타자격(학술대회)"))
                    grdType = "conference";

                else if(rs.getString("graduation_type").equals("기타자격(공모전)"))
                    grdType = "contest";

                else if(rs.getString("graduation_type").equals("최종보고서"))
                    grdType = "thesis";


                BackStudentDTO backStudentDTO = new BackStudentDTO();
                backStudentDTO.setPer_id(per_id);
                backStudentDTO.setName(name);
                backStudentDTO.setProf_name(prof_name);
                backStudentDTO.setGraduation_date(graduation_date);
                backStudentDTO.setMajor(major);
                backStudentDTO.setGraduation_type(graduation_type);
                backStudentDTO.setFinal_action_date(final_action_date);
                backStudentDTO.setGrdType(grdType);

                result.add(backStudentDTO);
            }

            rs.close();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            DbUtils.closeQuietly(conn);
        }

        return result;
    }

    //졸업 담당 교수 리스트 리턴 메소드
    public ArrayList<String> getAllProf(){
        ArrayList<String> result = new ArrayList<>();
        Connection conn = Config.getInstance().sqlLogin();
        Statement stmt = null;
        ResultSet rs = null;
        String query = "SELECT DISTINCT prof_name FROM back_students;";

        try {
            stmt = conn.createStatement();
            rs = stmt.executeQuery(query);

            result.add("전체 선택");

            while(rs.next()){
                result.add(rs.getString("prof_name"));
            }

            rs.close();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            DbUtils.closeQuietly(conn);
        }

        return result;
    }

    //졸업 연도 리스트 리턴 메소드
    public ArrayList<String> getAllSemester(){
        ArrayList<String> result = new ArrayList<>();
        Connection conn = Config.getInstance().sqlLogin();
        Statement stmt = null;
        ResultSet rs = null;
        String query = "SELECT DISTINCT graduation_date FROM back_students;";

        result.add("전체 선택");

        try {
            stmt = conn.createStatement();
            rs = stmt.executeQuery(query);

            while(rs.next()){
                result.add(rs.getString(1));
            }

            rs.close();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            DbUtils.closeQuietly(conn);
        }

        return result;
    }

    //입학 연도 리스트 리턴 메소드
    public ArrayList<String> getAllAdmission(){
        ArrayList<String> result = new ArrayList<>();
        Connection conn = Config.getInstance().sqlLogin();
        Statement stmt = null;
        ResultSet rs = null;
        String query = "SELECT DISTINCT SUBSTRING(per_id, 1, 4) FROM back_students;";

        result.add("전체 선택");

        try {
            stmt = conn.createStatement();
            rs = stmt.executeQuery(query);

            while(rs.next()){
                result.add(rs.getString(1));
            }

            rs.close();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            DbUtils.closeQuietly(conn);
        }

        return result;
    }

    //키워드 검색
    //kwd ex)
    //grdType:졸업논문/자격증/공모전/학술대회/전체 선택-/-/-grdSemester:19-08
    //-/-/-grdAdmission:2012-/-/-grdProf:XXX-/-/-name:XXX-/-/-stdNum:XXX
    public ArrayList<BackStudentDTO> getSearchStudent(String kwd){
        System.out.println(kwd);

        String[] kwds = kwd.split("-/-/-");
        String query = "SELECT * FROM back_students";
        String typeKwd = "";
        String semesterKwd = "";
        String admissionKwd = "";
        String profKwd = "";
        String nameKwd = "";
        String stdNumKwd = "";
        int kwdCnt = 0;

        for(String tmp : kwds){
            //grdType
            if(tmp.contains("grdType:") && !tmp.equals("grdType:")){
                String word = tmp.substring(tmp.indexOf(":") + 1);

                if(word.contains("전체 선택")){
                    continue;
                }

                else{
                    String[] s = word.split("/");
                    if(s.length > 0)
                        typeKwd += "(";

                    for(String v : s){
                        if(kwdCnt == 0){
                            query += " WHERE ";
                            kwdCnt++;
                        }

                        if(v.equals("졸업논문")){
                            if(!typeKwd.equals("("))
                                typeKwd += "OR ";

                            typeKwd += "graduation_type = \'최종보고서\' ";
                        }

                        else if(v.equals("자격증")){
                            if(!typeKwd.equals("("))
                                typeKwd += "OR ";

                            typeKwd += "graduation_type = \'기타자격(자격증)\' ";
                        }

                        else if(v.equals("공모전")){
                            if(!typeKwd.equals("("))
                                typeKwd += "OR ";

                            typeKwd += "graduation_type = \'기타자격(공모전)\' ";
                        }

                        else if(v.equals("학술대회")){
                            if(!typeKwd.equals("("))
                                typeKwd += "OR ";

                            typeKwd += "graduation_type = \'기타자격(학술대회)\' ";
                        }
                    }

                    if(s.length > 0){
                        typeKwd += ")";
                        kwdCnt++;
                        query += typeKwd;
                    }
                }
            }

            //grdSemester
            else if(tmp.contains("grdSemester:") && !tmp.equals("grdSemester:")){
                if(tmp.contains("전체 선택"))
                    continue;

                semesterKwd += "(graduation_date = \'" + tmp.substring(tmp.indexOf(":") + 1) + "\')";

                if(kwdCnt == 0){
                    query += " WHERE ";
                }

                if(kwdCnt > 0){
                    query += " AND ";
                }

                kwdCnt++;
                query += semesterKwd;
            }

            //grdAdmission
            else if(tmp.contains("grdAdmission:") && !tmp.equals("grdAdmission:")){
                if(tmp.contains("전체 선택"))
                    continue;

                admissionKwd += "(SUBSTRING(per_id, 1, 4) = \'" + tmp.substring(tmp.indexOf(":") + 1) + "\')";

                if(kwdCnt == 0){
                    query += " WHERE ";
                }

                if(kwdCnt > 0){
                    query += " AND ";
                }

                kwdCnt++;
                query += admissionKwd;
            }

            //grdProf
            else if(tmp.contains("grdProf:") && !tmp.equals("grdProf:")){
                if(tmp.contains("전체 선택"))
                    continue;

                profKwd += "(prof_name = \'" + tmp.substring(tmp.indexOf(":") + 1) + "\')";

                if(kwdCnt == 0){
                    query += " WHERE ";
                }

                if(kwdCnt > 0){
                    query += " AND ";
                }

                kwdCnt++;
                query += profKwd;
            }

            //name
            else if(tmp.contains("name:") && !tmp.equals("name:")){
                nameKwd += "(name = \'" + tmp.substring(tmp.indexOf(":") + 1) + "\')";

                if(kwdCnt == 0){
                    query += " WHERE ";
                }

                if(kwdCnt > 0){
                    query += " AND ";
                }

                kwdCnt++;
                query += nameKwd;
            }

            //stdNum
            else if(tmp.contains("stdNum:") && !tmp.equals("stdNum:")){
                stdNumKwd += "(per_id = " + tmp.substring(tmp.indexOf(":") + 1) + ")";

                if(kwdCnt == 0){
                    query += " WHERE ";
                }

                if(kwdCnt > 0){
                    query += " AND ";
                }

                kwdCnt++;
                query += stdNumKwd;
            }
        }

        System.out.println(query);

        //JDBC
        ArrayList<BackStudentDTO> result = new ArrayList<>();
        Connection conn = Config.getInstance().sqlLogin();
        Gson gson = new Gson();
        Statement stmt = null;
        ResultSet rs = null;

        try {
            stmt = conn.createStatement();
            rs = stmt.executeQuery(query);

            while(rs.next()){
                int per_id = rs.getInt("per_id");
                String name = rs.getString("name");
                String prof_name = rs.getString("prof_name");
                String graduation_date = rs.getString("graduation_date");
                String major = rs.getString("major");
                String graduation_type = null;
                Date final_action_date = rs.getDate("final_action_date");
                String grdType = null;

                if(rs.getString("graduation_type").equals("기타자격(자격증)"))
                    graduation_type = "자격증";

                else if(rs.getString("graduation_type").equals("기타자격(학술대회)"))
                    graduation_type = "학술대회";

                else if(rs.getString("graduation_type").equals("기타자격(공모전)"))
                    graduation_type = "공모전";

                else if(rs.getString("graduation_type").equals("최종보고서"))
                    graduation_type = "졸업논문";

                if(rs.getString("graduation_type").equals("기타자격(자격증)"))
                    grdType = "certificate";

                else if(rs.getString("graduation_type").equals("기타자격(학술대회)"))
                    grdType = "conference";

                else if(rs.getString("graduation_type").equals("기타자격(공모전)"))
                    grdType = "contest";

                else if(rs.getString("graduation_type").equals("최종보고서"))
                    grdType = "thesis";


                BackStudentDTO backStudentDTO = new BackStudentDTO();
                backStudentDTO.setPer_id(per_id);
                backStudentDTO.setName(name);
                backStudentDTO.setProf_name(prof_name);
                backStudentDTO.setGraduation_date(graduation_date);
                backStudentDTO.setMajor(major);
                backStudentDTO.setGraduation_type(graduation_type);
                backStudentDTO.setFinal_action_date(final_action_date);
                backStudentDTO.setGrdType(grdType);

                result.add(backStudentDTO);
            }

            rs.close();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            DbUtils.closeQuietly(conn);
        }

        return result;
    }

    //자격증 데이터 가져오는 메소드
    public ArrayList<BackCertificateDataDTO> getCertificate(int perId){
        ArrayList<BackCertificateDataDTO> result = new ArrayList<>();
        Connection conn = Config.getInstance().sqlLogin();
        Gson gson = new Gson();
        Statement stmt = null;
        ResultSet rs = null;

        String query = "SELECT * FROM back_certificate_data WHERE per_id = " + perId + ";";

        try {
            stmt = conn.createStatement();
            rs = stmt.executeQuery(query);

            while(rs.next()){
                int per_id = rs.getInt("per_id");
                String requirement = rs.getString("requirement");
                String cerId = rs.getString("cer_id");
                String organization = rs.getString("organization");
                Date acqDate = rs.getDate("acq_date");
                String cerFileName = rs.getString("cer_filename");

                BackCertificateDataDTO backCertificateDataDTO = new BackCertificateDataDTO();
                backCertificateDataDTO.setPerId(per_id);
                backCertificateDataDTO.setRequirement(requirement);
                backCertificateDataDTO.setCerId(cerId);
                backCertificateDataDTO.setOrganization(organization);
                backCertificateDataDTO.setAcqDate(acqDate);
                backCertificateDataDTO.setCerFileName(cerFileName);

                result.add(backCertificateDataDTO);
            }

            rs.close();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            DbUtils.closeQuietly(conn);
        }

        return result;
    }

    //공모전 데이터 가져오는 메소드
    public ArrayList<BackContestDataDTO> getContest(int perId){
        ArrayList<BackContestDataDTO> result = new ArrayList<>();
        Connection conn = Config.getInstance().sqlLogin();
        Gson gson = new Gson();
        Statement stmt = null;
        ResultSet rs = null;

        String query = "SELECT * FROM back_contest_data WHERE per_id = " + perId + ";";

        try {
            stmt = conn.createStatement();
            rs = stmt.executeQuery(query);

            while(rs.next()){
                int per_id = rs.getInt("per_id");
                String contestName = rs.getString("contest_name");
                String contestContent = rs.getString("contest_content");
                String organization = rs.getString("organization");
                Date awardDate = rs.getDate("award_date");
                Date openDate = rs.getDate("open_date");
                String awardFileName = rs.getString("award_filename");
                String addFileName = rs.getString("add_filename");
                String teamType = rs.getString("team_type");

                BackContestDataDTO backContestDataDTO = new BackContestDataDTO();
                backContestDataDTO.setPerId(per_id);
                backContestDataDTO.setContestName(contestName);
                backContestDataDTO.setContestContent(contestContent);
                backContestDataDTO.setOrganization(organization);
                backContestDataDTO.setAwardDate(awardDate);
                backContestDataDTO.setOpenDate(openDate);
                backContestDataDTO.setAwardFileName(awardFileName);
                backContestDataDTO.setAddFileName(addFileName);
                backContestDataDTO.setTeamType(teamType);

                result.add(backContestDataDTO);
            }

            rs.close();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            DbUtils.closeQuietly(conn);
        }

        return result;
    }

    //학술대회 데이터 가져오는 메소드
    public ArrayList<BackConferenceDataDTO> getConference(int perId){
        ArrayList<BackConferenceDataDTO> result = new ArrayList<>();
        Connection conn = Config.getInstance().sqlLogin();
        Gson gson = new Gson();
        Statement stmt = null;
        ResultSet rs = null;

        String query = "SELECT * FROM back_conference_data WHERE per_id = " + perId + ";";
        try {
            stmt = conn.createStatement();
            rs = stmt.executeQuery(query);
            while(rs.next()){
                int per_id = rs.getInt("per_id");
                String conferenceName = rs.getString("conference_name");
                String requirement = rs.getString("requirement");
                String thesisTitle = rs.getString("thesis_title");
                String organization = rs.getString("organization");
                Date openDate = rs.getDate("open_date");
                String thesisFileName = rs.getString("thesis_filename");
                String proofFileName = rs.getString("proof_filename");
                BackConferenceDataDTO backConferenceDataDTO = new BackConferenceDataDTO();
                backConferenceDataDTO.setPerId(perId);
                backConferenceDataDTO.setConferenceName(conferenceName);
                backConferenceDataDTO.setRequirement(requirement);
                backConferenceDataDTO.setThesisTitle(thesisTitle);
                backConferenceDataDTO.setOrganization(organization);
                backConferenceDataDTO.setOpenDate(openDate);
                backConferenceDataDTO.setThesisFileName(thesisFileName);
                backConferenceDataDTO.setProofFileName(proofFileName);
                result.add(backConferenceDataDTO);
            }

            rs.close();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            DbUtils.closeQuietly(conn);
        }

        return result;
    }

    //학생 한명 데이터
    public ArrayList<BackStudentDTO> getStudent(int perId){
        ArrayList<BackStudentDTO> result = new ArrayList<>();
        Connection conn = Config.getInstance().sqlLogin();
        Gson gson = new Gson();
        Statement stmt = null;
        ResultSet rs = null;

        String query = "SELECT * FROM back_students WHERE per_id="+perId+";";

        try {
            stmt = conn.createStatement();
            rs = stmt.executeQuery(query);

            while(rs.next()){
                int per_id = rs.getInt("per_id");
                String name = rs.getString("name");
                String prof_name = rs.getString("prof_name");
                String graduation_date = rs.getString("graduation_date");
                String major = rs.getString("major");
                String graduation_type = null;
                Date final_action_date = rs.getDate("final_action_date");
                String grdType = null;

                if(rs.getString("graduation_type").equals("기타자격(자격증)"))
                    graduation_type = "자격증";

                else if(rs.getString("graduation_type").equals("기타자격(학술대회)"))
                    graduation_type = "학술대회";

                else if(rs.getString("graduation_type").equals("기타자격(공모전)"))
                    graduation_type = "공모전";

                else if(rs.getString("graduation_type").equals("최종보고서"))
                    graduation_type = "졸업논문";

                if(rs.getString("graduation_type").equals("기타자격(자격증)"))
                    grdType = "certificate";

                else if(rs.getString("graduation_type").equals("기타자격(학술대회)"))
                    grdType = "conference";

                else if(rs.getString("graduation_type").equals("기타자격(공모전)"))
                    grdType = "contest";

                else if(rs.getString("graduation_type").equals("최종보고서"))
                    grdType = "thesis";


                BackStudentDTO backStudentDTO = new BackStudentDTO();
                backStudentDTO.setPer_id(per_id);
                backStudentDTO.setName(name);
                backStudentDTO.setProf_name(prof_name);
                backStudentDTO.setGraduation_date(graduation_date);
                backStudentDTO.setMajor(major);
                backStudentDTO.setGraduation_type(graduation_type);
                backStudentDTO.setFinal_action_date(final_action_date);
                backStudentDTO.setGrdType(grdType);

                result.add(backStudentDTO);
            }

            rs.close();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            DbUtils.closeQuietly(conn);
        }

        return result;
    }

    //졸업논문 데이터 가져오는 메소드
    public ArrayList<BackThesisDataDTO> getThesis(int perId){
        ArrayList<BackThesisDataDTO> result = new ArrayList<>();
        Connection conn = Config.getInstance().sqlLogin();
        Gson gson = new Gson();
        Statement stmt = null;
        ResultSet rs = null;

        String query = "SELECT * FROM back_thesis_data WHERE per_id = " + perId + ";";
        try {
            stmt = conn.createStatement();
            rs = stmt.executeQuery(query);
            while(rs.next()){
                int per_id = rs.getInt("per_id");
                String title = rs.getString("title");
                String classification = rs.getString("classification");
                String keyword = rs.getString("keyword");
                String proposalContent = rs.getString("proposal_content");
                String interimFileName = rs.getString("interim_filename");
                String finalRequirement = rs.getString("final_requirement");
                int finalPage = rs.getInt("final_page");
                String finalFileName = rs.getString("final_filename");

                BackThesisDataDTO backThesisDataDTO = new BackThesisDataDTO();
                backThesisDataDTO.setPerId(per_id);
                backThesisDataDTO.setClassification(classification);
                backThesisDataDTO.setKeyword(keyword);
                backThesisDataDTO.setTitle(title);
                backThesisDataDTO.setProposalContent(proposalContent);
                backThesisDataDTO.setInterimFileName(interimFileName);
                backThesisDataDTO.setFinalFileName(finalFileName);
                backThesisDataDTO.setFinalRequirement(finalRequirement);
                backThesisDataDTO.setFinalPage(finalPage);

                result.add(backThesisDataDTO);
            }

            rs.close();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            DbUtils.closeQuietly(conn);
        }

        return result;
    }


    //졸업자인지 확인
    public boolean isGraduate(int perId){
        Connection conn = Config.getInstance().sqlLogin();
        Gson gson = new Gson();
        Statement stmt = null;
        ResultSet rs = null;
        int cnt = 0;

        String query = "SELECT COUNT(*) FROM back_students WHERE per_id="+perId+";";

        try {
            stmt = conn.createStatement();
            rs = stmt.executeQuery(query);
            while (rs.next()) {
                cnt = rs.getInt(0);
            }
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            DbUtils.closeQuietly(conn);
        }

        if(cnt > 0){
            return true;
        }
        else{
            return false;
        }
    }

}
