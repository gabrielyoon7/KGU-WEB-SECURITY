<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
   StringBuffer url2_laboratory = request.getRequestURL();
   String logo_img_laboratory;

   //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
   //ai이면 ai로고 cs이면 cs로고
   if(url2_laboratory.substring(7,9).equals("ai") || url2_laboratory.substring(7,9).equals("lo")){
      logo_img_laboratory = "img/member_ai.png";
   }
   else{
      logo_img_laboratory = "img/member.png";
   }
%>
<%
   String tabMenuList = (String) request.getAttribute("tabmenulist");
   String laboratoryList = (String) request.getAttribute("laboratorylist");
   String num =(String) request.getAttribute("num");
%>
<!doctype html>
<html lang="ko">
<head>
<meta name="subject"
   content="Kyonggi University Department of Computer Science">
<meta name="author" content="Kyonggi Univ. SSF">
<meta name="keyword"
   content="경기대학교, 컴퓨터과학과, Kyonggi University, Computer Science">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="utf-8">
<title>연구실 : 경기대학교 AI컴퓨터공학부</title>
<link href='css/bootstrap.css' rel='stylesheet' type='text/css'>
<link href='css/default.css' rel='stylesheet' type='text/css'>
<link href='css/boardtable.css' rel='stylesheet' type='text/css'>
<link href='css/information.css' rel='stylesheet' type='text/css'>
<link href='css/content.css' rel='stylesheet' type='text/css'>
<script src="js/default.js"></script>
<script src="js/jquery-3.2.1.min.js"></script>
<style>
.profile {
   width: 125px;
   vertical-align:top;
   padding-top:20px;
   margin-left:15px;
}
a{
   white-space:nowrap;
}
dd{
   overflow:hidden;
   text-overflow:ellipsis;
}
.form-control {
   width: 300px;
   display: -webkit-inline-box;
}
.dl-style {
   width:350px;
   border-left:1px dotted black;
   padding-left:10px;
   margin-left:15px;
}
</style>
</head>
<body>

   <%@include file="../main/header.jsp"%>
   <main>
   <div id="content">
      <div id="title">
         <img src=<%=logo_img_laboratory%> />
         <div id="titlename"></div>
      </div>
      <div id="container">
         <div id="tab">
            <ul id="tabMenu">
            </ul>
         </div>
         <div id="maincontent">
            <ul>
               <li id="tap1">
                  <div class="contenttitle" id="maintitle"></div>
                  <ul id="laboratory"></ul>
               </li>
               <div id="insertlaboratory"></div>
            </ul>

         </div>
      </div>
   </div>
   <script>
      var list = $('#tabMenu');
      var tabmenu = <%=tabMenuList%>;
      var number = <%=num%>;
      for (var i = 0; i < tabmenu.length; ++i) {
         var value = tabmenu[i];
         var num = value.tab_id * 10 + value.orderNum;
         var text = '<li><span class="deco_dot">●</span><a href="'
               + value.path + '?num=' + num + '">' + value.page_title
               + '</a></li>'
         list.append(text);
      }

      var titlediv = $('#maintitle');
      for (var i = 0; i < tabmenu.length; ++i) {
         if (((tabmenu[i].tab_id * 10) + tabmenu[i].orderNum) == number) {
            titlediv.append(tabmenu[i].page_title);
         }
      }

      var panel = $('#titlename');
      var pane = $('#title');
      var headtitle =
   <%=headermenulist%>
      ;
      for (var i = 0; i < headtitle.length; ++i)
         if (headtitle[i].tab_id * 10 < number && (headtitle[i].tab_id+1) * 10 >= number) {
//            pane.prepend('<img src="'+headtitle[i].tab_img+'" alt="">');
            panel.append(headtitle[i].tab_title);
            break;
         }

     
      var user = <%=user%>;
      var type = <%=type%>;
      var lablist = <%=laboratoryList%>;
      var labpanel = $('#laboratory');
      for (var i = 0; i < lablist.length; ++i) {
         labpanel.append('<div id="laboratory_profile' + (lablist[i].id) + '""><div class="lab-profile" style="display:inline-block;" id="lab_profile'+ (lablist[i].id) +'"><div id="image'+(lablist[i].id)+'" style="display:inline;"><a href ="'+lablist[i].lab_homepage+'"><img src="img/laboratory/'+lablist[i].lab_img+'" alt="" class="profile"></a></div>'
                     + '<dl id="laboratorydl'+(lablist[i].id)+'" class="dl-style">'
                     +'<dd><div class="contenttitle">' + lablist[i].lab_name + ' 연구실<div style = "padding : 0;" class = "btn pull-right"></div></dd>'
                   +'<dd>연구실 위치 : ' + lablist[i].lab_location + '</dd>'
                   +'<dd><a href ="'+lablist[i].lab_homepage+'">홈페이지 : ' + lablist[i].lab_homepage + '</a></dd></dl></div>');
         if (type.type_name == '관리자'||type.type_name == '홈페이지관리자') {
            var editpanel = $('#laboratory_profile' + (lablist[i].id));
            editpanel.append('<div id="editbtn'+lablist[i].id+'" style="display:inline-block; vertical-align:top; margin-left:25px;"><a onclick="modifyLaboratory('+(lablist[i].id)+')" class="btn btn-default" style="height:34px; margin:2px;">수정</a>'+
            '<a onclick="deleteLaboratory('+ (lablist[i].id)+')" class="btn btn-default" style="height:34px; margin:2px;">삭제</a></div>');
         }
         var b = $('#laboratory_profile' + (lablist[i].id));
         b.append('<hr style="border: solid 1px lightgray;"/>');

      }

      if (type.type_name == '관리자'||type.type_name == '홈페이지관리자')
         $('#insertlaboratory')
               .html('<a onclick ="insertLaboratory()"><button type ="button" class="btn btn-default pull-right">추가</button></a>');
      function insertLaboratory() {
         var pan = $('#insertlaboratory');
         var a='';
         a += '<input type="file" name="uploadFile" id="uploadFile" accept=".jpg, .jpeg, .png"><dl>'+
         '<dd>연구실 이름 :<input type="text" class="form-control" name="lab_name" id="laboratory" required autofocus><div style = "padding : 0;" id="editbtn'+i+'" class = "btn pull-right"></div></dd>'+
         '<dd>연구실 위치 :<input type="text" class="form-control" name="lab_location" id="laboratory"  required></dd>'+
         '<dd>홈페이지 :<input type="text" class="form-control" name="lab_homepage" id="laboratory"  required></dd>'+
         '<a onclick="insertLab()"><button type="button" class="btn btn-default pull-right">완료</button></a>';
         pan.html(a);
      }

      function modifyLaboratory(i) {
         $.ajax({
                  url : "ajax.do",
                  type : "post",
                  data : {
                     req : "getonelaboratory",
                     data : i
                  },
                  dataType : "json",
                  success : function(data) {
                     var a = '';
                     var b = '';
                     $('#laboratorydl'+i).css('width', '460px');
                     var it = data;
                     a += '<div><img id="whatImage" src="img/laboratory/'+it.lab_img+'"><form style="display : inline-block" name="fileform" id="fileform" action="" method="post" enctype="multipart/form-data"><input type="text" name="LaboratoryID" value="' +it.id+ '" hidden><input style="display : inline-block" type="file" name="uploadFile" id="uploadFile" accept=".jpg, .jpeg, .png"><a onclick="modifyImage()"><button type="button" class="btn btn-default pull-right" style="display : inline-block">사진 수정</button></a></form></div>';
                     a += '<dd>연구실 이름 :<input type="text" class="form-control" name="lab_name1" id="laboratory" value="'+it.lab_name+'" required autofocus></dd>';
                     a += '<dd>연구실 위치 :<input type="text" class="form-control" name="lab_location1" id="laboratory" value="'+it.lab_location+'" required></dd>';
                     a += '<dd>홈페이지 :<input type="text" class="form-control" name="lab_homepage1" id="laboratory" value="'+it.lab_homepage+'" required></dd>';
                     $('#lab_profile' + (it.id)).html(a);
                     $('#editbtn'+(it.id)).empty();
                     $('#editbtn'+(it.id)).css('vertical-align','bottom');
                     b += '<a onclick="modifyLab(' + it.id + ')" class="btn btn-default">완료</a>';
                     $('#editbtn'+(it.id)).append(b);
                  }
               })
      }
      
      
      
      function modifyImage(){
         var formData = new FormData();
         formData.append("LaboratoryID",$('input[name=LaboratoryID]').val());
         formData.append("uploadFile",$('input[type=file]')[0].files[0]);
         $.ajax({
              url : "changeLabImage.do",
              type : "post",
              data : formData,
              processData : false,
              contentType : false,
              success : function(data) {
                 var a = '';
                 a += '<img src="img/laboratory/'+data+'" alt="" class="profile">';
                 $('#whatImage').attr('src',data);
              }
         })
      }
      
      function insertLab() {
        var formData = new FormData();
        formData.append("lab_img",$('input[name=uploadFile]')[0].files[0]);
        formData.append("lab_name", $('[name=lab_name]').val());
        formData.append("lab_location", $('[name=lab_location]').val());
          formData.append("lab_homepage", $('[name=lab_homepage]').val());

       var check = confirm("정말 추가하시겠습니까?");
       if(check){
         $
               .ajax({
                  url : "insertLab.do",
                  type : "post",
                  data : formData,
                  processData : false,
                  contentType : false,
                  dataType : "json",
                  success : function(data) {
                     alert("추가가 완료되었습니다");
                     var it = data;
                     var lab=$("#laboratory");
                     var b='';
                     lab.append('<div id="laboratory_profile' + (it.id) + '"" style="display:inline;"><div style="display:inline-block;" id="lab_profile'+ (it.id) +'"><div id="image'+(it.id)+'" style="display:inline;"><a href ="'+it.lab_homepage+'"><img src="img/laboratory/'+it.lab_img+'" alt="" class="profile"></a></div>'
                             + '<dl id="laboratorydl'+(it.id)+'" class="dl-style">'
                             +'<dd><div class="contenttitle">' + it.lab_name + ' 연구실<div style = "padding : 0;" class = "btn pull-right"></div></dd>'
                           +'<dd>연구실 위치 : ' + it.lab_location + '</dd>'
                           +'<dd><a href ="'+it.lab_homepage+'">홈페이지 : ' + it.lab_homepage + '</a></dd></dl></div>');
                     if (type.type_name == '관리자'||type.type_name == '홈페이지관리자'){
                             var editpanel = $('#laboratory_profile' + (it.id));
                             editpanel.append('<div id="editbtn'+it.id+'" style="display:inline-block; vertical-align:top; margin-left:25px;"><a onclick="modifyLaboratory('+(it.id)+')" class="btn btn-default" style="height:34px;">수정</a>'+
                             '<a onclick="deleteLaboratory('+ (it.id)+')" class="btn btn-default" style="height:34px;">삭제</a></div>');
                             var b = $('#laboratory_profile' + (it.id));
                             b.append('<hr style="border: solid 1px lightgray;"/>');
                     }
                     $('#insertlaboratory')
                           .html(
                                 '<a onclick ="insertLaboratory()"><button type ="button" class="btn btn-default pull-right">추가</button></a>');
                  }
               })
      }
      }

      function modifyLab(i) {
         var id = i;
         var name = $('[name=lab_name1]').val();
         var location = $('[name=lab_location1]').val();
         var homepage = $('[name=lab_homepage1]').val();
         var update = name + "-/-/-" + location + "-/-/-" + homepage +  "-/-/-" + id;
       var check = confirm("정말 수정하시겠습니까?");
       if(check){
         $
               .ajax({
                  url : "ajax.do",
                  type : "post",
                  data : {
                     req : "modifylab",
                     data : update
                  },
                  dataType : "json",
                  success : function(data) {
                     alert("수정이 완료되었습니다");
                     var it=data;
                     var a = '';
                     var b = '';
                     $('#laboratorydl'+it.id).css('width', '350px');
                     a +='<div id="laboratory_profile' + (it.id) + '"" style="display:inline;"><div style="display:inline-block;" id="lab_profile'+ (it.id) +'"><div id="image'+(it.id)+'" style="display:inline;"><a href ="'+it.lab_homepage+'"><img src="img/laboratory/'+it.lab_img+'" alt="" class="profile"></a></div>'
                     + '<dl id="laboratorydl'+(it.id)+'" class="dl-style">'
                     +'<dd><div class="contenttitle">' + it.lab_name + ' 연구실<div style = "padding : 0;" class = "btn pull-right"></div></dd>'
                   +'<dd>연구실 위치 : ' + it.lab_location + '</dd>'
                   +'<dd><a href ="'+it.lab_homepage+'">홈페이지 : ' + it.lab_homepage + '</a></dd></dl></div>';
                     $('#laboratory_profile' + id).html(a);
                     if (type.type_name == '관리자'||type.type_name == '홈페이지관리자'){
                     var editpanel = $('#laboratory_profile' + (it.id));
                     editpanel.append('<div id="editbtn'+it.id+'" style="display:inline-block; vertical-align:top; margin-left:25px;"><a onclick="modifyLaboratory('+(it.id)+')" class="btn btn-default" style="height:34px;">수정</a>'+
                     '<a onclick="deleteLaboratory('+ (it.id)+')" class="btn btn-default" style="height:34px;">삭제</a></div>');
                     var b = $('#laboratory_profile' + (it.id));
                     b.append('<hr style="border: solid 1px lightgray;"/>');
                     }
                     }
               })
       }
      }

      function deleteLaboratory(i) {
        var check = confirm("정말 삭제하시겠습니까?");
        if(check){
         $.ajax({
            url : "deleteLab.do",
            type : "post",
            data : {
               data : i
            },
            success : function(data) {
               alert("삭제 되었습니다");     
               var a = '';
               $('#laboratory_profile' + i).html(a);
            }
         })
      }
      }
      </script> 
     <%@include file="../main/footer.jsp"%>
   <div id="shadow">
      <div id="blur"></div>
   </div>
</body>
</html>