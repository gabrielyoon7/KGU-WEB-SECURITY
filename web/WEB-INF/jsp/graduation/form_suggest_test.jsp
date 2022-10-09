<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
    StringBuffer url2_grd_form_sug = request.getRequestURL();
    String logo_img_grd_form_sug;

    //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
    //ai이면 ai로고 cs이면 cs로고
    if(url2_grd_form_sug.substring(7,9).equals("ai") || url2_grd_form_sug.substring(7,9).equals("lo")){
        logo_img_grd_form_sug = "img/graduation_ai.png";
    }
    else{
        logo_img_grd_form_sug = "img/graduation.png";
    }
    //System.out.println((logo_img_grd_form_sug));
%>
<%
   String num = (String) request.getAttribute("num");
   String tabmenulist = (String) request.getAttribute("tabmenulist");//관리자탭메뉴
   String grduser = (String) request.getAttribute("grduser");//유저객체
   String graduationuser = (String) request.getAttribute("graduationuser");
   String stage_data=(String) request.getAttribute("stage_data");
   String modify=(String) request.getAttribute("modify");
   String grduseretc = (String)request.getAttribute("grduseretc");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta name="subject"
   content="Kyonggi University Department of Computer Science">
<meta name="author" content="Kyonggi Univ. SSF">
<meta name="keyword"
   content="경기대학교, 컴퓨터과학과, Kyonggi University, Computer Science">
<meta name="viewport" content="width=device-width, initial scale=1.0">
<meta charset="utf-8">
<title>경기대학교 AI컴퓨터공학부</title>
<link href='./css/default.css' rel='stylesheet' type='text/css'>
<link href='./css/boardtable.css' rel='stylesheet' type='text/css'>
<link href='./css/content.css' rel='stylesheet' type='text/css'>
<link href='css/bootstrap.css' rel='stylesheet' type='text/css'>
<link href='./css/information.css' rel='stylesheet' type='text/css'>
<script src="./js/default.js"></script>
<script src="./js/jquery-3.2.1.min.js"></script>
<script src="./js/bootstrap.min.js"></script>
<style>
.table{
   text-align:center;
}
.graduation_write_info {
   padding: 5px;
   border: 1px solid #607D8B;
   font-size: 13px;
   display: flex;
   margin: auto;
   margin-bottom: 10px;
}

.graduation_read_info {
   padding: 5px;
   border: 1px solid #607D8B;
   font-size: 13px;
   display: flex;
   margin: auto;
   margin-bottom: 10px;
}

.inform {
   display: inline-flex;
   text-align: left;
   margin-left : 5px;
   width : 620px;
   overflow-wrap:break-word;
   height : auto;
   padding-bottom:inherit;
}

.profile {
   background-color : #ECEFF1;
   font-weight: bold;
   display: inline-block;
   width: 80px;
   text-align: right;
   padding-right : 5px;
   height : auto;
   padding-bottom:inherit;
}

.explain {
   display: inline-block;
   border: 1px solid #607D8B;
   margin-right: 5px;
   padding-right: 5px;
   text-align: left;
   width: 380px;
   height: 120px;
  
}

.form-group {
   margin-bottom : 0;
   margin-left : 5px;
}

</style>
</head>
<body>
   <%@include file="../main/header.jsp"%>
    <main>
   <div id="content">
      <div id="title">
          <img src=<%=logo_img_grd_form_sug%> />
         <div>졸업논문</div>
      </div>
      <div id="container">
         <div id="tab">
            <ul id="tab_2">
            </ul>
         </div>
         <div id="maincontent">
            <ul>
               <li><div class="contenttitle">제안서 제출</div></li>
            </ul>
            <div>
               <div id="hey">
                     <!-- 학생정보 div -->
                     <div class="contenttitle2">학생정보</div>
                     <table id="usertable" class="table table-bordered" style="font-size : 13px; border : 2px solid #ddd; margin-bottom : 0;">
               </table>
               <br>
                  <div>
                     <!-- 졸업논문div -->
                     <div class="contenttitle2">졸업논문내용</div>
                     <div id="modify_main" class="graduation_read_info" style="border : 1.5px solid #ddd">
                        <ul style="width : auto">
                           <!-- 학생정보 div -->
                           <li>
                                 <div style="display: flex">
                                 <div class="profile">제목</div>
                                 <div class="form-group">
                            <input type="text" class="form-control" id="suggest_name" placeholder="제목을 입력하세요" style="width : 620px">
                          </div>
                          </div>
                           </li>
                           <li>
                                 <div class="profile">구분</div>
                                 <label class="radio-inline" style="margin-left : 5px">
                             <input type="radio" name="thesis" value="구현논문">구현논문
                         </label>
                                 <label class="radio-inline" style="margin-left : 20px">
                             <input type="radio" name="thesis" value="조사(이론)논문">조사(이론)논문
                         </label>
                           </li>
                           <li>
                              <div style="display : flex">
                                 <div class="profile">키워드</div>
                                 <div id=keyword_field style="display:inline-block; width : 600px">
                                       <div class="form-group" style="display : inline-block">
                                  <input type="text" class="form-control" id="kwd0" placeholder="키워드">
                                </div>
                                        <div class="form-group" style="display : inline-block; margin-left : 1px">
                                  <input type="text" class="form-control" id="kwd1" placeholder="키워드">
                                </div>
                                       <a id="more_keyword" title="키워드추가" onclick="create_keyword()"><img src="img/plus_ico.png" alt=""></a>   
                                 </div>
                            </div>
                           </li>
                           <li>
                              <div style="display : flex">
                                 <div class="profile" style="padding-top : 85px">내용</div>
                                    <div class="form-group" style="display : inline-block; width : 620px;">
                            <textarea class="form-control" id="suggest_content" rows=10></textarea>
                             </div>
                       </div>
                           </li>
                        </ul>
                     </div>
                  </div>
                    </div>
                    <div>
                  <div>
                        <div id="sign" class="text-right">서명
                        <div class="form-group" style="display : inline-block">
                      <input type="text" class="form-control" id="signature" placeholder="본인의 이름을 입력">
                    </div>
                        <button type="button" style="margin: 2px;" class="btn btn-default" onclick="submit_suggest()">완료</button>
                        <a href="javascript:history.go(-1)"><button type="button" style="margin: 2px;" class="btn btn-default">취소</button></a>
                        </div>
                  </div>
               </div>
            </div>
         </div>
            </div>
      </div>
   </main>
   <div id="sangdam" style="display:none">
   <p id="submit_suggest_date"style="text-align:right">제출일 : 2018년  월   일</p>
   <p id="submit_name" style="text-align:right">신청자 : ......[인]</p>
      <h3 style="text-align:center">지도교수 상담확인서</h3>
       
         <table class="table table-bordered">
         <tr><td><p style="text-align:left">교수 의견 :</p>
         <br><br><br>
        </td></tr><!-- 여기 수정필요 -->
      </table>
       <p style="text-align:center">위의 제안서 내용을 승인하며 이 학생의 졸업논문을 지도하겠습니다.</p>
         <p style="border:white;text-align:right">상담일 : 2018년     월      일</p>
         <p id="professorname" style="text-align:right">지도교수 : 지도교수  (인)</p>
      
   </div>
   <%@include file="../main/footer.jsp"%>
   <div id="shadow">
      <div id="blur"></div>
   </div>
   
   <script>
      var list = $('#tab_2');
      var tabmenu =
   <%=tabmenulist%>
      ;
      var number =
   <%=num%>
      ;
      for (var i = 0; i < tabmenu.length; ++i) {
         var value = tabmenu[i];
         var num = value.tab_id * 10 + value.orderNum;
         var text = '<li><span class="deco_dot">●</span><a href="'
               + value.path + '?num=' + num + '">' + value.page_title
               + '</a></li>'
         list.append(text);
      }
   </script>
   <script>
   var keyword_count = 1;
   var keyword_counttext = 1;
   var user=<%=user%>;
     var grduser=<%=grduser%>;
   var graduationuser=<%=graduationuser%>;
     var userlist=$('#usertable');
     userlist.append(usertable(grduser,graduationuser));
     var memory = [0];
     function usertable(grduser, graduationuser) {
    	 var grduseretc = <%=grduseretc%>;
         var c="";
         if(grduseretc.capstone==2){
            c="이수 (제출 가능)";
         }else if(grduseretc.capstone==1){
            c="이수중 (제출 가능)";
         }else if(grduseretc.capstone==0){
            c="미이수";
         }else
            c="해당없음 (제출 가능)";
         var a = '';
         a += '<tr style="border-bottom : 1px solid #ddd">';
         a += '<td style="background-color : #ECEFF1; font-weight: 600;">학번</td><td>' + graduationuser.per_id + '</td><td style="background-color : #ECEFF1; font-weight: 600;">졸업시기</td><td>'
               + graduationuser.graduation_date + '</td><td style="background-color : #ECEFF1; font-weight: 600;">지도교수</td><td>'
               + graduationuser.prof_name + '</td>';
         a += '</tr>';
         a += '<tr style="border-bottom : 1px solid #ddd">';
         a += '<td style="background-color : #ECEFF1; font-weight: 600;">이름</td><td>' + graduationuser.name + '<td style="background-color : #ECEFF1; font-weight: 600;">소속학과</td><td>' + grduser.major
         +'</td><td style="background-color : #ECEFF1; font-weight: 600;">지연횟수</td><td>'+graduationuser.delay_count+'회</td>';
         a += '</tr>';
         a += '<tr style="border-bottom : 1px solid #ddd">';
         a +=  '</td><td style="background-color : #ECEFF1; font-weight: 600;">기타자격</td><td>캡스톤 ' + c
               + '</td><td></td><td></td><td></td><td></td>';
         a += '</tr>';
         return a;
      }
     var modify=<%=modify%>;//1=수정 2=보기
   var stage_data=<%=stage_data%>;//데이터정보
     if(modify==1){//name(answer_1), checked_value(answer_2), keyword(answer_3), content(answer_4)
         var modifymain=$('#modify_main');
       var a='';  
       memory = [];
       var keyword=stage_data.keyword.split("/"); //keyword
         a+='<ul>';
       a+='<li><div style="display: flex"><div class="profile">제목</div><div class="form-group"><input type="text" class="form-control" id="suggest_name" placeholder="제목을 입력하세요" style="width : 620px" value="' + stage_data.title + '"></div></div></li>';
       a+='<li>';
       a+='<div class="profile">구분</div>';
       if(stage_data.classification=="구현논문"){ //classification
          a+='<label class="radio-inline" style="margin-left : 5px"><input type="radio" name="thesis" value="구현논문" checked>구현논문</label><label class="radio-inline" style="margin-left : 20px"><input type="radio" name="thesis" value="조사(이론)논문">조사(이론)논문</label></li>';
       }else{
         a+='<label class="radio-inline" style="margin-left : 5px"><input type="radio" name="thesis" value="구현논문">구현논문</label><label class="radio-inline" style="margin-left : 20px"><input type="radio" name="thesis" value="조사(이론)논문" checked>조사(이론)논문</label></li>';
       }
       a+='<li><div style="display: flex"><div class="profile">키워드</div><div id=keyword_field style="display:inline-block; width : 600px">';
       for(var i=0;i<(keyword.length-1);i++){
          a+= '<div id="kwddiv' + (i/2) + '"><div class="form-group" style="display : inline-block"><input type="text" class="form-control" id="kwd' + i + '" placeholder="키워드" value="' + keyword[i] + '"></div><div class="form-group" style="display : inline-block"><input type="text" class="form-control" id="kwd' + (i+1) + '" placeholder="키워드" value="' + keyword[i+1] + '"></div>';
          memory.push(i/2);
          if(i==0)
          a+='<a id="more_keyword" title="키워드추가" onclick="create_keyword()"><img src="img/plus_ico.png" alt=""></a></div>';
          else{
             a += '<a title="키워드추가" onclick="create_keyword()" style="margin-right:5px"><img src="img/plus_ico.png" alt=""></a>';
             a += '<a title="키워드삭제" onclick="delete_keyword('+(i/2)+')" style="margin-right:5px"><img src="img/minus_ico.png" alt=""></a></div>';
          }
          i++;
       }
      
       a+='</div></li>';
       a+='<li><div style="display: flex"><div class="profile">내용</div><div class="form-group" style="display : inline-block; width : 620px"><textarea class="form-control" id="suggest_content" rows=10>'+stage_data.proposal_content+'</textarea></div></div></li></ul>'; 
       modifymain.html(a);
       keyword_count = keyword.length;
      }else if(modify==2){
           var modifymain=$('#modify_main');
           var sign=$('#sign');
          var a='';
          var b='<div class="text-right"><a href="javascript:history.go(-1)"><button type="button" style = "margin : 2px;" class="btn btn-default">취소</button></a>';
            if((user.type.includes("관리자")||user.type.includes("교수"))){
               if(graduationuser.suggest>=6){ //suggest가 6,7일때만 관리자가 보기로 누를 수 있다.
                  if(graduationuser.suggest==6)
                b+='<button type="button" class="btn btn-default" onclick="success()">승인</button><button type="button" class="btn btn-default" onclick="refuse()">반려</button><a onclick="printview()" class="btn btn-default">인쇄</a></div>';
               }else
                 b+='<a onclick="printview()" class="btn btn-default">인쇄</a>';  
            }else
               if(graduationuser.suggest==6)
                       b+='<a href="graduation_form.do?per_id='+graduationuser.per_id+'&num=94&stage=2&modify=1"><button type="button" class="btn btn-default">수정</button></a><a onclick="printview()" class="btn btn-default">인쇄</a></div>';
                   else
                       b+='<a onclick="printview()" class="btn btn-default">인쇄</a></div>';
          sign.html(b);
          
          var keyword=stage_data.keyword.split("/");
          a+='<ul>';
          a+='<li><div style="width:709px;"><div class="profile">제목 </div><div class="inform">'+stage_data.title+'</div></div></li>';
          a+='<li><div id="radionth" style="display: flex">';
          a+='<div class="profile">구분 </div>';
          if(stage_data.classification=="구현논문"){
              a+='<label class="radio-inline" style="margin-left : 5px"><input type="radio" name="thesis" value="구현논문" checked>구현논문</label><label class="radio-inline disabled" style="margin-left : 20px"><input type="radio" disabled="disabled" name="thesis" value="조사(이론)논문">조사(이론)논문</label>   </li>';
          }else{
              a+='<label class="radio-inline disabled" style="margin-left : 5px"><input type="radio" name="thesis" value="구현논문" disabled="disabled">구현논문</label><label class="radio-inline" style="margin-left : 20px"><input type="radio" name="thesis" value="조사(이론)논문" checked>조사(이론)논문</label></li>';
          }
          a+='<li><div style="display: flex"><div class="profile">키워드 </div><div id=keyword_field>';
          for(var i=0;i<(keyword.length-1);i++){
             a+= '<div id="kwddiv' + (i/2) + '"><div class="form-group" style="display : inline-block"><input type="text" class="form-control" id="kwd' + i + '" placeholder="키워드" value="' + keyword[i] + '" readonly></div>';
             if(keyword[i+1]!='')
                a+='<div class="form-group" style="display : inline-block"><input type="text" class="form-control" id="kwd' + (i+1) + '" placeholder="키워드" value="' + keyword[i+1] + '" readonly></div>'
             i++;
          }
          a+='</div>'
          a+='<li><div style="display: flex"><div class="profile">내용 </div><div class="inform">'+stage_data.proposal_content+'</div></div></li></ul>';
          modifymain.html(a);  
      }
   
   function create_keyword() {//2번부터시작
      var keyword_field = $('#keyword_field');
      var keyword_id = 'kwddiv' + (++keyword_count)/2;
      var a = '';
      a += '<div id="'+keyword_id+'">'
      memory.push((keyword_count)/2);
      a += '<div class="form-group" style="display : inline-block"><input type="text" class="form-control" id="kwd' + keyword_count + '" placeholder="키워드"></div>';
      keyword_count++;
      a += '<div class="form-group" style="display : inline-block"><input type="text" class="form-control" id="kwd' + keyword_count + '" placeholder="키워드"></div>';
      a += '<a  title="키워드추가" onclick="create_keyword()" style="margin-right:5px"><img src="img/plus_ico.png" alt=""></a>';
      a += '<a  title="키워드삭제" id="imgminus" onclick="delete_keyword('+ (keyword_count-1)/2+ ')" style="margin-right:5px"><img src="img/minus_ico.png" alt=""></a></div>';
      
      keyword_field.append(a);
   }
   
   function delete_keyword(keyword_id) {
      var keyword_field = $('#kwddiv' + keyword_id);
      keyword_field.remove();
      memory.splice(memory.indexOf(keyword_id),1);

   }
   
   function submit_suggest(){
      var modi="";
      if(modify=="1"){
         modi="modify";
      }
      var signature=$('#signature').val();
      var user =<%=user%>;
      if(signature==user.name){
      var name=$('#suggest_name').val();
      var check = document.getElementsByName('thesis');
      var checked_value = '';
      for (var i = 0; i < check.length; i++) {
         if (check[i].checked) {
            checked_value = check[i].value;
         }
      }
   
      var keyword='';
      for(var j=0;j<memory.length;j++){
         var value= memory[j] * 2;
         var t= '#kwd'+value;
         var text=$(t).val();
         if(text != '')
               keyword+=text+"/";
         var t= '#kwd'+(value+1);
         var text=$(t).val();
         if(text != '')
               keyword+=text+"/";
      }
      var content=$('#suggest_content').val();
      
     var answer = user.per_id+"-/-/-"+name+"-/-/-"+checked_value+"-/-/-"+keyword+"-/-/-"+content;
    console.log(checked_value);
     if(check!=0&&name!=''&&keyword!=''&&content!='' && checked_value!=''){
      $.ajax({
         url:"ajax.do",
            type:"post",
            data : {
                  req : "submit_suggest",
                  data : answer,
                  modify : modi
            },
            success : function(data){
             alert(user.name+"["+data+"]님의 제안서가 제출 되었습니다.");
               window.location.href="graduation_intro.do?num=94";
            }
         
      })}
     else alert("모두 입력해주세요");
      }else{
         alert("서명 확인해주시기 바랍니다");
      }
   }
   
     function success(){
         var con_test = confirm("제안서를 승인하시겠습니까?");
         if(con_test==true){
             $.ajax({
                 url : "ajax.do",
                 type : "post",
                 data :{
                 req : "success_grd",
                 data : graduationuser.per_id,
                 state : "제안서"
             },
             success : function(data){
                 alert("승인되었습니다.");
                 window.location.href="graduation_manage.do?num=94&perid="+graduationuser.per_id;
             }
             })
         }
     }
     
     function refuse(){
          var con_test = confirm("제안서를 반려하시겠습니까?");

         if(con_test==true){
             var name =prompt("반려 사유를 입력하세요"); 
             if(name!=''){
             $.ajax({
                 url : "ajax.do",
                 type : "post",
                 data :{
                 req : "refuse_grd",
                 data : graduationuser.per_id+"-/-/-"+name,
                 state : "제안서"
             },
             success : function(data){
                 alert("반려되었습니다.");
                 window.location.href="graduation_manage.do?num=94&perid="+graduationuser.per_id;
             }
             })
         
     }else
        alert("반려사유를 입력하세요");
         }
     }
       function printview(){
          $('#submit_suggest_date').html('제출일 : '+formatData(graduationuser.suggest_action_date));
          $('#submit_name').html('신청자 : '+graduationuser.name+'[<span style="color:#ECEFF1">서명</span>]');
          $('#professorname').html('지도교수 :'+graduationuser.prof_name+' (인)');
          const main ='<br><h2 style="text-align:center">컴퓨터과학과 졸업논문 제안서<h2><br>';
          const html = document.querySelector('html');
          const printContents = document.querySelector('#hey').innerHTML;
          document.getElementById("sangdam").style.display = "block";
          const sangdam=document.querySelector('#sangdam').innerHTML;
          const printDiv = document.createElement('printDiv');
          printDiv.className = print-div;    
          html.appendChild(printDiv);
          printDiv.innerHTML = main; 
          printDiv.innerHTML += printContents;
          printDiv.innerHTML +=sangdam;
          document.body.style.display = 'none';
          
          window.print();
          document.body.style.display = 'block';
          printDiv.style.display = 'none';
          document.getElementById("sangdam").style.display = "none";
          var a='';
          a+='<div class="profile">구분 </div>';
          if(stage_data.classification=="구현논문"){
              a+='<label class="radio-inline" style="margin-left : 5px"><input type="radio" name="thesis" value="구현논문" checked>구현논문</label><label class="radio-inline disabled" style="margin-left : 20px"><input type="radio" disabled="disabled" name="thesis" value="조사(이론)논문">조사(이론)논문</label></li>';
          }else{
              a+='<label class="radio-inline disabled" style="margin-left : 5px"><input type="radio" name="thesis" value="구현논문" disabled="disabled">구현논문</label><label class="radio-inline" style="margin-left : 20px"><input type="radio" name="thesis" value="조사(이론)논문" checked>조사(이론)논문</label></li>';
          }
           $('#radionth').html(a);
        
       }
       function formatData(date) {
            var d = new Date(date), month = '' + (d.getMonth() + 1), day = ''
                  + d.getDate(), year = d.getFullYear();

            if (month.length < 2)
               month = '0' + month;
            if (day.length < 2)
               day = '0' + day;
      
            return  year+'년 '+month+'월 '+day+'일';
         }
   </script>
</body>
</html>