<%--
  Created by IntelliJ IDEA.
  User: ssky6
  Date: 2022-01-28
  Time: 오후 2:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //String num = (String)request.getAttribute("num");
    //String tabmenulist=(String) request.getAttribute("pageMenuList");
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
<html>
<head>
    <title>글 쓰기:경기대학교 AI컴퓨터공학부</title>
    <style>
        #maincontent {
            padding: 0;
        }

        #maincontent>ul {
            padding: 10px;
        }

        #container {
            width: 1000px;
        }

        #maincontent {
            margin: 0 auto;
            border: none;
        }

        #post_title {
            width: 744px;
        }

        #afile3-list {
            font-size: 13px;
        }

        #afile3-list a {
            color: tomato;
        }

        .file-drop-zone-title{
            padding : 25px 10px;
        }

        .kv-file-content {
            width : 500px !important;
        }

        .file-details-cell {
            display : none;
        }

        .kv-zoom-thumb {
            display : none;
        }

        .fileinput-remove{
            display : none;
        }
    </style>
</head>
<body>
<div id="maincontent">
    <ul>
        <li>
            <div id="articlename" class="contenttitle">글 작성하기</div>
        </li>
    </ul>
    <div class="form-group">
        <input type="text" class="form-control" id="post_title" name="title" placeholder="제목 :">
    </div>
    <textarea name="content" id="editor"></textarea>
    <!-- 파일첨부 -->
    <div class="file-loading">
        <input id="kv-explorer" type="file" multiple>
    </div>
    <div class="post_button" id="post_submit_btn">
        <a href="javascript:exit();history.back()" class="btn btn-default">취소</a>
        <a onclick="insertboard()" id="post_submit" class="btn btn-default">쓰기</a>
    </div>


    <script>

        var list = $('#tab_2');
        var articlename=$('#articlename');
        var arr = <%=pageMenuList%>
        var num=<%=num%>;
        numo=num%10;
        numt=num/10;
        for (var i = 0; i < arr.length; i++) {

            var value = arr[i];
            if(value.show_in_menus)
                list.append(makeone(value));
        }

        $('#post_submit').mouseenter(function(){
            $('#editor').text('안녕');
            $('#editor').blur();
        });

        function makeone(str) {
            var num=str.tab_id*10+str.orderNum;
            return '<li><span class="deco_dot">●</span><a href="'+str.path+'?num='+num+'">'
                + str.page_title + '</a></li>';
        }

        var pane = $('#title');
        var panel =$('#titlename');
        var user = <%= user%>;
        var headtitle = <%=headermenulist%>;
        for(var i = 0 ; i < headtitle.length ; ++i)
            if(headtitle[i].tab_id < numt && headtitle[i].tab_id > (numt-1))
            {
//            pane.prepend('<img src="'+headtitle[i].tab_img+'" alt="">');
                panel.append(headtitle[i].tab_title);
                break;
            }
        CKEDITOR.replace('editor', {
            allowedContent: true,
            height: 300,
            'filebrowserUploadUrl': 'Uploader'
        });

        $("#kv-explorer").fileinput({
            'theme': 'explorer-fa',
            'uploadUrl': 'webzine_upload.kgu',
            showRemove : false,
            showUpload : false,
            overwriteInitial : false,
            uploadExtraData:{
                writer : user.id,
                num : num
            }
        });

        function insertboard(){
            var writer_id = user.id;
            var writer_name  = user.name;
            var title=$('[name=title]').val();
            if(title.length>=125){
                alert("제목이 너무 깁니다!");
                return;
            }
            if(title.length == 0){
                alert('제목이 없습니다!');
                return;
            }
            var content = CKEDITOR.instances.editor.getData();
            var num=<%=num%>;
            var insert=num+"-/-/-"+writer_id+"-/-/-"+title+"-/-/-"+content+"-/-/-"+writer_name;

            $.ajax({
                url : 'ajax.kgu',
                type : 'post',
                data : {
                    req:"insertwebzine",
                    data:insert
                },
                async : false,
                success : function(data){
                    if(data == 'success'){
                        alert("등록이 완료되었습니다");
                        is_submit = true;
                        window.location.href = 'webzine_list.kgu?num=<%=num %>';
                    }
                }
            });
        }

        function exit(){
            $.ajax({
                url : 'webzine_file_delete.kgu',
                type : 'post',
                data : {data : <%=user%>.id},
                success : function(data) {
                    if(data != 'fail'){
                        alert('올렸던 글과 파일들은 저장되지 않습니다!');
                    }
                    else{
                        alert('SERVER ERROR, Please try again later...');
                        return;
                    }
                }
            })
        }


        var is_submit = false;
        $(window).on("beforeunload", function () {
            if (!is_submit){
                exit()
            }
        });
    </script>
</body>
</html>
