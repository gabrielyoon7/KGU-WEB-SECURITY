package kr.ac.kyonggi.cs.handler.action.graduation;

import java.sql.Connection;
import java.sql.SQLException;

import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import kr.ac.kyonggi.cs.common.sql.Config;
import kr.ac.kyonggi.cs.handler.dao.graduation.GraduationTestDAO;

public class GraduationQuartzSuggest implements Job{
	
	@Override
    public void execute(JobExecutionContext context) throws JobExecutionException{
		System.out.println("서제스트");
		Connection conn = Config.getInstance().sqlLogin();
		QueryRunner que = new QueryRunner();
		try {
			que.update(conn,"UPDATE grdu_students SET suggest=4,current=4 WHERE current_state=2 AND current=3");
		}catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
	}

}
