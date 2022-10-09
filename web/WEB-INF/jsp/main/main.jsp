<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%--url에 따른 로고 작업--%>
<%
   StringBuffer url2_main = request.getRequestURL();
   String logo_img_main;
   String logo_url_main;
   String button_color;
   String logo_title;
   String banner_color;

   //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
   //ai이면 ai로고 cs이면 cs로고
   if(url2_main.substring(7,9).equals("ai") || url2_main.substring(7,9).equals("lo")){
      logo_img_main = "img/banner_home2_ai.png";
      logo_url_main = "http://cs.kyonggi.ac.kr:8080/webp/Index";
      button_color = "#4955B3";
      banner_color = "#304766";
      logo_title = "컴퓨터공학전공 바로가기";
   }
   else{
      logo_img_main = "img/banner_home2.png";
      logo_url_main = "http://ai.kyonggi.ac.kr:8080/webp/Index";
      button_color = "#00897B";
       banner_color = "#2F6666";
      logo_title = "인공지능전공 바로가기";
   }
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
<title>경기대학교 AI컴퓨터공학부</title>

<link href="css/bootstrap.css" rel="stylesheet" type="text/css">

<link rel="stylesheet" href="css/swiper.css">
<link rel="stylesheet" href="css/swiper.min.css">
<link rel="stylesheet" href="css/information.css">
<link rel="stylesheet" href="css/boardtable.css">
<link rel="stylesheet" href="css/bootstrap-table.css">
<link rel="stylesheet" href="css/bootstrap.min.css">


   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">

<style>
li {
   text-overflow: ellipsis;
   overflow: hidden;
   white-space: nowrap;
   border-bottom: 1px solid gainsboro;
}

a:hover {
}

.research_banner div {
   width: 122px;
}

.site_banner div {
   width: 122px;
}

.index_post_link {
   color: grey;
   display: inline-block;
   width: 250px;
   white-space: nowrap;
   overflow: hidden;
   text-overflow: ellipsis;
}

.index_post_link:hover {
   color: "<%=button_color%>";
   font-weight : bold;
   text-decoration: none;
}

.right_side {
   border-left: 1px solid gainsboro;
}
.boardtable > thead > tr > th:nth-child(1), .boardtable > tbody > tr > td:nth-child(1) {
    min-width: 30px;
    max-width: 30px;
    width: 30px;
}
.boardtable > thead > tr > th:nth-child(2), .boardtable > tbody > tr > td:nth-child(2) {
    min-width: 60px;
    max-width: 60px;
    width: 60px;
}
.boardtable > thead > tr > th:nth-child(3), .boardtable > tbody > tr > td:nth-child(3) {
    min-width: 200px;
    max-width: 200px;
    width: 200px;
}
.boardtable > thead > tr > th, .boardtable > tbody > tr > td{
      text-align: center;
}
#list6 > li{
   padding-top:13px;
   padding-bottom:13px;
}
hr {
   padding: 0;
   margin: 0;
}

main {
   display: flex;
   flex-direction: column;
   margin: 0;
   padding: 0;
}

main>div {
   margin: 0;
   padding: 0;
   display: block;
   height: 500px;
   background-color: white;
}

main>div>div {
   display: block;
   margin: 400px auto auto;
   text-align: center;
   font-size: 35px;
   color: white;
}

main>p {
   margin-left: 200px;
   color: white;
   font-size: 25px;
   margin-bottom: 0;
}

td {
   padding: 5px;
}

.site_banner img {
   width: 122px;
}

.swiper-slide {
   overflow: hidden;
   background-size: cover;
   background-repeat: no-repeat;
}

.lab_banner {
   overflow: hidden;
}

ul {
   border: none;
}

.pagination-info {
   display : none;
}

</style>
<style>
.modal-backdrop {
   z-index: 1;
}
</style>
</head>
<body>
<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrap-table.js"></script>
<script src="js/swiper.js"></script>
   <%@include file="header.jsp"%>
   <script type="text/javascript">
      function clickList1() {
         $(".list_num1").css("color", "<%=button_color%>");
         $(".list_num2").css("color", "grey");
         $(".list_num3").css("color", "grey");
         $(".list_num1").css("font-weight", "bold");
         $(".list_num2").css("font-weight", "normal");
         $(".list_num3").css("font-weight", "normal");
         $(".list_body_num1").css("display", "block");
         $(".list_body_num2").css("display", "none");
         $(".list_body_num3").css("display", "none");
         document.getElementById('more_link').setAttribute('href',
               'notice_article_list.do?num=42');
      }

      function clickList2() {
         $(".list_num2").css("color", "<%=button_color%>");
         $(".list_num1").css("color", "grey");
         $(".list_num3").css("color", "grey");
         $(".list_num2").css("font-weight", "bold");
         $(".list_num1").css("font-weight", "normal");
         $(".list_num3").css("font-weight", "normal");
         $(".list_body_num2").css("display", "block");
         $(".list_body_num1").css("display", "none");
         $(".list_body_num3").css("display", "none");
         document.getElementById('more_link').setAttribute('href',
               'notice_article_list.do?num=43');
      }

      function clickList3() {
         $(".list_num3").css("color", "<%=button_color%>");
         $(".list_num1").css("color", "grey");
         $(".list_num2").css("color", "grey");
         $(".list_num3").css("font-weight", "bold");
         $(".list_num1").css("font-weight", "normal");
         $(".list_num2").css("font-weight", "normal");
         $(".list_body_num3").css("display", "block");
         $(".list_body_num1").css("display", "none");
         $(".list_body_num2").css("display", "none");
         document.getElementById('more_link').setAttribute('href',
               'notice_article_list.do?num=44');
      }

      function click2List1() {
         $(".list2_num1").css("color", "<%=button_color%>");
         $(".list2_num2").css("color", "grey");
         $(".list2_num1").css("font-weight", "bold");
         $(".list2_num2").css("font-weight", "normal");
         $(".list2_body_num1").css("display", "block");
         $(".list2_body_num2").css("display", "none");
         document.getElementById('more_link2').setAttribute('href', 'webzine_list.do?num=61');
      }

      function click2List2() {
         $(".list2_num2").css("color", "<%=button_color%>");
         $(".list2_num1").css("color", "grey");
         $(".list2_num2").css("font-weight", "bold");
         $(".list2_num1").css("font-weight", "normal");
         $(".list2_body_num2").css("display", "block");
         $(".list2_body_num1").css("display", "none");
         document.getElementById('more_link2').setAttribute('href', 'webzine_list.do?num=61');
      }
      
   </script>
   <div class="main">
      <div class="main_left" id="main_1">
         <!-- Slider main container -->
         <div class="swiper-container">
            <!-- Additional required wrapper -->
            <div class="swiper-wrapper">
               <!-- Slides -->
            </div>
            <!-- If we need pagination -->
            <div class="swiper-pagination"></div>

            <!-- If we need navigation buttons -->
            <div class="swiper-button-prev"></div>
            <div class="swiper-button-next"></div>

            <!-- If we need scrollbar -->
            <div class="swiper-scrollbar"></div>
         </div>
      </div>
      <div class="main_right" class="content_container">
<%--         <ul>--%>
<%--            <a href="http://kutis.kyonggi.ac.kr/webkutis/" title="경기대학교 쿠티스">--%>
<%--               <li class="site_banner" id="banner5" style="border : 1px white solid"></li>--%>
<%--            </a>--%>
<%--            <a href="http://lms.kyonggi.ac.kr/" title="경기대학교 LMS">--%>
<%--               <li class="site_banner" id="banner4" style="border : 1px white solid"></li>--%>
<%--            </a>--%>
<%--            <a href="https://www.facebook.com/kgucs/" title="경기대학교 컴퓨터과학과 페이스북">--%>
<%--               <li class="site_banner" id="banner3" style="border : 1px white solid"></li>--%>
<%--            </a>--%>
<%--            <a href="http://swuniv.kyonggi.ac.kr/introduction/organization" title="소프트웨어중심대학 사업단">--%>
<%--               <li class="site_banner" id="banner7" style="border : 1px white solid"></li>--%>
<%--            </a>--%>
<%--            <a href="https://sites.google.com/kyonggi.ac.kr/ccsri" title="콘텐츠융합소프트웨어연구소">--%>
<%--               <li class="site_banner" id="banner8" style="border : 1px white solid"></li>--%>
<%--            </a>--%>
<%--            &lt;%&ndash;      cs,ai변환 링크      &ndash;%&gt;--%>
<%--            <a href=<%=logo_url_main%> target="_blank" title="전환하기">--%>
<%--               <li class="site_banner" style="background-image: url(<%=logo_img_main%>); border : 1px white solid"></li>--%>
<%--            </a>--%>
<%--         </ul>--%>
         <div class="list-group">
            <a href="http://kutis.kyonggi.ac.kr/webkutis/" target="_blank" class="list-group-item list-group-item-action py-3 lh-tight" style="color: <%=banner_color%>;">
               <div class="d-flex w-100 align-items-center justify-content-between">
<%--                   <i class="bi bi-app" style="color: white"></i>--%>
                   <p class="h4 m-0" style="margin-left: 15px; padding-top: 2px;">KUTIS</p>
                   <i class="h4 m-0 bi bi-house-fill" style="font-size: 24px; margin-top: 0px;margin-bottom: 0px;padding-top: 8px;"></i>
               </div>
            </a>
            <a href="http://lms.kyonggi.ac.kr/" target="_blank" class="list-group-item list-group-item-action py-3 lh-tight" style="color: <%=banner_color%>;">
               <div class="d-flex w-100 align-items-center justify-content-between">
<%--                   <i class="bi bi-app" style="color: white"></i>--%>
                  <p class="h4 m-0" style="margin-left: 15px; padding-top: 2px;">LMS</p>
                   <i class="h4 m-0 bi bi-pencil-square" style="font-size: 24px; margin-top: 0px;margin-bottom: 0px;padding-top: 8px;"></i>
               </div>
            </a>
            <a href="https://www.facebook.com/kgucs/" target="_blank" class="list-group-item list-group-item-action py-3 lh-tight" style="color: <%=banner_color%>;">
               <div class="d-flex w-100 align-items-center justify-content-between">
<%--                   <i class="bi bi-app" style="color: white"></i>--%>
                  <p class="h4 m-0" style="margin-left: 15px; padding-top: 2px;">학과 페이스북</p>
                   <i class="h4 m-0 bi bi-facebook" style="font-size: 24px; margin-top: 0px;margin-bottom: 0px;padding-top: 8px;"></i>
               </div>
            </a>
            <a href="http://swuniv.kyonggi.ac.kr/introduction/organization" target="_blank" class="list-group-item list-group-item-action py-3 lh-tight" style="color: <%=banner_color%>;">
               <div class="d-flex w-100 align-items-center justify-content-between">
<%--                   <i class="bi bi-app" style="color: white"></i>--%>
                  <p class="h4 m-0" style="margin-left: 15px; padding-top: 2px;">소프트웨어중심대학</p>
                   <i class="h4 m-0 bi bi-bookmark-check-fill" style="font-size: 24px; margin-top: 0px;margin-bottom: 0px;padding-top: 8px;"></i>
               </div>
            </a>
            <a href="https://sites.google.com/kyonggi.ac.kr/ccsri" target="_blank" class="list-group-item list-group-item-action py-3 lh-tight" style="color: <%=banner_color%>;">
               <div class="d-flex w-100 align-items-center justify-content-between">
<%--                   <i class="bi bi-app" style="color: white"></i>--%>
                  <p class="h4 m-0" style="margin-left: 15px;margin-top: 3px;margin-bottom: 3px;padding-top: 5px;padding-bottom: 5px;">콘텐츠융합<br>소프트웨어연구소</p>
                  <i class="h4 m-0 bi bi-book" style="font-size: 24px;padding-bottom: 14px;padding-top: 14px;margin-top: 0px;margin-bottom: 0px;"></i>
               </div>
            </a>
            <a href="<%=logo_url_main%>" target="_blank" class="list-group-item list-group-item-action py-3 lh-tight" style="background-color: <%=banner_color%>;">
               <div class=" w-100 align-items-center text-center">
                  <p class="h4 m-0" style="color: white"><%=logo_title%></p>
<%--                  <i class="h4 m-0 bi-stack"></i>--%>
               </div>
            </a>
         </div>
      </div>
   </div>
   <div class="main2">
      <div class="main2_left">
         <div class="content_container">
            <div class="list_select">
               <div class="list_num1" onclick="clickList1()">학과공지</div>
               <span class="divide">|</span>
               <div class="list_num2" onclick="clickList2()">수업공지</div>
               <span class="divide">|</span>
               <div class="list_num3" onclick="clickList3()">취업공지</div>
               <div class="more">
                  <a id="more_link" href="notice_article_list.do?num=42" title="더보기"><img
                     src="img/plus_ico.png" alt=""></a>
               </div>
            </div>
            <div class="list_body_num1">
               <ul class="notice_list" id='list1'>
               </ul>
            </div>
            <div class="list_body_num2">
               <ul class="notice_list" id='list2'>
               </ul>
            </div>
            <div class="list_body_num3">
               <ul class="notice_list" id='list3'>
               </ul>
            </div>
         </div>
         <div class="content_container">
            <div class="list_select">
               <div class="list2_num1" onclick="click2List1()">학과 소식</div>
               <div class="more">
                  <a id="more_link2"  href="webzine_list.do?num=61" title="더보기">
                     <img src="img/plus_ico.png" alt="">
                  </a>
               </div>
            </div>
            <div class="list2_body_num1">
            	<ul class="notice_list" id='message_list'>
            	</ul>
            </div>
         </div>
      </div>
      <div class="main_right" style="border: 1px solid gainsboro;">
         <ul>
            <li class="site_banner" id="banner_research">
               <div>
                  주요 일정
                  <div class="more" style="padding : 0px 4px; width : auto" >
                     <a id="more_link2" title="더보기" data-toggle="modal" href="#modalTable">
                     <img src="img/plus_ico.png" style="width : auto;" alt=""></a>
                  </div>
               </div>
            </li>
            <li style="border: none;">
               <ul id='list6'>
               </ul>
            </li>
         </ul>
      </div>
   </div>

<!-- s:quick_area -->
<div class="quick_area">
   <div class="quick-slider-wrapper">
      <div class="btn_area">
         <div class="swiper-button-prev"></div>
      </div>
      <div class="swiper quick-slider">
         <div class="swiper-wrapper">
            <div class="swiper-slide">
               <a class="quick_icon" href="http://www.kyonggi.ac.kr/" target="_blank">
                  <img src="./img/sidemenu/ico_university.png" alt="경기대학교">
                  <span class="ico_name"></span>
               </a>
            </div>
            <div class="swiper-slide">
               <a class="quick_icon" href="http://swuniv.kyonggi.ac.kr/introduction/organization" target="_blank">
                  <img src="./img/sidemenu/ico_computer.png" alt="소프트웨어중심대학">
                  <span class="ico_name"></span>
               </a>
            </div>
            <div class="swiper-slide">
               <a class="quick_icon" href="https://sites.google.com/kyonggi.ac.kr/ccsri" target="_blank">
                  <img src="./img/sidemenu/ico_content.png" alt="콘텐츠융합 소프트웨어연구소">
                  <span class="ico_name"></span>
               </a>
            </div>
            <div class="swiper-slide">
               <a class="quick_icon" href="http://kutis.kyonggi.ac.kr/webkutis/view/indexWeb.jsp" target="_blank">
                  <img src="./img/sidemenu/ico_bulb.png" alt="KUTIS">
                  <span class="ico_name"></span>
               </a>
            </div>
            <div class="swiper-slide">
               <a class="quick_icon" href="https://lms.kyonggi.ac.kr/login.php" target="_blank">
                  <img src="./img/sidemenu/ico_lms.png" alt="LMS">
                  <span class="ico_name"></span>
               </a>
            </div>
            <div class="swiper-slide">
               <a class="quick_icon" href="http://www.kyonggi.ac.kr/common/intro/elearning.html" target="_blank">
                  <img src="./img/sidemenu/ico_edu.png" alt="E-러닝">
                  <span class="ico_name"></span>
               </a>
            </div>
         </div>
      </div>
      <div class="btn_area">
         <div class="swiper-button-next"></div>
      </div>
   </div>
</div>
<!-- e:quick_area -->


   <div id="shadow">
      <div id="blur"></div>
   </div>
   <%@include file="footer.jsp"%>
   <!-- /.modal -->
   <div class="container">
      <div class="modal" id="modalTable" tabindex="-1" role="dialog"
         aria-labelledby="myModalLabel" aria-hidden="true">
         <div class="modal-dialog">
            <div class="modal-content">
               <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal"
                     aria-label="Close">
                     <span aria-hidden="true">&times;</span>
                  </button>
                  <h4 class="modal-title">주요 일정</h4>
               </div>
               <div class="modal-body">
                  <table id="schedule_table" class="table" data-toggle="table" data-search="true" data-pagination="true"  data-page-list="[10]">
                     <thead>
                        <tr>
                           <th data-field="index">번호</th>
                           <th data-field="date">날짜</th>
                           <th data-field="content">일정</th>
                        </tr>
                     </thead>
                  </table>
               </div>
               <div class="modal-footer">
                  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
               </div>
            </div>
            <!-- /.modal-content -->
         </div>
         <!-- /.modal-dialog -->
      </div>
   </div>
   <!-- /.modal -->
   <script>
      var schedule;
      var table = $('#schedule_table'); 
      function getSchedule(){
            $.ajax({
                url : 'ajax.do',
                type : 'post',
                 data : {
                req: 'getMainSchedule',
                  data: ''
            },
            dataType : 'json',
            async :false,
            success : function(data){
                     schedule =   data;
                  }
            });         
      }
      
      function callSetupTableView() {
         table.bootstrapTable('append', data());
         table.bootstrapTable('refresh');
      }
      
      function data() {
         var rows = [];
         for (var i = 0; i < schedule.length; i++) {
            var value = schedule[i];
            var schDate = makedate(value);
            rows.push({
               index : i+1,
               date : schDate,
               content : value.content
            });
         }
         return rows;
      }
      
      $(function() {
         $('#modalTable').on('shown.bs.modal', function() {
            table.bootstrapTable('refresh');
         });
      });
      
      function makeone2(str) {
         var date = new Date(str.date);
          var month = date.getMonth() + 1;
          var day = date.getDate();
          var week = getInputDayLabel(date);
          if(month.length < 2)
             month += '0' + month;
          if(day.length < 2)
             day += '0' + day;
         return '<li class="schedule"><span class="schedule_date">'+month+'.'+day+'('+week+')'+'</span>&nbsp<span class="divide">|</span>&nbsp'+str.content+ '</li>';
      }
      
      function makedate(str){
         var date = new Date(str.date);
          var week = getInputDayLabel(date);
          return formatDateSch(str.date)+' ('+week+')';
      }
      
      function formatDate(date) {
          var d = new Date(date),
              month = '' + (d.getMonth() + 1),
              day = '' + d.getDate(),
              year = d.getFullYear();

          if (month.length < 2) month = '0' + month;
          if (day.length < 2) day = '0' + day;

          return [year, month, day].join('-');
      } 
      
      function formatDateSch(date){
         var d = new Date(date),
          month = '' + (d.getMonth() + 1),
          day = '' + d.getDate(),
          year = d.getFullYear();

      if (month.length < 2) month = '0' + month;
      if (day.length < 2) day = '0' + day;

      return [year%100, month, day].join('-');
      }
      
      function makeScheduleBoard() {
          getSchedule();
         var list = $('#list6');
         var arr = schedule;
         var scheduleline;
         if(schedule.length>6)
            scheduleline = 6;
         else scheduleline = schedule.length
         for (var i = 0; i < scheduleline; i++) {
            var value = arr[i];
            list.append(makeone2(value));
         }
      }
      
      function getInputDayLabel(day) {
         var week = new Array('일', '월', '화', '수', '목', '금', '토');
         var today = day.getDay();
         var todayLabel = week[today];
         return todayLabel; 
         }

      function makeBoard(){
         for(var i = 1 ; i <= 3 ; ++i){
           $.ajax({
              url : 'ajax.do',
              type : 'post',
              data : {
                 req : 'getMainNote',
                 data : i 
              },
              dataType : 'json',
              async : false,
              success : function (data){
                    var Panel = $('#list'+i);
                    var lists = data;
                    var num = getNumWithId(lists[0].category);
                    for(var j = 0 ; j < lists.length ; ++j){
                       var value = lists[j];
                       Panel.append('<li style="padding : 2px"><a href="notice_article_reader.do?num=' + num + '&id='+ value.id+'"class="index_post_link">'
                          + value.title + '</a><span class="date">' + formatDate(value.last_modified)
                          + '</span></li>');
                    }
              }
           })
         }
      }
   
      function getNumWithId(id){
         var result = '';
         $.ajax({
            url : 'ajax.do',
            type : 'post',
            data : {
               req : 'getonemenu',
               data : id
            },
            async : false,
            dataType : 'json',
            success : function(data){
               var value = data;
               result += value.tab_id;
               result += value.orderNum;
            }
         });
         return result;
      }
      
      $.ajax({
          url : 'ajax.do',
          type : 'post',
          data : {
             req : 'getSlider',
             data : ''
          },
          dataType : 'json',
          success : function(data){
        	  if(data != 'fail'){
        		  var images = data;
        		  var panel = $('.swiper-wrapper');
        		  for(var i = 0 ; i < images.length ; ++i){
        			  var value = images[i];


        			  //url이 ai사이트이면 (로컬테스트를 위해 "lo"추가
                     // 슬라이드 이미지이름이 "ai"가 포함되면 배너에 추가
                     //즉 url이 ai이고 사진이름이 ai가 포함되면 ai사이트에만 뿌려주고
                     // cs에서는 ai가 포함된 사진 제외 배너에 뿌려줌
                     <%
                         if(url_.substring(7,9).equals("ai") || url_.substring(7,9).equals("lo")){
                     %>
                     if(value.real_name.indexOf("ai") !== -1){
                        panel.append('<div class="swiper-slide" style="background-image : url(./img/slider/' + value.real_name + ')"></div>');
                     }
                     <%
                        }
                         else{
                     %>
                     if(value.real_name.indexOf("ai") === -1){
                        panel.append('<div class="swiper-slide" style="background-image : url(./img/slider/' + value.real_name + ')"></div>');
                     }
                     <%
                         }
                     %>


        		  };
        		  var mySwiper = new Swiper('.swiper-container', {
        		         // Optional parameters
        		         direction : 'horizontal',
        		         loop : true,
        		         // If we need pagination
        		         pagination : '.swiper-pagination',
        		         autoplay : 5000, // 자동이동 설정 (millisecond)
        		         autoplayDisableOnInteraction : true, // 사용자 상호 작용 후 해제,비해제 여부
        		         loop : true,
        		         nextButton : '.swiper-button-next',
        		         prevButton : '.swiper-button-prev',
        		         // And if we need scrollbar
        		         scrollbar : '.swiper-scrollbar',
        		      })
        		      $('.arrow-left').on('click', function(e) {
        		         e.preventDefault();
        		         mySwiper.swipePrev();
        		      });
        		      $('.arrow-right').on('click', function(e) {
        		         e.preventDefault();
        		         mySwiper.swipeNext();
        		      })
        	  }
          }
       });
      
      function makeMessageBoard(){
    	  $.ajax({
              url : 'ajax.do',
              type : 'post',
              data : {
                 req : 'getMessageBoard',
                 data : ''
              },
              dataType : 'json',
              success : function(data){
            	  var Panel = $('#message_list');
                 for(var i = 0 ; i < data.length ; ++i){
                	 var value = data[i];
                     Panel.append('<li style="padding : 2px"><a href="webzine_reader.do?num=61&id='+ value.id+'"class="index_post_link">'
                     + value.title + '</a><span class="date">' + formatDate(value.last_modified) + '</span></li>');
                 }
              }
           });
      }
      
      $('.main').find('.site_banner').hover(function(){
         $(this).css('border', '1px solid #336666');
      }, function(){
         $(this).css('border', '1px solid white');
      })
      
      $(document).ready(function() {
         makeBoard();
         makeMessageBoard();
         makeScheduleBoard();
         callSetupTableView();
      })
      
      
      
      
   </script>



<%--여기부터 무지성으로 복붙했으므로 수정 필요함--%>
<style>
   /* ==================== quick_area ==================== */
   .quick_area { position: fixed; z-index: 160; right: -80px; top: calc( (100% - 70px - 84px) / 2 + 70px + 84px); transform: translateY(-50%); overflow: hidden; width: 100px; border-radius: 30px 0px 0px 30px; background: rgba(0, 0, 0, .4); transition: right .45s;}
   .quick_area.active { right: 0;}
   .quick_area .quick-slider-wrapper { height: 700px;}
   .quick_area .btn_area { height: 50px; }
   .quick_area .btn_area .swiper-button-prev,
   .quick_area .btn_area .swiper-button-next { position: relative; left: 0; right: 0; top: 0; bottom: 0; width: 100%; height: 100%; padding: 0; margin: 0; background-position: center center; background-size: 18px auto;}
   .quick_area .btn_area .swiper-button-prev { background-image: url('./img/sidemenu/arr_top_wht.png');}
   .quick_area .btn_area .swiper-button-next { background-image: url('./img/sidemenu/arr_bottom_wht.png');}
   .quick_area .quick-slider { overflow: hidden; height: 599px;}
   .quick_area .quick-slider .swiper-wrapper { top: -1px;}
   .quick_area .quick-slider .swiper-slide { position: relative; height: 100px;}
   /* .quick_area .quick-slider .swiper-slide::after { content: ''; display: block; position: absolute; left: 0; bottom: -1px; width: 100%; height: 1px; background-color: #C2C2C2;} */
   .quick_area .quick-slider .quick_icon { display: block; height: 100%; text-align: center;}
   .quick_area .quick-slider .quick_icon { width: 100%;}
   .quick_area .quick-slider .quick_icon .ico_neme { font-size: 12px;}

</style>
<script>
   var sec1Swiper,
           sec2Swiper,
           sec3Swiper,
           sec4Swiper,
           sec5Swiper,
           sec6Swiper;
   $(document).ready(function(){


      // $('#wrap').imagesLoaded( function() {
      //            $('#fullpage').fullpage({
      //               // sectionsColor: ['#C63D0F', '#1BBC9B', '#7E8F7C','#333'],
      //               responsiveWidth: 1200,
      //               responsiveHeight : 800,
      //               // navigation: true,
      //               // navigationPosition: 'right',
      //               anchors: ['page01', 'page02', 'page03', 'page04', 'page05', 'page06', 'page07'],
      //               // scrollOverflow: true,
      //               autoScrolling:true,
      //               keyboardScrolling: true,
      //               css3: true,
      //               'onLeave': function (anchorLink, index) {
      //                  $(".progress_bar").removeClass("type_01");
      //                  $(".progress_bar").removeClass("type_02");
      //                  $(".progress_bar").removeClass("type_03");
      //                  $(".progress_bar").removeClass("type_04");
      //                  $("#header").removeClass("active2");
      //                  if(index > 1){
      //                     $(".top_btn").stop().show(500);
      //                  } else {
      //                     $(".top_btn").stop().hide(500);
      //                  }
      //                  switch (index % 4){
      //                     case 1:
      //                        $(".logo_img").attr("src","/frontLayer/images/ico/logo_type_A.png");
      //                        break;
      //                     case 2 :
      //                        $(".logo_img").attr("src","/frontLayer/images/ico/logo_type_B.png");
      //                        break;
      //                     case 3 :
      //                        $(".logo_img").attr("src","/frontLayer/images/ico/logo_type_C.png");
      //                        break;
      //                     case 0 :
      //                        $(".logo_img").attr("src","/frontLayer/images/ico/logo_type_D.png");
      //                        break;
      //                  }
      //
      //                  if($(".section").length == index){
      //                     $("#header").addClass("active2");
      //                     switch ((index % 4) - 1){
      //                        case 1:
      //                           $(".logo_img").attr("src","/frontLayer/images/ico/logo_type_A.png");
      //                           break;
      //                        case 2 :
      //                           $(".logo_img").attr("src","/frontLayer/images/ico/logo_type_B.png");
      //                           break;
      //                        case 3 :
      //                           $(".logo_img").attr("src","/frontLayer/images/ico/logo_type_C.png");
      //                           break;
      //                        case 0 :
      //                           $(".logo_img").attr("src","/frontLayer/images/ico/logo_type_D.png");
      //                           break;
      //                     }
      //                  }
      //               },
      //            });
      //         }
      // );

      var quickSwiper = new Swiper('.quick-slider', {
         direction: "vertical",
         slidesPerView: 'auto',
         loop: true,
         navigation: {
            nextEl: ".quick_area .swiper-button-next",
            prevEl: ".quick_area .swiper-button-prev",
         },
      });

      sec1Swiper = new Swiper('.sec1-slider', {
         spaceBetween: 20,
         slidesPerView: 4,
         // slidesPerColumn: 2,
         navigation: {
            nextEl: ".notice_area .swiper-button-next",
            prevEl: ".notice_area .swiper-button-prev",
         },
         breakpoints: {
            1800: {
               slidesPerView: 3,
            },
            1400: {
               slidesPerView: 2,
            },
            750: {
               slidesPerView: 1,
            },
         },
      });
      sec2Swiper = new Swiper('.sec2-slider', {
         spaceBetween: "3.636363%",
         slidesPerView: 3,
         navigation: {
            nextEl: ".sec2-slider-wrapper .swiper-button-next",
            prevEl: ".sec2-slider-wrapper .swiper-button-prev",
         },
         breakpoints: {
            1400: {
               slidesPerView: 2,
            },
            750: {
               slidesPerView: 1,
            },
         },
      });
      sec3Swiper = new Swiper('.sec3-slider', {
         spaceBetween: "3.636363%",
         slidesPerView: 3,
         navigation: {
            nextEl: ".sec3-slider-wrapper .swiper-button-next",
            prevEl: ".sec3-slider-wrapper .swiper-button-prev",
         },
         breakpoints: {
            1400: {
               slidesPerView: 2,
            },
            750: {
               slidesPerView: 1,
            },
         },
      });
      sec4Swiper = new Swiper('.sec4-slider', {
         spaceBetween: "3.636363%",
         slidesPerView: 3,
         navigation: {
            nextEl: ".sec4-slider-wrapper .swiper-button-next",
            prevEl: ".sec4-slider-wrapper .swiper-button-prev",
         },
         breakpoints: {
            1400: {
               slidesPerView: 2,
            },
            750: {
               slidesPerView: 1,
            },
         },
      });
      sec5Swiper = new Swiper('.sec5-slider', {
         spaceBetween: "3.636363%",
         slidesPerView: 3,
         navigation: {
            nextEl: ".sec5-slider-wrapper .swiper-button-next",
            prevEl: ".sec5-slider-wrapper .swiper-button-prev",
         },
         breakpoints: {
            1400: {
               slidesPerView: 2,
            },
            750: {
               slidesPerView: 1,
            },
         },
      });
      sec6Swiper = new Swiper('.sec6-slider', {
         spaceBetween: "3.636363%",
         slidesPerView: 3,
         navigation: {
            nextEl: ".sec6-slider-wrapper .swiper-button-next",
            prevEl: ".sec6-slider-wrapper .swiper-button-prev",
         },
         breakpoints: {
            1400: {
               slidesPerView: 2,
            },
            750: {
               slidesPerView: 1,
            },
         },
      });
      var bgProt_PC = 0;
      var bgProt_MO = 0;
      f_bg_height();
      function f_bg_height(){
         if(matchMedia("screen and (max-width: 992px)").matches){
            if(bgProt_PC == 1){
               setTimeout(function(){
                  $(".bg_height").each(function(index, item){
                     var offset1 = $(item).offset().top;
                     var offset2 = $(item).find(".swiper-slide:nth-child(1) .offset_check").offset().top;
                     offset1 = Math.ceil(offset1);
                     offset2 = Math.ceil(offset2);
                     $(item).find(".section_bg").height(offset2-offset1);
                  })
               },100);
            } else {
               $(".bg_height").each(function(index, item){
                  var offset1 = $(item).offset().top;
                  var offset2 = $(item).find(".swiper-slide:nth-child(1) .offset_check").offset().top;
                  offset1 = Math.ceil(offset1);
                  offset2 = Math.ceil(offset2);
                  $(item).find(".section_bg").height(offset2-offset1);
               })
            }
            bgProt_PC = 0;
            bgProt_MO = 1;
         } else {
            bgProt_PC = 1;
            bgProt_MO = 0;
         }
      }

      var reinitProt_PC = 0;
      var reinitProt_MO = 0;
      function f_reverse_each(){
         setTimeout(function(){
            $(".type_reverse").each(function(index, item){
               window["sec"+($(item).index() + 1)+"Swiper"].destroy();
               window["sec"+($(item).index() + 1)+"Swiper"] = new Swiper($(item).find(".swiper-container"), {
                  spaceBetween: "3.636363%",
                  slidesPerView: 3,
                  navigation: {
                     nextEl: $(item).find(".swiper-button-next"),
                     prevEl: $(item).find(".swiper-button-prev"),
                  },
                  breakpoints: {
                     1400: {
                        slidesPerView: 2,
                     },
                     750: {
                        slidesPerView: 1,
                     },
                  },
               });
            });
         },10);
      }
      function reinit(){
         if(matchMedia("screen and (max-width: 992px)").matches){
            if(reinitProt_PC == 1){
               f_reverse_each();
            }
            reinitProt_PC = 0;
            reinitProt_MO = 1;
         } else {
            if(reinitProt_MO == 1){
               f_reverse_each();
            }
            reinitProt_PC = 1;
            reinitProt_MO = 0;
            $(".quick_area").removeClass("active");
         }
      }
      if(matchMedia("screen and (max-width: 992px)").matches){
         reinitProt_PC = 0;
         reinitProt_MO = 1;
      } else {
         reinitProt_PC = 1;
         reinitProt_MO = 0;
      }

      $(window).resize(function(){
         f_bg_height();
         reinit();
      });

      $('.trigger_btn').on('click', function(e){
         e.preventDefault();
         $(".quick_area").toggleClass("active");
      })

   });

   $(document).ready(function () {

      $.namespace = function () {
         var a = arguments, o = null, i, j, d;
         for (i = 0; i < a.length; i = i + 1) {
            d = a[i].split(".");
            o = window;
            for (j = 0; j < d.length; j = j + 1) {
               o[d[j]] = o[d[j]] || {};
               o = o[d[j]];
            }
         }
         return o;
      };

      $.namespace("App");
      App = {
         init: function () {
            App.chkBrowser();
            App.scroll();
            $("#wrap").addClass("loaded");
            scrollBox();
            gnb();
         },
         chkBrowser: function () {
            // 브라우저 및 버전을 구하기 위한 변수들.
            'use strict';
            if (/Android/i.test(navigator.userAgent)) {
               // 안드로이드
               $("body").addClass("android");
            } else if (/iPhone|iPad|iPod/i.test(navigator.userAgent)) {
               // iOS 아이폰, 아이패드, 아이팟
               $("body").addClass("ios");
            } else {
               $("html").addClass("pc");
            }
            $(window).resize(function () {
               gnb();

               $("html").removeClass("pc");
               if (/Android/i.test(navigator.userAgent)) {
                  // 안드로이드
                  $("body").addClass("android");
               } else if (/iPhone|iPad|iPod/i.test(navigator.userAgent)) {
                  // iOS 아이폰, 아이패드, 아이팟
                  $("body").addClass("ios");
               } else {
                  $("body").removeClass("ios android");
                  $("html").addClass("pc");
               }
            });
         },
         scroll: function () {
            var i = 0;
            $('.scroll_controller').each(function() {
               i++;
               var element = $(this);
               var scrollWrapper = $('<div />', {
                  'class': 'scrollable',
                  'html': '<div />'
               }).insertBefore(element);
               element.data('scrollWrapper', scrollWrapper);
               element.appendTo(scrollWrapper.find('div'));
               if (element.outerWidth() > element.parent().outerWidth()) {
                  element.data('scrollWrapper').addClass('has-scroll');
               }
               $(window).on('resize orientationchange', function() {
                  if (element.outerWidth() > element.parent().outerWidth()) {
                     element.data('scrollWrapper').addClass('has-scroll');
                     has_scroll_check();
                  } else {
                     element.data('scrollWrapper').removeClass('has-scroll');
                  }
               });
               if($(".scroll_controller").length == i){
                  scrollable();
                  $('.scrollable > div').scrollLeft(10);
                  $('.scrollable > div').scrollLeft(0);
                  $('.scrollable > div').on('scroll',scrollable);
                  $(".scrollable").each(function(index, item){
                     if(!$(item).is(".has-scroll")){
                        $(item).addClass("no-scroll");
                     }
                  })
               }
            });
         }
      }

      $(document).scroll(function(){
         scrollBox();
      });

      function scrollable() {
         $(this).parent(".scrollable").removeClass("scroll_left");
         $(this).parent(".scrollable").removeClass("scroll_right");
         if ($(this).scrollLeft() == 0) {
            $(this).parent(".scrollable").addClass("scroll_left");
         } else if (Math.ceil($(this).scrollLeft() + $(this).width()) >= $(this).find('.scroll_controller').width()) {
            $(this).parent(".scrollable").addClass("scroll_right");
         }
      }

      $(".mobile").scroll(function(){
         var scrollTop = $(this).scrollTop();
         var innerHeight = $(this).innerHeight();
      });

      function scrollBox(){
         if(!$("body").is('.main_page')){
            var scrollTop = $(document).scrollTop();
            if (scrollTop > 0){
               $("#header").addClass("fixed");
               $(".top_btn").stop().show(500);
            } else {
               $("#header").removeClass("fixed");
               $(".top_btn").stop().hide(500);
            }
         }
      }

      // 상단메뉴 gnb
      var gnbSpeend = 0;
      var gnbSpeend2 = 0;
      var gnbProt_PC = 0;
      var gnbProt_MO = 0;
      function gnb(){
         if(!matchMedia("screen and (max-width: 1200px)").matches){
            if (gnbProt_PC == 0){
               gnbProt_PC = 1;
               gnbProt_MO = 0;
               $(".gnb_item a").on("mouseenter",function(){
                  // $(".gnb_item").removeClass("active");
                  // $(".gnb_item").addClass("active");
                  $("#header").addClass("active");
                  depth2_height();
               });
               $(".gnb_wrap").on("mouseleave",function(){
                  $("#header").removeClass("active");
                  depth2_height();
               });
               $(".gnb_list a").on("focus",function() {
                  $(this).trigger('mouseover');
               });
               $(".gnb_list").find('a:first, a:last').on('blur', function () {
                  setTimeout(function () {
                     if (!$(".gnb_list a").is(':focus')) {
                        $("#header").removeClass("active");
                     }
                  }, 10);
               });

               $(".gnb_item > a").removeClass("active");
               $("html, body").removeClass("hidden");
               $("#header .gnb_wrap").removeClass("active");
               $(".trigger").removeClass("active");
               $(".gnb_item > a").off("click");
               $(".depth2_area").hide();

               setTimeout(function(){
                  $(".scrollable").each(function(index, item){
                     if(!$(item).is(".has-scroll")){
                        $(item).addClass("no-scroll");
                     }
                  })
               },10);
            }
         } else {
            if(gnbProt_MO == 0){
               gnbProt_MO = 1;
               gnbProt_PC = 0;
               $(".depth2_area").height("auto");
               $(".gnb_item a").off("mouseenter");
               $(".gnb_wrap").off("mouseleave");
               $(".gnb_list a").off("focus");
               $(".gnb_list").find('a:first, a:last').off('blur');
               $("#header").removeClass("active");
               $(".lang_list").removeClass("active");

               $(".gnb_item > a").on("click",function(e) {
                  e.preventDefault();
                  $(this).toggleClass("active");
                  $(this).siblings(".depth2_area").slideToggle();
               });
            }
         }
      }


      $(".lang_btn").click(function(){
         $(".lang_list").toggleClass("active");
      });

      $('.trigger_btn').on('click', function(e){
         e.preventDefault();
         $("html, body").toggleClass("hidden");
         $(this).children(".trigger").toggleClass('active');
         $(".gnb_wrap").toggleClass("active");
      })

      $(".indicator_btn").on('click', function(e){
         $(this).parent(".indicator").toggleClass("active");
         $(this).parents(".indicator_select").siblings(".indicator_select").find(".indicator").removeClass("active");
      });
      $(".option_area").mouseleave(function(){
         $(".indicator").removeClass("active");
      });

      $(".quick_area").on('focus'," a, .btn_area div", function() {
         $(".quick_area").trigger('mouseover');
      });
      $(".quick_area").on('blur', " a, .btn_area div", function() {
         $(".quick_area").trigger('mouseleave');
      });

      $(".quick_area").on('mouseover', function() {
         $(this).addClass("active");
      });
      $(".quick_area").on('mouseleave', function() {
         $(this).removeClass("active");
      });

      var depth2_h = 0;
      function depth2_height(){
         depth2_h = 0;
         $(".depth2_inner").each(function(index, item){
            if ( depth2_h < $(item).outerHeight()){
               depth2_h = $(item).outerHeight();
               $(".depth2_area").height(depth2_h);
               $(".gnb_bg_inner").height(depth2_h);
            }
         })
      }

      $('html').click(function(e){
         if($(e.target).parents('.indicator').length < 1){
            $(".indicator").removeClass("active");
         }
         if($(e.target).parents('.lang_area').length < 1){
            $(".lang_list").removeClass("active");
         }
         if($(e.target).parents('.lang_area_mo').length < 1){
            $(".lang_list_mo").removeClass("active");
            $(".lang_btn_mo").removeClass("active");
         }
      });

      $('.top_btn').click(function(e){
         if(!$("body").is('.main_page')){
            e.preventDefault();
            $("html, body").animate({ scrollTop: 0 }, 450);
            return false;
         }
      });

      function has_scroll_check(){
         $(".no-scroll").each(function(index, item){
            if($(item).is(".has-scroll")){
               setTimeout(function(){
                  $(item).removeClass("no-scroll");
                  $(item).addClass("scroll_left");
               },10);
            }
         })
      }

   });
   $(function () {
      App.init();
   });






   var Navigation$1 = {
      name: 'navigation',
      params: {
         navigation: {
            nextEl: null,
            prevEl: null,

            hideOnClick: false,
            disabledClass: 'swiper-button-disabled',
            hiddenClass: 'swiper-button-hidden',
            lockClass: 'swiper-button-lock',
         },
      },
      create: function create() {
         var swiper = this;
         Utils.extend(swiper, {
            navigation: {
               init: Navigation.init.bind(swiper),
               update: Navigation.update.bind(swiper),
               destroy: Navigation.destroy.bind(swiper),
               onNextClick: Navigation.onNextClick.bind(swiper),
               onPrevClick: Navigation.onPrevClick.bind(swiper),
            },
         });
      },
      on: {
         init: function init() {
            var swiper = this;
            swiper.navigation.init();
            swiper.navigation.update();
         },
         toEdge: function toEdge() {
            var swiper = this;
            swiper.navigation.update();
         },
         fromEdge: function fromEdge() {
            var swiper = this;
            swiper.navigation.update();
         },
         destroy: function destroy() {
            var swiper = this;
            swiper.navigation.destroy();
         },
         click: function click(e) {
            var swiper = this;
            var ref = swiper.navigation;
            var $nextEl = ref.$nextEl;
            var $prevEl = ref.$prevEl;
            if (
                    swiper.params.navigation.hideOnClick
                    && !$(e.target).is($prevEl)
                    && !$(e.target).is($nextEl)
            ) {
               var isHidden;
               if ($nextEl) {
                  isHidden = $nextEl.hasClass(swiper.params.navigation.hiddenClass);
               } else if ($prevEl) {
                  isHidden = $prevEl.hasClass(swiper.params.navigation.hiddenClass);
               }
               if (isHidden === true) {
                  swiper.emit('navigationShow', swiper);
               } else {
                  swiper.emit('navigationHide', swiper);
               }
               if ($nextEl) {
                  $nextEl.toggleClass(swiper.params.navigation.hiddenClass);
               }
               if ($prevEl) {
                  $prevEl.toggleClass(swiper.params.navigation.hiddenClass);
               }
            }
         },
      },
   };
</script>
<%--여기까지 무지성으로 복붙했으므로 수정 필요함--%>

<style>
   .d-flex {
      display: flex!important;
   }
   .justify-content-between {
      justify-content: space-between!important;
   }
   .font-weight-bold {
      font-weight: 700!important;
   }
</style>


<%--<script src="js/swiper_for_main.js"></script>--%>
<%--<script src="js/swiper_min_for_main.js"></script>--%>
</body>
</html>