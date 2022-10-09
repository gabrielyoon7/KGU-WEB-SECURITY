<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
    String num = (String) request.getAttribute("num");
    String tabmenulist = (String) request.getAttribute("tabmenulist");

    String stage_data=(String) request.getAttribute("stage_data");
    String back_student = (String) request.getAttribute("back_student");
    String download1 = (String) request.getAttribute("download1");
    String download2 = (String) request.getAttribute("download2");
    long sc = (long) request.getAttribute("sc");
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
                        <div class="contenttitle" style="display : inline-block">기타자격 / 학술대회 제출</div>
                        <div id="etc_button" style="float : right"></div>
                    </li>
                </ul>
                <div id="hey">
                    <div>
                        <div class="contenttitle2">학생정보</div>
                        <table id="graduation_user_info" class="table table-bordered" style="font-size : 13px; border : 2px solid #ddd; margin-bottom : 0;">
                        </table>
                    </div>
                    <br>
                    <div class="contenttitle2">학술대회</div>
                    <div id="modify_main" class="graduation_read_info" style="border : 1.5px solid #ddd"><!-- 졸업논문div -->
                        <ul>
                            <li>
                                <div style="display : flex;">
                                    <div class="profile">학술대회명</div>
                                    <div class="form-group">
                                        <input type="text" class="form-control" id="contest_name" placeholder="제목을 입력하세요" style="width : 620px">
                                    </div>
                                </div>
                            </li>
                            <li>
                                <div style="display:flex">
                                    <div class="profile">자격요건</div>
                                    <div style="margin-right:auto;font-size:12px;">
                                        <label class="checkbox-inline" style="margin-left : 5px;"><input type="checkbox" id="chkbox" value="제1저자">제1저자</label>
                                        <label class="checkbox-inline" style="margin-left : 5px;"><input type="checkbox" id="chkbox" value="지도교수지도">지도교수지도</label>
                                        <label class="checkbox-inline" style="margin-left : 5px;"><input type="checkbox" id="chkbox" value="발표완료">발표완료</label>
                                        <label class="checkbox-inline" style="margin-left : 5px;"><input type="checkbox" id="chkbox" value="17.12.01이후">17.12.01이후</label>
                                    </div>
                                </div>
                            </li>
                            <li>
                                <div style="display:flex;">
                                    <div class="profile">논문제목</div>
                                    <div class="form-group">
                                        <input type="text" class="form-control" id="thesis" placeholder="제목을 입력하세요" style="width : 620px">
                                    </div>
                                </div>
                            </li>
                            <li>
                                <div style="display:flex">
                                    <div class="profile">개최기관</div>
                                    <div class="form-group">
                                        <input type="text" class="form-control" id="openplace" style="width : 263px;" placeholder="개최기관을 입력하세요">
                                    </div>
                                    <div class="profile" style="margin-left : 10px">학회개시일</div>
                                    <input type="date" class="form-control" style="width:263px; margin-left:5px;" id="Inputdate" name = "new_date">
                                </div>
                            </li>
                            <li>
                                <div id="uploadfile1" style="display:flex">
                                    <div class="profile">논문파일</div>
                                </div>
                            </li>
                            <li>
                                <div id="uploadfile2" style="display:flex">
                                    <div class="profile">기타증빙</div>
                                </div>
                            </li>
                        </ul>
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
    var list = $('#tab_2');
    var tabmenu =<%=tabmenulist%>;
    var number =<%=num%>;
    var download1 = <%=download1%>;
    var download2 = <%=download2%>;
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
    var sc = <%=sc%>;
    var userlist=$('#graduation_user_info');
    var download1 = <%= download1 %>;
    var download2 = <%= download2 %>;
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
        a+='<ul><li><div style="display : flex"><div class="profile">학술대회명</div><div class="form-group"><input type="text" class="form-control" id="contest_name" placeholder="제목을 입력하세요" value="' + stage_data.conferenceName + '" style="width : 620px" readonly></div></li>';
        a+='<li><div style="display:flex"><div class="profile">자격요건</div><div style="margin-right:auto;font-size:12px;">';//answer2
        a+='<label class="checkbox-inline" style="margin-left : 5px;" ><input type="checkbox" id="chkbox" value="제1저자" checked disabled>제1저자</label><label class="checkbox-inline" style="margin-left : 5px;" ><input type="checkbox" id="chkbox" value="지도교수지도" checked disabled>지도교수지도</label><label class="checkbox-inline" style="margin-left : 5px;"><input type="checkbox" id="chkbox" value="발표완료" checked disabled>발표완료</label><label class="checkbox-inline" style="margin-left : 5px;"><input type="checkbox" id="chkbox" value="17.12.01이후" checked disabled>17.12.01이후</label></li>';
        a+='<li><div style="display: flex"><div class="profile">논문제목</div><div class="form-group"><input type="text" class="form-control" id="thesis" placeholder="제목을 입력하세요" style="width : 620px" value="' + stage_data.thesisTitle + '" readonly></div></li>';
        a+='<li><div style="display:flex"><div class="profile">개최기관</div><div class="form-group"><input type="text" class="form-control" id="openplace" style="width : 263px;" placeholder="개최기관을 입력하세요" value="' + stage_data.organization + '" readonly></div><div class="profile" style="margin-left : 10px">학회개시일</div><input type="date" class="form-control" style="width:280px; margin-left : 5px;" id="Inputday" name = "new_date" value="' + makeDate(sc) + '" readonly></div></li>';
        a+='<li><div id="uploadfile1" style="display:flex"><div class="profile">논문 파일</div><div style="margin-left: 5px">'+stage_data.thesisFileName+'</div><div style="margin-right:5px; margin-left : 10px"><a href="download_back.do?id='+back_students.per_id+'&stage=6"><button class="btn btn-default" style="padding : 3px 10px;"><img src="img/downloadBtn.png"></button></a></div></div></li>';
        a+='<li><div id="uploadfile1" style="display:flex"><div class="profile">증명 파일</div><div style="margin-left: 5px">'+stage_data.proofFileName+'</div><div style="margin-right:5px; margin-left : 10px"><a href="download_back.do?id='+back_students.per_id+'&stage=7"><button class="btn btn-default" style="padding : 3px 10px;"><img src="img/downloadBtn.png"></button></a></div></div></li>';

        var x=0;
        modifymain.append(a);
        $('input:checkbox[id=chkbox]').each(function(){
            if($(this).val()==stage_data.requirement){
                $(this).prop("checked",true);
                x++;
            }
        });
        if(x == 0){
            $('#etc_name').val(stage_data.requirement);
            $('#etcxx').prop('checked',true);
        }

        return a;
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