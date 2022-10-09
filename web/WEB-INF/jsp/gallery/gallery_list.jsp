<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
    StringBuffer url2_gal_list = request.getRequestURL();
    String logo_img_gal_list;

    //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
    //ai이면 ai로고 cs이면 cs로고
    if(url2_gal_list.substring(7,9).equals("ai") || url2_gal_list.substring(7,9).equals("lo")){
        logo_img_gal_list = "img/community_ai.png";
    }
    else{
        logo_img_gal_list = "img/community.png";
    }
    //System.out.println((logo_img_gal_list));
%>
<% 
   String boardslist=(String)request.getAttribute("boardslist");
   String tabmenulist=(String) request.getAttribute("tabmenulist");
   String num=(String) request.getAttribute("num");%>
<!DOCTYPE HTML>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="utf-8">
<title>갤러리:경기대학교 AI컴퓨터공학부</title>
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

.forBoard {
}
.boardtable > thead > tr > th, .boardtable > tbody > tr > td{
   text-overflow: ellipsis;
    overflow: hidden;
    white-space: nowrap;
      text-align: center;
      border-left : none;
      border-right : none;
}
.boardtable > thead > tr > th:nth-child(1), .boardtable > tbody > tr > td:nth-child(1) {
    min-width: 65px;
    max-width: 65px;
    width: 65px;
}
.boardtable > thead > tr > th:nth-child(2), .boardtable > tbody > tr > td:nth-child(2) {
    min-width: 400px;
    max-width: 400px;
    width: 400px;
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

.fixed-table-container{
	border : none;
}

.pagination-info{
display : none;
}
.pull-right-pagination{
width : 100%;
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
          <img src=<%=logo_img_gal_list%> />
          <div id="titlename"></div>
      </div>
      <div id="container">
         <div id="tab">
         <ul id="tab_2">
         </ul>
         </div>
         <div id="maincontent">
            <ul>
               <li>
                  <div id="articlename" class="contenttitle col-md-11"></div><button class="col-md-1 btn btn-default" onclick="viewingChange()">전환</button>
               </li>
            </ul>
            <div id="viewing1" style="text-align: center">
               <div id ="viewing1_images">
                  <div class="col-md-3 col-xs-3 col-sm-3 col-lg-3" id="view1_div1" style="padding : 0"></div>
                  <div class="col-md-3 col-xs-3 col-sm-3 col-lg-3" id="view1_div2" style="padding : 0"></div>
                  <div class="col-md-3 col-xs-3 col-sm-3 col-lg-3" id="view1_div3" style="padding : 0"></div>
                  <div class="col-md-3 col-xs-3 col-sm-3 col-lg-3" id="view1_div4" style="padding : 0"></div>
               </div>
            </div>
            <div id="viewing2" style="display:none;">
                <table class="boardtable" id="table"
                  data-toggle="table"
                  data-pagination="true"
                  data-search="true"
                  data-side-pagination="true"
                  data-page-list="[10]"
                 >
                  <thead>
                     <tr class="table-style">
                         <th data-field="board_id" data-sortable="true">번호</th>
                         <th data-field="title" data-sortable="true">제목</th>
                         <th data-field="student_id" data-sortable="true">글쓴이</th>
                         <th data-field="last_modified" data-sortable="true">작성일</th>
                         <th data-field="views" data-sortable="true">조회수</th>
                     </tr>
                  </thead>
               </table>
            </div>
            <hr style="border : 1px solid black">
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
   if(<%=type%>.board_level <= 7){
	   var write=$("#write_post");
	   write.append( '<a href="gallery_board_writer.do?num='+num+'" class="btn btn-default">글쓰기</a>');
   }
   var moremore = 1;
   var boards=<%=boardslist%>;
    
 
  function formatDate(date) {
       var d = new Date(date),
           month = '' + (d.getMonth() + 1),
           day = '' + d.getDate(),
           year = d.getFullYear();

       if (month.length < 2) month = '0' + month;
       if (day.length < 2) day = '0' + day;

       return [year, month, day].join('-');
   } 
  
   function firstImages(){
	  var sequence=0;
      for(var i = 0 ; i < moremore * 10 ; ++i ){
            if(i >= boards.length)
               break;
            var value = boards[i];
            var sequence = checkHeight();
            $('#view1_div'+sequence).append('<a href="gallery_board_reader.do?id='+value.id+'&num='+ num +'" id="aNumber' + i + '"></a>');
            var forTitle = '';
            if(value.comments_count == 0)
            	forTitle = value.title;
            else
            	forTitle = value.title + ' <span style="font-size : 11px">[' + value.comments_count + ']</span>';
            $('#aNumber'+ i).append('<div class="hoverImage" style = "padding : 10px"><div class="explain" id="explainNumber' + i + '" style="visibility : hidden; position:absolute; color : white; background-color : black"><div style="font-weight : 700; font-size : 12px">'+ forTitle +'</div></div><img id="imageNumber' + i + '" src="img/gallery/' + value.img + '" style="width : 100%;"></div>');
            var image = $('#imageNumber'+i);
            image.on('load', function(){
               var itsheight = $(this).height();
                 var itswidth = $(this).width();
                 var changePanel = $(this).parent().children('.explain');
                 changePanel.height(itsheight);
                 changePanel.width(itswidth);
            });      
            sequence = i;
      }
      $('#imageNumber'+sequence).on('load',function(){
          $('#viewing1_images').height( Math.max( $('#view1_div1').height(), $('#view1_div2').height(), $('#view1_div3').height(), $('#view1_div4').height()) );
      })
      $('#viewing1').append('<div id ="viewing1_more" style="background-color : #ECEFF1; height : 50px; margin-top : 30px; padding-top : 8px"><button class="btn btn-default" onclick="moreMore()"><img src="img/downArrow.png"></button></div>');
   }

   function doHover(){
         $('.hoverImage').hover(
         function(){ 
             jQuery(this).find('img').fadeTo(50,0.3);
             jQuery(this).find('.explain').css('visibility','visible');
             }, 
         function(){ 
                 jQuery(this).find('img').fadeTo(50,1);
            jQuery(this).find('.explain').css('visibility','hidden');
            });
      }
   
   
   function moreMore(){
	   var sequence = moremore*10;
      for(var i = moremore*10 ; i < (moremore+1) * 10 ; ++i){
         if(i >= boards.length){
            $('#viewing1_more').html('<div>더 이상 남아있지 않습니다</div>');
           break;
         }
         var value = boards[i];
         var sequence = checkHeight();
         $('#view1_div'+sequence).append('<a href="gallery_board_reader.do?id='+value.id+'&num='+ num +'" id="aNumber' + i + '"></a>');
         var forTitle = '';
         if(value.comments_count == 0)
         	forTitle = value.title;
         else
         	forTitle = value.title + ' <span style="font-size : 11px">[' + value.comments_count + ']</span>';
         $('#aNumber'+ i).append('<div class="hoverImage" style = "padding : 10px"><div class="explain" id="explainNumber' + i + '" style="visibility : hidden; position:absolute; color : white; background-color : black"><div style="font-weight : 700; font-size : 12px">'+ forTitle +'</div></div><img id="imageNumber' + i + '" src="img/gallery/' + value.img + '" style="width : 100%;"></div>');
         var image = $('#imageNumber'+i);
         image.on('load', function(){
            var itsheight = $(this).height();
              var itswidth = $(this).width();
              var changePanel = $(this).parent().children('.explain');
              changePanel.height(itsheight);
              changePanel.width(itswidth);
         });      
         sequence = i;
      }
      doHover();
      $('#imageNumber'+sequence).on('load',function(){
          $('#viewing1_images').height( Math.max( $('#view1_div1').height(), $('#view1_div2').height(), $('#view1_div3').height(), $('#view1_div4').height()) );
      });
      ++moremore;
   }
   
   function checkHeight(){
      var height1 = $('#view1_div1').height();
      var height2 = $('#view1_div2').height();
      var height3 = $('#view1_div3').height();
      var height4 = $('#view1_div4').height();
      var result = Math.min(height1, height2, height3, height4);
      switch(result){
         case height1:
            return 1;
         case height2:
            return 2;
         case height3:
            return 3;
         case height4: 
            return 4;
      }
   }
   
   function callSetupTableView(){
      $('#table').bootstrapTable('append',data());
      $('#table').bootstrapTable('refresh');
   }
   
   function data(){
      var rows = [];
      for(var i=0;i<boards.length;i++){
         var value=boards[i];
         var forTitle = '';
         if(value.comments_count == 0)
        	 forTitle = value.title;
         else
        	 forTitle = value.title + ' <span style="font-size : 11px">[' + value.comments_count + ']</span>';
         var date = new Date(value.last_modified);
         rows.push({
           board_id: value.id,
           title: '<a href="gallery_board_reader.do?id='+value.id+'&num='+ num +'">'+forTitle+'</a>',
                 student_id: value.writer_name,
                 last_modified: formatDate(date),
                  views: value.view
                      }
         );
      }
      return rows;
   }

     var list = $('#tab_2');
     var articlename=$('#articlename');
     var num=<%=num%>;
     var numo=num%10;//orderNum
     var numt=num/10;//tab_id
     
    var arr = <%=tabmenulist%>;
      for (var i = 0; i < arr.length; i++) {         
         var value = arr[i];
         if(value.show_in_menus)
         list.append(makeone(value));
         if(value.orderNum==numo)
         articlename.append(value.page_title);
      }
   function makeone(str) {
      var num=str.tab_id*10+str.orderNum;
      return '<li><span class="deco_dot">●</span><a href="'+str.path+'?num='+num+'">'
            + str.page_title + '</a></li>';
   }
   
   var pane = $('#title');
     var panel =$('#titlename');
   var headtitle = <%=headermenulist%>;
   for(var i = 0 ; i < headtitle.length ; ++i){
      if(headtitle[i].tab_id < numt && headtitle[i].tab_id > (numt-1))
         {
//         pane.prepend('<img src="'+headtitle[i].tab_img+'" alt="">');
         panel.append(headtitle[i].tab_title);
         break;
         }
   }
   function viewingChange(){
         $('#viewing1').toggle();
         $('#viewing2').toggle();
         }
   
  
   $(function(){
         firstImages();
         doHover();
         callSetupTableView();
     });   
   
   </script>
</body>
</html>