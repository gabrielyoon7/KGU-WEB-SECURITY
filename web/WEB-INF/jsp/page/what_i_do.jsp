<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
	StringBuffer url2_what_i_do = request.getRequestURL();
	String logo_img_what_i_do;

	//로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
	//ai이면 ai로고 cs이면 cs로고
	if(url2_what_i_do.substring(7,9).equals("ai") || url2_what_i_do.substring(7,9).equals("lo")){
		logo_img_what_i_do = "img/student_ai.png";
	}
	else{
		logo_img_what_i_do = "img/student.png";
	}
	//System.out.println((logo_img_what_i_do));
%>
<%
	String notice_notes = (String) request.getAttribute("notice_notes");
	String webzine_notes = (String) request.getAttribute("webzine_notes");
	String gallery_notes = (String) request.getAttribute("gallery_notes");
	
	String notice_comments = (String) request.getAttribute("notice_comments");
	String webzine_comments = (String) request.getAttribute("webzine_comments");
	String gallery_comments = (String) request.getAttribute("gallery_comments");

	String likeNotes = (String) request.getAttribute("likeNotes");
	String answers = (String) request.getAttribute("answers");
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
<title>활동내역 : 경기대학교 AI컴퓨터공학부</title>
<link href='css/bootstrap.css' rel='stylesheet' type='text/css'>
<link href="css/bootstrap-table.css" rel="stylesheet" > 
<link href='css/default.css' rel='stylesheet' type='text/css'>
<link href='css/information.css' rel='stylesheet' type='text/css'>
<link href='css/content.css' rel='stylesheet' type='text/css'>
<script src="js/default.js"></script>
<script src="js/jquery-3.2.1.min.js"></script>
<style>
#text {
	font-size: 13px;
}

.form-control {
	display: inline-block;
}

.inform {
	display: inline-block;
	text-align: right;
	width: 270px;
}

.profile {
	display: inline-block;
	margin-right: 10px;
	border-right: solid 1px black;
	padding-right: 10px;
	width: 140px;
	text-align: center;
}

#panel1 {
	width: 240px;
	display: inline-block;
	vertical-align: top;
}

#panel2 {
	width: 420px;
	display: inline-block;
}

#panel {
	border-top: solid 1px black;
	padding-top: 10px;
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

table > thead > tr > th:nth-child(1), table > tbody > tr > td:nth-child(1) {
    min-width: 100px;
    max-width: 100px;
    width: 100px;
}

table > thead > tr > th:nth-child(2), table > tbody > tr > td:nth-child(2) {
    min-width: 400px;
    max-width: 400px;
    width: 400px;
}

#maincontent ul {
	padding : 0;
	padding-top : 10px;
}

.table{
	font-size : 14px;
}

.th-inner {
	text-align : center;
}

td {
	text-align : center;
}
</style>
</head>
<body>
	<%@include file="../main/header.jsp"%>
	<main>
	<div id="content">
		<div id="title">
			<img src=<%=logo_img_what_i_do%> />
			<div id="titlename">마이 페이지</div>
		</div>
		<div id="container">
			<div id="tab">
				<ul id="tabMenu">
					<li><span class="deco_dot">●</span><a href="goMyPage.do">회원정보</a></li>
					<li><span class="deco_dot">●</span><a href="goChangePassword.do">비밀번호변경</a></li>
					<li><span class="deco_dot">●</span><a href="goWhatIDo.do">활동내역</a></li>
				</ul>
			</div>
			<div id="maincontent">
				<ul>
					<li id="maintext" style="margin-bottom: 5px;">
						<div id="maintitle" class="contenttitle">활동내역</div>
						<ul id="text1">
						</ul>
					</li>
				</ul>
				<ul>
					<li id="maintext">
						<div id="maintitle" class="contenttitle">작성글</div>
					</li>
				</ul>
				<table id="table1" data-toggle="table" data-pagination="true" data-search="true" data-page-list="[10]">
               		<thead>
                  		<tr>
                      		<th data-field="board_id" data-sortable="true">번호</th>
                      		<th data-field="title" data-sortable="true">제목</th>
                      		<th data-field="last_modified" data-sortable="true">작성일</th>
                      		<th data-field="views" data-sortable="true">조회수</th>
                 		</tr>
               		</thead>
            	</table>
            	<ul>
					<li id="maintext">
						<div id="maintitle" class="contenttitle">추천한 글</div>
					</li>
				</ul>
				<table id="table2" data-toggle="table" data-pagination="true" data-search="true" data-page-list="[10]">
               		<thead>
                  		<tr>
                      		<th data-field="board_id" data-sortable="true">번호</th>
                      		<th data-field="title" data-sortable="true">제목</th>
                      		<th data-field="last_modified" data-sortable="true">작성일</th>
                      		<th data-field="views" data-sortable="true">추천수</th>
                 		</tr>
               		</thead>
            	</table>
				<ul>
					<li id="maintext">
						<div id="maintitle" class="contenttitle">작성 댓글</div>
					</li>
				</ul>
				<table id="table3" data-toggle="table" data-pagination="true" data-search="true" data-page-list="[10]">
               		<thead>
                  		<tr>
                      		<th data-field="board_id" data-sortable="true">번호</th>
                      		<th data-field="title" data-sortable="true">글 제목</th>
                      		<th data-field="last_modified" data-sortable="true">작성일</th>
                      		<th data-field="views" data-sortable="true">조회수</th>
                 		</tr>
               		</thead>
            	</table>
				<ul>
					<li id="maintext">
						<div id="maintitle" class="contenttitle">신청내역</div>
					</li>
				</ul>
				<table id="table4" data-toggle="table" data-pagination="true" data-search="true" data-page-list="[10]">
               		<thead>
                  		<tr>
                      		<th data-field="board_id" data-sortable="true">번호</th>
                      		<th data-field="title" data-sortable="true">제목</th>
                      		<th data-field="last_modified" data-sortable="true">기간</th>
                 		</tr>
               		</thead>
            	</table>
			</div>
		</div>
	</div>
				 </main>
	<%@include file="../main/footer.jsp"%>
	<div id="shadow">
		<div id="blur"></div>
	</div>
<script src="js/bootstrap-table.js"></script>
<script src="js/bootstrap-table-cookie.js"></script>
<script>
var notice_notes = <%=notice_notes%>;
var webzine_notes = <%=webzine_notes%>;
var gallery_notes = <%=gallery_notes%>;
var notice_comments = <%=notice_comments%>;
var webzine_comments = <%=webzine_comments%>;
var gallery_comments = <%=gallery_comments%>;
var likeNotes = <%=likeNotes%>;
var answers_notes = <%=answers%>;

function formatDate(date) {
    var d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;

    return [year, month, day].join('-');
} 


function callSetupTableView(){
    $('#table1').bootstrapTable('append',data1());
    $('#table1').bootstrapTable('refresh');
    $('#table2').bootstrapTable('append',data2());
    $('#table2').bootstrapTable('refresh');
    $('#table3').bootstrapTable('append',data3());
    $('#table3').bootstrapTable('refresh');
    $('#table4').bootstrapTable('append',data4());
    $('#table4').bootstrapTable('refresh');
 }

function data1(){
	var rows = [];
	var sequence = 1;
	for(var i = 0 ; i < notice_notes.length ; ++i){
		var value = notice_notes[i];
		var num;
		if(value.category == 41) num = 42;
		if(value.category == 46) num = 44;
		else num = 43;
		rows.push({
            board_id: sequence,
            title: '<a href="notice_article_reader.do?id=' + value.id + '&num=' + num + '">' + value.title + ' <span style="font-size : 11px">[' + value.comments_count + ']</span></a>',
            last_modified: formatDate(value.last_modified),
            views: value.views
         });
		sequence++;
	}
	for(var i = 0 ; i < webzine_notes.length ; ++i){
		var value = webzine_notes[i];
		var num;
		if(value.category == 72) num = 61;
		if(value.category == 73) num = 62;
		else num = 63;
		rows.push({
            board_id: sequence,
            title: '<a href="webzine_reader.do?id=' + value.id + '&num=' + num + '">' + value.title + ' <span style="font-size : 11px">[' + value.comments_count + ']</span></a>',
            last_modified: formatDate(value.last_modified),
            views: value.views
         });
		sequence++;
	}
	for(var i = 0 ; i < gallery_notes.length ; ++i){
		var value = gallery_notes[i];
		rows.push({
            board_id: sequence,
            title: '<a href="gallery_board_reader.do?id=' + value.id + '&num=73">' + value.title + ' <span style="font-size : 11px">[' + value.comments_count + ']</span></a>',
            last_modified: formatDate(value.last_modified),
            views: value.views
         });
		sequence++;
	}
	return rows;
}

function data2(){
	var rows = [];
	for(var i = 0 ; i < likeNotes.length ; ++i){
		var value = likeNotes[i];
		var num;
		if(value.category == 72) num = 61;
		if(value.category == 73) num = 62;
		else num = 63;
		rows.push({
            board_id: (i+1),
            title: '<a href="webzine_reader.do?id=' + value.id + '&num=' + num + '">' + value.title + ' <span style="font-size : 11px">[' + value.comments_count + ']</span></a>',
			last_modified : formatDate(value.last_modified),
			views : value.likes
		});
		
	}
	return rows;
}

function data3(){
	var rows = [];
	var sequence = 1;
	for(var i = 0 ; i < notice_comments.length ; ++i){
		var value = notice_comments[i];
		var num;
		if(value.category == 41) num = 42;
		if(value.category == 46) num = 44;
		else num = 43;
		rows.push({
            board_id: sequence,
            title: '<a href="notice_article_reader.do?id=' + value.id + '&num=' + num + '">' + value.title + ' <span style="font-size : 11px">[' + value.comments_count + ']</span></a>',
            last_modified: formatDate(value.last_modified),
            views: value.views
         });
		sequence++;
	}
	for(var i = 0 ; i < webzine_comments.length ; ++i){
		var value = webzine_comments[i];
		var num;
		if(value.category == 72) num = 61;
		if(value.category == 73) num = 62;
		else num = 63;
		rows.push({
            board_id: sequence,
            title: '<a href="webzine_reader.do?id=' + value.id + '&num=' + num + '">' + value.title + ' <span style="font-size : 11px">[' + value.comments_count + ']</span></a>',
            last_modified: formatDate(value.last_modified),
            views: value.views
         });
		sequence++;
	}
	for(var i = 0 ; i < gallery_comments.length ; ++i){
		var value = gallery_comments[i];
		rows.push({
            board_id: sequence,
            title: '<a href="gallery_board_reader.do?id=' + value.id + '&num=73">' + value.title + ' <span style="font-size : 11px">[' + value.comments_count + ']</span></a>',
            last_modified: formatDate(value.last_modified),
            views: value.views
         });
		sequence++;
	}
	return rows;
}

function data4(){
	var rows = [];
	for(var i = 0 ; i < answers_notes.length ; ++i){
		var value = answers_notes[i];
		rows.push({
			board_id : (i+1),
            title: '<a href="req_article_reader.do?id=' + value.id + '">' + value.title + '</a>',
			last_modified : formatDate(value.starting_date) + '~' + formatDate(value.closing_date)
		});
	}
	return rows;
}

$('#text1').append('<div style="font-size : 14px">지금까지 <span style="color : red; font-size : 22px">' + (notice_notes.length + webzine_notes.length + gallery_notes.length) + '</span>개의 글, <span style="color : red; font-size : 22px">' + (notice_comments.length + webzine_comments.length + gallery_comments.length) + '</span>개의 댓글, <span style="color : red; font-size : 22px">' + (likeNotes.length) + '</span>개의 추천, <span style="color : red; font-size : 22px">' + (answers_notes.length) + '</span>개의 신청을 하셨습니다.</div>');

$(function(){
	callSetupTableView();	
});
</script>
				
</body>
</html>