<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	Integer miss = (Integer) session.getAttribute("miss");
    Integer access = (Integer) session.getAttribute("Access");

    StringBuffer url2_login = request.getRequestURL();
    String img_login_logo;

    //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
    //ai이면 ai로고 cs이면 cs로고
    if(url2_login.substring(7,9).equals("ai") || url2_login.substring(7,9).equals("lo")){
        img_login_logo = "img/ai_logo.png";
    }
    else{
        img_login_logo = "img/cs_logo.png";
    }
%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta name="subject" content="Kyonggi University Department of Computer Science">
    <meta name="author" content="Kyonggi Univ. SSF">
    <meta name="keyword" content="경기대학교, 컴퓨터과학과, Kyonggi University, Computer Science">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="utf-8">
    <link href='css/default.css' rel='stylesheet' type='text/css'>
    <link href='css/login.css' rel='stylesheet' type='text/css'>
    <link href='css/bootstrap.css' rel='stylesheet' type='text/css'>
    <script src="js/sha256.js"></script>
    <title>로그인 : 경기대학교 AI컴퓨터공학부</title>
    <style>
        #wrong_password{
            color: black;
        }
        #information{
        	font-size : 24px;
        }
    </style>
</head>
<body>
<script src="js/default.js"></script>
<script src="js/jquery-3.2.1.min.js"></script>
<script>
	function letsSubmit() {
	if($('#id').val() != '' && $('#password').val() != ''){
	doSha();
    $('#login_form').submit();
}
	else
		alert("빈 칸을 입력해주세요");}

	function doSha(){
		var forsha = $('#id').val() + $('#password').val();
        $('#password_hash').val(SHA256(forsha));

	}


    //url에 따라 버튼 색깔 지정
    window.onload = function () {
        <%
        StringBuffer url3_main = request.getRequestURL();
        if(url3_main.substring(7,9).equals("ai") || url3_main.substring(7,9).equals("lo")){
        %>
        var login_btn_css = document.getElementsByClassName("login_btn");
        for(let i of login_btn_css){
            i.style.background = "#303666";
        }
        <%
            }
        %>
    }
</script>


<main>
    <div id="content">
        <div id="title">
            <div><a href="Index"><img src="<%=img_login_logo%>" alt="" style="width: 300px; margin-bottom : 20px"></a></div>
        </div>
        <div id="information">로그인</div>
        <div>
            <div class="list">
                <div class="loginForm">
                    <form method="POST" action="login.do" id="login_form">
                        <div class="box">
                        	<input type="text" class="form-control" name="id" id="id" placeholder="아이디를 입력하세요." autofocus style="height : 50px;font-size:20px;" required>
                            <br>
                            <input type="submit" onclick="letsSubmit()" style="display:none">
                            <input type="password" class="form-control" name="password" id="password" placeholder="비밀번호를 입력하세요." style="height : 50px;font-size:20px;">
                            <input type="hidden" name="password_hash" id="password_hash" class="iText" value="VALUE_NOT_EMPTY">
                            <br>
                            <p>
                                <span id="wrong_password">초기 비밀번호는 생년월일(YYMMDD)입니다.</span>
                            </p>
                        </div>
                        <a href="#" class="loginBtn" onclick="letsSubmit()" style = "text-decoration: none;">
                            <div class="login_btn">
                            	   로그인
                            </div>
                        </a>
                        <a href="register.do" class="loginBtn" style = "text-decoration:none;">
                        	<div class="login_btn">
                        		회원가입
                        	</div>
                        </a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</main>
       		 <script>
                    	var panel = $('#wrong_password');
                    	var miss = <%=miss%>;
                    	if(miss > 0){
                    		panel.text('잘못된 아이디, 혹은 비밀번호입니다 (' + miss + '회)');
                    		panel.css({'color' : 'red', 'font-weight' : 'bold', 'font-size' : '20px'});
                    	}

                    	var access = <%=access%>
                        if (access==1){ //ai.kyonggi.ac.kr에서 ai권한이 없는 사람이 로그인을 시도할 때
                            alert("AI홈페이지 로그인 권한이 없습니다. 학과 사무실로 문의 바랍니다.")
                        }
                        if (access==2){ //cs.kyonggi.ac.kr에서 ai권한이 있는 사람이 로그인을 시도할 때
                            alert("인공지능전공 홈페이지 (ai.kyonggi.ac.kr)에서 로그인 해주시기 바랍니다.")
                        }
             </script>
</body>
</html>

<%--<!DOCTYPE html>--%>
<%--<html lang="en">--%>
<%--<head>--%>
<%--    <meta charset="utf-8">--%>
<%--    <meta http-equiv="X-UA-Compatible" content="" IE=edge">--%>
<%--    <meta name="viewport" content="width=device-width" , initial-scale="1.0"/>--%>
<%--    <link rel="stylesheet" href="style.css">--%>
<%--    <title>AB대학교 컴퓨터공학과 로그인</title>--%>
<%--    <style>--%>
<%--        * {--%>
<%--            background-color: #dadacf;--%>
<%--        }--%>

<%--        .logo {--%>
<%--            width: 600px;--%>
<%--            height: 230px;--%>
<%--        }--%>

<%--        .text1 {--%>
<%--            font-size: 34px;--%>
<%--            font-family: sans-serif;--%>
<%--            margin-top: 30px;--%>
<%--            color: #4F4F4FFF;--%>
<%--            display: flex;--%>
<%--            justify-content: center;--%>
<%--        }--%>

<%--        .container1 {--%>
<%--            margin-top: 100px;--%>
<%--            position: relative;--%>
<%--            display: flex;--%>
<%--            justify-content: center;--%>
<%--        }--%>

<%--        .container2 {--%>
<%--            position: relative;--%>
<%--            display: flex;--%>
<%--            justify-content: center;--%>
<%--        }--%>

<%--        #userId {--%>
<%--            width: 800px;--%>
<%--            height: 110px;--%>
<%--            font-weight: 500;--%>
<%--            padding-left: 20px;--%>
<%--            margin-bottom: 10px;--%>
<%--            background-color: white;--%>
<%--            border: 0;--%>
<%--            font-size: 38px;--%>
<%--            border-radius: 8px;--%>
<%--            border-style: groove;--%>
<%--            border-color: rgb(230, 230, 230);--%>
<%--        }--%>

<%--        #password {--%>
<%--            width: 800px;--%>
<%--            height: 110px;--%>
<%--            font-weight: 500;--%>
<%--            padding-left: 20px;--%>
<%--            margin-bottom: 20px;--%>
<%--            background-color: white;--%>
<%--            border: 0;--%>
<%--            font-size: 38px;--%>
<%--            border-radius: 8px;--%>
<%--            border-style: groove;--%>
<%--            border-color: rgb(230, 230, 230);--%>
<%--        }--%>

<%--        #send {--%>
<%--            width: 400px;--%>
<%--            height: 100px;--%>
<%--            background-color: #0D4B3CFF;--%>
<%--            color: white;--%>
<%--            font-size: 38px;--%>
<%--            border: 0px;--%>
<%--            border-radius: 10px;--%>
<%--        }--%>

<%--        #new {--%>
<%--            width: 400px;--%>
<%--            height: 100px;--%>
<%--            background-color: #0D4B3CFF;--%>
<%--            color: white;--%>
<%--            font-size: 38px;--%>
<%--            border: 0px;--%>
<%--            border-radius: 10px;--%>
<%--        }--%>
<%--    </style>--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="container1">--%>
<%--    <form>--%>
<%--        <div style="text-align: center;">--%>
<%--            <img src='https://ifh.cc/g/yyGY7N.jpg' class="logo">--%>
<%--        </div>--%>
<%--        <h4 class="text1">로그인</h4>--%>
<%--        <div class="login_cont">--%>
<%--            <p class=""><input type="text" placeholder="아이디를 입력하세요." id="userId"/>--%>
<%--            <p class=""><input type="password" placeholder="비밀번호를 입력하세요." id="password"/>--%>
<%--            <h4 class="text1">초기 비밀번호는 생년월일(YYMMDD)입니다.</h4>--%>
<%--        </div>--%>
<%--    </form>--%>
<%--</div>--%>
<%--<div class="container2" style="text-align: center">--%>
<%--    <div style="display: inline-block; margin-right:10px;">--%>
<%--        <input type="submit" value="로그인" id="send"/>--%>
<%--    </div>--%>
<%--    <div style="display: inline-block">--%>
<%--        <input type="submit" value="회원가입" id="new"/>--%>
<%--    </div>--%>
<%--</div>--%>
<%--<script src="index.js"></script>--%>
<%--<hr style="margin-top: 50px; color: black;">--%>
<%--</body>--%>
<%--</html>--%>