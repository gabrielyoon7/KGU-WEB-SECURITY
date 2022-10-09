<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
    StringBuffer url2_track_view = request.getRequestURL();
    String logo_img_track_view;

    //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
    //ai이면 ai로고 cs이면 cs로고
    if(url2_track_view.substring(7,9).equals("ai") || url2_track_view.substring(7,9).equals("lo")){
        logo_img_track_view = "img/edu_ai.png";
    }
    else{
        logo_img_track_view = "img/edu.png";
    }
    //System.out.println((logo_img_track_view));
%>
<%

    String tabmenulist=(String) request.getAttribute("tabmenulist");
    String num=(String) request.getAttribute("num");
%>
<%
    //  과목정보를 교육과정(18), 학년, 학기별로 가져옴

    String subject_18_1_1 = (String) request.getAttribute("subject_18_1_1");
    String subject_18_1_2 = (String) request.getAttribute("subject_18_1_2");
    String subject_18_2_1 = (String) request.getAttribute("subject_18_2_1");
    String subject_18_2_2 = (String) request.getAttribute("subject_18_2_2");
    String subject_18_3_1 = (String) request.getAttribute("subject_18_3_1");
    String subject_18_3_2 = (String) request.getAttribute("subject_18_3_2");
    String subject_18_4_1 = (String) request.getAttribute("subject_18_4_1");
    String subject_18_4_2 = (String) request.getAttribute("subject_18_4_2");
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
        .clicked{
            background-color: #C1DFF9;
        }
        .clicked:hover {
            background-color: #C1DFF9;
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
            <img src=<%=logo_img_track_view%> />
            <div id="titlename">나의 이수 현황</div>
        </div>
        <div id="container">
            <div id="tab">
                <ul id="tab_2">
                </ul>
            </div>
            <div id="maincontent">
                <div class="contenttitle"style="margin-top:40px";><img src="img/list.gif"> 트랙보기</div>
                <div style="margin-top: 5px;margin-bottom: 5px;text-align: center;">
                    <button id="SE_btn" type="button" class="btn btn-default track-btn" onclick="clickTrack('SE')" style="width: 24%;font-size: 14px;">소프트웨어공학</button>
                    <button id="AI_btn" type="button" class="btn btn-default track-btn" onclick="clickTrack('AI')" style="width: 24%;font-size: 14px;">지능정보</button>
                    <button id="IE_btn" type="button" class="btn btn-default track-btn" onclick="clickTrack('IE')" style="width: 24%;font-size: 14px;">IoT 임베디드</button>
                    <button id="BS_btn" type="button" class="btn btn-default track-btn" onclick="clickTrack('BS')" style="width: 24%;font-size: 14px;">보안</button>
                </div>
                <div id="track_name" class="contenttitle2" style="padding-top: 0px;padding-bottom: 0px;margin-top: 10px;">

                </div>
                <table class="table table-bordered"style="font-size: 13px; border: 2px solid #ddd; margin-bottom: 20px;">
                    <tr style="background-color: #ECEFF1;">
                        <th style="text-align: center;width: 187px;">1학년 1학기</th><th style="text-align: center;width: 187px;">1학년 2학기</th>
                        <th style="text-align: center;width: 187px;">2학년 1학기</th><th style="text-align: center;width: 187px;">2학년 2학기</th>
                    </tr>
                    <tr id="subject_area_1">

                    </tr>
                    <tr style="background-color: #ECEFF1;">
                        <th style="text-align: center;width: 187px;">3학년 1학기</th><th style="text-align: center;width: 187px;">3학년 2학기</th>
                        <th style="text-align: center;width: 187px;">4학년 1학기</th><th style="text-align: center;width: 187px;">4학년 2학기</th>
                    </tr>
                    <tr id="subject_area_2">

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
        clickTrack('SE');
    });

    function createTable_1(code) {
        var output = "";

        output += '<td><ul>';
        for (var i = 0; i < sub_18_1_1.length; ++i) {
            var subject = sub_18_1_1[i];
            if(subject.track_code == null)
                output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
            else if(subject.track_code.includes(code))
                output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '" style="background-color: #c1dff9"></li>'
            else
                output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';
        output += '<td><ul>';
        for (var i = 0; i < sub_18_1_2.length; ++i) {
            var subject = sub_18_1_2[i];
            if(subject.track_code == null)
                output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
            else if(subject.track_code.includes(code))
                output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '" style="background-color: #c1dff9"></li>'
            else
                output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';
        output += '<td><ul>';
        for (var i = 0; i < sub_18_2_1.length; ++i) {
            var subject = sub_18_2_1[i];
            if(subject.track_code == null)
                output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
            else if(subject.track_code.includes(code))
                output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '" style="background-color: #c1dff9"></li>'
            else
                output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';
        output += '<td><ul>';

        for (var i = 0; i < sub_18_2_2.length; ++i) {
            var subject = sub_18_2_2[i];
            if(subject.track_code == null)
                output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
            else if(subject.track_code.includes(code))
                output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '" style="background-color: #c1dff9"></li>'
            else
                output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';

        document.querySelector("#subject_area_1").innerHTML = output;
    }

    function createTable_2(code) {
        var output = "";

        output += '<td><ul>';
        for (var i = 0; i < sub_18_3_1.length; ++i) {
            var subject = sub_18_3_1[i];
            if(subject.track_code == null)
                output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
            else if(subject.track_code.includes(code))
                output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '" style="background-color: #c1dff9"></li>'
            else
                output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '" ></li>'
        }
        output += '</ul></td>';
        output += '<td><ul>';
        for (var i = 0; i < sub_18_3_2.length; ++i) {
            var subject = sub_18_3_2[i];
            if(subject.track_code == null)
                output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
            else if(subject.track_code.includes(code))
                output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '" style="background-color: #c1dff9"></li>'
            else
                output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';
        output += '<td><ul>';
        for (var i = 0; i < sub_18_4_1.length; ++i) {
            var subject = sub_18_4_1[i];
            if(subject.track_code == null)
                output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
            else if(subject.track_code.includes(code))
                output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '" style="background-color: #c1dff9"></li>'
            else
                output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';
        output += '<td><ul>';

        for (var i = 0; i < sub_18_4_2.length; ++i) {
            var subject = sub_18_4_2[i];
            if(subject.track_code == null)
                output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
            else if(subject.track_code.includes(code))
                output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '" style="background-color: #c1dff9"></li>'
            else
                output += '<li><input type="button" class="btn btn-default" disabled="disabled" value="' + subject.sub_title + '"></li>'
        }
        output += '</ul></td>';

        document.querySelector("#subject_area_2").innerHTML = output;
    }

    function clickTrack(code) {
        var id = "";
        id = '#' + code + '_btn';
        $(id).addClass("clicked");
        $(id).blur();
        createTable_1(code);
        createTable_2(code);
        if(code == 'SE') {
            document.querySelector("#track_name").innerHTML = "&nbsp;&nbsp;소프트웨어공학 트랙";
            $("#AI_btn").removeClass("clicked");
            $("#IE_btn").removeClass("clicked");
            $("#BS_btn").removeClass("clicked");
        }
        else if(code == 'AI') {
            document.querySelector("#track_name").innerHTML = "&nbsp;&nbsp;지능정보 트랙";
            $("#SE_btn").removeClass("clicked");
            $("#IE_btn").removeClass("clicked");
            $("#BS_btn").removeClass("clicked");
        }

        else if(code == 'IE') {
            document.querySelector("#track_name").innerHTML = "&nbsp;&nbsp;IoT 임베디드 트랙";
            $("#AI_btn").removeClass("clicked");
            $("#SE_btn").removeClass("clicked");
            $("#BS_btn").removeClass("clicked");
        }
        else {
            document.querySelector("#track_name").innerHTML = "&nbsp;&nbsp;보안 트랙";
            $("#AI_btn").removeClass("clicked");
            $("#IE_btn").removeClass("clicked");
            $("#SE_btn").removeClass("clicked");
        }
    }


    function callSetupTableView(){
        $('#table').bootstrapTable('refresh');
    }



    var list = $('#tab_2');
    var arr = <%=tabmenulist%>;

    var sub_18_1_1 = <%=subject_18_1_1%>;   var sub_18_1_2 = <%=subject_18_1_2%>;
    var sub_18_2_1 = <%=subject_18_2_1%>;   var sub_18_2_2 = <%=subject_18_2_2%>;
    var sub_18_3_1 = <%=subject_18_3_1%>;   var sub_18_3_2 = <%=subject_18_3_2%>;
    var sub_18_4_1 = <%=subject_18_4_1%>;   var sub_18_4_2 = <%=subject_18_4_2%>;

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