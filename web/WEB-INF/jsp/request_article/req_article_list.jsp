<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
    StringBuffer url2_ra_list = request.getRequestURL();
    String logo_img_ra_list;

    //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
    //ai이면 ai로고 cs이면 cs로고
    if(url2_ra_list.substring(7,9).equals("ai") || url2_ra_list.substring(7,9).equals("lo")){
        logo_img_ra_list = "img/apply_ai.png";
    }
    else{
        logo_img_ra_list = "img/apply.png";
    }
    //System.out.println((logo_img_ra_list));
%>
<% 
String boardslist=(String)request.getAttribute("boardslist");
String tabmenulist=(String) request.getAttribute("tabmenulist");
String num=(String) request.getAttribute("num");
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="utf-8">
<title>신청 및 접수: 경기대학교 AI컴퓨터공학부</title>
 <link rel="stylesheet" href="css/bootstrap-table.css"> 
<link href='css/bootstrap.css' rel='stylesheet' type='text/css'>
<link href='css/default.css' rel='stylesheet' type='text/css'>
<link href='css/boardtable.css' rel='stylesheet' type='text/css'>
<link href='css/information.css' rel='stylesheet' type='text/css'>
<link href='css/content.css' rel='stylesheet' type='text/css'>
<style>
#maincontent {
   padding: 0;
}

#maincontent>ul {
   padding: 10px;
}
.boardtable > tbody > tr > td:nth-child(1),.boardtable > tbody > tr > td:nth-child(2),.boardtable > tbody > tr > td:nth-child(3),.boardtable > tbody > tr > td:nth-child(4),.boardtable > tbody > tr > td:nth-child(5){
padding-bottom:5px !important;
}
.boardtable > thead > tr > th:nth-child(1), .boardtable > tbody > tr > td:nth-child(1) {
    min-width: 65px;
    max-width: 65px;
    width: 65px;
}

.boardtable > thead > tr > th:nth-child(2), .boardtable > tbody > tr > td:nth-child(2) {
    min-width: 280px;
    max-width: 280px;
    width: 380px;
}

.boardtable > thead > tr > th, .boardtable > tbody > tr > td{
   text-overflow: ellipsis;
    overflow: hidden;
    white-space: nowrap;
      text-align: center;
      border-right : none;
      border-left : none;
}

.boardtable > thead > tr > th:nth-child(4), .boardtable > tbody > tr > td:nth-child(4) {
    min-width: 90px;
    max-width: 90px;
    width: 90px;
}

.boardtable > thead > tr > th:nth-child(5), .boardtable > tbody > tr > td:nth-child(5) {
    min-width: 65px;
    max-width: 65px;
    width: 65px;
}
.boardtable > tbody > tr > td:nth-child(6){
padding-top:5px !important;
padding-bottom:5px !important;
}
.fixed-table-container{
   border : none;
}

.pagination-info{
display : none;
}

.pull-right-pagination{
width : 100%;
}

.pull-right{
float : none !important;
}

.fixed-table-pagination{
width : 100%;
text-align : center;
}

div .search{
width : fit-content;
float : right !important;
}

</style>
</head>
<body>
   <script src="js/default.js"></script>
   <script src="js/jquery-3.2.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/bootstrap-table.js"></script>
    <script src="js/bootstrap-table-cookie.js"></script>
   <%@include file="../main/header.jsp"%>
   <main>
   <div id="content">
      <div id="title">
          <img src=<%=logo_img_ra_list%> />
          <div id="titlename"></div>
      </div>
      <div id="container">
         <div id="tab">
         <ul id="tab_2">
         </ul>
         </div>
         <div id="maincontent">
             <table class="boardtable" id="table"
               data-toggle="table"
               data-pagination="true"
               data-search="true"
               data-page-list="[10]"
              >
               <thead>
                  <tr>
                       <th data-field="no" data-sortable="true">번호</th>
                      <th data-field="title" data-sortable="true">제목</th>
                      <th data-field="limit_date" data-sortable="true">기간</th>
                      <th data-field="views" data-sortable="true">참여수</th>
                      <th data-field="available">대상</th>
                      <th data-field="buttons">참여하기</th>
                  </tr>
               </thead>
            </table>
            <div id="write_post" class="post_button">
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
               var write=$("#write_post");
               var type = <%=type%>;
               if(type.board_level <= 3)
                  write.append( '<a href="req_article_writer.do" class="btn btn-default">글쓰기</a>');
   
                 var boards=<%=boardslist%>;

                  function callSetupTableView(){
                     $('#table').bootstrapTable('append',data());
                       $('#table').bootstrapTable('refresh');
                  }
                 
                  function formatDate(date) {
                     var d = new Date(date),
                         month = '' + (d.getMonth() + 1),
                         day = '' + d.getDate(),
                         year = '' + d.getFullYear();

                     if (month.length < 2) month = '0' + month;
                     if (day.length < 2) day = '0' + day;

                     return [year, month, day].join('-');
                 }
                  
                function data(){
                   var rows = [];
                   var type = <%=type%>;
                   var user = <%=user%>;
                   for(var i=0;i<boards.length;i++){
                      var value= boards[i];
                      var lvlText='';
                      var can = '';
                      if(user != null){
                    	  if(value.student_id==user.id){
                              lvlText = '<a href="req_article_reader.do?id='+value.id+'&num=' + <%=num%> + '">'+value.title+'</a>';
                              can = '작성자';
                           }
                    	  else if(value.level.indexOf(type.for_header) >= 0 || type.for_header == '관리자'){
                              lvlText = '<a href="req_article_reader.do?id='+value.id+'">'+value.title+'</a>';
                              can = '○';
                          }
                          else{
                              lvlText = '<span>' + value.title + '<span/>';
                              can = 'ⅹ';
                          }
                      }
                      else if(value.level.indexOf(type.for_header) >= 0 || type.for_header == '관리자'){
                          lvlText = '<a href="req_article_reader.do?id='+value.id+'">'+value.title+'</a>';
                          can = '○';
                      }
                      else{
                          lvlText = '<span>' + value.title + '<span/>';
                          can = 'ⅹ';
                      }
                      var start = new Date(value.starting_date).getTime();
                      var close = new Date(value.closing_date).getTime() + 1000*60*60*24;
                      var today = new Date().getTime();
                      var buttonText = '';
                      if(start <= today && today <= close && (value.level.indexOf(type.for_header) >= 0 || type.for_header == '관리자'))
                         buttonText = '<button class="btn btn-primary" onclick="goReqBoard(' + value.id + ')" style="padding : 2px 13px; font-size : 13px;">참가</button>';
                      else if(close <= today)
                         buttonText = '<button class="btn btn-danger " style="padding : 2px 13px; font-size : 13px;" disabled>만료</button>';
                      else if(start > today)
                         buttonText = '<button class="btn btn-danger " style="padding : 2px 13px; font-size : 13px;" disabled>대기</button>';
                         else
                          buttonText = '<button class="btn btn-danger" style="padding : 2px 13px; font-size : 13px;" disabled>불가</button>';
                      rows.push({
                         no : value.id,
                         title: lvlText,
                         available: can,
                         limit_date:formatDate(value.starting_date).substring(2,12)+" ~ "+formatDate(value.closing_date).substring(2,12),
                         views: value.views+"명",
                         buttons: buttonText
                      });
                   }
                   return rows;
                }
                
                $(document).ready(function(){
                   callSetupTableView();
                   $('#articlename').append('<img src="img/list.gif"> '+arr[indexOfName].page_title);
                   $('.fixed-table-toolbar').css('margin-top' , '15px');
                })
                
                function goReqBoard(id){
                   window.location.href = 'req_article_reader.do?id='+id;
                }

     var list = $('#tab_2');
     var articlename=$('#articlename');
     var num=<%=num%>;
     var indexOfName = 0;

     numo=num%10;//orderNum
     numt=num/10;//tab_id
     
    var arr = <%=tabmenulist%>;   //탭메뉴리스트 넘어옴
      for (var i = 0; i < arr.length; i++) {         
         var value = arr[i];
         if(value.show_in_menus)
            list.append(makeone(value));
         if(value.orderNum==numo)
             var indexOfName = i;
      }
   function makeone(str) {   //탭메뉴만들기
      var num=str.tab_id*10+str.orderNum;
   		if(str.page_title == '졸업논문'){
   			if(<%=type%>.type_name == '졸업논문관리자' || <%=type%>.type_name == '교수1' || <%=type%>.type_name == '학부생' || <%=type%>.type_name == '복수전공생' || <%=type%>.type_name == '교수2' || <%=type%>.type_name == '관리자')
   				return '<li><span class="deco_dot">●</span><a href="'+str.path+'">' + str.page_title + '</a></li>';
            else
                return '<li><span class="deco_dot">●</span>' + str.page_title + '</li>';
   		}
        else if(str.page_title == '나의 이수 현황'){
            return '<li><span class="deco_dot">●</span><a href="'+str.path+'">' + str.page_title + '</a></li>';
        }
        else
              return '<li><span class="deco_dot">●</span><a href="'+str.path+'?num='+num+'">'
                    + str.page_title + '</a></li>';
   }
   
  
   
   var pane = $('#title');
     var panel =$('#titlename');
   var headtitle = <%=headermenulist%>;
   for(var i = 0 ; i < headtitle.length ; ++i)
      if(headtitle[i].tab_id <numt && headtitle[i].tab_id>(numt-1))
         {
//         pane.prepend('<img src="'+headtitle[i].tab_img+'" alt="">');
         panel.append(headtitle[i].tab_title);
         break;
         }
   
   </script>
</body>
</html>