<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    StringBuffer url2_com_club = request.getRequestURL();
    String logo_img_com_club;

    //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
    //ai이면 ai로고 cs이면 cs로고
    if(url2_com_club.substring(7,9).equals("ai") || url2_com_club.substring(7,9).equals("lo")){
        logo_img_com_club = "img/community_ai.png";
    }
    else{
        logo_img_com_club = "img/community.png";
    }
    //System.out.println((logo_img_com_club));
%>
<% String club = (String) request.getAttribute("club");
String tabMenuList = (String) request.getAttribute("tabmenulist");
String num=(String) request.getAttribute("num");
String tabmenulist =(String) request.getAttribute("tabmenulist");%>
<!doctype html>
<html lang="ko">
<head>
    <meta name="subject" content="Kyonggi University Department of Computer Science">
    <meta name="author" content="Kyonggi Univ. SSF">
    <meta name="keyword" content="경기대학교, 컴퓨터과학과, Kyonggi University, Computer Science">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="utf-8">
    <title>경기대학교 AI컴퓨터공학부</title>
    <link href='css/bootstrap.css' rel='stylesheet' type='text/css'>
    <link href='css/default.css' rel='stylesheet' type='text/css'>
    <link href='css/boardtable.css' rel='stylesheet' type='text/css'>
    <link href='css/information.css' rel='stylesheet' type='text/css'>
    <link href='css/content.css' rel='stylesheet' type='text/css'>
    <script src="//cdn.ckeditor.com/4.8.0/standard/ckeditor.js"></script>
    <script src="js/default.js"></script>
    <script src="js/jquery-3.2.1.min.js"></script>
    <style>
    </style>
</head>
<body>
<%@include file="../main/header.jsp" %>
<main>
    <div id="content">
        <div id="title">
            <img src=<%=logo_img_com_club%> />
            <div id="titlename"></div>
        </div>
        <div id="container">
            <div id="tab">
                <ul id="tabMenu">
         </ul>
            </div>
            <div id="maincontent">
                <ul>
                    <li>
                        <div class="contenttitle">동아리 소개</div>
                        <ul id="club">
                           
                        </ul>
                       <div id="write_post" class="post_button"></div>
                </ul>
               
            </div>
        </div>
    </div>
</main>
<%@include file="../main/footer.jsp" %>
<div id="shadow">
    <div id="blur"></div>
</div>
<script>
var list = $('#tabMenu');
var arr = <%=tabmenulist%>
var type = <%=type%>;
for (var i = 0; i < arr.length; i++) {
   
   var value = arr[i];
   if(value.show_in_menus)
   list.append(makeone(value));
}
var ibtn = $('#write_post');
if(type.type_name=='관리자'||type.type_name=='홈페이지관리자'){
   ibtn.append('<a onclick="insertclub()" class="btn btn-primary" style="margin-left:588px;">동아리 추가</a>');
}
function makeone(str) {
var num=str.tab_id*10+str.orderNum;
return '<li><span class="deco_dot">●</span><a href="'+str.path+'?num='+num+'">'
      + str.page_title + '</a></li>';
}

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


var img=$('#title');
var panel = $('#titlename');
var headtitle = <%=headermenulist%>;
var txt=<%=tabMenuList%>
for(var i = 0 ; i < headtitle.length ; ++i)
   if(headtitle[i].tab_id==txt[0].tab_id){
//      img.prepend('<img src="'+headtitle[i].tab_img+'" alt="">');
      panel.append(headtitle[i].tab_title);
      break;
      }
      
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
   a +='<a href="community_club.do?num='+<%=num%>+'" onclick="back('+i+')" id="post_submit" class="btn btn-default">뒤로</a></div>';
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