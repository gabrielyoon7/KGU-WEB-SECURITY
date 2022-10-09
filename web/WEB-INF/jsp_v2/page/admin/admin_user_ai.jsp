<%--
  Created by IntelliJ IDEA.
  User: ssky6
  Date: 2022-02-03
  Time: 오전 2:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //String tabmenulist=(String) request.getAttribute("tabmenulist");//관리자탭메뉴
    String alluser = (String) request.getAttribute("alluser");//스케쥴 리스트
    String AIuser = (String) request.getAttribute("AIuser");//스케쥴 리스트

%>
<%
    String headermenulist = (String) session.getAttribute("headermenulist");
    String menulist = (String) session.getAttribute("menulist");
    String user = (String) session.getAttribute("user");
    String type = (String) session.getAttribute("type");
%>
<%
    String num = (String) request.getAttribute("num");
    String pageMenuList = (String) request.getAttribute("pageMenuList");//좌측 소메뉴 리스트

    /**
     * for page.jsp
     * */
    String jsp = (String) request.getAttribute("jsp");
%>
<html>
<head>
    <title>유저 관리 : 경기대학교 AI컴퓨터공학부</title>
    <style>
        #maincontent {
            padding: 0;
        }

        #maincontent>ul {
            padding: 10px;
        }
        .boardtable > thead > tr > th:nth-child(2) {
            min-width: 30px;
        }

        .boardtable > tbody > tr > td:nth-child(2) {
            min-width: 30px;
        }
        .boardtable > thead > tr > th:nth-child(3) {
            min-width: 100px;
        }

        .boardtable > thead > tr > th:nth-child(5) {
            width: 120px;
            min-width:120px;
        }

        .boardtable > tbody > tr > td:nth-child(3) {
            font-family: 'Nanum Gothic', sans-serif;
            min-width: 100px;
        }

        .boardtable > tbody > tr > td:nth-child(5) {
            width: 120px;
            min-width:120px;
        }
        .boardtable > thead > tr > th:nth-child(2) {
            min-width: 150px;
        }
        .boardtable > thead > tr > th:nth-child(7), .boardtable > tbody > tr > td:nth-child(7){
            width:60px;
            min-width:60px;
        }
        .boardtable > thead > tr > th:nth-child(1), .boardtable > tbody > tr > td:nth-child(1){
            width:50px;
            min-width:50px;
        }
    </style>
</head>
<body>
<script>
    function makeboard(id) {
    var list = $(id);
    var arr = <%=pageMenuList%>;
    for (var i = 0; i < arr.length; i++) {
    var value = arr[i];
    if(value.show_in_menus)
    list.append(makeone(value));
}
}
    function makeone(str) {
    var num=str.tab_id*10+str.orderNum;
    var text = '<li><span class="deco_dot">●</span><a href="'+str.path+'?num='+num+'">'+ str.page_title + '</li>'
    return text;
}
</script>

<div id="maincontent">
    <ul>
        <li>
            <div class="contenttitle">인공지능 홈페이지(ai.kyonggi.ac.kr) 로그인 권한 관리</div>
        </li>
    </ul>
    <table class="boardtable" id="table" data-toggle="table"
           data-pagination="true" data-toolbar="#toolbar"
           data-search="true" data-side-pagination="true" data-click-to-select="true"
           data-page-list="[10]">
        <thead>
        <tr>
            <th data-field="state" data-checkbox="true"></th>
            <th data-field="del">설정</th>

            <th data-field="id" data-sortable="true">학번</th>
            <th data-field="name" data-sortable="true">이름</th>
            <th data-field="type" data-sortable="true">타입</th>
            <th data-field="major" data-sortable="true">전공</th>

        </tr>
        </thead>
    </table>
    <div class="col-md-6"></div>
</div>

<script>
    makeboard(tab_2)
</script>
<script>

    var alluser=<%=AIuser%>;

    function callSetupTableView(){
        $('#table').bootstrapTable('append',data());
        $('#table').bootstrapTable('refresh');
    }


    function data(){
        var rows = [];
        for(var i=0;i<alluser.length;i++){
            var user=alluser[i];
            rows.push({
                id: user.id,
                name: user.name,
                type : user.type,
                major : user.major,
                del : '<button type="button" class="btn btn-default btn btn-xs" style = "margin : 1px;" onclick="deleteAIAuthority('+i+')">AI권한삭제</button>'
            });
        }
        return rows;
    }

    $(document).ready(function(){
        callSetupTableView();
    })

    function deleteAIAuthority(id){ //AI 권한 삭제
        var user =alluser[id];
        var check = confirm(user.name+"["+user.id+"]님의 인공지능 홈페이지 접근 권한을 삭제 하시겠습니까? (삭제 시 인공지능 홈페이지 로그인 불가능.)");
        if(check){
            $.ajax({
                url : "ajaxuser.kgu", //AjaxuserAction
                type : "post",
                data : {
                    req : "deleteAIuser",
                    data : alluser[id].id
                },
                success :function(data){
                    alert("삭제되었습니다.");
                    window.location.href = 'admin.kgu?num=87';
                }
            })

        }

    }

</script>
</body>
</html>
