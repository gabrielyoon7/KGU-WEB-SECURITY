<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String user = (String) session.getAttribute("user");
	response.setHeader("cache-control","no-cache");
	response.setHeader("expires","0");
	response.setHeader("pragma","no-cache");
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
    <title>비밀번호 변경 : 경기대학교 AI컴퓨터공학부</title>
    <style>
    	#warning{
    	
    	}
    </style>
</head>
<body>
<script src="js/default.js"></script>
<script src="js/jquery-3.2.1.min.js"></script>

<main>
    <div id="content">
        <div id="title">
            <div><a href="Index"><img src="img/cslogo_black.png" alt="" style="width: 350px;"></a></div>
        </div>
        <div id="information">비밀번호 변경</div>
        <div>
            <div class="list">
                <div class="loginForm">
                    <form method="POST" action="changePassword.do" id="login_form">
                        <div class="box">
                       		<input type="text" class="form-control" name="name" id="name" style="height : 50px;font-size:20px;" readonly>
                        	<input type="password" class="form-control" name="password" id="password" placeholder="원래 비밀번호를 입력하세요." style="height : 50px;font-size:20px;">
							<input type="password" class="form-control" name="password" id="newPassword" placeholder="새로운 비밀번호를 입력하세요." style="height : 50px;font-size:20px;">
							<input type="password" class="form-control" name="password" id="newPasswordCheck" placeholder="한번 더 입력하세요." style="height : 50px;font-size:20px;">
                            <input type="hidden" name="password_hash" id="password_hash1" class="iText" value="VALUE_NOT_EMPTY">
                            <input type="hidden" name="password_hash2" id="password_hash2" class="iText" value="VALUE_NOT_EMPTY">
                            <input type="hidden" name="id" id="id" class="iText" value="VALUE_NOT_EMPTY">
                                <br><span id="warning">새로운 비밀번호는 8자 이상,영문,숫자,특수기호가 포함되어야 합니다</span><br>
                                <span id="warning">사용 가능한 특수문자 : !,@,#,$,%,^,&,*,(,)</span>
                        </div>
                        <a class="loginBtn" onclick="letsSubmit()" style = "text-decoration: none;">
                            <div id="login_btn">
                            	   변경하기
                            </div>
                        </a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</main>
       		<script>
       	$('#name').val(<%=user%>.name);
    	$('#id').val(<%=user%>.id);
    	var pattern = [];
		var pattern1 = '0123456789';
		 	pattern2 = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
		 	pattern3 = '!@#$%^&*()';
		pattern.push(pattern1);
		pattern.push(pattern2);
		pattern.push(pattern3);

		function letsSubmit() {

			if($('#password').val() != '' && $('#newPassword').val() != '' && $('#newPasswordCheck').val() != ''){
				var passwordSalt = $('#id').val() + $('#password').val();
				$('#password_hash1').val(SHA256(passwordSalt));
				var password = $('#password_hash1').val();
				var data = password + "-/-/-" + <%=user%>.id;
				$.ajax({
					url:"ajax.do",
					type:"post",
					async : false,
					data:{
						req:"checkPassword",
						data:data
					},
					success:function(data){
						if(data == 'true'){
							if($('#newPasswordCheck').val() == $('#newPassword').val() && check()){
								var newPasswordSalt = $('#id').val() + $('#newPassword').val();
								$('#password_hash2').val(SHA256(newPasswordSalt));
								$('#login_form').submit();
					 		   }
							else if($('#newPassword').val() != $('#newPasswordCheck').val()){
									$('#warning').text("비밀번호 확인이 정확하지 않습니다");
									$('#warning').css("color", "red");
								}
							else if(!check()){
									$('#warning').text("새로운 비밀번호는 8자 이상,영문,숫자,특수기호가 포함되어야 합니다");
									$('#warning').css("color", "red");
								}
							}
						else{
								$('#warning').text("현재 비밀번호가 정확하지 않습니다.");
								$('#warning').css("color", "red");

						}
					}
				})
			}
			else{
				$('#warning').text("빈 칸을 입력해주세요.");
				$('#warning').css("color", "red");
				}
		}
		
		function check(){
			var password = $('#newPassword').val();
			var isOK1 = 0;
	 		var isOK2 = 0;
	 		var isOK3 = 0;
	 		for(var i = 0; i < password.length ; ++i){
	 			if(pattern[0].indexOf(password[i]) >= 0)
	 				isOK1 = 1;
	 			if(pattern[1].indexOf(password[i]) >= 0)
	 				isOK2 = 1;
	 			if(pattern[2].indexOf(password[i]) >= 0)
	 				isOK3 = 1;
	 		}
	 		if(isOK1 == 1 && isOK2 == 1 && isOK3 == 1)
	 			return true;
	 		else
	 			return false;
		}
</script>
</body>
</html>
