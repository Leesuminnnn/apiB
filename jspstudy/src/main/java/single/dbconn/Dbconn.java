package single.dbconn;

import java.sql.Connection;
import java.sql.DriverManager;

public class Dbconn {
	
	//oracle
//	private String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";	 
//	private String user = "system";
//	private String password = "1234";
	
	//팀프로젝트 할때
//	private String coninfo = "jdbc:mysql://ezen0807.cafe24.com/ezen0807";
//	private String idinfo = "ezen0807";
//	private String pwdinfo = "1234";
	
	//mysql
//	private String url = "jdbc:mysql://localhost:3306/mysql?serverTimezone=UTC&characterEncoding=UTF-8";
//	private String user = "root";
//	private String password = "1234";
	
	private String url = "jdbc:mysql://sull22.cafe24.com/sull22";
	private String user = "sull22";
	private String password = "Atn7als54!";
	
	public Connection getConnection() {
		Connection conn = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn =  DriverManager.getConnection(url, user, password);				
		}catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
		}
	}
