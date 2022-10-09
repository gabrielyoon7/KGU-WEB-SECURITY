<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 2022-01-25
  Time: 오전 11:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%
    String user = (String) session.getAttribute("user");
    String type = (String) session.getAttribute("type");
    String num = (String)request.getAttribute("num");
    String tabmenulist=(String) request.getAttribute("pageMenuList");
    String boards=(String) request.getAttribute("boards");
    String id=(String) request.getAttribute("id");
    String file = (String) request.getAttribute("file");
%>
<form method="post" id="choose_board">
    <ul>
        <li>
            <div id="articlename" class="contenttitle">글 수정하기</div>
        </li>
    </ul>
    <div id="contentmain"></div>
</form>
<ul id="alreadyFiles">
</ul>
<div class="file-loading">
    <input id="kv-explorer" type="file" multiple>
</div>
<div class="post_button" id="post_submit_btn" style="margin-top : 5px;">
    <a href="javascript:history.back();" class="btn btn-default">취소</a>
    <a class="btn btn-default" onclick="modifyboard()">쓰기</a>
</div>
<script>
    // var list = $('#tab_2');
    // var articlename=$('#articlename');
    <%--var arr = <%=tabmenulist%>--%>
    var num=<%=num%>;
    // numo=num%10;//1의자리
    // numt=num/10;//10의자리
    // for (var i = 0; i < arr.length; i++) {
    //     var value = arr[i];
    //     if(value.show_in_menus)
    //         list.append(makeone(value));
    // }
    //
    // function makeone(str) {
    //     var num=str.tab_id*10+str.orderNum;
    //     return '<li><span class="deco_dot">●</span><a href="'+str.path+'?num='+num+'">'
    //         + str.page_title + '</a></li>';
    // }
    // var pane = $('#title');
    // var panel =$('#titlename');
    <%--var headtitle = <%=headermenulist%>;--%>
//     for(var i = 0 ; i < headtitle.length ; ++i)
//         if(headtitle[i].tab_id <numt && headtitle[i].tab_id>(numt-1))
//         {
// //			pane.prepend('<img src="'+headtitle[i].tab_img+'" alt="">');
//             panel.append(headtitle[i].tab_title);
//             break;
//         }
    var title=$('#contenttitle');
    var main=$('#contentmain');
    var arr=<%=boards%>;
    var user = <%=user%>;
    var type = <%=type%>;
    var value=arr;
    title.append('게시판 : '+value.title);
    main.append(input(value));
    function input(str){
        var type='<div class="form-group"><input type="text" class="form-control" id="post_title" name="title" placeholder="제목 :" value="' + str.title + '"></div>';
        var area='<textarea name="content" id="editor">'+str.content+'</textarea>';
        return type+area;
    }

    CKEDITOR.replace('editor', {
        allowedContent: true,
        height: 300,
        'filebrowserUploadUrl': 'Uploader'
    });

    $("#kv-explorer").fileinput({
        'theme': 'explorer-fa',
        'uploadUrl': 'notice_board_upload.do',
        showRemove : false,
        showUpload : false,
        overwriteInitial : false,
        uploadExtraData:{
            writer : user.id,
            num : num
        }
    });


    function modifyboard(){
        var id=<%=id%>;
        var modifytitle=$('[name=title]').val();
        if(modifytitle.length>=125){
            alert("제목이 너무 깁니다!");
            return;
        }
        if(modifytitle.length ==0){
            alert('제목을 설정해주세요!');
            return;
        }
        var content = CKEDITOR.instances.editor.getData();
        var modify=id+"-/-/-"+modifytitle+"-/-/-"+content;
        $.ajax({
            url : 'ajax.do',
            type : 'post',
            typeData : "gson",
            data : {
                req:"noticemodifyboard",
                data:modify
            },
            async : false,
            success : function(data){
                if(data == "success") {
                    alert("수정이 완료되었습니다");
                    is_submit = true;
                    window.location.href = 'notice_article_reader.do?num=' + <%=num%> + '&id=' + <%=id%>;
                }
                else{
                    alert("SERVER ERROR, Please try again later...");
                    return;
                }
            }
        });
    }

    var alreadyFiles = <%=file%>;
    if(alreadyFiles.length > 0){
        var alreadyPanel = $('#alreadyFiles');
        for(var i = 0 ; i < alreadyFiles.length ; ++i){
            var value = alreadyFiles[i];
            alreadyPanel.append('<li id="alreadyFileDiv' + i + '">' + value.filename + '<a onclick="alreadyDelete(' + i + ')"><img src="img/denied.png" style="width : 12px;margin-left : 5px;"></a></li>');
        }
    }

    function alreadyDelete(index){
        var value = alreadyFiles[index];
        $.ajax({
            url : 'ajax.do',
            type : 'post',
            data : {
                req:"notice_board_delete_already_file",
                data:value.id
            },
            success : function(data){
                if(data == "success") {
                    $('#alreadyFileDiv'+index).remove();
                }
                else{
                    alert("SERVER ERROR, Please try again later...");
                    return;
                }
            }
        });

    }


    function exit(){
        $.ajax({
            url : 'notice_board_file_delete.do',
            type : 'post',
            data : {data : <%=user%>.id},
            success : function(data) {
                if(data == 'fail'){
                    alert('SERVER ERROR, Please try again later...');
                }
            }
        });

        $.ajax({
            url : 'ajax.do',
            type : 'post',
            data : {
                req : 'notice_board_already_file_done',
                data : <%=boards%>.id
            },
            success : function(data){
                if(data != 'fail'){
                    alert('새로 올린 파일들과 수정내용들은 저장되지 않습니다!');
                }
                else{
                    alert('SERVER ERROR, Please try again later...');
                    return;
                }
            }
        });
    }

    var is_submit = false;

    $(window).on("beforeunload", function () {
        if (!is_submit){
            exit()
        }
    });


</script>
