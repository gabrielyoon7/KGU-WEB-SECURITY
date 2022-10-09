package kr.ac.kyonggi.cs.handler.action.graduation;

import java.sql.Connection;
import java.sql.SQLException;

import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import kr.ac.kyonggi.cs.common.sql.Config;

public class GraduationQuartzFinal implements Job{
	
	@Override
    public void execute(JobExecutionContext context) throws JobExecutionException{
		System.out.println("final ");
		Connection conn = Config.getInstance().sqlLogin();
		QueryRunner que = new QueryRunner();
		try {
			que.update(conn,"UPDATE grdu_students SET fin=4,current=4 WHERE current_state=4 AND current=3");
		}catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
	}

}
