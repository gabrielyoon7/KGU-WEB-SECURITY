<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta name="subject"
	content="Kyonggi University Department of Computer Science">
<meta name="author" content="Kyonggi Univ. SSF">
<meta name="keyword"
	content="경기대학교, 컴퓨터과학과, Kyonggi University, Computer Science">
<meta name="viewport" content="width=device-width, initial scale=1.0">
<meta charset="utf-8">
<title>경기대학교 AI컴퓨터공학부</title>
<link href='./css/default.css' rel='stylesheet' type='text/css'>
<link href='./css/boardtable.css' rel='stylesheet' type='text/css'>
<link href='./css/content.css' rel='stylesheet' type='text/css'>
<link href='css/bootstrap.css' rel='stylesheet' type='text/css'>
<link href='./css/information.css' rel='stylesheet' type='text/css'>
<script src="./js/default.js"></script>
<script src="./js/jquery-3.2.1.min.js"></script>
<style>
table {
	margin-top: 40px;
}
.graduation_info{
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
	text-align: right;
	width: 200px;
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
}
</style>
</head>
<body>
	<%@include file="../main/header.jsp"%>
	<script>
		function makeboard(id) {
			var list = $(id);
			var arr = [ {
				"name" : "공지사항",
				"link" : ""
			}, {
				"name" : "안내 및 내규",
				"link" : ""
			}, {
				"name" : "진행일정",
				"link" : ""
			}, {
				"name" : "마이페이지",
				"link" : ""
			} ];

			for (var i = 0; i < arr.length; i++) {
				var value = arr[i];
				list.append(makeone(value));
			}
		}
		function makeone(str) {
			return '<li><span class="deco_dot">●</span><a href="'+str.link+'">'
					+ str.name + '</a></li>';
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
						<div class="contenttitle">신청서 제출</div>
					</li>
				</ul>
				<div>
					<div class="graduation_info">
					<div col-md-6><!-- 학생정보 div -->
					<div class="contenttitle2">학생정보</div>
						<ul>
						<li><div class="profile">학번</div>
						<div class="inform"><input type="text" placeholder="학번을 입력해주세요" /></div></li>
						<li><div class="profile">이름</div>
						<div class="inform"><input type="text" placeholder="이름을 입력해주세요" /></div></li>
						<li><div class="profile">소속학과</div>
						<div class="inform"><input type="text" placeholder="예)컴퓨터과학과" /></div></li>
						<li><div class="profile">졸업시기</div>
						<div class="inform"><input type="text" placeholder="예)2017.02" /></div></li>
						<li><div class="profile">신청학기</div>
						<div class="inform"><input type="text" placeholder="예)4학년 1학기" /></div></li>
						</ul>
						</div>
						<div col-md-6><!-- 학생정보 div -->
					<div class="contenttitle2">졸업논문세칙</div>
					<ul>
						<div class="explain" cols="80px" rows="5">
						<ul><li>3월 9일 신청서 제출3월 31일 제안서 제출</li> 
						<li>4월 7일 지도교수확인서 오프라인제출</li>
						<li>9월 20일 중간보고 제출</li>
						<li>11월 10일 최종논문제출 및 지도교수확인서 오프라인제출</li>
						</ul>
						</div>
					</div>
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
makeboard(tab_2)
</script>
</body>
</html>