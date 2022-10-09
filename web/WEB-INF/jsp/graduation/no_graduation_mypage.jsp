<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
	String num = (String) request.getAttribute("num");
	String tabmenulist = (String) request.getAttribute("tabmenulist");//관리자탭메뉴
	String schedulelist = (String) request.getAttribute("schedulelist");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta name="subject" content="Kyonggi University Department of Computer Science">
<meta name="author" content="Kyonggi Univ. SSF">
<meta name="keyword" content="경기대학교, 컴퓨터과학과, Kyonggi University, Computer Science">
<meta name="viewport" content="width=device-width, initial scale=1.0">
<meta charset="utf-8">
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
width:100%;
	margin-top: 40px;
	 text-align:center;
}
.graduation_info {
	padding: 5px;
	border: 1px solid #607D8B;
	font-size: 13px;
	display: flex;
	width: 748px;
	margin: auto;
	margin-bottom: 10px;
	margin-top: 20px;
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
.boardtable>thead>tr>th:nth-child(1), .boardtable>tbody>tr>td:nth-child(1)  {
   width: 150px;text-align:center;min-width:150px;
}
.boardtable>thead>tr>th:nth-child(2), .boardtable>tbody>tr>td:nth-child(2) {
   width: 300px; text-align:center; min-width:300px;
}
.boardtable>thead>tr>th:nth-child(3), .boardtable>tbody>tr>td:nth-child(3) {
	width: 300px; text-align:center; min-width:300px;
  
}

</style>

</head>
<body>
	<%@include file="../main/header.jsp"%>
	<script>
		
	</script>
	<main>
	<div id="content">
		<div id="title">
			<img src="img/graduation.png" alt="">
			<div>졸업논문</div>
		</div>
		<div id="container">
			<div id="tab">
				<ul id="tabMenu">
				</ul>
			</div>
			<div id="maincontent">
			<div class = "graduation_info">
			<div class="col-md-12" id="usertable">
					<!-- javascript으로 이동 -->
				</div>
				</div>
				<div class="container" style="padding-left:0px">
					<div class="wrapper">
						<div class="arrow-steps clearfix">
							<div class="step current">
								<span> 신청서</span>
							</div>
							<div class="step">
								<span>제안서</span>
							</div>
							<div class="step">
								<span> 중간보고서</span>
							</div>
							<div class="step">
								<span>최종보고서</span>
							</div>
						</div>
				
					</div>
				</div>
				<div id="grd_state">
					<!-- 일정안내 -->
				</div>
				<div>
				<table class="boardtable" id="statetable">
				
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
	<script>
	$(document).ready(function() {
		setschedule();
		alertcheck();
	})
		var list = $('#tabMenu');
		var tabmenu =<%=tabmenulist%>;
		var number =<%=num%>;
		for (var i = 0; i < tabmenu.length; ++i) {
			var value = tabmenu[i];
			var num = value.tab_id * 10 + value.orderNum;
			var text = '<li><span class="deco_dot">●</span><a href="'
					+ value.path + '?num=' + num + '">' + value.page_title
					+ '</a></li>'
			list.append(text);
		}

		var table = $('#usertable');
		var user =<%=user%>;
		table.append(usertable(user));
		function usertable(user){
			var a = '';
			if(user.per_id==null)
				{
				a += '<ul><li>학번  없음 </li>';
				a += '<li>이름 ' + user.name + '</li>';
				a += '<li>소속학과  없음 </li></ul>';
				}
			else{
				a += '<ul><li>학번 ' + user.per_id + '</li>';
				a += '<li>이름 ' + user.name + '</li>';
				a += '<li>소속학과 ' + user.major + '</li></ul>';
			}
			return a;
		}

		function setschedule(){
			var table = $('#statetable');
			var arr = <%=schedulelist%>;
			var user =  <%=user%>;
			table.append('<thead><tr><th>단계구분</th><th>제출일정</th><th>파일제출</th></tr></thead>');//head부분
			table.append('<tbody>');
			table.append('<tr><td>'+arr[0].schedule_name+'</td><td>'+formatData(arr[0].starting_date)+'~'+formatData(arr[0].closing_date)+'</td><td><a href="graduation_form.do?per_id='+user.per_id+'&num=94&stage=1&modify=0"><button type="button" class="btn btn-default">제출</button></a></td></tr>');
			table.append('</tbody>');
		}
		function formatData(date) {
	         var d = new Date(date), month = '' + (d.getMonth() + 1), day = ''
	               + d.getDate(), year = d.getFullYear();

	         if (month.length < 2)
	            month = '0' + month;
	         if (day.length < 2)
	            day = '0' + day;

	         return [ year, month, day ].join('-');
	      }
		
		function alertcheck(){
			alert("졸업대상자가 아닙니다.\n신청서접수를 먼저해주세요!");
		}
		
		</script>/
</body>
</html>