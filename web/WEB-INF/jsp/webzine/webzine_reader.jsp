<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
   StringBuffer url2_wz_reader = request.getRequestURL();
   String logo_img_wz_reader;

   //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
   //ai이면 ai로고 cs이면 cs로고
   if(url2_wz_reader.substring(7,9).equals("ai") || url2_wz_reader.substring(7,9).equals("lo")){
      logo_img_wz_reader = "img/webzine_ai.png";
   }
   else{
      logo_img_wz_reader = "img/webzine.png";
   }
   //System.out.println((logo_img_wz_reader));
%>
<%
   String boards = (String)request.getAttribute("boards");
	String boardLevel = (String)request.getAttribute("boardLevel");
   String num=(String)request.getAttribute("num");
   String id=(String)request.getAttribute("id");
   String tabmenulist=(String) request.getAttribute("tabmenulist");
   String file = (String) request.getAttribute("file");
   String nextlist=(String) request.getAttribute("nextlist");
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="utf-8">
<title>경기대학교 AI컴퓨터공학부</title>
<link href='css/bootstrap.css' rel='stylesheet' type='text/css'>
<link href='css/default.css' rel='stylesheet' type='text/css'>
<link href='css/content.css' rel='stylesheet' type='text/css'>
<link href='css/boardtable.css' rel='stylesheet' type='text/css'>
<link href='css/post.css' rel='stylesheet' type='text/css'>
<link href='css/information.css' rel='stylesheet' type='text/css'>
<link href='css/bootstrap-table.css' rel='stylesheet' type='text/css'>
<style>
#maincontent {
   padding: 0;
}

#maincontent>ul {
   padding: 10px;
}

#comment_edit {
   margin-top: 5px;
   padding: 5px;
   width: 720px;
   height: 50px;
   font-size: 13px;
   border-radius: 5px;
   border: 1px solid gainsboro;
}

.comment_edit_form {
   padding-right: 10px;
   display: none;
   width: 520px;
}
.one-line{
   text-overflow: ellipsis;
   overflow: hidden;
   white-space: nowrap;
}
</style>
</head>
<body>
   <script src="js/default.js"></script>
   <script src="js/jquery-3.2.1.min.js"></script>
   <script src="js/bootstrap-table.js"></script>
   <%@include file="../main/header.jsp"%>
   <main>
   <div id="content">
      <div id="title">
         <img src=<%=logo_img_wz_reader%> />
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
                   <div id="articlename" class="contenttitle"></div>
               </li>
            </ul>

            <div id="post">
               <div id="posttitle" style="overflow-wrap:break-word;">
                  <!-- 제목 -->

               </div>
               <div id="postinfo">
                  <!-- 작성자, 조회수, 작성일 -->
                  <div id="postname"></div>
                  <div>
                     <div id="postviews" style="border-right : 1px solid black; margin-right:10px; padding-right: 10px">조회수 : </div>
                     <div id="postlike" style="border-right : 1px solid black; margin-right : 10px; padding-right : 10px">추천수 : </div>
                     <div id="postlast">  작성일 : </div>
                  </div>
               </div>
               <div id="post_box" class="post_box">
               </div>
               <div>
                  <div id="postmain" style="border-bottom : 0">
                     <!-- 메인내용 (content) -->
                  </div>
                  <div id="forLikes" style="width : 100%; text-align: center; border-bottom : 1px solid #607D8B; padding-bottom : 10px;">
                  </div>
               </div>
               <div id="post_button" class="post_button">
            </div>
            </div>
            
            <!-- 댓글 -->
            <div id="comment">
               <div id="commenttitle"></div>
               <div id="commentall"></div>
               <div></div>
            </div>
            <div id="comment_edit_container">
               <form name="commentInsertForm">
                  <div class="input-group">
                  <input type="hidden" name="student_id" value="anomyous"><!-- 세션 -->
                  <div id="for_comment"></div>
                  </div>
               </form>
            </div>
            <div id="next_post" class="post_box">
            <ul>
            <li><div>다음글</div><div>|</div><div id="nextpost" class="one-line"></div>
            <li><div>이전글</div><div>|</div><div id="previouspost" class="one-line"></div>
            </ul>
            </div>
         </div>
      </div>
   </div>


   </main>
   <%@include file="../main/footer.jsp"%>
   <div id="shadow">
      <div id="blur"></div>
   </div>
   <script>//왼쪽
   
      var list = $('#tab_2');
      var articlename=$('#articlename');
      var arr = <%=tabmenulist%>
       var num=<%=num%>;
       numo=num%10;
         numt=num/10;
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
   if(<%=boardLevel%>.write_comment_level >= <%=type%>.board_level){
      $('#for_comment').append('<textarea style="resize:none" name="content" class="form-control" cols="100" rows="1" placeholder="댓글을 입력하세요." required></textarea><div class="post_button" id="post_submit_btn"><a id="post_submit" class="btn btn-default">쓰기</a></div>');
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
   
   
   
   if(type.board_level <= 7 ){
	   $('#forLikes').append('<button class="btn btn-default" style="width:auto; margin-top : 20px; padding: 3px 10px" onclick="likeIt()"><img src="img/likes.png" style="width : 35px;"></button>');
   }
   </script>
   <script>   //post            
                     var title=$('#posttitle');   
                   var postauthor=$('#postname');
                    var views=$('#postviews');
                    var likes = $('#postlike');
                    var lastmodified=$('#postlast');
                    var content=$('#postmain');   
                    var button=$('#post_button');
                    
                    var arr= <%=boards%>//관련된 모든 정보
                   var num= <%=num%>;
                    var value= arr;
                 
                    function formatDate(date) {
                        var d = new Date(date),
                            month = '' + (d.getMonth() + 1),
                            day = '' + d.getDate(),
                            year = d.getFullYear();
                        	hour = d.getHours();
                        	minute = d.getMinutes();

                        if (month.length < 2) month = '0' + month;
                        if (day.length < 2) day = '0' + day;

                        return [year, month, day].join('-') + ' ' + [hour, minute].join(':');
                    } 
                    
                    
                    content.append(makemain(value));
                   title.append(value.title);
                 postauthor.append('<strong>'+value.student_name+'</strong>');
                   views.append(value.views);
                   likes.append(value.likes)
                 lastmodified.append(formatDate(value.last_modified));

                    
                      button.append(makelistbutton(num));
                      if(<%=user%> != null)
                      	if(arr.student_id == <%=user%>.id || <%=user%>.type.includes('관리자')){
                    	  button.append(makemodifybutton(value,num));
                          button.append(makedeletebutton(value));
                      }
                      
                    function makemain(str){
                       return str.content;
                       }
                    function makelistbutton(num){
                       return '<div><a href="webzine_list.do?num=' + num + '" class="btn btn-default">목록</a></div>';
                       
                    }
                    function makemodifybutton(str,num){
                       return '<div><a href="webzine_modifier.do?num='+num+'&id='+str.id+'" id="modifier" class="btn btn-default">수정</a></div>';
                    }
                    function makedeletebutton(str){
                       return '<div><a onclick="boardDelete('+ <%=id%> +')" class="btn btn-default">삭제</a>'+'</div>';
                    }
                    
               
    </script>
   <script>//comment
   var id = <%=id%>; //게시글 번호
    var comment=$('#commentall');
     var commenttitle=$('#commenttitle');
   
     
     $('#post_submit').click(function(){ //댓글 등록 버튼 클릭시 
    	 var user = <%=user%>;
        var student_id = user.id;
        var student_name = user.name;
       var article_id = <%=id%>;
       var content = $('[name=content]').val();
       if(content==""){
          alert("댓글이 입력되지 않았습니다.");
          return;
       }
       if(content.length>=125){
           alert("댓글이 너무 깁니다!");
           return;
        }
       var insertData = student_id+"-/-/-"+student_name+"-/-/-"+article_id+"-/-/-"+content;
       commentInsert(insertData); //Insert 함수호출(아래)
   });
   
    
    
   //댓글 목록 
   function commentList(){
       $.ajax({
           url : 'ajax.do',
           type : 'post',
           data : {
           req:"webzinegetcomment",   
           data:id,
           },
           dataType:"json",
           success : function(data){
           var arr=data;
           commenttitle.append('Comment ('+arr.length+'개)');
           for(var a = 0 ; a < data.length ; a++){
               var value=arr[a];
               comment.append(commentlist(value)); 
           }
            
           function commentlist(value){
        	  if(<%=user%> != null){
        		  if(value.writer_id == <%=user%>.id || <%=type%>.type_name.includes("관리자"))
             	 	return '<div class="commentmain"><div><strong>' + value.writer_name + '</strong></div>'+
              	'<div id="comment_'+value.id+'_main" class="comment_main_content" style="max-width : 420px">' + value.content + '</div>'+
              	'<div>' + formatDate(value.last_modified) + '</div>' +
                 '<div id="commentmodify' + value.id + '">' + commentmodify(value) + '</div></div>';
              	else{ 
              		return '<div class="commentmain"><div><strong>' + value.writer_name + '</strong></div>' +
        		  '<div id="comment_' + value.id + '_main" class="comment_main_content">' + value.content + '</div>' +
        		  '<div>' + formatDate(value.last_modified) + '</div>'+
        		  '</div>';
              	}	
        	  }
        	  else{
        		  return '<div class="commentmain"><div><strong>' + value.writer_name + '</strong></div>' +
        		  '<div id="comment_' + value.id + '_main" class="comment_main_content">' + value.content + '</div>' +
        		  '<div>' + formatDate(value.last_modified) + '</div>'+
        		  '</div>';}
           }
           
           function commentmodify(value){
              return '<a onclick="commentUpdate('+value.id+',\''+value.content+'\')" class="btn btn-default">수정 </a>'+
                    '<a onclick="commentDelete('+value.id+')" class="btn btn-default">삭제</a>';
           }
           }
       });
   }
   //댓글 등록
   function commentInsert(insertData){
	   var data = insertData + '-/-/-' + <%=boardLevel%>.write_comment_level;
       $.ajax({
           url : 'ajax.do',
           type : 'post',
           typeData : "gson",
           data : {
              req:"webzinecommentInsert",
              data: data
           },
           success : function(data){
        	   if(data == 'fail'){
        		   alert('SERVER ERROR, Please try again later...');
        		   return;
        	   }
              var a='';
              comment.html(a);
              commenttitle.html(a);   
              commentList(); //댓글 작성 후 댓글 목록 reload
               $('[name=content]').val('');
           }
       });
   }
    
   //댓글 수정 - 댓글 내용 출력을 input 폼으로 변경 
   function commentUpdate(id,content){
      $('#commentmodify'+id).empty();
       var a ='';
         a +='<form name="commentupdate">';
       a += '<div class="input-group">';
         a += '<input type="hidden" name="comment_id" value='+id+'>';
       a += '<textarea style="resize:none" name="content2" class="form-control" cols="100" rows="1" placeholder="댓글을 입력하세요." required>'+content+'</textarea>';
       a += '</div></form>';
       $('#commentmodify'+id).append('<a href="javascript:commentUpdateProc()" id="update_submit1" class="btn btn-default" style="margin-left:30px;">완료</a>');
       $('#comment_'+id+'_main').html(a);
       
   }
     
   
   //댓글 수정
   function commentUpdateProc(){
      var id = $('[name=comment_id]').val();
        var content = $('[name=content2]').val();             
       var updateContent = id+"-/-/-"+content;
       if(updateContent.length>=125){
              alert("댓글이 너무 깁니다!");
              return;
           }
       if(updateContent.length == 0){
    	   alert('댓글을 입력해주세요!');
    	   return;
       }

       $.ajax({
           url : 'ajax.do',
           type : 'post',
           data : {
              req:"webzinemodifycomment",
              data:updateContent
           },
           success : function(data){
              comment.empty();
               commenttitle.empty();   
               commentList(); //댓글 작성 후 댓글 목록 reload
           }
       });
   }
    
   //댓글 삭제 
   function commentDelete(id){
	   var check = confirm("정말 삭제하시겠습니까?");
	   if(!check)
		   return;
       $.ajax({
           url : 'ajax.do',
           type : 'post',
           data :{
              req:"webzinedeletecomment",
              data:id
           },
           success : function(data){
               if(data == 1){
                  var a='';
                  commenttitle.html(a);
                  comment.html(a);
                  commentList(); //댓글 삭제후 목록 출력 
               }
               else{
            	   alert('SERVER ERROR, Please try again later...');
               }
           }
       });
   }

    
   $(document).ready(function(){
	   if(<%=boardLevel%>.read_comment_level >= <%=type%>.board_level)
       		commentList(); //페이지 로딩시 댓글 목록 출력 
   });

   function boardDelete(id){//board 삭제
	   var check = confirm('정말 삭제하시겠습니까?');
   if(!check)
	   return;
      $.ajax({
         url:'webzine_boarddelete.do',
         type:'post',
         data:{data : id},
         success :function(data){
            alert("삭제가 완료 되었습니다.");
            window.location.href = 'webzine_list.do?num='+<%=num%>; 
         }
      });
   }   

   //글에 저장된 파일
   var postbox = $('#post_box');
   var file = <%=file%>;
   var a = '';
   if(file.length > 0)
      a += '첨부파일: ';
   if(file.length == 0)
	   $('#post_box').remove();
   var isAvailable = 0;
  
   for(var i = 0 ; i < file.length ; i++){
      var it = file[i];
      if(<%=type%>.board_level <= <%=boardLevel%>.file_download_level)
      	a += '<a href="webzine_download.do?id=' + it.id + '">' + it.filename + '</a>&nbsp&nbsp';
      else
    	  a  += it.filename + '<span>&nbsp&nbsp</span>';
   }
   postbox.append(a);
   
   function likeIt(){
	   var data = <%=boards%>.id;
	   $.ajax({
		   url : 'ajax.do',
		   type : 'post',
		   data : {
			   req : 'likeBoard',
			   data : data
		   },
		   success : function(data){
						if(data == 'success'){
							alert('추천 성공');
							window.location.href = 'webzine_reader.do?id=' + <%=id%> + '&num=' + <%=num%>;
						}else if(data == 'already'){
							alert('이미 추천한 글입니다');
						}else{
							alert('SERVER ERROR, Please try again later...');
						}
		   }
	   });
   }
   
   
      var nlist = <%=nextlist%>;
      var next = $('#nextpost');
      var previous = $('#previouspost');
      if(nlist[0].title==undefined)
         next.append('다음글이 없습니다.');
      else
         next.append('<a href="webzine_reader.do?id='+nlist[0].id+'&num='+num+'">'+nlist[0].title+'</a>');
      if(nlist[1].title==undefined)
         previous.append('이전글이 없습니다.');
      else
         previous.append('<a href="webzine_reader.do?id='+nlist[1].id+'&num='+num+'">'+nlist[1].title+'</a>');
   </script>
</body>
</html>