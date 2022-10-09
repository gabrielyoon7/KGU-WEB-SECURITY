<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
	
	String tabmenulist = (String) request.getAttribute("tabmenulist");
	
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
	<%@include file="../main/header.jsp"%>
	<script>
		function makeboard(id) {
			var list = $(id);
			var arr =
	<%=tabmenulist%>
		;
			for (var i = 0; i < arr.length; i++) {
				var value = arr[i];
				if (value.show_in_menus)
					list.append(makeone(value));
			}
		}
		function makeone(str) {
			var num = str.tab_id * 10 + str.orderNum;
			var text = '<li><span class="deco_dot">●</span><a href="'
					+ str.path + '?num=' + num + '">' + str.page_title
					+ '</li>'
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
						<div class="contenttitle">이전 졸업논문</div>
					</li>
				</ul>
			</div>
		</div>
	</div>
	</main>
	<%@include file="../main/footer.jsp"%>


	<script>
		makeboard(tab_2)
	</script>
</body>