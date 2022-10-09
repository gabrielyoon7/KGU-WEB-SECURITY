<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
String num = (String) request.getAttribute("num");
   String tabmenulist = (String) request.getAttribute("tabmenulist");//관리자탭메뉴
   String graduationuser = (String) request.getAttribute("graduationuser");
   String stage_data=(String) request.getAttribute("stage_data");
   String modify=(String) request.getAttribute("modify");
   String download=(String) request.getAttribute("download");
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
         <ul><li><div class="contenttitle">중간보고서 제출</div></li></ul>
         <div>
         <div>
         <div class="contenttitle2">학생정보</div>
            <table id="graduation_user_info" class="table table-bordered" style="font-size : 13px; border : 2px solid #ddd; margin-bottom : 0;">
         </table>
         <br>
       <div class="contenttitle2">중간보고서</div>
         <div id="modify_main" class="graduation_read_info" style="border : 1.5px solid #ddd">
            <ul>
            <li>
               <div style="display: flex">
                    <div class="profile">제목</div>
                    <div class="form-group">
                   <input type="text" class="form-control" id="mid_name" placeholder="제목을 입력하세요" style="width : 620px">
                 </div>
              </div>
            </li>
            <li>
               <div id="thesis_what" style="display:flex">
               <div class="profile">구분</div>
               </div>
            </li>
            <li>
               <div id="uploadfile1" style="display:flex">
                  <div class="profile">파일제출</div>
                  <div style="margin-left:5px; margin-top : 7px"><input type="file" name="uploadFile" id="uploadFile" accept=".hwp, .doc, .docx, .pdf"></div>
                  <div style="margin-right:auto"><button class="btn btn-default" onclick="uploadfile()" style="padding: 3px 10px"><img src="img/uploadBtn.png"></button></div>
               </div>
            </li>
            <li>
               <div style="display:flex">
                  <div class="profile" style="padding-top : 50px">진행내용</div>
                  <div class="form-group" style="display : inline-block; width : 620px;">
                   <textarea class="form-control" id="progress_content" rows=6 placeholder="진행내용을 입력하세요"></textarea>
                 </div>
               </div>
            </li>
            <li>
               <div style="display:flex">
                  <div class="profile" style="padding-top : 50px">향후계획</div>
                  <div class="form-group" style="display : inline-block; width : 620px;">
                   <textarea class="form-control" id="plan_content" rows=6 placeholder="향후계획을 입력하세요"></textarea>
                 </div>
               </div>
            </li>
         </ul>
         </div>
         <div><!-- 서명 + 버튼div -->
         <div id="sign" class="text-right">서명
            <div class="form-group" style="display : inline-block">
             <input type="text" class="form-control" id="signature" placeholder="본인의 이름을 입력">
           </div>
            <button type="button" style="margin: 2px;" class="btn btn-default" onclick="insert_mid()">완료</button>
            <a href="javascript:history.go(-1)"><button type="button" style="margin: 2px;" class="btn btn-default">취소</button></a>
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
   var list = $('#tab_2');
   var uploadf=null;
   var hashfile=null;//다운로드 파일
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
   var grduser=<%=grduser%>;
        var user=<%=user%>;
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
        var modify=<%=modify%>;//1=수정 2=보기
      var stage_data=<%=stage_data%>;//데이터정보
      var download=<%=download%>
        if(modify==1){//name(answer_1), checked_value(answer_2), keyword(answer_3), content(answer_4)
            var modifymain=$('#modify_main');
          var a='';  
          a+='<ul><li><div style="display: flex"><div class="profile">제목</div><div class="form-group"><input type="text" class="form-control" id="mid_name" placeholder="제목을 입력하세요" style="width : 620px" value="' + stage_data.answer_1 + '"></div></div></li>';
         a+='<li><div id="thesis_what" style="display:flex"><div class="profile">구분</div></div></li>';
         a+='<li><div id="uploadfile1" style="display:flex"><div class="profile">파일제출</div>';   
         a+='<div style="margin-left: 5px">'+download[0]+'</div><div style="margin-right:5px; margin-left : 10px"><a href="download.do?id='+stage_data.answer_3+'"><button class="btn btn-default" style="padding : 3px 10px;"><img src="img/downloadBtn.png"></button></a><button class="btn btn-default" onclick="modifyfilebutton()" style="padding: 3px 10px; margin-left : 5px"><img src="img/removeBtn.png"></button></div></div></li>';   
         a+='<li><div style="display:flex"><div class="profile" style="padding-top : 50px">진행내용</div><div class="form-group" style="display : inline-block; width : 620px;"><textarea class="form-control" id="progress_content" rows=6 placeholder="진행내용을 입력하세요">' + stage_data.answer_4 + '</textarea></div></div></li>';   
         a+='<li><div style="display:flex"><div class="profile" style="padding-top : 50px">향후계획</div><div class="form-group" style="display : inline-block; width : 620px;"><textarea class="form-control" id="plan_content" rows=6 placeholder="향후계획을 입력하세요">' + stage_data.answer_5 + '</textarea></div></div></li></ul>';
         modifymain.html(a);  
         }else if(modify==2){
              var modifymain=$('#modify_main');
              var sign=$('#sign');
             var a='';
             var b='<div class="text-right"><a href="javascript:history.go(-1)"><button type="button" style = "margin : 2px;" class="btn btn-default">취소</button></a>';
               if((user.type.includes("관리자")||user.type.includes("교수"))){
                  if(stage_data.success_date==null){
                     if(stage_data.refuse_date==null)
                   b+='<button type="button" class="btn btn-default" onclick="success()" >승인</button><button type="button" class="btn btn-default" onclick="refuse()">반려</button></div>';
                  }else
                    b+='';  
               }else
                  if(stage_data.success_date==null)
                          b+='<a href="graduation_form.do?per_id='+graduationuser.per_id+'&num=94&stage=3&modify=1"><button type="button" class="btn btn-default">수정</button></a></div>';
             sign.html(b);
             a+='<ul><li><div class="profile">제목 </div><div class="inform">'+stage_data.answer_1+'</div></li>';
            a+='<li><div id="thesis_what" style="display:flex"><div class="profile">구분 </div></div></li>';
            a+='<li><div id="uploadfile1" style="display:flex"><div class="profile">파일제출</div>';   
            a+='<div style="margin-left:5px">'+download[0]+'</div><div style="margin-left:5px"><a href="download.do?id='+stage_data.answer_3+'"><button class="btn btn-default" style="padding : 3px 10px; margin-left : 10px"><img src="img/downloadBtn.png"></button></a></div></div></li>';   
            a+='<li><div style="display:flex"><div class="profile" style="padding-top : 50px">진행내용</div><div class="form-group" style="display : inline-block; width : 620px;"><textarea class="form-control" id="progress_content" rows=6 placeholder="진행내용을 입력하세요" readonly>' + stage_data.answer_4 + '</textarea></div></div></li>';   
            a+='<li><div style="display:flex"><div class="profile" style="padding-top : 50px">향후계획</div><div class="form-group" style="display : inline-block; width : 620px;"><textarea class="form-control" id="plan_content" rows=6 placeholder="향후계획을 입력하세요" readonly>' + stage_data.answer_5 + '</textarea></div></div></li></ul>';
             modifymain.html(a);  
         }
        
        var thesis=$('#thesis_what');
        var th='';   
        $.ajax({
                url : "ajaxuser.do",
                type : "post",
                data :{
                    req : "thesis_what",
                    data : graduationuser.per_id
                },
                success : function(data){
                if(data=="구현논문"){
                 th +='<label class="radio-inline" style="margin-left : 5px"><input type="radio" name="thesis" value="구현논문" checked>구현논문</label><label class="radio-inline disabled" style="margin-left : 35px"><input type="radio" name="thesis" disabled="disabled" value="조사(이론)논문">조사(이론)논문</label>';
                 thesis.append(th);
                }else if(data=="조사(이론)논문"){
                 th +='<label class="radio-inline disabled" style="margin-left : 5px"><input type="radio" name="thesis" value="구현논문" disabled="disabled" >구현논문</label><label class="radio-inline" style="margin-left : 35px"><input type="radio" name="thesis"  value="조사(이론)논문" checked>조사(이론)논문</label>';
                 thesis.append(th);
                }else{
                    alert("제안서가 등록되지 않았거나 오류가 있습니다.");
                    window.location.href="javascript:history.go(-1)"
                } 
                }
            })
 
        
   function uploadfile(){
            var formData = new FormData();
            var address="";
            if($('input[name=uploadFile]')[0].files[0]!=null){
            formData.append("file_data",$('input[name=uploadFile]')[0].files[0]);
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
                    a+='<div class="profile">파일제출</div><div style="margin-left: 5px">'+file[0]+'</div><div style="margin-right:5px; margin-left : 10px"><a href="download.do?id='+file[1]+'"><button class="btn btn-default" style="padding : 3px 10px;"><img src="img/downloadBtn.png"></button></a><button class="btn btn-default" onclick="modifyfilebutton()" style="padding: 3px 10px; margin-left : 5px"><img src="img/removeBtn.png"></button></div></div></li>';
                    uploadf=file[0];
                    hashfile=file[1];
                     $('#uploadfile1').html(a);
                 }
            })
            }else{
               alert("파일을 등록해주세요");
            }
         return address;
      }
        
        function modifyfilebutton(){
           var a='';
            a+='<div class="profile">파일제출</div><div style="margin-left:5px; margin-top : 7px"><input type="file" name="uploadFile" id="uploadFile" accept=".hwp, .doc, .docx, .pdf"></div><div><button class="btn btn-default" onclick="uploadfile()" style="padding: 3px 10px"><img src="img/uploadBtn.png"></button></div>';
            a+='<div style="margin-left : 5px"><button class="btn btn-default" onclick="cancelfile()" style="padding : 6px 10px">취소</button></div>';
              $('#uploadfile1').html(a);
        }
        
        function cancelfile(){
             var a='';
             if(modify=="1"){
                a+='<div class="profile">파일제출</div>';
                a+='<div style="margin-left: 5px">'+download[0]+'</div><div style="margin-right:5px; margin-left : 10px"><a href="download.do?id='+stage_data.answer_3+'"><button class="btn btn-default" style="padding : 3px 10px;"><img src="img/downloadBtn.png"></button></a><button class="btn btn-default" onclick="modifyfilebutton()" style="padding: 3px 10px; margin-left : 5px"><img src="img/removeBtn.png"></button></div>';
             }else{
                 a+='<div class="profile">파일제출</div><div style="margin-left: 5px">'+uploadf+'</div><div style="margin-right:5px; margin-left : 10px"><a href="download.do?id='+hashfile+'"><button class="btn btn-default" style="padding : 3px 10px;"><img src="img/downloadBtn.png"></button></a><button class="btn btn-default" onclick="modifyfilebutton()" style="padding: 3px 10px; margin-left : 5px"><img src="img/removeBtn.png"></button></div></div></li>';
                 }          
             $('#uploadfile1').html(a);
        }
        
        function insert_mid(){
            var signature=$('#signature').val();
            var modi='';
            if(modify=="1"){
               modi="modify";
            }
            if(signature==user.name){
               var obj = new Object();
                obj.per_id=user.per_id;
                obj.name=$('#mid_name').val();
                var check = document.getElementsByName('thesis');
             var checked_value = '';
             for (var i = 0; i < check.length; i++) {
                if (check[i].checked) {
                   checked_value = check[i].value;
                }
             }
               obj.thesis=checked_value;
               obj.file=hashfile; //파일이름(uploadf)
               if(obj.file==null&&modify=="1"){
                  obj.file=stage_data.answer_3;
               }
               obj.progress=$('#progress_content').val();
               obj.plan=$('#plan_content').val();
              if(obj.name!=''&&check!=0&&obj.file!=null&&obj.progress!=''&&obj.plan!=''){
                var jsonobj=JSON.stringify(obj);
                $.ajax({
                    url:"ajax.do",
                    type:"post",
                    dataType:"json",
                    data :{
                        req:"insert_mid",
                        data : jsonobj,
                        modify : modi
                    },
                    success : function(data){
                       alert(user.name+"["+data+"]님의 중간보고서가 제출 되었습니다.");
                        window.location.href="graduation_intro.do?num=94";//나중에 바꾸자
                    }
                });
            }else 
                alert("모두 입력해주세요");
        }else{
                alert("서명이 되지 않았습니다. 서명을 해주시기 바랍니다");
            }
        }
        
      function success(){
            var con_test = confirm("중간보고서를 승인하시겠습니까?");
            if(con_test==true){
                $.ajax({
                    url : "ajax.do",
                    type : "post",
                    data :{
                    req : "success_grd",
                    data : graduationuser.per_id,
                    state : "중간보고서"
                },
                success : function(data){
                    alert("승인되었습니다.");
                    window.location.href="graduation_manage.do?num=94&perid="+graduationuser.per_id;
                }
                })
            }
        }
        
        function refuse(){
             var con_test = confirm("중간보고서를 반려하시겠습니까?");
            
            if(con_test==true){
                var name =prompt("반려 사유를 입력하세요"); 
                if(name!=''){
                $.ajax({
                    url : "ajax.do",
                    type : "post",
                    data :{
                    req : "refuse_grd",
                    data : graduationuser.per_id+"-/-/-"+name,
                    state : "중간보고서"
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
         
         
   </script>
</body>
</html>