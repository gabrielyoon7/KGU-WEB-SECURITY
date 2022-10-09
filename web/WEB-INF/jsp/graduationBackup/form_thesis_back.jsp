<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
    String num = (String) request.getAttribute("num");
    String tabmenulist = (String) request.getAttribute("tabmenulist");//관리자탭메뉴
    String back_student = (String) request.getAttribute("back_student");
    String stage_data = (String)request.getAttribute("stage_data");
    String interim_download = (String)request.getAttribute("interim_download");
    String final_download = (String)request.getAttribute("final_download");

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
                <ul><li><div class="contenttitle">졸업논문 조회</div></li></ul>
                <div>
                    <div>
                        <div class="contenttitle2">학생정보</div>
                        <table id="graduation_user_info" class="table table-bordered" style="font-size : 13px; border : 2px solid #ddd; margin-bottom : 0;">
                        </table>
                        <br>
                        <div class="contenttitle2">졸업논문</div>
                        <div id="modify_main" class="graduation_read_info" style="border : 1.5px solid #ddd">
                            <ul>
                                <li>
                                    <div style="display: flex">
                                        <div class="profile">제목</div>
                                        <div class="form-group">
                                            <input type="text" class="form-control" id="mid_name" placeholder="제목을 입력하세요" style="width : 620px">
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div id="thesis_what" style="display:flex">
                                        <div class="profile">구분</div>
                                        <div class="form-group">
                                            <input type="text" class="form-control" id="classification_name" placeholder="구분을 입력하세요" style="width : 620px">
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div style="display : flex">
                                        <div class="profile">키워드</div>
                                        <div id=keyword_field style="display:inline-block; width : 600px">
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div style="display : flex">
                                        <div class="profile" style="padding-top : 85px">제안서 내용</div>
                                        <div class="form-group" style="display : inline-block; width : 620px;">
                                            <textarea class="form-control" id="suggest_content" rows=10></textarea>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div style="display:flex">
                                        <div class="profile" style="padding-top : 50px">중간보고서 진행내용</div>
                                        <div class="form-group" style="display : inline-block; width : 620px;">
                                            <textarea class="form-control" id="progress_content" rows=6 placeholder="진행내용을 입력하세요"></textarea>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div style="display:flex">
                                        <div class="profile" style="padding-top : 50px">중간보고서 향후계획</div>
                                        <div class="form-group" style="display : inline-block; width : 620px;">
                                            <textarea class="form-control" id="plan_content" rows=6 placeholder="향후계획을 입력하세요"></textarea>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div style="display: flex">
                                        <div class="profile" style="padding-top : 40px">자격요건</div>
                                        <div style="margin-left : 5px">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" name="chkbox" value="논문양식파일사용">
                                                    논문양식파일사용
                                                </label>
                                            </div>
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" name="chkbox" value="목차,서론,본론,결론,참고문헌 포함">
                                                    목차,서론,본론,결론,참고문헌 포함
                                                </label>
                                            </div>
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" name="chkbox" value="본인이 직접 작성한 파일임을 확인함">
                                                    본인이 직접 작성한 파일임을 확인함
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div id="downMid" style="display:flex">
                                        <div class="profile">중간보고서 파일제출</div>
                                        <div style="margin-left:5px; margin-top : 7px"><input type="file" name="uploadFile" id="downloadMid" accept=".hwp, .doc, .docx, .pdf"></div>
                                        <div style="margin-right:auto"><button class="btn btn-default" onclick="uploadfile()" style="padding: 3px 10px"><img src="img/uploadBtn.png"></button></div>
                                    </div>
                                </li>
                                <li>
                                    <div id="downFinal" style="display: flex">
                                        <div class="profile">최종보고서 파일제출</div>
                                        <div style="margin-left:5px; margin-top : 7px"><input type="file" name="uploadFile" id="downloadFinal" accept=".hwp, .doc, .docx, .pdf"></div>
                                        <div style="margin-right:auto"><button class="btn btn-default" onclick="uploadfile()" style="padding: 3px 10px"><img src="img/uploadBtn.png"></button></div>
                                    </div>
                                </li>
                                <li>
                                    <div style="display: flex">
                                        <div class="profile">쪽수</div>
                                        <div>
                                            <div class="form-group">
                                                <input type="number" class="form-control" id="final_page" style="width : 80px">
                                            </div>
                                        </div>
                                        <div style="margin-left : 5px;">쪽</div><div style="font-size: 11px; margin-left: 5px">(서론/본론/결론/참고문헌 부분 쪽수, 표지/목차 제외)</div>
                                    </div>
                                </li>
                            </ul>
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

    var back_students = <%=back_student%>;
    var stage_data = <%=stage_data%>;
    var interim_download = <%=interim_download%>;
    var final_download = <%=final_download%>;

    var userlist=$('#graduation_user_info');

    $(document).ready(function(){
        userlist.append(insertStudent());
        insertData();
    })

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
        var a = '';
        var word = stage_data.keyword;
        var keyword = word.split("/");

        a+='<ul><li><div style="display: flex"><div class="profile">제목</div><div class="form-group"><input type="text" class="form-control" id="mid_name" placeholder="제목을 입력하세요" style="width : 620px" value="' + stage_data.title + '" readonly></div></div></li>';

        a+='<li>';
        a+='<div class="profile">구분</div>';
        if(stage_data.classification=="구현논문"){ //classification
            a+='<label class="radio-inline" style="margin-left : 5px"><input type="radio" name="thesis" value="구현논문" checked disabled>구현논문</label><label class="radio-inline" style="margin-left : 20px"><input type="radio" name="thesis" value="조사(이론)논문" disabled>조사(이론)논문</label></li>';
        }else{
            a+='<label class="radio-inline" style="margin-left : 5px"><input type="radio" name="thesis" value="구현논문" disabled>구현논문</label><label class="radio-inline" style="margin-left : 20px"><input type="radio" name="thesis" value="조사(이론)논문" checked disabled>조사(이론)논문</label></li>';
        }

        a+='<li><div style="display: flex"><div class="profile">키워드</div><div id=keyword_field style="display:inline-block; width : 600px">';
        for(var i=0;i<(keyword.length-1);i++) {
            a += '<div id="kwddiv' + (i / 2) + '"><div class="form-group" style="display : inline-block"><input type="text" class="form-control" id="kwd' + i + '" placeholder="키워드" value="' + keyword[i] + '" readonly></div><div class="form-group" style="display : inline-block"><input type="text" class="form-control" id="kwd' + (i + 1) + '" placeholder="키워드" value="' + keyword[i + 1] + '" readonly></div>';
            i++;
        }
        a+='</div></li>';

        a+='<li><div style="display: flex"><div class="profile">내용</div><div class="form-group" style="display : inline-block; width : 620px"><textarea class="form-control" id="suggest_content" rows=10 readonly>'+stage_data.proposalContent+'</textarea></div></div></li>';

        a+=   '<li><div style="display:flex"><div class="profile" style="padding-top : 40px">자격요건</div>';
        a+=   '<div id="checkboxx" style="margin-left : 5px;">';
        a+=   '<div class="checkbox"><label><input type="checkbox" id="chkbox" class="chkbox" value="논문양식파일사용" disabled>논문양식파일사용</label></div>';//문제임..
        a+=   '<div class="checkbox"><label><input type="checkbox" id="chkbox" class="chkbox" value="목차,서론,본론,결론,참고문헌 포함" disabled>목차,서론,본론,결론,참고문헌 포함</label></div>';
        a+=   '<div class="checkbox"><label><input type="checkbox" id="chkbox" class="chkbox" value="본인이 직접 작성한 파일임을 확인함" disabled>본인이 직접 작성한 파일임을 확인함</label></div>';
        a+=   '</div></div></li>';

        a+=   '<li><div style="display:flex"><div class="profile">쪽수</div><div style="text-align : left; margin-left : 5px;" readonly>'+stage_data.finalPage+' 쪽 </div>';
        a+=   '<div style="font-size:11px;margin-left:5px">(서론/본론/결론/참고문헌 부분 쪽수, 표지/목차 제외)</div></div></li>';

        a+='<li><div id="downMid" style="display:flex"><div class="profile">중간보고서 파일</div>';
        a+='<div style="margin-left: 5px">'+interim_download+'</div><div style="margin-right:5px; margin-left : 10px"><a href="download_back.do?id='+stage_data.perId+'&stage=1"><button class="btn btn-default" style="padding : 3px 10px;"><img src="img/downloadBtn.png"></button></a></div></div></li>';

        a+=   '<li><div id="downFinal" style="display:flex"><div class="profile">최종보고서 파일</div>';
        a+='<div style="margin-left: 5px">'+final_download+'</div><div style="margin-right:5px; margin-left : 10px"><a href="download_back.do?id='+stage_data.perId+'&stage=2"><button class="btn btn-default" style="padding : 3px 10px;"><img src="img/downloadBtn.png"></button></a></div></div></li>';
        a+= '</ul>';

        modifymain.html(a);

        var value=stage_data.finalRequirement.split("/");
        for(var i=0;i<value.length;i++){
            $('input:checkbox.chkbox').each(function(){
                if($(this).val()==value[i])
                    $(this).prop("checked",true);
            });
        }

    }




</script>
</body>
</html>