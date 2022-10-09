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
import kr.ac.kyonggi.cs.handler.vo.WebzineBoardsBean;
import kr.ac.kyonggi.cs.handler.vo.WebzineCommentsBean;
import kr.ac.kyonggi.cs.handler.vo.BoardLevelBean;
import kr.ac.kyonggi.cs.handler.vo.GalleryBoardsBean;
import kr.ac.kyonggi.cs.handler.vo.GalleryCommentsBean;
import kr.ac.kyonggi.cs.handler.vo.GalleryImageBean;
import kr.ac.kyonggi.cs.handler.vo.MenuBean;
import kr.ac.kyonggi.cs.handler.vo.NoticeBoardsBean;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;

public class GalleryBoardsDAO {

	public static GalleryBoardsDAO it;

	public static GalleryBoardsDAO getInstance() {
		if(it == null) 
			it = new GalleryBoardsDAO();
		return it;
	}

	public ArrayList<GalleryBoardsBean> getBoards(String id) {
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn, "SELECT * FROM gallery_boards WHERE category=? ORDER BY last_modified DESC;", new MapListHandler(),id);
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		ArrayList<GalleryBoardsBean> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GalleryBoardsBean>>() {}.getType());
		for(int i = 0 ; i < selectedList.size() ; ++i)
			selectedList.get(i).title = getRemoveHtmlText(selectedList.get(i).title);

		return selectedList;
	}

	public void uploadImage(String writer_id, String src, String text) {
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			queryRunner.update(conn, "INSERT INTO gallery_images(writer_id, src, text) VALUES (?, ?, ?);",writer_id,src, text);
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
	}
	public void giveImageBoardID(String writer_id, String board_id) {
		Connection conn=Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			queryRunner.update(conn,"UPDATE gallery_images SET `board_id`= ? WHERE `writer_id` = ? AND `board_id` = 0;",board_id,writer_id);
		}
		catch (SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
	}

	public String deleteImage(String file_name) {
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			queryRunner.update(conn, "DELETE FROM gallery_images WHERE src=?;",file_name);
		} catch (SQLException se) {
			se.printStackTrace();
			return "fail";
		} finally {
			DbUtils.closeQuietly(conn);
		}
		return "success";
	}

	public GalleryImageBean getImage(String file_name) {
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn, "SELECT * FROM gallery_images WHERE src=?", new MapListHandler(),file_name);
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		ArrayList<GalleryImageBean> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GalleryImageBean>>() {}.getType());
		return selectedList.get(0);
	}

	public GalleryBoardsBean getBoard(String id) {
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn, "SELECT * FROM gallery_boards WHERE id=?", new MapListHandler(),id);
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		ArrayList<GalleryBoardsBean> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GalleryBoardsBean>>() {}.getType());
		selectedList.get(0).title = getRemoveHtmlText(selectedList.get(0).title);
		selectedList.get(0).content = getRemoveHtmlText(selectedList.get(0).content);
		return selectedList.get(0);
	}

	public ArrayList<GalleryImageBean> getImages(int id){
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn, "SELECT * FROM gallery_images WHERE board_id=?", new MapListHandler(),id);
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		ArrayList<GalleryImageBean> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GalleryImageBean>>() {}.getType());
		return selectedList;
	}

	public void plusViews(int id) {
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			queryRunner.update(conn, "UPDATE gallery_boards SET view = view + 1 WHERE id=?",id);
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
	}

	public String insertGalleryBoards(String data) {
		String arr[]=data.split("-/-/-"); // 0 writerid 1 name 2 num 3 title 4 content 5=type.board_level
		Gson gson = new Gson();
		MenuBean it = new HomeDAO().getMenuBean(arr[2]);
		List<Map<String, Object>> listOfMaps=null;
		//Date today=new Date();
		String today = dateToString(new Date());
		int board_id;
		Connection conn =Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn, "SELECT * FROM board_level WHERE id = ?", new MapListHandler(),it.id);
			ArrayList<BoardLevelBean> levellist =gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<BoardLevelBean>>() {}.getType());
			if(levellist.get(0).write_level<Integer.parseInt(arr[5])) 
				return "fail";
			queryRunner.update(conn, "INSERT INTO gallery_boards (writer_id,writer_name,category,last_modified,title,content)"
					+ " VALUE(?,?,?,?,?,?);",arr[0],arr[1],it.id,today,arr[3],arr[4]);
			listOfMaps = queryRunner.query(conn, "SELECT * FROM gallery_boards WHERE writer_id=? AND title=? AND content=?;", new MapListHandler(), arr[0],arr[3],arr[4]);
			ArrayList<GalleryBoardsBean> selectedList =gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GalleryBoardsBean>>() {}.getType());
			if(selectedList.size() == 1 ) {
				GalleryBoardsBean it2 = selectedList.get(0);
				board_id = it2.id;
				giveImageBoardID(arr[0], Integer.toString(board_id));
				listOfMaps = queryRunner.query(conn, "SELECT * FROM gallery_images WHERE board_id = ?", new MapListHandler(), board_id);
				ArrayList<GalleryImageBean> selectedImageList =gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GalleryImageBean>>() {}.getType());
				GalleryImageBean it3 = selectedImageList.get(0);
				queryRunner.update(conn, "UPDATE gallery_boards SET img=? WHERE id=?",it3.src,board_id);
			}

		} catch (SQLException se) {
			se.printStackTrace();
			return "fail";
		} finally {
			DbUtils.closeQuietly(conn);
		}
		return "success";
	}

	public ArrayList<GalleryBoardsBean> getNextPrevious(String id){
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		ArrayList<GalleryBoardsBean> nextPrevious = new ArrayList<>();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn, "SELECT * FROM gallery_boards WHERE id=?", new MapListHandler(), id);
			Gson gson = new Gson();
			ArrayList<GalleryBoardsBean> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GalleryBoardsBean>>() {}.getType());
			listOfMaps = queryRunner.query(conn, "SELECT * FROM gallery_boards WHERE category = ?", new MapListHandler(), selectedList.get(0).category);
			selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GalleryBoardsBean>>() {}.getType());
			GalleryBoardsBean it;
			GalleryBoardsBean next = new GalleryBoardsBean();
			GalleryBoardsBean previous = new GalleryBoardsBean();
			if(selectedList.size() == 1) {
				nextPrevious.add(next);
				nextPrevious.add(previous);
			}
			else {
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

	public String insertComments(String data) {
		String arr[]=data.split("-/-/-"); //0 = id  1 = name 2 = article_id  3 = content
		//Date today = new Date();
		String today = dateToString(new Date());
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			queryRunner.update(conn, "INSERT INTO gallery_comments(writer_id, writer_name, board_id, last_modified, content) VALUES (?,?,?,?,?) ;",arr[0],arr[1],arr[2], today, arr[3]);
			queryRunner.update(conn,"UPDATE gallery_boards SET comments_count = comments_count + 1 WHERE id=?",arr[2]);
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		return "";
	}

	public String getComments(String data){
		String arr[]=data.split("-/-/-"); //0=id 1=type.board_level
		List<Map<String, Object>> listOfMaps = null;
		Gson gson = new Gson();
		Connection conn= Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn, "SELECT * FROM gallery_boards WHERE id=? ;",new MapListHandler(),arr[0]);
			ArrayList<GalleryBoardsBean> list = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GalleryBoardsBean>>() {}.getType());
			int menuID = list.get(0).category;
			listOfMaps = queryRunner.query(conn, "SELECT * FROM board_level WHERE id=? ;",new MapListHandler(),menuID);
			ArrayList<BoardLevelBean> levellist = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<BoardLevelBean>>() {}.getType());
			if(levellist.get(0).read_comment_level<Integer.parseInt(arr[1]))
				return null;
			listOfMaps = queryRunner.query(conn, "SELECT * FROM gallery_comments WHERE board_id=? ;",new MapListHandler(),arr[0]);
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			DbUtils.closeQuietly(conn);
		}
		ArrayList<GalleryCommentsBean> selectedList =gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GalleryCommentsBean>>() {}.getType());
		for(int i = 0 ; i < selectedList.size() ; ++i) 
			selectedList.get(i).content = getRemoveHtmlText(selectedList.get(i).content);
		return gson.toJson(selectedList);
	}

	public String deleteComments(String data) {
		String[] arr = data.split("-/-/-");//0 = id 1 = user_id 2= user_type
		Connection conn =Config.getInstance().sqlLogin();   
		List<Map<String,Object>> listOfMaps = null;
		try {
			Gson gson = new Gson();
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn, "SELECT * FROM gallery_comments WHERE id = ?", new MapListHandler(), arr[0]);
			ArrayList<GalleryCommentsBean> list = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GalleryCommentsBean>>() {}.getType());
			GalleryCommentsBean it = list.get(0);
			if(!it.writer_id.equals(arr[1]))
				if(!arr[2].equals("관리자")&&!arr[2].equals("홈페이지관리자"))
					return "fail";
			queryRunner.update(conn, "DELETE FROM gallery_comments WHERE id=? ;",arr[0]);
			queryRunner.update(conn, "UPDATE gallery_boards SET comments_count = comments_count - 1 WHERE id=?", it.board_id);
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		return "1";
	}

	public String updateComments(String data) {
		String arr[]=data.split("-/-/-");//0=id 1=content 2= userid 3=usertype;
		Connection conn =Config.getInstance().sqlLogin();
		List<Map<String,Object>> listOfMaps = null;
		try {
			Gson gson = new Gson();
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn, "SELECT * FROM gallery_comments WHERE id=?", new MapListHandler(), arr[0]);
			ArrayList<GalleryCommentsBean> list = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GalleryCommentsBean>>() {}.getType());
			GalleryCommentsBean it = list.get(0);
			if(!it.writer_id.equals(arr[2]))
				if(!arr[3].equals("관리자")&&!arr[3].equals("홈페이지관리자"))
					return "fail";
			queryRunner.update(conn, "UPDATE gallery_comments SET content=? WHERE id=? ;",arr[1],arr[0]);
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		return "";
	}

	public void deleteBoards(String id) {
		Connection conn= Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			queryRunner.update(conn, "DELETE FROM gallery_boards WHERE id=?;", id);
			queryRunner.update(conn, "DELETE FROM gallery_comments WHERE board_id=?;", id);
			queryRunner.update(conn, "DELETE FROM gallery_images WHERE board_id=?;", id);
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			DbUtils.closeQuietly(conn);
		}
	}

	public String deleteImageModify(String data) {
		String arr[] = data.split("-/-/-"); // 0=imagename 1=boardid 2=userid 3=usertypename
		GalleryBoardsBean check = getBoard(arr[1]);
		if(!check.writer_id.equals(arr[2]) && !arr[3].equals("관리자")&&!arr[3].equals("홈페이지관리자"))
			return "fail";
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			queryRunner.update(conn, "UPDATE gallery_images SET board_id = -1 WHERE src=?;", arr[0]);
		} catch (SQLException e){
			e.printStackTrace();
			return "fail";
		}
		return "success";
	}

	public String deleteImageModifyExit(String data) {
		String arr[] = data.split("-/-/-"); //0=boardID 1=userid 2=usertypename
		GalleryBoardsBean check = getBoard(arr[0]);
		if(!check.writer_id.equals(arr[1]) && !arr[2].equals("관리자")&&!arr[2].equals("홈페이지관리자"))
			return "fail";
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			queryRunner.update(conn, "UPDATE gallery_images SET board_id = ? WHERE board_id=-1 AND writer_id=?;", arr[0],check.writer_id);
		} catch(SQLException e) {
			e.printStackTrace();
			return "fail";
		}
		return "success";
	}

	public String modifyBoard(String data) {
		String arr[] = data.split("-/-/-");// 0 =title 1=content 2=board_id 3=userid 4=usertypename 5 = path
		GalleryBoardsBean check = getBoard(arr[2]);
		if(!check.writer_id.equals(arr[3]) && !arr[4].equals("관리자")&&!arr[4].equals("홈페이지관리자"))
			return "fail";
		Connection conn = Config.getInstance().sqlLogin();
		Gson gson = new Gson();
		try {
			QueryRunner queryRunner = new QueryRunner();
			queryRunner.update(conn, "UPDATE gallery_boards SET title=?, content=? WHERE id=? AND writer_id=?;", arr[0], arr[1], arr[2], check.writer_id);
			List<Map<String,Object>> listOfMaps = queryRunner.query(conn, "SELECT * FROM gallery_images WHERE board_id=-1 AND writer_id=?;",new MapListHandler(), check.writer_id);
			ArrayList<GalleryImageBean> lists = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GalleryImageBean>> () {}.getType());
			for(int i = 0 ; i < lists.size() ; ++i) {
				File deleteFile = new File(arr[5], lists.get(i).src);
				deleteFile.delete();
				deleteImage(lists.get(i).src);
			}      
			queryRunner.update(conn,"UPDATE gallery_images SET board_id=? WHERE board_id=0 AND writer_id=?;", arr[2], check.writer_id);
			listOfMaps = queryRunner.query(conn, "SELECT * FROM gallery_images WHERE board_id=? ORDER BY id",new MapListHandler(), arr[2]);
			lists = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GalleryImageBean>>() {}.getType());
			queryRunner.update(conn, "UPDATE gallery_boards SET img=? WHERE id=?;", lists.get(0).src, arr[2]);
		} catch(SQLException e) {
			e.printStackTrace();
			return "fail";
		}
		return "success";
	}
	
	public ArrayList<GalleryBoardsBean> getBoardsFromWho(String id) {
		Connection conn = Config.getInstance().sqlLogin();
		List<Map<String, Object>> listOfMaps = null;
		Gson gson = new Gson();
		try {
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn, "SELECT * FROM gallery_boards WHERE writer_id=?;",new MapListHandler(), id);
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		ArrayList<GalleryBoardsBean> lists = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GalleryBoardsBean>>() {}.getType());
		return lists;
	}
	
	public ArrayList<GalleryBoardsBean> getCommentsFromWho(String id) {
		Connection conn = Config.getInstance().sqlLogin();
		List<Map<String, Object>> listOfMaps = null;
		Gson gson = new Gson();
		ArrayList<GalleryBoardsBean> results = new ArrayList<>();
		try { 
			QueryRunner queryRunner = new QueryRunner();
			listOfMaps = queryRunner.query(conn, "SELECT * FROM gallery_comments WHERE writer_id=?;",new MapListHandler(), id);
			ArrayList<GalleryCommentsBean> lists = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<GalleryCommentsBean>>() {}.getType());
			for(int i = 0 ; i < lists.size() ; ++i) {
				GalleryBoardsBean thing = it.getBoard(Integer.toString(lists.get(i).board_id));
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
	
	//jong hun
		//db에 날짜를 옮길때 발생한 오류(190314)
		public static String dateToString(Date date) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
			return sdf.format(date);
		}
}
