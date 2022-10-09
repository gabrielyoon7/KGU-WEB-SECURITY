<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
   String text = (String) request.getAttribute("text");
%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="utf-8">
    <title>제작진 : 경기대학교 AI컴퓨터공학부</title>
    <link href="css/bootstrap.css" rel="stylesheet" type ="text/css">
    <link href='css/default.css' rel='stylesheet' type='text/css'>
    <link href='css/boardtable.css' rel='stylesheet' type='text/css'>
    <link href='css/information.css' rel='stylesheet' type='text/css'>
    <link href='css/content.css' rel='stylesheet' type='text/css'>
    <style>

    </style>
</head>
<body>
<script src="js/default.js"></script>
<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/jquery.cookie.js"></script>
<%@include file="header.jsp" %>
<main>
    <div id="content">
        <div id="title">
            <div>컴퓨터공학부 웹 공부 및 개발팀</div>
        </div>
        <div id="container">
            <div id="maincontent">
            	<ul>
	               	<li style="font-size : 15px; font-weight : 600"><p> CS-HOME 1기 : 16학번 김성빈 외 3명</p></li>
    	           <li style="font-size : 15px; font-weight : 600"><p> CS-HOME 2기 : 14학번 강경웅 김건욱 박지산 변중연 (18.01.01 ~ 18.03.01)</p></li>
    	           <li style="font-size : 15px; font-weight : 600"><p> CS-HOME 3기 : 17학번 이종훈 최동주 (19.01.01 ~ 19.03.01)</p></li>
                    <li style="font-size : 15px; font-weight : 600"><p> CS-HOME 4기 : 15학번 김주형 (20.01.01 ~ 20.03.01)</p></li>
                    <hr>
                    <li style="font-size : 15px; font-weight : 600">
                        <div>CS-HOME 5기</div>
                        <div>- 주요 작업</div>
                        <div>>> 인공지능전공(ai.kyonggi.ac.kr) 홈페이지 작업(21.01.01~21.02.28)</div>
                        <div>- 팀 원</div>
                        <div>[20.10.31 ~ 21.03.01]  16학번 박민수 / 16학번 이석근 / 17학번 <a href="https://github.com/gabrielyoon7">윤주현</a> (팀장) /  19학번 박채영 </div>
                    </li>
                    <hr>
                    <li style="font-size : 15px; font-weight : 600">
                        <div>CS-HOME 6기</div>
                        <div>- 주요 작업</div>
                        <div>>> 사물함 관리 프로젝트(21.03.02~21.06.31)</div>
                        <div>>> <a href="http://swaig.kyonggi.ac.kr:8080">SWAIG홈페이지</a> 작업(21.07.01~21.08.31)</div>
                        <div>>> 졸업요건진단시스템 프로젝트(21.09.01~21.12.31) </div>
                        <div>- 팀 원</div>
                        <div>[21.03.02 ~ 21.12.31] 17학번 <a href="https://github.com/gabrielyoon7">윤주현</a> (팀장) / 19학번 박선애 / 19학번 박소영 </div>
                        <div>[21.03.02 ~ 21.08.31] 19학번 박의진</div>
                        <div>[21.07.01 ~ 21.12.31] 19학번 김가영</div>
                    </li>
                    <li style="font-size : 15px; font-weight : 600">
                        <div>CS-HOME 7기</div>
                        <div>- 주요 작업</div>
                        <div>>> </div>
                        <div>- 팀 원</div>
                        <div>[21.12.01 ~ ]  </div>
                    </li>
               </ul>
               
               <div id="madeTime" style="text-align : center; font-size : 15px; margin-top : 20px">
               
               </div>
               
               <div style="text-align : center; font-size : 30px; font-weight : 700; margin-top : 50px">
               Thanks
               </div>
            </div>
        </div>
    </div>
</main>
<script>
	var Today = new Date();
	var madeDay = new Date('2018-03-01');
	var times = Today.getTime() - madeDay.getTime();
	
	$('#madeTime').html('현재 이 사이트의 오픈으로부터... <span style="color : red">' + Math.ceil(new Date(times)/1000/24/60/60) + "</span>일!");

</script>
<%@include file="footer.jsp" %>
<div id="shadow">
    <div id="blur"></div>
</div>
</body>
</html>