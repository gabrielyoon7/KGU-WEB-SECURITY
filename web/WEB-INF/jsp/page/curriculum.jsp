<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
   StringBuffer url2_curriculum = request.getRequestURL();
   String logo_img_curriculum;

   //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
   //ai이면 ai로고 cs이면 cs로고
   if(url2_curriculum.substring(7,9).equals("ai") || url2_curriculum.substring(7,9).equals("lo")){
      logo_img_curriculum = "img/edu_ai.png";
   }
   else{
      logo_img_curriculum = "img/edu.png";
   }
%>
<%
   String tabMenuList = (String) request.getAttribute("tabmenulist");
   String text = (String) request.getAttribute("text");
   String num = (String) request.getAttribute("num");
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
<title>소개 : 경기대학교 AI컴퓨터공학부</title>
<link href='css/bootstrap.css' rel='stylesheet' type='text/css'>
<link href='css/default.css' rel='stylesheet' type='text/css'>
<link href='css/boardtable.css' rel='stylesheet' type='text/css'>
<link href='css/information.css' rel='stylesheet' type='text/css'>
<link href='css/content.css' rel='stylesheet' type='text/css'>
<script src="js/default.js"></script>
<script src="js/jquery-3.2.1.min.js"></script>
<script src="//cdn.ckeditor.com/4.8.0/standard/ckeditor.js"></script>
<style>
</style>
</head>
<body>

   <%@include file="../main/header.jsp"%>
   <br>
   <main>
   <div id="content">
      <div id="title">
         <img src=<%=logo_img_curriculum%> />
         <div id="titlename"></div>
      </div>
      <div id="container">
         <div id="tab">
         <ul id="tabMenu">
         </ul>
         </div>
         <div id="maincontent">
            <ul>
               <li style="margin-bottom : 5px;">
                  <div id="maintitle" class="contenttitle">
                  </div>
<%--                  <div>내용들어갈부분</div>--%>
                  <div id="maintext"></div>
               </li>
            </ul>
               <div id="modify_button"></div>
<%--                  cs에서만 버튼 다나오게 하기위해서 버튼제어 javascript로 빼줌--%>
                  <div id="curriculum_btn">
<%--                     <button type="button" class="btn btn-default" onclick="view2012()">2012년 교육과정</button>--%>
<%--                     <button type="button" class="btn btn-default" onclick="view2017()">2017년 교육과정</button>--%>
<%--                     <button type="button" class="btn btn-default" onclick="view2018()">2018년 교육과정</button>--%>
                     <button type="button" class="btn btn-default" onclick="view2021()">2021년 교육과정</button>
                  </div>
               <div id="curriculum_view"></div>
               
         </div>
      </div>
   </div>
            <script>
               var maindiv = $('#maintext');
               var txt = <%=text%>;
               var btn_div = $('#curriculum_btn');
               //ai학부는 따로 텍스트를 넣어줬고 cs면(else문) db에서가져온 txt를 추가함. 연도별 커리큘럼도 cs에서만 모두표시.

               var myurl = window.location.href.slice(7,9);
               if (((<%=num%>) == "21") && ((myurl == "lo") || (myurl == "ai"))){
                  var txt_ai = ` \u003cp\u003e\n 인공지능학과에서는 인공지능 기술의 기본이 되는 논리적 기초와 컴퓨터 시스템의 동작 원리를 학습하고 파이썬 등 프로그램을 개발하는 능력을 습득, 훈련한다. 고학년에서는 실용적인 인공지능 기술 개발을 위한 빅데이터분산처리, 데이터마이닝, 기계학습과 딥러닝 등 응용 분야 기술을 습득한다. 4년 교육과정에서 모든 학생들이 5개 이상의 과목 프로젝트를 수행하여 다양한 분야의 설계와 개발을 경험한다. 그리고 전공 교육과정 전체를 이용한 캡스톤 프로젝트 개발과 현장실습교육을 통한 실무적인 능력을 습득한다.\n \u003c/p\u003e`;
                  maindiv.append(txt_ai);
               }
               else{
                  maindiv.append(txt.content);
                  var txt_ai_button = `
                     <button type="button" class="btn btn-default" onclick="view2012()">2012년 교육과정</button>
                     <button type="button" class="btn btn-default" onclick="view2017()">2017년 교육과정</button>
                     <button type="button" class="btn btn-default" onclick="view2018()">2018년 교육과정</button>
                   `;
                  btn_div.prepend(txt_ai_button);
               }

               //추가종료
               
               var list = $('#tabMenu');
               var tabmenu = <%=tabMenuList%>;
               for (var i = 0; i < tabmenu.length; ++i) {
                  var value = tabmenu[i];
                  var num = value.tab_id*10+value.orderNum;
                  var text = '<li><span class="deco_dot">●</span><a href="'+value.path+'?num='+num+'">'+ value.page_title + '</a></li>'
                           list.append(text);
                  }
               
               var titlediv = $('#maintitle');
               for(var i = 0 ; i < tabmenu.length ; ++i){
                  if(((tabmenu[i].id) == txt.text_id))
                     titlediv.append(tabmenu[i].page_title);
               }
               
               var panel = $('#titlename');
               var pane = $('#title');
               var number = <%=num%>;
               var headtitle = <%=headermenulist%>;
               for(var i = 0 ; i < headtitle.length ; ++i)
                  if(headtitle[i].tab_id*10 < number && (headtitle[i].tab_id+1)*10 > number)   {
//                     pane.prepend('<img src="'+headtitle[i].tab_img+'" alt="">');
                     panel.append(headtitle[i].tab_title);
                     break;
                     }
               var type = <%=type%>;
               if(user != null)
               if(type.type_name == '관리자'||type.type_name == '홈페이지관리자'){
               var modify_button = $('#modify_button');
               modify_button.append('<div id="write_post" class="col-xs-13 text-right" style = "margin : 2px;"><button type="button" class="btn btn-default" onclick="modify()">수정</button></div>');}
               
               
               function modify(){
                  var a='';
                  modify_button.html(a);
                  a+='<textarea id="editor">'+txt.content+'</textarea>';
                  a+='<div id="write_post" class="col-xs-13 text-right"><button type="button" class="btn btn-default" style = "margin : 2px;" onclick="modifyinfo()">수정</button>';
                  a+='<button type="button" class="btn btn-default" style = "margin : 2px;" onclick="back()">뒤로</button></div></div>';
                  $('#maintext').html(a);
                   
                  CKEDITOR.replace('editor', {
                         allowedContent: true,
                         height: 500,
                         'filebrowserUploadUrl': 'Uploader'
                     });
               }
               
               function back(){
                  var a='';
                  a+=txt.content;
                  $('#maintext').html(a);
                  var b='<div id="write_post" class="col-xs-13 text-right" style = "margin : 2px;"><button type="button" class="btn btn-default" onclick="modify()">수정</button></div>';
                  $('#modify_button').html(b);
               }
               function modifyinfo(){
                  var content = CKEDITOR.instances.editor.getData();
                  var text=<%=text%>;
                  var modify=text.text_id+"-/-/-"+content;
                  
                  $.ajax({
                     url: 'ajax.do',
                     type : 'post',
                     data :{
                        req : "modifyinfo",
                        data : modify
                     },
                     dataType:"json",
                     success : function(data){
                        if(data != ''){
                           alert("수정완료");
                           txt=data;
                           $('#maintext').html(txt.content);
                           var b='<div id="write_post" class="col-xs-13 text-right" style = "margin : 2px;"><button type="button" class="btn btn-default" onclick="modify()">수정</button></div>';
                           $('#modify_button').html(b);
                        }
                     else
                        alert('SERVER ERROR, Please try again later');}
                     ,
                  error : function(request,status,error){
                     alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                  }
                  })
               }
               // view2017();
               view2021(); //기본로딩값
               function view2012(){
                  var list = $('#curriculum_view');
                  list.empty();
                  list.append('<div class="contenttitle">2012년도 교육과정</div>'
                  +'<img src="./img/교육과정02.png" id="curriculum_2012" width="750px;">'
                  +'<div class="contenttitle">2012년도 교육과정 이수체계도</div>'
                  +'<img src="./img/edu2012.png" id="edu_2012" width="750px;">');
               }
               function view2017(){
                  var list = $('#curriculum_view');
                  list.empty();
                  list.append('<div class="contenttitle">2017년도 교육과정</div>'
                  +'<img src="./img/교육과정01.png" id="curriculum_2017" width="750px;">'
                  +'<div class="contenttitle">2017년도 교육과정 이수체계도</div>'
                  +'<img src="./img/edu2017.png" id="edu_2017" width="750px;">');
               }
               function view2018(){
                  var list = $('#curriculum_view');
                  list.empty();
                  list.append('<div class="contenttitle">2018년도 교육과정</div>'
                  +'<img src="./img/교육과정2018.png" id="curriculum_2017" width="750px;">'
                  +'<div class="contenttitle">2018년도 교육과정 이수체계도</div>'
                  +'<img src="./img/edu2018.png" id="edu_2018" width="750px;">');
               }
               function view2021(){
                  var list = $('#curriculum_view');
                  list.empty();
                  //
                  if (((<%=num%>) == "21") && ((myurl == "lo") || (myurl == "ai"))){
                     list.append('<div class="contenttitle">2021년도 교육과정</div>'
                             +'<img src="./img/교육과정2021_ai.png" id="curriculum_2021" width="750px;">'
                             +'<div class="contenttitle">2021년도 교육과정 이수체계도</div>'
                             +'<img src="./img/edu2021_ai.png" id="edu_2021" width="750px;">');
                  }
                  else{
                     list.append('<div class="contenttitle">2021년도 교육과정</div>'
                             +'<img src="./img/교육과정2021.png" id="curriculum_2021" width="750px;">'
                             +'<div class="contenttitle">2021년도 교육과정 이수체계도</div>'
                             +'<img src="./img/edu2021.png" id="edu_2021" width="750px;">');
                  }
                  //추가종료

                  // list.append('<div class="contenttitle">2021년도 교육과정</div>'
                  //         +'<img src="./img/교육과정2021.png" id="curriculum_2021" width="750px;">'
                  //         +'<div class="contenttitle">2021년도 교육과정 이수체계도</div>'
                  //         +'<img src="./img/edu2021.png" id="edu_2021" width="750px;">');
               }
            </script>
   </main>
   
   <%@include file="../main/footer.jsp" %>
   <div id="shadow">
      <div id="blur"></div>
   </div>

</body>
</html>