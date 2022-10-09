package kr.ac.kyonggi.cs.handler.action.graduation;

import java.sql.Connection;
import java.sql.SQLException;

import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import kr.ac.kyonggi.cs.common.sql.Config;

public class GraduationQuartzInterimEnd implements Job{
	
	@Override
    public void execute(JobExecutionContext context) throws JobExecutionException{
		System.out.println("mid end");
		Connection conn = Config.getInstance().sqlLogin();
		QueryRunner que = new QueryRunner();
		try {
			que.update(conn,"UPDATE grdu_students SET interim=5,current=5 WHERE current_state=3 AND current=4");
		}catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DbUtils.closeQuietly(conn);
		}
	}

}
