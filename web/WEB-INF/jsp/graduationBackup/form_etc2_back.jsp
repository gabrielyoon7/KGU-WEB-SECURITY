<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%

    String num = (String) request.getAttribute("num");
    String tabmenulist = (String) request.getAttribute("tabmenulist");

    String stage_data=(String) request.getAttribute("stage_data");
    String back_student = (String) request.getAttribute("back_student");
    String download = (String) request.getAttribute("download");
    long sc1 = (long) request.getAttribute("sc1");
    long sc2 = (long) request.getAttribute("sc2");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta name="subject"
          content="Kyonggi University Department of Computer Science">
    <meta name="author" content="Kyonggi Univ. SSF">
    <meta name="keyword"
          content="경기대학교, 컴퓨터과학과, Kyonggi University, Computer Science">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="utf-8">
    <title>경기대학교 AI컴퓨터공학부</title>
    <link href='./css/default.css' rel='stylesheet' type='text/css'>
    <link href='./css/boardtable.css' rel='stylesheet' type='text/css'>
    <link href='./css/content.css' rel='stylesheet' type='text/css'>
    <link href='css/bootstrap.css' rel='stylesheet' type='text/css'>
    <link href='./css/information.css' rel='stylesheet' type='text/css'>
    <script src="./js/default.js"></script>
    <script src="./js/jquery-3.2.1.min.js"></script>
    <script src='js/sha256.js'></script>
    <style>
        table {
            text-align : center;
        }

        .graduation_write_info {
            padding: 5px;
            border: 1px solid #607D8B;
            font-size: 13px;
            display: flex;
            margin: auto;
            margin-bottom: 10px;
        }
        .graduation_read_info {
            padding: 5px;
            border: 1px solid #607D8B;
            font-size: 13px;
            display: flex;
            margin: auto;
            margin-bottom: 10px;
        }

        .inform {
            display: inline-flex;
            text-align: left;
            margin-left : 5px;
            width : 620px;
            overflow-wrap:break-word;
            height : auto;
            padding-bottom:inherit;
        }

        .profile {
            background-color : #ECEFF1;
            font-weight: bold;
            display: inline-block;
            width: 80px;
            text-align: right;
            padding-right : 5px;
            height : auto;
            padding-bottom:inherit;
        }

        .explain {
            font-size: 13px;
            display: inline-block;
            border: 1px solid #607D8B;
            margin-right: 5px;
            padding-right: 5px;
            text-align: left;
            width: 380px;
            height: 120px
        }
        .explain2 {
            font-size : 12px;
            display: inline-block;
            margin-right: 5px;
            text-align: left;
            width: 630px;
            height: 100px;
            line-height : normal;
        }

        .form-group {
            margin-bottom : 0;
            margin-left : 5px;
        }
    </style>
</head>
<body>
<%@include file="../main/header.jsp"%>
<main>
    <div id="content">
        <div id="title">
            <img src="img/graduation.png" alt="">
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
                        <div class="contenttitle" style="display : inline-block">기타자격 / 공모전 제출</div>
                        <div id="etc_button" style="float : right"></div>
                    </li>
                </ul>
                <div>
                    <div id="hey">
                        <div><!-- 학생정보 div -->
                            <div class="contenttitle2">학생정보</div>
                            <table id="graduation_user_info" class="table table-bordered" style="font-size : 13px; border : 2px solid #ddd; margin-bottom : 0;">
                            </table>
                        </div>
                        <br>
                        <div class="contenttitle2">공모전</div>
                        <div id="modify_main" class="graduation_read_info" style="border : 1.5px solid #ddd"><!-- 졸업논문div -->
                            <ul>
                                <li>
                                    <div style="display : flex;">
                                        <div class="profile">공모전명</div>
                                        <div class="form-group">
                                            <input type="text" class="form-control" id="contest_name" placeholder="제목을 입력하세요" style="width : 620px">
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div style="display:flex">
                                        <div class="profile">팀유형</div>
                                        <div>
                                            <div style="margin-right:auto;font-size:12px;">
                                                <label class="radio-inline" style="margin-left : 5px"><input type="radio" name="select_license" value="1인팀" checked>1인팀</label>
                                                <label class="radio-inline" style="margin-left : 5px"><input type="radio" name="select_license" value="2인이상(경기대)" checked>2인이상(경기대)</label>
                                                <label class="radio-inline" style="margin-left : 5px"><input type="radio" name="select_license" value="2인이상(타대학연합)" checked>2인이상(타대학연합)</label>
                                            </div>
                                        </div>
                                </li>
                                <li>
                                    <div style="display:flex">
                                        <div class="profile">시상내역</div>
                                        <div class="form-group">
                                            <input type="text" class="form-control" id="price" style="width : 263px;" placeholder="직접 입력하세요">
                                        </div>
                                        <div class="profile" style="margin-left : 10px">개최기관</div>
                                        <div class="form-group">
                                            <input type="text" class="form-control" id="openorgan" style="width : 263px;" placeholder="직접 입력하세요">
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div style="display:flex">
                                        <div class="profile">시상일</div>
                                        <input type="date" class="form-control" style="width:263px; margin-left : 5px;" id="receivedate" name = "new_date">
                                        <div class="profile" style="margin-left : 10px">대회개최일</div>
                                        <input type="date" class="form-control" style="width:263px; margin-left : 5px;" id="opencontest" name = "new_date">
                                    </div>
                                </li>
                                <li>
                                    <div id="uploadfile1" style="display:flex">
                                        <div class="profile">상장사본</div>
                                    </div>
                                </li>
                                <li>
                                    <div id="uploadfile2" style="display:flex">
                                        <div class="profile">추가자료</div></div>
                                </li>
                            </ul>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</main>

<script>
    var list = $('#tab_2');
    var tabmenu =<%=tabmenulist%>;
    var number =<%=num%>;
    for (var i = 0; i < tabmenu.length; ++i) {
        var value = tabmenu[i];
        var num = value.tab_id * 10 + value.orderNum;
        var text = '<li><span class="deco_dot">●</span><a href="'
            + value.path + '?num=' + num + '">' + value.page_title
            + '</a></li>'
        list.append(text);
    }

    var stage_data = <%=stage_data%>;
    var back_students = <%=back_student%>;
    var userlist=$('#graduation_user_info');
    var download = <%= download %>;
    var sc1 = <%=sc1%>;
    var sc2 = <%=sc2%>;

    function insertStudent(){
        var a = '';
        a += '<tr style="border-bottom : 1px solid #ddd">';
        a += '<td style="background-color : #ECEFF1; font-weight: 600;">학번</td><td>' + back_students.per_id + '</td><td style="background-color : #ECEFF1; font-weight: 600;">졸업시기</td><td>'
            + back_students.graduation_date + '</td><td style="background-color : #ECEFF1; font-weight: 600;">지도교수</td><td>'
            + back_students.prof_name + '</td>';
        a += '</tr>';
        a += '<tr style="border-bottom : 1px solid #ddd">';
        a += '<td style="background-color : #ECEFF1; font-weight: 600;">이름</td><td>' + back_students.name + '<td style="background-color : #ECEFF1; font-weight: 600;">소속학과</td><td>' + back_students.major
            +'</td>';
        a += '</tr>';
        a += '<tr style="border-bottom : 1px solid #ddd">';
        a +=  '</td><td></td><td></td><td></td><td></td>';
        a += '</tr>';
        return a;
    }
    function insertData(){
        var a = '';
        var modifymain=$('#modify_main');
        modifymain.empty();
        a += '<ul><li><div style="display:flex"><div class="profile">공모전명</div><div class="form-group"><input type="text" class="form-control" id="contest_name" placeholder="제목을 입력하세요" style="width : 620px" value="' + stage_data.contestName + '" readonly></div></div></li>';
        a += '<li><div style="display:flex"><div class="profile">팀유형</div><div>';
        a += '<div style="margin-right:auto;font-size:12px;">';
        a += '<label class="radio-inline" style="margin-left : 5px"><input type="radio" name="select_license" value="1인팀" checked disabled>1인팀</label>'
        a += '<label class="radio-inline" style="margin-left : 5px"><input type="radio" name="select_license" value="2인이상(경기대)" checked disabled>2인이상(경기대)</label>'
        a += '<label class="radio-inline" style="margin-left : 5px"><input type="radio" name="select_license" value="2인이상(타대학연합)" checked disabled>2인이상(타대학연합)</label></li>'
        a += '<li><div style="display:flex"><div class="profile">시상내역</div><div class="form-group"><input type="text" class="form-control" id="price" style="width : 263px;" placeholder="직접 입력하세요" value="' + stage_data.contestContent + '" readonly></div><div class="profile" style="margin-left : 10px">개최기관</div><div class="form-group"><input type="text" class="form-control" id="openorgan" style="width : 263px;" placeholder="직접 입력하세요" value="' + stage_data.organization + '" readonly></div></div>';
        a += '<li><div style="display:flex"><div class="profile">시상일</div><input type="date" class="form-control" style="width:263px; margin-left : 5px;" id="receivedate" name = "new_date" value ="' + makeDate(sc1) + '" readonly><div class="profile" style="margin-left : 10px">대회개최일</div><input type="date" class="form-control" style="width:263px; margin-left : 5px;" id="opencontest" name = "new_date" value ="' + makeDate(sc2) + '" readonly></div>';

        a+='<li><div id="downMid" style="display:flex"><div class="profile">수상 파일</div>';
        a+='<div style="margin-left: 5px">'+stage_data.awardFileName+'</div><div style="margin-right:5px; margin-left : 10px"><a href="download_back.do?id='+stage_data.perId+'&stage=4"><button class="btn btn-default" style="padding : 3px 10px;"><img src="img/downloadBtn.png"></button></a></div></div></li>';

        a+=   '<li><div id="downFinal" style="display:flex"><div class="profile">추가 파일</div>';
        a+='<div style="margin-left: 5px">'+stage_data.addFileName+'</div><div style="margin-right:5px; margin-left : 10px"><a href="download_back.do?id='+stage_data.perId+'&stage=5"><button class="btn btn-default" style="padding : 3px 10px;"><img src="img/downloadBtn.png"></button></a></div></div></li>';

        var x=0;
        modifymain.append(a);
        $('input:radio[name=select_license]').each(function(){
            if($(this).val()==stage_data.teamType){
                $(this).prop("checked", true);
                x++;
            }
        });
        if(x == 0){
            $('#etc_name').val(stage_data.teamType);
            $('#etcxx').prop('checked',true);
        }

    }
    function makeDate(sc){
        var d = new Date(sc),
            month = '' + (d.getMonth() + 1),
            day = '' + d.getDate(),
            year = d.getFullYear();

        if (month.length < 2) month = '0' + month;
        if (day.length < 2) day = '0' + day;

        return [year, month, day].join('-');

    }
    $(document).ready(function(){
        userlist.append(insertStudent());
        insertData();
    })
</script>
</body>
</html>