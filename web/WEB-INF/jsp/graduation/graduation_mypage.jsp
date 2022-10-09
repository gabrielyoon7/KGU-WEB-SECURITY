<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
   String num = (String) request.getAttribute("num");
   String stage = (String) request.getAttribute("stage");
   String tabmenulist = (String) request.getAttribute("tabmenulist");//관리자탭메뉴
   String graduationuser = (String) request.getAttribute("graduationuser");
   String grduser = (String) request.getAttribute("grduser");
   String schedulelist = (String) request.getAttribute("schedulelist");
   String suggest_file = (String) request.getAttribute("suggest_file");
   String userlog=(String) request.getAttribute("userlog");
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
            <ul id="tabMenu">
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
      </div>
   </div>

   </main>
   <%@include file="../main/footer.jsp"%>
   <div id="shadow">
      <div id="blur"></div>
   </div>
   <script>
   var stage = <%=stage%>;
   var graduationuser =<%=graduationuser%>;//상태가 grd_state
   $(document).ready(function() {
         var sugg=<%=suggest_file%>;
         if(stage=="0"||sugg==null)
            setschedule_notgrd();
         else{
            setschedule();
               setrefuse();
           }
      })
      
      
      var list = $('#tabMenu');
      var tabmenu =<%=tabmenulist%>;
      var number =<%=num%>;
      for (var i = 0; i < tabmenu.length; ++i) {
         var value = tabmenu[i];
         var num = value.tab_id * 10 + value.orderNum;
         var text = '<li><span class="deco_dot">●</span><a href="'
               + value.path + '?num=' + num + '">' + value.page_title
               + '</a></li>'
         list.append(text);
      }

      var table = $('#usertable');
      var user =<%=user%>;
      

      var grduser =<%=grduser%>;//userbean상태
      if(stage=="0"){
         table.append(usertable_2(grduser));
      }else{
         table.append(usertable(grduser, graduationuser));
      }

      var state = $('#grd_state');
      var st = 0;
        var grdstate = graduationuser.grd_state;
        var substate = graduationuser.grd_state_level;
        state.append(addstate(st, grdstate, substate));

      function usertable(grduser, graduationuser) {
         var c="";
         if(graduationuser.capstone==2){
            c="이수 (제출 가능)";
         }else if(graduationuser.capstone==1){
            c="이수중 (제출 가능)";
         }else if(graduationuser.capstone==0){
            c="미이수";
         }else
            c="해당없음 (제출 가능)";
         var a = '';
         a += '<tr style="border-bottom : 1px solid #ddd">';
         a += '<td style="background-color : #ECEFF1; font-weight: 600;">학번</td><td>' + grduser.per_id + '</td><td style="background-color : #ECEFF1; font-weight: 600;">졸업시기</td><td>'
               + graduationuser.graduation_date + '</td><td style="background-color : #ECEFF1; font-weight: 600;">지도교수</td><td>'
               + graduationuser.prof_name + '</td>';
         a += '</tr>';
         a += '<tr style="border-bottom : 1px solid #ddd">';
         a += '<td style="background-color : #ECEFF1; font-weight: 600;">이름</td><td>' + grduser.name + '<td style="background-color : #ECEFF1; font-weight: 600;">소속학과</td><td>' + grduser.major
         +'</td><td style="background-color : #ECEFF1; font-weight: 600;">지연횟수</td><td>'+graduationuser.delay_count+'회</td>';
         a += '</tr>';
         a += '<tr style="border-bottom : 1px solid #ddd">';
         a +=  '</td><td style="background-color : #ECEFF1; font-weight: 600;">기타자격</td><td>캡스톤 ' + c
               + '</td><td></td><td></td><td></td><td></td>';
         a += '</tr>';
         return a;
      }
      function usertable_2(grduser){
         var a = '';
         a += '<tr style="border-bottom : 1px solid #ddd"><td style="background-color : #ECEFF1; font-weight: 600;">학번 </td><td>' + grduser.per_id + '</td></tr>';
         a += '<tr style="border-bottom : 1px solid #ddd"><td style="background-color : #ECEFF1; font-weight: 600;">이름 </td><td>' + grduser.name + '</td></tr>';
         a += '<tr style="border-bottom : 1px solid #ddd"><td style="background-color : #ECEFF1; font-weight: 600;">소속학과</td><td>' + grduser.major+'</td></tr>';
         return a;
      }

      function addstate(st, grstate, sub) {//우선 state 들어오는게 달라야함(button click시의 값으로 들어올 때)
            var steps=jQuery(".step");   
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
      
      
      function setschedule(){//2.25
          var table = $('#statetable');
          var arr = <%=schedulelist%>;
          var grduser = <%=grduser%>;
          var sugg=<%=suggest_file%>;
          var date=new Date();
          var a='';
             a+='<thead><tr><th>단계</th><th>일정</th><th>제출</th><th>비고</th></tr></thead>';//head부분
          a+='<tbody>';
          for(var i=0;i<arr.length;i++){//바꾸고싶다 ㅠㅠ 너무 코드 복잡(좋은코드가 없나요ㅠㅠ)
             var j=i;
                 if(i==4)continue;
                  if(i==5)
                     j=4;
                  var closing=new Date(arr[i].closing_date);
             var dayOfMonth = closing.getDate();  
             closing.setDate(dayOfMonth - 1); 
             var close = formatData(closing);
             a+='<tr class="tr'+i+'"><td title="'+arr[i].schedule_contents+'">'+arr[i].schedule_name+'</td><td><h5>'+formatData(arr[i].starting_date)+' ~ '+formatmd(close,"")+'</h5></td>';
             if(sugg[j].schedule_name!="default"){
                 if(sugg[j].schedule_name=="신청접수"){//제출한게 있을때
                     a+='<td><a href="graduation_form.do?per_id='+grduser.per_id+'&num=94&stage='+(i+1)+'&modify=2"><button type="button" class="btn btn-default">보기</button></a></td>';
                 }else if(sugg[j].schedule_name=='제안서'){
                      a+='<td><a href="graduation_form.do?per_id='+grduser.per_id+'&num=94&stage='+(i+1)+'&modify=2"><button type="button" class="btn btn-default">보기</button></a></td>';
                 }else if(sugg[j].schedule_name=='중간보고서'){
                      a+='<td><a href="graduation_form.do?per_id='+grduser.per_id+'&num=94&stage='+(i+1)+'&modify=2"><button type="button" class="btn btn-default">보기</button></a></td>';
                 }else if(sugg[j].schedule_name=='최종보고서'){
                      a+='<td><a href="graduation_form.do?per_id='+grduser.per_id+'&num=94&stage='+(i+1)+'&modify=2"><button type="button" class="btn btn-default">보기</button></a></td>';
                 }else if(sugg[j].schedule_name=='자격증'||sugg[j].schedule_name=='공모전'||sugg[j].schedule_name=='학술대회'){
                      a+='<td><a href="graduation_form.do?per_id='+grduser.per_id+'&num=94&stage='+(i+1)+'&modify=2"><button type="button" class="btn btn-default">보기</button></a></td>';
                 }
                 if(sugg[j].refuse_date==null){//반려가 없음
                 if(sugg[j].success_date!=null){
                     a+='<td>확인(제출 : '+formatmd(sugg[j].submit_date,".")+', 승인 : '+formatmd(sugg[j].success_date,".")+')';           
                 }else
                    if(sugg[j].schedule_name=='자격증'||sugg[j].schedule_name=='공모전'||sugg[j].schedule_name=='학술대회')
                       a+='<td><span style="color:blue">'+graduationuser.etc_level+'</span>(제출 : '+formatmd(sugg[j].submit_date,".")+')';//띄어쓰기 하는게 좋을지 고민해봐야함
                       else
                           a+='<td><span style="color:blue">   '+graduationuser.grd_state_level+'</span>(제출 : '+formatmd(sugg[j].submit_date,".")+')';//띄어쓰기 하는게 좋을지 고민해봐야함
             }else
                a+='<td><span style="color:blue">재제출 필요</span> (반려 : '+formatmd(sugg[j].refuse_date,".")+')';
                 }else{//시간구분
                    if(new Date(arr[i].starting_date)>=date){//날짜 안맞을떄(대기상태)
                    if(i!=0){
                       if(sugg[j-1].schedule_name=='default'){
                          a+='<td><button type="button" class="btn btn-default" style="pointer-events: none" ><img src="img/donot.png" style="width:24px"></button></td><td>전 단계 미승인';
                       }else
                          a+='<td><button type="button" class="btn btn-default" style="pointer-events: none" ><img src="img/donot.png" style="width:24px"></button></td><td>대기';
                    }else
                       a+='<td><button type="button" class="btn btn-default" style="pointer-events: none"><img src="img/donot.png" style="width:24px"></button></td><td>대기';
                     
                 }else if((new Date(arr[i].starting_date)<=date && new Date(arr[i].closing_date)>=date)){
                       if(i==5&&graduationuser.etc=='불가'){//날짜     //지연 풀어주는거추가해야함
                           a+='<td><button type="button" class="btn btn-default" style="pointer-events: none"><img src="img/donot.png" style="width:24px"></button></a></td><td>제출불가(캡스톤이수 필수)'; 
                             }else{
                           if(user.type.includes("관리자")||user.type.includes("교수")){
                                 if(i==5||i==0){
                                    if(sugg[0].success_date==null&&i==5){
                                         a+='<td><button type="button" class="btn btn-default" style="pointer-events: none">미제출</button></td><td>전 단계 미승인';
                                    }else
                                       a+='<td><button type="button" class="btn btn-default" style="pointer-events: none">미제출</button></td><td>제출가능';
                                 }else{
                                   
                                 if(sugg[j-1].success_date!=null)
                                    a+='<td><button type="button" class="btn btn-default" style="pointer-events: none">미제출</button></td><td>제출가능';
                                 else
                                    a+='<td><button type="button" class="btn btn-default" style="pointer-events: none;"미제출</button></td><td>전 단계 미승인';
                                 }
                           }else
                              if(graduationuser.grd_state==arr[i].schedule_name||i==5||i==0){
                                 if(i==5&&sugg[0].schedule_name=='default'){
                                     a+='<td><button type="button" class="btn btn-default" style="pointer-events: none"><img src="img/donot.png" style="width:24px"></button></td><td>전 단계 미승인';
                                 }else
                                   a+='<td><a href="graduation_form.do?per_id='+grduser.per_id+'&num=94&stage='+(i+1)+'&modify=0"><button type="button" class="btn btn-default">제출</button></a></td><td>제출가능';
                          }else
                             a+='<td><button type="button" class="btn btn-default" style="pointer-events: none; padding-top:0;padding-bottom:0"><img src="img/donot.png" style="width:24px"></button></td><td>전 단계 미승인';
                        }       
                 }else if(new Date(graduationuser.delay_date)>=date&&(graduationuser.grd_state==arr[i].schedule_name||i==5)){
                    if(i==5&&graduationuser.etc=='불가'){//날짜     //지연 풀어주는거추가해야함
                        a+='<td><button type="button" class="btn btn-default" style="pointer-events: none"><img src="img/donot.png" style="width:24px"></button></a></td><td>제출불가(캡스톤이수 필수)'; 
                        }else{
                        if(user.type.includes("관리자")||user.type.includes("교수")){
                                a+='<td><button type="button" class="btn btn-default" style="pointer-events: none">미제출</button></td><td>제출가능(연장 : '+formatmd(graduationuser.delay_date,".")+')';
                        }else
                          if(i==5||i==0){
                                if(sugg[0].success_date==null&&i==5)
                                   a+='<td><button type="button" class="btn btn-default" style="pointer-events: none"><img src="img/donot.png" style="width:24px"></button></td><td>전 단계 미승인';
                                else
                                      a+='<td><a href="graduation_form.do?per_id='+grduser.per_id+'&num=94&stage='+(i+1)+'&modify=0"><button type="button" class="btn btn-default">제출</button></a></td><td>제출가능(연장 : '+formatmd(graduationuser.delay_date,".")+')';
                           }else
                              if(sugg[j-1].schedule_name=="default"){
                                a+='<td><button type="button" class="btn btn-default" style="pointer-events: none; padding-top:0;padding-bottom:0"><img src="img/donot.png" style="width:24px"></button></td><td>전 단계 미승인';
                                 }else                               
                                a+='<td><a href="graduation_form.do?per_id='+grduser.per_id+'&num=94&stage='+(i+1)+'&modify=0"><button type="button" class="btn btn-default">제출</button></a></td><td>제출가능(연장 : '+formatmd(graduationuser.delay_date,".")+')';   
                     }    
                 }
                 else{
                         if(user.type.includes("관리자")||user.type.includes("교수")){
                            if(i!=5&&i!=0){
                               if(sugg[j-1].success_date!=null)
                                  a+='<td><button type="button" class="btn btn-default" onclick="delay_open()">연장</button>';//이거는 필요할까?? 우선 만들어 놓음
                                  else
                                     a+='<td><button type="button" class="btn btn-default" style="pointer-events: none">미제출</button>';
                            }else if(i==5&&graduationuser.etc=='불가')
                                a+='<td><button type="button" class="btn btn-default" style="pointer-events: none">미제출</button>';
                                else
                               a+='<td><button type="button" class="btn btn-default" onclick="delay_open()">연장</button>';//이거는 필요할까?? 우선 만들어 놓음
                         }else                          
                              a+='<td><button type="button" class="btn btn-default" style="pointer-events: none; padding-top:0;padding-bottom:0"><img src="img/donot.png" style="width : 24px;"></button>';
                        if(i!=0&&i!=5){
                           if(sugg[j-1].success_date!=null)
                                    a+='</td><td>마감';
                              else
                                 a+='</td><td>전 단계 미승인';
                        }else
                        a+='</td><td>마감';
             }

                 }
                a+='</td></tr>';
                 }   
             
             a+='</tbody>';
         
              table.html(a);
         }
        
      function setschedule_notgrd(){
         var table = $('#statetable');
         var arr = <%=schedulelist%>;
         var grduser = <%=grduser%>
         var sugg=<%=suggest_file%>;
         var date=new Date();
         table.append('<thead><tr><th>단계</th><th>일정</th><th>제출</th><th>비고</th></tr></thead>');//head부분
         table.append('<tbody>');
         if(graduationuser.grd_state_level=="제출가능"){
            table.append('<tr><td title="'+arr[0].schedule_contents+'">'+arr[0].schedule_name+'</td><td>'+formatData(arr[0].starting_date)+'~'+formatData(arr[0].closing_date)+'</td><td><a href="graduation_form.do?per_id='+grduser.per_id+'&num=94&stage=1"><button type="button" class="btn btn-default">제출</button></a></a></td><td>'+graduationuser.grd_state_level+'</td></tr>');
         }else{
            table.append('<tr><td title="'+arr[0].schedule_contents+'">'+arr[0].schedule_name+'</td><td>'+formatData(arr[0].starting_date)+'~'+formatData(arr[0].closing_date)+'</td><td><a href="graduation_form.do?per_id='+grduser.per_id+'&num=94&stage=1&modify=2"><button type="button" class="btn btn-default">보기</button></a></td><td>'+graduationuser.grd_state_level+'</td></tr>');

         }
         //graduationuser 정보를 이용하면 가능할듯 싶은데
         table.append('</tbody>');
      }
      function formatData(date) {
            var d = new Date(date), month = '' + (d.getMonth() + 1), day = ''
                  + d.getDate(), year = d.getFullYear();

            if (month.length < 2)
               month = '0' + month;
            if (day.length < 2)
               day = '0' + day;
      
            return [ year, month, day ].join('-');
         }
        function formatmd(date,comma) {
            var d = new Date(date), month = '' + (d.getMonth() + 1), day = ''
                  + d.getDate();

            if (month.length < 2)
               month = '0' + month;
            if (day.length < 2)
               day = '0' + day;
         if(comma==".")
            return [month, day ].join('.');
         else
           return [month, day ].join('-');
         }
       function formatData2(date) {
            var d = new Date(date), month = '' + (d.getMonth() + 1), day = ''
                  + d.getDate(), year = d.getFullYear(), hour=''+(d.getHours()),minute=''+(d.getMinutes()),second=''+(d.getSeconds());
         
            if (month.length < 2)
               month = '0' + month;
            if (day.length < 2)
               day = '0' + day;
            if(hour.length<2)
               hour='0'+hour;
            if(minute.length<2)
               minute='0'+minute;
      
            return [ year, month, day ].join('-')+' '+ hour+':'+minute ;
         }
        
        function delay_open(){
           $.ajax({
              url : "ajax.do",
              type: "post",
              data:{
                 req : "delay_open",
                 data : graduationuser.per_id
              },
              success : function(data){
                 alert(data+"일까지 연장 되었습니다.");
                 window.location.reload();
              }
           })
        }
        
        function setrefuse(){
            var table = $('#refusetable');
            var userlog=<%=userlog%>;
            if(userlog!=null){   
            var a='';
            a+='<thead><tr><th>일시</th><th>단계</th><th>처리결과</th></tr></thead>';//head부분
             a+='<tbody>';
            for(var i=(userlog.length-1);i>=0;i--){
                a+='<tr><td>'+formatData2(userlog[i].log_date)+'</td><td>'+userlog[i].grd_state+'</td><td>'+userlog[i].reason+'</td>';
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
        
        function popup_exit(){
           $('.complete_M').css('display', 'none');
        }
      </script>
</body>
</html>