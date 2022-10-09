<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
	StringBuffer url2_ra_writer = request.getRequestURL();
	String logo_img_ra_writer;

	//로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
	//ai이면 ai로고 cs이면 cs로고
	if(url2_ra_writer.substring(7,9).equals("ai") || url2_ra_writer.substring(7,9).equals("lo")){
		logo_img_ra_writer = "img/apply_ai.png";
	}
	else{
		logo_img_ra_writer = "img/apply.png";
	}
	//System.out.println((logo_img_ra_writer));
%>
<%
String tabmenulist=(String) request.getAttribute("tabmenulist");
String types = (String) request.getAttribute("typecount");
%>
<%
	String headermenulist = (String) session.getAttribute("headermenulist");
	String menulist = (String) session.getAttribute("menulist");
	String user = (String) session.getAttribute("user");
	String type = (String) session.getAttribute("type");
%>
<%
	String num = (String) request.getAttribute("num");
	String pageMenuList = (String) request.getAttribute("pageMenuList");//좌측 소메뉴 리스트

	/**
	 * for page.jsp
	 * */
	String jsp = (String) request.getAttribute("jsp");
%>

<title>경기대학교 AI컴퓨터공학부</title>

<style>
#maincontent {
	padding: 0;
}

#maincontent>ul {
	padding: 10px;
}

#container {
	width: 1000px;
}

#maincontent {
	margin: 0 auto;
	border: none;
}

#post_title {
	width: 744px;
}

#afile3-list {
	font-size: 13px;
}

#afile3-list a {
	color: tomato;
}

.kv-zoom-cache {
	display : none;
}

.file-drop-zone-title{
	padding : 25px 10px;
}

.kv-file-content {
	width : 500px !important;
}

.file-details-cell {
	display : none;
}

.kv-zoom-thumb {
	display : none;
}

.fileinput-remove{
	display : none;
}
</style>

			<div id="maincontent">
				<form name="writeboards">
					<ul>
						<li>
							<div id="articlename" class="contenttitle"></div>
						</li>
					</ul>
						<div class="form-group">
							<label for="post_title">제목</label>
							<input type="text" class="form-control" name="title" id="post_title" placeholder="제목을 입력하세요">
						</div>
						<div style="width: 280px; display : inline-block">
							<div class="form-group">
								<label for="InputStartDate">시작일</label>
								<input type="date" class="form-control" name="startDate" id="InputStartDate">
							</div>
						</div>
						<div style="width: 280px; display : inline-block; margin-left : 20px">
							<div class="form-group">
								<label for="InputFinishDate">마감일</label>
								<input type="date" class="form-control" name="finishDate" id="InputFinishDate">
							</div>
						</div>
						<div style="width: 135px; display : inline-block; margin-left : 20px">
							<label for="forWho">신청현황공개</label>
							<select class="form-control" id="forWho">
								<option value="0">작성자+관리자+교수님</option>
								<option value="1">모두공개</option>
							</select>
						</div>
						<div id="selectLevelDiv">
							<label>신청대상</label>
						</div>
					<hr style="border : 1px dotted black">
						<textarea name="content" id="editor"></textarea>
					<hr style="border : 1px solid black"></form>
					<div class="file-loading">
                     	<input id="fileInput" type="file" multiple>
                  	</div>
					<hr style="border : 1px solid black;" ></form>
					<div id="questionPanel" >
						<div id="addQuestion" >
							<div id="selectWhat" style="margin-bottom : 15px;">
								<label class="radio-inline">
									<input type="radio" name="what" value="주관식" checked="true"> 주관식
								</label>
								<label class="radio-inline">
									<input type="radio" name="what" value="단일객관식"> 단일객관식
								</label>
								<label class="radio-inline">
									<input type="radio" name="what" value="다중객관식"> 다중객관식
								</label>
								<label class="radio-inline">
									<input type="radio" name="what" value="척도형"> 척도형
								</label>
								<label class="radio-inline">
									<input type="radio" name="what" value="파일업로드형"> 파일업로드형
								</label>
								<button class="btn btn-default" onclick="makeQuestion()" style="float: right;">생성</button>
							</div>
							<div id="whatYouWant" style="margin-top : 5px">
							</div>
						</div>
						<div id="makeQuestion">
						</div>
						<hr style="border : 1px solid black; width: -webkit-fill-available">
						<div id="questionYouMade">
						</div>
					</div>	
						<div style="margin-top : 10px;" class="post_button" id="post_submit_btn">
							<a href="javascript:history.back()" class="btn btn-default">취소</a>
							<a class="btn btn-default" onclick="insertboard()">쓰기</a> 
						</div>
			</div>
					<script>
//여기는 쿼리문 변경

			var list = $('#tab_2');
			var articlename=$('#articlename');
			var arr = <%=tabmenulist%>
			for (var i = 0; i < arr.length; i++) {
				var value = arr[i];
				if(value.show_in_menus)
				list.append(makeone(value));
			}
			articlename.append('신규 신청접수 작성');
			articlename.css('text-align','center');
			
			var count = <%=types%>;
			var memory = [];
			for(var i = 0 ; i < count.length ; i ++){
				var value = count[i];
				if(value.for_header == '관리자')
					continue;
				if(i > 0){
					if(memory.indexOf(value.for_header) >= 0){
					}
					else{
						if(value.for_header == "손님")
							continue;
						memory.push(value.for_header);
						var sequence = memory.indexOf(value.for_header);
						$('#selectLevelDiv').append('<label class="checkbox-inline" style="margin-left : 20px"><input type="checkbox" id="levelcheck' + sequence + '" value="' + value.for_header + '">'+ value.for_header +'</label>');
						
					}
				}
				else{
					$('#selectLevelDiv').append('<label class="checkbox-inline" style="margin-left : 20px"><input type="checkbox" id="levelcheck' + i + '" value="' + value.for_header + '">'+ value.for_header +'</label>');
					memory.push(value.for_header);
					}
			}
			
			var today = new Date();
			var tomorrow = new Date();
			tomorrow.setDate(today.getDate() + 1);

			 function formatDate(date) {
		            var d = new Date(date),
		                month = '' + (d.getMonth() + 1),
		                day = '' + d.getDate(),
		                year = d.getFullYear();

		            if (month.length < 2) month = '0' + month;
		            if (day.length < 2) day = '0' + day;

		            return [year, month, day].join('-');
		        } 
			$('#InputStartDate').val(formatDate(today));
			$('#InputFinishDate').val(formatDate(tomorrow));
			
		// 	문제 수 계산기
		var questionIndex = 1;
		var answerIndex = 1;
		function makeQuestion(){
			answerIndex = 1;
			var index;
			if($("input[name=what]:checked").val()=='주관식'){
				index = 1;
				var a = '<div class="form-group"><input type="text" class="form-control" id="InputName" placeholder="질문을 입력해주세요"></div>';
				$('#whatYouWant').html(a);
				}
			
			if($("input[name=what]:checked").val()=='단일객관식'){
				index = 2;
				var a = '<div class="form-group"><input type="text" class="form-control" id="InputName" placeholder="질문을 입력해주세요"></div>'
				a += '<div id="answers"></div>';
				a += '<div style="width : 200px"><div class="input-group"><input type="text" class="form-control" placeholder="새로운 답변" id="newAnswer"><span class="input-group-btn"><button class="btn btn-default" type="button" onclick="makeAnswer()">추가!</button></span></div></div>';
				$('#whatYouWant').html(a);
			}
			
			if($("input[name=what]:checked").val()=='다중객관식'){
				index = 3;
				var a = '<div class="form-group"><input type="text" class="form-control" id="InputName" placeholder="질문을 입력해주세요"></div>'
				a += '<div id="answers"></div>';
				a += '<div style="width : 200px"><div class="input-group"><input type="text" class="form-control" placeholder="새로운 답변" id="newAnswer"><span class="input-group-btn"><button class="btn btn-default" type="button" onclick="makeAnswer()">추가!</button></span></div></div>';
				$('#whatYouWant').html(a);
			}
			if($("input[name=what]:checked").val()=='척도형'){
				index = 4;
				var a = '<div class="form-group"><input type="text" class="form-control" id="InputName" placeholder="질문을 입력해주세요"></div>';
				a += '<div class="form-group" style="width : 200px"><input type="text" class="form-control" id="InputMin" placeholder="최솟값"></div>';
				a += '<div class="form-group" style="width : 200px"><input type="text" class="form-control" id="InputMax" placeholder="최댓값"></div>';
				$('#whatYouWant').html(a);
			}
			if($('input[name=what]:checked').val() == '파일업로드형'){
				index = 5;
				var a = '<div class="form-group"><input type="text" class="form-control" id="InputName" placeholder="어떠한 파일을 올릴지 간단한 설명을 적어주세요"></div>';
				$('#whatYouWant').html(a);
			}
			$('#makeQuestion').html('<div><button id="makeBtn" class="btn btn-default" style="margin: 10px 0; float : right" onclick="submitQuestion('+index+')">저장</button></div>');
			
		}	
		
		function makeAnswer(){
			var text = $('#newAnswer').val();
			if(text == ''){
				alert('칸을 입력해주세요');
				return;
				}
			$('#newAnswer').val('');
			var a = '<div class="radio disabled count"><label><input type="radio" id="answer'+answerIndex+'" value="'+text+'" disabled>'+text+'</label></div>';
			$('#answers').append(a);
			answerIndex++;
		}
		
		var whatSequence = [];
		
		function submitQuestion(index){
			answerIndex = 0;
			var a ='';
			var question = $('#InputName').val();
			if(question == ''){
				alert('질문을 입력해주세요');
				return;
			}
			if(index == 1){
				a += '<div id="wantRemove'+questionIndex+'"><div><div class="form-group"><label for="question'+questionIndex+'"><img src="img/board.png" style="width:25px; margin-right:5px;"><span id="Type'+questionIndex+'">주관식</span></label><div onclick="removeQuestion('+questionIndex+')" style="display :inline-block"><img style="display:inline-block; margin-left : 10px; width : 17px" src="img/denied.png"></div><input type="text" class="form-control" readonly id="question'+questionIndex+'" name="question'+questionIndex+'" value="'+ question +'"></div></div><hr style="border : 1px dotted black"></div>';
				$('#questionYouMade').append(a);
			}
			if(index == 2){
				var answerLength = $('.count').length;
				a += '<div id="wantRemove'+questionIndex+'"><div><div class="form-group"><label for="question'+questionIndex+'"><img src="img/board.png" style="width:25px; margin-right:5px;"><span id="Type'+questionIndex+'">단일객관식</span></label><div onclick="removeQuestion('+questionIndex+')" style="display :inline-block"><img style="display:inline-block; margin-left : 10px; width : 17px" src="img/denied.png"></div><input type="text" class="form-control" readonly id="question'+questionIndex+'" name="question'+questionIndex+'" value="'+ question +'"></div></div>';
				a += '<div id="answerOf'+questionIndex+'"></div><hr style="border : 1px dotted black"></div>'
				$('#questionYouMade').append(a);
				var b = '';
				for(var i = 1 ; i <= answerLength ; ++i){
					var answer = $('#answer'+i).val();
					b += '<div class="radio disabled"><label><input type="radio" disabled class="Q' + questionIndex + '" id="Q' + questionIndex + 'A' + i + '" value="' + answer + '">' + answer + '</label></div>';
				}
				$('#answerOf'+questionIndex).html(b);
			}
			if(index == 3){
				var answerLength = $('.count').length;
				a += '<div id="wantRemove'+questionIndex+'"><div><div class="form-group"><label for="question'+questionIndex+'"><img src="img/board.png" style="width:25px; margin-right:5px;"><span id="Type'+questionIndex+'">다중객관식</span></label><div onclick="removeQuestion('+questionIndex+')" style="display :inline-block"><img style="display:inline-block; margin-left : 10px; width : 17px" src="img/denied.png"></div><input type="text" class="form-control" readonly id="question'+questionIndex+'" name="question'+questionIndex+'" value="'+ question +'"></div></div>';
				a += '<div id="answerOf'+questionIndex+'"></div><hr style="border : 1px dotted black"></div>'
				$('#questionYouMade').append(a);
				var b = '';
				for(var i = 1 ; i <= answerLength ; ++i){
					var answer = $('#answer'+i).val();
					b += '<div class="checkbox disabled"><label><input type="checkbox" disabled class="Q' + questionIndex + '" id="Q' + questionIndex + 'A' + i + '" value="' + answer + '">' + answer + '</label></div>';
				}
				$('#answerOf'+questionIndex).html(b);
			}
			if(index == 4){
				var min = $('#InputMin').val() + '';
				var max = $('#InputMax').val() + '';
				var avg = Number(max) + Number(min);
				if(min == '' || max == ''){
					alert("빈칸을 입력해주세요^^");
					return;
				}
				if(min > max){
					alert('이거 최소 최대 순서 잘못쓰신거같아요^^');
					return;
				}
				if(!checkInt(min) || !checkInt(max)){
					alert("숫자만 입력해주세요 ^^");
					return;
				}
				a += '<div id="wantRemove'+questionIndex+'"><div><div class="form-group"><label for="question'+questionIndex+'"><img src="img/board.png" style="width:25px; margin-right:5px;"><span id="Type'+questionIndex+'">척도형</span></label><div onclick="removeQuestion('+questionIndex+')" style="display :inline-block"><img style="display:inline-block; margin-left : 10px; width : 17px" src="img/denied.png"></div><input type="text" class="form-control" readonly id="question'+questionIndex+'" name="question'+questionIndex+'" value="'+ question +'"></div></div>';
				a += min +'<input type="range" id="range' + questionIndex + '">' + max + '<input type="hidden" id="min' + questionIndex + '" value="' + min + '"><input type="hidden" id="max' + questionIndex + '" value="' + max + '">';
				a += '<hr style="border : 1px dotted black"></div>'
				$('#questionYouMade').append(a);
				$('#range'+questionIndex).slider({
					min : min ,
					max : max ,
					value : Math.floor(avg/2),
					step : 1,
					enabled : false
				});
			}
			if(index == 5){
				a += '<div id="wantRemove'+questionIndex+'"><div><div class="form-group"><label for="question'+questionIndex+'"><img src="img/board.png" style="width:25px; margin-right:5px;"><span id="Type'+questionIndex+'">파일업로드형</span></label><div onclick="removeQuestion('+questionIndex+')" style="display :inline-block"><img style="display:inline-block; margin-left : 10px; width : 12px" src="img/denied.png"></div><input type="text" class="form-control" readonly id="question'+questionIndex+'" name="question'+questionIndex+'" value="'+ question +'"></div><input type="file" disabled></div><hr style="border : 1px dotted black"></div>';
				$('#questionYouMade').append(a);
			}
			whatSequence.push(questionIndex);
			questionIndex++;
			$('#whatYouWant').empty();
			$('#makeQuestion').empty();
		}	
			
		function checkInt(String){
			var a = ['0','1','2','3','4','5','6','7','8','9'];
			var isOk = 1;
			for(var i = 0 ; i < String.length ; ++i){
				var value = String[i];
				if(!a.includes(value))
					isOk = 0;
			}
			if(isOk == 0)
				return false;
			else
				return true;
		}
		
		function removeQuestion(index){
			$('#wantRemove'+index).remove();
			whatSequence = jQuery.grep(whatSequence, function(value) {
				  return value != index;
				});
		}
		
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
		
		var pane = $('#title');
	  	var panel =$('#titlename');
	  	var user = <%= user%>;
		var headtitle = <%=headermenulist%>;
//		pane.prepend('<img src="'+headtitle[4].tab_img+'" alt="">');
		panel.append(headtitle[4].tab_title);
		
		 CKEDITOR.replace('editor', {
	          allowedContent: true,
	          height: 300,
	          'filebrowserUploadUrl': 'Uploader'
	     });
	
		function insertboard(){
			var user = <%=user%>;
			
			var writer= user.id;
			var forWho = $('#forWho').val();// 0 : 작성자와 관리자만 보게하기 1 : 모두 보게하기
			var title=$('[name=title]').val();
			if(title.length == 0){
				alert('제목을 입력해주세요!');
				return;
			}
			var startDate = $('[name=startDate]').val();
			var finishDate = $('[name=finishDate]').val();
			if(startDate == '' || finishDate == ''){
				alert('날짜를 설정해주세요');
				return;
			}
			var level = '';
			
			for(var i = 0 ; i < memory.length ; ++i){
				var index = memory.indexOf(memory[i]);
				if($('input:checkbox[id="levelcheck' + index +'"]').is(":checked") ==  true)
					level += '|'+$('#levelcheck'+index).val()+'|';
			}
			
			if(level.length == 0){
				alert('대상을 선택해주세요');
				return;
			}
			var content = CKEDITOR.instances.editor.getData();
			// -/#/- 로 문제마다 구분 -/!/-로 문제 유형과 답변 구분  -/@/- 로 답변별 구분    1 주관 2 단일객관 3 다중객관 4척도형
			var question = '';
			var howManyQuestion = whatSequence.length;
			if(howManyQuestion == 0){
				alert('질문을 만들어주세요');
				return;
			}
			for(var k = 1 ; k <= howManyQuestion ; k ++){
				var i = whatSequence[k-1]
				if($('#Type'+i).text() == '주관식'){
					question += '1-/!/-';
					question += $('#question'+i).val();
					
				}
				
				if($('#Type'+i).text() == "단일객관식"){
					question += "2-/!/-";
					question += $('#question'+i).val() + "-/@/-";
					var length = $('.Q'+i).length;
					for(var j = 1 ; j <= length ; j++){
						var text = $('#Q'+i+'A'+j).val();
						question += text;
						if(j != length)
							question += "-/@/-"
					}
				}
				
				if($('#Type'+i).text() == "다중객관식"){
					question += "3-/!/-";
					question += $('#question'+i).val() + "-/@/-";
					var length = $('.Q'+i).length;
					for(var j = 1 ; j <= length ; j++){
						var text = $('#Q'+i+'A'+j).val();
						question += text;
						if(j != length)
							question += "-/@/-"
					}
				}
				if($('#Type'+i).text() == '척도형'){
					question += "4-/!/-";
					question += $('#question'+i).val() + "-/@/-"
					question += $('#min'+i).val() + "-/@/-" + $('#max'+i).val();
				}
				if($('#Type'+i).text() == '파일업로드형'){
					question += '5-/!/-';
					question += $('#question'+i).val();
				}
				if(k != howManyQuestion)
					question += "-/#/-"
			}
			var data = writer + "-/-/-" + user.name + "-/-/-" + title + "-/-/-" + startDate + "-/-/-" + finishDate + "-/-/-" + content + "-/-/-" + level + "-/-/-" + forWho + "-/-/-" + question;
			$.ajax({
			    url : 'ajax.do',
			    type : 'post',
		        data : {
		    	req: 'insertReqBoard',
		      	data: data
			},
			async : false,
			success : function(data){
				if(data != 'fail'){
					$.ajax({
					    url : 'ajax.do',
					    type : 'post',
					    async : false,
				        data : {
				    	req: 'makeReqFile',
				      	data: data
					},
					success : function(data){
						if(data == 'success'){
							alert('작성이 성공하였습니다');
							is_submit = true;
							window.location.href = 'req_article_list.do?num=51';
						}
						else{
							alert('SERVER ERROR, Please try again later....');
							return;
						}
					}
					});
				}
				else{
					alert('SERVER ERROR, Please try again later.');
					return;
				}
			   	}
			});
		}
		
		$("#fileInput").fileinput({
            'theme': 'explorer-fa',
            'uploadUrl': 'req_writer_upload_file.do',
            showRemove : false,
            showUpload : false,
            overwriteInitial : false,
            uploadExtraData:{
               writer : user.id,
               }
       });
		
		
		 function exit(){
	          $.ajax({
	                url : 'req_writer_exit_file.do',
	                type : 'post',
	                data : {data : <%=user%>.id},
	                success : function(data) {
	                   if(data != 'fail'){
	                	   alert('올렸던 글과 파일들은 저장되지 않습니다!');
	                   }
	                   else{
	                      alert('SERVER ERROR, Please try again later...');
	                      return;
	                      }
	                }
	           })     
	       }
	   
	   var is_submit = false;
	   $(window).on("beforeunload", function () {
	         if (!is_submit){ 
	            return exit();
	            }
	     });
		
		
		
	</script>
</body>
</html>
