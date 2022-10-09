<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
   StringBuffer url2_grd_form_etc2 = request.getRequestURL();
   String logo_img_grd_form_etc2;

   //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
   //ai이면 ai로고 cs이면 cs로고
   if(url2_grd_form_etc2.substring(7,9).equals("ai") || url2_grd_form_etc2.substring(7,9).equals("lo")){
      logo_img_grd_form_etc2 = "img/graduation_ai.png";
   }
   else{
      logo_img_grd_form_etc2 = "img/graduation.png";
   }
   //System.out.println((logo_img_grd_form_etc2));
%>
<%
   String num = (String) request.getAttribute("num");
   String tabmenulist = (String) request.getAttribute("tabmenulist");//관리자탭메뉴
   String graduationuser = (String) request.getAttribute("graduationuser");
   String download=(String) request.getAttribute("download");
   String download2=(String) request.getAttribute("download2");
   String modify=(String) request.getAttribute("modify");
   String stage_data=(String) request.getAttribute("stage_data");
   String grduser = (String) request.getAttribute("grduser");//유저객체
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
   <script src="./js/default.js"></script>
   <script src="./js/jquery-3.2.1.min.js"></script>
   <script src='js/sha256.js'></script>
   <style>
      table {
         text-align : center;
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
         font-size: 13px;
         display: inline-block;
         border: 1px solid #607D8B;
         margin-right: 5px;
         padding-right: 5px;
         text-align: left;
         width: 380px;
         height: 120px
      }
      .explain2 {
         font-size : 12px;
         display: inline-block;
         margin-right: 5px;
         text-align: left;
         width: 630px;
         height: 100px;
         line-height : normal;
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
         <img src=<%=logo_img_grd_form_etc2%> />
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
                  <div class="contenttitle" style="display : inline-block">기타자격 / 공모전 제출</div>
                  <div id="etc_button" style="float : right"></div>
               </li>
            </ul>
            <div>
               <div id="hey">
                  <div><!-- 학생정보 div -->
                     <div class="contenttitle2">학생정보</div>
                     <table id="graduation_user_info" class="table table-bordered" style="font-size : 13px; border : 2px solid #ddd; margin-bottom : 0;">
                     </table>
                  </div>
                  <br>
                  <div class="contenttitle2">공모전</div>
                  <div id="modify_main" class="graduation_read_info" style="border : 1.5px solid #ddd"><!-- 졸업논문div -->
                     <ul>
                        <li>
                           <div style="display : flex;">
                              <div class="profile">공모전명</div>
                              <div class="form-group">
                                 <input type="text" class="form-control" id="contest_name" placeholder="제목을 입력하세요" style="width : 620px">
                              </div>
                           </div>
                        </li>
                        <li>
                           <div style="display:flex">
                              <div class="profile">팀유형</div>
                              <div>
                                 <div style="margin-right:auto;font-size:12px;">
                                    <label class="radio-inline" style="margin-left : 5px"><input type="radio" name="select_license" value="1인팀" checked>1인팀</label>
                                    <label class="radio-inline" style="margin-left : 5px"><input type="radio" name="select_license" value="2인이상(경기대)" checked>2인이상(경기대)</label>
                                    <label class="radio-inline" style="margin-left : 5px"><input type="radio" name="select_license" value="2인이상(타대학연합)" checked>2인이상(타대학연합)</label>
                                 </div>
                              </div>
                        </li>
                        <li>
                           <div style="display:flex">
                              <div class="profile">시상내역</div>
                              <div class="form-group">
                                 <input type="text" class="form-control" id="price" style="width : 263px;" placeholder="직접 입력하세요">
                              </div>
                              <div class="profile" style="margin-left : 10px">개최기관</div>
                              <div class="form-group">
                                 <input type="text" class="form-control" id="openorgan" style="width : 263px;" placeholder="직접 입력하세요">
                              </div>
                           </div>
                        </li>
                        <li>
                           <div style="display:flex">
                              <div class="profile">시상일</div>
                              <input type="date" class="form-control" style="width:263px; margin-left : 5px;" id="receivedate" name = "new_date">
                              <div class="profile" style="margin-left : 10px">대회개최일</div>
                              <input type="date" class="form-control" style="width:263px; margin-left : 5px;" id="opencontest" name = "new_date">
                           </div>
                        </li>
                        <li>
                           <div id="uploadfile1" style="display:flex">
                              <div class="profile">상장사본</div>
                              <div style="margin-left:5px; margin-top : 7px"><input type="file" name="uploadFile" id="uploadFile" accept=".hwp, .doc, .docx, .pdf"></div>
                              <div style="margin-right:auto"><button class="btn btn-default" onclick="uploadfile(6)" style="padding: 3px 10px"><img src="img/uploadBtn.png"></button></div>
                           </div>
                        </li>
                        <li>
                           <div id="uploadfile2" style="display:flex">
                              <div class="profile">추가자료</div>
                              <div style="margin-left:5px; margin-top : 7px"><input type="file" name="uploadFile2" id="uploadFile2" accept=".hwp, .doc, .docx, .pdf"></div>
                              <div style="margin-right:auto"><button class="btn btn-default" onclick="uploadfile(7)" style="padding: 3px 10px"><img src="img/uploadBtn.png"></button></div>
                           </div>
                        </li>
                     </ul>
                  </div>
               </div>
               <div><!-- 서명 + 버튼div -->
                  <div id="sign" class="text-right">서명
                     <div class="form-group" style="display : inline-block">
                        <input type="text" class="form-control" id="signature" placeholder="본인의 이름을 입력">
                     </div>
                     <button type="button" style="margin: 2px;" class="btn btn-default" onclick="insert_etc2()">완료</button>
                     <a href="javascript:history.go(-1)"><button type="button" style="margin: 2px;" class="btn btn-default">취소</button></a>
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
   <p style="text-align:center">위의 내용을 확인하였으며, 이 학생의 졸업논문 기타자격 대체를 승인합니다.</p>
   <p style="border:white;text-align:right">상담일 : 2018년     월      일</p>
   <p id="professorname" style="text-align:right">지도교수 : 지도교수  (인)</p>

</div>
<script>
   var list = $('#tab_2');
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

   var user=<%=user%>;
   var grduser=<%=user%>;
   var graduationuser=<%=graduationuser%>;
   var userlist=$('#graduation_user_info');
   userlist.append(usertable(grduser,graduationuser));

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
      a += '<td style="background-color : #ECEFF1; font-weight: 600;">학번</td><td>' + graduationuser.per_id + '</td><td style="background-color : #ECEFF1; font-weight: 600;">졸업시기</td><td>'
              + graduationuser.graduation_date + '</td><td style="background-color : #ECEFF1; font-weight: 600;">지도교수</td><td>'
              + graduationuser.prof_name + '</td>';
      a += '</tr>';
      a += '<tr style="border-bottom : 1px solid #ddd">';
      a += '<td style="background-color : #ECEFF1; font-weight: 600;">이름</td><td>' + graduationuser.name + '<td style="background-color : #ECEFF1; font-weight: 600;">소속학과</td><td>' + graduationuser.major
              +'</td><td style="background-color : #ECEFF1; font-weight: 600;">지연횟수</td><td>'+graduationuser.delay_count+'회</td>';
      a += '</tr>';
      a += '<tr style="border-bottom : 1px solid #ddd">';
      a +=  '</td><td style="background-color : #ECEFF1; font-weight: 600;">기타자격</td><td>캡스톤 ' + c
              + '</td><td></td><td></td><td></td><td></td>';
      a += '</tr>';
      return a;
   }
   var uploadf1=null;
   var uploadf2=null;
   var hashfile1=null;
   var hashfile2=null;//다운로드 파일
   function uploadfile(sta){
      var formData = new FormData();
      var address="";

      if(sta==6){
         if($('input[name=uploadFile]')[0].files[0]==null){
            alert("파일이 없습니다.");
            return;
         }
         formData.append("file_data",$('input[name=uploadFile]')[0].files[0]);
         formData.append("stage", 6);
      }

      else if(sta==7){
         if($('input[name=uploadFile2]')[0].files[0]==null){
            alert("파일이 없습니다.");
            return;
         }
         formData.append("file_data",$('input[name=uploadFile2]')[0].files[0]);
         formData.append("stage", 7);
      }
      formData.append("writer",graduationuser.per_id);

      $.ajax({
         url : 'upload.do?writer='+graduationuser.per_id+'&stage='+ sta,
         type : "post",
         async:false,
         data : formData,
         processData : false,
         contentType : false,
         success : function(data){//데이터는 주소
            var file=data.split("-/-/-");
            var a='';
            if(sta==6)
               a+='<div class="profile">상장사본</div>';
            else if(sta==7)
               a+='<div class="profile">추가자료</div>';
            a+='<div style="margin-left: 5px">'+file[0]+'</div><div style="margin-right:5px; margin-left : 10px"><a href="download.do?id='+graduationuser.per_id+'&stage='+sta+'"><button class="btn btn-default" style="padding : 3px 10px;"><img src="img/downloadBtn.png"></button></a><button class="btn btn-default" onclick="modifyfilebutton(' + sta + ')" style="padding: 3px 10px; margin-left : 5px"><img src="img/removeBtn.png"></button></div></div></li>'
            if(sta==6){
               uploadf1=file[0];
               hashfile1=file[1];
            }
            else if(sta==7){
               uploadf2=file[0];
               hashfile2=file[1];
            }
            $('#uploadfile'+(sta-5)).html(a);
         }
      })

      return address;
   }
   //추가할것
   var modify=<%=modify%>;//1=수정 2=보기
   var stage_data=<%=stage_data%>;//데이터정보
   var download=<%=download%>;
   var download2=<%=download2%>;

   if(modify == 0 || modify == 1 || modify == 4 || modify == 5){
      var modifymain=$('#modify_main');
      var a='';

      a+='<ul><li><div style="display:flex"><div class="profile">공모전명</div><div class="form-group"><input type="text" class="form-control" id="contest_name" placeholder="제목을 입력하세요" style="width : 620px" value="' + stage_data.contest_name + '"></div></div></li>';
      a+='<li><div style="display:flex"><div class="profile">팀유형</div><div>';
      a+='<div style="margin-right:auto;font-size:12px;">';
      a+='<label class="radio-inline" style="margin-left : 5px"><input type="radio" name="select_license" value="1인팀" checked>1인팀</label>'
      a+='<label class="radio-inline" style="margin-left : 5px"><input type="radio" name="select_license" value="2인이상(경기대)" checked>2인이상(경기대)</label>'
      a+='<label class="radio-inline" style="margin-left : 5px"><input type="radio" name="select_license" value="2인이상(타대학연합)" checked>2인이상(타대학연합)</label></li>'
      a+='<li><div style="display:flex"><div class="profile">시상내역</div><div class="form-group"><input type="text" class="form-control" id="price" style="width : 263px;" placeholder="직접 입력하세요" value="' + stage_data.contest_content + '"></div><div class="profile" style="margin-left : 10px">개최기관</div><div class="form-group"><input type="text" class="form-control" id="openorgan" style="width : 263px;" placeholder="직접 입력하세요" value="' + stage_data.organization + '"></div></div>';
      a+='<li><div style="display:flex"><div class="profile">시상일</div><input type="date" class="form-control" style="width:263px; margin-left : 5px;" id="receivedate" name = "new_date" value ="'+formatDateToNum(stage_data.award_date)+'"><div class="profile" style="margin-left : 10px">대회개최일</div><input type="date" class="form-control" style="width:263px; margin-left : 5px;" id="opencontest" name = "new_date" value ="'+formatDateToNum(stage_data.open_date)+'"></div>';
      a+='<li><div id="uploadfile1" style="display:flex"><div class="profile">상장사본</div>';
      a+='<div style="margin-left: 5px">'+download+'</div><div style="margin-right:5px; margin-left : 10px"><a href="download.do?id='+graduationuser.per_id+'&stage=6"><button class="btn btn-default" style="padding : 3px 10px;"><img src="img/downloadBtn.png"></button></a><button class="btn btn-default" onclick="modifyfilebutton(6)" style="padding: 3px 10px; margin-left : 5px"><img src="img/removeBtn.png"></button></div></div></li>';
      a+='<li><div id="uploadfile2" style="display:flex">';
      a+='<div class="profile">추가자료</div>';
      a+='<div style="margin-left: 5px">'+download2+'</div><div style="margin-right:5px; margin-left : 10px"><a href="download.do?id='+graduationuser.per_id+'&stage=7"><button class="btn btn-default" style="padding : 3px 10px;"><img src="img/downloadBtn.png"></button></a><button class="btn btn-default" onclick="modifyfilebutton(7)" style="padding: 3px 10px; margin-left : 5px"><img src="img/removeBtn.png"></button></div></div></li></ul>';
      modifymain.html(a);
      $('input:radio[name=select_license]').each(function(){
         if($(this).val()==stage_data.team_type)
            $(this).prop("checked",true);
      });
   }

   if(modify == 0 || modify == 4){
      var sign=$('#sign');
      var etc_button=$('#etc_button');
      var a='';

      var b='<div class="text-right"><a href="javascript:history.go(-1)"><button type="button" style = "margin : 2px;" class="btn btn-default">취소</button></a>';
      b+='<a onclick="printview()" class="btn btn-default">인쇄</a>';

      sign.html(b);
      etc_button.html(a);
   }

   else if(modify == 1){
      var sign=$('#sign');
      var etc_button=$('#etc_button');
      var a='';

      var b = '<div class="form-group" style="display: inline-block"><input type="text" class="form-control" id="signature" placeholder="본인의 이름을 입력"></div>';
      b+='<div class="text-right"><a href="javascript:history.go(-1)"><button type="button" style = "margin : 2px;" class="btn btn-default">취소</button></a>';
      b+='<a onclick = "insert_etc2()"><button type="button" class="btn btn-default">수정</button></a><a onclick="printview()" class="btn btn-default">인쇄</a></div>';

      sign.html(b);
      etc_button.html(a);
   }

   else if(modify == 5){
      var sign=$('#sign');
      var etc_button=$('#etc_button');
      var a='';

      var b='<div class="text-right"><a href="javascript:history.go(-1)"><button type="button" style = "margin : 2px;" class="btn btn-default">취소</button></a>';
      b+='<button type="button" class="btn btn-default" onclick="success()" >승인</button><button type="button" class="btn btn-default" onclick="refuse()">반려</button><a onclick="printview()" class="btn btn-default">인쇄</a></div>';

      sign.html(b);
      etc_button.html(a);
   }

   function modifyfilebutton(sta){
      var a='';
      if(sta==6){
         a+='<div class="profile">상장사본</div><div style="margin-left:5px; margin-top : 7px"><input type="file" name="uploadFile" id="uploadFile" accept=".hwp, .doc, .docx, .pdf"></div><div><button class="btn btn-default" onclick="uploadfile(' + sta + ')" style="padding: 3px 10px"><img src="img/uploadBtn.png"></button></div>';
         a+='<div style="margin-left : 5px"><button class="btn btn-default" onclick="cancelfile(' + sta + ')" style="padding : 6px 10px">취소</button></div>';
         $('#uploadfile1').html(a);
      }else if(sta==7){
         a+='<div class="profile">추가자료</div><div style="margin-left:5px; margin-top : 7px"><input type="file" name="uploadFile2" id="uploadFile2" accept=".hwp, .doc, .docx, .pdf"></div><div><button class="btn btn-default" onclick="uploadfile(' + sta + ')" style="padding: 3px 10px"><img src="img/uploadBtn.png"></button></div>';
         a+='<div style="margin-left : 5px"><button class="btn btn-default" onclick="cancelfile(' + sta + ')" style="padding : 6px 10px">취소</button></div>';
         $('#uploadfile2').html(a);
      }

   }
   function cancelfile(sta){
      var a='';
      if(sta==6) {
         a+='<div class="profile">상장사본</div>';
         if(modify=="1")   {
            a+='<div style="margin-left: 5px">'+download+'</div><div style="margin-right:5px; margin-left : 10px"><a href="download.do?id='+graduationuser.per_id+'&stage=6"><button class="btn btn-default" style="padding : 3px 10px;"><img src="img/downloadBtn.png"></button></a><button class="btn btn-default" onclick="modifyfilebutton('+sta+')" style="padding: 3px 10px; margin-left : 5px"><img src="img/removeBtn.png"></button></div>';
         }
         else{
            a+='<div style="margin-left: 5px">'+uploadf1+'</div><div style="margin-right:5px; margin-left : 10px"><a href="download.do?id='+graduationuser.per_id+'&stage=6"><button class="btn btn-default" style="padding : 3px 10px;"><img src="img/downloadBtn.png"></button></a><button class="btn btn-default" onclick="modifyfilebutton('+sta+')" style="padding: 3px 10px; margin-left : 5px"><img src="img/removeBtn.png"></button></div>';
         }
         $('#uploadfile1').html(a);
      }
      else if(sta==7){
         if(modify=="1"){
            a+='<div class="profile">추가자료</div>';
            a+='<div style="margin-left: 5px">'+download2+'</div><div style="margin-right:5px; margin-left : 10px"><a href="download.do?id='+graduationuser.per_id+'&stage=7"><button class="btn btn-default" style="padding : 3px 10px;"><img src="img/downloadBtn.png"></button></a><button class="btn btn-default" onclick="modifyfilebutton('+sta+')" style="padding: 3px 10px; margin-left : 5px"><img src="img/removeBtn.png"></button></div>';
         }else{
            a+='<div class="profile">추가자료</div>';
            a+='<div style="margin-left: 5px">'+uploadf2+'</div><div style="margin-right:5px; margin-left : 10px"><a href="download.do?id='+graduationuser.per_id+'&stage=7"><button class="btn btn-default" style="padding : 3px 10px;"><img src="img/downloadBtn.png"></button></a><button class="btn btn-default" onclick="modifyfilebutton('+sta+')" style="padding: 3px 10px; margin-left : 5px"><img src="img/removeBtn.png"></button></div>';
         }
         $('#uploadfile2').html(a);
      }
   }

   function insert_etc2(){
      var modi='';

      var signature=$('#signature').val();
      if(signature==user.name){
         var obj =new Object();
         obj.per_id=user.per_id;
         obj.name=$('#contest_name').val();
         var check = document.getElementsByName('select_license');
         var checked_value = '';
         for (var i = 0; i < check.length; i++) {
            if (check[i].checked) {
               checked_value = check[i].value;
            }
         }
         obj.license=checked_value;
         obj.price=$('#price').val();
         obj.openorgan=$('#openorgan').val();
         obj.receivedate=$('#receivedate').val();
         obj.opencontest=$('#opencontest').val();
         obj.file1=hashfile1;
         obj.file2=hashfile2;
         if(modify=="1"){
            modi="modify";
            if(obj.file1==null){
               obj.file1=stage_data.award_filename;
            }
            if(obj.file2==null){
               obj.file2=stage_data.add_filename;
            }
         }

         if(obj.name!=null&&obj.license!=''&&obj.price!=null&&obj.openorgan!=null&&obj.receivedate!=null&&obj.opencontest!=null&&obj.file1!=null&&obj.file2!=null){
            var jsonobj=JSON.stringify(obj);
            $.ajax({
               url:"ajax.do",
               type:"post",
               data:{
                  req:"insert_etc2",
                  data: jsonobj,
                  modify:modi
               },
               success :function(data){
                  alert(user.name+"["+data+"]님의 공모전 보고서가 제출 되었습니다.");
                  window.location.href="graduation_intro.do?num=94"
               }

            })
         }else
            alert("모두 입력해주세요");
      }else
         alert("서명을 확인해주세요");

   }
   function success(){
      var con_test = confirm("기타자격(공모전 시상)을 승인하시겠습니까?");
      if(con_test==true){
         $.ajax({
            url : "ajax.do",
            type : "post",
            data :{
               req : "success_grd",
               data : graduationuser.per_id,
               state : "공모전"
            },
            success : function(data){
               alert("승인되었습니다.");
               window.location.href="graduation_manage.do?num=94&perid="+graduationuser.per_id;
            }
         })
      }
   }
   function refuse(){
      var con_test = confirm("기타자격(공모전 시상)을 반려하시겠습니까?");

      if(con_test==true){
         var name =prompt("반려 사유를 입력하세요");
         if(name!=''){
            $.ajax({
               url : "ajax.do",
               type : "post",
               data :{
                  req : "refuse_grd",
                  data : graduationuser.per_id+"-/-/-"+name,
                  state : "공모전"
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
      $('#submit_suggest_date').html('제출일 : '+formatData(stage_data.submit_date));
      $('#submit_name').html('신청자 : '+graduationuser.name+'[서명]');
      $('#professorname').html('지도교수 :'+graduationuser.prof_name+' (인)');
      $("#dele1").html('');
      $("#dele2").html('');
      const main ='<br><h2 style="text-align:center">컴퓨터과학과 졸업논문 기타자격제출 (공모전)<h2><br>';
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
      $("#dele1").html('<a href="download.do?id='+graduationuser.per_id+'&stage=6"><button class="btn btn-default" style="padding : 3px 10px; margin-left : 10px"><img src="img/downloadBtn.png"></button></a>');
      $("#dele2").html('<a href="download.do?id='+graduationuser.per_id+'&stage=7"><button class="btn btn-default" style="padding : 3px 10px; margin-left : 10px"><img src="img/downloadBtn.png"></button></a>');
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

   function formatDateToNum(date) {
      var d = new Date(date),
              month = '' + (d.getMonth() + 1),
              day = '' + d.getDate(),
              year = d.getFullYear();

      if (month.length < 2) month = '0' + month;
      if (day.length < 2) day = '0' + day;

      return [year, month, day].join('-');
   }
</script>
</body>
</html>