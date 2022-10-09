package kr.ac.kyonggi.cs.v2.handler.dao.main;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.ac.kyonggi.cs.common.sql.Config;
import kr.ac.kyonggi.cs.handler.vo.ScheduleBean;
import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

public class ScheduleDAO {
    public static kr.ac.kyonggi.cs.handler.dao.setting.ScheduleDAO it;

    public static kr.ac.kyonggi.cs.handler.dao.setting.ScheduleDAO getInstance() {
        if(it == null)
            it = new kr.ac.kyonggi.cs.handler.dao.setting.ScheduleDAO();
        return it;
    }


    public ArrayList<ScheduleBean> getSchedule() {// 일정리스트
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM `schedule` ORDER by `date` ASC;", new MapListHandler());
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<ScheduleBean> selectedList = gson.fromJson(gson.toJson(listOfMaps),
                new TypeToken<List<ScheduleBean>>() {
                }.getType());
        return selectedList;
    }

    public String getOneSchedule(String data) {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM `schedule` WHERE `index`=?", new MapListHandler(),
                    Integer.parseInt(data));
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<ScheduleBean> results = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<ScheduleBean>>() {
        }.getType());
        return gson.toJson(results.get(0));
    }

    public String modifySchedule(String data) {
        String arr[] = data.split("-/-/-");// 0=index 1=date 2=content
        Connection conn = Config.getInstance().sqlLogin();
        List<Map<String, Object>> listOfMaps = null;
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn, "UPDATE `schedule` SET `date`=?, `content`=? WHERE `index`=?;", arr[1], arr[2],
                    Integer.parseInt(arr[0]));
            listOfMaps = queryRunner.query(conn, "SELECT * FROM `schedule` WHERE `index`=?", new MapListHandler(),
                    Integer.parseInt(arr[0]));
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<ScheduleBean> results = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<ScheduleBean>>() {
        }.getType());
        return gson.toJson(results.get(0));
    }

    public String deleteSchedule(String data) {
        Connection conn = Config.getInstance().sqlLogin();

        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn, "DELETE FROM schedule WHERE `index`=?;", Integer.parseInt(data));
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }

        return "";
    }

    public String insertSchedule(String data) {
        String arr[] = data.split("-/-/-");// 0=date 1=content
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn, "INSERT INTO schedule(date,content) VALUES(?,?);",arr[0], arr[1]);
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        return "";
    }
    public String updateSchedule() {
        Date today = new Date();
        Connection conn = Config.getInstance().sqlLogin();
        QueryRunner queryRunner = new QueryRunner();
        ArrayList<ScheduleBean> selectedList = this.getSchedule();
        try {
            for (ScheduleBean S : selectedList) {
                if (((S.date.getTime() - today.getTime()) / (24 * 60 * 60 * 1000)) < 0) {

                    queryRunner.update(conn, "DELETE FROM `schedule` WHERE `index`=?;", S.index);

                }
            }
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "";
    }
}
