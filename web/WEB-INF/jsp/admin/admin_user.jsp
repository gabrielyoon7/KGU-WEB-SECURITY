<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
    StringBuffer url2_admin_user = request.getRequestURL();
    String logo_img_admin_user;

    //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
    //ai이면 ai로고 cs이면 cs로고
    if(url2_admin_user.substring(7,9).equals("ai") || url2_admin_user.substring(7,9).equals("lo")){
        logo_img_admin_user = "img/notice_ai.png";
    }
    else{
        logo_img_admin_user = "img/notice.png";
    }
    //System.out.println((logo_img_admin_user));
%>
<% 
String tabmenulist=(String) request.getAttribute("tabmenulist");//관리자탭메뉴
String alluser = (String) request.getAttribute("alluser");//스케쥴 리스트
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="utf-8">
<title>유저 관리 : 경기대학교 AI컴퓨터공학부</title>
<link rel="stylesheet" href="css/bootstrap-table.css">
<link href='css/bootstrap.css' rel='stylesheet' type='text/css'>
<link href='css/default.css' rel='stylesheet' type='text/css'>
<link href='css/boardtable.css' rel='stylesheet' type='text/css'>
<link href='css/information.css' rel='stylesheet' type='text/css'>
<link href='css/content.css' rel='stylesheet' type='text/css'>
<link href='css/bootstrap-table.css' rel='stylesheet' type='text/css'>

<style>
#maincontent {
   padding: 0;
}

#maincontent>ul {
   padding: 10px;
}
.boardtable > thead > tr > th:nth-child(2) {
    min-width: 30px;
}

.boardtable > tbody > tr > td:nth-child(2) {
    min-width: 30px;
}
.boardtable > thead > tr > th:nth-child(3) {
    min-width: 100px;
}

.boardtable > thead > tr > th:nth-child(5) {
    width: 120px;
    min-width:120px;
}

.boardtable > tbody > tr > td:nth-child(3) {
    font-family: 'Nanum Gothic', sans-serif;
    min-width: 100px;
}

.boardtable > tbody > tr > td:nth-child(5) {
    width: 120px;
    min-width:120px;
}
.boardtable > thead > tr > th:nth-child(2) {
    min-width: 150px;
}
.boardtable > thead > tr > th:nth-child(7), .boardtable > tbody > tr > td:nth-child(7){
   width:60px;
   min-width:60px;
}
.boardtable > thead > tr > th:nth-child(1), .boardtable > tbody > tr > td:nth-child(1){
   width:50px;
   min-width:50px;
}
</style>
</head>
<body>
   <script src="js/default.js"></script>
   <script src="js/jquery-3.2.1.min.js"></script>
   <script src="js/bootstrap.min.js"></script>
   <script src="js/bootstrap-table.js"></script>
   <script src="js/bootstrap-table-cookie.js"></script>
   <script src="js/bootstrap-table-export.min.js"></script>
   <script src='js/sha256.js'></script>
   <%@include file="../main/header.jsp"%>
   <script>
      function makeboard(id) {
         var list = $(id);
         var arr = <%=tabmenulist%>;
         for (var i = 0; i < arr.length; i++) {
            var value = arr[i];
            if(value.show_in_menus)
            list.append(makeone(value));
         }
      }
      function makeone(str) {
         var num=str.tab_id*10+str.orderNum;
         var text = '<li><span class="deco_dot">●</span><a href="'+str.path+'?num='+num+'">'+ str.page_title + '</li>'
         return text;
      }
   </script>
   <main>
   <div id="content">
      <div id="title">
          <img src=<%=logo_img_admin_user%> />
         <div>관리 페이지</div>
      </div>
      <div id="container">
         <div id="tab">
            <ul id="tab_2">
            </ul>
         </div>
         <div id="maincontent">
            <ul>
               <li>
                  <div class="contenttitle">사용자 관리</div>
               </li>
            </ul>
            <table class="boardtable" id="table" data-toggle="table"
               data-pagination="true" data-toolbar="#toolbar"
               data-search="true" data-side-pagination="true" data-click-to-select="true"
               data-page-list="[10]">
               <thead>
                  <tr>
                      <th data-field="state" data-checkbox="true"></th>
                   <th data-field="del">설정</th>
                      
                     <th data-field="id" data-sortable="true">ID</th>
                     <th data-field="per_id" data-sortable="true">학번</th>
                     <th data-field="type" data-sortable="true">타입</th>
                     <th data-field="name" data-sortable="true">이름</th>
                     <th data-field="gender" data-sortable="true">성별</th>
                     <th data-field="birth" data-sortable="true">생년월일</th>
                     <th data-field="hope_type" data-sortable="true">희망구분</th>
                     <th data-field="reg_date" data-sortable="true">가입일자</th>
                     <th data-field="major" data-sortable="true">전공</th>
                     <th data-field="grade" data-sortable="true">학년</th>
                     <th data-field="state1" data-sortable="true">재적상태</th>
                     <th data-field="homeID" data-sortable="true">H.ID</th>
                  </tr>
               </thead>
            </table>
            <div class="col-md-6"></div>
            <a href="#myModal" data-toggle="modal" onclick="insertuser()" class="btn btn-default col-md-2" style="display:none" id="forSuper">관리자 추가</a>
            <a href="#myModal" data-toggle="modal" onclick="modifyuser()" class="btn btn-default col-md-2">권한 수정</a>
            <a onclick="deleteselectuser()" id="remove" class="btn btn-default col-md-2">선택 삭제</a>
            </div>
         </div>
      </div>
   </div>
   </main>
   <%@include file="../main/footer.jsp"%>
   <div id="shadow">
      <div id="blur"></div>
   </div>
   <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal"aria-label="Close">
                     <span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title">권한 수정</h4>
        </div>
        <div class="modal-body" id = "myModalbody">
        </div>
        <div class="modal-footer">
        </div>
      </div>
    </div>
  </div>
   <script>
   makeboard(tab_2)
   </script>
   <script>
   function insertuser(){
      alert("관리자를 추가합니다");
      var list = $('#myModalbody');
      var a = '<div class="form-group"><label for="InputID">아이디</label><span id="warningID"></span><div class="input-group"><input onkeypress="changeID()" type="text" class="form-control" placeholder="원하는 아이디를 입력해주세요" id="InputID"><span class="input-group-btn"><button class="btn btn-default" type="button" onclick="checkID();">중복확인</button></span></div></div>';
      a += '<div class="form-group"><label for="InputPassword">비밀번호</label><input onkeyup="checkPassword()" type="password" class="form-control" id="InputPassword" placeholder="6 글자 이상으로 설정해주세요"></div>';
         a += '<div class="form-group"><label for="InputPasswordCheck">비밀번호 확인</label><span id="warningPassword"></span><input onkeyup="checkPassword()" type="password" class="form-control" id="InputPasswordCheck" placeholder="똑같이 입력해주세요"></div>';
         a += '<div class="form-group"><label for="InputName">이름</label><input type="text" class="form-control" id="InputName" placeholder="이름을 입력해주세요"></div>';
         a += '<div class="form-group"><label for="InputType" style="display :inline-block">구분</label><select class="form-control" id="InputType"><option>홈페이지관리자</option><option>졸업논문관리자</option><option>P3관리자</option></select></div>';         
         a += '<div class="col-xs-13 text-right"><button class="btn btn-default" onclick="LetsRegisteradmin()">회원가입</button></div>';
          a += '<input type="submit" onclick="LetsRegisteradmin()" style="display : none">';
       list.html(a);
   }
   
   if(<%=type%>.type_name == '관리자')
	   $('#forSuper').css('display', 'block');
   
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
               $('#warningID').html('*중복된 ID입니다');
               $('#warningID').css('color', 'red');
               $('#warningID').css('font-size', '11px');
               $('#warningID').css('margin-left', '10px');
               
            }
            else{
               $('#warningID').html('*사용가능한 ID입니다');
               $('#warningID').css('color', 'blue');
               $('#warningID').css('font-size', '11px');
               $('#warningID').css('margin-left', '10px');
            }
         }
      })
       }
   
   function checkPassword(){
      if($('#InputPassword').val().length < 6){
         $('#warningPassword').html('보안을 위해 6글자 이상으로 해주세요');
         $('#warningPassword').css('color', 'red');
         $('#warningPassword').css('font-size', '11px');
         $('#warningPassword').css('margin-left', '10px');
      }
      else if($('#InputPassword').val() == $('#InputPasswordCheck').val()){
         $('#warningPassword').html('비밀번호가 일치합니다');
         $('#warningPassword').css('color', 'blue');
         $('#warningPassword').css('font-size', '11px');
         $('#warningPassword').css('margin-left', '10px');
      }
      else{
         $('#warningPassword').html('비밀번호가 일치하지 않습니다');
         $('#warningPassword').css('color', 'red');
         $('#warningPassword').css('font-size', '11px');
         $('#warningPassword').css('margin-left', '10px');
      }
         
   }   
   
   function changeID(){
      $('#warningID').html('*ID 중복확인을 해주세요');
      $('#warningID').css('color', 'black');
      $('#warningID').css('font-size', '11px');
      $('#warningID').css('margin-left', '10px');
      
   }
   
   function LetsRegisteradmin(){
      if($('#warningID').text() == '*사용가능한 ID입니다'){
         if($('#warningPassword').text() == '비밀번호가 일치합니다' ){
            var id =$('#InputID').val();
            var password = $('#InputPassword').val();
            var type = $('#InputType').val();
            var name = $('#InputName').val();
            if(name!='' ){
               var update = id+"-/-/-"+SHA256(id+password)+"-/-/-"+name+"-/-/-"+type;
               $.ajax({
                  url:"ajaxuser.do",
                  type:"post",
                  data:{
                     req:"registeradmin",
                     data: update
                  },
                  success:function(data){
                     alert("추가 완료");
                     location.reload();
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
   
    var $table = $('#table');
      var $remove = $('#remove');
      
   function modifyuser(){
      var list = $('#myModalbody');
      var ids=$.map($table.bootstrapTable('getSelections'),function(row){
         return row.name + '(' + row.id + ')';
      });
      var types=$.map($table.bootstrapTable('getSelections'),function(row){
          return row.type;
       });
      var type=types[0];
      for(var k=0;k<types.length;k++){
         for(var j=k+1;j<types.length;j++){
            if(types[k]!=types[j]){
               type="여러 권한이 섞여있습니다";
               break;
            }
         }
         if(type=="여려 권한이 섞여있습니다")
            break;
      }
      var a='';
      a +='<div class="form-group"><label for="InputType" style="display :inline-block">선택된 ID</label></div>';
      a +='<div class="form-group">'+ids+' [총'+ids.length+'명]</div>';
      a +='<div class="form-group"><label for="InputType" style="display :inline-block">수정전 권한</label><input class="form-control" id="disabledInput" type="text" placeholder="Disabled input here..." value="'+type+'" disabled ></div>';
      a +='<div class="form-group"><label for="InputType" style="display :inline-block">수정후 권한</label><select class="form-control" id="modifyType"><option>교수1</option><option>교수2</option><option>조교</option><option>대학원생</option><option>복수전공생</option><option selected>학부생</option><option>타과생</option><option>학부모</option><option>입학예정자</option><option>기타</option></select></div>';
      a += '<div class="col-xs-13 text-right"><button class="btn btn-default" onclick="updatetype()">권한 수정</button></div>';
      list.html(a);

       
   } 
   
  function updatetype(){
    var type = $('#modifyType').val();
    var ids=$.map($table.bootstrapTable('getSelections'),function(row){
            return row.id;
         });
    
    
    var id='';
    for(var i=0;i<ids.length;i++){
       id +=ids[i]+"-/-/-"
    }
    var modify= type+"-/-/-"+id;
     
     
     $.ajax({
         url:"ajaxuser.do",
         type:"post",
         data : {
               req : "modifytype",
               data : modify
         },
         dataType:"json",
         success:function(data){
           alert("수정되었습니다");  
           location.reload();
         }
      });
    
  }
    
    function deleteselectuser(){
       var ids=$.map($table.bootstrapTable('getSelections'),function(row){
          return row.id;
       });
       var check = confirm(ids.length+"["+ids+"]명을 정말 삭제하시겠습니까?");
       if(check){
       var id="";
       for(var i=0;i<ids.length;i++){
          id+=ids[i]+"-/-/-";
          if(ids[i]=="admin"){
             alert("admin은 삭제할 수 없습니다");
             return;
          }
       }
       
       dataType:"json"
       $.ajax({
          url:"ajaxuser.do",
          type:"post",
          data : {
             req:"deleteselectuser",
             data : id
          },
          success : function(data){
             
             $table.bootstrapTable('remove',{
                field : 'id',
                values : ids
             })
          }
       })
       };
    }          

   
     
 
   
                 var alluser=<%=alluser%>;
                 
                  function callSetupTableView(){
                     $('#table').bootstrapTable('append',data());
                       $('#table').bootstrapTable('refresh');
                  }
                 
                
                function data(){
                   var rows = [];
                   for(var i=0;i<alluser.length;i++){
                      var user=alluser[i];
                      var date = formatData(user.reg_date);
                      rows.push({
                         id: user.id,                      
                         per_id : user.per_id,
                         type : user.type,     
                         name: user.name,
                         gender: user.gender,
                         birth: user.birth,
                         hope_type : user.hope_type,
                         reg_date : date,
                         major : user.major,
                         grade : user.grade,
                         state : user.state,
                         homeID : user.myhomeid,
                         del : '<button type="button" class="btn btn-default btn btn-xs" style = "margin : 1px;" onclick="enrollAIAuthority('+i+')">AI권한추가</button> <button type="button" class="btn btn-default btn btn-xs" style = "margin : 1px;" onclick="modifypw('+i+')">pw 초기화</button> <button type="button" class="btn btn-default btn btn-xs" style = "margin : 1px;" onclick="deleteuser('+i+')">삭제</button>'
                      });
                   }
                   return rows;
                }
                
                $(document).ready(function(){
                    callSetupTableView();
                    }) 
                    
                    
                    function formatData(date){
                   var d = new Date(date),
                      month = '' + (d.getMonth() + 1),
                      day = '' + d.getDate(),
                      year = d.getFullYear();

                  if (month.length < 2) month = '0' + month;
                  if (day.length < 2) day = '0' + day;

                  return [year, month, day].join('-');
                }

   function enrollAIAuthority(id){ //AI 권한 추가
       var user =alluser[id];
       var check = confirm(user.name+"["+user.id+"]님에게 인공지능 홈페이지 접근 권한을 부여 하시겠습니까?");
       if(check){
           $.ajax({
               url : "ajaxuser.do", //AjaxuserAction
               type : "post",
               data : {
                   req : "enrollAIuser",
                   data : user.id+"-/-/-"+user.name+"-/-/-"+user.type+"-/-/-"+user.major
               },
               success :function(data){
                   alert(user.name+"님은 이제 인공지능 홈페이지에서 로그인이 가능합니다.");
                   window.location.href = 'admin.do?num=83';
               }
           })

       }
   }

                function deleteuser(id){
                   var user =alluser[id];
                   var check = confirm(user.name+"["+user.id+"]를 정말 삭제하시겠습니까?");
                   if(check){
                      $.ajax({
                         url : "ajaxuser.do",
                          type : "post",
                          data : {
                                req : "deleteuser",
                                data : alluser[id].id
                             },
                             success :function(data){
                                alert("삭제되었습니다.");
                                window.location.href = 'admin.do?num=83';
                             }
                      })


                   }
                }
                
                function modifypw(id){
                   var user = alluser[id];
                   var change =user.birth;
                   
                   var check = confirm(user.name+"의 패스워드를 초기화 하시겠습니까?(초기화 : 생년월일(생년월일이 없을 경우 1234))");
                   if(check){
                      if(change=="-")
                         change="1234";
                      else{
                         var a=change.split("-");
                         change=user.id+a[0].substring(2,4)+""+a[1]+""+a[2];
        
                      }
                      $.ajax({
                         url : "ajaxuser.do",
                         type : "post",
                         data : {
                            req : "modifypw",
                            data : user.id+"-/-/-"+SHA256(change)
                         },
                         success : function(data){
                            alert(data+"의 패스워드가 변경 되었습니다!!");
                         }
                      })
                   }
                }
                  </script>
</body>
</html>