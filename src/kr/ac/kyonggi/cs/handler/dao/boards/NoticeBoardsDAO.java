package kr.ac.kyonggi.cs.handler.dao.boards;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;
/*import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;*/

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.reflect.TypeToken;


import kr.ac.kyonggi.cs.common.sql.Config;
import kr.ac.kyonggi.cs.handler.vo.NoticeCommentsBean;
import kr.ac.kyonggi.cs.handler.vo.NoticeFileBean;
import kr.ac.kyonggi.cs.handler.vo.BoardLevelBean;
import kr.ac.kyonggi.cs.handler.vo.MenuBean;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.vo.NoticeBoardsBean;

public class NoticeBoardsDAO {
	public static NoticeBoardsDAO it;

	public static NoticeBoardsDAO getInstance() {
		if(it == null)
			it = new NoticeBoardsDAO();
		return it;
	}


	public ArrayList<NoticeBoardsBean> getBoards(String num) {
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn, "SELECT * FROM notice_boards WHERE category=? ORDER BY id DESC;", new MapListHandler(),num);
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		ArrayList<NoticeBoardsBean> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<NoticeBoardsBean>>() {}.getType());
		for(int i = 0 ; i < selectedList.size() ; ++i)
			selectedList.get(i).title = getRemoveHtmlText(selectedList.get(i).title);
		return selectedList;
	}

	public ArrayList<NoticeBoardsBean> getAllBoards() {
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn, "SELECT * FROM notice_boards WHERE category=? OR category=? OR category=? ORDER BY last_modified DESC;", new MapListHandler(),41,46,51);
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		ArrayList<NoticeBoardsBean> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<NoticeBoardsBean>>() {}.getType());
		for(int i = 0 ; i < selectedList.size() ; ++i)
			selectedList.get(i).title = getRemoveHtmlText(selectedList.get(i).title);
		return selectedList;
	}

	public NoticeBoardsBean getBoardRead(int id) {
		List<Map<String,Object>> listOfMaps =null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn, "SELECT * FROM notice_boards WHERE id=?;",new MapListHandler(),id);
		}catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		ArrayList<NoticeBoardsBean> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<NoticeBoardsBean>>() {}.getType());
		selected.get(0).title = getRemoveHtmlText(selected.get(0).title);
		selected.get(0).content = getRemoveHtmlText(selected.get(0).content);
		return selected.get(0);

	}

	public void plusBoardView(int id) {
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			queryRunner.update(conn, "UPDATE notice_boards SET views = views+1 WHERE id=?;", id);
		}catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DbUtils.closeQuietly(conn);
		}
	}

	public String getComments(String data){
		String arr[]=data.split("-/-/-"); //0=id 1=type.board_level
		List<Map<String, Object>> listOfMaps = null;
		Connection conn= Config.getInstance().sqlLogin();
		Gson gson = new Gson();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn, "SELECT * FROM notice_boards WHERE id=? ;",new MapListHandler(),arr[0]);
			ArrayList<NoticeBoardsBean> list = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<NoticeBoardsBean>>() {}.getType());
			String menuID = list.get(0).category;
			listOfMaps = queryRunner.query(conn, "SELECT * FROM board_level WHERE id=? ;",new MapListHandler(),menuID);
			ArrayList<BoardLevelBean> levellist = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<BoardLevelBean>>() {}.getType());
			if(levellist.get(0).read_comment_level<Integer.parseInt(arr[1]))
				return null;
			listOfMaps = queryRunner.query(conn, "SELECT * FROM notice_comments WHERE article_id=? ;",new MapListHandler(),arr[0]);
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			DbUtils.closeQuietly(conn);
		}

		ArrayList<NoticeCommentsBean> selectedList =gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<NoticeCommentsBean>>() {}.getType());
		for(int i = 0 ; i < selectedList.size() ; ++i) {
			selectedList.get(i).content = getRemoveHtmlText(selectedList.get(i).content);
		}
		String commentList = gson.toJson(selectedList);

		return commentList;
	}


	public String insertComments(String data) {
		System.out.println(data);
		String arr[]=data.split("-/-/-"); //0 = id  1 = name 2 = article_id  3 = content
		//Date today = new Date();
		String today = dateToString(new Date());
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			queryRunner.update(conn, "INSERT INTO notice_comments(writer_id, writer_name, article_id,last_modified,content) VALUES (?,?,?,?,?) ;",arr[0],arr[1],arr[2], today, arr[3]);
			queryRunner.update(conn, "UPDATE notice_boards SET comments_count=comments_count+1 WHERE id=?", arr[2]);
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		return "";
	}


	public String updateComments(String data) {
		System.out.println(data);
		String arr[]=data.split("-/-/-");//0=id 1=content 2= userid 3=usertype;
		Connection conn =Config.getInstance().sqlLogin();
		List<Map<String,Object>> listOfMaps = null;
		try {
			Gson gson = new Gson();
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn, "SELECT * FROM notice_comments WHERE id=?", new MapListHandler(), arr[0]);
			ArrayList<NoticeCommentsBean> list = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<NoticeCommentsBean>>() {}.getType());
			NoticeCommentsBean it = list.get(0);
			if(!it.writer_id.equals(arr[2]))
				if(!arr[3].equals("관리자")&&!arr[3].equals("홈페이지관리자"))
					return "fail";
			queryRunner.update(conn, "UPDATE notice_comments SET content=? WHERE id=? ;",arr[1],arr[0]);
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		return "";
	}


	public String deleteComments(String data) {
		String[] arr = data.split("-/-/-");//0 = id 1 = user_id 2= user_type
		Connection conn =Config.getInstance().sqlLogin();   
		List<Map<String,Object>> listOfMaps = null;
		try {
			Gson gson = new Gson();
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn, "SELECT * FROM notice_comments WHERE id = ?", new MapListHandler(), arr[0]);
			ArrayList<NoticeCommentsBean> list = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<NoticeCommentsBean>>() {}.getType());
			NoticeCommentsBean it = list.get(0);
			if(!it.writer_id.equals(arr[1]))
				if(!arr[2].equals("관리자")&&!arr[2].equals("홈페이지관리자"))
					return "fail";
			queryRunner.update(conn, "DELETE FROM notice_comments WHERE id=? ;",arr[0]);
			queryRunner.update(conn, "UPDATE notice_boards SET comments_count=comments_count-1 WHERE id=?", it.article_id);

		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		return "1";
	}
	
	//jong hun
	//db에 날짜를 옮길때 발생한 오류(190314)
	public static String dateToString(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
		return sdf.format(date);
	}

	public String insertBoards(String data) {
		String arr[]=data.split("-/-/-");//0=num(category) 1=writer_id 2=title 3=content 4=student_name 5=type.board_level
		
		Gson gson = new Gson();
		//Date today=new Date();
		String today = dateToString(new Date());
		
		Connection conn =Config.getInstance().sqlLogin();
		try {
			MenuBean it = new HomeDAO().getMenuBean(arr[0]);
			List<Map<String, Object>> listOfMaps=null;
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn, "SELECT * FROM board_level WHERE id = ?", new MapListHandler(),it.id);
			ArrayList<BoardLevelBean> levellist =gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<BoardLevelBean>>() {}.getType());
			if(levellist.get(0).write_level<Integer.parseInt(arr[5])) 
				return "fail";
			
			queryRunner.update(conn, "INSERT INTO notice_boards(student_id,title,category,views,level,currentStatus,last_modified,content,student_name)"
					+ " VALUE(?,?,?,0,(SELECT max_level FROM fdb_pages WHERE id=?),0,?,?,?) ;",arr[1],arr[2],it.id,it.id,today,arr[3],arr[4]);
			
			listOfMaps = queryRunner.query(conn, "SELECT * FROM notice_boards WHERE student_id=? AND title=? AND content=?;", new MapListHandler(), arr[1],arr[2],arr[3]);
			ArrayList<NoticeBoardsBean> selectedList =gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<NoticeBoardsBean>>() {}.getType());
			if(selectedList.size() == 1 ) {
				NoticeBoardsBean it2 = selectedList.get(0);
				insertFileId(arr[1], Integer.toString(it2.id));
			}
		} catch (SQLException se) {
			se.printStackTrace();
			return "fail";
		} finally {
			DbUtils.closeQuietly(conn);
		}

		return "success";
	}


	public String modifyBoards(String data) {
		String arr[]=data.split("-/-/-");//0=id 1=title 2=content 3= writer_id 4= type_name 5= path
		Connection conn=Config.getInstance().sqlLogin();
		NoticeBoardsBean board = getBoardRead(Integer.valueOf(arr[0]));
		if(!board.student_id.equals(arr[3]) && !arr[4].equals("관리자")&&!arr[4].equals("홈페이지관리자"))
			return "fail";
		List<Map<String,Object>> listOfMaps = null;
		Gson gson = new Gson();
		try {
			QueryRunner queryRunner = new QueryRunner();
			queryRunner.update(conn,"UPDATE notice_boards SET title=?, content=? WHERE id=?;",arr[1],arr[2],arr[0]);

			listOfMaps = queryRunner.query(conn, "SELECT * FROM notice_file WHERE board_id=-1 AND writer=?", new MapListHandler(), arr[3]);
			ArrayList<NoticeFileBean> list = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<NoticeFileBean>>() {}.getType());
			for(int i = 0 ; i < list.size() ; ++i) {
				File deleteFile = new File(arr[5],list.get(i).filelink);
				deleteFile.delete();
			}
			queryRunner.update(conn, "DELETE FROM notice_file WHERE board_id=-1 AND writer=?", arr[3]);
		}catch(SQLException se) {
			se.printStackTrace();
			return "fail";
		}finally {
			DbUtils.closeQuietly(conn);
		}
		return "success";
	}

	public String deleteBoards(String data) {
		Connection conn=Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			queryRunner.update(conn,"DELETE FROM notice_boards WHERE id=?;",Integer.valueOf(data));
			queryRunner.update(conn,"DELETE FROM notice_comments WHERE article_id = ?;", Integer.valueOf(data));
		}
		catch (SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		return "1";
	}

	public void insertFile(String id, String writer, String name, String link) {
		Connection conn=Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			queryRunner.update(conn,"INSERT INTO notice_file(id, writer, filename, filelink) VALUE (?, ?, ?, ?);",id, writer, name, link);
		}
		catch (SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
	}

	public void insertFileId(String writer, String id) {
		Connection conn=Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			queryRunner.update(conn,"UPDATE notice_file SET `board_id`= ? WHERE `writer` = ? AND `board_id` = 0;",Integer.valueOf(id), writer);
		}
		catch (SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
	}

	public ArrayList<NoticeFileBean> getFilesForDelete(String writer){
		ArrayList<NoticeFileBean> selectedList = null;
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn, "SELECT * FROM notice_file WHERE writer=? AND board_id=0", new MapListHandler(), writer);
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<NoticeFileBean>>() {}.getType());
		return selectedList;
	}

	public void deleteFileWithName(String fileName) {
		Connection conn=Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			queryRunner.update(conn, "DELETE FROM notice_file WHERE filelink=?;", fileName);
		}
		catch (SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
	}

	public ArrayList<NoticeFileBean> readFile(int id) {
		ArrayList<NoticeFileBean> selectedList = null;
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn, "SELECT * FROM notice_file WHERE board_id=?", new MapListHandler(), id);
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<NoticeFileBean>>() {}.getType());
		return selectedList;
	}

	public NoticeFileBean getFile(String id) {
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn, "SELECT * FROM notice_file WHERE id=?", new MapListHandler(), id);
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		ArrayList<NoticeFileBean> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<NoticeFileBean>>() {}.getType());
		if(selectedList.size() > 0)
			return selectedList.get(0);
		else
			return null;
	}

	public void deleteFile(String id) {
		Connection conn=Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			queryRunner.update(conn, "DELETE FROM notice_file WHERE board_id=?;", id);
		}
		catch (SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
	}

	public ArrayList<NoticeBoardsBean> getNextPrevious(String id){
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		ArrayList<NoticeBoardsBean> nextPrevious = new ArrayList<>();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn, "SELECT * FROM notice_boards WHERE id=?", new MapListHandler(), id);
			Gson gson = new Gson();
			ArrayList<NoticeBoardsBean> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<NoticeBoardsBean>>() {}.getType());
			listOfMaps = queryRunner.query(conn, "SELECT * FROM notice_boards Where category = ?", new MapListHandler(), selectedList.get(0).category);
			selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<NoticeBoardsBean>>() {}.getType());
			NoticeBoardsBean it;
			NoticeBoardsBean next = new NoticeBoardsBean();
			NoticeBoardsBean previous = new NoticeBoardsBean();
			if(selectedList.size() == 1) {
				nextPrevious.add(next);
				nextPrevious.add(previous);
			}else {
				for(int i = 0 ; i < selectedList.size() ; ++i) {
					it = selectedList.get(i);
					if(it.id == Integer.valueOf(id)) { //찾은 경우
						if(i == 0) { //가장 오래된  글일 경우
							next = selectedList.get(i+1);
							next.title = getRemoveHtmlText(next.title);
							nextPrevious.add(next);
							nextPrevious.add(previous);
							break;
						}
						else if(i == (selectedList.size() - 1)) { // 가장 최신 글일 경우
							previous = selectedList.get(i-1);
							previous.title = getRemoveHtmlText(previous.title);
							nextPrevious.add(next);
							nextPrevious.add(previous);
							break;
						}else {// 중간 글일 경우
							next = selectedList.get(i+1);
							previous  = selectedList.get(i-1);
							next.title = getRemoveHtmlText(next.title);
							previous.title = getRemoveHtmlText(previous.title);
							nextPrevious.add(next);
							nextPrevious.add(previous);
							break;
						}
					}
				}
			}
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		if(!nextPrevious.isEmpty()) {
			return nextPrevious;
		}
		else
			return null;
	}

	public String deleteAlreadyFile(String data) {
		String arr[] = data.split("-/-/-"); // 0 = file id 1= user id 2= user type name
		Connection conn=Config.getInstance().sqlLogin();
		NoticeFileBean file = getFile(arr[0]);
		if(!file.writer.equals(arr[1]) && !arr[2].equals("관리자")&&!arr[2].equals("홈페이지관리자"))
			return "error";
		try {
			QueryRunner queryRunner = new QueryRunner();
			queryRunner.update(conn, "UPDATE notice_file SET board_id = -1 WHERE id=?;",arr[0]);
		}
		catch (SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}

		return "success";
	}

	public String alreadyFileDone(String data) {
		String arr[] = data.split("-/-/-"); // 0 = board_id 1=writer_id
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			queryRunner.update(conn,"UPDATE notice_file SET board_id = ? WHERE writer=? AND board_id=-1",arr[0], arr[1]);
		} catch (SQLException se) {
			se.printStackTrace();
			return "fail";
		} finally {
			DbUtils.closeQuietly(conn);
		}

		return "success";
	}

	public String getMainNotes(String data) {
		Connection conn = Config.getInstance().sqlLogin();
		Gson gson = new Gson();
		List<Map<String, Object>> listOfMaps = null;
		int id = 0;
		try {
			QueryRunner queryRunner = new QueryRunner();
			if(Integer.valueOf(data) == 1) id = 41;
			if(Integer.valueOf(data) == 2) id = 51;
			if(Integer.valueOf(data) == 3) id = 46;
			listOfMaps = queryRunner.query(conn, "SELECT * FROM notice_boards WHERE category=? ORDER BY id DESC", new MapListHandler(), id);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		ArrayList<NoticeBoardsBean> lists = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<NoticeBoardsBean>> () {}.getType());
		for(int i = 0 ; i < lists.size() ; ++i) 
			lists.get(i).title = getRemoveHtmlText(lists.get(i).title);
		if(lists.size() >= 9)
			return gson.toJson(lists.subList(0, 9));
		else
			return gson.toJson(lists);
	}

	public ArrayList<NoticeFileBean> getFileBoardId(){
		Connection conn = Config.getInstance().sqlLogin();
		List<Map<String, Object>> listOfMaps = null;
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn,"SELECT board_id FROM notice_file;", new MapListHandler());
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		ArrayList<NoticeFileBean> lists = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<NoticeFileBean>>() {}.getType());
		return lists;
	}

	public ArrayList<NoticeBoardsBean> getBoardsFromWho(String id) {
		Connection conn = Config.getInstance().sqlLogin();
		List<Map<String, Object>> listOfMaps = null;
		Gson gson = new Gson();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn, "SELECT * FROM notice_boards WHERE student_id=?;",new MapListHandler(), id);
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		ArrayList<NoticeBoardsBean> lists = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<NoticeBoardsBean>>() {}.getType());
		return lists;
	}
	
	public ArrayList<NoticeBoardsBean> getCommentsFromWho(String id) {
		Connection conn = Config.getInstance().sqlLogin();
		List<Map<String, Object>> listOfMaps = null;
		Gson gson = new Gson();
		ArrayList<NoticeBoardsBean> results = new ArrayList<>();
		try { 
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn, "SELECT * FROM notice_comments WHERE writer_id=?;",new MapListHandler(), id);
			ArrayList<NoticeCommentsBean> lists = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<NoticeCommentsBean>>() {}.getType());
			for(int i = 0 ; i < lists.size() ; ++i) {
				NoticeBoardsBean thing = it.getBoardRead(lists.get(i).article_id);
				results.add(thing);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		return results;
	}
	
	private String getRemoveHtmlText(String content) {
		if(content == null)
			return null;
		Pattern SCRIPTS = Pattern.compile("<(no)?script[^>]*>.*?</(no)?script>", Pattern.DOTALL);
		Pattern STYLE = Pattern.compile("<style[^>]*>.*</style>", Pattern.DOTALL);
		//Pattern TAGS = Pattern.compile("<(\"[^\"]*\"|\'[^\']*\'|[^\'\">])*>");
		//Pattern nTAGS = Pattern.compile("<\\w+\\s+[^<]*\\s*>");
		Pattern ENTITY_REFS = Pattern.compile("&[^;]+;");
		Pattern WHITESPACE = Pattern.compile("\\s\\s+");
		Pattern WHITE = Pattern.compile("<!--");
		Pattern ON = Pattern.compile("(on)+[a-z]*=");

		Matcher m;

		m = SCRIPTS.matcher(content);
		content = m.replaceAll("");
		m = STYLE.matcher(content);
		content = m.replaceAll("");
		m = ENTITY_REFS.matcher(content);
		content = m.replaceAll("");
		m = WHITESPACE.matcher(content);
		content = m.replaceAll(" ");
		m = WHITE.matcher(content);
		content = m.replaceAll("");
		m = ON.matcher(content);
		content = m.replaceAll("");
		return content;
	}

	public String fixedButton(String status){ // str.fixed-/-/-str.id
		String arr[] = status.split("-/-/-");
		String fixed = arr[0];
		String id = arr[1];
		if(fixed.equals("false")){
			fixed="true";
		}
		else{
			fixed="false";
		}

		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			queryRunner.update(conn, "UPDATE notice_boards SET fixed=? WHERE id=?;", fixed, id);
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		return fixed;
	}
}
