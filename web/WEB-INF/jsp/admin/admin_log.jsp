<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
   StringBuffer url2_admin_log = request.getRequestURL();
   String logo_img_admin_log;

   //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
   //ai이면 ai로고 cs이면 cs로고
   if(url2_admin_log.substring(7,9).equals("ai") || url2_admin_log.substring(7,9).equals("lo")){
      logo_img_admin_log = "img/notice_ai.png";
   }
   else{
      logo_img_admin_log = "img/notice.png";
   }
   //System.out.println((logo_img_admin_log));
%>
<% 
String tabmenulist=(String) request.getAttribute("tabmenulist");//관리자탭메뉴
String logs = (String) request.getAttribute("logs"); // 로그 텍스트
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="utf-8">
<title>로그확인 : 경기대학교 AI컴퓨터공학부</title>
<link rel="stylesheet" href="css/bootstrap-table.css">
<link href='css/bootstrap.css' rel='stylesheet' type='text/css'>
<link href='css/default.css' rel='stylesheet' type='text/css'>
<link href='css/boardtable.css' rel='stylesheet' type='text/css'>
<link href='css/information.css' rel='stylesheet' type='text/css'>
<link href='css/content.css' rel='stylesheet' type='text/css'>
<style>
#maincontent {
   padding: 0;
}

#maincontent>ul {
   padding: 10px;
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
   <main>
   <div id="content">
      <div id="title">
         <img src=<%=logo_img_admin_log%> />
         <div>관리 페이지</div>
      </div>
      <div id="container">
         <div id="tab">
            <ul id="tab_2">
            </ul>
         </div>
         <div id="maincontent">
            <ul>
               <li>
                  <div class="contenttitle">로그 확인</div>
               </li>
            </ul>
            <div id="for_log">
            	<label style="font-size : 14px"> ※로그에는 회원가입, 관리자 추가, 로그인 기록이 남습니다. 로그가 길어질 시 서버에 영향을 줄 수 있습니다.</label>
            	 <div class="form-group" style="width : auto; overflow : auto">
                   		<textarea class="form-control" id="logs" rows=30 placeholder="로그가 비어있습니다." readonly></textarea>
                 </div>
            </div>
            <button class="btn btn-default" style="float : right; margin-bottom : 10px;" onclick="deleteLog()">로그삭제</button>
         </div>
      </div>
   </div>
   </main>
   <%@include file="../main/footer.jsp"%>
   
   <script>
   var arr = <%=tabmenulist%>;
   for (var i = 0; i < arr.length; i++) {
      var value = arr[i];
      if(value.show_in_menus)
      	$('#tab_2').append(makeone(value));
   }
   
   function makeone(str) {
      	var num=str.tab_id*10+str.orderNum;
      	var text = '<li><span class="deco_dot">●</span><a href="'+str.path+'?num='+num+'">'+ str.page_title + '</li>'
      	return text;
      }
   
   var logs = <%=logs%>;
   var logText = '';
   for(var i = 0 ; i < logs.length ; ++i)
	   logText += logs[i] + '\n';
   $('#logs').val(logText);
                
   function deleteLog(){
	   $.ajax({
		   url : 'ajax.do',
		   type : 'post',
		   data : {
			   req : 'deleteLog',
			   data : ''
		   },
		   success : function(data){
				if(data == "success"){
					window.location.href = 'admin.do?num=85';
				}   else{
					alert('SERVER ERROR, Please try again later...');
				}
		   }
	   });
   }
   </script>
</body>
</html>