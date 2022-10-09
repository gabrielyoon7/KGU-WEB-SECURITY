<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
    StringBuffer url2_track_course = request.getRequestURL();
    String logo_img_track_course;

    //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
    //ai이면 ai로고 cs이면 cs로고
    if(url2_track_course.substring(7,9).equals("ai") || url2_track_course.substring(7,9).equals("lo")){
        logo_img_track_course = "img/edu_ai.png";
    }
    else{
        logo_img_track_course = "img/edu.png";
    }
    //System.out.println((logo_img_track_course));
%>
<%

    String tabmenulist=(String) request.getAttribute("tabmenulist");
    String num=(String) request.getAttribute("num");
%>
<%
    //    모든 과목정보를 교육과정(12, 17, 18), 학년, 학기별로 가져옴
    String subject_12_1_1 = (String) request.getAttribute("subject_12_1_1");
    String subject_12_1_2 = (String) request.getAttribute("subject_12_1_2");
    String subject_12_2_1 = (String) request.getAttribute("subject_12_2_1");
    String subject_12_2_2 = (String) request.getAttribute("subject_12_2_2");
    String subject_12_3_1 = (String) request.getAttribute("subject_12_3_1");
    String subject_12_3_2 = (String) request.getAttribute("subject_12_3_2");
    String subject_12_4_1 = (String) request.getAttribute("subject_12_4_1");
    String subject_12_4_2 = (String) request.getAttribute("subject_12_4_2");

    String subject_17_1_1 = (String) request.getAttribute("subject_17_1_1");
    String subject_17_1_2 = (String) request.getAttribute("subject_17_1_2");
    String subject_17_2_1 = (String) request.getAttribute("subject_17_2_1");
    String subject_17_2_2 = (String) request.getAttribute("subject_17_2_2");
    String subject_17_3_1 = (String) request.getAttribute("subject_17_3_1");
    String subject_17_3_2 = (String) request.getAttribute("subject_17_3_2");
    String subject_17_4_1 = (String) request.getAttribute("subject_17_4_1");
    String subject_17_4_2 = (String) request.getAttribute("subject_17_4_2");

    String subject_18_1_1 = (String) request.getAttribute("subject_18_1_1");
    String subject_18_1_2 = (String) request.getAttribute("subject_18_1_2");
    String subject_18_2_1 = (String) request.getAttribute("subject_18_2_1");
    String subject_18_2_2 = (String) request.getAttribute("subject_18_2_2");
    String subject_18_3_1 = (String) request.getAttribute("subject_18_3_1");
    String subject_18_3_2 = (String) request.getAttribute("subject_18_3_2");
    String subject_18_4_1 = (String) request.getAttribute("subject_18_4_1");
    String subject_18_4_2 = (String) request.getAttribute("subject_18_4_2");

    String subject_21_1_1 = (String) request.getAttribute("subject_21_1_1");
    String subject_21_1_2 = (String) request.getAttribute("subject_21_1_2");
    String subject_21_2_1 = (String) request.getAttribute("subject_21_2_1");
    String subject_21_2_2 = (String) request.getAttribute("subject_21_2_2");
    String subject_21_3_1 = (String) request.getAttribute("subject_21_3_1");
    String subject_21_3_2 = (String) request.getAttribute("subject_21_3_2");
    String subject_21_4_1 = (String) request.getAttribute("subject_21_4_1");
    String subject_21_4_2 = (String) request.getAttribute("subject_21_4_2");
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
            width: 800px;
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

        table {
            width: 100%;
            margin-top: 5px;
            margin-bottom: 20px;
            text-align: center;
            vertical-align: middle;
        }
        .btn{
            font-size: 12px;
            width: 180px;
        }
        .btn[disabled='disabled']{
            opacity: 1;
            cursor:default;
        }
        .clicked {
            background-color: #E6E6E6;
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
            <img src=<%=logo_img_track_course%> />
            <div id="titlename">나의 이수 현황</div>
        </div>
        <div id="container">
            <div id="tab">
                <ul id="tab_2">
                </ul>
            </div>
            <div id="maincontent">
                <div class="contenttitle"style="margin-top:40px";><img src="img/list.gif"> 교육과정 보기</div>
                <div style="margin-top: 5px;margin-bottom: 5px;text-align: center;">
                    <button id="view_year12" type="button" class="btn btn-default" onclick="show_course_12()" style="width: 32%;font-size: 14px;">2012년도 컴퓨터공학 전공교육과정</button>
                    <button id="view_year17" type="button" class="btn btn-default" onclick="show_course_17()" style="width: 32%;font-size: 14px;">2017년도 컴퓨터공학 전공교육과정</button>
                </div>
                <div style="margin-top: 5px;margin-bottom: 5px;text-align: center;">
                    <button id="view_year18" type="button" class="btn btn-default" onclick="show_course_18()" style="width: 32%;font-size: 14px;">2018년도 컴퓨터공학 전공교육과정</button>
                    <button id="view_year21" type="button" class="btn btn-default" onclick="show_course_21()" style="width: 32%;font-size: 14px;">2021년도 컴퓨터공학 전공교육과정</button>
                </div>
                <div id="sub_year" class="contenttitle2" style="padding-top: 0px;padding-bottom: 0px;margin-top: 10px;">

                </div>

                <table class="table table-bordered"
                       style="font-size: 13px; border: 2px solid #ddd; margin-bottom: 20px;text-align: center;">
                    <tr style="background-color: #ECEFF1;">
                        <th style="text-align: center;width: 187px;">1학년 1학기</th><th style="text-align: center;width: 187px;">1학년 2학기</th>
                        <th style="text-align: center;width: 187px;">2학년 1학기</th><th style="text-align: center;width: 187px;">2학년 2학기</th>
                    </tr>
                    <tr id="subject_area_1" style="font-size: 10px">

                    </tr>
                    <tr style="background-color: #ECEFF1;">
                        <th style="text-align: center;width: 187px;">3학년 1학기</th><th style="text-align: center;width: 187px;">3학년 2학기</th>
                        <th style="text-align: center;width: 187px;">4학년 1학기</th><th style="text-align: center;width: 187px;">4학년 2학기</th>
                    </tr>
                    <tr id="subject_area_2" style="font-size: 10px">

                    </tr>
                </table>
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

    $(document).ready(function(){
        createTable_18_1();
        createTable_18_2();
        $("#view_year18").addClass("clicked");
    });

    function createTable_12_1() {
        var output = "";

        output += '<td><ul>';
        for (var i = 0; i < sub_12_1_1.length; ++i) {
            var subject = sub_12_1_1[i];
            output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'

        }
        output += '</ul></td>';
        output += '<td><ul>';
        for (var i = 0; i < sub_12_1_2.length; ++i) {
            var subject = sub_12_1_2[i];
            output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';
        output += '<td><ul>';
        for (var i = 0; i < sub_12_2_1.length; ++i) {
            var subject = sub_12_2_1[i];
            output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';
        output += '<td><ul>';

        for (var i = 0; i < sub_12_2_2.length; ++i) {
            var subject = sub_12_2_2[i];
            output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';

        document.querySelector("#subject_area_1").innerHTML = output;
    }

    function createTable_12_2() {
        var output = "";

        output += '<td><ul>';
        for (var i=0; i < sub_12_3_1.length; ++i) {
            var subject = sub_12_3_1[i];
            output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';
        output += '<td><ul>';
        for (var i=0; i < sub_12_3_2.length; ++i) {
            var subject = sub_12_3_2[i];
            output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';
        output += '<td><ul>';
        for (var i=0; i < sub_12_4_1.length; ++i) {
            var subject = sub_12_4_1[i];
            output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';
        output += '<td><ul>';
        for (var i=0; i < sub_12_4_2.length; ++i) {
            var subject = sub_12_4_2[i];
            output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';

        document.querySelector("#subject_area_2").innerHTML = output;
        document.querySelector("#sub_year").innerHTML = "&nbsp;&nbsp;2012학년도 교육과정";
    }
    function createTable_17_1() {
        var output = "";

        output += '<td><ul>';
        for (var i = 0; i < sub_17_1_1.length; ++i) {
            var subject = sub_17_1_1[i];
            output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';
        output += '<td><ul>';
        for (var i = 0; i < sub_17_1_2.length; ++i) {
            var subject = sub_17_1_2[i];
            output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';
        output += '<td><ul>';
        for (var i = 0; i < sub_17_2_1.length; ++i) {
            var subject = sub_17_2_1[i];
            output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';
        output += '<td><ul>';
        for (var i = 0; i < sub_17_2_2.length; ++i) {
            var subject = sub_17_2_2[i];
            output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';

        document.querySelector("#subject_area_1").innerHTML = output;
    }

    function createTable_17_2() {
        var output = "";

        output += '<td><ul>';
        for (var i=0; i < sub_17_3_1.length; ++i) {
            var subject = sub_17_3_1[i];
            output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';
        output += '<td><ul>';
        for (var i=0; i < sub_17_3_2.length; ++i) {
            var subject = sub_17_3_2[i];
            output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';
        output += '<td><ul>';
        for (var i=0; i < sub_17_4_1.length; ++i) {
            var subject = sub_17_4_1[i];
            output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';
        output += '<td><ul>';
        for (var i=0; i < sub_17_4_2.length; ++i) {
            var subject = sub_17_4_2[i];
            output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';

        document.querySelector("#subject_area_2").innerHTML = output;
        document.querySelector("#sub_year").innerHTML = "&nbsp;&nbsp;2017학년도 교육과정";
    }
    function createTable_18_1() {
        var output = "";

        output += '<td><ul>';
        for (var i = 0; i < sub_18_1_1.length; ++i) {
            var subject = sub_18_1_1[i];
            output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';
        output += '<td><ul>';
        for (var i = 0; i < sub_18_1_2.length; ++i) {
            var subject = sub_18_1_2[i];
            output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';
        output += '<td><ul>';
        for (var i = 0; i < sub_18_2_1.length; ++i) {
            var subject = sub_18_2_1[i];
            output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';
        output += '<td><ul>';
        for (var i = 0; i < sub_18_2_2.length; ++i) {
            var subject = sub_18_2_2[i];
            output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';

        document.querySelector("#subject_area_1").innerHTML = output;
    }

    function createTable_18_2() {
        var output = "";

        output += '<td><ul>';

        for (var i=0; i < sub_18_3_1.length; ++i) {
            var subject = sub_18_3_1[i];
            output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';
        output += '<td><ul>';
        for (var i=0; i < sub_18_3_2.length; ++i) {
            var subject = sub_18_3_2[i];
            output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';
        output += '<td><ul>';
        for (var i=0; i < sub_18_4_1.length; ++i) {
            var subject = sub_18_4_1[i];
            output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';
        output += '<td><ul>';
        for (var i=0; i < sub_18_4_2.length; ++i) {
            var subject = sub_18_4_2[i];
            output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';

        document.querySelector("#subject_area_2").innerHTML = output;
        document.querySelector("#sub_year").innerHTML = "&nbsp;&nbsp;2018학년도 교육과정";
    }

    function createTable_21_1() {
        var output = "";

        output += '<td><ul>';
        for (var i=0; i < sub_21_1_1.length; ++i) {
            var subject = sub_21_1_1[i];
            output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';
        output += '<td><ul>';
        for (var i=0; i < sub_21_1_2.length; ++i) {
            var subject = sub_21_1_2[i];
            output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';
        output += '<td><ul>';
        for (var i=0; i < sub_21_2_1.length; ++i) {
            var subject = sub_21_2_1[i];
            output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';
        output += '<td><ul>';
        for (var i=0; i < sub_21_2_2.length; ++i) {
            var subject = sub_21_2_2[i];
            output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';

        document.querySelector("#subject_area_1").innerHTML = output;
        document.querySelector("#sub_year").innerHTML = "&nbsp;&nbsp;2021학년도 교육과정";
    }

    function createTable_21_2() {
        var output = "";

        output += '<td><ul>';

        for (var i=0; i < sub_21_3_1.length; ++i) {
            var subject = sub_21_3_1[i];
            output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';
        output += '<td><ul>';
        for (var i=0; i < sub_21_3_2.length; ++i) {
            var subject = sub_21_3_2[i];
            output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';
        output += '<td><ul>';
        for (var i=0; i < sub_21_4_1.length; ++i) {
            var subject = sub_21_4_1[i];
            output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';
        output += '<td><ul>';
        for (var i=0; i < sub_21_4_2.length; ++i) {
            var subject = sub_21_4_2[i];
            output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';

        document.querySelector("#subject_area_2").innerHTML = output;
        document.querySelector("#sub_year").innerHTML = "&nbsp;&nbsp;2021학년도 교육과정";
    }

    function show_course_12() {
        $("#view_year12").addClass("clicked");
        $("#view_year12").blur();
        createTable_12_1();
        createTable_12_2();
        $("#view_year17").removeClass("clicked");
        $("#view_year18").removeClass("clicked");
        $("#view_year21").removeClass("clicked");
    }

    function show_course_17() {
        $("#view_year17").addClass("clicked");
        $("#view_year17").blur();
        createTable_17_1();
        createTable_17_2();
        $("#view_year12").removeClass("clicked");
        $("#view_year18").removeClass("clicked");
        $("#view_year21").removeClass("clicked");
    }

    function show_course_18() {
        $("#view_year18").addClass("clicked");
        $("#view_year18").blur();
        createTable_18_1();
        createTable_18_2();
        $("#view_year12").removeClass("clicked");
        $("#view_year17").removeClass("clicked");
        $("#view_year21").removeClass("clicked");
    }

    //21년도 교육과정 추가
    function show_course_21() {
        $("#view_year21").addClass("clicked");
        $("#view_year21").blur();
        createTable_21_1();
        createTable_21_2();
        $("#view_year12").removeClass("clicked");
        $("#view_year17").removeClass("clicked");
        $("#view_year18").removeClass("clicked");
    }

    function callSetupTableView(){
        $('#table').bootstrapTable('refresh');
    }

    var list = $('#tab_2');
    var arr = <%=tabmenulist%>;

    var sub_12_1_1 = <%=subject_12_1_1%>;   var sub_12_1_2 = <%=subject_12_1_2%>;
    var sub_12_2_1 = <%=subject_12_2_1%>;   var sub_12_2_2 = <%=subject_12_2_2%>;
    var sub_12_3_1 = <%=subject_12_3_1%>;   var sub_12_3_2 = <%=subject_12_3_2%>;
    var sub_12_4_1 = <%=subject_12_4_1%>;   var sub_12_4_2 = <%=subject_12_4_2%>;

    var sub_17_1_1 = <%=subject_17_1_1%>;   var sub_17_1_2 = <%=subject_17_1_2%>;
    var sub_17_2_1 = <%=subject_17_2_1%>;   var sub_17_2_2 = <%=subject_17_2_2%>;
    var sub_17_3_1 = <%=subject_17_3_1%>;   var sub_17_3_2 = <%=subject_17_3_2%>;
    var sub_17_4_1 = <%=subject_17_4_1%>;   var sub_17_4_2 = <%=subject_17_4_2%>;

    var sub_18_1_1 = <%=subject_18_1_1%>;   var sub_18_1_2 = <%=subject_18_1_2%>;
    var sub_18_2_1 = <%=subject_18_2_1%>;   var sub_18_2_2 = <%=subject_18_2_2%>;
    var sub_18_3_1 = <%=subject_18_3_1%>;   var sub_18_3_2 = <%=subject_18_3_2%>;
    var sub_18_4_1 = <%=subject_18_4_1%>;   var sub_18_4_2 = <%=subject_18_4_2%>;

    //21년도 교육과정 추가
    var sub_21_1_1 = <%=subject_21_1_1%>;   var sub_21_1_2 = <%=subject_21_1_2%>;
    var sub_21_2_1 = <%=subject_21_2_1%>;   var sub_21_2_2 = <%=subject_21_2_2%>;
    var sub_21_3_1 = <%=subject_21_3_1%>;   var sub_21_3_2 = <%=subject_21_3_2%>;
    var sub_21_4_1 = <%=subject_21_4_1%>;   var sub_21_4_2 = <%=subject_21_4_2%>;

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