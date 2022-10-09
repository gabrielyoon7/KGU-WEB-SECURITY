package kr.ac.kyonggi.cs.handler.dao.setting;

import java.io.File;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.reflect.TypeToken;

import kr.ac.kyonggi.cs.common.sql.Config;
import kr.ac.kyonggi.cs.handler.vo.BoardLevelBean;
import kr.ac.kyonggi.cs.handler.vo.HeaderMenuBean;
import kr.ac.kyonggi.cs.handler.vo.MenuBean;
import kr.ac.kyonggi.cs.handler.vo.SliderBean;
import kr.ac.kyonggi.cs.handler.vo.TextBean;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;

public class HomeDAO {
	public static HomeDAO it;
	
	public static HomeDAO getInstance() {
		if(it == null)
			it = new HomeDAO();
		return it;
	}
	
   public ArrayList<HeaderMenuBean> getHeaderMenu(){
      List<Map<String, Object>> listOfMaps = null;
      Connection conn = Config.getInstance().sqlLogin();
      try {
         QueryRunner queryRunner = new QueryRunner();
         listOfMaps = queryRunner.query(conn, "SELECT * FROM `fdb_tabs`;", new MapListHandler());
      } catch (SQLException se) {
         se.printStackTrace();
      } finally {
         DbUtils.closeQuietly(conn);
      }
      Gson gson = new Gson();
      ArrayList<HeaderMenuBean> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<HeaderMenuBean>>() {}.getType());
      return selectedList;
   }
   public ArrayList<MenuBean> getMenu(){
      List<Map<String, Object>> listOfMaps = null;
      Connection conn = Config.getInstance().sqlLogin();
      try {
         QueryRunner queryRunner = new QueryRunner();
         listOfMaps = queryRunner.query(conn, "SELECT * FROM `fdb_pages` ORDER BY `tab_id` ASC, `orderNum` ASC;", new MapListHandler());
      } catch (SQLException se) {
         se.printStackTrace();
      } finally {
         DbUtils.closeQuietly(conn);
      }
      Gson gson = new Gson();
      ArrayList<MenuBean> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<MenuBean>>() {}.getType());
      return selectedList;
   }

   public ArrayList<MenuBean> getTrackMenu(String id){
       List<Map<String, Object>> listOfMaps = null;
       Connection conn = Config.getInstance().sqlLogin();
       try {
           QueryRunner queryRunner = new QueryRunner();
           listOfMaps = queryRunner.query(conn, "SELECT * FROM `fdb_pages` where `tab_id` = ? ORDER BY orderNum ASC;", new MapListHandler(), id.substring(0,2));
       } catch (SQLException se) {
           se.printStackTrace();
       } finally {
           DbUtils.closeQuietly(conn);
       }
       Gson gson = new Gson();
       ArrayList<MenuBean> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<MenuBean>>() {}.getType());
       return selectedList;
   }
   
   public ArrayList<MenuBean> getTabMenu(String id){
      List<Map<String, Object>> listOfMaps = null;
      Connection conn = Config.getInstance().sqlLogin();
      try {
         QueryRunner queryRunner = new QueryRunner();
         listOfMaps = queryRunner.query(conn, "SELECT * FROM `fdb_pages` where `tab_id` = ? ORDER BY orderNum ASC;", new MapListHandler(), id.substring(0,1));
      } catch (SQLException se) {
         se.printStackTrace();
      } finally {
         DbUtils.closeQuietly(conn);
      }
      Gson gson = new Gson();
      ArrayList<MenuBean> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<MenuBean>>() {}.getType());
      return selectedList;
   }
   
   public ArrayList<MenuBean> getGrdTabMenu(String num, int id) {// 탭메뉴 관리자/유저 나누기 = id로 구분 = min_level
	   int number = (Integer.valueOf(num)/10);
		List<Map<String, Object>> listOfMaps = null;
		Connection conn = Config.getInstance().sqlLogin();
		try {
			QueryRunner queryRunner = new QueryRunner();
			if(id == 4) //졸업논문 관리자일대
			listOfMaps = queryRunner.query(conn,"SELECT * FROM `fdb_pages` where `tab_id` = ? AND (`show_in_menus` = 1 OR `show_in_menus` = ? OR `show_in_menus` = ? ) ORDER BY orderNum ASC;", new MapListHandler(), number, 3,4);
			else if(id!=0) //교수 1일때
				listOfMaps = queryRunner.query(conn,"SELECT * FROM `fdb_pages` where `tab_id` = ? AND (`show_in_menus` = 1 OR `show_in_menus` = ?) ORDER BY orderNum ASC;",new MapListHandler(),number,id);
			else listOfMaps = null;
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
		Gson gson = new Gson();
		ArrayList<MenuBean> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<MenuBean>>() {
		}.getType());
		
		return selectedList;
	}
   
   public TextBean getText(String id) {
      List<Map<String, Object>> listOfMaps = null;
      Connection conn = Config.getInstance().sqlLogin();
      int num = Integer.valueOf(id);
      try {
         QueryRunner queryRunner = new QueryRunner();
         listOfMaps = queryRunner.query(conn,"SELECT * FROM `text` where `text_id` = ?;", new MapListHandler(), num);
      } catch(SQLException se) {
         se.printStackTrace();
      } finally {
         DbUtils.closeQuietly(conn);
      }
      Gson gson = new Gson();
      ArrayList<TextBean> textList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<TextBean>>() {}.getType());
         if(textList.get(0) !=null)
            return textList.get(0);
      return null;   
   }
   
   public String modifyinfo(String data) {
      String arr[]=data.split("-/-/-");//0=>text_id 1=content
      Connection conn = Config.getInstance().sqlLogin();
      List<Map<String, Object>> listOfMaps = null;
      try {
         QueryRunner queryRunner = new QueryRunner();
         queryRunner.update(conn,"UPDATE text SET content=? WHERE text_id=?;",arr[1],arr[0]);
         listOfMaps = queryRunner.query(conn, "SELECT * FROM text WHERE text_id=? ;",new MapListHandler(),arr[0]);
      } catch (SQLException se) {
         se.printStackTrace();
         return "fail";
      } finally {
         DbUtils.closeQuietly(conn);
      }
      Gson gson = new Gson();
      ArrayList<TextBean> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<TextBean>>() {}.getType());
      return gson.toJson(selectedList.get(0));
   }
   
   public String getOneMenu(String id) {
         List<Map<String, Object>> listOfMaps = null;
         Connection conn = Config.getInstance().sqlLogin();
         try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM `fdb_pages` where `id` = ?;", new MapListHandler(), Integer.parseInt(id));
         } catch (SQLException se) {
            se.printStackTrace();
         } finally {
            DbUtils.closeQuietly(conn);
         }
         Gson gson = new Gson();
         ArrayList<MenuBean> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<MenuBean>>() {}.getType());
         return gson.toJson(selectedList.get(0));
      }
   
   public String modifyMenu(String data) {                           //Static_Page 수정
      List<Map<String, Object>> listOfMaps = null;
      String arr[]=data.split("-/-/-"); //0=title 1=headermenu 2=ordernum 3=id
      Connection conn = Config.getInstance().sqlLogin();
       Gson gson = new Gson();
      try {
         QueryRunner queryRunner = new QueryRunner();
         MenuBean it = gson.fromJson(getOneMenu(arr[3]),MenuBean.class);
         ArrayList<MenuBean> itsTab = getTabMenu(Integer.toString(it.tab_id)); 
         if(it.tab_id==Integer.parseInt(arr[1])&&Math.abs(it.orderNum-Integer.parseInt(arr[2]))==1) {
                 listOfMaps=queryRunner.query(conn,"SELECT * FROM kgcs.fdb_pages WHERE `tab_id`=? AND `orderNum`=?;",new MapListHandler(),Integer.parseInt(arr[1]),Integer.parseInt(arr[2]));
                 ArrayList<MenuBean> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<MenuBean>>() {}.getType());
                 queryRunner.update(conn,"UPDATE `fdb_pages` SET `orderNum`=?  WHERE id=?;",Integer.parseInt(arr[2]),Integer.parseInt(arr[3]));
                 queryRunner.update(conn,"UPDATE `fdb_pages` SET `orderNum`=?  WHERE id=?;",it.orderNum,selectedList.get(0).id);
                 sortedMenu(arr[1]);
         }
             else if(it.tab_id!=Integer.parseInt(arr[1])) {
            	 if(itsTab.size() == 1)
                	 return "fail";
          listOfMaps=queryRunner.query(conn,"SELECT * FROM kgcs.fdb_pages WHERE `tab_id`=? ORDER BY `orderNum` ASC;",new MapListHandler(),Integer.parseInt(arr[1]));
         ArrayList<MenuBean> sortedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<MenuBean>>() {}.getType());
         for(MenuBean M : sortedList) {
            if(M.orderNum>=Integer.parseInt(arr[2])) {
                  queryRunner.update(conn,"UPDATE `fdb_pages` SET `orderNum`=? WHERE id=?",M.orderNum+1,M.id);
            }
         }
          queryRunner.update(conn,"UPDATE `fdb_pages` SET `page_title`=?, `tab_id`=?, `orderNum`=?  WHERE id=?;",arr[0],Integer.parseInt(arr[1]),Integer.parseInt(arr[2]),Integer.parseInt(arr[3]));
          sortedMenu(Integer.toString(it.tab_id));
          sortedMenu(arr[1]);
             }
             else if((it.tab_id==Integer.parseInt(arr[1])&& it.orderNum-Integer.parseInt(arr[2]) <= 0)){
                listOfMaps=queryRunner.query(conn,"SELECT * FROM kgcs.fdb_pages WHERE `tab_id`=? ORDER BY `orderNum` ASC;",new MapListHandler(),arr[1]);
                 ArrayList<MenuBean> sortedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<MenuBean>>() {}.getType());
                 for(MenuBean M : sortedList) {
                   if(M.orderNum>Integer.parseInt(arr[2])) {
                         queryRunner.update(conn,"UPDATE `fdb_pages` SET `orderNum`=? WHERE id=?",M.orderNum+1,M.id);
                   }
                }
                 queryRunner.update(conn,"UPDATE `fdb_pages` SET `page_title`=?, `tab_id`=?, `orderNum`=?  WHERE id=?;",arr[0],Integer.parseInt(arr[1]),Integer.parseInt(arr[2])+1,Integer.parseInt(arr[3]));
                 sortedMenu(arr[1]);
             }
             else if((it.tab_id==Integer.parseInt(arr[1])&& it.orderNum-Integer.parseInt(arr[2]) > 1)) {
                listOfMaps=queryRunner.query(conn,"SELECT * FROM kgcs.fdb_pages WHERE `tab_id`=? ORDER BY `orderNum` ASC;",new MapListHandler(),arr[1]);
                 ArrayList<MenuBean> sortedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<MenuBean>>() {}.getType());
                 for(MenuBean M : sortedList) {
                   if(M.orderNum >= Integer.parseInt(arr[2])) {
                         queryRunner.update(conn,"UPDATE `fdb_pages` SET `orderNum`=? WHERE id=?",M.orderNum+1,M.id);
                   }
                }
                 queryRunner.update(conn,"UPDATE `fdb_pages` SET `page_title`=?, `tab_id`=?, `orderNum`=?  WHERE id=?;",arr[0],Integer.parseInt(arr[1]),Integer.parseInt(arr[2])+1,Integer.parseInt(arr[3]));
                 sortedMenu(arr[1]);
             }
      }catch(SQLException se) {
             se.printStackTrace();
       } finally {
          DbUtils.closeQuietly(conn);
       }
      return "";
      }
   
      public String modifyNoticeMenu(String data) {         //게시판 수정
         List<Map<String, Object>> listOfMaps = null;
         String arr[]=data.split("-/-/-");//0=title 1=header 2=ordernum 3=read_level 4=write_level 5=read_comment_level 6=write_comment_level 7=file_download_level 8=id 
         Connection conn = Config.getInstance().sqlLogin();
       Gson gson= new Gson();
       try {
          QueryRunner queryRunner = new QueryRunner();
          MenuBean it = gson.fromJson(getOneMenu(arr[8]),MenuBean.class);
          ArrayList<MenuBean> itsTab = getTabMenu(Integer.toString(it.tab_id)); 
          if(it.tab_id==Integer.parseInt(arr[1]) && Math.abs(it.orderNum-Integer.parseInt(arr[2])) == 1) {
              listOfMaps=queryRunner.query(conn,"SELECT * FROM kgcs.fdb_pages WHERE `tab_id`=? AND `orderNum`=?;",new MapListHandler(),Integer.parseInt(arr[1]),Integer.parseInt(arr[2]));
              ArrayList<MenuBean> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<MenuBean>>() {}.getType());
              queryRunner.update(conn,"UPDATE `fdb_pages` SET `orderNum`=?  WHERE id=?;",Integer.parseInt(arr[2]),Integer.parseInt(arr[8]));
              queryRunner.update(conn,"UPDATE `board_level` SET `article_name`=?,`read_level`=?, `write_level`=?, `read_comment_level`=?, `write_comment_level`=?, `file_download_level`=? WHERE id=?",arr[0],Integer.parseInt(arr[3]),Integer.parseInt(arr[4]),Integer.parseInt(arr[5]),Integer.parseInt(arr[6]),Integer.parseInt(arr[7]),Integer.parseInt(arr[8]));
              queryRunner.update(conn,"UPDATE `fdb_pages` SET `orderNum`=?  WHERE id=?;",it.orderNum,selectedList.get(0).id);
          }
          else if(it.tab_id!=Integer.parseInt(arr[1])) {
        	  if(itsTab.size() == 1)
              	 return "fail";
          listOfMaps=queryRunner.query(conn,"SELECT * FROM kgcs.fdb_pages WHERE `tab_id`=? ORDER BY `orderNum` ASC;",new MapListHandler(),arr[1]);
          ArrayList<MenuBean> sortedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<MenuBean>>() {}.getType());
          for(MenuBean M : sortedList) {
            if(M.orderNum>=Integer.parseInt(arr[2])) {
               queryRunner.update(conn,"UPDATE `fdb_pages` SET `orderNum`=? WHERE id=?",M.orderNum+1,M.id);
            }
         }
          queryRunner.update(conn,"UPDATE `fdb_pages` SET `page_title`=?, `tab_id`=?, `orderNum`=?  WHERE id=?;",arr[0],Integer.parseInt(arr[1]),Integer.parseInt(arr[2]),Integer.parseInt(arr[8]));
          queryRunner.update(conn,"UPDATE `board_level` SET `article_name`=?, `read_level`=?, `write_level`=?, `read_comment_level`=?, `write_comment_level`=?, `file_download_level`=? WHERE id=?",arr[0],Integer.parseInt(arr[3]),Integer.parseInt(arr[4]),Integer.parseInt(arr[5]),Integer.parseInt(arr[6]),Integer.parseInt(arr[7]),Integer.parseInt(arr[8]));
          sortedMenu(Integer.toString(it.tab_id));
          sortedMenu(arr[1]);
          }
          else if((it.tab_id==Integer.parseInt(arr[1])&&(it.orderNum-Integer.parseInt(arr[2]))<=0)){
             listOfMaps=queryRunner.query(conn,"SELECT * FROM kgcs.fdb_pages WHERE `tab_id`=? ORDER BY `orderNum` ASC;",new MapListHandler(),arr[1]);
              ArrayList<MenuBean> sortedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<MenuBean>>() {}.getType());
              for(MenuBean M : sortedList) {
                if(M.orderNum>Integer.parseInt(arr[2])) {
                   queryRunner.update(conn,"UPDATE `fdb_pages` SET `orderNum`=? WHERE id=?",M.orderNum+1,M.id);
                }
             }
              queryRunner.update(conn,"UPDATE `fdb_pages` SET `page_title`=?, `tab_id`=?, `orderNum`=?  WHERE id=?;",arr[0],Integer.parseInt(arr[1]),Integer.parseInt(arr[2])+1,Integer.parseInt(arr[8]));
              queryRunner.update(conn,"UPDATE `board_level` SET `article_name`=?, `read_level`=?, `write_level`=?, `read_comment_level`=?, `write_comment_level`=?, `file_download_level`=? WHERE id=?",arr[0],Integer.parseInt(arr[3]),Integer.parseInt(arr[4]),Integer.parseInt(arr[5]),Integer.parseInt(arr[6]),Integer.parseInt(arr[7]),Integer.parseInt(arr[8]));
              sortedMenu(arr[1]);
          }
          else if((it.tab_id==Integer.parseInt(arr[1])&&(it.orderNum-Integer.parseInt(arr[2]))>1)){
             listOfMaps=queryRunner.query(conn,"SELECT * FROM kgcs.fdb_pages WHERE `tab_id`=? ORDER BY `orderNum` ASC;",new MapListHandler(),arr[1]);
              ArrayList<MenuBean> sortedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<MenuBean>>() {}.getType());
              for(MenuBean M : sortedList) {
                if(M.orderNum>=Integer.parseInt(arr[2])) {
                   queryRunner.update(conn,"UPDATE `fdb_pages` SET `orderNum`=? WHERE id=?",M.orderNum+1,M.id);
                }
             }
              queryRunner.update(conn,"UPDATE `fdb_pages` SET `page_title`=?, `tab_id`=?, `orderNum`=?  WHERE id=?;",arr[0],Integer.parseInt(arr[1]),Integer.parseInt(arr[2])+1,Integer.parseInt(arr[8]));
              queryRunner.update(conn,"UPDATE `board_level` SET `article_name`=?, `read_level`=?, `write_level`=?, `read_comment_level`=?, `write_comment_level`=?, `file_download_level`=? WHERE id=?",arr[0],Integer.parseInt(arr[3]),Integer.parseInt(arr[4]),Integer.parseInt(arr[5]),Integer.parseInt(arr[6]),Integer.parseInt(arr[7]),Integer.parseInt(arr[8]));
              sortedMenu(arr[1]);
          }
       } catch(SQLException se) {
          se.printStackTrace();
       } finally {
          DbUtils.closeQuietly(conn);
       }
       return "";
      }
      public MenuBean getMenuBean(String num) {               //orderNum과 헤더 메뉴(tab_id)를 이용하여 하나의 메뉴에 대한 정보를 찾는 메소드
            List<Map<String, Object>> listOfMaps = null;
            Connection conn = Config.getInstance().sqlLogin();
            int number= Integer.valueOf(num);
            try {
               QueryRunner queryRunner = new QueryRunner();
               listOfMaps = queryRunner.query(conn, "SELECT * FROM `fdb_pages` where tab_id=? AND orderNum=?;", new MapListHandler(), number/10, number%10);
            } catch (SQLException se) {
               se.printStackTrace();
            } finally {
               DbUtils.closeQuietly(conn);
            }
            Gson gson = new Gson();
            ArrayList<MenuBean> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<MenuBean>>() {}.getType());
            return selectedList.get(0);
         }
         
         public String insertMenu(String data) {                  //Static_Page 추가
            List<Map<String, Object>> listOfMaps = null;
            String arr[]=data.split("-/-/-"); //0=title 1=headermenu 2=ordernum
            Connection conn = Config.getInstance().sqlLogin();
             Gson gson = new Gson();
            try {
               QueryRunner queryRunner = new QueryRunner();
                listOfMaps=queryRunner.query(conn,"SELECT * FROM kgcs.fdb_pages WHERE `tab_id`=? ORDER BY `orderNum` ASC;",new MapListHandler(),Integer.parseInt(arr[1]));
                ArrayList<MenuBean> sortedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<MenuBean>>() {}.getType());
               for(MenuBean M : sortedList) {
                  if(M.orderNum>=Integer.parseInt(arr[2])) {
                     queryRunner.update(conn,"UPDATE `fdb_pages` SET `orderNum`=? WHERE id=?",M.orderNum+1,M.id);
                  }
               }
                queryRunner.update(conn,"INSERT INTO `fdb_pages` (`path`, `page_title`, `tab_id`, `orderNum`) VALUES(?,?,?,?);","information.do",arr[0],Integer.parseInt(arr[1]),Integer.parseInt(arr[2]));
                listOfMaps=queryRunner.query(conn, "SELECT * FROM kgcs.fdb_pages WHERE `page_title`=? AND `tab_id`=? AND`orderNum`=?",new MapListHandler(),arr[0],Integer.parseInt(arr[1]),Integer.parseInt(arr[2]));
                ArrayList<MenuBean> selectedList=gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<MenuBean>>() {}.getType());
                queryRunner.update(conn,"INSERT INTO `text` (`text_id`,`content`) VALUES(?,?)",selectedList.get(0).id,"내용을 입력해주세요");
                sortedMenu(arr[1]);
            }catch(SQLException se) {
                   se.printStackTrace();
             } finally {
                DbUtils.closeQuietly(conn);
             }
            return "";
         }
       
         public String insertNoticeMenu(String data) {            //게시판 추가
            List<Map<String, Object>> listOfMaps = null;
            String arr[]=data.split("-/-/-");//0=title 1=header 2=ordernum 3=read_level 4=write_level 5=read_comment_level 6=write_comment_level 7=file_download_level
          Connection conn = Config.getInstance().sqlLogin();
          Gson gson= new Gson();
          try {
             QueryRunner queryRunner = new QueryRunner();
             listOfMaps=queryRunner.query(conn,"SELECT * FROM kgcs.fdb_pages WHERE `tab_id`=? ORDER BY `orderNum` ASC;",new MapListHandler(),arr[1]);
            ArrayList<MenuBean> sortedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<MenuBean>>() {}.getType());
            for(MenuBean M : sortedList) {
               if(M.orderNum>=Integer.parseInt(arr[2])) {
                  queryRunner.update(conn,"UPDATE `fdb_pages` SET `orderNum`=? WHERE id=?",M.orderNum+1,M.id);
               }
            }
             queryRunner.update(conn,"INSERT INTO `fdb_pages` (`path`, `page_title`, `tab_id`, `orderNum`) VALUES(?,?,?,?);","notice_article_list.do",arr[0],Integer.parseInt(arr[1]),Integer.parseInt(arr[2]));
             queryRunner.update(conn,"INSERT INTO `board_level` (`id`,`article_name`,`read_level`,`write_level`,`read_comment_level`,`write_comment_level`,`file_download_level`) VALUES((SELECT `id` FROM `fdb_pages` WHERE `page_title`=?),?,?,?,?,?,?)",arr[0],arr[0],Integer.parseInt(arr[3]),Integer.parseInt(arr[4]),Integer.parseInt(arr[5]),Integer.parseInt(arr[6]),Integer.parseInt(arr[7]));
             sortedMenu(arr[1]);
          } catch(SQLException se) {
             se.printStackTrace();
          } finally {
             DbUtils.closeQuietly(conn);
          }
          return "";
         }
         
         public void sortedMenu(String id) {                     //메뉴들이 공백없이 위로정렬되게 하는 메소드
            List<Map<String, Object>> listOfMaps = null;
            Connection conn = Config.getInstance().sqlLogin();
             Gson gson= new Gson();
             try {
                 QueryRunner queryRunner = new QueryRunner();
            listOfMaps=queryRunner.query(conn,"SELECT * FROM kgcs.fdb_pages WHERE `tab_id` = ? ORDER BY `orderNum` ASC;",new MapListHandler(),Integer.parseInt(id));
            ArrayList<MenuBean> sortedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<MenuBean>>() {}.getType()); 
             for(int i=0;i<sortedList.size();i++) {
                  queryRunner.update(conn,"UPDATE `fdb_pages` SET `orderNum`=? WHERE id=?",i+1,sortedList.get(i).id);
               }
               listOfMaps=queryRunner.query(conn,"SELECT * FROM kgcs.fdb_pages WHERE `tab_id` = ? ORDER BY `orderNum` ASC;",new MapListHandler(),Integer.parseInt(id));
               sortedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<MenuBean>>() {}.getType());
               String pathName = sortedList.get(0).path+"?num="+sortedList.get(0).tab_id+"1";
               queryRunner.update(conn,"UPDATE `fdb_tabs` SET `tab_url`=? WHERE `tab_id`=?",pathName,sortedList.get(0).tab_id);
             }catch(SQLException se) {
                 se.printStackTrace();
              } finally {
                 DbUtils.closeQuietly(conn);
              }
         }
         
         public String getNumOrder(String data) {               //헤더 메뉴가 가지고있는 하위 메뉴의 갯수찾는 메소드
            List<Map<String, Object>> listOfMaps = null;
            Connection conn = Config.getInstance().sqlLogin();
            try {
                   QueryRunner queryRunner = new QueryRunner();
                   listOfMaps=queryRunner.query(conn,"SELECT * FROM kgcs.fdb_pages WHERE `tab_id` = ?;",new MapListHandler(),Integer.parseInt(data));
                } catch(SQLException se) {
                   se.printStackTrace();
                } finally {
                   DbUtils.closeQuietly(conn);
                }
            Gson gson = new Gson();
            ArrayList<MenuBean> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<MenuBean>>() {}.getType());
            return Integer.toString(selectedList.size());
         }
        
         public String deleteMenu(String id) {            //Static_Page 삭제
            Connection conn = Config.getInstance().sqlLogin();
            Gson gson= new Gson();
            try {
                QueryRunner queryRunner = new QueryRunner();
                MenuBean it = gson.fromJson(getOneMenu(id),MenuBean.class);
                ArrayList<MenuBean> itsTab = getTabMenu(Integer.toString(it.tab_id)); 
                if(itsTab.size() == 1)
               	 return "fail";
                queryRunner.update(conn,"DELETE FROM `fdb_pages` WHERE `id`=?",it.id);
                queryRunner.update(conn,"DELETE FROM `text` WHERE `text_id`=?",it.id);
                sortedMenu(Integer.toString(it.tab_id));
               } catch(SQLException se) {
                   se.printStackTrace();
                } finally {
                   DbUtils.closeQuietly(conn);
                }
            return "";
         }

         public String deleteNoticeMenu(String id) {      //게시판삭제
               Connection conn = Config.getInstance().sqlLogin();
               Gson gson= new Gson();
               try {
                  QueryRunner queryRunner = new QueryRunner();
                  MenuBean it = gson.fromJson(getOneMenu(id),MenuBean.class);
                  ArrayList<MenuBean> itsTab = getTabMenu(Integer.toString(it.tab_id)); 
                  if(itsTab.size() == 1)
                 	 return "fail";
                  queryRunner.update(conn,"DELETE FROM `fdb_pages` WHERE `id`=?",it.id);
                   queryRunner.update(conn,"DELETE FROM `board_level` WHERE `article_name`=?",it.page_title);
                   queryRunner.update(conn, "DELETE FROM `boards` WHERE `category`=?",it.id);
                  sortedMenu(Integer.toString(it.tab_id));
                  } catch(SQLException se) {
                      se.printStackTrace();
                   } finally {
                      DbUtils.closeQuietly(conn);
                   }
               return "";
            }
         
         public BoardLevelBean getBoardLevel(int id) {
               List<Map<String, Object>> listOfMaps = null;
               Connection conn = Config.getInstance().sqlLogin();
               Gson gson= new Gson();
               try {
                  QueryRunner queryRunner = new QueryRunner();
                  listOfMaps = queryRunner.query(conn,"SELECT * FROM `board_level` WHERE `id`=?;", new MapListHandler(), id);
                  } catch(SQLException se) {
                      se.printStackTrace();
                   } finally {
                      DbUtils.closeQuietly(conn);
                   }
               ArrayList<BoardLevelBean> selectedList = gson.fromJson(gson.toJson(listOfMaps),  new TypeToken<List<BoardLevelBean>>() {}.getType());
               return selectedList.get(0);
         }
		
		public void uploadSlider(String uploadFile, String newFileName) {
			Connection conn = Config.getInstance().sqlLogin();
			try {
				QueryRunner queryRunner = new QueryRunner();
				queryRunner.update(conn, "INSERT INTO slider(original_name, real_name) VALUES (?,?);", uploadFile, newFileName);
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				DbUtils.closeQuietly(conn);
			}
		}
		public String deleteSlider(String data) {
			String arr[] = data.split("-/-/-");
			Connection conn = Config.getInstance().sqlLogin();
			List<Map<String, Object>> listOfMaps = null;
			Gson gson = new Gson();
			try {
				QueryRunner queryRunner = new QueryRunner();
				listOfMaps = queryRunner.query(conn, "SELECT * FROM slider WHERE id=?", new MapListHandler(), arr[0]);
				ArrayList<SliderBean> lists = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<SliderBean>> () {}.getType());
				File deleteFile = new File(arr[1], lists.get(0).real_name);
				deleteFile.delete();
				queryRunner.update(conn, "DELETE FROM slider WHERE id=?", arr[0]);
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				DbUtils.closeQuietly(conn);
			}
			return "success";
		}
		
		public String getSliders() {
			Connection conn = Config.getInstance().sqlLogin();
			List<Map<String, Object>> listOfMaps = null;
			Gson gson = new Gson();
			try {
				QueryRunner queryRunner = new QueryRunner();
				listOfMaps = queryRunner.query(conn, "SELECT * FROM slider ORDER BY id DESC", new MapListHandler());
			} catch(SQLException e) {
				e.printStackTrace();
				return "fail";
			} finally {
				DbUtils.closeQuietly(conn);
			}
			ArrayList<SliderBean> lists = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<SliderBean>> () {}.getType());
			return gson.toJson(lists);
		}
		
		public String checkHomeId(String id) {
			Connection conn = Config.getInstance().sqlLogin();
			List<Map<String, Object>> listOfMaps = null;
			Gson gson = new Gson();
			try {
				QueryRunner queryRunner = new QueryRunner();
				listOfMaps = queryRunner.query(conn, "SELECT myhomeid FROM user WHERE myhomeid <> '-';", new MapListHandler());
			} catch(SQLException e) {
				e.printStackTrace();
				return "fail";
			} finally {
				DbUtils.closeQuietly(conn);
			}
			ArrayList<UserBean> lists = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<UserBean>>() {}.getType());
			for(int i = 0 ; i < lists.size() ; ++i) {
				if(lists.get(i).myhomeid.equals(id))
					return "fail";
			}
			return "success";
		}

		public String submitHomeId(String data) {
			String arr[] = data.split("-/-/-"); // 0 homeid 1 userid
			Connection conn = Config.getInstance().sqlLogin();
			if(arr[0].equals("-"))
				return "fail";
			if(arr[0].length() > 20)
				return "fail";
			try {
				QueryRunner queryRunner = new QueryRunner();
				queryRunner.update(conn, "UPDATE user SET myhomeid=? WHERE id=?;",arr[0], arr[1]);
			} catch(SQLException e) {
				e.printStackTrace();
				return "fail";
			} finally {
				DbUtils.closeQuietly(conn);
			}
			return "success";
		}
}