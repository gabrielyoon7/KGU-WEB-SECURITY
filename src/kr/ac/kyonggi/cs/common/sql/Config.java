package kr.ac.kyonggi.cs.common.sql;

import java.sql.Connection;
import java.sql.DriverManager;

// Enum Singleton
public class Config {

	private Config() {}
	private static class Singleton {
		private static final Config instance = new Config();
	}
	
	public static Config getInstance() {
		return Singleton.instance;
	}
	// DB 커넥션 Variable
	private Connection conn = null;

	// DB 정보

	private final String tool = "jdbc:mysql://";
	private final String port = "3306";
	
	private final String domain = "localhost";
	private final String id = "root";
//	private final String pw = "****";
//	private final String pw = "1q2w3e4r!";
	private final String pw = "NewSt@rt!70";
	private final String dbname = "test_db";
	
	private String url = tool + domain + ":" + port + "/" + dbname
			+ "?autoReconnect=true&useSSL=false&validationQuery=select 1&allowPublicKeyRetrieval=true";

		public Connection sqlLogin() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, id, pw);
			
		} catch (Exception e) {
			//System.out.println("asdsd");
			e.printStackTrace();
			System.out.println("DB 연결 실패");
		}
		return conn;
	}
}
