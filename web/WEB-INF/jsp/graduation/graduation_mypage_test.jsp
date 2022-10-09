<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
	StringBuffer url2_grd_mypage = request.getRequestURL();
	String logo_img_grd_mypage;

	//로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
	//ai이면 ai로고 cs이면 cs로고
	if(url2_grd_mypage.substring(7,9).equals("ai") || url2_grd_mypage.substring(7,9).equals("lo")){
		logo_img_grd_mypage = "img/graduation_ai.png";
	}
	else{
		logo_img_grd_mypage = "img/graduation.png";
	}
	//System.out.println((logo_img_grd_mypage));
%>
<%
String grdu_student = (String)request.getAttribute("grdu_student");
String grdu_students_state_list = (String)request.getAttribute("grdu_students_state_list");
String etc_state = (String)request.getAttribute("etc_state");
String log_list = (String)request.getAttribute("log_list");
String tabmenulist = (String) request.getAttribute("tabMenu");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta name="subject"
	content="Kyonggi University Department of Computer Science">
<meta name="author" content="Kyonggi Univ. SSF">
<meta name="keyword"
	content="경기대학교, 컴퓨터과학과, Kyonggi University, Computer Science">
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
<link href='css/bootstrap-table.css' rel='stylesheet' type='text/css'>
<script src="./js/default.js"></script>
<script src="./js/jquery-3.2.1.min.js"></script>
<script src="js/step-progress-bar.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrap-table.js"></script>
<script src="js/bootstrap-table-cookie.js"></script>
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
	width: 100%;
	margin-top: 40px;
	text-align: center;
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

.boardtable>thead>tr>th:nth-child(1), .boardtable>tbody>tr>td:nth-child(1)
	{
	width: 15%;
	text-align: center;
	min-width: 80px;
}

.boardtable>thead>tr>th:nth-child(2), .boardtable>tbody>tr>td:nth-child(2)
	{
	width: 30%;
	text-align: center;
	min-width: 80px;
}

.boardtable>thead>tr>th:nth-child(3), .boardtable>tbody>tr>td:nth-child(3)
	{
	width: 25%;
	text-align: center;
	min-width: 80px;
}

.boardtable>thead>tr>th:nth-child(4), .boardtable>tbody>tr>td:nth-child(4)
	{
	width: 30%;
	text-align: center;
	min-width: 80px;
}

.tr5 {
	background-color: #d9e3f7;
}

.btn {
	padding: 4px 15px;
	font-size: 12px;
}

.complete_M {
	border: 1px solid #ddd;
	position: absolute;
	width: 400px;
	height: 200px;
	margin-top: 50px;
	margin-left: 165px;
	background-color: white;
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
			<img src=<%=logo_img_grd_mypage%> />
			<div>졸업논문</div>
		</div>
		<div id="container">
			<div id="tab">
				<ul id="tab_2">
				</ul>
			</div>
			<div id="maincontent">
				<div id="danger_main"></div>
				<table id="usertable" class="table table-bordered"
					style="font-size: 13px; border: 2px solid #ddd; margin-bottom: 0;">
				</table>
				<div class="complete_M">
					<a onclick="popup_exit()"> <img
						style="margin-left: 370px; margin-top: 0px;"
						src="img/grd_denied.png"></a> <img
						style="margin-left: 100px; margin-top: 20px; width: 200px; height: 100px"
						src="img/missioncomplete.png">
				</div>
				<div class="container" style="height: 120px; padding-left: 0">
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
				<div id="grd_state" class="step-box" style="margin-bottom: 20px">
					<!-- 일정안내 -->
				</div>
				<div>
					<table class="boardtable" id="statetable">

					</table>

					<table class="boardtable" id="refusetable"
						style="margin-top: 15px;">

					</table>
					<div id="forRefuse" style="text-align: right"></div>
				</div>
			</div>
		</div>
	</div>

	</main>
	<%@include file="../main/footer.jsp"%>
	<div id="shadow">
		<div id="blur"></div>
	</div>
				<!-- 기타관련 모달 페이지 0 -->
			<div class="modal fade" id="check_etc" role="dialog">
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
								<tbody>
									<tr>
										<td>자격증</td>
										<td id="check-etc-certi-btn"></td>
									</tr>

									<tr>
										<td>학술대회</td>
										<td id="check-etc-confere-btn"></td>
									</tr>

									<tr>
										<td>공모전</td>
										<td id="check-etc-contest-btn"></td>
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

			<!-- 기타관련 모달 페이지 1 -->
			<div class="modal fade" id="modify_etc" role="dialog">
				<div class="modal-dialog">

					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">기타 자격 수정</h4>
						</div>
						<div class="modal-body">
							<table class="boardtable">
								<thead>
									<tr>
										<th>단계</th>
										<th>제출</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>자격증</td>
										<td id="modify-etc-certi-btn"></td>
									</tr>

									<tr>
										<td>학술대회</td>
										<td id="modify-etc-confere-btn"></td>
									</tr>

									<tr>
										<td>공모전</td>
										<td id="modify-etc-contest-btn"></td>
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

			<!-- 기타관련 모달 페이지 2 -->
			<div class="modal fade" id="add_etc" role="dialog">
				<div class="modal-dialog">

					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">기타 자격 추가</h4>
						</div>
						<div class="modal-body">
							<table class="boardtable">
								<thead>
									<tr>
										<th>단계</th>
										<th>제출</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>자격증</td>
										<td id="add-etc-certi-btn"></td>
									</tr>

									<tr>
										<td>학술대회</td>
										<td id="add-etc-confere-btn"></td>
									</tr>

									<tr>
										<td>공모전</td>
										<td id="add-etc-contest-btn"></td>
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

			<!-- 기타관련 모달 페이지 3 -->
			<div class="modal fade" id="remove_etc" role="dialog">
				<div class="modal-dialog">

					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">기타 자격 삭제</h4>
						</div>
						<div class="modal-body">
							<table class="boardtable">
								<thead>
									<tr>
										<th>단계</th>
										<th>제출</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>자격증</td>
										<td id="remove-etc-certi-btn"></td>
									</tr>

									<tr>
										<td>학술대회</td>
										<td id="remove-etc-confere-btn"></td>
									</tr>

									<tr>
										<td>공모전</td>
										<td id="remove-etc-contest-btn"></td>
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

			<!-- 기타관련 모달 페이지 4 -->
			<div class="modal fade" id="admin_check" role="dialog">
				<div class="modal-dialog">

					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">기타 자격 확인</h4>
						</div>
						<div class="modal-body">
							<table class="boardtable">
								<thead>
									<tr>
										<th>단계</th>
										<th>제출</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>자격증</td>
										<td id="admin-check-certi-btn"></td>
									</tr>

									<tr>
										<td>학술대회</td>
										<td id="admin-check-confere-btn"></td>
									</tr>

									<tr>
										<td>공모전</td>
										<td id="admin-check-contest-btn"></td>
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

			<!-- 기타관련 모달 페이지 5 -->
			<div class="modal fade" id="admin_proc" role="dialog">
				<div class="modal-dialog">

					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">기타 자격 승인 및 반려</h4>
						</div>
						<div class="modal-body">
							<table class="boardtable">
								<thead>
									<tr>
										<th>단계</th>
										<th>제출</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>자격증</td>
										<td id="admin-proc-certi-btn"></td>
									</tr>

									<tr>
										<td>학술대회</td>
										<td id="admin-proc-confere-btn"></td>
									</tr>

									<tr>
										<td>공모전</td>
										<td id="admin-proc-contest-btn"></td>
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

			<!-- 기타관련 모달 페이지 6 -->
			<div class="modal fade" id="admin_extend" role="dialog">
				<div class="modal-dialog">

					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">기타 자격 연장</h4>
						</div>
						<div class="modal-body">
							<table class="boardtable">
								<thead>
									<tr>
										<th>단계</th>
										<th>제출</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>자격증</td>
										<td id="admin-extend-certi-btn"></td>
									</tr>

									<tr>
										<td>학술대회</td>
										<td id="admin-extend-confere-btn"></td>
									</tr>

									<tr>
										<td>공모전</td>
										<td id="admin-extend-contest-btn"></td>
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
			
			<!-- 기타관련 모달 페이지 7 -->
			<div class="modal fade" id="resubmit_etc" role="dialog">
				<div class="modal-dialog">

					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">기타 자격 재제출</h4>
						</div>
						<div class="modal-body">
							<table class="boardtable">
								<thead>
									<tr>
										<th>단계</th>
										<th>제출</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>자격증</td>
										<td id="resubmit-certi-btn"></td>
									</tr>

									<tr>
										<td>학술대회</td>
										<td id="resubmit-confere-btn"></td>
									</tr>

									<tr>
										<td>공모전</td>
										<td id="resubmit-contest-btn"></td>
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
	<script>
   
   var grdu_student = <%=grdu_student%>
   $(document).ready(function() {
          setschedule();
             setrefuse();
    })
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
   var table = $('#usertable');
   table.append(usertable(grdu_student));
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
       a +=  '</td><td style="background-color : #ECEFF1; font-weight: 600;">기타자격</td><td>캡스톤 ' + grdu_student.etc_accept
             + '</td><td></td><td></td><td></td><td></td>';
       a += '</tr>';
       return a;
    }
   
   function addstate(st, grstate, sub) {//우선 state 들어오는게 달라야함(button click시의 값으로 들어올 때)
	   
       var steps=jQuery(".step");   //현재상태=sub 현재단계=grstate
       var a = '';
       if (sub == 4)
          a += '<div class="step-state step2">';
       else if (sub == 6)
          a += '<div class="step-state step3">';
       else if (sub == 6)
          a += '<div class="step-state step4">';
       else if (sub == 7)
          a += '<div class="step-state step5">';
       else if(sub == 3)
          a+= '<div class="step-state step1">';
       else if(sub==5)
          a+= '<div class="step-state step2-ing">';
       else if(sub==4)
             a+= '<div class="step-state step2">';
       if (grstate == 1){
          a += '<ul><li><p>대기</p></li>';
          a += '<li><p title="제출가능설명">제출가능</p></li><li><p title="제출완료설명">제출완료</p></li><li></li><li><p title="확인설명">확인</p></li></ul>';
       }
       else if (grstate == 2){
          jQuery(steps[1]).addClass('current');
          jQuery(steps[0]).removeClass('current').addClass('done');
          a += '<ul><li><p>대기</p></li>';
          a += '<li><p title="제출가능설명">제출가능</p></li><li><p title="제출완료설명">제출완료</p></li><li><p title="면담 필수입니다">면담</p></li><li><p title="확인설명">확인</p></li></ul>';
       }
       else if (grstate == 3){
          jQuery(steps[2]).addClass('current');
          jQuery(steps[1]).removeClass('current').addClass('done');
          jQuery(steps[0]).removeClass('current').addClass('done');
          a += '<ul><li><p>대기</p></li>';
          a += '<li><p title="제출가능설명">제출가능</p></li><li><p title="제출완료설명">제출완료</p></li><li></li><li><p title="확인설명">확인</p></li></ul>';
       }
       else if (grstate == 4){
          jQuery(steps[3]).addClass('current');
          jQuery(steps[2]).removeClass('current').addClass('done');
          jQuery(steps[1]).removeClass('current').addClass('done');
          jQuery(steps[0]).removeClass('current').addClass('done');
          a += '<ul><li><p>대기</p></li>';
          a += '<li><p title="제출가능설명">제출가능</p></li><li><p title="제출완료설명">제출완료</p></li><li><p title="면담 필수입니다">면담</p></li><li><p title="확인설명">확인</p></li></ul>';
       }else if(grstate==6){
          jQuery(steps[3]).addClass('current');
          jQuery(steps[2]).removeClass('current');
          jQuery(steps[1]).removeClass('current');
          jQuery(steps[0]).removeClass('current').addClass('done');
          a += '<ul><li><p>대기</p></li>';
          a += '<li><p title="대기설명">제출가능</p></li><li><p title="제출설명">제출완료</p></li><li><p title="면담 필수입니다">면담</p></li><li><p title="확인설명">확인</p></li></ul>';
          if(sub="확인" && <%=type%>.board_level > 3){
             $('.complete_M').css('display', 'block');
          }
       }else if(grstate ==5){
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
	   a+='<tr class="tr'+i+'"><td>'+gssl[i].schedule_name+'</td><td>'+gssl[i].starting_date_str+'~'+gssl[i].end_date_str+'</td>';
	   if(gssl[i].state_enum==6 || gssl[i].state_enum==7){
		   a+='<td><a href="graduation_form.do?per_id='+grdu_student.per_id+'&num=94&stage='+gssl[i].schedule_name_int+'&modify=2"><button type="button" class="btn btn-default">'+gssl[i].btn_name+'</button></a></td>';
	   }
	   else if(gssl[i].state_enum==5){
		   if(user.type.includes("관리자")||user.type.includes("교수")){
			   a+='<td><button type="button" class="btn btn-default" onclick="delay_open()">'+gssl[i].btn_name+'</button></td>';
		   }
		   else{
			   a+='<td><button type="button" class="btn btn-default"style="pointer-events: none">'+gssl[i].btn_name+'</button></td>';
		   }
	   }
	   else if(gssl[i].state_enum==4){
		   if(user.type.includes("관리자")||user.type.includes("교수")){
			   a+='<td><button type="button" class="btn btn-default"style="pointer-events: none">'+gssl[i].btn_name+'</button></td>';
		   }
		   else{
			   a+='<td><a href="graduation_form.do?per_id='+grdu_student.per_id+'&num=94&stage='+gssl[i].schedule_name_int+'&modify=0"><button type="button" class="btn btn-default">'+gssl[i].btn_name+'</button></a></td>';
		   }
	   }
	   else{
		   a+='<td><button type="button" class="btn btn-default"style="pointer-events: none">'+gssl[i].btn_name+'</button></td>';
	   }
	   a+='<td>'+gssl[i].note+'</td></tr>';
   }
	   
	   //여기서 부터 기타자격 제출 관련 제어 (etc)
	   a+='<tr><td>'+etc_state.schedule_name+'</td><td>'+etc_state.starting_date_str+'~'+etc_state.end_date_str+'</td>';
	   var etcButtonState ='true'; //윤주현 : 기타자격 제출이 가능한지 여부를 표기함. (기본적으로 가능한 상태)
	   if(user.type.includes("관리자")||user.type.includes("교수")){
		   if(etc_state.state_enum == 5){
			   if(etc_state.certificate_submit == 1){
				   $('#admin-extend-certi-btn').html('<a href="graduation_etc_form.do?per_id=' + grdu_student.per_id + '&num=94&stage=7&modify=6"><button type="button" class="btn btn-default">O</button></a>');
			   }
			   else{
				   $('#admin-extend-certi-btn').html('<button type="button" class="btn btn-default">X</button>');
			   }
			   
			   if(etc_state.conference_submit == 1){
				   $('#admin-extend-confere-btn').html('<a href="graduation_etc_form.do?per_id=' + grdu_student.per_id + '&num=94&stage=8&modify=6"><button type="button" class="btn btn-default">O</button></a>');
			   }
			   else{
				   $('#admin-extend-confere-btn').html('<button type="button" class="btn btn-default">X</button>');
			   }
			   
			   if(etc_state.contest_submit == 1){
				   $('#admin-extend-contest-btn').html('<a href="graduation_etc_form.do?per_id=' + grdu_student.per_id + '&num=94&stage=9&modify=6"><button type="button" class="btn btn-default">O</button></a>');
			   }
			   else{
				   $('#admin-extend-contest-btn').html('<button type="button" class="btn btn-default">X</button>');
			   }
			   
			   a+='<td><button type="button" class="btn btn-default" onclick="delay_open()">연장</button></td>';
		   }
		   
		   else if(etc_state.state_enum == 6){
			   if(etc_state.certificate_submit == 1){
				   $('#admin-proc-certi-btn').html('<a href="graduation_etc_form.do?per_id=' + grdu_student.per_id + '&num=94&stage=7&modify=5"><button type="button" class="btn btn-default">O</button></a>');
			   }
			   else{
				   $('#admin-proc-certi-btn').html('<button type="button" class="btn btn-default">X</button>');
			   }
			   
			   if(etc_state.conference_submit == 1){
				   $('#admin-proc-confere-btn').html('<a href="graduation_etc_form.do?per_id=' + grdu_student.per_id + '&num=94&stage=8&modify=5"><button type="button" class="btn btn-default">O</button></a>');
			   }
			   else{
				   $('#admin-proc-confere-btn').html('<button type="button" class="btn btn-default">X</button>');
			   }
			   
			   if(etc_state.contest_submit == 1){
				   $('#admin-proc-contest-btn').html('<a href="graduation_etc_form.do?per_id=' + grdu_student.per_id + '&num=94&stage=9&modify=5"><button type="button" class="btn btn-default">O</button></a>');
			   }
			   else{
				   $('#admin-proc-contest-btn').html('<button type="button" class="btn btn-default">X</button>');
			   }
			   
			   a+='<td><button type="button" class="btn btn-default"data-toggle="modal" data-target="#admin_proc">보기</button></td>';
		   }
		   
		   else if(etc_state.state_enum == 7){
			   if(etc_state.certificate_submit == 1){
				   $('#admin-check-certi-btn').html('<a href="graduation_etc_form.do?per_id=' + grdu_student.per_id + '&num=94&stage=7&modify=4"><button type="button" class="btn btn-default">O</button></a>');
			   }
			   else{
				   $('#admin-check-certi-btn').html('<button type="button" class="btn btn-default">X</button>');
			   }
			   
			   if(etc_state.conference_submit == 1){
				   $('#admin-check-confere-btn').html('<a href="graduation_etc_form.do?per_id=' + grdu_student.per_id + '&num=94&stage=8&modify=4"><button type="button" class="btn btn-default">O</button></a>');
			   }
			   else{
				   $('#admin-check-confere-btn').html('<button type="button" class="btn btn-default">X</button>');
			   }
			   
			   if(etc_state.contest_submit == 1){
				   $('#admin-check-contest-btn').html('<a href="graduation_etc_form.do?per_id=' + grdu_student.per_id + '&num=94&stage=9&modify=4"><button type="button" class="btn btn-default">O</button></a>');
			   }
			   else{
				   $('#admin-check-contest-btn').html('<button type="button" class="btn btn-default">X</button>');
			   }
			   
			   a+='<td><button type="button" class="btn btn-default"data-toggle="modal" data-target="#admin_check">보기</button></td>';
		   }
		   
		   else{
			   a+='<td><button type="button" class="btn btn-default"style="pointer-events: none">미제출</button></td>';
		   }
	   }
	   
	   else{
		   if(grdstate<3){//윤주현 : 현재 상태가 3(중간보고서 제출 가능) 미만인 경우에는 "제출 불가" 버튼을 출력하게 하여 제출 불가능하게 처리함.
			   a+='<td><button type="button" class="btn btn-default"style="pointer-events: none">제출 불가</button></td>';
			   etcButtonState ='false'; //윤주현 : 기타자격 제출이 가능한지 여부를 표기함. (버튼을 잠구면서 불가능하게 변경)
		   }
		   else if(etc_state.state_enum==4){
			   if(etc_state.certificate_submit == 0){
				   $('#add-etc-certi-btn').html('<a href="graduation_etc_form.do?per_id='+ grdu_student.per_id+ '&num=94&stage=7&modify=2"><button type="button" class="btn btn-default">O</button></a>');
				   $('#resubmit-certi-btn').html('<button type="button" class="btn btn-default">X</button>');
			   }
			   else{
				   $('#add-etc-certi-btn').html('<button type="button" class="btn btn-default">X</button>');
				   $('#resubmit-certi-btn').html('<a href="graduation_etc_form.do?per_id='+ grdu_student.per_id+ '&num=94&stage=7&modify=1"><button type="button" class="btn btn-default">O</button></a>');
			   }
			   
			   if(etc_state.conference_submit == 0){
				   $('#add-etc-confere-btn').html('<a href="graduation_etc_form.do?per_id='+ grdu_student.per_id+ '&num=94&stage=8&modify=2"><button type="button" class="btn btn-default">O</button></a>');
				   $('#resubmit-confere-btn').html('<button type="button" class="btn btn-default">X</button>');
			   }
			   else{
				   $('#add-etc-confere-btn').html('<button type="button" class="btn btn-default">X</button>');
				   $('#resubmit-confere-btn').html('<a href="graduation_etc_form.do?per_id='+ grdu_student.per_id+ '&num=94&stage=8&modify=1"><button type="button" class="btn btn-default">O</button></a>');
			   }
			   
			   if(etc_state.contest_submit == 0){
				   $('#add-etc-contest-btn').html('<a href="graduation_etc_form.do?per_id='+ grdu_student.per_id+ '&num=94&stage=9&modify=2"><button type="button" class="btn btn-default">O</button></a>');
				   $('#resubmit-contest-btn').html('<button type="button" class="btn btn-default">X</button>');
			   }
			   else{
				   $('#add-etc-contest-btn').html('<button type="button" class="btn btn-default">X</button>');
				   $('#resubmit-contest-btn').html('<a href="graduation_etc_form.do?per_id='+ grdu_student.per_id+ '&num=94&stage=9&modify=1"><button type="button" class="btn btn-default">O</button></a>');
			   }
			   
			   if(etc_state.certificate_submit == 1 || etc_state.conference_submit == 1 || etc_state.contest_submit == 1){
				   a+='<td><button type="button" class="btn btn-default"data-toggle="modal" data-target="#resubmit_etc">재제출</button><button type="button" class="btn btn-default" data-toggle="modal" data-target="#add_etc">제출</button></td>';
			   }
			   
			   else{
				   a+='<td><button type="button" class="btn btn-default" data-toggle="modal" data-target="#add_etc">제출</button></td>';
			   }

		   }
		   
		   else if(etc_state.state_enum==6){
			   if(etc_state.certificate_submit == 1){
				   $('#modify-etc-certi-btn').html('<a href="graduation_etc_form.do?per_id=' + grdu_student.per_id + '&num=94&stage=7&modify=1"><button type="button" class="btn btn-default">O</button></a>');
				   $('#add-etc-certi-btn').html('<button type="button" class="btn btn-default">X</button>');
				   $('#remove-etc-certi-btn').html('<a href="graduation_etc_form.do?per_id=' + grdu_student.per_id + '&num=94&stage=7&modify=3"><button type="button" class="btn btn-default">O</button></a>');
			   }
			   else{
				   $('#modify-etc-certi-btn').html('<button type="button" class="btn btn-default">X</button>');
				   $('#add-etc-certi-btn').html('<a href="graduation_etc_form.do?per_id='+ grdu_student.per_id+ '&num=94&stage=7&modify=2"><button type="button" class="btn btn-default">O</button></a>');
				   $('#remove-etc-certi-btn').html('<button type="button" class="btn btn-default">X</button>');
			   }
			   
			   if(etc_state.conference_submit == 1){
				   $('#modify-etc-confere-btn').html('<a href="graduation_etc_form.do?per_id=' + grdu_student.per_id + '&num=94&stage=8&modify=1"><button type="button" class="btn btn-default">O</button></a>');
				   $('#add-etc-confere-btn').html('<button type="button" class="btn btn-default">X</button>');
				   $('#remove-etc-confere-btn').html('<a href="graduation_etc_form.do?per_id=' + grdu_student.per_id + '&num=94&stage=8&modify=3"><button type="button" class="btn btn-default">O</button></a>');
			   }
			   else{
				   $('#modify-etc-confere-btn').html('<button type="button" class="btn btn-default">X</button>');
				   $('#add-etc-confere-btn').html('<a href="graduation_etc_form.do?per_id='+ grdu_student.per_id+ '&num=94&stage=8&modify=2"><button type="button" class="btn btn-default">O</button></a>');
				   $('#remove-etc-confere-btn').html('<button type="button" class="btn btn-default">X</button>');
			   }
			   
			   if(etc_state.contest_submit == 1){
				   $('#modify-etc-contest-btn').html('<a href="graduation_etc_form.do?per_id=' + grdu_student.per_id + '&num=94&stage=9&modify=1"><button type="button" class="btn btn-default">O</button></a>');
				   $('#add-etc-contest-btn').html('<button type="button" class="btn btn-default">X</button>');
				   $('#remove-etc-contest-btn').html('<a href="graduation_etc_form.do?per_id=' + grdu_student.per_id + '&num=94&stage=9&modify=3"><button type="button" class="btn btn-default">O</button></a>');
			   }
			   else{
				   $('#modify-etc-contest-btn').html('<button type="button" class="btn btn-default">X</button>');
				   $('#add-etc-contest-btn').html('<a href="graduation_etc_form.do?per_id='+ grdu_student.per_id+ '&num=94&stage=9&modify=2"><button type="button" class="btn btn-default">O</button></a>');
				   $('#remove-etc-contest-btn').html('<button type="button" class="btn btn-default">X</button>');
			   }
			   
			   a+='<td><button type="button" class="btn btn-default"data-toggle="modal" data-target="#modify_etc">수정</button><button type="button" class="btn btn-default"data-toggle="modal" data-target="#add_etc">추가</button><button type="button" class="btn btn-default"data-toggle="modal" data-target="#remove_etc">삭제</button></td>';
		   }
		   else if(etc_state.state_enum==7){
			   if(etc_state.certificate_submit == 1){
				   $('#check-etc-certi-btn').html('<a href="graduation_etc_form.do?per_id=' + grdu_student.per_id + '&num=94&stage=7&modify=0"><button type="button" class="btn btn-default">O</button></a>');
			   }
			   else{
				   $('#check-etc-certi-btn').html('<button type="button" class="btn btn-default">X</button>');
			   }
			   
			   if(etc_state.conference_submit == 1){
				   $('#check-etc-confere-btn').html('<a href="graduation_etc_form.do?per_id=' + grdu_student.per_id + '&num=94&stage=8&modify=0"><button type="button" class="btn btn-default">O</button></a>');
			   }
			   else{
				   $('#check-etc-confere-btn').html('<button type="button" class="btn btn-default">X</button>');
			   }
			   
			   if(etc_state.contest_submit == 1){
				   $('#check-etc-contest-btn').html('<a href="graduation_etc_form.do?per_id=' + grdu_student.per_id + '&num=94&stage=9&modify=0"><button type="button" class="btn btn-default">O</button></a>');
			   }
			   else{
				   $('#check-etc-contest-btn').html('<button type="button" class="btn btn-default">X</button>');
			   }
			   
			   a+='<td><button type="button" class="btn btn-default"data-toggle="modal" data-target="#check_etc">보기</button></td>';
		   }
		   else{
			   a+='<td><button type="button" class="btn btn-default"style="pointer-events: none">제출 불가</button></td>';
		   }
	   }
	   //윤주현 (여기서부터) : 앞서서 etcButtonState가 true인지 false인지 검사하여 비고란에 기본 상태인 etc_state.note를 출력할지, '(제출 불가)'를 출력할 지 결정함.
	   if(etcButtonState=='true'){
		   a+='<td>'+etc_state.note+'</td></tr>';
	   }
	   else{
		   a+='<td>'+'(제출 불가)'+'</td></tr>';
	   }
	   //윤주현 (여기까지)
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
     	   a+='<tr><td>'+userlog[i].date+'</td><td>'+userlog[i].state+'</td><td>'+userlog[i].content+'</td></tr>';
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
      </script>
</body>
</html>