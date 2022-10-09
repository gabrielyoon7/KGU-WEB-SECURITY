<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%  
	String bigMenu= (String) session.getAttribute("headermenulist");
	String smallMenu= (String) session.getAttribute("menulist");
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="utf-8">
<title>사이트맵 : 경기대학교 AI컴퓨터공학부</title>
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
	min-height: 300px;
	display: flex;
	padding: 0;
}

#maincontent>ul {
	padding: 10px;
	min-width: 150px;
}

#maincontent>ul>li>ul {
	border: none;
}
</style>
</head>
<body>
	<script src="js/default.js"></script>
	<script src="js/jquery-3.2.1.min.js"></script>
	
	<%@include file="header.jsp"%>
	<main>
	<div id="content">
		<div id="title">
			<img src="img/map.png" alt="">
			<div>사이트맵</div>
		</div>
		<div id="container">
		</div>
	</div>
	</main>
	<%@include file="footer.jsp"%>
	<div id="shadow">
		<div id="blur"></div>
	</div>
 <script>
 	var sequence = 0;
	var tabs=<%=bigMenu%>;
	var pages=<%=smallMenu%>;
	var container = $('#container');
	for(var i=1;i<=7;i++){
		if(i % 4 == 1){
			sequence++;
			container.append('<div id="maincontent" class="maincontent'+ sequence +'"></div>');
		}
		var main = $('.maincontent'+sequence);
		var value1=tabs[i-1];
		main.append('<ul style="margin-left : 45px"><li><div class="contenttitle">'+value1.tab_title+'</div><ul id="site'+ i +'">');
		for(var j = 0 ; j < pages.length ; j++){
		var value2=pages[j];
		var mainsite = $('#site'+i);
		if(value2.tab_id==i && value2.show_in_menus){//이거 다르게 바꾸고싶음 
			var num = value2.tab_id*10+value2.orderNum;
			if(value2.page_title == '졸업논문')
				var text = '<li><a href="'+value2.path+'">'
				+ value2.page_title + '</a></li>';
			else
				var text = '<li><a href="' + value2.path + '?num=' + num + '">' + value2.page_title + '</a></li>';
			mainsite.append(text);
		}
	}
		main.append('</li></ul>');
	}
</script>
</body>
</html>
