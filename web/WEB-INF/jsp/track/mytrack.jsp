<%@ page import="kr.ac.kyonggi.cs.handler.vo.user.UserBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
    StringBuffer url2_mytrack = request.getRequestURL();
    String logo_img_mytrack;

    //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
    //ai이면 ai로고 cs이면 cs로고
    if(url2_mytrack.substring(7,9).equals("ai") || url2_mytrack.substring(7,9).equals("lo")){
        logo_img_mytrack = "img/edu_ai.png";
    }
    else{
        logo_img_mytrack = "img/edu.png";
    }
    //System.out.println((logo_img_mytrack));
%>
<%
    String tabmenulist=(String) request.getAttribute("tabmenulist");
    String num=(String) request.getAttribute("num");
    String user_info = (String) request.getAttribute("user_info");
//    user가 선택한 모든 과목 정보를 갖는 total_subject
    String total_subject = (String) request.getAttribute("total_subject");
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
        .explain {
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
            <img src=<%=logo_img_mytrack%> />
            <div id="titlename">나의 이수 현황</div>
        </div>
        <div id="container">
            <div id="tab">
                <ul id="tab_2">
                </ul>
            </div>
            <div id="maincontent">
                <div class="contenttitle"style="margin-top:40px";><img src="img/list.gif"> 이수 현황</div>
                    <table id="usertable" class="table table-bordered"
                           style="font-size: 13px; border: 2px solid #ddd; margin-bottom: 5px;">
                        <tr style="border-bottom: 1px solid #ddd">
                            <td style="background-color: #ECEFF1; font-weight: 600;">학번</td>
                            <td id="stu_code_td"></td>
                            <td style="background-color: #ECEFF1; font-weight: 600;">이름</td>
                            <td id="stu_name_td"></td>
                            <td style="background-color: #ECEFF1; font-weight: 600;">입학년도</td>
                            <td id="stu_admYear_td"></td>
                        </tr>
                        <tr style="border-bottom: 1px solid #ddd">
                            <td style="background-color: #ECEFF1; font-weight: 600;">이수학기</td>
                            <td id="stu_compSem_td"></td>
                            <td style="background-color: #ECEFF1; font-weight: 600;">트랙제</td>
                            <td id="stu_track_td"></td>
                            <td style="background-color: #ECEFF1; font-weight: 600;">최근수정일자</td>
                            <td id="stu_lastModi_td"></td>
                        </tr>
                    </table>

                <div class="show_my_subject">
                    <div class="selected_majer">
                        <table id="majertable" class="table table-bordered"
                               style="font-size: 13px; border: 2px solid #ddd; margin-bottom: 5px;margin-top:10px;">
                            <tr style="border-bottom: 1px solid #ddd">
                                <td style="background-color: #ECEFF1; font-weight: 600;width: 108px;">전공<br>과목</td>
                                <td id="sub_major_list_td"></td>
                                <td id="sub_major_total_td" style="background-color: #ECEFF1; font-weight: 600;width: 108px;"></td>
                            </tr>
                        </table>
                        <div class="progress_value">
                            <progress id="sub_major_bar" max="100" value="0" style="width: 657px;"></progress>
                            <span id="sub_major_bar_span" style="font-size:15px;padding-left: 20px;font-weight: 600;"></span>
                        </div>
                    </div>
                    <div class="selected_MS">
                        <table id="MStable" class="table table-bordered"
                               style="font-size: 13px; border: 2px solid #ddd; margin-bottom: 5px;margin-top:0px;">
                            <tr style="border-bottom: 1px solid #ddd">
                                <td style="background-color: #ECEFF1; font-weight: 600;width: 108px;">수리와과학<br>과목</td>
                                <td id="sub_math_science_list_td"></td>
                                <td id="sub_math_science_total_td" style="background-color: #ECEFF1; font-weight: 600;width: 108px;"></td>
                            </tr>
                        </table>
                        <div class="progress_value">
                            <progress id="sub_math_science_bar" max="100" value="0" style="width: 657px;"></progress>
                            <span id="sub_math_science_bar_span" style="font-size:16px;padding-left: 20px;font-weight: 600;"></span>
                        </div>
                    </div>
                    <div class="selected_track">
                        <div class="selected_track_SE">
                            <table id="SEtable" class="table table-bordered"
                                   style="font-size: 13px; border: 2px solid #ddd; margin-bottom: 5px;margin-top:0px;">
                                <tr style="border-bottom: 1px solid #ddd">
                                    <td style="background-color: #ECEFF1; font-weight: 600;width: 108px;">소프트웨어<br>트랙</td>
                                    <td id="sub_se_list_td"></td>
                                    <td id="sub_se_total_td" style="background-color: #ECEFF1; font-weight: 600;width: 108px;"></td>
                                </tr>
                            </table>
                            <div class="progress_value">
                                <progress id="sub_se_bar" max="100" value="0" style="width: 657px;"></progress>
                                <span id="sub_se_bar_span" style="font-size:16px;padding-left: 20px;font-weight: 600;"></span>
                            </div>
                        </div>
                        <div class="selected_track_AI">
                            <table id="AItable" class="table table-bordered"
                                   style="font-size: 13px; border: 2px solid #ddd; margin-bottom: 5px;margin-top:0px;">
                                <tr style="border-bottom: 1px solid #ddd">
                                    <td style="background-color: #ECEFF1; font-weight: 600;width: 108px;">지능 정보<br>트랙</td>
                                    <td id="sub_ai_list_td"></td>
                                    <td id="sub_ai_total_td" style="background-color: #ECEFF1; font-weight: 600;width: 108px;"></td>
                                </tr>
                            </table>
                            <div class="progress_value">
                                <progress id="sub_ai_bar" max="100" value="0" style="width: 657px;"></progress>
                                <span id="sub_ai_bar_span" style="font-size:16px;padding-left: 20px;font-weight: 600;"></span>
                            </div>
                        </div>
                        <div class="selected_IE">
                            <table id="IEtable" class="table table-bordered"
                                   style="font-size: 13px; border: 2px solid #ddd; margin-bottom: 5px;margin-top:0px;">
                                <tr style="border-bottom: 1px solid #ddd">
                                    <td style="background-color: #ECEFF1; font-weight: 600;width: 108px;">IoT 임베디드<br>트랙</td>
                                    <td id="sub_ie_list_td"></td>
                                    <td id="sub_ie_total_td" style="background-color: #ECEFF1; font-weight: 600;width: 108px;"></td>
                                </tr>
                            </table>
                            <div class="progress_value">
                                <progress id="sub_ie_bar" max="100" value="0" style="width: 657px;"></progress>
                                <span id="sub_ie_bar_span" style="font-size:16px;padding-left: 20px;font-weight: 600;"></span>
                            </div>
                        </div>
                        <div class="selected_BS">
                            <table id="BStable" class="table table-bordered"
                                   style="font-size: 13px; border: 2px solid #ddd; margin-bottom: 5px;margin-top:0px;">
                                <tr style="border-bottom: 1px solid #ddd">
                                    <td style="background-color: #ECEFF1; font-weight: 600;width: 108px;">블록체인 보안<br>트랙</td>
                                    <td id="sub_bs_list_td"></td>
                                    <td id="sub_bs_total_td" style="background-color: #ECEFF1; font-weight: 600;width: 108px;"></td>
                                </tr>
                            </table>
                            <div class="progress_value">
                                <progress id="sub_bs_bar" max="100" value="0" style="width: 657px;"></progress>
                                <span id="sub_bs_bar_span" style="font-size:16px;padding-left: 20px;font-weight: 600;"></span>
                            </div>
                        </div>
                    </div>
                    <div id="button_area_sub" class="explain">
                        <span>* 트랙 이수 인증제는 2018년도 이후 입학생에 대하여 적용됩니다.</span>
                    </div>
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
    // User정보(학번, 이름, 입학년도, 이수학기, 트랙제, 최근수정일자) 테이블 세팅
    function createUserInfoTable() {
        document.querySelector('#stu_code_td').innerHTML = user.id;
        document.querySelector('#stu_name_td').innerHTML = user.name;
        document.querySelector('#stu_admYear_td').innerHTML = user.adm_year;
        document.querySelector('#stu_compSem_td').innerHTML = user.comp_sem;
        if (user.adm_year >= 2018) {
            document.querySelector('#stu_track_td').innerHTML = '해당';
        }
        else {
            document.querySelector('#stu_track_td').innerHTML = '비해당';
        }
        document.querySelector('#stu_lastModi_td').innerHTML = user.logDateString;
    }
    // User가 신청한 전공 과목 테이블 생성
    function createMajorInfoTable() {
        var list_output = "";
        var credit = 0;
        var total_output = "";
        var span_output = 0;
        for (var i=0; i<total_sub.length; ++i) {
            var subject = total_sub[i];
            if (subject.sub_class_ex == "전공") {
                list_output += subject.sub_title;
                if (i < total_sub.length-1)
                    list_output += ", ";
                credit += subject.credit;
            }
        }
        total_output += credit + "<br>" + "(67)";
        span_output = Math.round(credit / 67 * 100);
        $("#sub_major_bar").attr("value", parseInt(span_output));
        document.querySelector("#sub_major_list_td").innerHTML = list_output;
        document.querySelector("#sub_major_total_td").innerHTML = total_output;
        document.querySelector("#sub_major_bar_span").innerHTML = span_output + "%";
    }
    // User가 신청한 수리와과학 과목 테이블 생성
    function createMathScienceInfoTable() {
        var list_output = "";
        var credit = 0;
        var total_output = "";
        var span_output = 0;
        for (var i=0; i<total_sub.length; ++i) {
            var subject = total_sub[i];
            if (subject.sub_class_ex == "수과") {
                list_output += subject.sub_title;
                if (i < total_sub.length-1)
                    list_output += ", ";
                credit += subject.credit;
            }
        }
        total_output += credit + "<br>" + "(24)";
        span_output = Math.round(credit / 24 * 100);
        $("#sub_math_science_bar").attr("value", parseInt(span_output));
        document.querySelector("#sub_math_science_list_td").innerHTML = list_output;
        document.querySelector("#sub_math_science_total_td").innerHTML = total_output;
        document.querySelector("#sub_math_science_bar_span").innerHTML = span_output + "%";
    }
    // User가 신청한 트랙별 과목 테이블 생성
    function createTrackInfoTable() {
        var menuList = ["se", "ai", "ie", "bs"];
        for (var j=0; j<menuList.length; ++j) {
            var target_list = "#sub_" + menuList[j] + "_list_td";
            var target_total = "#sub_" + menuList[j] + "_total_td";
            var target_bar = "#sub_" + menuList[j] + "_bar";
            var target_span = "#sub_" + menuList[j] + "_bar_span";
            var output_list = "";
            var output_credit = 0;
            for (var i = 0; i < total_sub.length; ++i) {
                var subject = total_sub[i];
                if (subject.track_code == menuList[j].toUpperCase()) {
                    output_list += subject.sub_title + " ";
                    output_credit += subject.credit;
                }
            }
            var per = Math.round(output_credit / 21 * 100);
            document.querySelector(target_list).innerHTML = output_list;
            document.querySelector(target_total).innerHTML = output_credit + "<br>" + "(21)";
            $(target_bar).attr("value", parseInt(per));
            document.querySelector(target_span).innerHTML = per + "%";
        }
    }

    function createInfoTable() {
        createMajorInfoTable();
        createMathScienceInfoTable();
        createTrackInfoTable();
    }


    var moremore = 1;


    function callSetupTableView(){
        $('#table').bootstrapTable('refresh');
    }

    var list = $('#tab_2');

    var total_sub = <%=total_subject%>;
    var num=<%=num%>;
    var arr = <%=tabmenulist%>;
    var user=<%=user_info%>;

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
        // alert("<유저정보>학번: " + user.id + " 이름: " + user.name + " 트랙제: " + user.track_ex + " 입학년도: " + user.adm_year + " 이수학기: " + user.comp_sem + " 최근 접속시간: " + user.log_date);
        callSetupTableView();
        createUserInfoTable();
        createInfoTable();
    });

</script>
</body>
</html>
