<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
   StringBuffer url2_info = request.getRequestURL();
   String logo_img_info;

   //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
   //ai이면 ai로고 cs이면 cs로고
   if(url2_info.substring(7,9).equals("ai") || url2_info.substring(7,9).equals("lo")){
      logo_img_info = "img/intro_ai.png";
   }
   else{
      logo_img_info = "img/intro.png";
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
   <main>
   <div id="content">
      <div id="title">
         <img src=<%=logo_img_info%> />
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
         </div>
      </div>
   </div>
            <script>
               var maindiv = $('#maintext');
               var txt = <%=text%>;

               //ai학부는 따로 텍스트를 넣어줬고 cs면(else문) db에서가져온 txt를 추가함.

               var myurl = window.location.href.slice(7,9);
               if (((<%=num%>) == "11") && ((myurl == "lo") || (myurl == "ai"))) {
                  var txt_ai = `\u003cul\u003e\n\t\u003cli\u003e\n\t\u003cp\u003e인공지능 기술은 4차 산업혁명 시대를 이끄는 핵심 기술입니다. 인공지능학과는 혁신적인 인공지능 기술 중심의 교육을 통해 정부와 기업, 사회의 모든 분야에서 핵심적인 역할을 할 수 있는 인재 양성에 최선을 다합니다. 또한 인공지능 분야의 산업체와의 협업, 현업에서의 전문 기술 교육을 통해 미래 지능형 사회를 이끌어갈 인재를 양성합니다.\u003c/p\u003e\n\n\t\u003cp\u003e▶ 진로\u003c/p\u003e\n\n\t\u003col style\u003d\"list-style: disc\"\u003e\n\t\t\u003cli\u003e인공지능 SW 개발자 : 미래 인공지능 사회를 이끌어갈 소프트웨어를 개발하는 전문 엔지니어\u003c/li\u003e\n\t\t\u003cli\u003e인공지능 산업 기업체 종사자 : 스마트팩토리, 스마트자동차, 스마트헬스케어 등 다양한 분야의 산업체에 취업하여 사회의 발전을 위해 일하는 전문 엔지니어\u003c/li\u003e\n\t\t\u003cli\u003e인공지능 분야 창업 : 인공지능 기술을 이용한 제품 및 서비스를 기획하고 개발하는 기업을 직접 운영하는 사업가\u003c/li\u003e\n\t\t\u003cli\u003e교육자 : 초중등 학교와 일반인 대상의 인공지능 교육을 담당할 교육분야 전문가\u003c/li\u003e\n\t\t\u003cli\u003e공무원 : 국가 전산 업무를 담당하고 4차 산업분야의 정책을 담당하는 기술 공무원\u003c/li\u003e\n\t\u003c/ol\u003e\n\n\t\u003cp\u003e▶ 학과사무실\u003c/p\u003e\n\n\t\u003col style\u003d\"list-style: disc\"\u003e\n\t\t\u003cli\u003e위치 : 8강의동 3층 8305호\u003c/li\u003e\n\t\t\u003cli\u003e전화번호 : 031-249-9670 (FAX : 031-249-9673)\u003c/li\u003e\n\t\t\u003cli\u003e홈페이지 : http://ai.kyonggi.ac.kr\u003c/li\u003e\n\t\u003c/ol\u003e\n\t\u003c/li\u003e\n\u003c/ul\u003e\n`;
                  maindiv.append(txt_ai);
               }
               else if (((<%=num%>) == "13") && ((myurl == "lo") || (myurl == "ai"))) {
                  var txt_ai = `<p>컴퓨터과학과는 최고수준의 개인용 컴퓨터와 프로젝터 환경을 갖춘 4개의 실습실을 보유하고 있으며, 반 이상의 수업이 실습실에서 진행됩니다. 또한 팀프로젝트 진행을 위한 회의 공간과 세미나실을 제공하여 활발한 커뮤니케이션을 통한 창의적 인재를 양성하는데 힘을 쏟고 있습니다.</p> <ul>  							<li>  								<div class="contenttitle2">▶ 학과전용 실습실 현황</div>  							</li>  						</ul>  						<p>  							<style type="text/css">  .tg {  	border-collapse: collapse;  	border-spacing: 0;  }    .tg td {  	font-size: 14px;  	padding: 10px 5px;  	border-style: solid;  	border-width: 1px;  	overflow: hidden;  	word-break: normal;  }    .tg th {;  	font-size: 14px;  	font-weight: normal;  	padding: 10px 5px;  	border-style: solid;  	border-width: 1px;  	overflow: hidden;  	word-break: normal;  }    .tg .tg-s6z2 {  	text-align: center  }    .tg .tg-baqh {  	text-align: center;  	vertical-align: top  }    .tg .tg-j4kc {  	background-color: #efefef;  	text-align: center  }  </style>  						<table class="tg" style="table-layout: fixed; width: 581px">  							<colgroup>  								<col style="width: 55px">  								<col style="width: 84px">  								<col style="width: 246px">  								<col style="width: 75px">  								<col style="width: 121px">  							</colgroup>  							<tr>  								<th class="tg-j4kc">번호</th>  								<th class="tg-j4kc">호실</th>  								<th class="tg-j4kc">위치</th>  								<th class="tg-j4kc">PC대수</th>  								<th class="tg-j4kc">기타</th>  							</tr>  							<tr>  								<td class="tg-s6z2">1</td>  								<td class="tg-baqh">8510</td>  								<td class="tg-baqh">8강의동 5층</td>  								<td class="tg-baqh">40</td>  								<td class="tg-baqh"></td>  							</tr>  							<tr>  								<td class="tg-s6z2">2</td>  								<td class="tg-s6z2">8001</td>  								<td class="tg-s6z2">8강의동 B1층</td>  								<td class="tg-s6z2">45</td>  								<td class="tg-s6z2"></td>  							</tr>  							<tr>  								<td class="tg-baqh">3</td>  								<td class="tg-s6z2">8308</td>  								<td class="tg-s6z2">8강의동 3층</td>  								<td class="tg-s6z2">50</td>  								<td class="tg-s6z2">야간 개방</td>  							</tr>  							<tr>  								<td class="tg-baqh">4</td>  								<td class="tg-baqh">8504</td>  								<td class="tg-baqh">8강의동 5층</td>  								<td class="tg-baqh">25</td>  								<td class="tg-baqh">개방 실습실</td>  							</tr>  						</table>  						</p>  						<hr style="border: solid 1px lightgray;" />  						<p>  							<img src="img/8001.png" width="500" height="300">  						</p>    						<p>  							<img src="img/8308.png" width="500" height="300">  						</p>    						<p>  							<img src="img/8504.png" width="500" height="300">  						</p>  						<hr style="border: solid 1px lightgray;" />  						<ul>  							<li>  								<div class="contenttitle2">▶ 기타 실습환경</div>  							</li>  						</ul>  						<p>교육과 연구를 위한 학과의 컴퓨팅 환경으로는 학과 공용으로 다수의 컴퓨터 서버, 스토리지 서버, 클러스터드  							리눅스 서버를 갖추고 있으며, 연구실 별로도 각종 서버급 컴퓨터, 워크스테이션, 최신의 퍼스널 컴퓨터 및 여러 종류의  							주변 기기를 보유하고 있습니다. 모든 컴퓨터는 초고속 통신망으로 인터넷에 연결되어 있으며 8강의동 전체에 무선랜이  							설치되어 연구실과 강의실 어느 곳에서도 무선으로 인터넷 접속이 가능하도록 되어있습니다.</p>`;
                  maindiv.append(txt_ai);
               }
               else if (((<%=num%>) == "14") && ((myurl == "lo") || (myurl == "ai"))) {
                  var txt_ai = `<p>  - AI 시스템 개발에 필요한 기초 소프트웨어 지식 습득<br /> - 체계적인 AI 시스템 모델링 및 설계 능력 함양<br /> - 다양한 AI 응용산업별 AI기술 활용 능력 배양<br /> - 소통과 문제 해결 능력을갖춘 실무형 AI 전문 인력 양성<br /> </p>      <hr style="border: 1px solid lightgray;" />    `;
                  maindiv.append(txt_ai);
               }
               else{
                  maindiv.append(txt.content);
               }

               //추가종료
               var list = $('#tabMenu');
               var tabmenu = <%=tabMenuList%>;

               //ai링크로 이동하도록
               if((myurl == "lo")||(myurl=="ai")){
                  for (var i = 0; i < tabmenu.length; ++i) {
                     var value = tabmenu[i];
                     var num = value.tab_id*10+value.orderNum;
                     var text = '<li><span class="deco_dot">●</span><a href="'
                             + value.path + '?num=' + num + '">' + value.page_title
                             + '</a></li>'
                     list.append(text);
                  }
               }
               //cs링크로 이동하도록
               else{
                  for (var i = 0; i < tabmenu.length; ++i) {
                     var value = tabmenu[i];
                     var num = value.tab_id*10+value.orderNum;
                     var text = '<li><span class="deco_dot">●</span><a href="'
                             + value.path + '?num=' + num + '">' + value.page_title
                             + '</a></li>'
                     list.append(text);
                  }
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

               if((myurl == "lo")||(myurl=="ai")) {
                  for (var i = 8; i < headtitle.length; ++i)
                     if (headtitle[i].tab_id * 10 < number && (headtitle[i].tab_id + 1) * 10 > number) {
//                     pane.prepend('<img src="'+headtitle[i].tab_img+'" alt="">');
                        panel.append(headtitle[i].tab_title);
                        break;
                     }
               }
               else {
                  for (var i = 0; i < headtitle.length; ++i)
                     if (headtitle[i].tab_id * 10 < number && (headtitle[i].tab_id + 1) * 10 > number) {
//                     pane.prepend('<img src="'+headtitle[i].tab_img+'" alt="">');
                        panel.append(headtitle[i].tab_title);
                        break;
                     }
               }

               var user = <%=user%>;
               if(<%=type%>.type_name == '관리자'||<%=type%>.type_name == '홈페이지관리자'||(<%=num%>=='92'&&<%=type%>.type_name=='졸업논문관리자'))
                  $('#modify_button').append('<div id="write_post" class="col-xs-13 text-right" style = "margin : 2px;"><button type="button" class="btn btn-default" onclick="modify()">수정</button></div>');
               
               function modify(){
                  var modify_button = $('#modify_button');
                  var a='';
                  modify_button.empty();
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
                        if(data != 'fail'){
                           alert("수정완료");
                           txt=data;
                           $('#maintext').html(txt.content);
                           var b='<div id="write_post" class="col-xs-13 text-right" style = "margin : 2px;"><button type="button" class="btn btn-default" onclick="modify()">수정</button></div>';
                           $('#modify_button').html(b);
                        }
                     else
                        alert('SERVER ERROR, Please try again later');
                        }
                  })
               }
            </script>
   </main>
   
   <%@include file="../main/footer.jsp" %>
   <div id="shadow">
      <div id="blur"></div>
   </div>

</body>
</html>