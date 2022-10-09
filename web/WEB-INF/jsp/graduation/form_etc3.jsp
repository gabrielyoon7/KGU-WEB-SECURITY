<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
String num = (String) request.getAttribute("num");
   String tabmenulist = (String) request.getAttribute("tabmenulist");//관리자탭메뉴
   String graduationuser = (String) request.getAttribute("graduationuser");
   String download=(String) request.getAttribute("download");
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
         <img src="img/graduation.png" alt="">
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
                  <div class="contenttitle" style="display : inline-block">기타자격 / 학술대회 제출</div>
               <div id="etc_button" style="float : right"></div>
               </li>
            </ul>
         <script>
         var etc=$('#etc_button');
         var a='';
         a+='<a href="graduation_form.do?per_id='+<%=graduationuser %>.per_id+'&num=94&stage=5"><button type="button" class="btn btn-default">공모전제출</button></a>';
         a+='<a href="graduation_form.do?per_id='+<%=graduationuser %>.per_id+'&num=94&stage=6"><button type="button" class="btn btn-default">자격증제출</button></a>';
         etc.html(a);
         </script>
            <div id="hey">
               <div>
                  <div class="contenttitle2">학생정보</div>
                  <table id="graduation_user_info" class="table table-bordered" style="font-size : 13px; border : 2px solid #ddd; margin-bottom : 0;">
                  </table>
               </div>
               <br>
               <div class="contenttitle2">학술대회</div>
               <div id="modify_main" class="graduation_read_info" style="border : 1.5px solid #ddd"><!-- 졸업논문div -->
                  <ul>
                     <li>
                        <div style="display : flex;">
                           <div class="profile">학술대회명</div>
                           <div class="form-group">
                               <input type="text" class="form-control" id="contest_name" placeholder="제목을 입력하세요" style="width : 620px">
                             </div>
                        </div>
                     </li>
                     <li>
                        <div style="display:flex">
                           <div class="profile">자격요건</div>
                           <div style="margin-right:auto;font-size:12px;">
                              <label class="checkbox-inline" style="margin-left : 5px;"><input type="checkbox" id="chkbox" value="제1저자">제1저자</label>
                              <label class="checkbox-inline" style="margin-left : 5px;"><input type="checkbox" id="chkbox" value="지도교수지도">지도교수지도</label>
                              <label class="checkbox-inline" style="margin-left : 5px;"><input type="checkbox" id="chkbox" value="발표완료">발표완료</label>
                              <label class="checkbox-inline" style="margin-left : 5px;"><input type="checkbox" id="chkbox" value="17.12.01이후">17.12.01이후</label>
                           </div>
                        </div>
                     </li>
                     <li>
                        <div style="display:flex;">
                           <div class="profile">논문제목</div>
                           <div class="form-group">
                               <input type="text" class="form-control" id="thesis" placeholder="제목을 입력하세요" style="width : 620px">
                             </div>
                        </div>
                     </li>
                     <li>
                        <div style="display:flex">
                           <div class="profile">개최기관</div>
                           <div class="form-group">
                               <input type="text" class="form-control" id="openplace" style="width : 263px;" placeholder="개최기관을 입력하세요">
                           </div>      
                           <div class="profile" style="margin-left : 10px">학회개시일</div>
                           <input type="date" class="form-control" style="width:263px; margin-left:5px;" id="Inputdate" name = "new_date">
                        </div>
                     </li>
                     <li>
                        <div id="uploadfile1" style="display:flex">
                           <div class="profile">논문파일</div>
                           <div style="margin-left:5px; margin-top : 7px"><input type="file" name="uploadFile" id="uploadFile" accept=".hwp, .doc, .docx, .pdf"></div>
                              <div style="margin-right:auto"><button class="btn btn-default" onclick="uploadfile(1)" style="padding: 3px 10px"><img src="img/uploadBtn.png"></button></div>
                        </div>
                     </li>
                     <li>
                        <div id="uploadfile2" style="display:flex">
                           <div class="profile">기타증빙</div>
                           <div style="margin-left:5px; margin-top : 7px"><input type="file" name="uploadFile2" id="uploadFile2" accept=".hwp, .doc, .docx, .pdf"></div>
                              <div style="margin-right:auto"><button class="btn btn-default" onclick="uploadfile(2)" style="padding: 3px 10px"><img src="img/uploadBtn.png"></button></div>
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
                  <button type="button" style="margin: 2px;" class="btn btn-default" onclick="insert_etc3()">완료</button>
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
   <%@include file="../main/footer.jsp"%>
   <div id="shadow">
      <div id="blur"></div>
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
   var grduser=<%=grduser%>;
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
    var uploadf1=null;
    var uploadf2=null;
    var hashfile1=null;
    var hashfile2=null;//다운로드 파일
    function uploadfile(id){
             var formData = new FormData();
             var address="";
             
             if(id==1){
                if($('input[name=uploadFile]')[0].files[0]==null){
                    alert("파일이 없습니다.");
                    return;
                 }
                formData.append("file_data",$('input[name=uploadFile]')[0].files[0]);
             }else if(id==2){
                if($('input[name=uploadFile2]')[0].files[0]==null){
                    alert("파일이 없습니다.");
                    return;
                 }
                formData.append("file_data",$('input[name=uploadFile2]')[0].files[0]);
             }
             formData.append("writer",graduationuser.per_id);
             $.ajax({
                url : "upload.do",
                type : "post",
                async:false,
                data : formData,
                  processData : false,
                  contentType : false,
                  success : function(data){//데이터는 주소
                      var file=data.split("-/-/-");
                     var a='';
                     if(id==1)
                           a+='<div class="profile">논문파일</div>';
                      else if(id==2)
                         a+='<div class="profile">기타증빙</div>';
                        a+='<div style="margin-left: 5px">'+file[0]+'</div><div style="margin-right:5px; margin-left : 10px"><a href="download.do?id='+file[1]+'"><button class="btn btn-default" style="padding : 3px 10px;"><img src="img/downloadBtn.png"></button></a><button class="btn btn-default" onclick="modifyfilebutton(' + id + ')" style="padding: 3px 10px; margin-left : 5px"><img src="img/removeBtn.png"></button></div></div></li>'
                     if(id==1){
                      uploadf1=file[0];
                      hashfile1=file[1];
                     }
                     else if(id==2){
                       uploadf2=file[0];
                       hashfile2=file[1];
                     }
                     $('#uploadfile'+id).html(a);
                  }
             })
          
          return address;
       }
    var modify=<%=modify%>;//1=수정 2=보기
    var stage_data=<%=stage_data%>;//데이터정보
   var download=<%=download%>;
     if(modify==1){
            var modifymain=$('#modify_main');
          var a='';  
          a+='<ul><li><div style="display : flex"><div class="profile">학술대회명</div><div class="form-group"><input type="text" class="form-control" id="contest_name" placeholder="제목을 입력하세요" value="' + stage_data.answer_1 + '" style="width : 620px"></div></li>';
          a+='<li><div style="display:flex"><div class="profile">자격요건</div><div style="margin-right:auto;font-size:12px;">';//answer2
         a+='<label class="checkbox-inline" style="margin-left : 5px;"><input type="checkbox" id="chkbox" value="제1저자" >제1저자</label><label class="checkbox-inline" style="margin-left : 5px;"><input type="checkbox" id="chkbox" value="지도교수지도">지도교수지도</label><label class="checkbox-inline" style="margin-left : 5px;"><input type="checkbox" id="chkbox" value="발표완료">발표완료</label><label class="checkbox-inline" style="margin-left : 5px;"><input type="checkbox" id="chkbox" value="17.12.01이후">17.12.01이후</label></li>';
         a+='<li><div style="display: flex"><div class="profile">논문제목</div><div class="form-group"><input type="text" class="form-control" id="thesis" placeholder="제목을 입력하세요" style="width : 620px" value="' + stage_data.answer_3 + '"></div></li>';
         a+='<li><div style="display:flex"><div class="profile">개최기관</div><div class="form-group"><input type="text" class="form-control" id="openplace" style="width : 263px;" placeholder="개최기관을 입력하세요" value="' + stage_data.answer_4 + '"></div><div class="profile" style="margin-left : 10px">학회개시일</div><input type="date" class="form-control" style="width:263px; margin-left:5px;" id="Inputdate" name = "new_date" value="' + stage_data.answer_5 + '"></div></li>';
         a+='<li><div id="uploadfile1" style="display:flex"><div class="profile">논문파일</div>';
         a+='<div style="margin-left: 5px">'+download[0]+'</div><div style="margin-right:5px; margin-left : 10px"><a href="download.do?id='+stage_data.answer_6+'"><button class="btn btn-default" style="padding : 3px 10px;"><img src="img/downloadBtn.png"></button></a><button class="btn btn-default" onclick="modifyfilebutton(1)" style="padding: 3px 10px; margin-left : 5px"><img src="img/removeBtn.png"></button></div></div></li>';
         a+='<li><div id="uploadfile2" style="display:flex"><div class="profile">기타증빙</div>';
         a+='<div style="margin-left: 5px">'+download[1]+'</div><div style="margin-right:5px; margin-left : 10px"><a href="download.do?id='+stage_data.answer_7+'"><button class="btn btn-default" style="padding : 3px 10px;"><img src="img/downloadBtn.png"></button></a><button class="btn btn-default" onclick="modifyfilebutton(2)" style="padding: 3px 10px; margin-left : 5px"><img src="img/removeBtn.png"></button></div></div></li></ul>';
         modifymain.html(a);  
         $('input:checkbox').each(function(){
               if(stage_data.answer_2.includes($(this).val()))
                  $(this).prop("checked",true);
               });
         }else if(modify==2){
              var modifymain=$('#modify_main');
              var sign=$('#sign');
              var etc_button=$('#etc_button');
             var a='';
             var b='<div class="text-right"><a href="javascript:history.go(-1)"><button type="button" style = "margin : 2px;" class="btn btn-default">취소</button></a>';
               if((user.type.includes("관리자")||user.type.includes("교수"))){
                  if(stage_data.success_date==null){
                     if(stage_data.refuse_date==null)
                   b+='<button type="button" class="btn btn-default" onclick="success()" >승인</button><button type="button" class="btn btn-default" onclick="refuse()">반려</button><a onclick="printview()" class="btn btn-default">인쇄</a></div>';
                  }else
                    b+='<a onclick="printview()" class="btn btn-default">인쇄</a>';  
               }else
                  if(stage_data.success_date==null)
                          b+='<a href="graduation_form.do?per_id='+graduationuser.per_id+'&num=94&stage=7&modify=1"><button type="button" class="btn btn-default">수정</button></a><a onclick="printview()" class="btn btn-default">인쇄</a></div>';
             sign.html(b);
             etc_button.html(a);
             a+='<ul><li><div style="width:709px;"><div class="profile">학술대회명</div><div class="inform">'+stage_data.answer_1+'</div></li>';
            a+='<li><div style="display:flex"><div class="profile">자격요건</div><div style="margin-right:auto;font-size:12px;">';//answer2
            a+='<div id="checkboxx"><label class="checkbox-inline" style="margin-left : 5px;"><input type="checkbox" id="chkbox" value="제1저자" disabled="disabled">제1저자</label><label class="checkbox-inline" style="margin-left : 5px;"><input type="checkbox" disabled="disabled" id="chkbox" value="지도교수지도">지도교수지도</label><label class="checkbox-inline" style="margin-left : 5px;"><input type="checkbox" disabled="disabled" id="chkbox" value="발표완료">발표완료</label><label class="checkbox-inline" style="margin-left : 5px;"><input type="checkbox" id="chkbox" disabled="disabled" value="17.12.01이후">17.12.01이후</label></div></li>';
            a+='<li><div style="width:709px;"><div class="profile">논문제목</div><div class="inform">'+stage_data.answer_3+'</div></div></li>';
            a+='<li><div style="display:flex"><div class="profile">개최기관</div><div class="inform"  style="width: 263px;">'+stage_data.answer_4+'</div>';
            a+='<div class="profile">학회개시일</div><input type="date" class="form-control" style="width:263px; margin-left : 5px;" id="receivedate" name = "new_date" readonly value="' + stage_data.answer_5 + '"></div>';
             a+='</li>';
             a+='<li><div id="uploadfile1" style="display:flex"><div class="profile">논문파일</div>';
            a+='<div style="margin-left:5px">'+download[0]+'</div><div id="dele1" style="margin-left:5px"><a href="download.do?id='+stage_data.answer_6+'"><button class="btn btn-default" style="padding : 3px 10px; margin-left : 10px"><img src="img/downloadBtn.png"></button></a></div></div></li>';
            a+='<li><div id="uploadfile1" style="display:flex"><div class="profile">기타증빙</div>';
            a+='<div style="margin-left:5px">'+download[1]+'</div><div id="dele2" style="margin-left:5px"><a href="download.do?id='+stage_data.answer_7+'"><button class="btn btn-default" style="padding : 3px 10px; margin-left : 10px"><img src="img/downloadBtn.png"></button></a></div></div></li></ul>';
            modifymain.html(a);  
            $('input:checkbox').each(function(){
               if(stage_data.answer_2.includes($(this).val()))
                  $(this).prop("checked",true);
            })
         }
    function modifyfilebutton(id){
       var a='';
       if(id==1){ 
           a+='<div class="profile">논문파일</div><div style="margin-left:5px; margin-top : 7px"><input type="file" name="uploadFile" id="uploadFile" accept=".hwp, .doc, .docx, .pdf"></div><div><button class="btn btn-default" onclick="uploadfile(' + id + ')" style="padding: 3px 10px"><img src="img/uploadBtn.png"></button></div>';
             a+='<div style="margin-left : 5px"><button class="btn btn-default" onclick="cancelfile(' + id + ')" style="padding : 6px 10px">취소</button></div>';
         $('#uploadfile1').html(a);
       }else if(id==2){
           a+='<div class="profile">기타증빙</div><div style="margin-left:5px; margin-top : 7px"><input type="file" name="uploadFile2" id="uploadFile2" accept=".hwp, .doc, .docx, .pdf"></div><div><button class="btn btn-default" onclick="uploadfile(' + id + ')" style="padding: 3px 10px"><img src="img/uploadBtn.png"></button></div>';
             a+='<div style="margin-left : 5px"><button class="btn btn-default" onclick="cancelfile(' + id + ')" style="padding : 6px 10px">취소</button></div>';

            $('#uploadfile2').html(a);
       }
         
    }
    function cancelfile(id){
        var a='';
      if(id==1) {
         if(modify=="1"){
            a+='<div class="profile">논문파일</div>';
               a+='<div style="margin-left: 5px">'+download[0]+'</div><div style="margin-right:5px; margin-left : 10px"><a href="download.do?id='+stage_data.answer_6+'"><button class="btn btn-default" style="padding : 3px 10px;"><img src="img/downloadBtn.png"></button></a><button class="btn btn-default" onclick="modifyfilebutton('+id+')" style="padding: 3px 10px; margin-left : 5px"><img src="img/removeBtn.png"></button></div>';
         }else{
          a+='<div class="profile">논문파일</div>';
            a+='<div style="margin-left: 5px">'+ uploadf1 +'</div><div style="margin-right:5px; margin-left : 10px"><a href="download.do?id='+hashfile1+'"><button class="btn btn-default" style="padding : 3px 10px;"><img src="img/downloadBtn.png"></button></a><button class="btn btn-default" onclick="modifyfilebutton('+id+')" style="padding: 3px 10px; margin-left : 5px"><img src="img/removeBtn.png"></button></div>';
      }
      $('#uploadfile1').html(a);
      }
        else if(id==2){
           if(modify=="1"){
              a+='<div class="profile">기타증빙</div>';
               a+='<div style="margin-left: 5px">'+download[1]+'</div><div style="margin-right:5px; margin-left : 10px"><a href="download.do?id='+stage_data.answer_7+'"><button class="btn btn-default" style="padding : 3px 10px;"><img src="img/downloadBtn.png"></button></a><button class="btn btn-default" onclick="modifyfilebutton('+id+')" style="padding: 3px 10px; margin-left : 5px"><img src="img/removeBtn.png"></button></div>';
       }else{
           a+='<div class="profile">기타증빙</div>';
            a+='<div style="margin-left: 5px">'+ uploadf2+'</div><div style="margin-right:5px; margin-left : 10px"><a href="download.do?id='+hashfile2+'"><button class="btn btn-default" style="padding : 3px 10px;"><img src="img/downloadBtn.png"></button></a><button class="btn btn-default" onclick="modifyfilebutton('+id+')" style="padding: 3px 10px; margin-left : 5px"><img src="img/removeBtn.png"></button></div>';
          }
        $('#uploadfile2').html(a);
        }
   }
    
    function insert_etc3(){//학술대회 제출(required 필요함)
       var modi='';
       if(modify=="1"){
          modi="modify";
       }
       var signature=$('#signature').val();
       if(signature==user.name){
          var number=0;
          var check='';
          $('#chkbox:checked').each(function(){
             check+=$(this).val()+'/';
             number++;
          })
          if(number<4){
             alert("자격요건 모두 체크해주세요");
             return;
          }
          var obj=new Object();
          obj.per_id=user.per_id;
          obj.name=$('#contest_name').val();
          obj.check=check;
          obj.thesis=$('#thesis').val();
          obj.openplace=$('#openplace').val();
          obj.date=$('#Inputdate').val();
          obj.upload1=hashfile1;
          obj.upload2=hashfile2;
          if(modify=="1"){
              modi="modify";
              if(obj.upload1==null&&stage_data.answer_7!=null)
                 obj.upload1=stage_data.answer_6;
           if(obj.upload2==null){               
              obj.upload2=stage_data.answer_7;
           }
            }
          
          var jsonobj=JSON.stringify(obj);
            if(obj.name!=''&&obj.check!=''&&obj.thesis!=''&&obj.openplace!=''&&obj.date!=''&&obj.upload1!=null&&obj.upload2!=null){
          $.ajax({
             url:"ajax.do",
             type:"post",
             data:{
                req:"insert_etc3",
                data :jsonobj,
                modify:modi
             },
             success : function(data){
                alert(user.name+"["+data+"]님의 학술대회 보고서가 제출 되었습니다.");
                window.location.href="graduation_intro.do?num=94"             
                      }
          })
       }else
            alert("모두 입력해주세요");
           
    }
        else{
           alert("서명을 해주세요!");
        }
    }
        function success(){
            var con_test = confirm("기타자격(학술대회 정보)을 승인하시겠습니까?");
            if(con_test==true){
               
                $.ajax({
                    url : "ajax.do",
                    type : "post",
                    data :{
                    req : "success_grd",
                    data : graduationuser.per_id,
                    state : "학술대회"
                },
                success : function(data){
                    alert("승인되었습니다.");
                    window.location.href="graduation_manage.do?num=94&perid="+graduationuser.per_id;
                }
                })
            }
        }
function refuse(){
             var con_test = confirm("기타자격(학술대회 정보)을 반려하시겠습니까?");
  
            if(con_test==true){
                var name =prompt("반려 사유를 입력하세요"); 
                if(name!=''){
                $.ajax({
                    url : "ajax.do",
                    type : "post",
                    data :{
                    req : "refuse_grd",
                    data : graduationuser.per_id+"-/-/-"+name,
                    state : "학술대회"
                },
                success : function(data){
                    alert("반려되었습니다.");
                    window.location.href="graduation_manage.do?num=94&perid="+graduationuser.per_id;
                }
                })
            
        }else{
           alert("반려사유를 입력하세요");
            }
            }
        }
        
function printview(){
      $('#submit_suggest_date').html('제출일 : '+formatData(stage_data.submit_date));
      $('#submit_name').html('신청자 : '+graduationuser.name+'[서명]');
      $('#professorname').html('지도교수 :'+graduationuser.prof_name+' (인)');
      $("#dele1").html('');
      $("#dele2").html('');
      var a='';
      a+='<label class="checkbox-inline" style="margin-left : 5px;"><input type="checkbox" id="chkbox" value="제1저자" disabled="disabled" checked>제1저자</label><label class="checkbox-inline" style="margin-left : 5px;"><input type="checkbox" disabled="disabled" id="chkbox" value="지도교수지도"checked>지도교수지도</label><label class="checkbox-inline" style="margin-left : 5px;"><input type="checkbox" disabled="disabled" id="chkbox" value="발표완료" checked>발표완료</label><label class="checkbox-inline" style="margin-left : 5px;"><input type="checkbox" id="chkbox" disabled="disabled" value="17.12.01이후" checked>17.12.01이후</label>';
      $('#checkboxx').html(a);
      const main ='<br><h2 style="text-align:center">컴퓨터과학과 졸업논문 기타자격제출(학술대회 발표)<h2><br>';
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
      $("#dele1").html('<a href="download.do?id='+stage_data.answer_6+'"><button class="btn btn-default" style="padding : 3px 10px; margin-left : 10px"><img src="img/downloadBtn.png"></button></a>');
      $("#dele2").html('<a href="download.do?id='+stage_data.answer_7+'"><button class="btn btn-default" style="padding : 3px 10px; margin-left : 10px"><img src="img/downloadBtn.png"></button></a>');
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