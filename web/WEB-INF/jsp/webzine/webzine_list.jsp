<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
    StringBuffer url2_wz_list = request.getRequestURL();
    String logo_img_wz_list;

    //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
    //ai이면 ai로고 cs이면 cs로고
    if(url2_wz_list.substring(7,9).equals("ai") || url2_wz_list.substring(7,9).equals("lo")){
        logo_img_wz_list = "img/webzine_ai.png";
    }
    else{
        logo_img_wz_list = "img/webzine.png";
    }
//    System.out.println((logo_img_wz_list));
%>
<% 
String boardslist=(String)request.getAttribute("boardslist");
String tabmenulist=(String) request.getAttribute("tabmenulist");
String num=(String) request.getAttribute("num");
String readLevel = (String) request.getAttribute("readLevel");
String writeLevel = (String) request.getAttribute("writeLevel");
String menu = (String) request.getAttribute("menu");
String fileBoardId = (String) request.getAttribute("fileBoardId");
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="utf-8">
<title>게시판:경기대학교 AI컴퓨터공학부</title>
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
.boardtable > thead > tr > th, .boardtable > tbody > tr > td{
   text-overflow: ellipsis;
    overflow: hidden;
    white-space: nowrap;
      text-align: center;
      border-right : none;
      border-left : none;
}
.boardtable > thead > tr > th:nth-child(1), .boardtable > tbody > tr > td:nth-child(1) {
    min-width: 65px;
    max-width: 65px;
    width: 65px;
}
.boardtable > thead > tr > th:nth-child(2), .boardtable > tbody > tr > td:nth-child(2) {
    min-width: 350px;
    max-width: 350px;
    width: 350px;
}

.boardtable > thead > tr > th:nth-child(3),.boardtable > tbody > tr > td:nth-child(3),.boardtable > thead > tr > th:nth-child(5),.boardtable > tbody > tr > td:nth-child(5){
    min-width: 80px;
    max-width: 80px;
    width:80px;
}

.boardtable > thead > tr > th:nth-child(4),.boardtable > tbody > tr > td:nth-child(4){
   min-width: 100px;
   max-width: 100px;
   width: 100px;
}
.boardtable > thead > tr > th:nth-child(5),.boardtable > tbody > tr > td:nth-child(5){
   min-width: 70px;
   max-width: 70px;
   width: 70px;
}
.boardtable > thead > tr > th:nth-child(6),.boardtable > tbody > tr > td:nth-child(6){
   min-width: 70px;
   max-width: 70px;
   width: 70px;
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
          <img src=<%=logo_img_wz_list%> />
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
               <thead >
                  <tr class="table-style" >
                      <th data-field="board_id" data-sortable="true">번호</th>
                      <th data-field="title" data-sortable="true">제목</th>
                      <th data-field="student_id" data-sortable="true">글쓴이</th>
                      <th data-field="last_modified" data-sortable="true">작성일</th>
                      <th data-field="views" data-sortable="true">조회</th>
                      <th data-field="likes" data-sortable="true">추천</th>
                  </tr>
               </thead>
            </table>
            <div id="write_post" class="post_button">
            </div>
            </div>
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
   var num=<%=num%>;            
   var write=$("#write_post");
   if(Number(<%=writeLevel%>) >= <%=type%>.board_level && <%=menu%>.page_title != '전체공지')
      write.append( '<a href="webzine_writer.do?num='+num+'" class="btn btn-default">글쓰기</a>');
   
         
         function formatDate(date) {
            var d = new Date(date),
                month = '' + (d.getMonth() + 1),
                day = '' + d.getDate(),
                year = d.getFullYear();

            if (month.length < 2) month = '0' + month;
            if (day.length < 2) day = '0' + day;

            return [year, month, day].join('-');
        } 
         
                 var boards=<%=boardslist%>;
                  function callSetupTableView(){
                     $('#table').bootstrapTable('append',data());
                       $('#table').bootstrapTable('refresh');
                  }
                  
                  
      	var fileBoardId = <%=fileBoardId%>;
      	var fileBoardIdArray = [];
      	for(var i = 0 ; i < fileBoardId.length ;  ++i)
      		fileBoardIdArray.push(fileBoardId[i].board_id);
                function data(){
                   var rows = [];
                   var type = <%=type%>;
                   var readLevel = <%=readLevel%>;
                   for(var i=0;i<boards.length;i++){
                      var value=boards[i];
                      var for_title = '';
                      var titleCut = '';
                      if(value.title.length > 33)
                    	  titleCut = value.title.substring(0,33) + '...';
                      else
  						  titleCut = value.title;                  		  
                      if(Number(readLevel) < type.board_level ){
                     	    for_title = titleCut;
                     	    if(value.comments_count != 0)
                     	    	for_title += ' <span style="font-size : 11px">[' + value.comments_count + ']</span>';
                     	   if(fileBoardIdArray.indexOf(value.id) >= 0)
    							for_title += '<img src="img/file_ico.png" style="margin-left : 5px;">';
                      }
                      else{
     						for_title = '<a href="webzine_reader.do?id='+value.id+'&num='+ num +'">'+titleCut;
     						if(value.comments_count != 0)
     							for_title += ' <span style="font-size : 11px">[' + value.comments_count + ']</span>';
     						if(fileBoardIdArray.indexOf(value.id) >= 0)
     							for_title += '<img src="img/file_ico.png" style="margin-left : 5px;">';
     						for_title += '</a>';
                      }
                      rows.push({
                         board_id: boards.length - i,
                         title: for_title,
                         student_id: value.student_name,
                         last_modified: formatDate(value.last_modified),
                         views: value.views,
                         likes : value.likes
                      });
                      
                   }
                   return rows;
                }
                
                $(document).ready(function(){
                   callSetupTableView();
                   $('#articlename').append('<img src="img/list.gif"> '+arr[indexOfName].page_title);
                   $('.fixed-table-toolbar').css('margin-top' , '15px');
                })


      var list = $('#tab_2');
     var articlename=$('#articlename');
     var num=<%=num%>;
     var indexOfName = 0;
     numo=num%10;//orderNum
     numt=num/10;//tab_id
     
    var arr = <%=tabmenulist%>;
      for (var i = 0; i < arr.length; i++) {         
         var value = arr[i];
         if(value.show_in_menus)
         list.append(makeone(value));
         if(value.orderNum==numo)
             var indexOfName = i;
      }
   function makeone(str) {
      var num=str.tab_id*10+str.orderNum;
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