<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	StringBuffer url2_gal_reader = request.getRequestURL();
	String logo_img_gal_reader;

	//로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
	//ai이면 ai로고 cs이면 cs로고
	if(url2_gal_reader.substring(7,9).equals("ai") || url2_gal_reader.substring(7,9).equals("lo")){
		logo_img_gal_reader = "img/community_ai.png";
	}
	else{
		logo_img_gal_reader = "img/community.png";
	}
	//System.out.println((logo_img_gal_reader));
%>
<%
	String board = (String) request.getAttribute("boards");
	String boardLevel = (String)request.getAttribute("boardLevel");
	String tabmenulist=(String) request.getAttribute("tabmenulist");
	String id = (String)request.getAttribute("id");
	String images = (String)request.getAttribute("images");
	String num = (String)request.getAttribute("num");
	String nextlist=(String) request.getAttribute("nextlist");
%>
<%
	String headermenulist = (String) session.getAttribute("headermenulist");
	String menulist = (String) session.getAttribute("menulist");
	String user = (String) session.getAttribute("user");
	String type = (String) session.getAttribute("type");
%>
<%
	String pageMenuList = (String) request.getAttribute("pageMenuList");//좌측 소메뉴 리스트

	/**
	 * for page.jsp
	 * */
	String jsp = (String) request.getAttribute("jsp");
%>
<title>갤러리 : 경기대학교 AI컴퓨터공학부</title>
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
						<div class="col-md-3">
							<div id="postwriter">작성자 : </div>
						</div>
						<!--조회수, 기간 -->
						<div class="col-md-4"></div>
						<div class="col-md-5">
							<span id="postviews">조회수 : </span>
							<span id="postDate" style="margin-left : 20px; padding-left: 20px; border-left : 1px solid black">작성일 : </span>
						</div>
					</div>
					<div id="postimages">
						<!-- 이미지들 -->
					</div>
					<div id="postmain">
						<!-- 내용 (content) -->
					</div>
				</div>
				<div class="post_button" style="margin-top : 10px"><!--관리자라면 뭘 할 수 있는가-->
				</div>
				<div id="comment">
               		<div id="commenttitle"></div>
               		<div id="commentall"></div>
               		<div></div>
               		<div id="for_comment"></div>
            	</div>
				<div id="next_post" class="post_box">
            		<ul>
            			<li><div>다음글</div><div>|</div><div id="nextpost" class="one-line"></div>
            			<li><div>이전글</div><div>|</div><div id="previouspost" class="one-line"></div>
            		</ul>
            	</div>
			</div>
<script>
	var list = $('#tab_2');
	var articlename=$('#articlename');
	var arr = <%=tabmenulist%>
	for (var i = 0; i < arr.length; i++) {
		var value = arr[i];
		if(value.show_in_menus)
			list.append(makeone(value));
	}
	articlename.append('갤러리');
	var pane = $('#title');
	var panel =$('#titlename');
	var user = <%= user%>;
	var type = <%= type%>;
	var headtitle = <%=headermenulist%>;
//	pane.prepend('<img src="'+headtitle[6].tab_img+'" alt="">');
	panel.append(headtitle[6].tab_title);
	var buttonPanel = $('.post_button');
	
	if(user != null){
		if(type.for_header == '관리자' || <%=board%>.writer_id == user.id)
			buttonPanel.append('<div class="col-md-10"></div><button class="btn btn-default" onclick="goList()">목록</button><button class="btn btn-default" onclick="modifyBoard()">수정</button><button class="btn btn-default" onclick="deleteBoard()">삭제</button>');
		else
			buttonPanel.append('<div class="col-md-11"></div><button class="btn btn-default" onclick="goList()">목록</button>')
	}
	else
		buttonPanel.append('<div class="col-md-11"></div><button class="btn btn-default" onclick="goList()">목록</button>')
		
	function goList(){
		window.location.href = 'gallery_board_list.kgu?num=' +<%=num%>;
	}
	
	function modifyBoard(){
		window.location.href = 'gallery_board_modify.kgu?id=' + <%=id%> + '&num=' + <%=num%>;
	}
	
	function deleteBoard(){
		var check = confirm('정말로 삭제하시겠습니까?');
		if(!check) return;
		$.ajax({
	           url : 'gallery_board_delete.kgu',
	           type : 'post',
	           data : {
	           data:<%=id%>
	           },
	           success : function(data){
	          		if(data == 'success'){
	          			alert('삭제되었습니다.');
	          			window.location.href = 'gallery_board_list.kgu?num=' + <%=num%>;
	          			}
	          		else{
	          			alert('SERVER ERROR, Please try again later...');
	          			return;
	          		}
	          		}
	           });
	}
	
	
	function makeone(str) {
		var num=str.tab_id*10+str.orderNum;
		return '<li><span class="deco_dot">●</span><a href="'+str.path+'?num='+num+'">'
				+ str.page_title + '</a></li>';
	}
	
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
	
	var value = <%=board%>;
	$('#posttitle').append(value.title);
	$('#postviews').append(value.view);
	$('#postwriter').append(value.writer_name);
	$('#postmain').append(value.content);
	$('#postDate').append(formatDate(value.last_modified));
	var images = <%=images%>;
	for(var i = 0 ; i < images.length ; ++i){
		var value = images[i];
		if(value.text != '-')
			var a = '<div style="border-bottom : 1px dotted black; padding : 10px 0px"><img src="img/gallery/' + value.src + '" style="width : auto;"><div style="font-size : 14px"> ' + value.text + '</div></div>';
		else
			var a = '<div style="border-bottom : 1px dotted black; padding : 10px 0px"><img src="img/gallery/' + value.src + '" style="width : auto;"></div>';

		$('#postimages').append(a);
	}
	  var comment=$('#commentall');
	     var commenttitle=$('#commenttitle');
	  if(<%=boardLevel%>.write_comment_level >= <%=type%>.board_level){
		   $('#for_comment').append('<textarea style="resize:none" name="content" class="form-control" cols="100" rows="1" placeholder="댓글을 입력하세요." required></textarea><div class="post_button" id="post_submit_btn"><a id="post_submit"><button type="button" class="btn btn-default">쓰기</button></a></div>');
	   }
	
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
	       var data = insertData + '-/-/-' + <%=boardLevel%>.write_comment_level;
	       $.ajax({
	           url : 'ajax.do',
	           type : 'post',
	           typeData : "gson",
	           data : {
	              req:"galleryInsertComment",
	              data: data
	           },
	           success : function(data){
	        	   if(data == 'fail'){
	        		   alert('SERVER ERROR, Please try again later...');
	        		   return;
	        	   }
	              comment.empty();
	              commenttitle.empty();   
	              commentList(); //댓글 작성 후 댓글 목록 reload
	               $('[name=content]').val('');
	           }
	       });
	   });
	
	  function commentList(){
	       $.ajax({
	           url : 'ajax.do',
	           type : 'post',
	           data : {
	           req:"galleryGetComment",   
	           data:<%=id%>,
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
	              req:"galleryModifyComment",
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
	              req:"galleryDeleteComment",
	              data:id
	           },
	           success : function(data){
	               if(data == 1){
	                  commenttitle.empty();
	                  comment.empty();
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
	
	 var nlist = <%=nextlist%>;
     var next = $('#nextpost');
     var previous = $('#previouspost');
     if(nlist[0].title==undefined)
        next.append('다음글이 없습니다.');
     else
        next.append('<a href="article_reader.kgu?id='+nlist[0].id+'&num='+num+'">'+nlist[0].title+'</a>');
     if(nlist[1].title==undefined)
        previous.append('이전글이 없습니다.');
     else
        previous.append('<a href="article_reader.kgu?id='+nlist[1].id+'&num='+num+'">'+nlist[1].title+'</a>');
	
</script>