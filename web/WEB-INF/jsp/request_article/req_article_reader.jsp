<%@ page language="java" contentType="text/html;charset=UTF-8"
   pageEncoding="UTF-8"%>
<%
   StringBuffer url2_ra_reader = request.getRequestURL();
   String logo_img_ra_reader;

   //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
   //ai이면 ai로고 cs이면 cs로고
   if(url2_ra_reader.substring(7,9).equals("ai") || url2_ra_reader.substring(7,9).equals("lo")){
      logo_img_ra_reader = "img/apply_ai.png";
   }
   else{
      logo_img_ra_reader = "img/apply.png";
   }
   //System.out.println((logo_img_ra_reader));
%>
<%
   String board = (String) request.getAttribute("board");
   String tabmenulist=(String) request.getAttribute("tabmenulist");
   String AnswerWhoDone = (String) request.getAttribute("AnswerWhoDone");
   String file = (String) request.getAttribute("file");
   String num = (String) request.getAttribute("num");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<meta charset="utf-8">
<title>신청 및 접수 : 경기대학교 AI컴퓨터공학부</title>
<link href='css/bootstrap.css' rel='stylesheet' type='text/css'>
<link href='css/default.css' rel='stylesheet' type='text/css'>
<link href='css/content.css' rel='stylesheet' type='text/css'>
<link href='css/boardtable.css' rel='stylesheet' type='text/css'>
<link href='css/post.css' rel='stylesheet' type='text/css'>
<link href='css/information.css' rel='stylesheet' type='text/css'>
<link href='css/bootstrap-table.css' rel='stylesheet' type='text/css'>
<link href='css/bootstrap-slider.css' rel='stylesheet' type='text/css'>
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
.table-bordered > thead > tr > th, .table-bordered > tbody > tr > th, .table-bordered > tfoot > tr > th, .table-bordered > thead > tr > td, .table-bordered > tbody > tr > td, .table-bordered > tfoot > tr > td{
	min-width : 100px;
}

#moreViewAll{
	overflow : auto;
}
.anotherDone {
	text-align : center;
	height : 30px;
	background-color : #ECEFF1;
	border : 1px solid #607D8B;
	margin-top : 5px;
	font-family : NanumSquare;
}

.moreView {
	height : 10px;
	background-color : #455A64;
}

.explain {
	font-family : NanumSquare;
	font-size : 12px;
}

.for4 {
	margin-left : 10px;
	font-size : 15px;
	font-weight : 600;
}

.for_slider{
	margin-top : 5px;
	text-align : center;
	width : 100%;
}

.radio, .checkbox {
	margin-top : 5px;
	margin-bottom : 5px;
	}
	
</style>
</head>
<body>
   <script src="js/default.js"></script>
   <script src="js/jquery-3.2.1.min.js"></script>
   <script src="js/bootstrap.min.js"></script>
   <script src="js/bootstrap-table.js"></script>
   <script src="js/bootstrap-table-cookie.js"></script>
   <script src="js/bootstrap-slider.js"></script>
   <%@include file="../main/header.jsp"%>
   <main>
   <div id="content">
      <div id="title">
         <img src=<%=logo_img_ra_reader%> />
         <div id="titlename">
         </div>
      </div>
      <div id="container">
         <div id="tab">
            <ul id="tab_2">
               <!-- 탭메뉴설정 -->
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
                  <!--참여자 수, 기간 -->
                  <div>
                     <div id="postname"></div>
                  </div>
                  <div>
                     <div id="postviews" style="padding-right : 10px;">참여자 수 : </div>
                     <div id="postlast" style="border-left : 1px solid black; padding-left : 10px;"> 참여기간 : </div>
                  </div>
               </div>
               <div id="post_box" class="post_box">
               </div>
               <div id="postmain">
                  <!-- 내용 (content) -->
               </div>
               <div id="questions">
               </div>
               <div id="anotherDone">
               </div>
            </div>
               <div class="post_button" style="margin-top : 10px"><!--관리자라면 받을 수 있다-->
               </div>
            </div>

         </div>
      </div>
   </main>
   <%@include file="../main/footer.jsp"%>

<script>
   var list = $('#tab_2');
   var articlename=$('#articlename');
   var arr = <%=tabmenulist%>
   var type = <%=type%>;
   for (var i = 0; i < arr.length; i++) {
      var value = arr[i];
      if(value.show_in_menus)
         list.append(makeone(value));
   }
   articlename.append('신청접수하기');
   var pane = $('#title');
   var panel =$('#titlename');
   var user = <%= user%>;
   var headtitle = <%=headermenulist%>;
//   pane.prepend('<img src="'+headtitle[4].tab_img+'" alt="">');
   panel.append(headtitle[4].tab_title);

   function makeone(str) {   //탭메뉴만들기
	      var num=str.tab_id*10+str.orderNum;
	   		if(str.page_title == '졸업논문'){
	   			if(<%=type%>.type_name == '졸업논문관리자' || <%=type%>.type_name == '교수1' || <%=type%>.type_name == '학부생' || <%=type%>.type_name == '복수전공생' || <%=type%>.type_name == '교수2')
	   				return '<li><span class="deco_dot">●</span><a href="'+str.path+'">'
	   	            + str.page_title + '</a></li>';
	   	            else
	   	            	return '<li><span class="deco_dot">●</span>'
	   	             + str.page_title + '</li>';
	   		}
            else if(str.page_title == '나의 이수 현황'){
               return '<li><span class="deco_dot">●</span><a href="'+str.path+'">' + str.page_title + '</a></li>';
            }
	            else	
	      return '<li><span class="deco_dot">●</span><a href="'+str.path+'?num='+num+'">'
	            + str.page_title + '</a></li>';
	   }
   
   var value = <%=board%>;
   $('#postname').append(value.student_name);
   $('#posttitle').append(value.title);
   $('#postviews').append(value.views);
   var start = new Date(value.starting_date);
   var min = start.getTime();
   var close = new Date(value.closing_date);
   var max = close.getTime() + 1000*60*60*24;
   var today = new Date();
   var current = today.getTime();
   var isAvailable = 0; // 신청이 가능한지 검사하는 변수
   var wasDone = 0; //예전에 제출한 것이 있는지 검사하는 변수
   $('#postlast').append(formatDate(start) +' ~ '+ formatDate(close));
   if(min <= current && current <= max){
      isAvailable = 1;
   }
   
   var doneQuestion = null;
   
   function check(){
      var sending = value.id;
      $.ajax({
            url : 'ajax.do',
          type : 'post',
         async :false,
        data : {
          req: 'whoAnswerIt',
           data: sending
      },
      dataType : 'json',
      success : function(data){
               if(data == 'fail')
                  alert('SERVER ERROR, Please try again later.');
               if(data == 'empty'){
                  return;
               }
               else{
                  wasDone = 1;
                  doneQuestion = data;
               }
              }
      });
   }
   
   $('#postmain').append(value.content);
   
   function makeButtons(){
	   var isFiles = 0;
	   for(var i = 0 ; i < questions.length ; ++i){
		   var value = questions[i];
		   if(value.question_type == '5')
			   isFiles = 1;
	   }
	   if(type.board_level == 0 || <%=board%>.student_id == user.id){
		   if(<%=board%>.views == 0)
			   $('.post_button').append('<div class="col-md-6"></div><div class="col-md-6"><button class="btn btn-default col-md-4" onclick="removeQuestion()">삭제하기</button><a class="col-md-4 btn btn-default" href="req_article_modifier.do?id=' + <%=board%>.id + '&num=' + <%=num%> + '" style="margin : 0">수정하기</a><a class="btn btn-default col-md-4" style="margin : 0" href="req_article_list.do?num=51">목록으로</a></div>');
		   else {
			   if(isFiles == 1)
				   $('.post_button').append('<div class="col-md-4"></div><div class="col-md-8"><button class="btn btn-default col-md-2" onclick="removeQuestion()">삭제</button><a class="col-md-2 btn btn-default" style="margin : 0" href="req_board_excel.do?id=' + <%=board%>.id + '">엑셀</a><a class="col-md-4 btn btn-default" style="margin : 0" href="req_board_all_download.do?id=' + <%=board%>.id + '">파일다운</a><a class="col-md-2 btn btn-default" href="req_article_modifier.do?id=' + <%=board%>.id + '&num=' + <%=num%> + '" style="margin : 0">수정하기</a><a class="col-md-2 btn btn-default" style="margin : 0" href="req_article_list.do?num=51">목록으로</a></div>');
			   else
				   $('.post_button').append('<div class="col-md-6"></div><div class="col-md-6"><button class="btn btn-default col-md-3" onclick="removeQuestion()">삭제</button><a class="col-md-3 btn btn-default" style="margin : 0" href="req_board_excel.do?id=' + <%=board%>.id + '">엑셀</a><a class="col-md-3 btn btn-default" href="req_article_modifier.do?id=' + <%=board%>.id + '&num=' + <%=num%> + '" style="margin : 0">수정</a><a class="col-md-3 btn btn-default" style="margin : 0" href="req_article_list.do?num=51">목록</a></div>');
		   }
	   }
	   else
		   $('.post_button').append('<div class="col-md-10"></div><div class="col-md-2"><a class="col-md-10 btn btn-default" style="margin : 0" href="req_article_list.do?num=51">목록으로</a></div>')
   }
   
     function removeQuestion(){
      var check = confirm("정말 삭제하시겠습니까?");
      if(!check) return;
      var board = <%=board%>;
      var data = board.id;
      $.ajax({
          url : 'ajax.do',
          type : 'post',
          async :false,
           data : {
          req: 'removeQuestion',
            data: data
         }, 
         success : function(data){
                     if(data == 'success'){
                        alert('삭제되었습니다.');
                        window.location.href = 'req_article_list.do?num=51';
                        }
                     else
                        alert('SERVER ERROR, Please try again later.');
               }
         })
   }
   
   var questions = null;

   function getQuestion(){
      $.ajax({
          url : 'ajax.do',
          type : 'post',
          async :false,
           data : {
          req: 'getQuestions',
            data: value.id
         }, 
         dataType : "json",
         success : function(data){
            questions = data;
            }
      })
   }
   
   function settingQuestion(){
      if(isAvailable == 1 && value.level.indexOf(type.for_header) >= 0){
            var panel = $('#questions');
            for(var i = 0 ; i < questions.length ; ++i ){
               var it = questions[i];//타입 1 = 주관식 2 = 단일객관식 3 = 다중객관식  4 = 척도형  5 = 파일업로드형
               if(it.question_type == '1'){
                  var text = '';
                  text += '<div class="form-group" id="question' + i + '"><label>'+ (i+1) + '.' + it.question_content + '</label><input type="text" class="form-control" name="answer' + i + '" placeholder="답변을 해주세요"></div>';
                  panel.append(text);      
               }
               if(it.question_type == '2'){
                  var text = '';
                  var answers = it.question_content.split('-/@/-');
                  text += '<div class="form-group" id="question' + i + '"><label>'+ (i+1) + '.' + answers[0] + '</label><div id="allAnswers' + i + '"></div>'; 
                  panel.append(text);
                  var answerPanel = $('#allAnswers'+i);
                  for(var j = 1 ; j < answers.length ; ++j){
                     var input = '<div class="radio"><label><input type="radio" name="answer' + i + '" value="' + answers[j] + '">' + answers[j] + '</label></div>';
                     answerPanel.append(input);
                  }
               }
               if(it.question_type == '3'){
                  var text = '';
                  var answers = it.question_content.split('-/@/-');
                  text += '<div class="form-group" id="question' + i + '"><label>'+ (i+1) + '.' + answers[0] + '<span style="color : gray; font-size : 12px">(다중 선택 가능 문항입니다)</span></label><div id="allAnswers' + i + '"></div>'; 
                  panel.append(text);
                  var answerPanel = $('#allAnswers'+i);
                  for(var j = 1 ; j < answers.length ; ++j){
                     var input = '<div class="checkbox"><label><input type="checkbox" id="answer' + i + 'S' + j + '" value="' + answers[j] + '">' + answers[j] + '</label></div>';
                     answerPanel.append(input);
                  }
               }
               
               if(it.question_type == '4'){
            	   var text = '';
            	   var answers = it.question_content.split('-/@/-');
            	   text += '<div class="form-group" id="question' + i + '"><label>'+ (i+1) + '.' + answers[0] + '</label><div class="for_slider" id="sliderPanel' + i + '"></div>';
            	   panel.append(text);
            	   var sliderPanel = $('#sliderPanel'+i);
            	   var text = answers[1] + ' <input type="range" id="range' + i + '"> ' + answers[2];
            	   sliderPanel.append(text);
				   $('#range'+i).slider({
					   id : 'getRange'+i,
					   min : Number(answers[1]),
					   max : Number(answers[2]),
					   value : Math.floor((Number(answers[1]) + Number(answers[2]))/2),
					   step : 1,
					   enabled : true
				   });
               }
               if(it.question_type == '5'){
            	   var text = '';
            	   text += '<div id="question' + i + '"><label>'+ (i+1) + '.' + it.question_content + '</label><input type="file" name="answer' + i + '"></div>';
                   panel.append(text);     
               }
            }
            $('#questions').append('<div class="col-md-4"></div><button class="btn btn-default col-md-4" onclick="submitNewAnswer()">제출할래요</button>');
            }   
      else{
         var panel = $('#questions');
      }
   }
   
   
   function submitNewAnswer(){
      // 다중객관식의 경우 답안 구분자 -/@/- Answer 구분자 -/#/-
      var rightNow = new Date().getTime();
      if(min > current || current > max){
    	  alert('현재 참여하실 수 없습니다.');
    	  return;
      }
      var Answer = '';
      var board_number = <%=board%>.id;
      var fileSequence = 1;
      for(var i = 0 ; i < questions.length ; i ++){
         var it = questions[i];
         if($('input:text[name=answer'+i+']').val() != null)
        	 if($('input:text[name=answer'+i+']').val().length >= 150){
    		 	alert((i+1) + '번 문항의 답변이 너무 깁니다.');
    		 	return;
    		 }
         if(it.question_type == '1'){
            Answer += $('input:text[name=answer'+i+']').val();
         }
         if(it.question_type == '2'){
        	if($('input:radio[name=answer'+i+']:checked').val() != undefined)
            	Answer += $('input:radio[name=answer'+i+']:checked').val();
        	else
        		Answer += '';
         }
         if(it.question_type == '3'){
            var length = it.question_content.split('-/@/-').length;
            for(var j = 1 ; j < length ; j ++){
               if($('input:checkbox[id="answer' + i + 'S' + j + '"]').is(":checked") ==  true)
                  {
                  Answer += $('#answer'+i+'S'+j).val();
                  Answer +='-/@/-' //무조건 하나 더생기므로 나중에 액션에서 다오에서 고려
                  }
            }
         }
         if(it.question_type == '4'){
        	 Answer += $('#range'+i).slider('getValue');
         }
         if(it.question_type == '5'){
        	 var formData = new FormData();
        	 formData.append('uploadFile', $('input[name=answer' + i + ']')[0].files[0]);
        	 formData.append('fileSequence',fileSequence);
        	 formData.append('userName',<%=user%>.name);
        	 formData.append('boardID',board_number);
        	 $.ajax({
                 url : 'req_board_answer_upload.do',
                 type : 'post',
                 data : formData,
                 processData : false,
                 contentType : false,
                 async : false,
                 success : function(data) {
                	if(data == 'not good file'){
                		alert('파일 중 올릴 수 없는 확장자가 포함되어 있습니다.');
                		return;
                	}
                    if(data != 'fail'){
                        Answer += data;
                        ++fileSequence;
                    }
                    else{
                        alert('SERVER ERROR, Please try again later...');
                        return;
                    }
                 }
            })
         }
         if(i != questions.length)
            Answer += '-/#/-';
      }
      
      var data = board_number + "-/-/-" + Answer + "-/-/-" + questions.length;
      $.ajax({
          url : 'ajax.do',
          type : 'post',
           data : {
          req: 'insertAnswer',
            data: data
      },
      success : function(data){
         if(data == 'success'){
            alert('신청이 성공하였습니다');
            if(<%=board%>.for_who == 1)
            	window.location.href= 'req_article_reader.do?id=' + <%=board%>.id;
            wasDone = 1;
            check();
            whatIDone();
            }
         else if(data == 'fail'){
            alert('SERVER ERROR, Please try again later.');
         } else if(data == 'timeout'){
     		alert('해당되는 시간이 아닙니다.');
    		return;
    	}
         else {
        	 alert('이미 신청한 글입니다.');
         }
            }
      });
            
   }
   
   function whatIDone() {//doneQuestion 이용
      var panel = $('#questions');
      panel.css('border','1px black dotted');
      panel.empty();
      panel.append('<div id="myPanel" style="text-align : center ; font-size : 20px; margin-bottom:10px;">나의 신청 현황</div>');
      for(var i = 0 ; i < doneQuestion.length ; ++i){
         var it = questions[i];//타입 1 = 주관식 2 = 단일객관식 3 = 다중객관식
         var done = doneQuestion[i];
         if(it.question_type == '1'){
            var text = '';
            if(done.answer != '')
            	text += '<div class="form-group" id="question' + i + '"><label>'+ (i+1) + '.' + it.question_content + '</label><input type="text" class="form-control" name="answer' + i + '" value="' + done.answer + '" readonly></div>';
            else
            	text += '<div class="form-group" id="question' + i + '"><label>'+ (i+1) + '.' + it.question_content + '</label><input type="text" class="form-control" name="answer' + i + '" value="답변을 하지 않았습니다." readonly></div>';
            panel.append(text);      
         }
         if(it.question_type == '2'){
            var text = '';
            var allAnswer = it.question_content;
            var answers = allAnswer.split('-/@/-');
            text += '<div class="form-group" id="question' + i + '"><label>'+ (i+1) + '.' + answers[0] + '</label><div id="allAnswers' + i + '"></div>'; 
            panel.append(text);
            var answerPanel = $('#allAnswers'+i);
            for(var j = 1 ; j < answers.length ; ++j){
               if(answers[j] == done.answer)
                  var input = '<div class="radio disabled"><label><input type="radio" disabled checked="true" name="answer' + i + '" id="answer' + i + 'S' + j + '" value="' + answers[j] + '">' + answers[j] + '</label></div>';
                  else
                  var input = '<div class="radio disabled"><label><input type="radio" disabled name="answer' + i + '" id="answer' + i + 'S' + j + '" value="' + answers[j] + '">' + answers[j] + '</label></div>';
               answerPanel.append(input);
            }
           if(done.answer == '')
        	   answerPanel.append('<span style="font-size : 14px; color : red">답변을 하지 않았습니다.</span>');
         }
         if(it.question_type == '3'){
            var text = '';
            var allAnswer = it.question_content;
            var answers = allAnswer.split('-/@/-');
            var myAnswer = done.answer.split('-/@/-');
            text += '<div class="form-group" id="question' + i + '"><label>'+ (i+1) + '.' + answers[0] + '<span style="color : gray; font-size : 12px">(다중 선택 가능 문항입니다)</span></label><div id="allAnswers' + i + '"></div>'; 
            panel.append(text);
            var answerPanel = $('#allAnswers'+i);
            for(var j = 1 ; j < answers.length ; ++j){
               if(myAnswer.includes(answers[j]))
                  var input = '<div class="checkbox disabled"><label><input type="checkbox" disabled checked="true" id="answer' + i + 'S' + j + '" value="' + answers[j] + '">' + answers[j] + '</label></div>';
               else
                  var input = '<div class="checkbox disabled"><label><input type="checkbox" disabled id="answer' + i + 'S' + j + '" value="' + answers[j] + '">' + answers[j] + '</label></div>';
               answerPanel.append(input);
            }
            if(done.answer == '')
         	   answerPanel.append('<span style="font-size : 14px; color : red">답변을 하지 않았습니다.</span>');
         }
        if(it.question_type == '4'){
        	var text = '';
        	var allAnswer = it.question_content;
        	var answers = allAnswer.split('-/@/-');
        	text += '<div class="form-group" id="question' + i + '"><label>'+ (i+1) + '.' + answers[0] + '</label><div class="for_slider" id="sliderPanel' + i + '"></div>';
      	   panel.append(text);
      	   var sliderPanel = $('#sliderPanel'+i);
      	   var text = answers[1] + ' <input type="range" id="range' + i + '"> ' + answers[2] + '<span class="for4"> 선택값 : ' + done.answer + '</span>';
      	   sliderPanel.append(text);
			   $('#range'+i).slider({
				   id : 'getRange' + i,
				   min : Number(answers[1]),
				   max : Number(answers[2]),
				   value : Number(done.answer),
				   step : 1,
				   enabled : false
			   });
        }
        if(it.question_type == '5'){
        	 var text = '';
        	 if(done.answer != 'null')
             	text += '<div class="form-group" id="question' + i + '"><label>'+ (i+1) + '.' + it.question_content + '</label><br><a href="req_board_download.do?id=' + done.answer + '"><img src="img/file_ico.png"></a></div>';
             else
             	text += '<div class="form-group" id="question' + i + '"><label>'+ (i+1) + '.' + it.question_content + '</label><br><span style="font-size : 14px; color : red">파일을 올리지 않았습니다.</span></div>';
             panel.append(text);
        }
      }   
      var rightNow = new Date().getTime();
      if(min <= current && current <= max)
      	panel.append('<div class="col-md-4"></div><button class="btn btn-default col-md-2" onclick="modifyMyAnswer()">수정</button><button class="btn btn-default col-md-2" onclick="deleteMyAnswer()">삭제</button>');
   }
   
   function whatAnotherDone(index, doneQuestions){
	   var panel = $('#moreViewAnother'+index);
	   var doneQuestion = doneQuestions;
	      panel.css('border','1px black solid');
	      panel.css('padding-bottom','10px');
	      panel.empty();
	      panel.append('<div id="AnotherPanel' + index + '" style="text-align : center ; font-size : 20px; margin-bottom:10px;">' + doneQuestion[0].user_name + '(' + doneQuestion[0].user_per_id + ')의 신청 현황</div>');
	      for(var i = 0 ; i < doneQuestion.length ; ++i){
	         var it = questions[i];//타입 1 = 주관식 2 = 단일객관식 3 = 다중객관식
	         var done = doneQuestion[i];
	         if(it.question_type == '1'){
	            var text = '';
	            if(done.answer != '')
	            	text += '<div class="form-group" id="question' + i + 'Another' + index + '"><label>'+ (i+1) + '.' + it.question_content + '</label><input type="text" class="form-control" name="answer' + i + '" value="' + done.answer + '" readonly></div>';
	            else
	            	text += '<div class="form-group" id="question' + i + 'Another' + index + '"><label>'+ (i+1) + '.' + it.question_content + '</label><input type="text" class="form-control" name="answer' + i + '" value="답변을 하지 않았습니다." readonly></div>';
	            panel.append(text);      
	         }
	         if(it.question_type == '2'){
	            var text = '';
	            var allAnswer = it.question_content;
	            var answers = allAnswer.split('-/@/-');
	            text += '<div class="form-group" id="question' + i + '"><label>'+ (i+1) + '.' + answers[0] + '</label><div id="allAnswers' + i + 'Another' + index + '"></div>'; 
	            panel.append(text);
	            var answerPanel = $('#allAnswers'+ i + 'Another' + index);
	            for(var j = 1 ; j < answers.length ; ++j){
	               if(answers[j] == done.answer)
	            	   var input = '<div class="radio disabled"><label><input type="radio" disabled checked="true" name="answer' + i + 'Another' + index + '" id="answer' + i + 'S' + j + '" value="' + answers[j] + '">' + answers[j] + '</label></div>';
	               else
	                  var input = '<div class="radio disabled"><label><input type="radio" disabled name="answer' + i + 'Another' + index + '" id="answer' + i + 'S' + j + '" value="' + answers[j] + '">' + answers[j] + '</label></div>';
	               answerPanel.append(input);
	            }
	            if(done.answer == '')
	         	   answerPanel.append('<span style="font-size : 14px; color : red">답변을 하지 않았습니다.</span>');
	         }
	         if(it.question_type == '3'){
	            var text = '';
	            var allAnswer = it.question_content;
	            var answers = allAnswer.split('-/@/-');
	            var myAnswer = done.answer.split('-/@/-');
	            text += '<div class="form-group" id="question' + i + '"><label>'+ (i+1) + '.' + answers[0] + '<span style="color : gray; font-size : 12px">(다중 선택 가능 문항입니다)</span></label><div id="allAnswers' + i + 'Another' + index + '"></div>'; 
	            panel.append(text);
	            var answerPanel = $('#allAnswers'+ i + 'Another' + index);
	            for(var j = 1 ; j < answers.length ; ++j){
	               if(myAnswer.includes(answers[j]))
	                  var input = '<div class="checkbox disabled"><label><input type="checkbox" disabled checked="true" id="answer' + i + 'S' + j + '" value="' + answers[j] + '">' + answers[j] + '</label></div>';
	               else
	                  var input = '<div class="checkbox disabled"><label><input type="checkbox" disabled id="answer' + i + 'S' + j + '" value="' + answers[j] + '">' + answers[j] + '</label></div>';
	               answerPanel.append(input);
	            }
	            if(done.answer == '')
	         	   answerPanel.append('<span style="font-size : 14px; color : red">답변을 하지 않았습니다.</span>');
	         }
	        if(it.question_type == '4'){
	        	var text = '';
	        	var allAnswer = it.question_content;
	        	var answers = allAnswer.split('-/@/-');
	        	text += '<div class="form-group" id="question' + i + '"><label>'+ (i+1) + '.' + answers[0] + '</label><div  class="for_slider" id="sliderPanel' + i + 'Another' + index + '"></div>';
	      	   panel.append(text);
	      	   var sliderPanel = $('#sliderPanel' + i + 'Another' + index);
	      	   var text = answers[1] + ' <input type="range" id="range' + i + 'Another' + index + '"> ' + answers[2] + '<span class="for4"> 선택값 : ' + done.answer + '</span>';
	      	   sliderPanel.append(text);
				   $('#range' + i + 'Another' + index).slider({
					   min : Number(answers[1]),
					   max : Number(answers[2]),
					   value : Number(done.answer),
					   step : 1,
					   enabled : false
				   });
	        }
	        if(it.question_type == '5'){
	        	 var text = '';
	        	 if(done.answer != 'null')
	             	text += '<div class="form-group" id="question' + i + 'Another' + index + '"><label>'+ (i+1) + '.' + it.question_content + '</label><br><a href="req_board_download.do?id=' + done.answer + '"><img src="img/file_ico.png"></a></div>';
	             else
		             text += '<div class="form-group" id="question' + i + 'Another' + index + '"><label>'+ (i+1) + '.' + it.question_content + '</label><br><span style="font-size : 14px; color : red">파일을 올리지 않았습니다.</span></div>';
	             panel.append(text);
	        }
	      }   
   }
   
   function modifyMyAnswer(){
	  var rightNow = new Date().getTime();
	  if(min > current || current > max){
		  alert('현재 수정하실 수 없습니다.');
		  return;
	  }
      var panel = $('#questions');
      panel.css('border','1px black dotted');
      panel.empty();
      panel.append('<div id="myPanel" style="text-align : center ; font-size : 20px; margin-bottom:10px;">나의 신청 현황</div>');
      for(var i = 0 ; i < doneQuestion.length ; ++i){
         var it = questions[i];//타입 1 = 주관식 2 = 단일객관식 3 = 다중객관식 4 = 척도형
         var done = doneQuestion[i];
         if(it.question_type == '1'){
            var text = '';
            text += '<div class="form-group" id="question' + i + '"><label>'+ (i+1) + '.' + it.question_content + '</label><input type="text" class="form-control" name="answer' + i + '" value="' + done.answer + '"></div>';
            panel.append(text);      
         }
         if(it.question_type == '2'){
            var text = '';
            var allAnswer = it.question_content;
            var answers = allAnswer.split('-/@/-');
            text += '<div class="form-group" id="question' + i + '"><label>'+ (i+1) + '.' + answers[0] + '</label><div id="allAnswers' + i + '"></div>'; 
            panel.append(text);
            var answerPanel = $('#allAnswers'+i);
            for(var j = 1 ; j < answers.length ; ++j){
               if(answers[j] == done.answer)
                  var input = '<div class="radio"><label><input type="radio" checked="true" name="answer' + i + '" id="answer' + i + 'S' + j + '" value="' + answers[j] + '">' + answers[j] + '</label></div>';
               else
                  var input = '<div class="radio"><label><input type="radio" name="answer' + i + '" id="answer' + i + 'S' + j + '" value="' + answers[j] + '">' + answers[j] + '</label></div>';
               answerPanel.append(input);
            }
         }
         if(it.question_type == '3'){
            var text = '';
            var allAnswer = it.question_content;
            var answers = allAnswer.split('-/@/-');
            var myAnswer = done.answer.split('-/@/-');
            text += '<div class="form-group" id="question' + i + '"><label>'+ (i+1) + '.' + answers[0] + '<span style="color : gray; font-size : 12px">(다중 선택 가능 문항입니다)</span></label><div id="allAnswers' + i + '"></div>'; 
            panel.append(text);
            var answerPanel = $('#allAnswers'+i);
            for(var j = 1 ; j < answers.length ; ++j){
               if(myAnswer.includes(answers[j]))
                  var input = '<div class="checkbox"><label><input type="checkbox" checked="true" id="answer' + i + 'S' + j + '" value="' + answers[j] + '">' + answers[j] + '</label></div>';
               else
                  var input =  '<div class="checkbox"><label><input type="checkbox" id="answer' + i + 'S' + j + '" value="' + answers[j] + '">' + answers[j] + '</label></div>';
               answerPanel.append(input);
            }
         }
        if(it.question_type == '4'){
        	var text = '';
        	var allAnswer = it.question_content;
        	var answers = allAnswer.split('-/@/-');
        	text += '<div class="form-group" id="question' + i + '"><label>'+ (i+1) + '.' + answers[0] + '</label><div  class="for_slider" id="sliderPanel' + i + '"></div>';
      	   panel.append(text);
      	   var sliderPanel = $('#sliderPanel'+i);
      	   var text = answers[1] + ' <input type="range" id="range' + i + '"> ' + answers[2];
      	   sliderPanel.append(text);
			   $('#range'+i).slider({
				   id : 'getRange' + i,
				   min : Number(answers[1]),
				   max : Number(answers[2]),
				   value : Number(done.answer),
				   step : 1,
				   enabled : true
			   });
        }
        if(it.question_type == '5'){
        	var text = '';
     	   text += '<div id="question' + i + '"><label>'+ (i+1) + '.' + it.question_content + '</label><span style="color : gray; font-size : 12px">(파일은 다시 올려주셔야합니다!)</span><input type="file" name="answer' + i + '"></div>';
     	   panel.append(text);   
        }
      }   
      $('#questions').append('<div class="col-md-4"></div><button class="btn btn-default col-md-4" onclick="submitModifyAnswer()">수정할래요</button>');
      
   }
   
   function submitModifyAnswer(){
	  var rightNow = new Date().getTime();
	  if(min > current || current > max){
		  alert('현재 수정하실 수 없습니다.');
		  return;
	  }
	  
      var board = <%=board%>;
      var data = board.id;
      $.ajax({
          url : 'ajax.do',
          type : 'post',
          async : false,
           data : {
          req: 'deleteWhoAnswer',
            data: data
      },
      success : function(data){
               if(data == 'success'){
                  var Answer = '';
                  var board_number = <%=board%>.id;
                  var fileSequence = 1;
                  for(var i = 0 ; i < questions.length ; i ++){
                     var it = questions[i];
                     if(it.question_type == '1'){
                        Answer += $('input:text[name=answer'+i+']').val();
                     }
                     if(it.question_type == '2'){
                        Answer += $('input:radio[name=answer'+i+']:checked').val();
                     }
                     if(it.question_type == '3'){
                        var length = it.question_content.split('-/@/-').length;
                        for(var j = 1 ; j < length ; j ++){
                           if($('input:checkbox[id="answer' + i + 'S' + j + '"]').is(":checked") ==  true)
                              {
                              Answer += $('#answer'+i+'S'+j).val();
                              Answer +='-/@/-' //무조건 하나 더생기므로 나중에 액션에서 다오에서 고려
                              }
                        }
                     }
                     if(it.question_type == '4'){
                    	 Answer += $('#range'+i).slider("getValue");
                     }
                     if(it.question_type == '5'){
                    	 var formData = new FormData();
                    	 formData.append('uploadFile', $('input[name=answer' + i + ']')[0].files[0]);
                    	 formData.append('fileSequence',fileSequence);
                    	 formData.append('userName',<%=user%>.name);
                    	 formData.append('boardID',board_number);
                    	 $.ajax({
                             url : 'req_board_answer_upload.do',
                             type : 'post',
                             data : formData,
                             processData : false,
                             contentType : false,
                             async : false,
                             success : function(data) {
                                if(data != 'fail'){
                                    Answer += data;
                                    ++fileSequence;
                                }
                                else{
                                    alert('SERVER ERROR, Please try again later...');
                                }
                             }
                        })
                     }
                     if(i != questions.length)
                        Answer += '-/#/-';
                  }
                  var data = board_number + "-/-/-" + Answer + "-/-/-" + questions.length;
                  $.ajax({
                      url : 'ajax.do',
                      type : 'post',
                       data : {
                      req: 'insertAnswer',
                        data: data
                  },
                  success : function(data){
                     if(data == 'success'){
                        alert('수정이 성공하였습니다');
                        if(<%=board%>.for_who == 1)
                        	window.location.href= 'req_article_reader.do?id=' + <%=board%>.id;
                        check();
                        whatIDone();
                     }
                     else if(data == 'fail'){
                        alert('SERVER ERROR, Please try again later.');
                     } else{
                    	 alert('이미 신청한 글입니다.');
                     }
                        }
                  });
               }
               else{
                  alert('SERVER ERROR, Please try again later.');
               }
               }
      });
   }
   
   function deleteMyAnswer(){
	   var rightNow = new Date().getTime();
		  if(min > current || current > max){
			  alert('현재 삭제하실 수 없습니다.');
			  return;
		  }
      var board = <%=board%>;
      var data = board.id;
      $.ajax({
          url : 'ajax.do',
          type : 'post',
          async : false,
           data : {
          req: 'deleteWhoAnswer',
            data: data
      },
      success : function(data){
               if(data == 'success'){
                  alert('삭제에 성공하였습니다.');
                  $('#questions').empty();
                  wasDone = 0;
                  settingQuestion();
                  if(min <= current && current <= max){
                     isAvailable = 1;
                  }
               }
               else{
                  alert('SERVER ERROR, Please try again later.');
               }
               }
      });
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
   
   function makeAnother(){
	   
	   var anotherAnswer = <%=AnswerWhoDone%>;
 		var AnotherPanel = $('#anotherDone');
	  	if(anotherAnswer.length > 0){
	  		AnotherPanel.append('<div class="explain">각각을  클릭하면 상세한 정보를 볼 수 있습니다.</div>')
	  		var done = [];
	  		for(var i = 0 ; i < anotherAnswer.length ; ++i){
	  			var value = anotherAnswer[i];
	  			var sequence = Math.floor(i/questions.length);
	  			done.push(value);
	  			if(i % questions.length == 0){
	  				var text = '<a onclick="doMoreView(' + sequence + ')"><div class="anotherDone">' + value.user_name + '(' + value.user_per_id + ')의 신청입니다</div></a><div id="moreViewAnother' + sequence + '" style="display:none;"></div>';
	  				AnotherPanel.append(text);
	  			}
	  			if(i % questions.length == (questions.length - 1)){
	  				whatAnotherDone(sequence, done);
	  				done = [];
	  			}
	  		}
	  		AnotherPanel.append('<a onclick="doAllView()"><div class="anotherDone">전체결과보기</div></a><div id ="moreViewAll" style="display : none; overflow:auto;">총 ' + (anotherAnswer.length / questions.length) + '명</div>');
	  		makeAllView();
   		}
	  	else if(<%=type%>.for_header == '관리자' || <%=board%>.student_id == <%=user%>.id ){
	  		AnotherPanel.append('<div class="explain">※아직 신청자가 없습니다</div>');
	  	}
	  }
 
   function doMoreView(index){
	   $('#moreViewAnother'+index).toggle();
   }
   
   function doAllView(){
	   $('#moreViewAll').toggle();
   }
   
   function makeAllView(){
	   var forAnswer = []
	   var allPanel = $('#moreViewAll');
	   allPanel.css('border', '1px solid black');
	   allPanel.css('padding-bottom', '10px');
	    var allViewTable = $('<table></table>').attr({'id' : 'table'});
	  	allViewTable.addClass('table table-striped table-hover table-bordered');
	    var allViewThead = $('<thead></thead>').attr('id', 'allTableThead').appendTo(allViewTable);
	    var allViewTr = $('<tr></tr>').attr('id','allTableTr').appendTo(allViewThead);
	    $('<th></th>').attr({'data-field' : 'name', 'data-sortable' : 'true'}).text('이름').appendTo(allViewTr);
	    $('<th></th>').attr({'data-field' : 'per_id', 'data-sortable' : 'true'}).text('학번').appendTo(allViewTr);
	    $('<th></th>').attr({'data-field' : 'grade', 'data-sortable' : 'true'}).text('학년').appendTo(allViewTr);
	    for(var i = 0 ; i < questions.length ; i++){
	    	$('<th></th>').attr({'data-field' : 'AnswerAnother' + i , 'data-sortable' : 'true'}).text((i+1) + '번').appendTo(allViewTr);
	    }
	    var allViewTbody = $('<tbody></tbody>').appendTo(allViewTable);
	    allViewTable.appendTo(allPanel);
	    var getDatas = data();
	    for(var i = 0 ; i < getDatas.length ; ++i){
	    	var value = getDatas[i];
	    	var oneTr = $('<tr></tr>').appendTo(allViewTbody);
	    	$('<td></td>').text(value.name).appendTo(oneTr);
	    	$('<td></td>').text(value.per_id).appendTo(oneTr);
	    	$('<td></td>').text(value.grade).appendTo(oneTr);
	    	for(var j = 0 ; j < questions.length ; ++j)
	    		if(questions[j].question_type == 5){
	    			if(value['AnswerAnother' + j] != 'null')
			    		$('<td></td>').html('<a href="req_board_download.do?id=' + value['AnswerAnother' + j] + '"><img src="img/file_ico.png"></a>').appendTo(oneTr);
	    			else
			    		$('<td></td>').html('<span style="font-size : 14px; color : red">미제출<span>').appendTo(oneTr);
	    		}
	    		else{
	    			if(value['AnswerAnother' + j] != '')
		    			$('<td></td>').text(value['AnswerAnother' + j]).appendTo(oneTr);
	    			else
		    			$('<td></td>').html('<span style="color : red; font-size : 14px;">미답변</span>').appendTo(oneTr);
	    		}
	    }
   }
   
   function data(){
       var rows = [];
       var AnswerWhoDone = <%=AnswerWhoDone%>;
       var forRows;
       for(var i = 0 ; i < AnswerWhoDone.length ; ++i){
          var value= AnswerWhoDone[i];
          var number = i % questions.length;
          if(number == 0){
        	  forRows = new Object();
        	  forRows.name = value.user_name;
        	  forRows.per_id = value.user_per_id;
        	  forRows.grade = value.user_grade;
          }
          forRows['AnswerAnother'+number] = value.answer;
          if(number == (questions.length - 1))
              rows.push(forRows);
       }
       return rows;
    }
   
   var postbox = $('#post_box');
   var file = <%=file%>;
   var a = '';
   if(file.length > 0)
      a += '첨부파일: ';
   if(file.length == 0)
	   $('#post_box').remove();
   for(var i = 0 ; i < file.length ; i++){
      var it = file[i];
      if(<%=user%> != null){
    	  if(<%=board%>.level.includes(<%=type%>.for_header) || <%=type%>.for_header == '관리자' || <%=user%>.id == <%=board%>.student_id)
    	      	a += '<a href="req_writer_download_file.do?id=' + it.id + '">' + it.original_name + '</a>&nbsp&nbsp';
    	      else
    	    	  a  += it.original_name + '&nbsp&nbsp';
      }
      else
    	  a  += it.original_name + '&nbsp&nbsp';
   }
   postbox.append(a);
   
   
   $(function(){
      check();
      getQuestion();
      makeAnother();
      if(wasDone == 0)
         settingQuestion();
      else{
         whatIDone();
         }
      makeButtons();
      }
   )
   
   
</script>
</body>
</html>