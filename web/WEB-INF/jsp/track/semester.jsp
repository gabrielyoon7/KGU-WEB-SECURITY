<%@ page import="java.util.Calendar" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
    StringBuffer url2_track_semester = request.getRequestURL();
    String logo_img_track_semester;

    //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
    //ai이면 ai로고 cs이면 cs로고
    if(url2_track_semester.substring(7,9).equals("ai") || url2_track_semester.substring(7,9).equals("lo")){
        logo_img_track_semester = "img/edu_ai.png";
    }
    else{
        logo_img_track_semester = "img/edu.png";
    }
    //System.out.println((logo_img_track_semester));
%>
<%
    String tabmenulist=(String) request.getAttribute("tabmenulist");
    String num=(String) request.getAttribute("num");
    String user_info = (String) request.getAttribute("user_info");
%>
<%
    //User가 신청한 과목정보를 학기별로 가져옴 ex) 11: 1학년 1학기, 32: 3학년 2학기
    String user_subject_11 = (String) request.getAttribute("user_subject_11");      String user_subject_12 = (String) request.getAttribute("user_subject_12");
    String user_subject_21 = (String) request.getAttribute("user_subject_21");      String user_subject_22 = (String) request.getAttribute("user_subject_22");
    String user_subject_31 = (String) request.getAttribute("user_subject_31");      String user_subject_32 = (String) request.getAttribute("user_subject_32");
    String user_subject_41 = (String) request.getAttribute("user_subject_41");      String user_subject_42 = (String) request.getAttribute("user_subject_42");
    String user_subject_51 = (String) request.getAttribute("user_subject_51");      String user_subject_52 = (String) request.getAttribute("user_subject_52");

    //User가 각 학년학기를 들은 수강 연도 안들었으면 -1저장되있음
    String user_year_11 = (String) request.getAttribute("user_year_11");        String user_year_12 = (String) request.getAttribute("user_year_12");
    String user_year_21 = (String) request.getAttribute("user_year_21");        String user_year_22 = (String) request.getAttribute("user_year_22");
    String user_year_31 = (String) request.getAttribute("user_year_31");        String user_year_32 = (String) request.getAttribute("user_year_32");
    String user_year_41 = (String) request.getAttribute("user_year_41");        String user_year_42 = (String) request.getAttribute("user_year_42");
    String user_year_51 = (String) request.getAttribute("user_year_51");        String user_year_52 = (String) request.getAttribute("user_year_52");
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
            <img src=<%=logo_img_track_semester%> />
            <div id="titlename">나의 이수 현황</div>
        </div>
        <div id="container">
            <div id="tab">
                <ul id="tab_2">
                </ul>
            </div>
            <div id="maincontent">
                <div class="contenttitle"style="margin-top:40px";><img src="img/list.gif"> 이수 현황 등록</div>
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
                <div id="sem_div" class="show_sem_sub">

                </div>
                <input style="float:right" class="btn btn-default" type="button" onclick="mySubView()" value="확인">
                <input style="float:right;margin-right:10px;" class="btn btn-default" type="button" onclick="addSemTable()" value="추가">
                <input style="float:right;margin-right:10px;" class="btn btn-default" type="button" onclick="delLastSemTable()" value="마지막 학기 삭제">
                <input style="float:right;margin-right:10px;" class="btn btn-default" type="button" onclick="delLastSemTable_all()" value="초기화">

                <div id="addSem_div" class="show_sem_sub"></div>
            </div>
        </div>
    </div>
<%--    </div>--%>
<%--    </div>--%>
</main>
<%@include file="../main/footer.jsp"%>
<div id="shadow">
    <div id="blur"></div>
</div>
<script>

    function popup_sec(grade, sem) {
        var url = "mytrack_enroll_popup.do?num=";
        url += num + "&val=";
        var yearTmp = grade + "" + sem;
        var grade = parseInt(yearTmp.substr(0, 1));
        var sem = parseInt(yearTmp.substr(1, 1));
        var yearFlag = (grade-1)*2 + sem-1;
        var year = yearList[yearFlag];
        if (year == null) {
            if (yearFlag > 0) {
                year = yearList[yearFlag - 1];
                if (year == null) {
                    alert("이전학기를 등록 완료해야합니다.");
                    return;
                }
            }
            //처음 학기 등록 유저
            if (user.comp_sem == 1) {
                var yearT = parseInt(user.adm_year);
                var semT = 1;
                // var semT = parseInt(year.substr(4, 1));
                url += "null";
                url += yearT + "" + semT + "" + grade + "" + sem;
            }
            else {
                var yearT = parseInt(year.substr(0, 4));
                var semT = parseInt(year.substr(4, 1));
                url += "null";
                if (semT == 1) {
                    url += yearT + "" + (semT + 1) + "" + grade + "" + sem;
                } else {
                    url += (yearT + 1) + "" + (semT - 1) + grade + "" + sem;
                }
            }
        }
        else {
            url += "norm" + year + "" + grade + "" + sem;
        }
        url += '&compSem=' + user.comp_sem;
        var name = "enroll_popup";
        var popupX = (document.body.offsetWidth / 2) - (1000 / 2);
        var popupY= (document.body.offsetHeight / 2) - (300 / 2);
        var popOption = "width=1070, height=850, resizable=no, menubar=no, toolbar=no, scrollbars=no, status=no, left="+ popupX;
        window.open(url, name, popOption);
    }


    //수정버튼 클릭시 popup()
    function popup(input) {
        //팝업 페이지에 전달할 url
        //val: 선택한 수정칸에 존재하는 학년과 학기 정보
        //연도정보는 기존에 선택한 전적이있으면 추가, 없으면 null추가
        //compSem: 유저의 현재 이수학기 => 추가가 가능하므로 전달받아 DB값 변경
        var url = "mytrack_enroll_popup.do?num=";
        url += num + "&val=";
        var yearTmp = input.getAttribute("id").substr(6, 8);
        var grade = parseInt(yearTmp.substr(0, 1));
        var sem = parseInt(yearTmp.substr(1, 1));
        var yearFlag = (grade-1)*2 + sem-1;
        var year = yearList[yearFlag];
        if (year == null) {
            if (yearFlag > 0) {
                year = yearList[yearFlag - 1];
                if (year == null) {
                    alert("이전학기를 등록 완료해야합니다.");
                    return;
                }
            }
            //처음 학기 등록 유저
            if (user.comp_sem == 1) {
                var yearT = parseInt(user.adm_year);
                var semT = 1;
                // var semT = parseInt(year.substr(4, 1));
                url += "null";
                url += yearT + "" + semT;
                url += grade + "" + sem;
            }
            else {
                var yearT = parseInt(year.substr(0, 4));
                var semT = parseInt(year.substr(4, 1));
                url += "null";
                if (semT == 1) {
                    url += yearT + "" + (semT + 1);
                    url += grade + "" + sem;
                } else {
                    url += (yearT + 1) + "" + (semT - 1);
                    url += grade + "" + sem;
                }
            }
        }
        else {
            url += "norm";
            url += year;
            url += grade + "" + sem;
        }
        url += '&compSem=' + user.comp_sem;
        var name = "enroll_popup";

        var popupX = (document.body.offsetWidth / 2) - (1000 / 2);
//&nbsp;만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
        var popupY= (document.body.offsetHeight / 2) - (300 / 2);
//&nbsp;만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
        var popOption = "width=1070, height=850, resizable=no, menubar=no, toolbar=no, scrollbars=no, status=no, left="+ popupX;

        window.open(url, name, popOption);
    }
    // 중간에 추가한 학기 테이블의 DB Value만제거
    function delLastSemTable_select_between(val1, val2) {
        var newComp_sem = user.comp_sem;
        var answer = newComp_sem + "-" + val1 + "" + val2;
        $.ajax({
            url: "ajax.do",
            type: "post",
            data: {
                req: "delete_last_semester_table",
                data: answer,
            },
            success: function() {
                location.reload();
            }
        })
    }
    // 가장 최근에 추가한 학기 테이블 제거, DB Value제거

    function delLastSemTable_select(val1, val2) {
        var newComp_sem = user.comp_sem-1;
        var answer = newComp_sem + "-" + val1 + "" + val2;
        $.ajax({
            url: "ajax.do",
            type: "post",
            data: {
                req: "delete_last_semester_table",
                data: answer,
            },
            success: function() {
                location.reload();
            }
        })
    }
    // 이거를 초기화로 해본다.

    function delLastSemTable_all() {
        var newComp_sem = 0;

        var check_user = confirm("확인 선택시 모든 학기가 삭제됩니다.");
        if (!check_user)
            return;
        var val1 = 1;
        var val2 = 1;
        var answer = newComp_sem + "-" + val1 + "" + val2;
        $.ajax({
            url: "ajax.do",
            type: "post",
            data: {
                req: "delete_all_semester_table",
                data: answer,
            },
            success: function() {
                location.reload();
            }
        })
    }
    // 가장 최근에 추가한 학기 테이블 제거, DB Value제거
    function delLastSemTable() {
        //마지막 학기 테이블의 id값(semN)에서 N값 추출
        var last_child = $("#sem_div").children().last().attr("id");
        if (last_child == null) {
            alert("더이상 삭제할 학기가 존재하지 않습니다.");
            return;
        }
        var check_user = confirm("확인 선택시 최근에 등록한 학기가 삭제됩니다.");
        if (!check_user)
            return;
        var last_child_val = last_child.substr(3, 1);
        if (last_child_val % 2 == 0) {
            var val1 = parseInt(last_child_val / 2);
            var val2 = 2;
        }
        else {
            var val1 = parseInt(last_child_val / 2) + 1;
            var val2 = 1;
        }
        // alert(last_child_val + "=>" + val1 + "-" + val2);
        var newComp_sem = user.comp_sem-1;
        var answer = newComp_sem + "-" + val1 + "" + val2;
        $.ajax({
            url: "ajax.do",
            type: "post",
            data: {
                req: "delete_last_semester_table",
                data: answer,
            },
            success: function() {
                location.reload();
            }
        })
    }
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

    //User가 신청한 과목정보를 학기별로 가져옴 ex) 11: 1학년 1학기, 32: 3학년 2학기
    var comp_sub_11 = <%=user_subject_11%>;         var comp_sub_12 = <%=user_subject_12%>;
    var comp_sub_21 = <%=user_subject_21%>;         var comp_sub_22 = <%=user_subject_22%>;
    var comp_sub_31 = <%=user_subject_31%>;         var comp_sub_32 = <%=user_subject_32%>;
    var comp_sub_41 = <%=user_subject_41%>;         var comp_sub_42 = <%=user_subject_42%>;
    var comp_sub_51 = <%=user_subject_51%>;         var comp_sub_52 = <%=user_subject_52%>;
    var yearList = [<%=user_year_11%>, <%=user_year_12%>, <%=user_year_21%>, <%=user_year_22%>, <%=user_year_31%>, <%=user_year_32%>, <%=user_year_41%>, <%=user_year_42%>, <%=user_year_51%>, <%=user_year_52%>];

    //User가 신청한 과목을 학기별로 테이블 생성
    //세부적인 output 설정
    function createSemesterTable_data_next(sub_arr) {
        if (sub_arr == null)
            return "";
        var output = "";
        for (var i=0; i<sub_arr.length; ++i) {
            var subject = sub_arr[i];
            if (subject.sub_class_ex == "수과")
                output += '<span style="color:blue">' + subject.sub_title + '</span>';
            else
                output += subject.sub_title;
            if (i < sub_arr.length-1)
                output += ", ";
        }
        return output;
    }
    //User가 신청한 과목을 학기별로 테이블 생성
    //데이터를 생성해서 틀에 전달
    function createSemesterTable_data() {
        for (var i=1; i<=5; ++i) {
            for (var j = 1; j <= 2; ++j) {
                var targetID = "#sem_" + i + "_" + j;
                var target = document.querySelector(targetID);
                if (target == null) {
                    return;
                }
                switch (i + "|" + j) {
                    case "1|1":
                        if(comp_sub_11 != null)
                            target.innerHTML = createSemesterTable_data_next(comp_sub_11);
                        break;
                    case "1|2":
                        if(comp_sub_12 != null)
                            target.innerHTML = createSemesterTable_data_next(comp_sub_12);
                        break;
                    case "2|1":
                        if(comp_sub_21 != null)
                            target.innerHTML = createSemesterTable_data_next(comp_sub_21);
                        break;
                    case "2|2":
                        if(comp_sub_22 != null)
                            target.innerHTML = createSemesterTable_data_next(comp_sub_22);
                        break;
                    case "3|1":
                        if(comp_sub_31 != null)
                            target.innerHTML = createSemesterTable_data_next(comp_sub_31);
                        break;
                    case "3|2":
                        if(comp_sub_32 != null)
                            target.innerHTML = createSemesterTable_data_next(comp_sub_32);
                        break;
                    case "4|1":
                        if(comp_sub_41 != null)
                            target.innerHTML = createSemesterTable_data_next(comp_sub_41);
                        break;
                    case "4|2":
                        if(comp_sub_42 != null)
                            target.innerHTML = createSemesterTable_data_next(comp_sub_42);
                        break;
                    case "5|1":
                        if(comp_sub_51 != null)
                            target.innerHTML = createSemesterTable_data_next(comp_sub_51);
                        break;
                    case "5|2":
                        if(comp_sub_52 != null)
                            target.innerHTML = createSemesterTable_data_next(comp_sub_52);
                        break;
                }
            }
        }
    }
    //User가 신청한 과목을 학기별로 테이블 생성
    //틀만 일단 생성
    function createSemesterTable() {
        let totalSem = user.comp_sem;
        var target = document.querySelector('#sem_div');
        var grade = 1;
        var sem = 1;
        var output = "";
        //이수학기를 통해 학년과 학기별로 테이블 생성
        var iTmp = 0;
        for (var i=0; i<totalSem; ++i) {
            var tmp = yearList[iTmp++];
            if (tmp == null) {
                // alert("과목이 존재하지 않는 학기가 존재합니다.");
                break;
            }
            if (i!=0 && i%2==0)
                grade++;
            output += '<table id="sem' + (i+1) + '" ';
            output += 'class="table table-bordered" style="font-size: 13px; border: 2px solid #ddd; margin-bottom: 5px;margin-top:10px;"><tr style="border-bottom: 1px solid #ddd"><td style="background-color: #ECEFF1; font-weight: 600;width: 108px;">';
            output += grade + '학년 ' + sem + '학기';
            output += '<br>(' + tmp.substr(0, 4) + "-" + tmp.substr(4, 4) + ')';
            output += '</td><td id="sem_' + grade + '_' + sem + '"' ;
            output += '></td><td style="width:10%">';
            output += '<input type="button" class="btn btn-default"';
            output += 'id="modify' + grade + sem + '" ';
            output += 'onclick=popup(this) value="수정" style="float:right"></td></tr>';
            output += '</table>';
            if (++sem==3)
                sem = 1;
        }
        target.innerHTML = output;
    }
    //유저가 학기 추가시 추가학기 테이블 생성
    function addSemTable() {
        let totalSem = user.comp_sem;
        if (totalSem+1 > 10) {
            alert('더이상 학기 추가가 불가능합니다.');
            return;
        }
        var target = document.querySelector('#addSem_div');
        var output = target.innerHTML;
        var totalSemTmp = totalSem+1;
        user.comp_sem = totalSemTmp;
        var grade, sem;
        if (totalSemTmp % 2 != 0) {
            grade = totalSemTmp / 2 - 0.5 + 1;
            sem = totalSemTmp%2;
        }
        else {
            grade = totalSemTmp / 2;
            sem = totalSemTmp%2 + 2;
        }
        var yearFlag = ((grade - 1) * 2 + sem - 1);
        alert("Grade: " + grade + ", Sem: " + sem + ", YearFlag: " + yearFlag);
        var year = yearList[yearFlag];
        if (yearFlag > 0) {
            if (year == null) {
                var year_before = yearList[yearFlag - 1];
                // alert("Year=NULL, " + year_before);
                if (year_before == null) {
                    user.comp_sem--;
                    alert("이전학기를 등록 완료해야합니다.");
                    return;
                }
            }
        }
        // $.ajax({
        //     url: "ajax.do",
        //     type: "post",
        //     data: {
        //         req: "add_user_compSem",
        //         data: totalSemTmp,
        //     },
        //     async: false,
        //     success: function () {
        //         alert("학기 1 증가");
        //     }
        // })
        popup_sec(grade, sem);
        // output += '<table id="sem' + (totalSemTmp) + '" ';
        // output += 'class="table table-bordered" style="font-size: 13px; visibility: hidden; border: 2px solid #ddd; margin-bottom: 5px;margin-top:10px;"><tr style="border-bottom: 1px solid #ddd"><td style="background-color: #ECEFF1; font-weight: 600;width: 108px;">';
        // if (user.comp_sem > 8)
        //     output += '(추가)' + sem + '학기';
        // else
        //     output += grade + '학년 ' + sem + '학기';
        // output += '</td><td></td><td style="width:10%"><input type="button" class="btn btn-default"';
        // output += 'id="modify' + grade + sem + '" ';
        // output += 'onclick=popup(this) value="수정" style="float:right"></td></tr></table>';
        // target.innerHTML = output;
        //
        // document.querySelector('#stu_compSem_td').innerHTML = user.comp_sem;
        //
        // var tmpId = "#modify" + grade + "" + sem;
        // $(tmpId).trigger("click");
    }

    function mySubView() {
        location.href="mytrack.do?num=101";
    }

    function testFunc() {
        alert("TEST Function!!!");
    }

    function callSetupTableView(){
        $('#table').bootstrapTable('refresh');
    }

    var list = $('#tab_2');

    var user=<%=user_info%>;
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
        // alert("<유저정보>학번: " + user.id + " 이름: " + user.name + " 트랙제: " + user.track_ex + " 입학년도: " + user.adm_year + " 이수학기: " + user.comp_sem + " 최근 접속시간: " + user.log_date);
        callSetupTableView();
        createUserInfoTable();
        createSemesterTable();
        createSemesterTable_data();
    });

</script>
</body>
</html>