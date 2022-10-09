<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    StringBuffer url2_register = request.getRequestURL();
    String img_register1;
    String img_register2;
    String img_register_logo;

    //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
    //ai이면 ai로고 cs이면 cs로고
    if(url2_register.substring(7,9).equals("ai") || url2_register.substring(7,9).equals("lo")){
        img_register1 = "img/사람hover1_ai.png";
        img_register2 = "img/사람hover2_ai.png";
        img_register_logo = "img/ai_logo.png";
    }
    else{
        img_register1 = "img/사람hover1.png";
        img_register2 = "img/사람hover2.png";
        img_register_logo = "img/cs_logo.png";
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
    <title>회원가입 : 경기대학교 컴퓨터과학전공</title>
    <style>
        #wrong_password{
            color: black;
        }
        
        #contentPanel{
           margin-top : 20px;
           width : 640px !important;
           
        }
        
        .choicePanel{
           width : 310px;
           display : inline-block;
        }
        
        #information{
           font-size : 24px;
        }
        
        .intro{
           margin-top : 20px;
           font-size : 17px;
        }
        
        #line{
           border : #37474F solid 1px;
           display : inline-block;
           height : 250px;
        }
        
        .input-group{
           width : 300px;
        }
        
        .form-control{
           width : 300px;
        }
        
        .informPassword{
           font-size : 11px;
           margin-left : 10px;
        }
    </style>
</head>
<body>
<script src="js/default.js"></script>
<script src="js/jquery-3.2.1.min.js"></script>
<script src='js/sha256.js'></script>
<main>
    <div id="content">
        <div id="title">
            <div><a href="Index"><img src="<%=img_register_logo%>" alt="" style="width: 350px;"></a></div>
        </div>
        <div id="information">회원 가입 구분 선택</div>
        <div id="contentPanel">
           	<div id="inputPanel">
                 	<div id="BigUserPanel" class="choicePanel" onclick="selectBig()">
                    	<img id ="user1image" src="img/사람1.png">
                    	<div class="intro">학번 혹은 교번이 있어요!</div>
                 	</div>
              	<div id="line"></div>
                 	<div id="SmallUserPanel" class="choicePanel" onclick="selectSmall()">
                    	<img id ="user2image" src="img/사람2.png">
                    	<div class="intro">학번 혹은 교번이 없어요!</div>
                 	</div>
              	<div class="intro">학번이나 교번이 있는 유저는 관리자 승인 후 구분이 결정됩니다!</div>
           	</div>
        </div>
    </div>
</main>
              <script>
              $('#BigUserPanel').hover(function(){
            	  $(this).children('img').attr('src', '<%=img_register1%>');
              }, function(){
            	  $(this).children('img').attr('src', 'img/사람1.png');
              })
              
               $('#SmallUserPanel').hover(function(){
            	  $(this).children('img').attr('src', '<%=img_register2%>');
              }, function(){
            	  $(this).children('img').attr('src', 'img/사람2.png');
              })
              
              
              
              
                 var ischeckID = 0;
                 var ischeckPassword = 0;
                 var isSafePassword = 0;
                 var pattern = [];
                 var pattern1 = '0123456789';
                    pattern2 = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
                    pattern3 = '!@#$%^&*()';
                 pattern.push(pattern1);
                pattern.push(pattern2);
                pattern.push(pattern3);
                 function checkPattern(password){
                    isSafePassword = 0 ;
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
                       isSafePassword = 1 ;
                 }
                 
                 
                 function selectBig(){
                    $('#information').text('회원 가입');
                    var panel = $('#contentPanel');
                   panel.css('text-align', 'left');
                   var inputPanel = $('#inputPanel');
                   inputPanel.empty();
                   inputPanel.css('padding-left', '180px');
                   inputPanel.css('padding-right', '150px');
                   var a = '<div class="form-group"><label for="InputID">학번(교번)</label><span id="warningID"></span><div class="input-group"><input onkeydown="changeID()" type="text" class="form-control" placeholder="학번이나 교번을 입력해주세요" id="InputID"><span class="input-group-btn"><button class="btn btn-default" type="button" onclick="checkID();">중복확인</button></span></div></div>';
                   a += '<div class="form-group"><label for="InputPassword">비밀번호</label><span class="informPassword">가능한 특수문자 : !,@,#,$,%,^,&,*,(,)</span><input onkeyup="checkPassword()" type="password" class="form-control" id="InputPassword" placeholder="8 글자 이상으로 설정해주세요"></div>';
                   a += '<div class="form-group"><label for="InputPasswordCheck">비밀번호 확인</label><span id="warningPassword"></span><input onkeyup="checkPassword()" type="password" class="form-control" id="InputPasswordCheck" placeholder="똑같이 입력해주세요"></div>';
                   a += '<div class="form-group"><label for="InputName">이름</label><input type="text" class="form-control" id="InputName" placeholder="이름을 입력해주세요"></div>';
                   a += '<div class="form-group"><label for="InputGender">성별</label><div><label class="radio-inline"><input type="radio" name="gender" value="남">남자</label><label class="radio-inline"  style="margin-left:70px;"><input type="radio" name="gender" value="여">여자</label></div></div>';
                   a += '<div class="form-group"><label for="InputBirth">생년월일</label><span style="font-size : 11px; margin-left : 10px">비밀번호 초기화시 생년월일로 초기화됩니다</span><input type="date" class="form-control" id="InputBirth" placeholder="Date of Birth"></div>';
                   a += '<div class="form-group"><label for="InputEmail">E-mail</label><input type="email" class="form-control" id="InputEmail" placeholder="E-mail을 입력해주세요"></div>';
                   a += '<div class="form-group"><label for="InputPhone">전화번호</label><input type="tel" class="form-control" id="InputPhone"  placeholder="- 포함해서 적어주세요"></div>';
                   a += '<div class="form-group"><label for="InputType" style="display :inline-block">희망구분</label><span style="font-size : 11px; margin-left : 10px">관리자 승인 후 변경됩니다</span><select class="form-control" id="InputType"><option>교수1</option><option>교수2</option><option>조교</option><option>대학원생</option><option>복수전공생</option><option selected>학부생</option><option>타과생</option></select></div>';
                   a += '<div class="form-group"><label for="InputMajor">학과</label><input type="text" class="form-control" id="InputMajor" placeholder="학과를 입력해주세요" value="컴퓨터과학과"></div>';
                   a += '<a href="#" class="loginBtn" onclick="LetsRegisterBig()" style = "text-decoration: none; text-align : center; margin : 15px 25px"><div id="login_btn">가입하기</div></a>'
                    
                   inputPanel.html(a);
                   
                   $('#InputType').on('change',function(){
                	   if($(this).val() == '복수전공생' || $(this).val() == '타과생')
                		   $('#InputMajor').val('');
                	   else
                		   $('#InputMajor').val('컴퓨터과학과');
                   })
                 }
                 
                 function selectSmall(){
                    $('#information').html('회원 가입');
                    var panel = $('#contentPanel');
                    panel.css('text-align', 'left');
                    var inputPanel = $('#inputPanel');
                    inputPanel.empty();
                    inputPanel.css('padding-left', '180px');
                    inputPanel.css('padding-right', '150px');
                    var a = '<div class="form-group"><label for="InputID">아이디</label><span id="warningID"></span><div class="input-group"><input onkeydown="changeID()" type="text" class="form-control" placeholder="원하는 아이디를 입력해주세요" id="InputID"><span class="input-group-btn"><button class="btn btn-default" type="button" onclick="checkID();">중복확인</button></span></div></div>';
                    a += '<div class="form-group"><label for="InputPassword">비밀번호</label><span class="informPassword">가능한 특수문자 : !,@,#,$,%,^,&,*,(,)</span><input onkeyup="checkPassword()" type="password" class="form-control" id="InputPassword" placeholder="8 글자 이상으로 설정해주세요"></div>';
                    a += '<div class="form-group"><label for="InputPasswordCheck">비밀번호 확인</label><span id="warningPassword"></span><input onkeyup="checkPassword()" type="password" class="form-control" id="InputPasswordCheck" placeholder="똑같이 입력해주세요"></div>';
                    a += '<div class="form-group"><label for="InputName">이름</label><input type="text" class="form-control" id="InputName" placeholder="이름을 입력해주세요"></div>';
                   a += '<div class="form-group"><label for="InputGender">성별</label><div><label class="radio-inline"><input type="radio" name="gender" value="남">남자</label><label class="radio-inline"  style="margin-left:70px;"><input type="radio" name="gender" value="여">여자</label></div></div>';
                    a += '<div class="form-group"><label for="InputBirth">생년월일</label><span style="font-size : 11px; margin-left : 10px">비밀번호 초기화시 생년월일로 초기화됩니다</span><input type="date" class="form-control" id="InputBirth" placeholder="Date of Birth"></div>';
                    a += '<div class="form-group"><label for="InputEmail">E-mail</label><input type="email" class="form-control" id="InputEmail" placeholder="E-mail을 입력해주세요"></div>';
                    a += '<div class="form-group"><label for="InputPhone">전화번호</label><input type="tel" class="form-control" id="InputPhone"  placeholder="- 포함해서 적어주세요"></div>';
                    a += '<div class="form-group"><label for="InputType" style="display :inline-block">구분</label><select class="form-control" id="InputType" ><option>학부모</option><option>입학예정자</option><option selected>기타</option></select></div>';
                     a += '<a href="#" class="loginBtn" onclick="LetsRegisterSmall()" style = "text-decoration: none; text-align : center; margin : 15px 25px"><div id="login_btn">가입하기</div></a>'
                 
                    inputPanel.html(a);
                 }
                 
                 function checkID(){
                    var id = $('#InputID').val();
                    $.ajax({
                  url:"ajax.do",
                  type:"post",
                  data:{
                     req:"checkid",
                     data: id
                  },
                  success:function(data){
                     var result = data;
                     if(data == 'dup'){
                        ischeckID = 0;
                        $('#warningID').html('*중복된 ID입니다');
                        $('#warningID').css('color', 'red');
                        $('#warningID').css('font-size', '11px');
                        $('#warningID').css('margin-left', '10px');
                        
                     }
                     else{
                        ischeckID = 1;
                        $('#warningID').html('*사용가능한 ID입니다');
                        $('#warningID').css('color', 'blue');
                        $('#warningID').css('font-size', '11px');
                        $('#warningID').css('margin-left', '10px');
                     }
                  }
               })
                 }
             
         function changeID(){
            ischeckID = 0;
            $('#warningID').html('*ID 중복확인을 해주세요');
            $('#warningID').css('color', 'black');
            $('#warningID').css('font-size', '11px');
            $('#warningID').css('margin-left', '10px');
         }
             
         function checkPassword(){
            checkPattern($('#InputPassword').val());
            if($('#InputPassword').val().length < 8 || isSafePassword != 1){
               ischeckPassword = 0;
               $('#warningPassword').html('8자 이상, 영문과 숫자, 특수문자의 조합');
               $('#warningPassword').css('color', 'red');
               $('#warningPassword').css('font-size', '11px');
               $('#warningPassword').css('margin-left', '10px');
            }
            else if($('#InputPassword').val() == $('#InputPasswordCheck').val()){
               ischeckPassword = 1;
               $('#warningPassword').html('비밀번호가 일치합니다');
               $('#warningPassword').css('color', 'blue');
               $('#warningPassword').css('font-size', '11px');
               $('#warningPassword').css('margin-left', '10px');
            }
            else{
               ischeckPassword = 0;
               $('#warningPassword').html('비밀번호가 일치하지 않습니다');
               $('#warningPassword').css('color', 'red');
               $('#warningPassword').css('font-size', '11px');
               $('#warningPassword').css('margin-left', '10px');
            }
         }   
                
         function LetsRegisterSmall(){
            if(ischeckID == 1){
               if(ischeckPassword == 1){
                  var id =$('#InputID').val();
                  var password = $('#InputPassword').val();
                  var forsha = id+password;
                  var name = $('#InputName').val();
                  var gender = $('input[name=gender]:checked').val();
                  var birth = $('#InputBirth').val();
                  var email = $('#InputEmail').val();
                  var phone = $('#InputPhone').val();
                  var type = $('#InputType').val();
                  if(name!=''&& gender!='' && birth!='' && email!='' && phone!=''){
                     var update = id+"-/-/-"+SHA256(forsha)+"-/-/-"+name+"-/-/-"+gender+"-/-/-"+birth+"-/-/-"+email+"-/-/-"+phone+"-/-/-"+type;
                     $.ajax({
                        url:"ajax.do",
                        type:"post",
                        data:{
                           req:"registersmallid",
                           data: update
                        },
                        success:function(data){
                                 if(data == "success"){
                                    $('#information').html('회원가입 완료');
                                    var inputPanel = $('#inputPanel');
                                         inputPanel.empty();
                                         var a = '';
                                         a += '<a href="loginpage.do" class="loginBtn" style = "text-decoration: none; text-align : center; margin : 25px 25px"><div id="login_btn">로그인하기</div></a>';
                                         inputPanel.html(a);
                                      }
                                 else{
                                    alert('SERVER ERROR, Please try again later');
                                 }
                              }
                        })
                     }
                  else{
                     alert("빈칸을 채워주세요");
                  }
               }
               else{
                  alert("비밀번호를 일치시켜주세요.");
               }
            }
            else
               alert("아이디 중복확인을 해주세요");
            }
            
         
         function LetsRegisterBig(){
            if(ischeckID == 1){
               if(ischeckPassword == 1){
                  var id =$('#InputID').val();
                  var password = $('#InputPassword').val();
                  var forsha = id+password;
                  var name = $('#InputName').val();
                  var gender = $('input[name=gender]:checked').val();
                  var birth = $('#InputBirth').val();
                  var email = $('#InputEmail').val();
                  var phone = $('#InputPhone').val();
                  var type = $('#InputType').val();
                  var major = $('#InputMajor').val();
                  var perID = id;
                  var why = $('#InputWhy').val();
                  if(name!='' && gender!='' && birth!='' && email!='' && phone!='' && major !='' && perID != ''){
                     var update = id+"-/-/-"+SHA256(forsha)+"-/-/-"+name+"-/-/-"+gender+"-/-/-"+birth+"-/-/-"+email+"-/-/-"+phone+"-/-/-"+type+"-/-/-"+major+"-/-/-"+perID;
                     $.ajax({
                        url:"ajax.do",
                        type:"post",
                        data:{
                           req:"registerbigid",
                           data: update
                        },
                        success:function(data){
                                 if(data == 'success'){
                                    $('#information').html('회원가입 완료');
                                    var inputPanel = $('#inputPanel');
                                         inputPanel.empty();
                                         var a = '';
                                         a += '<div style = "font : 12px; margin-left : 35px;">구분은 관리자 승인 후 변경됩니다</div>';
                                         a += '<a href="loginpage.do" class="loginBtn" style = "text-decoration: none; text-align : center; margin : 25px 25px"><div id="login_btn">로그인하기</div></a>';
                                         inputPanel.html(a);
                                 }
                                 else
                                    alert('SERVER ERROR, Please try again later');
                                 }
                        })
                     }
                  else{
                     alert("빈칸을 채워주세요");
                  }
               }
               else{
                  alert("비밀번호를 일치시켜주세요.");
               }
            }
            else
               alert("아이디 중복확인을 해주세요");
            }
            
             </script>
</body>
</html>