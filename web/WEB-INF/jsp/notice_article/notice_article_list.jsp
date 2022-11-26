<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    StringBuffer url2_na_list = request.getRequestURL();
    String logo_img_na_list;

    //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
    //ai이면 ai로고 cs이면 cs로고
    if (url2_na_list.substring(7, 9).equals("ai") || url2_na_list.substring(7, 9).equals("lo")) {
        logo_img_na_list = "img/notice_ai.png";
    } else {
        logo_img_na_list = "img/notice.png";
    }
    //System.out.println((logo_img_na_list));
%>
<%
    String boardslist = (String) request.getAttribute("boardslist");
    String tabmenulist = (String) request.getAttribute("tabmenulist");
    String num = (String) request.getAttribute("num");
    String readLevel = (String) request.getAttribute("readLevel");
    String writeLevel = (String) request.getAttribute("writeLevel");
    String menu = (String) request.getAttribute("menu");
    String fileBoardId = (String) request.getAttribute("fileBoardId");
%>
<!DOCTYPE html>
<html>
<%@include file="notice_head.jsp" %>
<body>
<script src="js/default.js"></script>
<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrap-table.js"></script>
<script src="js/bootstrap-table-cookie.js"></script>
<%@include file="../main/header.jsp" %>
<main>
    <div id="content">
        <div id="title">
            <img src=<%=logo_img_na_list%> />
            <div id="titlename"></div>
        </div>
        <div id="container">
            <div id="tab">
                <ul id="tab_2">
                </ul>
            </div>
            <div id="maincontent">
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
                <div id="write_post" class="post_button">
                </div>

            </div>
        </div>
    </div>
    </div>
    </div>
</main>
<%@include file="../main/footer.jsp" %>
<div id="shadow">
    <div id="blur"></div>
</div>
<script>
    var num =<%=num%>;
    var write = $("#write_post");
    if (Number(<%=writeLevel%>) >= <%=type%>.board_level && <%=menu%>.page_title != '전체공지'){
        write.append('<a href="notice_article_writer.do?num=' + num + '" class="btn btn-success">글쓰기</a>');
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
                    for_title = '<a href="notice_article_reader.do?id=' + value.id + '&num=' + num + '">' + titleCut;
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
                for_title = '<a href="notice_article_reader.do?id=' + value.id + '&num=' + num + '">' + titleCut;
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
        $('#articlename').append('<img src="img/list.gif"> ' + arr[indexOfName].page_title);
        $('.fixed-table-toolbar').css('margin-top', '15px');
    })


    var list = $('#tab_2');
    var articlename = $('#articlename');
    var indexOfName = 0;
    var num =<%=num%>;
    numo = num % 10;//orderNum
    numt = num / 10;//tab_id

    var arr = <%=tabmenulist%>;
    for (var i = 0; i < arr.length; i++) {
        var value = arr[i];
        if (value.show_in_menus)
            list.append(makeone(value));
        if (value.orderNum == numo)
            indexOfName = i;
    }

    function makeone(str) {
        var num = str.tab_id * 10 + str.orderNum;
        if (str.page_title == '졸업논문') {
            if (<%=type%>.type_name == '졸업논문관리자' || <%=type%>.type_name == '교수1' ||<%=type%>.type_name == '학부생' || <%=type%>.type_name == '복수전공생' || <%=type%>.type_name == '교수2' || <%=type%>.type_name == '관리자' ){
                return '<li><span class="deco_dot">●</span><a href="' + str.path + '">' + str.page_title + '</a></li>';
            }
            else{
                return '<li><span class="deco_dot">●</span>' + str.page_title + '</li>';
            }
        } else{
            return '<li><span class="deco_dot">●</span><a href="' + str.path + '?num=' + num + '">' + str.page_title + '</a></li>';
        }
    }

    var pane = $('#title');
    var panel = $('#titlename');
    var headtitle = <%=headermenulist%>;
    for (var i = 0; i < headtitle.length; ++i)
        if (headtitle[i].tab_id < numt && headtitle[i].tab_id > (numt - 1)) {
//         pane.prepend('<img src="'+headtitle[i].tab_img+'" alt="">');
            panel.append(headtitle[i].tab_title);
            break;
        }

</script>
</body>
</html>