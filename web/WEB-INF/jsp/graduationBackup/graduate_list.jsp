<%--졸업논문 조회기능 사용 x--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java"%>--%>
<%--<%--%>
<%--    String userlist = (String) request.getAttribute("userlist");--%>
<%--    String tabmenulist = (String) request.getAttribute("tabmenulist");--%>
<%--    String ordernum = (String) request.getAttribute("ordernum");--%>
<%--    String proflist=(String) request.getAttribute("proflist");--%>
<%--    String etclist = (String)request.getAttribute("etclist");--%>
<%--    String reqorgrd = (String)request.getAttribute("reqorgrd"); //1=신청접수 0=졸업전체--%>
<%--    //190720(add)--%>
<%--    String semesterlist = (String)request.getAttribute("semesterlist");--%>
<%--    String admissionlist = (String)request.getAttribute("admissionlist");--%>
<%--%>--%>
<%--<!DOCTYPE html>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
<%--    <meta charset="utf-8">--%>
<%--    <title>경기대학교 AI컴퓨터공학부</title>--%>
<%--    <link rel="stylesheet" href="css/bootstrap-table.css">--%>
<%--    <link href='css/bootstrap.css' rel='stylesheet' type='text/css'>--%>
<%--    <link href='css/default.css' rel='stylesheet' type='text/css'>--%>
<%--    <link href='css/boardtable.css' rel='stylesheet' type='text/css'>--%>
<%--    <link href='css/information.css' rel='stylesheet' type='text/css'>--%>
<%--    <link href='css/content.css' rel='stylesheet' type='text/css'>--%>
<%--    <link href='css/bootstrap-table.css' rel='stylesheet' type='text/css'>--%>
<%--    <style>--%>
<%--        #maincontent {--%>
<%--            padding: 0;--%>
<%--        }--%>

<%--        #maincontent>ul {--%>
<%--            padding: 10px;--%>
<%--        }--%>

<%--        .boardtable>thead>tr>th:nth-child(1) {--%>
<%--            min-width: 20px;--%>
<%--        }--%>

<%--        .boardtable>tbody>tr>td:nth-child(1) {--%>
<%--            min-width: 20px;--%>
<%--        }--%>

<%--        .boardtable>thead>tr>th:nth-child(2) {--%>
<%--            min-width: 30px;--%>
<%--            max-width: 30px;--%>
<%--        }--%>

<%--        .boardtable>thead>tr>th:nth-child(4) {--%>
<%--            width: 80px;--%>
<%--        }--%>

<%--        .boardtable>tbody>tr>td:nth-child(2) {--%>
<%--            font-family: 'Nanum Gothic', sans-serif;--%>
<%--            min-width: 30px;--%>
<%--            max-width: 30px;--%>
<%--        }--%>

<%--        .boardtable>tbody>tr>td:nth-child(5), .boardtable>thead>tr>th:nth-child(5)--%>
<%--        {--%>
<%--            min-width: 65px;--%>
<%--            max-width: 65px;--%>
<%--        }--%>

<%--        .boardtable>tbody>tr>td:nth-child(4) {--%>
<%--            width: 100px;--%>
<%--        }--%>

<%--        .modal-body .fixed-table-body {--%>
<%--            height: 257px;--%>
<%--        }--%>
<%--    </style>--%>
<%--</head>--%>
<%--<body>--%>
<%--<script src="js/default.js"></script>--%>
<%--<script src="js/jquery-3.2.1.min.js"></script>--%>
<%--<script src="js/bootstrap.min.js"></script>--%>
<%--<script src="js/bootstrap-table.js"></script>--%>
<%--<script src="js/bootstrap-table-cookie.js"></script>--%>
<%--<%@include file="../main/header.jsp"%>--%>
<%--<script>--%>
<%--    function makeboard(id) {--%>
<%--        var list = $(id);--%>
<%--        var arr = <%=tabmenulist%>;--%>
<%--        for (var i = 0; i < arr.length; i++) {--%>
<%--            var value = arr[i];--%>
<%--            if(value.show_in_menus)--%>
<%--                list.append(makeone(value));--%>
<%--        }--%>
<%--    }--%>
<%--    function makeone(str) {--%>
<%--        var num=str.tab_id*10+str.orderNum;--%>
<%--        var text = '<li><span class="deco_dot">●</span><a href="'+str.path+'?num='+num+'">'+ str.page_title + '</li>'--%>
<%--        return text;--%>
<%--    }--%>
<%--</script>--%>
<%--<main>--%>
<%--    <div id="content">--%>
<%--        <div id="title">--%>
<%--            <img src="img/graduation.png" alt="">--%>
<%--            <div>졸업논문</div>--%>
<%--        </div>--%>
<%--        <div id="container">--%>
<%--            <div id="tab">--%>
<%--                <ul id="tab_2">--%>
<%--                </ul>--%>
<%--            </div>--%>
<%--            <div id="maincontent">--%>
<%--                <ul>--%>
<%--                    <li>--%>
<%--                        <div class="contenttitle">졸업자 조회</div>--%>
<%--                    </li>--%>
<%--                </ul>--%>
<%--                <div id = "grd_type">--%>
<%--                    <div class="paddingtype">졸업 유형 :</div>--%>
<%--                    <input type="checkbox" name="grd_type" value="졸업논문"/> <span style="font-size : 17px">졸업논문</span>--%>
<%--                    <input type="checkbox" name="grd_type" value="자격증"/> <span style="font-size : 17px">자격증</span>--%>
<%--                    <input type="checkbox" name="grd_type" value="공모전"/> <span style="font-size : 17px">공모전</span>--%>
<%--                    <input type="checkbox" name="grd_type" value="학술대회" /> <span style="font-size : 17px">학술대회</span>--%>
<%--                    <input type="checkbox" name="grd_type" value="전체 선택"/><span style="font-size : 17px">전체 선택</span>--%>
<%--                </div>--%>
<%--                <div class="paddingtype">졸업년도 :</div><div class="paddingtype2" id="grd_semester"></div>--%>
<%--                <div class="paddingtype">입학년도 :</div><div class="paddingtype2" id="grd_admission"></div>--%>
<%--                <br>--%>
<%--                <div class="paddingtype">교수 :</div><div class="paddingtype2" id="grd_prof"></div>--%>
<%--                <div class="paddingtype">이름 :</div><input type = "text" placeholder="이름을 입력하세요" id="grd_name">--%>
<%--                <div class="paddingtype">학번 :</div><input type = "text" placeholder="학번을 입력하세요" id="grd_num">--%>
<%--                <a onclick="grdSearch()"><button type="button" class="btn btn-default paddingButton" style="height: 35px; float: right;">조회</button></a>--%>
<%--                <br>--%>

<%--                <table class="boardtable2" id="table" data-toggle="table"--%>
<%--                       data-pagination="true" data-search="false"--%>
<%--                       data-side-pagination="true" data-page-list="[10]">--%>
<%--                    <thead>--%>
<%--                    <tr>--%>
<%--                        <th data-field="index" data-sortable="true">번호</th>--%>
<%--                        <th data-field="per_id" data-sortable="true">학번</th>--%>
<%--                        <th data-field="name" data-sortable="true">이름</th>--%>
<%--                        <th data-field="prof_name" data-sortable="true">교수</th>--%>
<%--                        <th data-field="major" data-sortable="true">학과</th>--%>
<%--                        <th data-field="graduation_type" data-sortable="true">졸업종류</th>--%>
<%--                        <th data-field="graduation_date" data-sortable="true">졸업일자</th>--%>
<%--                        <th data-field="final_action_date" data-sortable="true">승인날짜</th>--%>
<%--                    </tr>--%>
<%--                    </thead>--%>
<%--                </table>--%>

<%--                <div id="buttonmenu" style="margin-top: 10px;">--%>
<%--                    <a onclick="grdExcelDown()"><button type="button" class="btn btn-default col-xs-1" style="height: 34px;">다운</button></a>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</main>--%>
<%--<%@include file="../main/footer.jsp"%>--%>
<%--<div id="shadow">--%>
<%--    <div id="blur"></div>--%>
<%--</div>--%>
<%--<script>--%>
<%--    makeboard(tab_2);--%>
<%--    var users=<%=userlist%>;--%>
<%--    var profs=<%=proflist%>;--%>
<%--    var semesters=<%=semesterlist%>;--%>
<%--    var admissions=<%=admissionlist%>;--%>

<%--    function studentData(stdData){--%>
<%--        var rows = [];--%>

<%--        for(var i = 0; i < stdData.length; i++){--%>
<%--            var value=stdData[i];--%>

<%--            rows.push({--%>
<%--                index:i+1,--%>
<%--                per_id:value.per_id,--%>
<%--                name:'<a href="graduation_back_info.do?num=94&perid='+value.per_id+'&grdType='+value.grdType+'">'+value.name+'</a>',--%>
<%--                prof_name:value.prof_name,--%>
<%--                major:value.major,--%>
<%--                graduation_type:value.graduation_type,--%>
<%--                graduation_date:value.graduation_date,--%>
<%--                final_action_date:value.final_action_date--%>
<%--            });--%>
<%--        }--%>

<%--        return rows;--%>
<%--    }--%>

<%--    function insertSemester(){--%>
<%--        var list = $('#grd_semester');--%>
<%--        var a = '';--%>
<%--        a += '<select class="inform" id="InputSemesterdate" style="width : 160px">';--%>

<%--        for(var i = 0; i < semesters.length; i++){--%>
<%--            var value = semesters[i];--%>
<%--            a += '<option>'+(value)+'</option>';--%>
<%--        }--%>

<%--        a+= '</select>'--%>
<%--        list.append(a);--%>
<%--    }--%>

<%--    function insertAdmission(){--%>
<%--        var list = $('#grd_admission');--%>
<%--        var a = '';--%>
<%--        a += '<select class="inform" id="InputAdmissiondate" style="width : 160px">';--%>

<%--        for(var i = 0; i < admissions.length; i++){--%>
<%--            var value = admissions[i];--%>
<%--            a += '<option>'+(value)+'</option>';--%>
<%--        }--%>

<%--        a+= '</select>'--%>
<%--        list.append(a);--%>
<%--    }--%>

<%--    function insertProf(){--%>
<%--        var list = $('#grd_prof');--%>
<%--        var a = '';--%>
<%--        a += '<select class="inform" id="InputProf" style="width : 160px">';--%>

<%--        for(var i = 0; i < profs.length; i++){--%>
<%--            var value = profs[i];--%>
<%--            a += '<option>'+(value)+'</option>';--%>
<%--        }--%>

<%--        a+= '</select>'--%>
<%--        list.append(a);--%>
<%--    }--%>

<%--    //선택된 졸업 종류--%>
<%--    function selectedType(){--%>
<%--        var checked_type='';--%>
<%--        var type = document.getElementsByName("grd_type");--%>
<%--        var size = document.getElementsByName("grd_type").length;--%>

<%--        for(var i = 0; i < size; i++){--%>
<%--            if(document.getElementsByName("grd_type")[i].checked == true){--%>
<%--                checked_type += (document.getElementsByName("grd_type")[i].value);--%>
<%--                checked_type += "/";--%>
<%--            }--%>
<%--        }--%>
<%--        return checked_type;--%>
<%--    }--%>

<%--    var loadData = [];--%>
<%--    function grdSearch(){--%>
<%--        var grdType = "grdType:" + selectedType();--%>
<%--        var grdSemester = "grdSemester:" + $('#InputSemesterdate').val();--%>
<%--        var grdAdmission = "grdAdmission:" + $('#InputAdmissiondate').val();--%>
<%--        var grdProf = "grdProf:" + $('#InputProf').val();--%>
<%--        var name = "name:" + $('#grd_name').val();--%>
<%--        var stdNum = "stdNum:" + $('#grd_num').val();--%>
<%--        var answer = grdType + "-/-/-" + grdSemester + "-/-/-" + grdAdmission + "-/-/-" + grdProf + "-/-/-"--%>
<%--                    + name + "-/-/-" + stdNum;--%>

<%--        $.ajax({--%>
<%--            url:"graduate_back_ajax.do",--%>
<%--            type:"post",--%>
<%--            data : {--%>
<%--                req : "grd_search",--%>
<%--                data : answer--%>
<%--            },--%>
<%--            dataType : "json",--%>
<%--            success : function(data){--%>
<%--                loadData = data;--%>
<%--                $('#table').bootstrapTable('load', studentData(loadData));--%>
<%--                $('#table').bootstrapTable('refresh');--%>
<%--            }--%>
<%--        })--%>
<%--    }--%>

<%--    function grdExcelDown(){--%>
<%--        var excelList = [];--%>

<%--        if(loadData.length != 0){--%>
<%--            excelList = loadData;--%>
<%--        }--%>

<%--        else{--%>
<%--            excelList = users;--%>
<%--        }--%>

<%--        excelList = JSON.stringify(excelList);--%>

<%--        $.ajax({--%>
<%--            url:"graduate_back_ajax.do",--%>
<%--            type:"post",--%>
<%--            data : {--%>
<%--                req : "grd_excel_down",--%>
<%--                data : excelList--%>
<%--            },--%>
<%--            dataType : "json",--%>
<%--            success:function(data){--%>
<%--                window.location.href = "graduate_excel_down.do?fileName=" + data;--%>
<%--            }--%>
<%--        })--%>
<%--    }--%>

<%--    function callSetupTableView(){--%>
<%--        $('#table').bootstrapTable('append',studentData(users));--%>
<%--        $('#table').bootstrapTable('refresh');--%>
<%--    }--%>

<%--    $(document).ready(function(){--%>
<%--        callSetupTableView();--%>
<%--        insertSemester();--%>
<%--        insertAdmission();--%>
<%--        insertProf();--%>
<%--    })--%>

<%--</script>--%>
<%--</body>--%>
<%--</html>--%>