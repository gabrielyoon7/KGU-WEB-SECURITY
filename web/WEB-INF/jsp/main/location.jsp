<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String text = (String) request.getAttribute("text");
%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="utf-8">
    <title>오시는 길 및 연락처 : 경기대학교 AI컴퓨터공학부</title>
    <link href="css/bootstrap.css" rel="stylesheet" type ="text/css">
    <link href='css/default.css' rel='stylesheet' type='text/css'>
    <link href='css/boardtable.css' rel='stylesheet' type='text/css'>
    <link href='css/information.css' rel='stylesheet' type='text/css'>
    <link href='css/content.css' rel='stylesheet' type='text/css'>
    <style>
        #container {
            display: flex;
            flex-direction: column;
        }

        #maincontent {
            display: flex;
            padding: 0;
        }

        #maincontent > ul {
            padding: 10px;
            min-width: 150px;
        }
        #map{
            height:600px;
        }
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
            <img src="img/map.png" alt="">
            <div>연락처 및 오시는 길</div>
        </div>
        <div id="container">
            <div id="maincontent">
            </div>
        </div>
    </div>
</main>
<script>
	var panel = $('#maincontent');
	var text = <%=text%>;
	panel.append(text.content);
</script>
<%@include file="footer.jsp" %>
<div id="shadow">
    <div id="blur"></div>
</div>
</body>
</html>
