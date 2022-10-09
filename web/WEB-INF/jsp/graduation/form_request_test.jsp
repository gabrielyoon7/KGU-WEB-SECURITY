<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
   StringBuffer url2_grd_form_req = request.getRequestURL();
   String logo_img_grd_form_req;

   //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
   //ai이면 ai로고 cs이면 cs로고
   if(url2_grd_form_req.substring(7,9).equals("ai") || url2_grd_form_req.substring(7,9).equals("lo")){
      logo_img_grd_form_req = "img/graduation_ai.png";
   }
   else{
      logo_img_grd_form_req = "img/graduation.png";
   }
   //System.out.println((logo_img_grd_form_req));
%>
<%
   String num = (String) request.getAttribute("num");
   String stage_data = (String) request.getAttribute("stage_data");
   String tabmenulist = (String) request.getAttribute("tabMenu");
   String grduser = (String) request.getAttribute("grduser");
   String subDBuser = (String) request.getAttribute("graduationuser");
   String modify = (String) request.getAttribute("modify");
   String proflist = (String) request.getAttribute("proflist");
   String schedulelist= (String) request.getAttribute("schedulelist");
   String reqstudent = (String) request.getAttribute("reqstudent");
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
<style>
table {
   margin-top: 40px;
}

.graduation_write_info {
   padding: 5px;
   border: 1px solid #607D8B;
   font-size: 13px;
   display: flex;
   width: 748px;
   margin: auto;
   margin-bottom: 10px;
}

.graduation_read_info {
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
   width: 200px;
}

.profile {
   font-weight: bold;
   display: inline-block;
   margin-right: 5px;
   padding-right: 5px;
   width: 70px;
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

</style>
</head>
<body>
<script src="./js/jquery-3.2.1.min.js"></script>
<script src="./js/bootstrap.min.js"></script>
<script src="./js/default.js"></script>

   <%@include file="../main/header.jsp"%>
   <main>
   <div id="content">
      <div id="title">
         <img src=<%=logo_img_grd_form_req%> />
         <div>졸업논문</div>
      </div>
      <div id="container">
         <div id="tab">
            <ul id="tab_2">
            </ul>
         </div>
         <div id="maincontent">
            <ul>
               <li>
                  <div class="contenttitle">신청서 제출</div>
               </li>
            </ul>
            <div>
               <div class="graduation_write_info">
                  <div col-md-6>
                     <!-- 학생정보 div -->
                     <div class="contenttitle2">학생정보</div>
                     <ul id="student_data">
                        <li><div class="profile">졸업시기</div>
                           <div class="inform" id="grd_semester">
                           </div></li>
                     </ul>
                  </div>
                  <div col-md-6>
                     <!-- 학생정보 div -->
                     <div class="contenttitle2">졸업논문 진행일정</div>
                     <ul>
                        <div>
                           <textarea id="schedule" class="explain" readonly>
3월 9일 신청서 제출
3월 31일 제안서 제출
4월 7일 지도교수확인서 오프라인제출
9월 20일 중간보고 제출
11월 10일 최종논문제출 및 지도교수확인서 오프라인제출</textarea>
                        </div>
                        <input type="checkbox" id="checkbox1" name="agreement" VALUE="agree" /> 위 일정과 운영세칙을 확인하였으며, 세칙의 규정을 준수하겠습니다.
                  </div>
               </div>
               <div id="log_area">
                  <div class="contenttitle2">기타자격 준비현황</div>
                  <div style="font-size : 13px">준비중인 항목이 있으면, 모두 표시하시오.(기타자격 요건을 확인해주세요)</div>
                  <input type="checkbox" name="etc" value="자격증"/> <span style="font-size : 13px">자격증</span><br />
                  <input type="checkbox" name="etc" value="공모전"/> <span style="font-size : 13px">공모전</span> <br />
                  <input type="checkbox" name="etc" value="학술대회발표"/> <span style="font-size : 13px">학술대회발표</span> <br />
                   <input type="checkbox" name="etc" value="논문"> <span style="font-size : 13px">논문</span>  <br />
                  <input type="checkbox" name="etc" value="기타"/><span style="font-size : 13px">기타 :</span>
                  <input type="text" name = "etc4_text" placeholder="내용을 입력하세요." style="font-size : 13px">
               </div>
               <div>
                  <div class="col-md-9"></div>
                  <div id="button_area" class="text-right">
                     <!-- java script -->
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
   <!-- modal -->
       <div class="modal fade" id="myModal" role="dialog">
      <div class="modal-dialog">
         <!-- Modal content-->
         <div class="modal-content">
            <div class="modal-header">
               <button type="button" class="close" data-dismiss="modal"aria-label="Close">
                  <span aria-hidden="true">&times;</span>
               </button>
               <h4 class="modal-title">신청접수 승인</h4>
            </div>
            <div id="howmany2"></div>
            <div class="modal-body" id="myModalbody2">  
            <!-- java script -->          
            </div>
            <div class="modal-footer" id="footer2"></div>
         </div>
      </div>
   </div>
         <!-- modal -->
         <div >
         </div>
   <script>
   $(document).ready(function() {//바로시작하는 function
	  
      set_student_Data();
      
      insertsemester();
      
      check_user();
      
      button_change();
     
      set_schedule();
     
      
   })
   var list = $('#tab_2');
   var tabmenu =<%=tabmenulist%>;
   var number =<%=num%>;
   var agreement;
   if ($('input[name=agreement]').is(":checked")) {
      agreement=true; 
   }
   for (var i = 0; i < tabmenu.length; ++i) {// tabmenu설정
      var value = tabmenu[i];
      var num = value.tab_id * 10 + value.orderNum;
      var text = '<li><span class="deco_dot">●</span><a href="'
            + value.path + '?num=' + num + '">' + value.page_title
            + '</a></li>'
      list.append(text);
   }
   function set_schedule(){
   var schedule=$('#schedule');
   var schedulelist=<%=schedulelist%>;
   var a='';
   for(var i=0;i<schedulelist.length;i++){
      var closing=new Date(schedulelist[i].end_date);
      var dayOfMonth = closing.getDate();  
      closing.setDate(dayOfMonth - 1); 
      var close = formatmd(closing,"");
      a+=formatData(schedulelist[i].starting_date)+' ~ '+close+' : '+schedulelist[i].schedule_name+' 제출\n';
   }
   schedule.html(a);
   }
   
   
   function set_student_Data(){//학생정보 조건문에따라 설정
	   var reqstudent = <%=reqstudent%>
	   var user = <%=user%>
       var grduser = <%=grduser%>
      var list = $('#student_data');
      var a='';
      if((user.type.includes("관리자"))||(user.type.includes("교수"))){
         if(grduser==null){
        	 a+='<li><div class="profile">학번</div><div class="inform"><input type="text" name="per_id" placeholder="학번을 입력해주세요" value="'+reqstudent.per_id+' "readonly/></div></li>'
             +'<li><div class="profile">이름</div><div class="inform"><input type="text" name="name" placeholder="이름을 입력해주세요" value="'+reqstudent.name+'" readonly/></div></li>'
             +'<li><div class="profile">소속학과</div><div class="inform"><input type="text" id="grdMajor" name="major" placeholder="예)컴퓨터과학과" value="'+reqstudent.major+'" readonly/></div></li>'
         }
         else{
            a+='<li><div class="profile">학번</div><div class="inform"><input type="text" name="per_id" placeholder="학번을 입력해주세요" value="'+grduser.per_id+' "readonly/></div></li>'
            +'<li><div class="profile">이름</div><div class="inform"><input type="text" name="name" placeholder="이름을 입력해주세요" value="'+grduser.name+'" readonly/></div></li>'
            +'<li><div class="profile">소속학과</div><div class="inform"><input type="text" id="grdMajor" name="major" placeholder="예)컴퓨터과학과" value="'+grduser.major+'" readonly/></div></li>'
         }
      }else{
    	  if(reqstudent!=null){
    		  a+='<li><div class="profile">학번</div><div class="inform"><input type="text" name="per_id" placeholder="학번을 입력해주세요" value="'+reqstudent.per_id+' "readonly/></div></li>'
              +'<li><div class="profile">이름</div><div class="inform"><input type="text" name="name" placeholder="이름을 입력해주세요" value="'+reqstudent.name+'" readonly/></div></li>'
              +'<li><div class="profile">소속학과</div><div class="inform"><input type="text" id="grdMajor" name="major" placeholder="예)컴퓨터과학과" value="'+reqstudent.major+'" /></div></li>'
    	  }
    	  else if(grduser==null){
            a+='<li><div class="profile">학번</div><div class="inform"><input type="text" name="per_id" placeholder="학번을 입력해주세요"/></div></li>'
            +'<li><div class="profile">이름</div><div class="inform"><input type="text" name="name" placeholder="이름을 입력해주세요" /></div></li>'
            +'<li><div class="profile">소속학과</div><div class="inform"><input type="text" id="grdMajor" name="major" placeholder="예)컴퓨터과학과" /></div></li>'
         }
         else{
            a+='<li><div class="profile">학번</div><div class="inform"><input type="text" name="per_id" placeholder="학번을 입력해주세요" value="'+grduser.per_id+' "readonly/></div></li>'
            +'<li><div class="profile">이름</div><div class="inform"><input type="text" name="name" placeholder="이름을 입력해주세요" value="'+grduser.name+'" readonly/></div></li>'
            +'<li><div class="profile">소속학과</div><div class="inform"><input type="text" id="grdMajor" name="major" placeholder="예)컴퓨터과학과" value="'+grduser.major+'" readonly/></div></li>'
         }
      }
            list.prepend(a);
   }
   function selectedbox(){//설정된 checkbox 값 받아넘기기
      var checked_etc='';
      var etc = document.getElementsByName("etc");//체크박스들 이름
      if ($('input[name=agreement]').is(":checked")) {
         //check이름을 가진 check중에서 체크된 것만 값 가져오기
          var size = document.getElementsByName("etc").length;
          for(var i = 0; i < size; i++){
              if(document.getElementsByName("etc")[i].checked == true){
                 if(i==4){
                  checked_etc+=($('input[name=etc4_text]').val());
                  checked_etc+="(기타)/";
               }
               else{
                 checked_etc+=(document.getElementsByName("etc")[i].value);
               checked_etc+="/";
               }
              }
          }
      }else{
         alert("약관 동의를 체크해주세요!");
         return 0;
      }
      
      return checked_etc;
   }
   
   function insertsemester(){//관리자/교수거나 보기이면 날짜는 div로  수정/제출이면 select로 설정
      var list = $('#grd_semester');
        var today = new Date();
        var user = <%=user%>;
        var modify=<%=modify%>;
        var v = <%=subDBuser%>;
        var year = today.getFullYear();
        var a = '';
        if(user.type.includes("관리자")||user.type.includes("교수")||modify==2){
           a+='<div class="inform" style="text-align : left; padding-left:17px">'+v.graduation_date+'</div>';
        }
        else{
        	if(modify==0){
        		a += '<select class="inform" id="Inputdate" style="width : 160px"><option>'+(year)+'-08</option><option selected>'+(year+1)+'-02</option></select>';
        	}
        	
        	else{
        		if(v.graduation_date.includes("-02")){
        			a += '<select class="inform" id="Inputdate" style="width : 160px"><option>'+(year)+'-08</option><option selected>'+(year+1)+'-02</option></select>';
        		}
        		
        		else if(v.graduation_date.includes("-08")){
        			a += '<select class="inform" id="Inputdate" style="width : 160px"><option selected>'+(year)+'-08</option><option>'+(year+1)+'-02</option></select>';
        		}
        		
        		else{
        			a += '<select class="inform" id="Inputdate" style="width : 160px"><option>'+(year)+'-08</option><option selected>'+(year+1)+'-02</option></select>';
        		}
        	}
        }
        list.append(a);
    }
    function submit_request(){//신청서 접수하는 function
        var check = selectedbox();
        var date = $('#Inputdate').val();
        var major = $('#grdMajor').val();
        var user = <%=user%>
        var answer = user.per_id+"-/-/-"+user.name+"-/-/-"+date+"-/-/-"+check+"-/-/-"+major;
        if(check!=0){
         $.ajax({
            url:"ajax.do",
               type:"post",
               data : {
                     req : "submit_request",
                     data : answer
               },
               success : function(data){
                     alert("신청서 접수 완료!");
                      window.location.href="graduation_intro.do?num=94&stage=0"
               }
            
         })}
    }
      function submit_update_request(){//신청서-update(수정)하는 function
           var check = selectedbox();
           var date = $('#Inputdate').val();
           var major = $('#grdMajor').val();
           var user = <%=user%>
           var answer = user.per_id+"-/-/-"+user.name+"-/-/-"+date+"-/-/-"+check+"-/-/-"+major;
           if(check!=0){
            $.ajax({
               url:"ajax.do",
                  type:"post",
                  data : {
                        req : "submit_update_request",
                        data : answer
                  },
                  success : function(){
                     alert("수정 완료!");
                     window.location.href="graduation_intro.do?num=94&stage=0"
                  }
               
            })}
         }
    function button_change(){//버튼 조건문통해 설정 후 생성
       var log = <%=stage_data%>
         var button_area = $('#button_area');
       var user = <%=user%>
       var grduser = <%=grduser%>
       var modify = <%=modify%>
       var a='';
      
       if(user.type.includes("관리자")||user.type.includes("교수")){
             if(modify==1){
                 $('[name=etc4_text]').prop("readonly",true);
       	  		 a+='<a href="#myModal" data-toggle="modal" onclick="insertgrduser()" class="btn btn-default col-xs-1.5">승인</a>';
      		     a+='<button onclick="req_refuse()" type="button" style="margin: 2px;" class="btn btn-default">반려</button>';
             }else
                 a+='<a href="javascript:history.go(-1)"><button type="button" style = "margin : 2px;" class="btn btn-default">뒤로</button></a>';
          }
       else if(modify==2){
          $('[name=etc4_text]').prop("readonly",true);
          a+='<a href="javascript:history.go(-1)"><button type="button" style = "margin : 2px;" class="btn btn-default">취소</button></a>';
             if(grduser.current_state==1)
             a+='<a href="graduation_form.do?per_id='+grduser.per_id+'&num=94&stage=1&modify=1"><button type="button" class="btn btn-default">수정</button></a>';
          
          }
       else if(modify==1){
          a+='<a href="javascript:history.go(-1)"><button type="button" style = "margin : 2px;" class="btn btn-default">취소</button></a>'
          +'<button onclick="submit_update_request()" type="button" style="margin: 2px;" class="btn btn-default">완료</button>'
          }
       else{
          a+='<a href="javascript:history.go(-1)"><button type="button" style = "margin : 2px;" class="btn btn-default">취소</button></a>'
          +'<button onclick="submit_request()" type="button" style="margin: 2px;" class="btn btn-default">완료</button>'
          }
       
       button_area.append(a);    
    }
       
    function check_user(){   //관리자,교수 or 보기,수정일 경우 log-data가져와 show
       var user = <%=user%>
       var modify = <%=modify%>
       if(user.type.includes("관리자")||user.type.includes("교수")||modify==2||modify==1){
          show_log();
       }
    }
    function show_log(){//grd_log 를 받아와 show 하는 function
       var log = <%=stage_data%>
       var arr = log.logetc.split("/");
       var text = '';
       var etc = document.getElementsByName("etc");//체크박스들 이름
       for(var i =0 ; i <5 ; i++){
          for(var j =0;j<(arr.length-1);j++){
             if(i==4){
                if(arr[j].includes("기타")){
                   $("[name=etc4_text]").attr('value', (arr[j].split("(기타)"))[0]);
                   etc[i].checked=true;
                }
             }
             if(document.getElementsByName("etc")[i].value == arr[j]){
                etc[i].checked=true;
                }
             }
          }
       var modify = <%=modify%>;
       if(modify=="1"){
          $('input:checkbox[name=agreement]').each(function(){
                   $(this).prop("checked",true);
                   $(this).prop("disabled",false);
                });
          $('input:checkbox[name=etc]').each(function(){
                $(this).prop("disabled",false);
             });
       }else if(modify=="2"){
          $('input:checkbox[name=agreement]').each(function(){
                   $(this).prop("checked",true);
                   $(this).prop("disabled",true);
                });
          $('input:checkbox[name=etc]').each(function(){
                $(this).prop("disabled",true);
             });
       }
       }
    function insertgrduser(){//modal에 승인을위해 값을 입력하는 function
       var subDBuser=<%=reqstudent%>;
       var proflist=<%=proflist%>;
          var list = $('#myModalbody2');
          var today = new Date();
          var year = today.getFullYear();
          var a = '<div class="form-group"><label for="InputID">학번</label><div class="input-group"><input onkeypress="changeID()" type="text" class="form-control" value="'+subDBuser.per_id+'" id="InputID" readonly></div></div>';
          a += '<div class="form-group" id="name1"><label for="InputName">이름</label><div class="input-group"><input onkeypress="changeID()" type="text" class="form-control" value="'+subDBuser.name+'" id="InputName" readonly></div></div>';
          
          a += '<div class="form-group" id="major"><label for="InputMajor">학과</label><div class="input-group"><input onkeypress="changeID()" type="text" class="form-control" value="'+subDBuser.major+'" id="InputMajor" readonly></div></div>';
          
          a += '<div class="form-group"><label for="Inputprofessor" style="display :inline-block">지도교수 배정</label><select class="form-control" id="Inputprofessor"><option>선택해주세요</option>';
         if(subDBuser.prof_name=='미정'){
            for(var i=0;i<proflist.length;i++){
                 a+='<option>'+proflist[i]+'</option>';
              }
         }else
            a+='<option selected>'+subDBuser.prof_name+'</option>';
         
          a+='</select></div>';
          a += '<div class="form-group"><label for="Inputcapstone" style="display :inline-block">캡스톤이수여부</label><select class="form-control" id="Inputcapstone">';
         if(subDBuser.capstone==0)
          a+='<option>선택해주세요</option><option>미이수</option><option>이수중</option><option>이수</option><option>해당없음</option></select></div>'; 
         else if(subDBuser.capstone==1)
             a+='<option>이수중</option></select></div>';//수정...
         else if(subDBuser.capstone==2)
            a+='<option>이수</option></select></div>';
         else if(subDBuser.capstone==3)
               a+='<option>해당없음</option></select></div>';
          a += '<div class="form-group"><label for="InputGraduation_date" style="display :inline-block">졸업년도</label><div class="input-group"><input onkeypress="changeID()" type="text" class="form-control" value="'+subDBuser.graduation_date+'" id="InputGraduation_date" readonly></div></div>';   
          a += '<div class="col-xs-13 text-right"><button class="btn btn-default" onclick="insertonegrduser()">신청서승인</button></div>';
          a += '<input type="submit" onclick="insertonegrduser()" style="display : none">';
           list.html(a);
       }
    function insertonegrduser(){//modal을 통해 승인된 정보를 정식DB에 넣기위한 function
               var per_id =$('#InputID').val();
               var name = $('#InputName').val();
               var date = $('#InputGraduation_date').val();
               var capstone = $('#Inputcapstone').val();
               var prof=$('#Inputprofessor').val();
               var major=$('#InputMajor').val();
               
               
               if(prof=="선택해주세요"){
                  alert("지도교수를 선택해주세요");
                  return 0;
               }
               if(capstone=="선택해주세요"){
                  alert("캡스톤여부를 선택해주세요");
                  return 0;
               }
                  var update = per_id+"-/-/-"+name+"-/-/-"+date+"-/-/-"+capstone+"-/-/-"+prof+"-/-/-"+major;
                  $.ajax({
                     url:"ajaxuser.do",
                     type:"post",
                     data:{
                        req:"req_insertgrduser",
                        data: update
                     },
                     success:function(data){
                        alert("학번 : "+data+"  추가 완료");
                        window.location.href="graduation_admin.do?num=95"
                        }
                     });
         }
    function req_refuse(){
       var subDBuser = <%=subDBuser%>;
       var per_id = subDBuser.per_id;
       var update = per_id+"-/-/-"+"신청접수";
       $.ajax({
             url:"ajax.do",
             type:"post",
             data:{
                req:"req_refuse",
                data: update
             },
             success:function(data){
                alert("학번 : "+per_id+" 승인반려");
                window.location.href='graduation_admin.do?num=95';
                }
             });
       
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
   </script>
</body>
</html>