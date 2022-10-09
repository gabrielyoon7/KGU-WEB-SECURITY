package kr.ac.kyonggi.cs.v2.handler.dao.user;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.ac.kyonggi.cs.common.sql.Config;
import kr.ac.kyonggi.cs.handler.vo.GrdUserBean;
import kr.ac.kyonggi.cs.handler.vo.user.BigUser;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserTypeBean;
import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.ColumnListHandler;
import org.apache.commons.dbutils.handlers.MapListHandler;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class UserDAO {
	public static UserDAO it;

	public static UserDAO getInstance() {
		if(it == null)
			it = new UserDAO();
		return it;
	}

	public UserBean getUser(String id) {
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn,"SELECT * FROM user WHERE id = ?;", new MapListHandler(), id);
		} catch(SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		ArrayList<BigUser> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<BigUser>>() {}.getType());
		if(selected.size()>0) {
			return selected.get(0);
		}
		else
			return null;
	}

	public void whoIsLogIn(String id) {
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			queryRunner.update(conn,"UPDATE user SET last_login = now() WHERE id = ?;", id);
		} catch(SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
	}
	public UserTypeBean getType(String type){
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			String sql = "SELECT * FROM usertype where type_name = '" + type + "';";
			listOfMaps = queryRunner.query(conn, sql, new MapListHandler());
		} catch(Exception se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}

		try {
			Gson gson = new Gson();
			ArrayList<UserTypeBean> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<UserTypeBean>>() {}.getType());
			for(int i = 0; i < selected.size(); i++)
			{
			}
			if(selected.size() > 0) {
				return selected.get(0);
			}
			else
				return null;
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	public ArrayList<UserTypeBean> getAllType(){
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn,"SELECT * FROM `usertype` ORDER BY `board_level`", new MapListHandler());
		} catch(SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		ArrayList<UserTypeBean> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<UserTypeBean>>() {}.getType());
		return selected;
	}



	public boolean checkID(String id) {
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn,"SELECT * FROM user WHERE id = ?;", new MapListHandler(), id);
		} catch(SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		ArrayList<UserBean> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<UserBean>>() {}.getType());
		if(selected.size()==0) {
			return true;
		}
		else
			return false;
	}

	public String registerSmallID(String text) {
		String arr[] = text.split("-/-/-");//id+"-/-/-"+password+"-/-/-"+name+"-/-/-"+gender+"-/-/-"+birth+"-/-/-"+email+"-/-/-"+phone+"-/-/-"+type;
		if(!checking(text))
			return "fail";
		boolean result = false;
		if( !arr[7].equals("학부모") && !arr[7].equals("기타") && !arr[7].equals("입학예정자"))
			return "fail";
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			queryRunner.update(conn,"INSERT INTO user(id,password,name,gender,birth,email,phone,type,reg_date) VALUES (?,?,?,?,?,?,?,?,now());", arr[0],arr[1],arr[2],arr[3],arr[4],arr[5],arr[6],arr[7]);
			result = true;
		} catch(SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		if(result)
			return "success";
		else
			return "fail";
	}

	public String registerBigID(String text) {
		String arr[] = text.split("-/-/-");//id+"-/-/-"+SHA256(password)+"-/-/-"+name+"-/-/-"+gender+"-/-/-"+birth+"-/-/-"+email+"-/-/-"+phone+"-/-/-"+type+"-/-/-"+major+"-/-/-"+perID
		boolean result =false;
		if(!checking(text))
			return "fail";
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			queryRunner.update(conn,"INSERT INTO user(id,password,name,gender,birth,email,phone,hope_type,major,per_id,type,reg_date) VALUES (?,?,?,?,?,?,?,?,?,?,?,now());", arr[0],arr[1],arr[2],arr[3],arr[4],arr[5],arr[6],arr[7],arr[8],arr[9],"구분변경희망자");
			result = true;
		} catch(SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		if(result)
			return "success";
		else
			return "fail";
	}

	public void changePassword(String id, String newPassword) {
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			queryRunner.update(conn,"UPDATE user SET password = ? WHERE id = ?;", newPassword, id);
		} catch(SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}

	}

	public boolean checkPassword(String data) {
		String arr[] = data.split("-/-/-");//password, id
		if(!checking(arr[1]))
			return false;
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn,"SELECT * FROM user WHERE id = ?;", new MapListHandler(), arr[1]);
		} catch(SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		ArrayList<UserBean> results = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<UserBean>>() {}.getType());
		if(results.get(0).password.equals(arr[0]))
			return true;
		else
			return false;
	}

	public ArrayList<UserBean> getAlluser() {
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn,"SELECT * FROM user WHERE type <> '관리자';", new MapListHandler());
		} catch(SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		ArrayList<UserBean> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<UserBean>>() {}.getType());
		if(selected.size()>0) {
			return selected;
		}
		else
			return null;
	}

	public ArrayList<UserBean> getAIuser() { //ai권한 가진 유저만 db에서 불러오기
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn,"SELECT * FROM user_ai  WHERE type <> '관리자';", new MapListHandler());
		} catch(SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		ArrayList<UserBean> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<UserBean>>() {}.getType());
		//System.out.println("userDAO.getAIuser "+selected.size());
		if(selected.size()>0) {
			return selected;
		}
		else
			return null;
	}

	public String deleteUser(String data) {
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			queryRunner.update(conn,"DELETE FROM user WHERE id=? ;",data);
		} catch(SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		return data;

	}

	public String insertAdmin(String data) {
		String arr[] = data.split("-/-/-");//id+"-/-/-"+SHA256(password)+"-/-/-"+name+"-/-/-"+type
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			queryRunner.update(conn,"INSERT INTO user(id,password,name,type,reg_date) VALUES (?,?,?,?,now());", arr[0],arr[1],arr[2],arr[3]);
		} catch(SQLException se) {
			se.printStackTrace();
			return "fail";
		} finally {
			DbUtils.closeQuietly(conn);
		}
		return arr[0] + "-/-/-" + arr[2] + "-/-/-" + arr[3];
	}

	public String modifyType(String data) {
		String arr[]=data.split("-/-/-");//0=변경할 type 1~=바뀔것
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			for(int i=1;i<arr.length;i++) {
				queryRunner.update(conn,"UPDATE user SET type = ?, hope_type = ? WHERE id = ?;",arr[0],"-",arr[i]);
			}
		}catch(SQLException se) {
			se.printStackTrace();
		}finally {
			DbUtils.closeQuietly(conn);
		}
		return "1";
	}

	public String modifypw(String data) {// 수정
		String arr[] = data.split("-/-/-");
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps=queryRunner.query(conn,"SELECT * FROM user WHERE id = ?;",new MapListHandler(),arr[0]);
			queryRunner.update(conn,"UPDATE user SET password = ? WHERE id = ?;", arr[1], arr[0]);
		}catch(Exception se) {
			se.printStackTrace();
		}finally {
			DbUtils.closeQuietly(conn);
		}
		return (String)listOfMaps.get(0).get("name") + "[" + (String)listOfMaps.get(0).get("per_id") + "]";
	}

	public String modifydata(String data) {
		String arr[] = data.split("-/-/-");//0:id 1:phone 2:birth 3:email
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			queryRunner.update(conn,"UPDATE user SET phone=?,birth=?,email=? WHERE id = ?;",arr[1],arr[2],arr[3],arr[0]);
		}catch(SQLException se) {
			se.printStackTrace();
		}finally {
			DbUtils.closeQuietly(conn);
		}
		return "";
	}

	public String insertexceluser(List<Map<String, Object>> xlsUserReader) {
		Connection conn = Config.getInstance().sqlLogin();
		boolean die=false;
		int dieid =0;
		try {
			QueryRunner queryRunner = new QueryRunner();

			for(int i=0;i<xlsUserReader.size();i++) {
				UserBean user=new UserBean();
				user.id=(String) xlsUserReader.get(i).get("id");//id
				user.per_id=(String) xlsUserReader.get(i).get("per_id");//학번
				if(user.id==null) {
					user.id=user.per_id;
				}
				List<String> idlist=queryRunner.query(conn,"SELECT id FROM user ",new ColumnListHandler<String>());

				for(int j=0;j<idlist.size();j++) {//중복id검사(한사람 죽어버리기)
					if(user.id.equals(idlist.get(j))) {
						die=true;
						dieid++;
						break;
					}
				}
				if(die) {
					die=false;
					continue;
				}
				user.major=(String) xlsUserReader.get(i).get("major");//전공
				if(user.major==null)
					user.major="-";
				user.phone=(String) xlsUserReader.get(i).get("phone");//휴대폰
				if(user.phone==null)
					user.phone="-";
				user.grade=(String) xlsUserReader.get(i).get("grade");
				if(user.grade==null)
					user.grade="-";//학년
				user.name=(String) xlsUserReader.get(i).get("name");//이름
				user.birth=(String) xlsUserReader.get(i).get("birth");//생일
				user.state=(String) xlsUserReader.get(i).get("state");//재적상태
				if(user.state==null)
					user.state="-";
				user.type=(String) xlsUserReader.get(i).get("type");//타입
				if(user.type == null)
					user.type = "학부생";
				user.email=(String) xlsUserReader.get(i).get("email");//이메일
				if(user.email==null)
					user.email="-";
				List<String> namelist=queryRunner.query(conn,"SELECT name FROM user ",new ColumnListHandler<String>());
				List<String> birthlist=queryRunner.query(conn,"SELECT birth FROM user ",new ColumnListHandler<String>());
				for(int k=0;k<namelist.size();k++) {
					if(user.name.equals(namelist.get(k))&&user.birth.equals(birthlist.get(k))) {
						queryRunner.update(conn,"UPDATE user SET major=?,per_id=?,type=?,state=? WHERE name=? and birth=?",namelist.get(k),birthlist.get(k));//전공,학번,타입,재적상태 
						die=true;
						break;
					}
				}
				if(die) {
					die=false;
				}
				String[] p =user.birth.split("-");
				String password=p[0].substring(2, 4)+p[1]+p[2];//yymmdd
				String toSha = user.id + password;
				user.password=SHA256(toSha);
				Date date=new Date();
				queryRunner.update(conn,"INSERT INTO user(id,password,major,phone,grade,name,birth,state,type,email,per_id,reg_date) VALUE(?,?,?,?,?,?,?,?,?,?,?,?)",user.id,user.password,user.major,user.phone,user.grade,user.name,user.birth,user.state,user.type,user.email,user.per_id,date);//id 중복될경우
			}
		}catch(SQLException se) {
			se.printStackTrace();
		}finally {
			DbUtils.closeQuietly(conn);
		}

		return Integer.toString(xlsUserReader.size()-dieid);
	}
	public String SHA256(String str){
		String SHA = "";
		try{
			MessageDigest sh = MessageDigest.getInstance("SHA-256");
			sh.update(str.getBytes());
			byte byteData[] = sh.digest();
			StringBuffer sb = new StringBuffer();
			for(int i = 0 ; i < byteData.length ; i++){
				sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
			}
			SHA = sb.toString();
		}catch(NoSuchAlgorithmException e){
			e.printStackTrace();
			SHA = null;
		}
		return SHA;
	}

	public String compareUser(String header, String id) {//header value
		List<Map<String, Object>> listOfMaps = null;

		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn,"SELECT * FROM user WHERE id=?;",new MapListHandler() ,id);
		} catch(SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		String data=null;
		if(!listOfMaps.isEmpty())
			data=(String)listOfMaps.get(0).get(header);

		if(data!=null) {
			return data;
		}
		else {
			return null;
		}
	}

	public String modifyexceluser(List<Map<String, Object>> modifymap) {
		Connection conn = Config.getInstance().sqlLogin();

		boolean die=false;
		int dieid =0;
		try {
			QueryRunner queryRunner = new QueryRunner();
			for(int i=0;i<modifymap.size();i++) {
				UserBean user=new UserBean();
				user.id=(String) modifymap.get(i).get("id");//id
				user.per_id=(String) modifymap.get(i).get("per_id");//학번
				user.major=(String) modifymap.get(i).get("major");//전공
				user.grade=(String) modifymap.get(i).get("grade");//학년
				user.state=(String) modifymap.get(i).get("state");//재적상태
				user.type=(String) modifymap.get(i).get("type");//타입
				if(user.per_id!=null)
					queryRunner.update(conn,"UPDATE user SET per_id=? WHERE id=?",user.per_id,user.id);
				if(user.major!=null)
					queryRunner.update(conn,"UPDATE user SET major=? WHERE id=?",user.major,user.id);
				if(user.grade!=null)
					queryRunner.update(conn,"UPDATE user SET grade=? WHERE id=?",user.grade,user.id);
				if(user.state!=null)
					queryRunner.update(conn,"UPDATE user SET state=? WHERE id=?",user.state,user.id);
				if(user.type!=null)
					queryRunner.update(conn,"UPDATE user SET type=? WHERE id=?",user.type,user.id);

			}
		}catch(SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		return Integer.toString(modifymap.size());
	}

	public String checkper_id_req(String per_id) {//바꿈
		List<Map<String, Object>> listOfMaps = null;
		List<Map<String, Object>> listOfMaps2 = null;

		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn,"SELECT * FROM user WHERE per_id = ?;", new MapListHandler(), per_id);
			listOfMaps2 = queryRunner.query(conn,"SELECT * FROM grdu_req_students WHERE per_id = ?;", new MapListHandler(), per_id);

		} catch(SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		ArrayList<UserBean> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<UserBean>>() {}.getType()); //있으면 0 없으면 X
		ArrayList<GrdUserBean> checked = gson.fromJson(gson.toJson(listOfMaps2), new TypeToken<List<GrdUserBean>>() {}.getType());//있으면 X 없으면 0

		if(selected.size()!=0 && checked.size()==0)
			return "0-/-/-"+selected.get(0).name;//존재학번, 학번 중복 X
		else if(selected.size()!=0 && checked.size()!=0)
			return "1";//존재하는 학번 but 학번 중복
		else if(selected.size()==0 && checked.size()==0)
			return "2"; //존재하지 않는 학번 중복안된 학번
		else
			return "3";//존재하지 않는 학번 과 중복된 학번
	}

	public String checkper_id(String per_id) {//바꿈
		List<Map<String, Object>> listOfMaps = null;
		List<Map<String, Object>> listOfMaps2 = null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn,"SELECT * FROM user WHERE per_id = ?;", new MapListHandler(), per_id);
			listOfMaps2 = queryRunner.query(conn,"SELECT * FROM grdu_students WHERE per_id = ?;", new MapListHandler(), per_id);
		} catch(SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		ArrayList<UserBean> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<UserBean>>() {}.getType()); //있으면 0 없으면 X
		ArrayList<GrdUserBean> checked = gson.fromJson(gson.toJson(listOfMaps2), new TypeToken<List<GrdUserBean>>() {}.getType());//있으면 X 없으면 0
		if(selected.size()!=0 && checked.size()==0)
			return "0-/-/-"+selected.get(0).name;//존재학번, 학번 중복 X
		else if(selected.size()!=0 && checked.size()!=0)
			return "1";//존재하는 학번 but 학번 중복
		else if(selected.size()==0 && checked.size()==0)
			return "2"; //존재하지 않는 학번 중복안된 학번
		else
			return "3";//존재하지 않는 학번 과 중복된 학번
	}

	public UserBean getUserperid(String per_id) {
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn,"SELECT * FROM user WHERE per_id = ?;", new MapListHandler(), per_id);
		} catch(SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		ArrayList<BigUser> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<BigUser>>() {}.getType());
		if(selected.size()>0) {
			return selected.get(0);
		}
		else
			return null;
	}

	private boolean checking(String content) {
		Pattern SCRIPTS = Pattern.compile("<(no)?script[^>]*>.*?</(no)?script>", Pattern.DOTALL);
		Pattern STYLE = Pattern.compile("<style[^>]*>.*</style>", Pattern.DOTALL);
		Pattern TAGS = Pattern.compile("<(\"[^\"]*\"|\'[^\']*\'|[^\'\">])*>");
		//Pattern nTAGS = Pattern.compile("<\\w+\\s+[^<]*\\s*>");
		Pattern ENTITY_REFS = Pattern.compile("&[^;]+;");
		Pattern WHITESPACE = Pattern.compile("\\s\\s+");
		Pattern WHITE = Pattern.compile("<!--");
		Pattern ON = Pattern.compile("(on)+[a-z]*=");
		Pattern SQL = Pattern.compile("[`';=]");

		Matcher m;

		m = SCRIPTS.matcher(content);
		if(m.find())
			return false;
		m = STYLE.matcher(content);
		if(m.find())
			return false;
		m = TAGS.matcher(content);
		if(m.find())
			return false;
		m = ENTITY_REFS.matcher(content);
		if(m.find())
			return false;
		m = WHITESPACE.matcher(content);
		if(m.find())
			return false;
		m = WHITE.matcher(content);
		if(m.find())
			return false;
		m = ON.matcher(content);
		if(m.find())
			return false;
		m = SQL.matcher(content);
		if(m.find())
			return false;
		return true;
	}

	public String enrollAIuser(String data) { //AI 접근 권한 추가
		//System.out.println("userDAO.enrollAIuser");
		String arr[] = data.split("-/-/-");//id+"-/-/-"+name+"-/-/-"+type+"-/-/-"+major
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			queryRunner.update(conn,"INSERT INTO user_ai(id,name,type,major) VALUES (?,?,?,?);", arr[0],arr[1],arr[2],arr[3]);
		} catch(SQLException se) {
			se.printStackTrace();
			return "fail";
		} finally {
			DbUtils.closeQuietly(conn);
		}
		return arr[0] + "-/-/-" + arr[1] + "-/-/-" + arr[2] + "-/-/-" + arr[3];
	}

	public String deleteAIUser(String data) { //AI 접근 권한 삭제
		Connection conn = Config.getInstance().sqlLogin();
		//System.out.println("userdao.deleteAIuser");
		try {
			QueryRunner queryRunner = new QueryRunner();
			queryRunner.update(conn,"DELETE FROM user_ai WHERE id=? ;",data);
		} catch(SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		return data;
	}

	public UserBean getAIUser(String id) { //user_ai에 유저가 있는지 검색
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn,"SELECT * FROM user_ai WHERE id = ?;", new MapListHandler(), id);
		} catch(SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		ArrayList<BigUser> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<BigUser>>() {}.getType());
		if(selected.size()>0) { //user_ai테이블에 존재하는 경우
			return selected.get(0);
		}
		else //user_ai 테이블에 존재하지 않는 경우
			return null;
	}

}