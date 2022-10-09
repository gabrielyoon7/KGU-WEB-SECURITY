<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    StringBuffer url2_grd_mlist = request.getRequestURL();
    String logo_img_grd_mlist;

    //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
    //ai이면 ai로고 cs이면 cs로고
    if (url2_grd_mlist.substring(7, 9).equals("ai") || url2_grd_mlist.substring(7, 9).equals("lo")) {
        logo_img_grd_mlist = "img/graduation_ai.png";
    } else {
        logo_img_grd_mlist = "img/graduation.png";
    }
    //System.out.println((logo_img_grd_mlist));
%>
<%
    String userlist = (String) request.getAttribute("userlist");
    String tabmenulist = (String) request.getAttribute("tabmenulist");
%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="utf-8">
    <title>관리리스트 : 경기대학교 AI컴퓨터공학부</title>
    <link rel="stylesheet" href="css/bootstrap-table.css">
    <link href='css/bootstrap.css' rel='stylesheet' type='text/css'>
    <link href='css/default.css' rel='stylesheet' type='text/css'>
    <link href='css/boardtable.css' rel='stylesheet' type='text/css'>
    <link href='css/information.css' rel='stylesheet' type='text/css'>
    <link href='css/content.css' rel='stylesheet' type='text/css'>
    <link href='css/bootstrap-table.css' rel='stylesheet' type='text/css'>
    <style>
        #maincontent {
            padding: 0;
        }

        #maincontent > ul {
            padding: 10px;
        }

        .boardtable > thead > tr > th:nth-child(1) {
            min-width: 20px;
        }

        .boardtable > tbody > tr > td:nth-child(1) {
            min-width: 20px;
        }

        .boardtable > thead > tr > th:nth-child(2) {
            min-width: 40px;
            max-width: 40px;
        }

        .boardtable > thead > tr > th:nth-child(4) {
            width: 80px;
        }

        .boardtable > tbody > tr > td:nth-child(2) {
            font-family: 'Nanum Gothic', sans-serif;
            min-width: 40px;
            max-width: 40px;
        }

        .boardtable > tbody > tr > td:nth-child(4) {
            width: 100px;
        }

        .boardtable > tbody > tr > td:nth-child(5), .boardtable > thead > tr > th:nth-child(5) {
            min-width: 65px;
            max-width: 65px;
        }

        .boardtable > tbody > tr > td:nth-child(6), .boardtable > thead > tr > th:nth-child(6) {
            min-width: 75px;
            max-width: 75px;
        }

        .boardtable > tbody > tr > td:nth-child(7), .boardtable > tbody > tr > td:nth-child(8),
        .boardtable > tbody > tr > td:nth-child(9), .boardtable > tbody > tr > td:nth-child(10),
        .boardtable > tbody > tr > td:nth-child(11), .boardtable > thead > tr > th:nth-child(7),
        .boardtable > thead > tr > th:nth-child(8), .boardtable > thead > tr > th:nth-child(9),
        .boardtable > thead > tr > th:nth-child(10), .boardtable > thead > tr > th:nth-child(11) {
            min-width: 65px;
            max-width: 65px;
        }
    </style>
</head>
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
            <img src=<%=logo_img_grd_mlist%>/>
            <div>졸업논문</div>
        </div>
        <div id="container">
            <div id="tab">
                <ul id="tab_2">
                </ul>
            </div>
            <div id="maincontent">
                <ul>
                    <li>
                        <div class="contenttitle">졸업논문 관리</div>
                    </li>
                </ul>
                <table class="boardtable" id="table" data-toggle="table"
                       data-pagination="true" data-search="true"
                       data-side-pagination="true" data-page-list="[10]">
                    <thead>
                    <tr>
                        <th data-field="state" data-checkbox="true"></th>
                        <th data-field="index" data-sortable="true">번호</th>
                        <th data-field="per_id" data-sortable="true">학번</th>
                        <th data-field="name" data-sortable="true">이름</th>
                        <th data-field="prof_name" data-sortable="true">교수</th>
                        <th data-field="graduation_date" data-sortable="true">졸업</th>
                        <th data-field="form_request" data-sortable="true">신청</th>
                        <th data-field="form_suggest" data-sortable="true">제안</th>
                        <th data-field="form_mid" data-sortable="true">중간</th>
                        <th data-field="form_final" data-sortable="true">최종</th>
                        <th data-field="form_etc" data-sortable="true">기타</th>
                    </tr>
                    </thead>
                </table>

                <div id="buttonmenu" style="margin-top: 10px;"></div>
            </div>
        </div>
    </div>
</main>
<%@include file="../main/footer.jsp" %>
<div id="shadow">
    <div id="blur"></div>
</div>
<script>
    var users =<%=userlist%>;
    var list = $('#tab_2');
    var tabmenu =<%=tabmenulist%>;
    for (var i = 0; i < tabmenu.length; ++i) {
        var value = tabmenu[i];
        var num = value.tab_id * 10 + value.orderNum;
        var text = '<li><span class="deco_dot">●</span><a href="'
            + value.path + '?num=' + num + '">' + value.page_title
            + '</a></li>'
        list.append(text);
    }

    function make_state(state_num, stage_num, perid) {//유저 한줄 던져줘 학번,이름,각단계상태... 학번
        var result;  //표시될 상태, 링크주소

        if (stage_num == 5) {
            if (state_num == 1) {
                result = '자격없음';
            } else if (state_num == 2) {
                result = "-";
            } else if (state_num == 3) {
                result = '대기';
            } else if (state_num == 4) {
                result = '미제출';
            } else if (state_num == 5) {
                result = '지연';
            } else if (state_num == 6) {
                result = '<a href="graduation_manage.do?num=94&perid=' + perid + '">○</a>'
            } else {
                result = '<a href="graduation_manage.do?num=94&perid=' + perid + '">승인</a>';
            }
            return result;
        } else {
            if (state_num == 1) {
                result = '자격없음';
            } else if (state_num == 2) {
                result = "-";
            } else if (state_num == 3) {
                result = '대기';
            } else if (state_num == 4) {
                result = '미제출';
            } else if (state_num == 5) {
                result = '지연';
            } else if (state_num == 6) {
                result = '<a href="graduation_form.do?num=94&per_id=' + perid + '&stage=' + stage_num + '&modify=2">○</a>';
            } else if (state_num == 7) {
                result = '<a href="graduation_form.do?num=94&per_id=' + perid + '&stage=' + stage_num + '&modify=2">승인</a>';
            }
            return result;
        }
    }


    function callSetupTableView() {
        $('#table').bootstrapTable('append', data());
        $('#table').bootstrapTable('refresh');
    }

    function data() {
        var rows = [];
        for (var i = 0; i < users.length; i++) {//전체유저
            var value = users[i];
            var pid = value.per_id;
            var result_1 = null; //신청
            var result_2 = null; //제안
            var result_3 = null; //중간
            var result_4 = null; //최종
            var result_5 = null; //기타
            result_1 = make_state(value.request, 1, pid);
            result_2 = make_state(value.suggest, 2, pid);
            result_3 = make_state(value.interim, 3, pid);
            result_4 = make_state(value.fin, 4, pid);
            result_5 = make_state(value.level_num, 5, pid);


            rows.push({
                index: i + 1,
                per_id: value.per_id,
                name: '<a href="graduation_manage.do?num=94&perid=' + value.per_id + '">' + value.name + '</a>',
                prof_name: value.prof_name,
                graduation_date: value.graduation_date,
                form_request: result_1,
                form_suggest: result_2,
                form_mid: result_3,
                form_final: result_4,
                form_etc: result_5
            });
        }
        return rows;
    }


    $(document).ready(function () {
        callSetupTableView();

    })

    function formatmd(date, comma) {
        var d = new Date(date), month = '' + (d.getMonth() + 1), day = ''
            + d.getDate();

        if (month.length < 2)
            month = '0' + month;
        if (day.length < 2)
            day = '0' + day;

        return [month, day].join(comma);
    }
</script>
</body>
</html>