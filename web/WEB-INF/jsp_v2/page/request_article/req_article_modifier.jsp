<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
	StringBuffer url2_ra_modifier = request.getRequestURL();
	String logo_img_ra_modifier;

	//로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
	//ai이면 ai로고 cs이면 cs로고
	if(url2_ra_modifier.substring(7,9).equals("ai") || url2_ra_modifier.substring(7,9).equals("lo")){
		logo_img_ra_modifier = "img/apply_ai.png";
	}
	else{
		logo_img_ra_modifier = "img/apply.png";
	}
	//System.out.println((logo_img_ra_modifier));
%>
<% 
String tabmenulist=(String) request.getAttribute("tabmenulist");
String types = (String) request.getAttribute("typecount");
String board = (String) request.getAttribute("board");
String file = (String) request.getAttribute("file");
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
								<option value="0" id="forWho0">작성자+관리자+교수님</option>
								<option value="1" id="forWHo1">모두공개</option>
							</select>
						</div>
						<div id="selectLevelDiv">
							<label>신청대상</label>
						</div>
					<hr style="border : 1px dotted black">
						<textarea name="content" id="editor"></textarea>
					<hr style="border : 1px solid black"></form>
					<ul id="alreadyFiles">
					</ul>
               		<div class="file-loading">
                   		<input id="fileInput" type="file" multiple>
               		</div>
               		<div style="margin-top : 5px;" class="post_button" id="post_submit_btn">
							<a href="javascript:history.back()" class="btn btn-default">취소</a>
							<a class="btn btn-default" onclick="modifyboard()">수정</a> 
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
			
			var board = <%=board%>;
			$('#post_title').val(board.title);
			$('#InputStartDate').val(formatDate(board.starting_date));
			$('#InputFinishDate').val(formatDate(board.closing_date));
			$('#forWho').val(board.for_who);			
			$('#editor').text(board.content);
			
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
						if(board.level.includes(value.for_header))
							$('#selectLevelDiv').append('<label class="checkbox-inline" style="margin-left : 20px"><input type="checkbox" checked="true" id="levelcheck' + sequence + '" value="' + value.for_header + '">'+ value.for_header +'</label>');
						else
							$('#selectLevelDiv').append('<label class="checkbox-inline" style="margin-left : 20px"><input type="checkbox" id="levelcheck' + sequence + '" value="' + value.for_header + '">'+ value.for_header +'</label>');

					}
				}
				else{
					if(board.level.includes(value.for_header))
						$('#selectLevelDiv').append('<label class="checkbox-inline" style="margin-left : 20px"><input type="checkbox" checked="true" id="levelcheck' + sequence + '" value="' + value.for_header + '">'+ value.for_header +'</label>');
					else
						$('#selectLevelDiv').append('<label class="checkbox-inline" style="margin-left : 20px"><input type="checkbox" id="levelcheck' + sequence + '" value="' + value.for_header + '">'+ value.for_header +'</label>');
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
	
		function modifyboard(){
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
			
			var data = title + "-/-/-" + startDate + "-/-/-" + finishDate + "-/-/-" + content + "-/-/-" + level + "-/-/-" + forWho + "-/-/-" + <%=board%>.id;
			$.ajax({
			    url : 'ajax.do',
			    type : 'post',
		        data : {
		    	req: 'modifyReqBoard',
		      	data: data
			},
			success : function(data){
					if(data == "success"){
						alert('수정에 성공하였습니다');
						}
					else{
						alert('SERVER ERROR, Please try again later...');
						return;
					}
				}
			});
			is_submit = true;
			window.location.href = 'req_article_reader.do?num=51&id='+<%=board%>.id;
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
		
		var alreadyFiles = <%=file%>;
		if(alreadyFiles.length > 0){
			var alreadyPanel = $('#alreadyFiles');
			for(var i = 0 ; i < alreadyFiles.length ; ++i){
				var value = alreadyFiles[i];
				alreadyPanel.append('<li id="alreadyFileDiv' + i + '">' + value.original_name + '<a onclick="alreadyDelete(' + i + ')"><img src="img/denied.png" style="width : 12px; margin-left : 5px;"></a></li>');
			}		
		}
		
		function alreadyDelete(index){
			var value = alreadyFiles[index];
			$.ajax({
				url : 'ajax.do',
				type : 'post',
				data : {
					req:"req_board_delete_already_file",
					data:value.id
				},
				success : function(data){
					if(data == "success") {
						$('#alreadyFileDiv'+index).remove();
					}
					else{
						alert("SERVER ERROR, Please try again later...");
						return;
					}
				}
			});
			
		}
		
		 function exit(){
	          $.ajax({
	                url : 'req_writer_exit_file.do',
	                type : 'post',
	                data : {
	                	data : <%=user%>.id
	                	},
	                success : function(data) {
	                   if(data == 'fail'){
	                	   alert('SERVER ERROR, Please try again later...');
		                      return;	                   
		                      }
	                }
	           })
	          $.ajax({
	        	  url : 'ajax.do',
	        	  type : 'post',
	        	  data :{
	        		  req : 'req_board_already_file_exit',
	        		  data : <%=board%>.id
	        	  },
	        	  success : function(data){
	        		 if(data != 'fail'){
	        			 alert('수정했던 파일, 글들은 저장되지 않습니다.')
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
