package kr.ac.kyonggi.cs.handler.action.graduation;

import java.sql.Connection;
import java.sql.SQLException;

import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import kr.ac.kyonggi.cs.common.sql.Config;

public class GraduationQuartzEtc implements Job{
	
	@Override
    public void execute(JobExecutionContext context) throws JobExecutionException{
		System.out.println("???");
		Connection conn = Config.getInstance().sqlLogin();
		QueryRunner que = new QueryRunner();
		try {
			que.update(conn,"UPDATE grdu_etc_state SET certi_level_int=4,confe_level_int=4,contest_level_int=4 WHERE capstone>1");
		}catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
	}
}
