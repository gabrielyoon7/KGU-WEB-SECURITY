<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
String grdu_student = (String)request.getAttribute("grdu_student");
String grdu_students_state_list = (String)request.getAttribute("grdu_students_state_list");
String etc_state = (String)request.getAttribute("etc_state");
String log_list = (String)request.getAttribute("log_list");
String usertype = (String)request.getAttribute("usertype");
String user_type_int = (String)request.getAttribute("user_type_int");
String per_id = (String)request.getAttribute("per_id");
String tabmenulist = (String) request.getAttribute("tabMenu");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta name="subject" content="Kyonggi University Department of Computer Science">
<meta name="author" content="Kyonggi Univ. SSF">
<meta name="keyword" content="경기대학교, 컴퓨터과학과, Kyonggi University, Computer Science">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
   width: 15%;text-align:center;min-width:80px;
}
.boardtable>thead>tr>th:nth-child(2), .boardtable>tbody>tr>td:nth-child(2) {
   width: 30%;text-align:center;min-width:80px;
}
.boardtable>thead>tr>th:nth-child(3), .boardtable>tbody>tr>td:nth-child(3) {
   width: 25%;text-align:center;min-width:80px;
  
}
.boardtable>thead>tr>th:nth-child(4), .boardtable>tbody>tr>td:nth-child(4) {
   width: 30%;text-align:center;min-width:80px;
  
}
.tr5{
 background-color : #d9e3f7;
}

.btn {
   padding : 4px 15px;
   font-size : 12px;
}

.complete_M{
border:1px solid #ddd;
position : absolute;
width:400px;
height:200px;
margin-top:50px;
margin-left:165px;
background-color : white;
 z-index: 6;
 display: none;
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
				<ul id="tab_2">
				</ul>
			</div>
         <div id="maincontent">
            <div id="danger_main"></div>
            <table id="usertable" class="table table-bordered" style="font-size : 13px; border : 2px solid #ddd; margin-bottom : 0;">
            </table>
            <div class="complete_M">
            <a onclick="popup_exit()">
               <img style="margin-left:370px;margin-top:0px;" src="img/grd_denied.png"></a>
               <img style="margin-left:100px;margin-top:20px;width:200px;height:100px" src="img/missioncomplete.png">
            </div>
            <div class="container" style = "height : 120px; padding-left : 0">
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
                        <span>최종보고서(기타자격)</span>
                     </div>
                  </div>
               </div>
            </div>
            <div id="grd_state" class="step-box" style="margin-bottom : 20px">
               <!-- 일정안내 -->
            </div>
            <div>
            <table class="boardtable" id="statetable">
            
            </table>   
          
                <table class="boardtable" id="refusetable" style="margin-top : 15px;">
           
            </table> 
              <div id="forRefuse" style="text-align:right">  
               </div>
            </div>
         </div>
         	<!-- 기타관련 모달 페이지 -->
			<div class="modal fade" id="modal_etc" role="dialog">
				<div class="modal-dialog">

					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">기타 자격 제출</h4>
						</div>
						<div class="modal-body">
							<table class="boardtable">
								<thead>
									<tr>
										<th>단계</th>
										<th>제출</th>
									</tr>
								</thead>
								<tbody id="etc-table">
									<tr>
										<td>자격증</td>
										<td id="certi-btn"></td>
									</tr>

									<tr>
										<td>학술대회</td>
										<td id="confere-btn"></td>
									</tr>

									<tr>
										<td>공모전</td>
										<td id="contest-btn"></td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">Close</button>
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
   var grdu_student = <%=grdu_student%>
   var list = $('#tab_2');
   var tabmenu =<%=tabmenulist%>;
   for (var i = 0; i < tabmenu.length; ++i) {
       var value = tabmenu[i];
       var num = value.tab_id * 10 + value.orderNum;
       var text = '<li><span class="deco_dot">●</span><a href="'
             + value.path + '?num=' + num + '">' + value.page_title
             + '</a></li>'
       list.append(text);
    }
   var state = $('#grd_state');
   var grdstate=grdu_student.current_state;
   var substate=grdu_student.current;
   var st=0;
   state.append(addstate(st, grdstate, substate));
   
   function usertable(grdu_student) {
       var c="";
       if(grdu_student.capstone==3){
          c="이수 (제출 가능)";
       }else if(grdu_student.capstone==2){
          c="이수중 (제출 가능)";
       }else if(grdu_student.capstone==1){
          c="미이수";
       }else
          c="해당없음 (제출 가능)";
       var a = '';
       a += '<tr style="border-bottom : 1px solid #ddd">';
       a += '<td style="background-color : #ECEFF1; font-weight: 600;">학번</td><td>' + grdu_student.per_id + '</td><td style="background-color : #ECEFF1; font-weight: 600;">졸업시기</td><td>'
             + grdu_student.graduation_date + '</td><td style="background-color : #ECEFF1; font-weight: 600;">지도교수</td><td>'
             + grdu_student.prof_name + '</td>';
       a += '</tr>';
       a += '<tr style="border-bottom : 1px solid #ddd">';
       a += '<td style="background-color : #ECEFF1; font-weight: 600;">이름</td><td>' + grdu_student.name + '<td style="background-color : #ECEFF1; font-weight: 600;">소속학과</td><td>' + grdu_student.major
       +'</td><td style="background-color : #ECEFF1; font-weight: 600;">지연횟수</td><td>'+grdu_student.delay_count+'회</td>';
       a += '</tr>';
       a += '<tr style="border-bottom : 1px solid #ddd">';
       a +=  '</td><td style="background-color : #ECEFF1; font-weight: 600;">기타자격</td><td>캡스톤 ' + c
             + '</td><td></td><td></td><td></td><td></td>';
       a += '</tr>';
       return a;
    }
   function addstate(st, grstate, sub) {//우선 state 들어오는게 달라야함(button click시의 값으로 들어올 때)
       var steps=jQuery(".step");   //현재상태=sub 현재단계=grstate
       var a = '';
       if (sub == "제출가능")
          a += '<div class="step-state step2">';
       else if (sub == "제출완료")
          a += '<div class="step-state step3">';
       else if (sub == "면담")
          a += '<div class="step-state step4">';
       else if (sub == "확인")
          a += '<div class="step-state step5">';
       else if(sub == "대기")
          a+= '<div class="step-state step1">';
       else if(sub=="지연")
          a+= '<div class="step-state step2-ing">';
       else if(sub=="반려")
             a+= '<div class="step-state step2">';
       if (grstate == '신청접수'){
          a += '<ul><li><p>대기</p></li>';
          a += '<li><p title="제출가능설명">제출가능</p></li><li><p title="제출완료설명">제출완료</p></li><li></li><li><p title="확인설명">확인</p></li></ul>';
       }
       else if (grstate == '제안서'){
          jQuery(steps[1]).addClass('current');
          jQuery(steps[0]).removeClass('current').addClass('done');
          a += '<ul><li><p>대기</p></li>';
          a += '<li><p title="제출가능설명">제출가능</p></li><li><p title="제출완료설명">제출완료</p></li><li><p title="면담 필수입니다">면담</p></li><li><p title="확인설명">확인</p></li></ul>';
       }
       else if (grstate == '중간보고서'){
          jQuery(steps[2]).addClass('current');
          jQuery(steps[1]).removeClass('current').addClass('done');
          jQuery(steps[0]).removeClass('current').addClass('done');
          a += '<ul><li><p>대기</p></li>';
          a += '<li><p title="제출가능설명">제출가능</p></li><li><p title="제출완료설명">제출완료</p></li><li></li><li><p title="확인설명">확인</p></li></ul>';
       }
       else if (grstate == '최종보고서'){
          jQuery(steps[3]).addClass('current');
          jQuery(steps[2]).removeClass('current').addClass('done');
          jQuery(steps[1]).removeClass('current').addClass('done');
          jQuery(steps[0]).removeClass('current').addClass('done');
          a += '<ul><li><p>대기</p></li>';
          a += '<li><p title="제출가능설명">제출가능</p></li><li><p title="제출완료설명">제출완료</p></li><li><p title="면담 필수입니다">면담</p></li><li><p title="확인설명">확인</p></li></ul>';
       }else if(grstate=='기타자격'){
          jQuery(steps[3]).addClass('current');
          jQuery(steps[2]).removeClass('current');
          jQuery(steps[1]).removeClass('current');
          jQuery(steps[0]).removeClass('current').addClass('done');
          a += '<ul><li><p>대기</p></li>';
          a += '<li><p title="대기설명">제출가능</p></li><li><p title="제출설명">제출완료</p></li><li><p title="면담 필수입니다">면담</p></li><li><p title="확인설명">확인</p></li></ul>';
          if(sub="확인" && <%=type%>.board_level > 3){
             $('.complete_M').css('display', 'block');
          }
       }else if(grstate =='최종통과'){
          jQuery(steps[3]).addClass('current');
          jQuery(steps[2]).removeClass('current').addClass('done');
          jQuery(steps[1]).removeClass('current').addClass('done');
          jQuery(steps[0]).removeClass('current').addClass('done');
          a += '<ul><li><p>개시전</p></li>';
          a += '<li><p title="제출가능설명">제출가능</p></li><li><p title="제출완료설명">제출완료</p></li><li><p title="면담 필수입니다">면담</p></li><li><p title="확인설명">확인</p></li></ul>';
            if(<%=type%>.board_level > 3)
                $('.complete_M').css('display', 'block');
       }
       
       a += '</div>';
       return a;
    }
   var gssl=<%=grdu_students_state_list%>;
   var etc_state=<%=etc_state%>;
   function setschedule(){
	   var table = $('#statetable');
	   var a='';
	   a+='<thead><tr><th>단계</th><th>일정</th><th>제출</th><th>비고</th></tr></thead>';//head부분
	   a+='<tbody>';
	   for(var i=0;i<gssl.length;i++){
	   a+='<tr class="tr'+i+'"><td>'+gssl[i].schedule_name+'</td><td>'+gssl[i]starting_date_str+'~'+gssl[i].end_date_str+'</td>';
	   if(gssl[i].state_enum==6 || gssl[i].state_enum==7){
		   a+='<td><a href="graduation_form.do?per_id='+grdu_student.per_id+'&num=94&stage='+gssl[i].schedule_name_int+'&modify=2"><button type="button" class="btn btn-default">'+gssl[1].btn_name'</button></a></td>';
	   }
	   else if(gssl[i].state_enum==5){
		   if(user.type.includes("관리자")||user.type.includes("교수")){
			   a+='<td><button type="button" class="btn btn-default" onclick="delay_open()">'+gssl[i].btn_name'</button></td>';
		   }
		   else{
			   a+='<td><button type="button" class="btn btn-default"style="pointer-events: none">'+gssl[i].btn_name'</button></td>';
		   }
	   }
	   else if(gssl[i].state_enum==4){
		   if(user.type.includes("관리자")||user.type.includes("교수")){
			   a+='<td><button type="button" class="btn btn-default"style="pointer-events: none">'+gssl[i].btn_name'</button></td>';
		   }
		   else{
			   a+='<td><a href="graduation_form.do?per_id='+grdu_student.per_id'&num=94&stage='+gssl[i].schedule_name_int+'&modify=0"><button type="button" class="btn btn-default">'+gssl[1].btn_name'</button></a></td>';
		   }
	   }
	   else{
		   a+='<td><button type="button" class="btn btn-default"style="pointer-events: none">'+gssl[i].btn_name+'</button></td>';
	   }
	   a+='<td>'+gssl[i].note+'</td></tr>';
   }
	   a+='<tr><td>'+etc_state.schedule_name+'</td><td>'+etc_state.starting_date_str+'~'+etc_state.end_date_str+'</td>';
	   if(etc_state.state_enum==4){
		   a+='<td><button type="button" class="btn btn-default"data-toggle="modal" data-target="#modal_etc" onclick="addEtc()">제출</button></td>';
	   }
	   else if(etc_state.state_enum==6){
		   a+='<td><button type="button" class="btn btn-default"data-toggle="modal" data-target="#modal_etc" onclick="modifyEtc()">수정</button><button type="button" class="btn btn-default"data-toggle="modal" data-target="#modal_etc" onclick="addEtc()">추가</button><button type="button" class="btn btn-default"data-toggle="modal" data-target="#modal_etc" onclick="removeEtc()">삭제</button></td>';
	   }
	   else if(etc_state_state_enum==7){
		   a+='<td><button type="button" class="btn btn-default"data-toggle="modal" data-target="#modal_etc" onclick="checkEtc()">보기</button></td>';
	   }
	   else if(etc_state.state_enum==5){
		   if(user.type.includes("관리자")||user.type.includes("교수")){
			   a+='<td><button type="button" class="btn btn-default" onclick="delay_open()">연장</button></td>'   
		   }
		   else{
			   a+='<td><button type="button" class="btn btn-default"style="pointer-events: none">마감</button></td>';
		   }
	   }
	   else{
		   a+='<td><button type="button" class="btn btn-default"style="pointer-events: none">제출 불가</button></td>';
	   }
	   a+='<td>'+etc_state.note+'</td></tr>';
	   a+='</tbody>';
	   table.html(a);
   }
   
   function setrefuse(){
       var table = $('#refusetable');
       var userlog=<%=log_list%>;
       if(userlog!=null){   
       var a='';
       a+='<thead><tr><th>일시</th><th>단계</th><th>처리결과</th></tr></thead>';//head부분
        a+='<tbody>';
        for(var i=0;i<userlog.length;i++){
     	   a+='<tr><td>'+userlog.date+'</td><td>'+userlog.state+'</td><td>'+userlog.content+'</td></tr>';
        }
       a+='</tbody>';
       $('#forRefuse').html('<button class="btn btn-default" onclick="closelog()">로그닫기</button>');
       table.html(a);
   }
   }
   function closelog(){
       var table = $('#refusetable');
        var forrefuse = $('#forRefuse');
        table.html('');
        forrefuse.html('<button class="btn btn-default" onclick="setrefuse()">로그열기</button>');
   }
   
   function delay_open(){
       $.ajax({
          url : "ajax.do",
          type: "post",
          data:{
             req : "delay_open",
             data : grdu_student.per_id
          },
          success : function(data){
             alert(data+"일까지 연장 되었습니다.");
             window.location.reload();
          }
       })
    }
 //기타자격 제출 및 추가 버튼
	//stateenum의 level 자격증(7), 학술대회(8), 공모전(9)
	function addEtc() {

		//자격증
		if (etc_state.certificate_submit == 0) {
			$('#certi-btn').html('<a href="graduation_form.do?per_id='+ grdu_student.per_id
				+'&num=94&stage=7&modify=0"><button type="button" class="btn btn-default">O</button></a>');
		}
		else{
			$('#certi-btn').html('<button type="button" class="btn btn-default">X</button>');
		}

		
		//학술대회
		if (etc_state.conference_submit == 0) {
			$('#confere-btn').html('<a href="graduation_form.do?per_id='+ grdu_student.per_id
					+'&num=94&stage=8&modify=0"><button type="button" class="btn btn-default">O</button></a>');
		}
		else{
			$('#confere-btn').html('<button type="button" class="btn btn-default">X</button>');
		}

		//공모전
		if (etc_state.contest_submit == 0) {
			$('#contest-btn').html('<a href="graduation_form.do?per_id='+ grdu_student.per_id
					+'&num=94&stage=9&modify=0"><button type="button" class="btn btn-default">O</button></a>');
		}
		else{
			$('#contest-btn').html('<button type="button" class="btn btn-default">X</button>');
		}
	}

	//기타자격 삭제 버튼(삭제는 modify=4)
	function removeEtc() {
		//자격증
		if (etc_state.certificate_submit == 1) {
			$('#certi-btn').html('<a href="graduation_form.do?per_id='+ grdu_student.per_id
				+'&num=94&stage=7&modify=4"><button type="button" class="btn btn-default">O</button></a>');
		}
		else{
			$('#certi-btn').html('<button type="button" class="btn btn-default">X</button>');
		}

		
		//학술대회
		if (etc_state.conference_submit == 1) {
			$('#confere-btn').html('<a href="graduation_form.do?per_id='+ grdu_student.per_id
					+'&num=94&stage=8&modify=4"><button type="button" class="btn btn-default">O</button></a>');
		}
		else{
			$('#confere-btn').html('<button type="button" class="btn btn-default">X</button>');
		}

		//공모전
		if (etc_state.contest_submit == 1) {
			$('#contest-btn').html('<a href="graduation_form.do?per_id='+ grdu_student.per_id
					+'&num=94&stage=9&modify=4"><button type="button" class="btn btn-default">O</button></a>');
		}
		else{
			$('#contest-btn').html('<button type="button" class="btn btn-default">X</button>');
		}

	}

	//기타자격 수정 버튼
	function modifyEtc() {
		//자격증
		if (etc_state.certificate_submit == 1) {
			$('#certi-btn').html('<a href="graduation_form.do?per_id='+ grdu_student.per_id
				+'&num=94&stage=7&modify=0"><button type="button" class="btn btn-default">O</button></a>');
		}
		else{
			$('#certi-btn').html('<button type="button" class="btn btn-default">X</button>');
		}

		
		//학술대회
		if (etc_state.conference_submit == 1) {
			$('#confere-btn').html('<a href="graduation_form.do?per_id='+ grdu_student.per_id
					+'&num=94&stage=8&modify=0"><button type="button" class="btn btn-default">O</button></a>');
		}
		else{
			$('#confere-btn').html('<button type="button" class="btn btn-default">X</button>');
		}

		//공모전
		if (etc_state.contest_submit == 1) {
			$('#contest-btn').html('<a href="graduation_form.do?per_id='+ grdu_student.per_id
					+'&num=94&stage=9&modify=0"><button type="button" class="btn btn-default">O</button></a>');
		}
		else{
			$('#contest-btn').html('<button type="button" class="btn btn-default">X</button>');
		}

	}

	//기타자격 확인 버튼
	function checkEtc() {
		//자격증
		if (etc_state.certificate_submit == 1) {
			$('#certi-btn').html('<a href="graduation_form.do?per_id='+ grdu_student.per_id
				+'&num=94&stage=7&modify=1"><button type="button" class="btn btn-default">O</button></a>');
		}
		else{
			$('#certi-btn').html('<button type="button" class="btn btn-default">X</button>');
		}

		
		//학술대회
		if (etc_state.conference_submit == 1) {
			$('#confere-btn').html('<a href="graduation_form.do?per_id='+ grdu_student.per_id
					+'&num=94&stage=8&modify=1"><button type="button" class="btn btn-default">O</button></a>');
		}
		else{
			$('#confere-btn').html('<button type="button" class="btn btn-default">X</button>');
		}

		//공모전
		if (etc_state.contest_submit == 1) {
			$('#contest-btn').html('<a href="graduation_form.do?per_id='+ grdu_student.per_id
					+'&num=94&stage=9&modify=1"><button type="button" class="btn btn-default">O</button></a>');
		}
		else{
			$('#contest-btn').html('<button type="button" class="btn btn-default">X</button>');
		}

	}
      </script>
</body>
</html>