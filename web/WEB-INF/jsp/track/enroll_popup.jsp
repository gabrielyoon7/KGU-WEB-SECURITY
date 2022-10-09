<%@ page import="java.util.Calendar" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
    String tabmenulist=(String) request.getAttribute("tabmenulist");
    String num=(String) request.getAttribute("num");
    String user_info = (String) request.getAttribute("user_info");
%>
<%
    //    모든 과목정보를 교육과정(12, 18, 19), 학년, 학기별로 가져옴
    String subject_12_1_1 = (String) request.getAttribute("subject_12_1_1");    String subject_12_1_2 = (String) request.getAttribute("subject_12_1_2");
    String subject_12_2_1 = (String) request.getAttribute("subject_12_2_1");    String subject_12_2_2 = (String) request.getAttribute("subject_12_2_2");
    String subject_12_3_1 = (String) request.getAttribute("subject_12_3_1");    String subject_12_3_2 = (String) request.getAttribute("subject_12_3_2");
    String subject_12_4_1 = (String) request.getAttribute("subject_12_4_1");    String subject_12_4_2 = (String) request.getAttribute("subject_12_4_2");
    String subject_12_5_1 = (String) request.getAttribute("subject_12_5_1");    String subject_12_5_2 = (String) request.getAttribute("subject_12_5_2");

    String subject_17_1_1 = (String) request.getAttribute("subject_17_1_1");    String subject_17_1_2 = (String) request.getAttribute("subject_17_1_2");
    String subject_17_2_1 = (String) request.getAttribute("subject_17_2_1");    String subject_17_2_2 = (String) request.getAttribute("subject_17_2_2");
    String subject_17_3_1 = (String) request.getAttribute("subject_17_3_1");    String subject_17_3_2 = (String) request.getAttribute("subject_17_3_2");
    String subject_17_4_1 = (String) request.getAttribute("subject_17_4_1");    String subject_17_4_2 = (String) request.getAttribute("subject_17_4_2");
    String subject_17_5_1 = (String) request.getAttribute("subject_17_5_1");    String subject_17_5_2 = (String) request.getAttribute("subject_17_5_2");

    String subject_18_1_1 = (String) request.getAttribute("subject_18_1_1");    String subject_18_1_2 = (String) request.getAttribute("subject_18_1_2");
    String subject_18_2_1 = (String) request.getAttribute("subject_18_2_1");    String subject_18_2_2 = (String) request.getAttribute("subject_18_2_2");
    String subject_18_3_1 = (String) request.getAttribute("subject_18_3_1");    String subject_18_3_2 = (String) request.getAttribute("subject_18_3_2");
    String subject_18_4_1 = (String) request.getAttribute("subject_18_4_1");    String subject_18_4_2 = (String) request.getAttribute("subject_18_4_2");
    String subject_18_5_1 = (String) request.getAttribute("subject_18_5_1");    String subject_18_5_2 = (String) request.getAttribute("subject_18_5_2");

    String subject_21_1_1 = (String) request.getAttribute("subject_21_1_1");    String subject_21_1_2 = (String) request.getAttribute("subject_21_1_2");
    String subject_21_2_1 = (String) request.getAttribute("subject_21_2_1");    String subject_21_2_2 = (String) request.getAttribute("subject_21_2_2");
    String subject_21_3_1 = (String) request.getAttribute("subject_21_3_1");    String subject_21_3_2 = (String) request.getAttribute("subject_21_3_2");
    String subject_21_4_1 = (String) request.getAttribute("subject_21_4_1");    String subject_21_4_2 = (String) request.getAttribute("subject_21_4_2");
    String subject_21_5_1 = (String) request.getAttribute("subject_21_5_1");    String subject_21_5_2 = (String) request.getAttribute("subject_21_5_2");

    String subject_math_science = (String) request.getAttribute("subject_math_science");

//    User가 학년-학기별로 선택한 과목정보
    String user_subject_total = (String) request.getAttribute("user_subject_total");
    String user_subject_11 = (String) request.getAttribute("user_subject_11");  String user_subject_12 = (String) request.getAttribute("user_subject_12");
    String user_subject_21 = (String) request.getAttribute("user_subject_21");  String user_subject_22 = (String) request.getAttribute("user_subject_22");
    String user_subject_31 = (String) request.getAttribute("user_subject_31");  String user_subject_32 = (String) request.getAttribute("user_subject_32");
    String user_subject_41 = (String) request.getAttribute("user_subject_41");  String user_subject_42 = (String) request.getAttribute("user_subject_42");
    String user_subject_51 = (String) request.getAttribute("user_subject_51");  String user_subject_52 = (String) request.getAttribute("user_subject_52");
    String user_subject_math_science = (String) request.getAttribute("user_subject_math_science");
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
            margin-right: 50px;
            margin-left: 50px;
            width: 803px;
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
        .clicked {
            background-color: #C1DFF9;
        }
        .majorSubbutton:hover {
            background-color: white;
        }
        .clicked:hover {
            background-color: #C1DFF9;
        }
        .subjectButton {
            font-size: 12px;
            width: 180px;
        }
        .subjectButton[disabled='disabled']{
            cursor:default;
        }
        .btn[disabled='disabled'] {
            cursor:default;
        }
    </style>
</head>
<body>
<script src="js/default.js"></script>
<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrap-table.js"></script>
<script src="js/bootstrap-table-cookie.js"></script>
<main>
    <div id="content" style="width:900px">
        <div id="title">
            <img src="img/edu.png" alt="">
            <div id="titlename">이수 현황 등록
                <span id="title_now" style="font-size:75%"></span>
            </div>
        </div>
        <div id="container" style="width:900px">
            <div id="maincontent">
                <%--@declare id=""--%><table id="usertable" class="table table-bordered"
                                             style="font-size: 13px; border: 2px solid #ddd; margin-top: 15px; margin-bottom: 5px;">
                <tr style="border-bottom: 1px solid #ddd">
                    <td style="background-color: #ECEFF1; font-weight: 600;">학번</td>
                    <td id="stu_code_td"></td>
                    <td style="background-color: #ECEFF1; font-weight: 600;">이름</td>
                    <td id="stu_name_td"></td>
                    <td style="background-color: #ECEFF1; font-weight: 600;">입학년도</td>
                    <td id="stu_admYear_td"></td>
                </tr>
                <tr style="border-bottom: 1px solid #ddd">
                    <td style="background-color: #ECEFF1; font-weight: 600;">수강연도</td>
                    <td>
                        <select name="" id="selectYear" onchange="createSubjectTable()">
                            <option value="0">연도선택</option>
                        </select>
                        <select name="" id="selectSem" onchange="createSubjectTable()">
                            <option value="0">학기선택</option>
                            <option value="1">1학기</option>
                            <option value="2">2학기</option>
                        </select>
                    </td>
                    <td style="background-color: #ECEFF1; font-weight: 600;">트랙제</td>
                    <td id="stu_track_td"></td>
                    <td style="background-color: #ECEFF1; font-weight: 600;">최근수정일자</td>
                    <td id="stu_lastModi_td"></td>
                </tr>
            </table>
                <div id="subjecttable" class="show_sem_sub">

                </div>
                <input type="button" class="btn btn-default" style="float:right; margin:5px" value="취소" onclick="submit_cancle()">
                <input id="submit_button" type="button" class="btn btn-default" style="float:right; margin:5px" value="저장" onclick="submit_update()">
                <input type="button" class="btn btn-default" style="float:right; margin:5px" value="지우기" onclick="delete_selected()">
                <label for="">현재 선택 과목 학점 총합: </label>
                <label for="" id="total_credit_label">0</label>
            </div>
        </div>
</main>
<div id="shadow">
    <div id="blur"></div>
</div>
<script>
    // User정보(학번, 이름, 입학년도, 이수학기, 트랙제, 최근수정일자) 테이블 세팅
    function createUserInfoTable() {
        document.querySelector('#stu_code_td').innerHTML = user.id;
        document.querySelector('#stu_name_td').innerHTML = user.name;
        document.querySelector('#stu_admYear_td').innerHTML = user.adm_year;
        // document.querySelector('#stu_compSem_td').innerHTML = user.comp_sem;
        if (user.adm_year >= 2017) {
            document.querySelector('#stu_track_td').innerHTML = '해당';
        }
        else {
            document.querySelector('#stu_track_td').innerHTML = '비해당';
        }
        document.querySelector('#stu_lastModi_td').innerHTML = user.logDateString;
        var output = "";
        if (user.last_modi_year < 2000)
            var min = user.adm_year;
        else
            var min = user.last_modi_year;
        for (var i=user.adm_year; i<=2021; ++i) {
            output += '<option value="';
            output += i + '">';
            output += i + '</option>';
        }
        document.querySelector('#selectYear').innerHTML += output;
        // alert('(' + val.substr(0, 1) + '학년 ' + val.substr(1, 1) + '학기)');

        //현재 선택한 학년-학기 테이블을 이전에 선택한적있다면 이전 정보 가져와서 표출
        if (global_check != "null") {
            document.querySelector("#title_now").innerHTML = '(' + global_grade + '학년 ' + global_sem + '학기, ' + global_year + "-" + global_sel_sem + ')';
            createSubjectTable_detail(global_year, global_grade, global_sel_sem);
            check_before_selected_sub(parseInt(global_year), parseInt(global_sel_sem), parseInt(global_grade), parseInt(global_sem));
        }
        else {
            document.querySelector("#title_now").innerHTML = '(' + global_grade + '학년 ' + global_sem + '학기, ' + global_year + "-" + global_sel_sem + ')';
            $("#selectYear").val(global_year);
            $("#selectSem").val(global_sel_sem);
            createSubjectTable_detail(global_year, global_grade, global_sel_sem);
            check_before_selected_sub_math_science();
            $("#submit_button").attr("disabled", true);
        }
    }
    //현재 선택한 학년-학기 테이블을 이전에 선택한적있다면 이전 정보 가져와서 표출 함수
    function check_before_selected_sub(year, sel_sem, grade, sem) {
        // alert("check_before_selected_sub call");
        //Select 태그 이전 수강연도로 설정
        $("#selectYear").val(year);
        $("#selectSem").val(sel_sem);
        var yearTmp = (grade-1)*2 + (sem-1);
        // alert(grade+""+sem + " - " + yearTmp);
        var yearArr = userSelectList[yearTmp];
        if (yearArr == null)
            return;
        // alert(year + "-" + grade + "-" + sem);
        //선택했던 과목 표현
        for (var i=0; i<yearArr.length; ++i) {
            var subject = yearArr[i];
            clicked_subject.push(subject.id);
            var id = "#" + subject.id;
            $(id).addClass("clicked");
            total_credit += parseInt($(id).attr("name"));
        }
        //선택했던 수리와 과학 과목 버튼은 비활성화
        for (var i=0; i<userSelect_sub_mathScience.length; ++i) {
            var flag = false;
            var subject = userSelect_sub_mathScience[i];
            if (subject == null)
                continue;
            // alert(subject.sub_title);
            for (var j=0; j<yearArr.length; ++j) {
                if (subject.id == yearArr[j].id)
                    flag = true;
            }
            if (!flag) {
                var id = "#" + subject.id;
                $(id).attr("disabled", true);
            }
        }
        // alert("NOW CLICKED: " + clicked_subject);
        document.querySelector("#total_credit_label").innerHTML = total_credit;
        if (total_credit <= 0)
            $("#submit_button").attr("disabled", true);
        else {
            $("#submit_button").attr("disabled", false);
        }
    }
    function check_before_selected_sub_math_science_all() {
        for (var i=0; i<userSelect_sub_mathScience.length; ++i) {
            var subject = userSelect_sub_mathScience[i];
            if (subject == null)
                continue;
            var id = "#" + subject.id;
            // alert(id);
            $(id).attr("disabled", true);
        }
    }
    function check_before_selected_sub_math_science() {
        var yearTmp = (global_grade-1)*2 + (global_sem-1);
        var yearArr = userSelectList[yearTmp];
        if (yearArr == null) {
            check_before_selected_sub_math_science_all();
            return;
        }
        for (var i=0; i<userSelect_sub_mathScience.length; ++i) {
            var flag = false;
            var subject = userSelect_sub_mathScience[i];
            if (subject == null)
                continue;
            for (var j=0; j<yearArr.length; ++j) {
                if (yearArr[j].id == subject.id) {
                    flag = true;
                    break;
                }
            }
            if (!flag) {
                var id = "#" + subject.id;
                $(id).attr("disabled", true);
            }
        }
    }

    // User가 과목버튼 클릭시 과목의 id값을 저장할 배열
    var clicked_subject = new Array();
    //User가 모든 과목을 선택한후 저장버튼 누르면 DB에 저장
    function submit_update() {
        //선택된 과목정보, 학년, 학기정보와 수정된 이수학기 정보를 전달
        var selected_year = $("#selectYear option:selected").attr("value");
        var selected_sem = $("#selectSem option:selected").attr("value");
        var answer = clicked_subject + ":" + selected_year+""+selected_sem + "-" + global_grade + "" + global_sem + "-" + (comp_sem);
        // alert("Answer: " + answer);
        // alert(answer + "-----" + clicked_subject.length);
        if (clicked_subject.length >= 0) {
            $.ajax({
                url: "ajax.do",
                async: false,     //값을 리턴시 해당코드를 추가하여 동기로 변경
                type: "post",
                data: {
                    req: "submit_track_request",
                    data: answer,
                },
                // dataType : "json",
                success: function(rVal) {
                    //처리완료되면 팝업창 닫은후 팝업부모(학기별정보)창 새로고침
                    alert("rVal: " + rVal);
                    if (rVal.indexOf("fail_date_low") != -1) {
                        var bef_year = rVal.substr(rVal.indexOf("-") + 1, rVal.length);
                        alert("수강연도, 학기가 낮게 설정 되었습니다. 다시 설정해주세요\n이전학기: " + bef_year.substr(0, 4) + "-" + bef_year.substr(4, 5));
                        return;
                    }
                    else if (rVal.indexOf("fail_date_high") != -1) {
                        var aft_year = rVal.substr(rVal.indexOf("-") + 1, rVal.length);
                        alert("수강연도, 학기가 높게 설정 되었습니다. 다시 설정해주세요\n직후학기: " + aft_year.substr(0, 4) + "-" + aft_year.substr(4, 5));
                        return;
                    }
                    else if (rVal.indexOf("fail_dupl") != -1) {
                        var output = "";
                        var dupl_arr = rVal.substr(rVal.indexOf("-") + 1, rVal.length).split("-");
                        // alert("dupl_arr: " + dupl_arr);
                        for (var i=0; i<dupl_arr.length; ++i) {
                            var idTmp = "#" + dupl_arr[i];
                            output += $(idTmp).attr("value") + " ";
                            $(idTmp).removeClass('clicked');
                            var tmp = clicked_subject.splice(clicked_subject.indexOf(parseInt(dupl_arr[i])), 1);
                            total_credit -= parseInt($(idTmp).attr("name"));
                        }
                        document.querySelector("#total_credit_label").innerHTML = total_credit;
                        if (total_credit <= 0)
                            $("#submit_button").attr("disabled", true);
                        else
                            $("#submit_button").attr("disabled", false);
                        alert("ERROR: 중복된 과목을 선택하였습니다." + "\n\n중복 과목: " + output);
                        // alert("Clicked_subject: " + clicked_subject);
                        return;
                    }
                    else if (rVal.indexOf("fail_unknown") != -1) {
                        alert("정의되지 않은 오류입니다. 관리자에게 문의해주세요.");
                        return;
                    }
                    else {
                        alert("추가 및 수정 완료");
                        global_check = "norm";
                        window.location.href = "mytrack_semester.do?num=" + num;
                        opener.location.reload();
                    }
                    self.close();
                }
            })
        }
    }
    //취소시 팝업창 닫음
    function submit_cancle() {
        // var check_user = confirm("현재 선택한 항목들이 삭제됩니다.\n확인 클릭시 기존 화면으로 이동합니다.");
        // if (!check_user)
        //     return;
        // var comp_sem_tmp = user.comp_sem;
        // if (comp_sem_tmp % 2 == 0) {
        //     var val1 = parseInt(comp_sem_tmp / 2);
        //     var val2 = 2;
        // }
        // else {
        //     var val1 = parseInt(comp_sem_tmp / 2) + 1;
        //     var val2 = 1;
        // }
        // if ( (global_grade) == val1 && (global_sem == val2) ) {
        //     // alert("최근학기 제거");
        //     opener.parent.delLastSemTable_select(global_grade, global_sem);
        // }
        // else {
        //     // alert("중간학기 제거");
        //     opener.parent.delLastSemTable_select_between(global_grade, global_sem);
        // }
        self.close();
    }
    function delete_selected() {
        for (var i = clicked_subject.length-1; i>=0; --i) {
            var sub = clicked_subject[i];
            var id = "#" + sub;
            $(id).removeClass('clicked');
            // alert(sub + "-" + parseInt($(id).attr("name")));
            total_credit -= parseInt($(id).attr("name"));
            clicked_subject.splice(clicked_subject.indexOf(sub), 1);
            // alert(clicked_subject);
        }
        document.querySelector("#total_credit_label").innerHTML = total_credit;
        $("#submit_button").attr("disabled", true);
    }
    //과목버튼 클릭시 선택과목 배열에 추가, 클래스(Clicked)추가하여 스타일 변경
    var total_credit = 0;
    function subjectButtonClick(button) {
        // alert("Click Event Accur");
        button.blur();
        var target = parseInt(button.id);
        // alert(target);
        var id = "#" + target;
        var classes = $(id).attr("class");
        // alert(classes);
        if (!classes.includes("clicked")) {
            // alert("click");
            //클릭되지않은 버튼을 클릭했을때
            $(id).addClass('clicked');
            clicked_subject.push(target);
            total_credit += parseInt($(id).attr("name"));
        }
        else {
            // alert("unclick");
            //클릭된 버튼을 클릭 해제
            $(id).removeClass('clicked');
            var tmp = clicked_subject.splice(clicked_subject.indexOf(parseInt(target)), 1);
            // alert(tmp);
            total_credit -= parseInt($(id).attr("name"));
            // alert(clicked_subject);
        }
        if (total_credit > 24)
            alert("수강학점이 매우 높습니다.\n(현재 학점: " + total_credit + ")");
        document.querySelector("#total_credit_label").innerHTML = total_credit;
        // alert("NOW CLICKED: " + clicked_subject);
        if (total_credit <= 0)
            $("#submit_button").attr("disabled", true);
        else
            $("#submit_button").attr("disabled", false);
    }
    //과목버튼 생성
    //4. 전달받은 배열으로 과목버튼 리스트 생성
    function makeSubjectArr(sub) {
        var output = "<ul>";
        for (var i = 0; i < sub.length; ++i) {
            var subject = sub[i];
            output += '<li><input type="button"'
            output += 'id="' + subject.id + '"';
            output += 'class="subjectButton majorSubbutton btn btn-default"' + 'name="' + subject.credit;
            output += '" value="' + subject.sub_title + '"';
            output += 'onclick="subjectButtonClick(this)">';
            output += '</li>';
        }
        output += "</ul>";
        return output;
    }
    //과목버튼 생성
    //3. 연도, 학년, 학기정보로 Action을 통해 전달받은 객체와 매칭시킴
    function createSubjectTable_data(year, grade, sem) {
        var output = "";
        // alert(year + " " + grade + " " + sem);
        if (year < 2017) {
            switch(grade + "|" +  sem) {
                case "1|1":         return makeSubjectArr(sub_12_1_1);  break;
                case "1|2":         return makeSubjectArr(sub_12_1_2);  break;
                case "2|1":         return makeSubjectArr(sub_12_2_1);  break;
                case "2|2":         return makeSubjectArr(sub_12_2_2);  break;
                case "3|1":         return makeSubjectArr(sub_12_3_1);  break;
                case "3|2":         return makeSubjectArr(sub_12_3_2);  break;
                case "4|1":         return makeSubjectArr(sub_12_4_1);  break;
                case "4|2":         return makeSubjectArr(sub_12_4_2);  break;
                case "5|1":         return makeSubjectArr(sub_12_5_1);  break;
                case "5|2":         return makeSubjectArr(sub_12_5_2);  break;
            }
        }
        else if (year == 2017) {
            switch(grade + "|" + sem) {
                case "1|1":         return makeSubjectArr(sub_17_1_1);  break;
                case "1|2":         return makeSubjectArr(sub_17_1_2);  break;
                case "2|1":         return makeSubjectArr(sub_17_2_1);  break;
                case "2|2":         return makeSubjectArr(sub_17_2_2);  break;
                case "3|1":         return makeSubjectArr(sub_17_3_1);  break;
                case "3|2":         return makeSubjectArr(sub_17_3_2);  break;
                case "4|1":         return makeSubjectArr(sub_17_4_1);  break;
                case "4|2":         return makeSubjectArr(sub_17_4_2);  break;
                case "5|1":         return makeSubjectArr(sub_17_5_1);  break;
                case "5|2":         return makeSubjectArr(sub_17_5_2);  break;
            }
        }
        else if (year >= 2018 && year < 2021) {
            switch(grade + "|" + sem) {
                case "1|1":         return makeSubjectArr(sub_18_1_1);  break;
                case "1|2":         return makeSubjectArr(sub_18_1_2);  break;
                case "2|1":         return makeSubjectArr(sub_18_2_1);  break;
                case "2|2":         return makeSubjectArr(sub_18_2_2);  break;
                case "3|1":         return makeSubjectArr(sub_18_3_1);  break;
                case "3|2":         return makeSubjectArr(sub_18_3_2);  break;
                case "4|1":         return makeSubjectArr(sub_18_4_1);  break;
                case "4|2":         return makeSubjectArr(sub_18_4_2);  break;
                case "5|1":         return makeSubjectArr(sub_18_5_1);  break;
                case "5|2":         return makeSubjectArr(sub_18_5_2);  break;
            }
        }

        //21년도 교육과정 추가
        else if (year >= 2021) {
            switch(grade + "|" + sem) {
                case "1|1":         return makeSubjectArr(sub_21_1_1);  break;
                case "1|2":         return makeSubjectArr(sub_21_1_2);  break;
                case "2|1":         return makeSubjectArr(sub_21_2_1);  break;
                case "2|2":         return makeSubjectArr(sub_21_2_2);  break;
                case "3|1":         return makeSubjectArr(sub_21_3_1);  break;
                case "3|2":         return makeSubjectArr(sub_21_3_2);  break;
                case "4|1":         return makeSubjectArr(sub_21_4_1);  break;
                case "4|2":         return makeSubjectArr(sub_21_4_2);  break;
                case "5|1":         return makeSubjectArr(sub_21_5_1);  break;
                case "5|2":         return makeSubjectArr(sub_21_5_2);  break;
            }
        }
    }
    //과목버튼 생성
    //3-1. 수리와 과학 과목 버튼 생성
    function createSubject_mathScience_data() {
        var output = '<ul>';
        for (var i=0; i<sub_math_science.length; ++i) {
            var subject = sub_math_science[i];
            output += '<li style="display:inline"><input type="button"'
            output += 'id="' + subject.id + '"';
            output += 'class="subjectButton btn btn-default"' + 'name="' + subject.credit;
            output += '" value="' + subject.sub_title + '" ';
            output += '';
            output += 'onclick="subjectButtonClick(this)">';
            output += '</li>';
        }
        output += '</ul>';
        return output;
    }
    //과목버튼 생성
    //2. 전달받은 연도, 학년, 학기정보로 테이블 틀 생성
    function createSubjectTable_detail(year, grade, sem) {
        // alert("Year: " + year + "Grade: " + grade + "Sem: " + sem);
        // year: 유저가 선택한 수강연도
        var yearT = year;
        var gradeT;
        var semT;
        var output = "";
        output += '<table class="table table-bordered" style="font-size: 13px; border: 2px solid #ddd; margin-bottom: 5px;"><tr>';
        for (var i=0; i<4; i++) {
            if (i%2 == 0)
                output += '<th style="background-color: #ECEFF1; font-weight: 600;">';
            else
                output += "<th>";
            output += (yearT-i) + "년도" + (1+i) + "학년" + sem + "학기" + "</th>";
            // output += (1+i) + "학년" + sem + "학기" + "</th>";
        }
        output += '</tr>';

        output += '<tr>'
        for (var i=0; i<4; ++i) {
            yearT = year-i;
            if (yearT >= 2012 && yearT < 2017)
                yearT = 2012;
            else if (yearT >= 2017 && yearT < 2018)
                yearT = 2017;
            else if (yearT >= 2018 && yearT < 2021)
                yearT = 2018;
            else
                yearT = 2021; //21년도 교육과정 추가
            gradeT = 1 + i;
            semT = sem;
            if (i%2 == 0)
                output += '<td style="background-color: #ECEFF1; font-weight: 600;">';
            else
                output += '<td>';
            // alert(yearT + "-" + gradeT + "-" + semT);
            output += createSubjectTable_data(yearT, gradeT, semT);
            output += '</td>';
            // alert(output);
        }
        output += '</tr><tr><td colspan="4">';
        output += createSubject_mathScience_data();
        output += '</td></tr></table>';
        document.querySelector("#subjecttable").innerHTML = output;
    }
    //과목버튼 생성
    //1. 학년, 학기정보 추출, 선택한 수강연도 추출하여 다음함수전달
    function createSubjectTable() {
        // alert(val);
        // var grade = val.substr(0, 1);
        // var sem = val.substr(1, 1);
        // var select = $("#selectYear");
        // alert(select.attr("id"));
        var selectedYear = $("#selectYear option:selected");
        var selectedSem = $("#selectSem option:selected");
        // alert(selectItem.attr("value"));
        var year = selectedYear.attr("value");
        var sem = selectedSem.attr("value");
        if (year==0 || sem==0)
            return;
        if (clicked_subject.length > 0) {
            var check_user = confirm("현재 선택한 항목들이 삭제됩니다.\n확인 클릭시 새로 입력한 수강연도로 이동합니다.");
            if (!check_user)
                return;
            delete_selected();
        }
        // alert("year: " + selectItem.attr("value") + "grade:" + grade + ", sem:" + sem);
        document.querySelector("#title_now").innerHTML = '(' + global_grade + '학년 ' + global_sem + '학기, ' + year + "-" + sem + ')';
        createSubjectTable_detail(year, global_grade, sem);
        check_before_selected_sub_math_science();
        if (total_credit <= 0)
            $("#submit_button").attr("disabled", true);
        else
            $("#submit_button").attr("disabled", false);
    }


    function callSetupTableView(){
        $('#table').bootstrapTable('refresh');
    }

    var list = $('#tab_2');

    var loc1 = window.location.href.indexOf("val") + 4;
    var loc2 = window.location.href.indexOf("val") + 8;
    var val1 = window.location.href.substr(loc1, 4);
    var val2 = window.location.href.substr(loc2, 7);
    var loc3 = window.location.href.indexOf("compSem") + 8;
    var comp_sem = window.location.href.substr(loc3, 1);

    var global_check = val1;
    var global_year = val2.substr(0, 4);
    var global_sel_sem = val2.substr(4, 1);
    var global_grade = val2.substr(5, 1);
    var global_sem = val2.substr(6, 1);

    // alert(global_check + "-" + global_year + "-" + global_sel_sem + "-" + global_grade + "-" + global_sem);

    //이수체계 학년 학기 정보 가져옴
    var sub_12_1_1 = <%=subject_12_1_1%>;       var sub_12_1_2 = <%=subject_12_1_2%>;
    var sub_12_2_1 = <%=subject_12_2_1%>;       var sub_12_2_2 = <%=subject_12_2_2%>;
    var sub_12_3_1 = <%=subject_12_3_1%>;       var sub_12_3_2 = <%=subject_12_3_2%>;
    var sub_12_4_1 = <%=subject_12_4_1%>;       var sub_12_4_2 = <%=subject_12_4_2%>;
    var sub_12_5_1 = <%=subject_12_5_1%>;       var sub_12_5_2 = <%=subject_12_5_2%>;

    var sub_17_1_1 = <%=subject_17_1_1%>;       var sub_17_1_2 = <%=subject_17_1_2%>;
    var sub_17_2_1 = <%=subject_17_2_1%>;       var sub_17_2_2 = <%=subject_17_2_2%>;
    var sub_17_3_1 = <%=subject_17_3_1%>;       var sub_17_3_2 = <%=subject_17_3_2%>;
    var sub_17_4_1 = <%=subject_17_4_1%>;       var sub_17_4_2 = <%=subject_17_4_2%>;
    var sub_17_5_1 = <%=subject_17_5_1%>;       var sub_17_5_2 = <%=subject_17_5_2%>;

    var sub_18_1_1 = <%=subject_18_1_1%>;       var sub_18_1_2 = <%=subject_18_1_2%>;
    var sub_18_2_1 = <%=subject_18_2_1%>;       var sub_18_2_2 = <%=subject_18_2_2%>;
    var sub_18_3_1 = <%=subject_18_3_1%>;       var sub_18_3_2 = <%=subject_18_3_2%>;
    var sub_18_4_1 = <%=subject_18_4_1%>;       var sub_18_4_2 = <%=subject_18_4_2%>;
    var sub_18_5_1 = <%=subject_18_5_1%>;       var sub_18_5_2 = <%=subject_18_5_2%>;

    //21년도 교육과정 추가
    var sub_21_1_1 = <%=subject_21_1_1%>;       var sub_21_1_2 = <%=subject_21_1_2%>;
    var sub_21_2_1 = <%=subject_21_2_1%>;       var sub_21_2_2 = <%=subject_21_2_2%>;
    var sub_21_3_1 = <%=subject_21_3_1%>;       var sub_21_3_2 = <%=subject_21_3_2%>;
    var sub_21_4_1 = <%=subject_21_4_1%>;       var sub_21_4_2 = <%=subject_21_4_2%>;
    var sub_21_5_1 = <%=subject_21_5_1%>;       var sub_21_5_2 = <%=subject_21_5_2%>;

    var sub_math_science = <%=subject_math_science%>;


    //User가 선택한 과목 가져옴
    var userSelectTotal = <%=user_subject_total%>;
    var userSelectList = [<%=user_subject_11%>, <%=user_subject_12%>, <%=user_subject_21%>, <%=user_subject_22%>, <%=user_subject_31%>, <%=user_subject_32%>, <%=user_subject_41%>, <%=user_subject_42%>,  <%=user_subject_51%>, <%=user_subject_52%>];
    var userSelect_sub_mathScience = <%=user_subject_math_science%>;

    //전달받은 url을 연도, 학년, 학기로 분리
    var user=<%=user_info%>;
    var arr = <%=tabmenulist%>;
    var num = <%=num%>;

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

    // window.addEventListener("beforeunload", function (e) {
    //     if (global_check == "null") {
    //         // opener.parent.testFunc();
    //         opener.parent.delLastSemTable_select(global_grade, global_sem);
    //         // opener.location.reload();
    //     }
    // });
    // window.addEventListener("beforeunload", submit_cancle());


    $(function(){
        // alert("<유저정보>학번: " + user.id + " 이름: " + user.name + " 트랙제: " + user.track_ex + " 입학년도: " + user.adm_year + " 이수학기: " + user.comp_sem + " 최근 접속시간: " + user.log_date);
        // alert(val + " ----- " + comp_sem);
        // alert(global_year + "-" + global_grade + "-" + global_sem);
        callSetupTableView();
        createUserInfoTable();
    });

</script>
</body>
</html>