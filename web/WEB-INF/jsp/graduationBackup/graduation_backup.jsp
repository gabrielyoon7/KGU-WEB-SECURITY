<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%

	String tabmenulist = (String) request.getAttribute("tabmenulist");
	String userList = (String)request.getAttribute("userList");
	String year = (String)request.getAttribute("yearList");
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="utf-8">
<title>경기대학교 AI컴퓨터공학부</title>
<link rel="stylesheet" href="css/bootstrap-table.css">
<link href='css/bootstrap.css' rel='stylesheet' type='text/css'>
<link href='css/default.css' rel='stylesheet' type='text/css'>
<link href='css/boardtable.css' rel='stylesheet' type='text/css'>
<link href='css/information.css' rel='stylesheet' type='text/css'>
<link href='css/content.css' rel='stylesheet' type='text/css'>
<link href='css/bootstrap-table.css' rel='stylesheet' type='text/css'>
<style>
#maincontent {
	padding: 0;
}

#maincontent>ul {
	padding: 10px;
}

#thesisModalBody {
	 padding: 5px;
	 border: 1px solid #607D8B;
	 font-size: 13px;
	 display: flex;
	 margin: auto;
	 margin-bottom: 10px;
 }
#contestModalModalBody {
	padding: 5px;
	border: 1px solid #607D8B;
	font-size: 13px;
	display: flex;
	margin: auto;
	margin-bottom: 10px;
}
#certificateModalBody {
	padding: 5px;
	border: 1px solid #607D8B;
	font-size: 13px;
	display: flex;
	margin: auto;
	margin-bottom: 10px;
}
#conferenceModalBodyModalBody {
	padding: 5px;
	border: 1px solid #607D8B;
	font-size: 13px;
	display: flex;
	margin: auto;
	margin-bottom: 10px;
}

.profile {
	background-color : #ECEFF1;
	font-weight: bold;
	display: inline-block;
	width: 80px;
	text-align: right;
	padding-right : 5px;
	height : auto;
	padding-bottom:inherit;
}
.inform {
	display: inline-block;
	text-align: left;
	margin-left : 5px;
	width : 620px;
	overflow-wrap:break-word;
	height : auto;
	padding-bottom:inherit;
}

.boardtable>thead>tr>th:nth-child(1) {
	min-width: 20px;
}

.boardtable>tbody>tr>td:nth-child(1) {
	min-width: 20px;
}

.boardtable>thead>tr>th:nth-child(2) {
	min-width: 30px;
	max-width: 30px;
}

.boardtable>thead>tr>th:nth-child(4) {
	width: 80px;
}

.boardtable>tbody>tr>td:nth-child(2) {
	font-family: 'Nanum Gothic', sans-serif;
	min-width: 30px;
	max-width: 30px;
}

.boardtable>tbody>tr>td:nth-child(5), .boardtable>thead>tr>th:nth-child(5)
	{
	min-width: 65px;
	max-width: 65px;
}

.boardtable>tbody>tr>td:nth-child(4) {
	width: 100px;
}

.modal-body .fixed-table-body {
	font-family: 'Nanum Gothic', sans-serif;
	height: 257px;
}
</style>
</head>
<body>
	<script src="js/default.js"></script>
	<script src="js/jquery-3.2.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/bootstrap-table.js"></script>
	<script src="js/bootstrap-table-cookie.js"></script>
	<script src="js/sha256.js"></script>
	<%@include file="../main/header.jsp"%>
	<script>
		function makeboard(id) {
			var list = $(id);
			var arr = <%=tabmenulist%>;
			for (var i = 0; i < arr.length; i++) {
				var value = arr[i];
				if(value.show_in_menus)
					list.append(makeone(value));
			}
		}
		function makeone(str) {
			var num=str.tab_id*10+str.orderNum;
			var text = '<li><span class="deco_dot">●</span><a href="'+str.path+'?num='+num+'">'+ str.page_title + '</li>'
			return text;
		}
	</script>
	<main>
		<div id="content">
			<div id="title">
				<img src="img/graduation.png" alt="">
				<div>졸업논문</div>
			</div>
			<div id="container">
				<div id="tab">
					<ul id="tab_2">
					</ul>
				</div>
				<div id="maincontent">
					<ul>
						<li>
							<div class="contenttitle">졸업논문 백업</div>
						</li>
					</ul>
					<div id="backupbutton" style="margin-top: 10px;">
						<a href="#myModal2" data-toggle="modal" class="btn btn-default col-xl-1" style="display: inline; float:right;">백업</a>
						<button type="button" class="btn btn-default col-xs-1" onclick="searchYear()" style="height: 34px; float:right;">조회</button>
						<select class="inform" id="semester" style="width:100px; float:right;margin: 3px">

						</select>
					</div>

					<table class="boardtable" id="table" data-toggle="table"
								   data-pagination="true" data-filter-controll="true"
								   data-click-to-select="true"
								   data-side-pagination="true" data-page-list="[10]">
					<thead>
					<tr>
						<th data-field="state" data-checkbox="true"></th>
						<th data-field="index" data-sortable="true">번호</th>
						<th data-field="per_id" data-sortable="true">학번</th>
						<th data-field="name" data-sortable="true">이름</th>
						<th data-field="prof_name" data-sortable="true">교수</th>
						<th data-field="graduation_date" data-sortable="true">졸업년도</th>
						<th data-field="graduation_type" data-sortable="true">졸업 종류</th>
					</tr>
					</thead>

				</table>

				</div>
			</div>
		</div>
	</main>
	<%@include file="../main/footer.jsp"%>
	<div class="modal fade" id="myModal2" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">백업</h4>
				</div>
				<div id="howmany2"></div>
				<div class="modal-body" id="loginModal">
					<label>
						아이디<input type="text" id="id"><br>
						비밀번호<input type="password" id="pw">
					</label>
				</div>
				<div class="modal-footer" id="footer2">
					<button type="button" onclick="grd_backup()">백업</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="thesisModal" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">졸업논문 백업 미리보기</h4>
				</div>
				<div class="modal-body" id="thesisModalBody" style="border : 1.5px solid #ddd">

				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="contestModal" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">공모전 백업 미리보기</h4>
				</div>
				<div class="modal-body" id="contestModalBody" style="border : 1.5px solid #ddd">

				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="certificateModal" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">자격증 백업 미리보기</h4>
				</div>
				<div class="modal-body" id="certificateModalBody" style="border : 1.5px solid #ddd">

				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="conferenceModal" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">학술대회 백업 미리보기</h4>
				</div>
				<div class="modal-body" id="conferenceModalBody" style="border : 1.5px solid #ddd">

				</div>
			</div>
		</div>
	</div>

	<script>
		makeboard(tab_2)
		var userList=<%=userList%>;
		var yearList = <%=year%>;

		function grd_backup() {
			var tmp=$('#table').bootstrapTable('getSelections');
			var size=tmp.length; //체크된 리스트의 길이
			//tmp[0].per_id 학번
			var per_id='';
			var id = document.getElementById('id').value;
			var pw = document.getElementById('pw').value;
			if(id=='' || pw==''){
				alert('빈칸을 입력해주세요');
				return;
			}
			for(var i=0;i<size;i++){
				per_id+=tmp[i].per_id;
				per_id+='-/-/-';
			}
			var hash=SHA256(id+pw);
			$.ajax({
				url:"graduate_backup_ajax.do",
				type:"post",
				traditional:true,
				dataType : "json",
				data:{
					users:JSON.stringify(userList),
					data:per_id,
					hashv:hash,
					req:"backup"
				},
				success:function (msg) {
					if(msg=='fail'){
						alert('아이디 비밀번호를 다시 입력해주세요');
					}
					else{
						alert(msg+'명이 백업 되었습니다');
					}
					location.reload();
				}
			})
		}

		function thesisModal(number) {
			var body=$('#thesisModalBody');
			var str='';
			str+='<ul>';
			str+='<li><div style="width:709px;"><div class="profile">이름</div><div class="inform">'+userList[number].name+'</div></div></li>';
			str+='<li><div style="width:709px;"><div class="profile">학번</div><div class="inform">'+userList[number].per_id+'</div></div></li>';
			str+='<li><div style="width:709px;"><div class="profile">지도교수</div><div class="inform">'+userList[number].prof_name+'</div></div></li>';
			str+='<li><div style="width:709px;"><div class="profile">구분</div><div class="inform">'+userList[number].classification+'</div></div></li>';
			str+='<li><div style="width:709px;"><div class="profile">키워드</div><div class="inform">'+userList[number].keyword+'</div></div></li>';
			str+='<li><div style="width:709px;"><div class="profile">제안서</div><div class="inform">'+userList[number].proposal_content+'</div></div></li>';
			str+='<li><div style="width:709px;"><div class="profile">중간보고서</div><div class="inform">'+userList[number].interim_filename+'</div></div></li>';
			str+='<li><div style="width:709px;"><div class="profile">최종보고서</div><div class="inform">'+userList[number].final_filename+'</div></div></li>';
			str+='</ul>';
			body.html(str);
		}
		function certiModol(number) {
			var body=$('#certificateModalBody');
			var str='';
			str+='<ul>';
			str+='<li><div style="width:709px;"><div class="profile">이름</div><div class="inform">'+userList[number].name+'</div></div></li>';
			str+='<li><div style="width:709px;"><div class="profile">학번</div><div class="inform">'+userList[number].per_id+'</div></div></li>';
			str+='<li><div style="width:709px;"><div class="profile">자격증</div><div class="inform">'+userList[number].requirement+'</div></div></li>';
			str+='<li><div style="width:709px;"><div class="profile">자격증 번호</div><div class="inform">'+userList[number].cer_id+'</div></div></li>';
			str+='<li><div style="width:709px;"><div class="profile">발급기관</div><div class="inform">'+userList[number].organization+'</div></div></li>';
			str+='<li><div style="width:709px;"><div class="profile">취득일</div><div class="inform">'+userList[number].acq_date+'</div></div></li>';
			str+='<li><div style="width:709px;"><div class="profile">자격증 사본</div><div class="inform">'+userList[number].cer_filename+'</div></div></li>';
			str+='</ul>';
			body.html(str);

		}
		function contestModal(number) {
			var body=$('#contestModalBody');
			var str='';
			str+='<ul>';
			str+='<li><div style="width:709px;"><div class="profile">이름</div><div class="inform">'+userList[number].name+'</div></div></li>';
			str+='<li><div style="width:709px;"><div class="profile">학번</div><div class="inform">'+userList[number].per_id+'</div></div></li>';
			str+='<li><div style="width:709px;"><div class="profile">공모전명</div><div class="inform">'+userList[number].contest_name+'</div></div></li>';
			str+='<li><div style="width:709px;"><div class="profile">팀유형</div><div class="inform">'+userList[number].team_type+'</div></div></li>';
			str+='<li><div style="width:709px;"><div class="profile">시상내역</div><div class="inform">'+userList[number].contest_content+'</div></div></li>';
			str+='<li><div style="width:709px;"><div class="profile">개최기관</div><div class="inform">'+userList[number].organization+'</div></div></li>';
			str+='<li><div style="width:709px;"><div class="profile">시상일</div><div class="inform">'+userList[number].award_date+'</div></div></li>';
			str+='<li><div style="width:709px;"><div class="profile">대회개최일</div><div class="inform">'+userList[number].open_date+'</div></div></li>';
			str+='<li><div style="width:709px;"><div class="profile">상자사본</div><div class="inform">'+userList[number].award_filename+'</div></div></li>';
			str+='<li><div style="width:709px;"><div class="profile">추가자료</div><div class="inform">'+userList[number].add_filename+'</div></div></li>';
			str+='</ul>';
			body.html(str);
		}
		function confeModal(number) {
			var body=$('#conferenceModalBody');
			var str='';
			str+='<ul>';
			str+='<li><div style="width:709px;"><div class="profile">이름</div><div class="inform">'+userList[number].name+'</div></div></li>';
			str+='<li><div style="width:709px;"><div class="profile">학번</div><div class="inform">'+userList[number].per_id+'</div></div></li>';
			str+='<li><div style="width:709px;"><div class="profile">학술대회명</div><div class="inform">'+userList[number].conference_name+'</div></div></li>';
			str+='<li><div style="width:709px;"><div class="profile">자격요건</div><div class="inform">'+userList[number].requirement+'</div></div></li>';
			str+='<li><div style="width:709px;"><div class="profile">논문제목</div><div class="inform">'+userList[number].thesis_title+'</div></div></li>';
			str+='<li><div style="width:709px;"><div class="profile">개최기관</div><div class="inform">'+userList[number].organization+'</div></div></li>';
			str+='<li><div style="width:709px;"><div class="profile">학회개최일</div><div class="inform">'+userList[number].open_date+'</div></div></li>';
			str+='<li><div style="width:709px;"><div class="profile">논문파일</div><div class="inform">'+userList[number].thesis_filename+'</div></div></li>';
			str+='<li><div style="width:709px;"><div class="profile">기타증빙</div><div class="inform">'+userList[number].proof_filename+'</div></div></li>';
			str+='</ul>';
			body.html(str);

		}

		function insertOption() {
			var select=$('#semester');
			for(var i=0;i<yearList.length;i++){
				var str='<option value='+yearList[i]+'>'+yearList[i]+'</option>';
				select.append(str);
			}
		}
		function insertData() {
			var user=[];
			for(var i=0;i<userList.length;i++){
				var str='';
				var type=userList[i].graduation_type;
				str=getType(type,userList[i].name,i);
				user.push({
					index:i+1,
					per_id:userList[i].per_id,
					name:str,
					prof_name:userList[i].prof_name,
					graduation_date:userList[i].graduation_date,
					graduation_type:userList[i].graduation_type
				});
			}
			return user;
		}
		// '+userData+'
		function getType(type,name,number) {
			var str='';
			if(type=='졸업 논문'){
				str='<a href="#thesisModal" onclick="thesisModal('+number+')" data-toggle="modal">'+name+'</a>';
			}
			else if(type=='공모전'){
				str='<a href="#contestModal" onclick="contestModal('+number+')" data-toggle="modal">'+name+'</a>';
			}
			else if(type=='학술대회'){
				str='<a href="#conferenceModal" onclick="confeModal('+number+')" data-toggle="modal">'+name+'</a>';
			}
			else{
				str='<a href="#certificateModal" onclick="certiModol('+number+')" data-toggle="modal">'+name+'</a>';
			}
			return str;
		}



		function searchYear() {

			var user=[];
			var seme=document.getElementById("semester");
			for(var i=0;i<userList.length;i++){
				if(userList[i].graduation_date==seme.options[seme.selectedIndex].value){
					var str='';
					var type=userList[i].graduation_type;
					str=getType(type,userList[i].name,i);
					user.push({
						index:i+1,
						per_id:userList[i].per_id,
						name:str,
						prof_name:userList[i].prof_name,
						graduation_date:userList[i].graduation_date,
						graduation_type:userList[i].graduation_type
					});
				}

			}
			$('#table').bootstrapTable('removeAll');
			$('#table').bootstrapTable('prepend',user);
		}
		function callSetupTableView(){
			$('#table').bootstrapTable('append',insertData());
			//$('#table').bootstrapTable('refresh');
		}
		$(document).ready(function(){
			insertOption();
			callSetupTableView();
		})
	</script>
</body>
