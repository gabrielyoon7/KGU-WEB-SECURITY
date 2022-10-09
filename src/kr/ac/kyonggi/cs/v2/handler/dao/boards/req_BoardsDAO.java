package kr.ac.kyonggi.cs.v2.handler.dao.boards;

import java.io.File;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import kr.ac.kyonggi.cs.common.sql.Config;
import kr.ac.kyonggi.cs.handler.vo.req_AnswerBean;
import kr.ac.kyonggi.cs.handler.vo.req_AnswerFileBean;
import kr.ac.kyonggi.cs.handler.vo.req_BoardsBean;
import kr.ac.kyonggi.cs.handler.vo.req_QuestionBean;
import kr.ac.kyonggi.cs.handler.vo.req_WriterFileBean;

public class req_BoardsDAO {
    public static req_BoardsDAO it;

    public static req_BoardsDAO getInstance() {
        if(it == null)
            it = new req_BoardsDAO();
        return it;
    }


    public ArrayList<req_BoardsBean> getBoards() {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM req_boards ORDER BY id DESC;", new MapListHandler());
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<req_BoardsBean> selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<req_BoardsBean>>() {}.getType());
        for(int i = 0 ; i < selectedList.size() ; ++i)
            selectedList.get(i).title = getRemoveHtmlText(selectedList.get(i).title);
        return selectedList;
    }

    public req_BoardsBean getBoardRead(int id) {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM req_boards WHERE id=?;", new MapListHandler(), id);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<req_BoardsBean> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<req_BoardsBean>>() {}.getType());
        selected.get(0).title = getRemoveHtmlText(selected.get(0).title);
        selected.get(0).content = getRemoveHtmlText(selected.get(0).content);
        return selected.get(0);
    }

    public String insertBoards(String data) {
        String arr[] = data.split("-/-/-");// 0=student_id 1=name 2=title 3=startingDate 4=closingDate 5=Content 6=대상레벨
        // 7=forWho 8=questions(다시 나눠줄 필요 있음) 9=type.board_level
        String ques[] = arr[8].split("-/#/-");// 문제구분 -/#/- 문제의 종류와 내용 구분 -/!/- 질문과보기 구분은 -/@/-
        Gson gson = new Gson();
        Connection conn = Config.getInstance().sqlLogin();
        List<Map<String, Object>> listOfMaps = null;
        String id = "fail";
        try {
            QueryRunner queryRunner = new QueryRunner();
            if (3 < Integer.parseInt(arr[9]))
                return "fail";
            queryRunner.update(conn,
                    "INSERT INTO req_boards(student_id, student_name, title, starting_date, closing_date, content, level, for_who) VALUES (?,?,?,?,?,?,?,?);",
                    arr[0], arr[1], arr[2], arr[3], arr[4], arr[5], arr[6], arr[7]);
            listOfMaps = queryRunner.query(conn,
                    "SELECT * FROM req_boards WHERE student_id=? AND title=? AND starting_date=? AND closing_date=? AND content=? AND level=? AND for_who=?;",
                    new MapListHandler(), arr[0], arr[2], arr[3], arr[4], arr[5], arr[6], arr[7]);
            ArrayList<req_BoardsBean> array = gson.fromJson(gson.toJson(listOfMaps),
                    new TypeToken<List<req_BoardsBean>>() {
                    }.getType());
            req_BoardsBean it = array.get(0);
            id = Integer.toString(it.id);
            for (int i = 0; i < ques.length; i++) {
                String text[] = ques[i].split("-/!/-");
                String type = text[0];
                String content = text[1];
                queryRunner.update(conn,
                        "INSERT INTO req_question(board_number, question_number, question_content, question_type) VALUES (?,?,?,?);",
                        it.id, i + 1, content, Integer.valueOf(type));
            }
            queryRunner.update(conn, "UPDATE req_writer_files SET board_id=? WHERE board_id=0 AND writer_id=?", id,
                    arr[0]);
        } catch (SQLException se) {
            se.printStackTrace();
            return "fail";
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return id;
    }

    public String modifyBoards(String data) {
        String arr[] = data.split("-/-/-");// 0 writer id 1 title 2 startDate 3 finishDate 4 content 5 level 6 forWho 7
        // <%board%>.id 8 type.typename 9 path;
        Gson gson = new Gson();
        Connection conn = Config.getInstance().sqlLogin();
        List<Map<String, Object>> listOfMaps = null;
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM req_boards WHERE id=?;", new MapListHandler(), arr[7]);
            ArrayList<req_BoardsBean> array = gson.fromJson(gson.toJson(listOfMaps),
                    new TypeToken<List<req_BoardsBean>>() {
                    }.getType());
            req_BoardsBean it = array.get(0);
            if (!it.student_id.equals(arr[0]) && !arr[8].equals("관리자") && !arr[8].equals("홈페이지관리자"))
                return "fail";
            queryRunner.update(conn,
                    "UPDATE req_boards SET title=?, starting_date=?, closing_date=?, content=?, level=?, for_who=? WHERE id=?;",
                    arr[1], arr[2], arr[3], arr[4], arr[5], arr[6], arr[7]);
            queryRunner.update(conn, "UPDATE req_writer_files SET board_id=? WHERE board_id=0 AND writer_id=?", it.id,
                    it.student_id);
            listOfMaps = queryRunner.query(conn, "SELECT * FROM req_writer_files WHERE board_id = -1 AND writer_id = ?",
                    new MapListHandler(), it.student_id);
            ArrayList<req_WriterFileBean> lists = gson.fromJson(gson.toJson(listOfMaps),
                    new TypeToken<List<req_WriterFileBean>>() {
                    }.getType());
            for (int i = 0; i < lists.size(); ++i) {
                File deleteFile = new File(arr[9], lists.get(i).real_name);
                deleteFile.delete();
                deleteWriterFile(lists.get(i).id);
            }
        } catch (SQLException se) {
            se.printStackTrace();
            return "fail";
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public ArrayList<req_QuestionBean> getQuestions(String data) {
        String arr[] = data.split("-/-/-");// 0= id 1=type.for_header 2= user.id 3= type.board_level
        List<Map<String, Object>> listOfMaps = null;
        Gson gson = new Gson();
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM req_boards WHERE id=?;", new MapListHandler(), arr[0]);
            ArrayList<req_BoardsBean> reqList = gson.fromJson(gson.toJson(listOfMaps),
                    new TypeToken<List<req_BoardsBean>>() {
                    }.getType());
            if (!reqList.get(0).student_id.equals(arr[2]) && !reqList.get(0).level.contains(arr[1]) && Integer.valueOf(arr[3]) != 0)
                return null;
            listOfMaps = queryRunner.query(conn, "SELECT * FROM req_question WHERE board_number=? ORDER BY question_number;", new MapListHandler(), arr[0]);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        ArrayList<req_QuestionBean> selected = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<req_QuestionBean>>() {}.getType());
        for(int i = 0 ; i < selected.size() ; ++i)
            selected.get(i).question_content = getRemoveHtmlText(selected.get(i).question_content);
        return selected;
    }

    public String insertAnswers(String data) {
        String arr[] = data.split("-/-/-");// 0= userName 1=userid 2=per_id 3=grade 4=type 5=board_number 6=answers 7= question개수
        String answers[] = arr[6].split("-/#/-"); // answer별 구분자 -/#/- 다중객관식은 그냥 answer에 구분자쨰로 넣고 유념해야할듯.
        if(arr[2].equals("null"))
            arr[2] = "-";
        if(arr[3].equals("null"))
            arr[3] = "-";
        Connection conn = Config.getInstance().sqlLogin();
        boolean result = false;
        List<Map<String, Object>> listOfMaps = null;
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM req_answer WHERE user_id=? AND board_number=?;",
                    new MapListHandler(), arr[1], arr[5]);
            if (listOfMaps.size() > 0)
                return "already";
            for (int i = 0; i < answers.length; i++) {
                queryRunner.update(conn,
                        "INSERT INTO req_answer(user_name, user_id, user_per_id, user_grade, user_job, question_number,board_number, answer) VALUES(?,?,?,?,?,?,?,?);",
                        arr[0], arr[1], arr[2], arr[3], arr[4], (i + 1), arr[5], answers[i]);
            }
            for (int j = answers.length ; j < Integer.valueOf(arr[7]) ; ++j) {
                queryRunner.update(conn,
                        "INSERT INTO req_answer(user_name, user_id, user_per_id, user_grade, user_job, question_number,board_number, answer) VALUES(?,?,?,?,?,?,?,?);",
                        arr[0], arr[1], arr[2], arr[3], arr[4], (j + 1), arr[5], "");
            }
            queryRunner.update(conn, "UPDATE req_boards SET `views`= `views`+1 WHERE `id` = ?;", arr[5]);
            result = true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        if (result)
            return "success";
        else
            return "fail";
    }

    public String whoAnswerIt(String data) {
        String arr[] = data.split("-/-/-");// 0= board_number 1= user_id
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM req_answer WHERE board_number=? AND user_id=?;",
                    new MapListHandler(), arr[0], arr[1]);
        } catch (SQLException e) {
            e.printStackTrace();
            return "fail";
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        ArrayList<req_AnswerBean> list = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<req_AnswerBean>>() {}.getType());
        for(int i = 0 ; i < list.size() ; ++i)
            list.get(i).answer = getRemoveHtmlText(list.get(i).answer);
        if (!list.isEmpty())
            return gson.toJson(list);
        else
            return "empty";
    }

    public String deleteWhoAnswer(String data) {
        String arr[] = data.split("-/-/-");// 0= board_number 1= user_name 2=user_per_id 3=user_grade 4 = user_id
        // realPath
        Connection conn = Config.getInstance().sqlLogin();
        Gson gson = new Gson();
        List<Map<String, Object>> listOfMaps = null;
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM req_answer WHERE board_number=? AND user_id=?", new MapListHandler(), arr[0],arr[4]);
            ArrayList<req_AnswerBean> reqList = gson.fromJson(gson.toJson(listOfMaps),new TypeToken<List<req_AnswerBean>>() {}.getType());
            if (!reqList.get(0).user_id.equals(arr[4]))
                return null;
            queryRunner.update(conn, "DELETE FROM req_answer WHERE board_number=? AND user_id=?;", arr[0], arr[4]);
            listOfMaps = queryRunner.query(conn, "SELECT * FROM req_answer_files WHERE board_id=? AND user_id=?;",
                    new MapListHandler(), arr[0], arr[4]);
            ArrayList<req_AnswerFileBean> files = gson.fromJson(gson.toJson(listOfMaps),
                    new TypeToken<List<req_AnswerFileBean>>() {}.getType());
            for (int i = 0; i < files.size(); ++i) {
                req_AnswerFileBean it = files.get(i);
                File deleteFile = new File(arr[5], it.real_name);
                deleteFile.delete();
                queryRunner.update(conn, "DELETE FROM req_answer_files WHERE board_id=? AND user_id=?;", arr[0], arr[1]);
            }
            queryRunner.update(conn, "UPDATE req_boards SET `views`=`views`-1 WHERE `id` = ?;", arr[0]);
        } catch (SQLException e) {
            e.printStackTrace();
            return "fail";
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public String removeQuestion(String data) {
        String arr[] = data.split("-/-/-"); // 0= board_id 1=realPath
        Connection conn = Config.getInstance().sqlLogin();
        List<Map<String, Object>> listOfMaps = null;
        Gson gson = new Gson();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn, "DELETE FROM req_answer WHERE board_number=?;", arr[0]);
            queryRunner.update(conn, "DELETE FROM req_question WHERE board_number=?;", arr[0]);
            queryRunner.update(conn, "DELETE FROM req_boards WHERE id=?;", arr[0]);
            queryRunner.update(conn, "DELETE FROM req_answer_files WHERE board_id=?;", arr[0]);
            listOfMaps = queryRunner.query(conn, "SELECT * FROM req_writer_files WHERE board_id=?",new MapListHandler(),arr[0]);
            File deleteFile = new File(arr[1]+"/"+arr[0]);
            File[] tempFile = deleteFile.listFiles();
            for (int i = 0; i < tempFile.length; i++) {
                tempFile[i].delete();
            }
            deleteFile.delete();
            ArrayList<req_WriterFileBean> lists = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<req_WriterFileBean>>() {}.getType());
            for(int i = 0 ; i < lists.size() ; ++i) {
                File delFile = new File(arr[1],lists.get(i).real_name);
                delFile.delete();
            }
            queryRunner.update(conn, "DELETE FROM req_writer_files WHERE board_id=?;", arr[0]);
        } catch (SQLException e) {
            e.printStackTrace();
            return "fail";
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public ArrayList<req_AnswerBean> getResult(String id) {
        Gson gson = new Gson();
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn,
                    "SELECT * FROM req_answer WHERE board_number=? ORDER BY user_name, question_number;",
                    new MapListHandler(), id);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            DbUtils.closeQuietly(conn);
        }
        ArrayList<req_AnswerBean> it = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<req_AnswerBean>>() {}.getType());
        for(int i = 0 ; i < it.size() ; ++i)
            it.get(i).answer = getRemoveHtmlText(it.get(i).answer);
        return it;
    }

    public void uploadAnswerFile(String id, String uploadFile, String newFileName, String user_id, String boardNumber) {
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,
                    "INSERT INTO req_answer_files(id,original_name,real_name,user_id,board_id) VALUES (?,?,?,?,?);", id,
                    uploadFile, newFileName, user_id, boardNumber);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
    }

    public req_AnswerFileBean getFile(String id) {
        Gson gson = new Gson();
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM req_answer_files WHERE id=?", new MapListHandler(), id);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            DbUtils.closeQuietly(conn);
        }
        ArrayList<req_AnswerFileBean> it = gson.fromJson(gson.toJson(listOfMaps),
                new TypeToken<List<req_AnswerFileBean>>() {
                }.getType());
        return it.get(0);
    }

    public void uploadWriterFile(String id, String original_name, String real_name, String writer_id) {
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            queryRunner.update(conn,
                    "INSERT INTO req_writer_files(id,original_name,real_name,writer_id) VALUES (?,?,?,?);", id,
                    original_name, real_name, writer_id);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
    }

    public req_WriterFileBean deleteWriterFile(String id) {
        Connection conn = Config.getInstance().sqlLogin();
        List<Map<String, Object>> listOfMaps = null;
        Gson gson = new Gson();
        req_WriterFileBean it = null;
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM req_writer_files WHERE id = ?", new MapListHandler(),
                    id);
            ArrayList<req_WriterFileBean> list = gson.fromJson(gson.toJson(listOfMaps),
                    new TypeToken<List<req_WriterFileBean>>() {
                    }.getType());
            it = list.get(0);
            queryRunner.update(conn, "DELETE FROM req_writer_files WHERE id = ?", id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return it;
    }

    public ArrayList<req_WriterFileBean> getWriterFiles(String writer_id, String board_id) {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        Gson gson = new Gson();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM req_writer_files WHERE writer_id=? AND board_id=?",
                    new MapListHandler(), writer_id, board_id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        ArrayList<req_WriterFileBean> lists = gson.fromJson(gson.toJson(listOfMaps),
                new TypeToken<List<req_WriterFileBean>>() {
                }.getType());
        return lists;
    }

    public ArrayList<req_WriterFileBean> readFile(int id) {
        ArrayList<req_WriterFileBean> selectedList = null;
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM req_writer_files WHERE board_id=?",
                    new MapListHandler(), id);
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        Gson gson = new Gson();
        selectedList = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<req_WriterFileBean>>() {
        }.getType());
        return selectedList;
    }

    public req_WriterFileBean getWriterFile(String id) {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        Gson gson = new Gson();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM req_writer_files WHERE id=?;", new MapListHandler(),
                    id);
            ArrayList<req_WriterFileBean> lists = gson.fromJson(gson.toJson(listOfMaps),
                    new TypeToken<List<req_WriterFileBean>>() {
                    }.getType());
            if (lists.size() == 1)
                return lists.get(0);
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return null;
    }

    public String deleteAlreadyFile(String data) {
        String arr[] = data.split("-/-/-"); // 0 data 1 id 2 type.type_name
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        Gson gson = new Gson();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM req_writer_files WHERE id=?;", new MapListHandler(),
                    arr[0]);
            ArrayList<req_WriterFileBean> lists = gson.fromJson(gson.toJson(listOfMaps),
                    new TypeToken<List<req_WriterFileBean>>() {
                    }.getType());
            req_WriterFileBean it = lists.get(0);
            if (!it.writer_id.equals(arr[1]) && !arr[2].equals("관리자") && !arr[2].equals("홈페이지"))
                return "fail";
            queryRunner.update(conn, "UPDATE req_writer_files SET board_id = -1 WHERE id=?", arr[0]);
        } catch (SQLException se) {
            se.printStackTrace();
            return "fail";
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public String alreadyFileExit(String data) {
        String arr[] = data.split("-/-/-"); // 0 boardid 1 id 2 type.type_name
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        Gson gson = new Gson();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT * FROM req_boards WHERE id=?;", new MapListHandler(), arr[0]);
            ArrayList<req_BoardsBean> lists = gson.fromJson(gson.toJson(listOfMaps),
                    new TypeToken<List<req_BoardsBean>>() {
                    }.getType());
            req_BoardsBean it = lists.get(0);
            if (!it.student_id.equals(arr[1]) && !arr[2].equals("관리자") && !arr[2].equals("홈페이지관리자"))
                return "fail";
            queryRunner.update(conn, "UPDATE req_writer_files SET board_id = ? WHERE board_id=-1 AND writer_id=?",
                    arr[0], it.student_id);
        } catch (SQLException se) {
            se.printStackTrace();
            return "fail";
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return "success";
    }

    public String getMainBoards() {
        List<Map<String, Object>> listOfMaps = null;
        Connection conn = Config.getInstance().sqlLogin();
        Gson gson = new Gson();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn,
                    "SELECT * FROM req_boards WHERE date_add(closing_date,interval +1 day ) > ? ORDER BY closing_date",
                    new MapListHandler(), new Date());
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            DbUtils.closeQuietly(conn);
        }
        ArrayList<req_BoardsBean> lists = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<req_BoardsBean>>() {}.getType());
        for(int i = 0 ; i < lists.size() ; ++i)
            lists.get(i).title = getRemoveHtmlText(lists.get(i).title);
        if (lists.size() > 9)
            return gson.toJson(lists.subList(0, 9));
        else
            return gson.toJson(lists);
    }

    public ArrayList<req_BoardsBean> getBoardsWhatIDone(String id) {
        Connection conn = Config.getInstance().sqlLogin();
        List<Map<String, Object>> listOfMaps = null;
        ArrayList<req_BoardsBean> lists = new ArrayList<>();
        Gson gson = new Gson();
        try {
            QueryRunner queryRunner = new QueryRunner();
            listOfMaps = queryRunner.query(conn, "SELECT DISTINCT board_number FROM req_answer WHERE user_id=?", new MapListHandler(), id);
            ArrayList<req_AnswerBean> answers = gson.fromJson(gson.toJson(listOfMaps), new TypeToken<List<req_AnswerBean>>() {}.getType());
            for(int i = 0 ; i < answers.size() ; ++i) {
                req_BoardsBean thing = getBoardRead(answers.get(i).board_number);
                lists.add(thing);
            }
        }catch(SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtils.closeQuietly(conn);
        }
        return lists;
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
}