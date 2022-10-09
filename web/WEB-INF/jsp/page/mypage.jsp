<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
%>
<!doctype html>
<html lang="ko">
<head>
<meta name="subject"
	content="Kyonggi University Department of Computer Science">
<meta name="author" content="Kyonggi Univ. SSF">
<meta name="keyword"
	content="경기대학교, 컴퓨터과학과, Kyonggi University, Computer Science">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="utf-8">
<title>마이페이지 : 경기대학교 AI컴퓨터공학부</title>
<link href='css/bootstrap.css' rel='stylesheet' type='text/css'>
<link href='css/default.css' rel='stylesheet' type='text/css'>
<link href='css/boardtable.css' rel='stylesheet' type='text/css'>
<link href='css/information.css' rel='stylesheet' type='text/css'>
<link href='css/content.css' rel='stylesheet' type='text/css'>
<script src="js/default.js"></script>
<script src="js/jquery-3.2.1.min.js"></script>
<style>
#text {
	font-size: 13px;
}

.form-control {
	display: inline-block;
}

.inform {
	display: inline-block;
	text-align: right;
	width: 270px;
}

.profile {
	display: inline-block;
	margin-right: 10px;
	border-right: solid 1px black;
	padding-right: 10px;
	width: 140px;
	text-align: center;
}

#panel1 {
	width: 240px;
	display: inline-block;
	vertical-align: top;
}

#panel2 {
	width: 420px;
	display: inline-block;
}

#panel {
	border-top: solid 1px black;
	padding-top: 10px;
}
</style>
</head>
<body>

	<%@include file="../main/header.jsp"%>
	<main>
	<div id="content">
		<div id="title">
			<img src="img/student.png" alt="">
			<div id="titlename">마이 페이지</div>
		</div>
		<div id="container">
			<div id="tab">
				<ul id="tabMenu">
					<li><span class="deco_dot">●</span><a href="goMyPage.do">회원정보</a></li>
					<li><span class="deco_dot">●</span><a href="goChangePassword.do">비밀번호변경</a></li>
					<li><span class="deco_dot">●</span><a href="goWhatIDo.do">활동내역</a></li>
				</ul>
			</div>
			<div id="maincontent">
				<ul>
					<li id="maintext" style="margin-bottom: 5px;">
						<div id="maintitle" class="contenttitle">회원정보</div>
						<ul id="text">
						</ul>
					</li>
					<div id="modify_button"></div>
				</ul>
			</div>
		</div>
	</div>
	<script>
					var user = <%=user%>;
					var type = <%=type%>;
					var today = new Date();
					var reg_day = new Date(user.reg_date);
					var betweenDay = (today.getTime() - reg_day.getTime())/24/1000/60/60;
					$(document).ready(function(){
						setdata();
	                    }) 
					
					function setdata(){
						var a = '<div id="panel"><div id="panel1"><img src="img/임시.jpg" class="img-circle img-responsive"><div style="margin-top : 10px; text-align : center; font-size : 15px;">'+user.name+'</div></div>';
						a += '<div id="panel2"><div style = "text-align : right; font-size : 20px; font-family : NanumSquare; margin-bottom : 10px;">오늘은 가입한 지 <span style="color : red;">'+ (parseInt(betweenDay)+1) +'</span>일째입니다.</div><hr>';
						a += '<div class="profile">전화번호</div><div class="inform">'+ user.phone+'</div>';
						a += '<div class="profile">생년월일</div><div class="inform">'+ user.birth+'</div>';
						a += '<div class="profile">이메일</div><div class="inform">'+ user.email+'</div>';
						a += '<div class="profile">구분</div><div class="inform">'+ user.type+'</div>';
						if(type.class_type == 'BigUser'){
							a += '<div class="profile">학과</div><div class="inform">'+user.major+'</div>';
							a += '<div class="profile">학번(교번)</div><div class="inform">'+ user.per_id+'</div>';
							a += '<div class="profile">학년</div><div class="inform">'+ user.grade+'</div>';
							a += '<div class="profile">상태</div><div class="inform">'+ user.state+'</div>';
							}
						$('#text').empty();
						$('#text').append(a);
						$('#modify_button').empty();
						$('#modify_button').append('<button type="button" style="float : right;"class="btn btn-default" onclick="setmodify()">수정</button>');
					}
					
					function setmodify(){
						var a = '<div id="panel"><div id="panel1"><img src="img/임시.jpg" class="img-circle img-responsive"><div style="margin-top : 10px; text-align : center; font-size : 15px;">'+user.name+'</div></div>';
						a += '<div id="panel2"><div style = "text-align : right; font-size : 20px; font-family : NanumSquare; margin-bottom : 10px;">오늘은 가입한 지 <span style="color : red;">'+ (parseInt(betweenDay)+1) +'</span>일째입니다.</div><hr>';
						a += '<div class="profile">전화번호</div><div class="inform"><div class="form-group" style="margin : 0;"><input type="text" class="form-control" name = "phone" placeholder="변경할 번호를 입력해주세요" value="' + user.phone + '"></div></div>';
						a += '<div class="profile">생년월일</div><div class="inform"><input type="date" class="form-control" name="birth" value="' + formatDate(user.birth) + '"></div>';
						a += '<div class="profile">이메일</div><div class="inform"><div class="form-group" style="margin : 0;"><input type="text" class="form-control" name = "email" placeholder="변경할 이메일을 입력해주세요" value="' + user.email + '"></div></div>';
						a += '<div class="profile">구분</div><div class="inform">'+ user.type+'</div>';
						if(type.class_type == 'BigUser'){
							a += '<div class="profile">학과</div><div class="inform">'+user.major+'</div>';
							a += '<div class="profile">학번(교번)</div><div class="inform">'+ user.per_id+'</div>';
							a += '<div class="profile">학년</div><div class="inform">'+ user.grade+'</div>';
							a += '<div class="profile">상태</div><div class="inform">'+ user.state+'</div>';
							}
						$('#text').empty();
						$('#text').append(a);
						$('#modify_button').empty();
						$('#modify_button').append('<button type="button" style="float : right;"class="btn btn-default" onclick="refresh()">취소</button>');
						$('#modify_button').append('<button type="button" style="float : right;"class="btn btn-default" onclick="modify()">완료</button>');
					}
					
					function refresh(){
						location.reload();
					}

					function modify(){
						var id = user.id;
						var phone = $('[name = phone]').val();
						var birth = $('[name = birth]').val();
						var email = $('[name = email]').val();
						
						var userdata = id+"-/-/-"+phone+"-/-/-"+birth+"-/-/-"+email;
						
						$.ajax({
							url:"ajax.do",
							type:"post",
							data :{
								req:"modifyuserdata",
								data:userdata
							},
							success : function(data){
								alert("수정이 완료 되었습니다.");
								location.reload();
								}
						})
					}
					
					  function formatDate(date) {
				            var d = new Date(date),
				                month = '' + (d.getMonth() + 1),
				                day = '' + d.getDate(),
				                year = d.getFullYear();

				            if (month.length < 2) month = '0' + month;
				            if (day.length < 2) day = '0' + day;

				            return [year, month, day].join('-');
				        }
					  
					 if(<%=type%>.board_level <= 6){
						 $('#maincontent').append('<ul><li id="maintext" style="margin-bottom: 5px;"><div id="maintitle" class="contenttitle">마이 홈페이지</div><ul id="myhomeID"></ul></li></ul>');
						 if(user.myhomeid == '-')
							  $('#myhomeID').append('<div style="font-size : 13px" id="makePanel">아직 나의 홈페이지 아이디가 없습니다.<button class="btn btn-default" onclick="makeHomeID()" style="margin-left : 10px">만들기</button></div>');
						  else
							  $('#myhomeID').append('<div style="font-size : 13px">나의 홈페이지 아이디 : <span style="color : red;">' + user.myhomeid + '</span></div>');
						  
						  function makeHomeID(){
							  $('#makePanel').html('<div style="display : flex"><div class="input-group" style="margin : 0; margin-right : 10px; width : 300px;"><input onkeydown="reCheck()" type="text" class="form-control" name = "homeId" placeholder="아이디를 입력해주세요"><span class="input-group-btn" id="checkOrSubmit"><button class="btn btn-default" type="button" onclick="checkHome()">중복확인</button></span></div><div><span style="font-size : 12px;">※ 영대소문자,숫자 가능 5글자 이상으로 만들어주세요.(Ex. ddodd34)</span><br/><span style="font-size : 12px;">※ 한번 생성 후 수정, 삭제기 불가능합니다</span></div></div>');
						  }
					 } 
					  
					  
					  function checkHome(){
						  var homeid = $('[name = homeId]').val();
						  if( homeid == ''){
							  alert('입력해주세요!');
							  return;
						  }
						  if(homeid.length < 5){
							  alert('다섯 자 이상 입력해주세요!');
							  return;
						  }
						  if(/[^a-z0-9]/i.test(homeid)){
							  alert('대소문자와 숫자만 가능해요!');
							  return;
						  }
						  if(homeid.length > 20){
							  alert('20자 미만으로 해주세요!');
							  return;
						  }
						  $.ajax({
							  url : 'ajax.do',
							  type : 'post',
							  data : {
								  req : 'checkHomeId',
								  data : homeid
							  },
							  success : function(data){
								  if(data == 'success'){
									  $('#checkOrSubmit').html('<button class="btn btn-default" type="button" onclick="submitHomeId()" style="color : blue">제출하기</button>');
								  }else{
									  alert('이미 있는 아이디에요!')
									  return;
								  }
							  }
						  })
					  }
					  
					  function reCheck(){
						  $('#checkOrSubmit').html('<button class="btn btn-default" type="button" onclick="checkHome()">중복확인</button>');
					  }
					  
					  function submitHomeId(){
						  var homeid = $('[name = homeId]').val();
						  $.ajax({
								url : 'ajax.do',
								type : 'post',
								data : {
									req : 'submitHomeId',
									data : homeid
								},
								success : function(data){
									if(data == "success"){
										alert('등록에 성공하였습니다.');
										window.location.href = 'goMyPage.do';
									}
									else{
										alert('SERVER ERROR, Please try again later...');
										return;
									}
								}
						  })
					  }
				</script> 
				</main>



	<%@include file="../main/footer.jsp"%>
	<div id="shadow">
		<div id="blur"></div>
	</div>

</body>
</html>