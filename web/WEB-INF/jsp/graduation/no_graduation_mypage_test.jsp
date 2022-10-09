<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
	StringBuffer url2_grd_no_mypage = request.getRequestURL();
	String logo_img_grd_no_mypage;

	//로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
	//ai이면 ai로고 cs이면 cs로고
	if(url2_grd_no_mypage.substring(7,9).equals("ai") || url2_grd_no_mypage.substring(7,9).equals("lo")){
		logo_img_grd_no_mypage = "img/graduation_ai.png";
	}
	else{
		logo_img_grd_no_mypage = "img/graduation.png";
	}
	//System.out.println((logo_img_grd_no_mypage));
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta name="subject"
	content="Kyonggi University Department of Computer Science">
<meta name="author" content="Kyonggi Univ. SSF">
<meta name="keyword"
	content="경기대학교, 컴퓨터과학과, Kyonggi University, Computer Science">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="utf-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<title>경기대학교 AI컴퓨터공학부</title>
<link href='./css/default.css' rel='stylesheet' type='text/css'>
<link href='./css/boardtable.css' rel='stylesheet' type='text/css'>
<link href='./css/content.css' rel='stylesheet' type='text/css'>
<link href='css/bootstrap.css' rel='stylesheet' type='text/css'>
<link href='./css/information.css' rel='stylesheet' type='text/css'>
<link href='css/progress-bar.css' rel='stylesheet' type='text/css'>
<link href='css/step-progress-bar.css' rel='stylesheet' type='text/css'>
<script src="./js/default.js"></script>
<script src="./js/jquery-3.2.1.min.js"></script>
<script src="js/step-progress-bar.js"></script>
<style>
#circle {
	width: 100px;
	height: 100px;
	background: red;
	-moz-border-radius: 50px;
	-webkit-border-radius: 50px;
	border-radius: 50px;
}

table {
	width: 100%;
	margin-top: 40px;
	text-align: center;
}

.graduation_info {
	padding: 5px;
	border: 1px solid #607D8B;
	font-size: 13px;
	display: flex;
	width: 748px;
	margin: auto;
	margin-bottom: 10px;
}

.inform {
	display: inline-block;
	text-align: center;
	width: 250px;
}

.profile {
	display: inline-block;
	margin-right: 5px;
	padding-right: 5px;
	width: 80px;
	text-align: center;
}

.explain {
	display: inline-block;
	border: 1px solid #607D8B;
	margin-right: 5px;
	padding-right: 5px;
	text-align: left;
	width: 380px;
	height: 120px
}

.boardtable>thead>tr>th:nth-child(1), .boardtable>tbody>tr>td:nth-child(1)
	{
	width: 15%;
	text-align: center;
	min-width: 80px;
}

.boardtable>thead>tr>th:nth-child(2), .boardtable>tbody>tr>td:nth-child(2)
	{
	width: 30%;
	text-align: center;
	min-width: 80px;
}

.boardtable>thead>tr>th:nth-child(3), .boardtable>tbody>tr>td:nth-child(3)
	{
	width: 25%;
	text-align: center;
	min-width: 80px;
}

.boardtable>thead>tr>th:nth-child(4), .boardtable>tbody>tr>td:nth-child(4)
	{
	width: 30%;
	text-align: center;
	min-width: 80px;
}

.btn {
	padding: 4px 15px;
	font-size: 12px;
}

.complete_M {
	border: 1px solid #ddd;
	position: absolute;
	width: 400px;
	height: 200px;
	margin-top: 50px;
	margin-left: 165px;
	background-color: white;
	z-index: 6;
	display: none;
}
</style>

</head>
<body>
<%@include file="../main/header.jsp"%>
<main>
<div id="content">
		<div id="title">
			<img src=<%=logo_img_grd_no_mypage%> />
			<div>졸업논문</div>
		</div>
		<div id="container">
				<div id="tab">
				<ul id="tabMenu">
					<c:forEach items="${tabMenu}" var="tab">
						<li><span class="deco_dot">●</span><a
							href="${tab.path}?num=${tab.tab_id * 10 + tab.orderNum}">${tab.page_title}</a></li>
					</c:forEach>
				</ul>
			</div>
			<div id="maincontent">
			<table id="usertable" class="table table-bordered"
					style="font-size: 13px; border: 2px solid #ddd; margin-bottom: 0;">
					<tr style="border-bottom: 1px solid #ddd">
						<td style="background-color: #ECEFF1; font-weight: 600;">학번</td>
						<td>${user.per_id}</td>
						<td style="background-color: #ECEFF1; font-weight: 600;">이름</td>
						<td>${user.name}</td>
						<td style="background-color: #ECEFF1; font-weight: 600;">소속학과</td>
						<c:if test="${reqstudent==null}">
							<td>${user.major}</td>
						</c:if>
						<c:if test="${reqstudent!=null}">				
							<td>${reqstudent.major}</td>
						</c:if>
					</tr>
				</table>
				
				<div>
				<!-- 여기에 상태 -->
				<table class="boardtable" id="statetable">
				<thead>
				<tr>
				<th>단계</th>
				<th>일정</th>
				<th>제출</th>
				<th>비고</th>
				</tr>
				<tr>
				<td>${request.schedule_name}</td>
				<td>${request.starting_date_str}~${request.end_date_str}</td>
				<c:if test="${reqstudent==null}">
				<td><a href="graduation_form.do?per_id=${user.per_id}&num=94&stage=1&modify=0"><button
											type="button" class="btn btn-default">제출가능</button></a></td>
				</c:if>
				<c:if test="${reqstudent!=null}">
				
				<td><a href="graduation_form.do?per_id=${reqstudent.per_id}&num=94&stage=1&modify=1"><button
											type="button" class="btn btn-default">보기</button></a></td>
				</c:if>
				
				<c:if test="${reqstudent==null}">
				<td>제출 가능</td>
				</c:if>
				<c:if test="${reqstudent!=null}">				
				<td>제출 완료</td>
				</c:if>
				</tr>
				</thead>
				</table>				

				</div>
			</div>
		</div>
	</div>
</main>
<%@include file="../main/footer.jsp"%>
	<div id="shadow">
		<div id="blur"></div>
	</div>
</body>
</html>