
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
    String num = (String) request.getAttribute("num");
    String tabmenulist = (String) request.getAttribute("tabmenulist");

    String stage_data=(String) request.getAttribute("stage_data");
    String back_student = (String) request.getAttribute("back_student");
    long sc = (long) request.getAttribute("sc");
    String download = (String) request.getAttribute("download");

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
            text-align: center;
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
            margin-left: 5px;
            width: 620px;
            overflow-wrap: break-word;
            height: auto;
            padding-bottom: inherit;
        }

        .profile {
            background-color: #ECEFF1;
            font-weight: bold;
            display: inline-block;
            width: 80px;
            text-align: right;
            padding-right: 5px;
            height: auto;
            padding-bottom: inherit;
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
            font-size: 12px;
            display: inline-block;
            margin-right: 5px;
            text-align: left;
            width: 630px;
            height: 100px;
            line-height: normal;
        }

        .form-group {
            margin-bottom: 0;
            margin-left: 5px;
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
                        <div class="contenttitle" style="display: inline-block">기타자격
                            / 자격증 제출</div>
                        <div id="etc_button" style="float: right"></div>
                    </li>
                </ul>
                <div id="hey">
                    <div>
                        <div class="contenttitle2">학생정보</div>
                        <table id="graduation_user_info" class="table table-bordered"
                               style="font-size: 13px; border: 2px solid #ddd; margin-bottom: 0;">
                        </table>
                    </div>
                    <br>
                    <div class="contenttitle2">자격증</div>
                    <div id="modify_main" class="graduation_read_info"
                         style="border: 1.5px solid #ddd">
                        <!-- 졸업논문div -->
                        <ul>
                            <li>
                                <div style="display: flex">
                                    <div class="profile" style="padding-top: 45px;">자격요건</div>
                                    <div>
                                        <div class="radio" style="margin-left: 5px">
                                            <label> <input type="radio" name="select_license"
                                                           value="정보처리기사">정보처리기사
                                            </label>
                                        </div>
                                        <div class="radio" style="margin-left: 5px">
                                            <label> <input type="radio" name="select_license"
                                                           value="SQLD">SQLD
                                            </label>
                                        </div>
                                        <div class="radio" style="margin-left: 5px; display: flex">
                                            <label> <input type="radio" name="select_license"
                                                           value="ETC">기타
                                            </label>
                                            <div class="form-group">
                                                <input type="text" class="form-control" id="etc_name"
                                                       style="width: 160px; margin-left: 5px"
                                                       placeholder="직접 입력하세요">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </li>
                            <li>
                                <div style="display: flex">
                                    <div class="profile">자격증번호</div>
                                    <div class="form-group">
                                        <input type="text" class="form-control" id="licensenum"
                                               style="width: 250px;" placeholder="직접 입력하세요">
                                    </div>
                                </div>
                            </li>
                            <li>
                                <div style="display: flex">
                                    <div class="profile">발급기관</div>
                                    <div class="form-group">
                                        <input type="text" class="form-control" id="licenseplace"
                                               style="width: 250px;" placeholder="직접 입력하세요">
                                    </div>
                                    <div class="profile" style="margin-left: 10px">취득일</div>
                                    <input type="date" class="form-control"
                                           style="width: 280px; margin-left: 5px;" id="Inputday"
                                           name="new_date">
                                </div>
                            </li>
                            <li>
                                <div id="uploadfile1" style="display: flex">
                                    <div class="profile">자격증사본</div>
                                    <div style="margin-left: 5px; margin-top: 7px">
                                        <input type="file" name="uploadFile" id="uploadFile"
                                               accept=".hwp, .doc, .docx, .pdf">
                                    </div>
                                    <%--<div style="margin-right: auto">
                                        <button class="btn btn-default" onclick="uploadfile()"
                                                style="padding: 3px 10px">
                                            <img src="img/uploadBtn.png">
                                        </button>
                                    </div>--%>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
                <%--<div>
                    <!-- 서명 + 버튼div -->
                    <div id="sign" class="text-right">
                        서명
                        <div class="form-group" style="display: inline-block">
                            <input type="text" class="form-control" id="signature"
                                   placeholder="본인의 이름을 입력">
                        </div>
                        <button type="button" style="margin: 2px;" class="btn btn-default"
                                onclick="insert_license()">완료</button>
                        <a href="javascript:history.go(-1)"><button type="button"
                                                                    style="margin: 2px;" class="btn btn-default">취소</button></a>
                    </div>
                </div>
                --%>
                <a href="javascript:history.back()"><button type="button"
                                                            style="margin: 2px;" class="btn btn-default">취소</button></a>
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
    var sc = <%=sc%>;
    var download = <%= download %>
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
        var modifymain=$('#modify_main');
        modifymain.empty();
        var a='';
        a+='<ul id="modifyUL"><li><div style="display:flex"><div class="profile" style="padding-top : 45px;">자격요건</div><div>';
        a+='<div class="radio" style="margin-left : 5px"><label><input type="radio" name="select_license" value="정보처리기사" checked disabled>정보처리기사</label></div>' +
            '<div class="radio" style="margin-left : 5px"><label><input type="radio" name="select_license" value="SQLD" checked disabled>SQLD</label></div>';
        a+='<li><div style="display:flex"><div class="profile">자격증번호</div><div class="form-group"><input type="text" class="form-control" id="licensenum" style="width : 250px;" placeholder="직접 입력하세요" value="' + stage_data.cerId + '" readonly></div></li>';
        a+='<li><div style="display:flex"><div class="profile">발급기관</div><div class="form-group"><input type="text" class="form-control" id="licenseplace" style="width : 250px;" placeholder="직접 입력하세요" value="' + stage_data.organization + '" readonly></div><div class="profile" style="margin-left : 10px">취득일</div><input type="date" class="form-control" style="width:280px; margin-left : 5px;" id="Inputday" name = "new_date" value="' + makeDate(sc) + '" readonly></div></li>';
        //다운로드버튼
        a+='<li><div id="uploadfile1" style="display:flex"><div class="profile">자격증사본</div><div style="margin-left: 5px">'+download+'</div><div style="margin-right:5px; margin-left : 10px"><a href="download_back.do?id='+back_students.per_id+'&stage=3"><button class="btn btn-default" style="padding : 3px 10px;"><img src="img/downloadBtn.png"></button></a></div></div></li>';
        var x=0;
        modifymain.append(a);
        $('input:radio[name=select_license]').each(function(){
            if($(this).val()==stage_data.requirement){
                $(this).prop("checked",true);
                x++;
            }
        });
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