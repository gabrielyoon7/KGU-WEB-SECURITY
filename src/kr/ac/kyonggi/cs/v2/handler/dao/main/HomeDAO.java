package kr.ac.kyonggi.cs.v2.handler.dao.main;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.ac.kyonggi.cs.common.sql.Config;
import kr.ac.kyonggi.cs.handler.vo.*;
import kr.ac.kyonggi.cs.v2.handler.dto.main.MainDTO;
import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class HomeDAO {
    public static HomeDAO it;

    public static HomeDAO getInstance() {
        if(it == null)
            it = new HomeDAO();
        return it;
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

    public MainDTO getMain(String id, String major) {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
//        int num = Integer.valueOf(id);
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn,"SELECT * FROM `v2_text` where `id` = ? AND `major` = ?;", new MapListHandler(), id, major);
        } catch(SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<MainDTO> textList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<MainDTO>>() {}.getType());
        if(textList.get(0) !=null)
            return textList.get(0);
        return null;
    }

    public String modifyinfo(String data) {
//        System.out.println(data);
        String arr[]=data.split("-/-/-");//0:major, 1:id, 2:content
        String major=arr[0];
        String id=arr[1];
        String content=arr[2];
        Connection conn = Config.getInstance().sqlLogin();
        List<Map<String, Object>> listOfMaps = null;
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,"UPDATE v2_text SET content=? WHERE major =? AND id=?;",content,major,id);
            listOfMaps = queryRunner.query(conn, "SELECT * FROM v2_text WHERE major =? AND id=? ;",new MapListHandler(),major,id);
        } catch (SQLException se) {
            se.printStackTrace();
            return "fail";
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<MainDTO> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<MainDTO>>() {}.getType());
        return gson.toJson(selectedList.get(0));
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

    public ArrayList<HeaderMenuBean> getTitleName(String id){
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        int num= Integer.valueOf(id);
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM `fdb_tabs` where 'tab_id' = ? ;", new MapListHandler(), num%10);
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<HeaderMenuBean> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<HeaderMenuBean>>() {}.getType());
        return selectedList;
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

}