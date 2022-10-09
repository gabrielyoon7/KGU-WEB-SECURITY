<%--
  Created by IntelliJ IDEA.
  User: wwwls
  Date: 2022-01-21
  Time: 오전 3:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%

    /**
     * v2 code
     * */

    String club = (String) request.getAttribute("club");
    String num = (String) request.getAttribute("num");
%>
<ul>
    <li>
        <div class="contenttitle">동아리 소개</div>
        <ul id="club">

        </ul>
        <div id="write_post" class="post_button"></div>
    </li>
</ul>

<div id="shadow">
    <div id="blur"></div>
</div>
<script>

    var ibtn = $('#write_post');
    if(type.type_name=='관리자'||type.type_name=='홈페이지관리자'){
        ibtn.append('<a onclick="insertclub()" class="btn btn-primary" style="margin-left:588px;">동아리 추가</a>');
    }
    // function makeone(str) {
    //     var num=str.tab_id*10+str.orderNum;
    //     return '<li><span class="deco_dot">●</span><a href="'+str.path+'?num='+num+'">'
    //         + str.page_title + '</a></li>';
    // }

</script>

<script>
    var club=$('#club');
    var arr=<%=club%>;
    for(var i=0;i<arr.length;i++){
        var value=arr[i];
        club.append('<div id="club'+value.id+'">'+makename(value)+makecontent(value)+makeurl(value)+'</div>');
        if(type.type_name=='관리자'||type.type_name=='홈페이지관리자'){
            club.append('<div id="post_submit_btn'+value.id+'" class="post_button" style="float:right;"><a onclick="modifyclub('+i+')" class="btn btn-default">수정</a><a onclick="deleteclub('+value.id+')" class="btn btn-default">삭제</a></div>');
            club.append('<br>');
        }
    }

    function makename(value){
        return '<div id="clubname'+value.id+'" class="contenttitle2">'+value.clubname+'</div>'
    }
    function makecontent(value){
        return '<div id="clubcontent_'+value.id+'_modify">'+value.clubcontent+'</div>';
    }
    function makeurl(value){
        return '<br><li id="clubURL'+value.id+'">홈페이지 : <a href="'+value.clubaddr+'">'+value.clubaddr+'</a></li>';
    }


<%--    var img=$('#title');--%>
<%--    var panel = $('#titlename');--%>
<%--    var headtitle = <%=headermenulist%>;--%>
<%--    var txt=<%=tabMenuList%>--%>
<%--    for(var i = 0 ; i < headtitle.length ; ++i)--%>
<%--        if(headtitle[i].tab_id==txt[0].tab_id){--%>
<%--//      img.prepend('<img src="'+headtitle[i].tab_img+'" alt="">');--%>
<%--            panel.append(headtitle[i].tab_title);--%>
<%--            break;--%>
<%--        }--%>

    function modifyclub(i){
        var value=arr[i];
        var a='';
        a +='<form name="clubmodify">';
        $('#clubname'+value.id).empty();
        a +='<div style="display:flex; margin-bottom:8px; margin-top:5px;">동아리 이름 : <input type="text" class="form-control" name="clubname" value="'+value.clubname+'" style="width:596px; margin-left:3px;"></div>';
        a +='<textarea name="clubcontent'+value.id+'" id="editor'+value.id+'" required>'+value.clubcontent+'</textarea>';
        $('#clubURL'+value.id).empty();
        a +='<div style="display:flex; margin-top:8px;">홈페이지 : <input type="text" class="form-control" name="clubaddr" value="'+value.clubaddr+'" style="width:615px; margin-left:3px;"></div>';
        $('#post_submit_btn'+value.id).empty();
        a +='<div class="post_button" id="post_submit_btn"><a onclick="postclub('+value.id+')" id="post_submit" class="btn btn-default"> 수정 </a>'
        a +='<a href="community_club.kgu?num='+<%=num%>+'" onclick="back('+i+')" id="post_submit" class="btn btn-default">뒤로</a></div>';
        a +='</div></form>';
        var text = 'editor'+value.id;
        $('#clubcontent_'+value.id+'_modify').html(a);
        CKEDITOR.replace(text,{
            allowedContent : true,
            height : 500,
            'filebrowserUploadUrl' : 'Uploader'
        });

    }

    function back(i){
        var a=arr[i].content;
        $('clubcontent_'+arr[i].id+'_modify').html(a);

    }

</script>
<script>
    function postclub(id){
        var text="editor"+id;
        var name = $('[name=clubname]').val();
        var content=CKEDITOR.instances[text].getData();
        var address = $('[name=clubaddr]').val();
        var insert =id+"-/-/-"+name+"-/-/-"+content+"-/-/-"+address;

        $.ajax({
            url:"ajax.do",
            type:"post",
            data :{
                req:"modifyclub",
                data:insert
            },
            success : function(data){
                if(data==1){
                    alert("수정이 완료 되었습니다.");
                    window.location.href= 'community_club.do?num='+<%=num%>;
                }else
                    alert("수정이 되지 않았습니다 다시 시도해 주세요!!");
            }
        })

    }

    function deleteclub(id){
        $.ajax({
            url:"ajax.do",
            type:"post",
            data :{
                req:"deleteclub",
                data:id
            },
            success : function(data){
                if(data==1){
                    alert("삭제가 완료되었습니다.");
                    window.location.href='community_club.do?num=<%=num%>';
                }
            }
        })
    }
    function insertclub(){
        var a='';
        a +='<form name="clubinsert">';
        a +='<input type="text" class="form-control" name="addclubname" placeholder="동아리 이름을 입력하세요">';
        a +='<textarea name="addclubcontent" id="addeditor" required></textarea>';
        a +='<input type="text" class="form-control" name="addclubaddr" placeholder="동아리 주소를 입력하세요">';
        a +='<div class="post_button"><a onclick="addclub()" id="post_submit" class="btn btn-default">추가</a>';
        a +='</div></form>';
        $('#write_post').css('margin-top','8px')
        $('#write_post').html(a);
        CKEDITOR.replace("addeditor",{
            allowedContent : true,
            height : 500
        });
    }

    function addclub(){
        var name=$('[name=addclubname]').val();
        var content = CKEDITOR.instances.addeditor.getData();
        var addr =$('[name=addclubaddr]').val();
        var insert = name+"-/-/-"+content+"-/-/-"+addr;

        $.ajax({
            url:"ajax.do",
            type:"post",
            data :{
                req:"insertclub",
                data:insert
            },
            success : function(data){
                if(data==1){
                    alert("추가가 완료 되었습니다.");
                    window.location.href= 'community_club.do?num=' + <%=num%>;
                }else
                    alert("추가가 되지 않았습니다 다시 시도해 주세요!!");
            }

        });
    }

</script>
</body>
</html>