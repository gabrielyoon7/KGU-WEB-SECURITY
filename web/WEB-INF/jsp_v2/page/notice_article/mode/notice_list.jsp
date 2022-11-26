<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 2022-01-25
  Time: 오전 11:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String user = (String) session.getAttribute("user");
    String type = (String) session.getAttribute("type");

    String boardslist = (String) request.getAttribute("boardslist");
    String num = (String) request.getAttribute("num");
    String readLevel = (String) request.getAttribute("readLevel");
    String writeLevel = (String) request.getAttribute("writeLevel");
    String menu = (String) request.getAttribute("menu");
    String fileBoardId = (String) request.getAttribute("fileBoardId");
%>
<table class="boardtable" id="table"
       data-toggle="table"
       data-pagination="true"
       data-search="true"
       data-page-list="[10]"
>
    <thead>
    <tr class="table-style">
        <th data-field="board_id" data-sortable="true">번호</th>
        <th data-field="title" data-sortable="true">제목</th>
        <th data-field="student_id" data-sortable="true">글쓴이</th>
        <th data-field="last_modified" data-sortable="true">작성일</th>
        <th data-field="views" data-sortable="true">조회수</th>
    </tr>
    </thead>
</table>
<div id="write_post" class="post_button"></div>
<script>
    var num =<%=num%>;
    var write = $("#write_post");
    if (Number(<%=writeLevel%>) >= <%=type%>.board_level && <%=menu%>.page_title != '전체공지'){
        write.append('<a href="notice_article_writer.kgu?num=' + num + '" class="btn btn-primary">글쓰기</a>');
    }


    function formatDate(date) {
        var d = new Date(date),
            month = '' + (d.getMonth() + 1),
            day = '' + d.getDate(),
            year = d.getFullYear();

        if (month.length < 2) month = '0' + month;
        if (day.length < 2) day = '0' + day;

        return [year, month, day].join('-');
    }

    var boards =<%=boardslist%>; // 게시판의 내용부분일 들어감 배열의 형태인듯
    function callSetupTableView() {
        $('#table').bootstrapTable('append', fixed_data());
        $('#table').bootstrapTable('append', data());
        $('#table').bootstrapTable('refresh');
    }


    var fileBoardId = <%=fileBoardId%>;
    var fileBoardIdArray = [];
    for (var i = 0; i < fileBoardId.length; ++i){
        fileBoardIdArray.push(fileBoardId[i].board_id);
    }

    function fixed_data(){
        var rows = [];
        var type = <%=type%>;
        var readLevel = <%=readLevel%>;
        for (var i = 0; i < boards.length; i++) {
            var value = boards[i]; //게시판 내용 i번째
            if(value.fixed=='true'){
                var for_title = '';
                var titleCut = '';
                if (value.title.length > 33)
                    titleCut = value.title.substring(0, 33) + '...';
                else
                    titleCut = value.title;
                if (Number(readLevel) < type.board_level) {
                    for_title = titleCut;
                    if (value.comments_count != 0)
                        for_title += ' <span style="font-size : 11px">[' + value.comments_count + ']</span>';
                    if (fileBoardIdArray.indexOf(value.id) >= 0)
                        for_title += '<img src="img/file_ico.png" style="margin-left : 5px;">';
                } else {
                    for_title = '<a href="notice_article_reader.kgu?id=' + value.id + '&num=' + num + '">' + titleCut;
                    if (value.comments_count != 0)
                        for_title += ' <span style="font-size : 11px">[' + value.comments_count + ']</span>';
                    if (fileBoardIdArray.indexOf(value.id) >= 0)
                        for_title += '<img src="img/file_ico.png" style="margin-left : 5px;">';
                    for_title += '</a>';
                }
                rows.push({
                    board_id: '<div style="color: red">[공지]</div>',
                    title: for_title,
                    student_id: value.student_name,
                    last_modified: formatDate(value.last_modified),
                    views: value.views
                });
            }
        }
        return rows;
    }
    function data() {
        var rows = [];
        var type = <%=type%>;
        var readLevel = <%=readLevel%>;
        for (var i = 0; i < boards.length; i++) {
            var value = boards[i]; //게시판 내용 i번째
            var for_title = '';
            var titleCut = '';
            if (value.title.length > 33)
                titleCut = value.title.substring(0, 33) + '...';
            else
                titleCut = value.title;
            if (Number(readLevel) < type.board_level) {
                for_title = titleCut;
                if (value.comments_count != 0)
                    for_title += ' <span style="font-size : 11px">[' + value.comments_count + ']</span>';
                if (fileBoardIdArray.indexOf(value.id) >= 0)
                    for_title += '<img src="img/file_ico.png" style="margin-left : 5px;">';
            } else {
                for_title = '<a href="notice_article_reader.kgu?id=' + value.id + '&num=' + num + '">' + titleCut;
                if (value.comments_count != 0)
                    for_title += ' <span style="font-size : 11px">[' + value.comments_count + ']</span>';
                if (fileBoardIdArray.indexOf(value.id) >= 0)
                    for_title += '<img src="img/file_ico.png" style="margin-left : 5px;">';
                for_title += '</a>';
            }
            rows.push({
                board_id: value.id,
                title: for_title,
                student_id: value.student_name,
                last_modified: formatDate(value.last_modified),
                views: value.views
            });

        }
        return rows;
    }

    $(document).ready(function () {
        callSetupTableView();
        // $('#articlename').append('<img src="img/list.gif"> ' + arr[indexOfName].page_title);
        // $('.fixed-table-toolbar').css('margin-top', '15px');
    })


</script>