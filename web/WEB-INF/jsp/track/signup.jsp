<%@ page import="kr.ac.kyonggi.cs.handler.vo.user.UserBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
    StringBuffer url2_track_signup = request.getRequestURL();
    String logo_img_track_signup;

    //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
    //ai이면 ai로고 cs이면 cs로고
    if(url2_track_signup.substring(7,9).equals("ai") || url2_track_signup.substring(7,9).equals("lo")){
        logo_img_track_signup = "img/edu_ai.png";
    }
    else{
        logo_img_track_signup = "img/edu.png";
    }
    //System.out.println((logo_img_track_signup));
%>
<%
    String tabmenulist=(String) request.getAttribute("tabmenulist");
    String num=(String) request.getAttribute("num");
    String user_id = (String)request.getAttribute("user_id");
    String user_per_id = (String)request.getAttribute("user_per_id");
    String user_name = (String)request.getAttribute("user_name");
%>
<!DOCTYPE HTML>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="utf-8">
    <title>경기대학교 AI컴퓨터공학부</title>
    <link rel="stylesheet" href="css/bootstrap-table.css">
    <link href='css/bootstrap.css' rel='stylesheet' type='text/css'>
    <link href='css/default.css' rel='stylesheet' type='text/css'>
    <link href='css/boardtable.css' rel='stylesheet' type='text/css'>
    <link href='css/information.css' rel='stylesheet' type='text/css'>
    <link href='css/content.css' rel='stylesheet' type='text/css'>
    <style>
        #maincontent {
            padding: 0;
            padding-bottom: 60px;
        }

        #maincontent>ul {
            padding: 10px;
        }

        .forBoard {
        }
        .boardtable > thead > tr > th, .boardtable > tbody > tr > td{
            text-overflow: ellipsis;
            overflow: hidden;
            white-space: nowrap;
            text-align: center;
            border-left : none;
            border-right : none;
        }
        .boardtable > thead > tr > th:nth-child(1), .boardtable > tbody > tr > td:nth-child(1) {
            min-width: 65px;
            max-width: 65px;
            width: 65px;
        }
        .boardtable > thead > tr > th:nth-child(2), .boardtable > tbody > tr > td:nth-child(2) {
            min-width: 400px;
            max-width: 400px;
            width: 400px;
        }

        .boardtable > thead > tr > th:nth-child(3),.boardtable > tbody > tr > td:nth-child(3),.boardtable > thead > tr > th:nth-child(5),.boardtable > tbody > tr > td:nth-child(5){
            min-width: 80px;
            max-width: 80px;
            width:80px;
        }
        .boardtable > thead > tr > th:nth-child(4),.boardtable > tbody > tr > td:nth-child(4){
            min-width: 100px;
            max-width: 100px;
            width: 100px;
        }

        .fixed-table-container{
            border : none;
        }

        .pagination-info{
            display : none;
        }
        .pull-right-pagination{
            width : 100%;
        }
        .fixed-table-pagination{
            width : 100%;
            text-align : center;
        }

        div .search{
            width : fit-content;
            float : right !important;
        }

        table {
            width: 100%;
            margin-top: 5px;
            text-align: center;
        }

        .mytrack_enroll_info{
            padding: 5px 5px 20px;
            border: 1px solid #dedede;
            font-size: 15px;
            display: flex;
            width: 748px;
            margin: 10px auto;
        }
        .form-control {
            display: inline-block;
        }
        .inform {
            display: inline-block;
            text-align: right;
            width: 150px;
        }
        .profile {
            display: inline-block;
            font-weight: bold;
            margin-right: 5px;
            padding-right: 5px;
            width: 80px;
            text-align: center;
        }
        .explain {
            display: inline-block;
            border: 1px solid #dedede;
            width: 380px;
            margin-right: 5px;
            padding-right: 5px;
            text-align: left;
            color: #4c606a;
        }

    </style>
</head>
<body>
<script src="js/default.js"></script>
<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrap-table.js"></script>
<script src="js/bootstrap-table-cookie.js"></script>
<%@include file="../main/header.jsp"%>
<main>
    <div id="content">
        <div id="title">
            <img src=<%=logo_img_track_signup%> />
            <div id="titlename">나의 이수 현황</div>
        </div>
        <div id="container">
            <div id="tab">
                <ul id="tab_2">
                </ul>
            </div>
            <div id="maincontent">
                <div class="contenttitle"style="margin-top:40px";><img src="img/list.gif"> 나의 정보 등록</div>
                <div>
                    <div class="mytrack_enroll_info">
                        <div col-md-6 style="width: 280px;"><!-- 나의 정보 div -->
                            <div class="contenttitle2">&nbsp;&nbsp;나의 정보</div>
                            <ul>
                                <li><div class="profile">학번</div>
                                    <div class="inform"><input type="text" id="stu_id" class = "form-control" placeholder="학번을 입력해주세요" /></div></li>
                                <li><div class="profile">이름</div>
                                    <div class="inform"><input type="text" id="stu_name" class = "form-control" readonly style="background: #eceff1"/></div></li>
                            </ul>
                        </div>
                        <div col-md-6><!-- 주의 사항 div -->
                            <div class="contenttitle2"> 주의 사항</div>
                            <ul>
                                <div class="explain" style="background-color: #eceff1">
                                    <ul><li>&nbsp;&nbsp;이 페이지는 이수 현황 사용을 위한 등록창입니다.</li>
                                        <li>&nbsp;&nbsp;2018년 이후 입학생만 트랙 이수 대상입니다.<br>&nbsp;&nbsp;&nbsp;&nbsp;-> 학번으로 입학년도를 판단합니다.</li>
                                        <li>&nbsp;&nbsp;추후 수정 불가능하니 신중하게 입력해주세요.</li>
                                    </ul>
                                </div>
                            </ul>
                        </div>
                    </div>
                </div>
                <div id="button_area" class="text-right">
                    <button type="button" class="btn btn-default" onclick= "history.go(-1)" style = "margin: 2px;">취소</button>
                    <button type="button" class="btn btn-default" onclick="update()" style = "margin: 2px;">저장</button>
                </div>
            </div>
        </div>
    </div>
    </div>
    </div>
</main>
<%@include file="../main/footer.jsp"%>
<div id="shadow">
    <div id="blur"></div>
</div>
<script>

    var userid = <%=user_id%>
    var userperid=<%=user_per_id%>
    var username = <%=user_name%>

    if(userperid.match(/^\d{9}$/))
        document.getElementById("stu_id").value = userperid;
    else if(userid.match(/^\d{9}$/))
        document.getElementById("stu_id").value = userid;
    else
        document.getElementById("stu_id").value = null;
    document.getElementById("stu_name").value = username;

    function update() {

        // 입력 확인
        if(!document.getElementById("stu_id").value){
            alert("학번을 입력하세요");
            document.getElementById("stu_id").focus();
            return false;
        }
        if(!document.getElementById("stu_id").value.match(/^\d{9}$/)){
            alert("학번은 9자리 숫자로만 입력해주세요.");
            document.getElementById("stu_id").focus();
            return false;
        }

        if(!document.getElementById("stu_name").value){
            alert("이름을 입력하세요");
            document.getElementById("stu_name").focus();
            return false;
        }
        const id = document.getElementById('stu_id').value;
        const name = document.getElementById('stu_name').value;

        let checked_index = -1;
        let checked_value = '';

        if(stu_id > 201800000){
            checked_value = "yes";
        }
        else {
            checked_value = "no";
        }

        const msg = name+'/'+id+'/'+checked_value+'/'+userid;
        $.ajax({
            url: "ajax.do",
            type: "post",
            data: {
                req: "enroll_new_user",
                data: msg,
            },
            success: function() {
                alert("등록 되었습니다");
                location.href="mytrack.do?num=101";
            }
        })
    };

    function callSetupTableView(){
        $('#table').bootstrapTable('refresh');
    }


    var list = $('#tab_2');


    var num=<%=num%>;
    var arr = <%=tabmenulist%>;


    for (var i = 0; i < arr.length; i++) {
        var value = arr[i];
        if(value.show_in_menus)
            list.append(makeone(value));
    }
    function makeone(str) {
        var num=str.tab_id*10+str.orderNum;
        return '<li><span class="deco_dot">●</span><a href="'+str.path+'?num='+num+'">'
            + str.page_title + '</a></li>';
    }


    $(function(){
        callSetupTableView();

    });

</script>
</body>
</html>