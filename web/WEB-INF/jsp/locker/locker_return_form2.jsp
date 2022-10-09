<%--
  Created by IntelliJ IDEA.
  User: Gabriel Yoon
  Date: 2021-03-05
  Time: 오전 2:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
    StringBuffer url2_locker_return_form = request.getRequestURL();
    String logo_img__locker_return_form;

    //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
    //ai이면 ai로고 cs이면 cs로고
    if(url2_locker_return_form.substring(7,9).equals("ai") || url2_locker_return_form.substring(7,9).equals("lo")){
        logo_img__locker_return_form = "img/graduation_ai.png";
    }
    else{
        logo_img__locker_return_form = "img/graduation.png";
    }
    //System.out.println((logo_img__locker_return_form));
%>
<%
    String num = (String) request.getAttribute("num");
    String tabmenulist = (String) request.getAttribute("tabMenu");//관리자탭메뉴
//    String graduationuser = (String) request.getAttribute("graduationuser");
//    String stage_data=(String) request.getAttribute("stage_data");
    String modify=(String) request.getAttribute("modify");
    String download=(String) request.getAttribute("download");
//    String grduser = (String) request.getAttribute("grduser");//유저객체
//    String grduseretc = (String)request.getAttribute("grduseretc");
//    String assignedStudent = (String) request.getAttribute("assignedStudent");//관리자탭메뉴

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
            <img src=<%=logo_img__locker_return_form%> />
            <div>사물함 반납하기</div>
        </div>
        <div id="container">
            <div id="tab">
                <ul id="tab_2">
                </ul>
            </div>
            <div id="maincontent">
                <ul><li><div class="contenttitle">사물함 반납하기</div></li></ul>
                <div>
                    <div>
                        <div class="contenttitle2">반납양식(사물함 외부 사진)</div>
                        <div id="modify_main" class="graduation_read_info" style="border : 1.5px solid #ddd">
                            <ul>
                                <li>
                                    <div id="uploadfile1" style="display:flex">
                                        <div class="profile">파일제출</div>
                                        <div style="margin-left:5px; margin-top : 7px"><input type="file" name="uploadFile" id="uploadFile" accept="image/*"></div>
                                        <div style="margin-right:auto"><button class="btn btn-default" onclick="uploadfile()" style="padding: 3px 10px"><img src="img/uploadBtn.png"></button></div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div><!-- 서명 + 버튼div -->
                            <div id="sign" class="text-right">
                                <button type="button" style="margin: 2px;" class="btn btn-default" onclick="insert_data()">제출</button>
                                <a href="javascript:history.go(-1)"><button type="button" style="margin: 2px;" class="btn btn-default">뒤로</button></a>
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
    $(document).ready(function() {//바로시작하는 function
    })
    var list = $('#tab_2');
    var title = $('#title2');

    var tabmenu = <%=tabmenulist%>;
    var number =<%=num%>;
    for (var i = 0; i < tabmenu.length; ++i) {
        var value = tabmenu[i];
        var num = value.tab_id * 10 + value.orderNum;
        var text = '<li><span class="deco_dot">●</span><a href="' + value.path + '?num=' + num + '">' + value.page_title + '</a></li>'
        list.append(text);
        if (number == num) {
            title.append(value.page_title);
        }
    }


    var modify=<%=modify%>;//1=수정 2=보기
    var download=<%=download%>
    if(modify==1){//name(answer_1), checked_value(answer_2), keyword(answer_3), content(answer_4)
        var modifymain=$('#modify_main');
        var a='';
        a+='<li><div id="uploadfile1" style="display:flex"><div class="profile">파일제출</div>';
        a+='<div style="margin-left: 5px">'+download[0]+'</div><div style="margin-right:5px; margin-left : 10px"><a href="download.do?id=${assignedStudent.per_id}"><button class="btn btn-default" style="padding : 3px 10px;"><img src="img/downloadBtn.png"></button></a><button class="btn btn-default" onclick="modifyfilebutton()" style="padding: 3px 10px; margin-left : 5px"><img src="img/removeBtn.png"></button></div></div></li>';
        modifymain.html(a);
    }else if(modify==2){
        var modifymain=$('#modify_main');
        var sign=$('#sign');
        var a='';
        var b='<div class="text-right"><a href="javascript:history.go(-1)"><button type="button" style = "margin : 2px;" class="btn btn-default">취소</button></a>';
        if((user.type.includes("관리자"))){
            b+='<button type="button" class="btn btn-default" onclick="success()" >승인</button><button type="button" class="btn btn-default" onclick="refuse()">반려</button></div>';
        }
        sign.html(b);
        a+='<li><div id="uploadfile1" style="display:flex"><div class="profile">파일제출</div>';
        a+='<div style="margin-left:5px">'+download[0]+'</div><div style="margin-left:5px"><a href="download.do?id=${assignedStudent.per_id}"><button class="btn btn-default" style="padding : 3px 10px; margin-left : 10px"><img src="img/downloadBtn.png"></button></a></div></div></li>';
        modifymain.html(a);
    }


    function uploadfile(){
        var formData = new FormData();
        var address="";
        if($('input[name=uploadFile]')[0].files[0]!=null){
            formData.append("file_data",$('input[name=uploadFile]')[0].files[0]);
            formData.append("writer",${assignedStudent.per_id});
            $.ajax({
                url : 'locker_upload2.do?writer=${assignedStudent.per_id}',
                type : "post",
                async:false,
                data : formData,
                processData : false,
                contentType : false,
                success : function(data){//데이터는 주소
                    var file=data.split("-/-/-");
                    var a='';
                    a+='<div class="profile">파일제출</div><div style="margin-left: 5px">'+file[0]+'</div><div style="margin-right:5px; margin-left : 10px"><a href="download.do?id=${assignedStudent.per_id}"><button class="btn btn-default" style="padding : 3px 10px;"><img src="img/downloadBtn.png"></button></a><button class="btn btn-default" onclick="modifyfilebutton()" style="padding: 3px 10px; margin-left : 5px"><img src="img/removeBtn.png"></button></div></div></li>';
                    uploadf=file[0];
                    hashfile=file[1];
                    $('#uploadfile1').html(a);
                }
            })
        }else{
            alert("파일을 등록해주세요");
        }
        return address;
    }

    function modifyfilebutton(){
        var a='';
        a+='<div class="profile">파일제출</div><div style="margin-left:5px; margin-top : 7px"><input type="file" name="uploadFile" id="uploadFile" accept="image/*"></div><div><button class="btn btn-default" onclick="uploadfile()" style="padding: 3px 10px"><img src="img/uploadBtn.png"></button></div>';
        a+='<div style="margin-left : 5px"><button class="btn btn-default" onclick="cancelfile()" style="padding : 6px 10px">취소</button></div>';
        $('#uploadfile1').html(a);
    }

    function cancelfile(){
        var a='';
        if(modify=="1"){
            a+='<div class="profile">파일제출</div>';
            a+='<div style="margin-left: 5px">'+download[0]+'</div><div style="margin-right:5px; margin-left : 10px"><a href="download.do?id='+graduationuser.per_id+'&stage=3"><button class="btn btn-default" style="padding : 3px 10px;"><img src="img/downloadBtn.png"></button></a><button class="btn btn-default" onclick="modifyfilebutton()" style="padding: 3px 10px; margin-left : 5px"><img src="img/removeBtn.png"></button></div>';
        }else{
            a+='<div class="profile">파일제출</div><div style="margin-left: 5px">'+uploadf+'</div><div style="margin-right:5px; margin-left : 10px"><a href="download.do?id='+graduationuser.per_id+'&stage=3"><button class="btn btn-default" style="padding : 3px 10px;"><img src="img/downloadBtn.png"></button></a><button class="btn btn-default" onclick="modifyfilebutton()" style="padding: 3px 10px; margin-left : 5px"><img src="img/removeBtn.png"></button></div></div></li>';
        }
        $('#uploadfile1').html(a);
    }
//여기까지
    function insert_data(){
        var modi='';
        if(modify=="1"){
            modi="modify";
        }
        var obj = new Object();
        obj.per_id = user.per_id; //여기 user.per_id 였었다
        obj.name = user.name;
        <%--obj.locker_num = ${assignedStudent.locker_num};--%>

        obj.file = hashfile; //파일이름(uploadf)
        obj.realfile = uploadf;
        // if (obj.file == null && modify == "1") {
        //     obj.file = stage_data.interim_filename;
        // }

        // obj.progress = $('#progress_content').val();
        // obj.plan = $('#plan_content').val();
        // obj.per_id = user.per_id;
        // obj.stage = 3; //여기 추가
        var jsonobj = JSON.stringify(obj);
        $.ajax({
            url: "ajax.do",
            type: "post",
            dataType: "json",
            data: {
                req: "return_picture2",
                data: jsonobj,
                modify: modi
            },
            success: function (data) {
                alert(user.name + "[" + data + "]님의 반납사진(외부)이 제출 되었습니다.");
                window.location.href = "locker_apply.do?num=112";
            }
        });

    }

</script>
</body>
</html>