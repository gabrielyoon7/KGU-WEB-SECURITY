package kr.ac.kyonggi.cs.handler.dao.grdBack;

import kr.ac.kyonggi.cs.common.sql.Config;
import kr.ac.kyonggi.cs.handler.dto.grdBack.TargetStudentDto;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

public class GrdBackupDao {
    private static GrdBackupDao grdBackupDao=null;
    public static GrdBackupDao getInstance(){
        if(grdBackupDao==null){

            grdBackupDao = new GrdBackupDao();
        }
        return grdBackupDao;
    }

    public void insertBackupTable(List<TargetStudentDto> list,List<String> per_id) throws Exception{
        Connection connection = Config.getInstance().sqlLogin();
        QueryRunner queryRunner = new QueryRunner();
        String query1="INSERT INTO back_students (per_id, name, prof_name, graduation_date, major, graduation_type, final_action_date) VALUES (?, ?, ?, ?, ?, ?, ?)";
        String query2="INSERT INTO back_thesis_data (per_id, title, classification, keyword, proposal_content, interim_filename, final_requirement, final_page, final_filename) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        String query3="INSERT INTO back_certificate_data (per_id, requirement, cer_id, organization, acq_date, cer_filename) VALUES (?, ?, ?, ?, ?, ?)";
        String query4="INSERT INTO back_contest_data (per_id, contest_name, contest_content, organization, award_date, open_date, award_filename, add_filename, team_type) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        String query5="INSERT INTO back_conference_data (per_id, conference_name, requirement, thesis_title, organization, open_date, thesis_filename, proof_filename) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        for(TargetStudentDto user:list){
            if(per_id.contains(Integer.toString(user.getPer_id()))){
                if(user.getGraduation_type().equals("최종보고서")){
                    queryRunner.update(connection,query1,user.getPer_id(),user.getName(),
                            user.getProf_name(),user.getGraduation_date(),user.getMajor()
                            ,user.getGraduation_type(),user.getFinal_action_date());
                    queryRunner.update(connection,query2,user.getPer_id(),user.getTitle(),
                            user.getClassification(),user.getKeyword(),user.getProposal_content(),
                            user.getInterim_filename(),user.getFinal_requirement(),user.getFinal_page(),user.getFinal_filename());
                }
                else if(user.getGraduation_type().equals("기타자격(자격증)")){
                    queryRunner.update(connection,query1,user.getPer_id(),user.getName(),
                            user.getProf_name(),user.getGraduation_date(),user.getMajor()
                            ,user.getGraduation_type(),user.getCerti_date());
                    queryRunner.update(connection,query3,user.getPer_id(),user.getRequirement(),
                            user.getCer_id(),user.getOrganization(),user.getAcq_date(),user.getCer_filename());

                }

                else if(user.getGraduation_type().equals("기타자격(공모전)")){
                    queryRunner.update(connection,query1,user.getPer_id(),user.getName(),
                            user.getProf_name(),user.getGraduation_date(),user.getMajor()
                            ,user.getGraduation_type(),user.getContest_date());
                    queryRunner.update(connection,query4,user.getPer_id(),user.getContest_name(),
                            user.getContest_content(),user.getOrganization(),user.getAward_date(),
                            user.getOpen_date(),user.getAward_filename(),user.getAdd_filename(),
                            user.getTeam_type());
                }
                else{
                    queryRunner.update(connection,query1,user.getPer_id(),user.getName(),
                            user.getProf_name(),user.getGraduation_date(),user.getMajor()
                            ,user.getGraduation_type(),user.getConfe_date());
                    queryRunner.update(connection,query5,user.getPer_id(),user.getConference_name(),
                            user.getRequirement(),user.getThesis_title(),user.getOrganization()
                            ,user.getOpen_date(),user.getThesis_filename(),user.getProof_filename());
                }
            }
        }
        //return "success";
    }



    //@TODO grdu_student에서 fin이 7, grdu_etc_State에서 각 단계 상태가 7 => 통과
    public List<TargetStudentDto> getAllTargetStudent(){
        Connection connection = Config.getInstance().sqlLogin();
        String query1="SELECT * FROM grdu_thesis_data gd,grdu_students gs where gs.fin=7 and gs.per_id=gd.per_id";
        String query2="SELECT * FROM grdu_etc_state ge,grdu_students gs,grdu_certificate_data gc\n" +
                ",grdu_conference_data gf, grdu_contest_data gt WHERE (certi_level_int=7 or confe_level_int=7 or contest_level_int=7) and ge.per_id=gs.per_id and gs.per_id=gt.per_id and gs.per_id=gc.per_id and gs.per_id=gf.per_id";
        String certi="select * from grdu_etc_state ge,grdu_students gs,grdu_certificate_data gc where ge.certi_level_int=7 and gs.per_id=ge.per_id and gs.per_id=gc.per_id";
        String confe="select * from grdu_etc_state ge,grdu_students gs,grdu_conference_data gc where ge.confe_level_int=7 and gs.per_id=ge.per_id and gs.per_id=gc.per_id;";
        String contest="select * from grdu_etc_state ge,grdu_students gs,grdu_contest_data gc where ge.contest_level_int=7 and gs.per_id=ge.per_id and gs.per_id=gc.per_id;";
        QueryRunner queryRunner = new QueryRunner();
        List<TargetStudentDto> result1=null; //논문
        List<TargetStudentDto> result2=null; //기타
        List<TargetStudentDto> result3=null; //기타
        List<TargetStudentDto> result4=null; //기타
        ArrayList<TargetStudentDto> total=null;
        try{
            result1=queryRunner.query(connection,query1,new BeanListHandler<>(TargetStudentDto.class));
            result2=queryRunner.query(connection,certi,new BeanListHandler<>(TargetStudentDto.class));
            result3=queryRunner.query(connection,confe,new BeanListHandler<>(TargetStudentDto.class));
            result4=queryRunner.query(connection,contest,new BeanListHandler<>(TargetStudentDto.class));
        }
        catch (Exception e){
            e.printStackTrace();
        }
        total=convert(result1,result2,result3,result4);

        return total;
    }



    private ArrayList<TargetStudentDto> convert(List<TargetStudentDto> result1,List<TargetStudentDto> result2
    ,List<TargetStudentDto> result3,List<TargetStudentDto> result4){
        ArrayList<TargetStudentDto> total = new ArrayList<>();
        total.addAll(result1);
        total.addAll(result2);
        total.addAll(result3);
        total.addAll(result4);
        for(TargetStudentDto targetStudentDto:total){
            if(targetStudentDto.getFin()==7){
                targetStudentDto.setGraduation_type("최종보고서");
            }
            else if(targetStudentDto.getCerti_level_int()==7){
                targetStudentDto.setGraduation_type("기타자격(자격증)");
            }
            else if(targetStudentDto.getConfe_level_int()==7){
                targetStudentDto.setGraduation_type("기타자격(학술대회)");
            }
            else if(targetStudentDto.getContest_level_int()==7){
                targetStudentDto.setGraduation_type("기타자격(공모전)");
            }
        }
        return total;
    }

}