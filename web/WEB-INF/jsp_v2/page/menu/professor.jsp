<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-01-21
  Time: 오전 12:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

    /**
     * v2 code
     * */
    String professorList = (String) request.getAttribute("professorlist");

%>
<%
    String headermenulist = (String) session.getAttribute("headermenulist");
    String menulist = (String) session.getAttribute("menulist");
    String user = (String) session.getAttribute("user");
    String type = (String) session.getAttribute("type");
%>
<%
    String num = (String) request.getAttribute("num");
    String pageMenuList = (String) request.getAttribute("pageMenuList");//좌측 소메뉴 리스트

    /**
     * for page.jsp
     * */
    String jsp = (String) request.getAttribute("jsp");
%>
<style>
    .profile {
        width: 125px;
        vertical-align: top;
    }

    .form-control {
        width: 300px;
        display: -webkit-inline-box;
    }
</style>
<div id="maincontent">
    <ul>
        <li id="tap1">
            <div class="contenttitle" id="maintitle"></div>
            <ul id="professor"></ul>
        </li>
        <div id="insertprofessor"></div>
    </ul>
</div>
<script>

    $(document).ready(function () { //본문 제어
        makePageTitle('maintitle'); // 본문 안에 제목 넣어주는 역할 (page.jsp에서 함수를 찾아보세요)
    })

    var propanel = $('#professor');
    var user = <%=user%> ;
    var type = <%=type%> ;
    var prolist = <%=professorList%> ;
    for (var i = 0; i < prolist.length; ++i) {
        propanel.append('<div id="professor_profile' + (prolist[i].id) + '"><div id="image'+ (prolist[i].id) +'" style="display : inline"><img src="img/professor/'+prolist[i].prof_img+'" alt="" class="profile"></div>'
                + '<dl><div id="professor' + (prolist[i].id)
                + '"><dd><div class="contenttitle">'
                + prolist[i].prof_name
                + ' 교수<div style = "padding : 0;" id="editbtn'
                + (prolist[i].id)
                + '" class = "btn pull-right"></div></div></dd>');
        var a = $('#professor' + (prolist[i].id));
        a.append('<dd>사무실 위치 : ' + prolist[i].prof_location + '</dd>');
        a.append('<dd>연락처 : ' + prolist[i].prof_call + '</dd>'
            + '<dd>이메일 : ' + prolist[i].prof_email + '</dd>'
            + '<dd>담당과목 : ' + prolist[i].prof_lecture + '</dd>');
        var b = $('#professor_profile' + (prolist[i].id));
        b.append('<hr style="border: solid 1px lightgray;"/>');
        if (type.type_name == '관리자'||type.type_name == '홈페이지관리자') {
            var editpanel = $('#editbtn' + (prolist[i].id));
            editpanel.append('<a onclick="modifyProfessor('+(prolist[i].id)+')"><button type="button" style = "margin : 2px;" class="btn btn-default">수정</button></a>');
            editpanel.append('<a onclick="deleteProfessor('+ (prolist[i].id)+')"><button type="button" style = "margin : 2px;" class="btn btn-default">삭제</button></a>');
        }

    }

    if (type.type_name == '관리자'||type.type_name == '홈페이지관리자')
        $('#insertprofessor').html('<a onclick ="insertProfessor()"><button type ="button" class="btn btn-default pull-right">추가</button></a>');
    function insertProfessor() {
        var pan = $('#insertprofessor');
        var a='';
        a +='<input type="file" name="uploadFile" id="uploadFile" accept=".jpg, .jpeg, .png"><dl>'+
            '<dd>이름 :<input type="text" class="form-control" name="prof_name" id="professor"><div style = "padding : 0;" id="editbtn'+i+'" class = "btn pull-right"></div></dd>'+
            '<dd>사무실 위치 :<input type="text" class="form-control" name="prof_location" id="professor"></dd>'+
            '<dd>연락처 :<input type="text" class="form-control" name="prof_call" id="professor"></dd>'+
            '<dd>이메일 :<input type="text" class="form-control" name="prof_email" id="professor"></dd>'+
            '<dd>담당과목 :<input type="text" class="form-control" name="prof_lecture" id="professor"></dd></dl>'+
            '<a onclick="insertPro()"><button type="button" class="btn btn-default pull-right">완료</button></a>';
        pan.html(a);
    }

    function modifyProfessor(i) {
        $.ajax({
            url : "ajax.do",
            type : "post",
            data : {
                req : "getoneprofessor",
                data : i
            },
            dataType : "json",
            success : function(data) {
                var a = '';
                var it = data;
                a += '<div><form style="display : inline-block" name="fileform" id="fileform" action="" method="post" enctype="multipart/form-data"><input type="text" name="ProfessorID" value="' +it.id+ '" hidden><input style="display : inline-block" type="file" name="uploadFile" id="uploadFile" accept=".jpg, .jpeg, .png"><a onclick="modifyImage()"><button type="button" class="btn btn-default pull-right" style="display : inline-block">사진 수정</button></a></form></div>';
                a += '<dd>이름 :<input type="text" class="form-control" name="prof_name1" id="professor" value="'+it.prof_name+'"></dd>';
                a += '<dd>사무실 위치 :<input type="text" class="form-control" name="prof_location1" id="professor" value="'+it.prof_location+'"></dd>';
                a += '<dd>연락처 :<input type="text" class="form-control" name="prof_call1" id="professor" value="'+it.prof_call+'"></dd>';
                a += '<dd>이메일 :<input type="text" class="form-control" name="prof_email1" id="professor" value="'+it.prof_email+'"></dd>';
                a += '<dd>담당과목 :<input type="text" class="form-control" name="prof_lecture1" id="professor" value='+it.prof_lecture+'></dd>';
                a += '<a onclick="modifyPro('
                    + it.id
                    + ')"><button type="button" class="btn btn-default pull-right">정보 수정</button></a>';

                $('#professor' + (it.id)).html(a);
            }
        })
    }



    function modifyImage(){
        var formData = new FormData();
        formData.append("ProfessorID",$('input[name=ProfessorID]').val());
        formData.append("uploadFile",$('input[type=file]')[0].files[0]);
        $.ajax({
            url : "changeProImage.do",
            type : "post",
            data : formData,
            processData : false,
            contentType : false,
            success : function(data) {
                var a = '';
                a += '<img src="img/professor/'+data+'" alt="" class="profile">';
                $('#image'+$('input[name=ProfessorID]').val()).html(a);
            }
        })
    }

    function insertPro() {
        var formData = new FormData();
        formData.append("prof_img",$('input[name=uploadFile]')[0].files[0]);
        formData.append("prof_name", $('[name=prof_name]').val())
        formData.append("prof_location", $('[name=prof_location]').val())
        formData.append("prof_call", $('[name=prof_call]').val())
        formData.append("prof_email", $('[name=prof_email]').val())
        formData.append("prof_lecture", $('[name=prof_lecture]').val())

        var check = confirm("정말 추가하시겠습니까?");
        if(check){
            $
                .ajax({
                    url : "insertPro.do",
                    type : "post",
                    data : formData,
                    processData : false,
                    contentType : false,
                    dataType : "json",
                    success : function(data) {
                        alert("추가가 완료되었습니다");
                        var it = data;
                        var pro=$("#professor");
                        pro.append('<div id="professor_profile'
                            + (it.id)
                            + '"><img src="img/professor/'+it.prof_img+'" alt="" class="profile">'
                            + '<dl><div id="professor'
                            + (it.id)
                            + '"><dd><div class="contenttitle">'
                            + it.prof_name
                            + ' 교수<div style = "padding : 0;" id="editbtn'
                            + (it.id)
                            + '" class = "btn pull-right"></div></div></dd>'
                            + '<dd>사무실 위치: '
                            + it.prof_location
                            + '</dd>'
                            + '<dd>연락처 : '
                            + it.prof_call
                            + '</dd>'
                            + '<dd>이메일 : '
                            + it.prof_email
                            + '</dd>'
                            + '<dd>담당과목 : '
                            + it.prof_lecture
                            + '</dd></div></dl>'
                            + '<hr style="border: solid 1px lightgray;"/></div>');
                        if (type.type_name == '관리자'||type.type_name == '홈페이지관리자') {
                            var editpanel = $('#editbtn' + (it.id));
                            editpanel
                                .append('<a onclick="modifyProfessor('
                                    + (it.id)
                                    + ')"><button type="button" style = "margin : 2px;" class="btn btn-default">수정</button></a>');
                            editpanel
                                .append('<a onclick="deleteProfessor('
                                    + (it.id)
                                    + ')"><button type="button" style = "margin : 2px;" class="btn btn-default">삭제</button></a>');
                        }
                        $('#insertprofessor')
                            .html(
                                '<a onclick ="insertProfessor()"><button type ="button" class="btn btn-default pull-right">추가</button></a>');
                    }
                })
        }
    }

    function modifyPro(i) {
        var id = i;
        var name = $('[name=prof_name1]').val();
        var location = $('[name=prof_location1]').val();
        var call = $('[name=prof_call1]').val();
        var email = $('[name=prof_email1]').val();
        var lecture = $('[name=prof_lecture1]').val();
        var update = name + "-/-/-" + location + "-/-/-" + call + "-/-/-" + email + "-/-/-" + lecture + "-/-/-" + id;
        var check = confirm("정말 수정하시겠습니까?");
        if(check){
            $
                .ajax({
                    url : "ajax.do",
                    type : "post",
                    data : {
                        req : "modifypro",
                        data : update
                    },
                    dataType : "json",
                    success : function(data) {
                        alert("수정이 완료되었습니다");
                        var a = '';
                        a += '<dd><div class="contenttitle">'
                            + name
                            + ' 교수<div style = "padding : 0;" id="editbtn'+id+'" class = "btn pull-right"></div></div></dd>';
                        a += '<dd>사무실 위치 : ' + location + '</dd>';
                        a += '<dd>연락처 : ' + call + '</dd>';
                        a += '<dd>이메일 : ' + email + '</dd>';
                        a += '<dd>담당과목 : ' + lecture + '</dd></div>';
                        $('#professor' + id).html(a);
                        if (type.type_name == '관리자'||type.type_name == '홈페이지관리자') {
                            var editpanel = $('#editbtn' + id);
                            editpanel
                                .append('<a onclick="modifyProfessor('
                                    + id
                                    + ')"><button type="button" style = "margin : 2px;" class="btn btn-default">수정</button></a>');
                            editpanel
                                .append('<a onclick="deleteProfessor('
                                    + id
                                    + ')"><button type="button" style = "margin : 2px;" class="btn btn-default">삭제</button></a>');
                        }

                    }
                })
        }
    }

    function deleteProfessor(i) {
        var check = confirm("정말 삭제하시겠습니까?");
        if(check){
            $.ajax({
                url : "deletePro.do",
                type : "post",
                data : {
                    data : i
                },
                success : function(data) {
                    alert("삭제 되었습니다");
                    var a = '';
                    $('#professor_profile' + i).html(a);
                }
            })
        }
    }
</script>