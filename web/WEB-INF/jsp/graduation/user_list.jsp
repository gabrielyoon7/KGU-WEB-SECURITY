<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
String userlist = (String) request.getAttribute("userlist");
String tabmenulist = (String) request.getAttribute("tabmenulist");
String ordernum = (String) request.getAttribute("ordernum");
String proflist=(String) request.getAttribute("proflist");
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="utf-8">
<title>경기대학교 AI컴퓨터공학부</title>
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

.boardtable>thead>tr>th:nth-child(1) {
   min-width: 20px;
}

.boardtable>tbody>tr>td:nth-child(1) {
   min-width: 20px;
}

.boardtable>thead>tr>th:nth-child(2) {
   min-width: 30px;
   max-width: 30px;
}

.boardtable>thead>tr>th:nth-child(4) {
   width: 80px;
}

.boardtable>tbody>tr>td:nth-child(2) {
   font-family: 'Nanum Gothic', sans-serif;
   min-width: 30px;
   max-width: 30px;
}

.boardtable>tbody>tr>td:nth-child(5), .boardtable>thead>tr>th:nth-child(5){
   min-width : 65px;
   max-width : 65px;
}

.boardtable>tbody>tr>td:nth-child(4) {
   width: 100px;
}

.modal-body .fixed-table-body {
	height : 257px;
	}
</style>
</head>
<body>
   <script src="js/default.js"></script>
   <script src="js/jquery-3.2.1.min.js"></script>
   <script src="js/bootstrap.min.js"></script>
   <script src="js/bootstrap-table.js"></script>
   <script src="js/bootstrap-table-cookie.js"></script>
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
                  <div class="contenttitle">졸업대상자 관리</div>
               </li>
            </ul>
            <table class="boardtable" id="table" data-toggle="table"
               data-pagination="true" data-search="true"
               data-side-pagination="true" data-page-list="[10]">
               <thead>
                  <tr>
                     <th data-field="state" data-checkbox="true"></th>
                     <th data-field="index" data-sortable="true">번호</th>
                     <th data-field="per_id" data-sortable="true">학번</th>
                     <th data-field="name" data-sortable="true">이름</th>
                     <th data-field="prof_name" data-sortable="true">교수</th>
                     <th data-field="graduation_date" data-sortable="true">졸업년도</th>
                     <th data-field="grd_state" data-sortable="true">단계</th>
                     <th data-field="grd_state_level" data-sortable="true">상태</th>
                     <th data-field="capstone" data-sortable="true">캡스톤이수</th>
                  </tr>
               </thead>
            </table>

            <div id="buttonmenu"style="margin-top: 10px;">
               
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
               <button type="button" class="close" data-dismiss="modal"
                  aria-label="Close">
                  <span aria-hidden="true">&times;</span>
               </button>
               <h4 class="modal-title">USER</h4>
            </div>
            <div id="howmany"></div>
            <div class="modal-body" id="myModalbody">
               <table id="insert_excel" data-toggle="table" data-height="299">
                  <thead>
                     <tr>
                        <th data-field="state" data-checkbox="true"></th>
                        <th data-field="number" data-sortable="true">번호</th>
                        <th data-field="per_id" data-sortable="true">학번</th>
                        <th data-field="name" data-sortable="true">이름</th>
                        <th data-field="prof_name" data-sortable="true">지도교수</th>
                        <th data-field="graduation_date" data-sortable="true">졸업년도</th>
                        <th data-field="grd_state" data-sortable="true">단계</th>
                        <th data-field="grd_state_level" data-sortable="true">상태</th>
                        <th data-field="capstone" data-sortable="true">캡스톤이수</th>
                        
                     </tr>
                  </thead>
               </table>
            </div>
            <div class="modal-footer" id="footer"></div>
         </div>
      </div>
   </div>
   <!-- Modal -->
   <div class="modal fade" id="myModal2" role="dialog">
      <div class="modal-dialog">
         <!-- Modal content-->
         <div class="modal-content">
            <div class="modal-header">
               <button type="button" class="close" data-dismiss="modal"
                  aria-label="Close">
                  <span aria-hidden="true">&times;</span>
               </button>
               <h4 class="modal-title">USER</h4>
            </div>
            <div id="howmany2"></div>
            <div class="modal-body" id="myModalbody2">            
               
            </div>
            <div class="modal-footer" id="footer2"></div>
         </div>
      </div>
   </div>
   <script>
   makeboard(tab_2)

               var buttonmenu=$('#buttonmenu');
               if (type.type_name == '졸업논문관리자' && <%=ordernum%> == 5){
                  var a='';
	               a+='<div class="col-xs-8"><input type="file" name="uploadFile" id="uploadFile" accept=".xls, .xlsx"></div>';
	               a+='<a href="graduationExcelDown.do"><button type="button" class="btn btn-default col-xs-1" style="height: 34px;">다운</button>';
	               a+='<a href="#myModal" data-toggle="modal" onclick="grd_excel()"><button type="button" class="btn btn-default col-xs-1" style="height: 34px;">엑셀업</button></a>';
	               a+='<a href="#myModal2" data-toggle="modal" onclick="insertgrduser()"class="btn btn-default col-xs-1">추가</a>';
	               a+='<a onclick="deletegrduser()"><button type="button" class="btn btn-default col-xs-1" style="height: 34px;">삭제</button></a>';
	               buttonmenu.html(a);
               }
               if(type.type_name == '졸업논문관리자' && <%=ordernum%> == 6){
            	   var a='';
	               a+='<a onclick="deletegrduser()" class="btn btn-default" style="height: 34px; float: right">삭제</a>';
	               buttonmenu.html(a);
               }
               
                 var users=<%=userlist%>;
                 
                  function callSetupTableView(){
                     $('#table').bootstrapTable('append',data());
                       $('#table').bootstrapTable('refresh');
                  }
                 
                
                function data(){
                   var rows = [];
                   for(var i=0;i<users.length;i++){
                      var value=users[i];
                      var cap="-1";
                      if(value.capstone=="0")
                        cap="미이수"; 
                      else if(value.capstone=="1")
                         cap="이수중";
                      else if(value.capstone=="2")
                         cap="이수";
                      else if(value.capstone=="3")
                         cap="해당없음";
                      rows.push({
                         index:i+1,
                          per_id:value.per_id,
                          name:'<a href="graduation_manage.do?num=94&perid='+value.per_id+'">'+value.name+'</a>',
                          prof_name:value.prof_name,
                          graduation_date:value.graduation_date,
                          grd_state:value.grd_state,
                          grd_state_level:value.grd_state_level,
                          capstone : cap
                      });
                   }
                   return rows;
                }
                
                $(document).ready(function(){
                    callSetupTableView();
                    }) 
                    
          var addgrd=null;
          function grd_excel(){
                   var address = uploadexcel();
                   $.ajax({
                      url : "graduationexcel.do",
                      type : "post",
                      async : false,
                      data : {
                         address : address
                      },
                      dataType : "json",
                      success : function(data){
                         addgrd=data;
                         var modal = $('#MyModalbody');
                         var howmany =$('#howmany');
                         var a = '<h3> 총 ' + (data.length)+ '명의 회원이 등록될 예정입니다.</h3>';
                         howmany.html(a);
                         var table=$('#insert_excel');
                         table.bootstrapTable('load',insertdata(data));
                         table.bootstrapTable('refresh');
                         var footer = $('#footer');
                         footer.html('<button id="deletegrd" class="btn btn-default" onclick="deletegrd('+data.length+')">선택 삭제</button><button id="addbutton" type="button" class="btn btn-default" style = "margin : 1px;" onclick="addgrduser()">일괄 추가</button>');
                      }
                   })
                }          //여기까지
                    
                
                
          function insertdata(data){
              var rows = [];
              for(var i=0;i<data.length;i++){
                 var value=data[i];
                 rows.push({
                       index:(i+1),
                     per_id:value.per_id,
                     name:value.name,
                     prof_name:value.prof_name,
                     graduation_date:value.graduation_date,
                     grd_state:value.grd_state,
                     grd_state_level:value.grd_state_level,
                     capstone : value.capstone
                 });
              }
              return rows;
           }   
         function uploadexcel(){
            var formData = new FormData();
            var address="";
            formData.append("excelfile",$('input[name=uploadFile]')[0].files[0]);
            $.ajax({
               url : "insertExcel.do",
               type : "post",
               async:false,
               data : formData,
                 processData : false,
                 contentType : false,
                 success : function(data){//데이터는 주소
                 address =data;
                 }
            })
         
         return address;
      }
         
         function deletegrd(length){
            var table=$('#insert_excel');
            var per_ids=$.map(table.bootstrapTable('getSelections'),function(row){
               return row.per_id;
            });
            table.bootstrapTable('remove', {
                 field: 'per_id',
                 values: per_ids
             });
            var howmany =$('#howmany');
            var a = '<h3> 총 ' + (length-per_ids.length)+ '명의 회원이 등록될 예정입니다.</h3>';
            howmany.html(a);
         }
         function deletegrduser(){
            var ordernum = <%=ordernum%>
            var table=$('#table');
            var per_ids=$.map(table.bootstrapTable('getSelections'),function(row){
               return row.per_id;
            });
            var deleteuser="";
            if(per_ids.length == 0){
            	alert('선택된 사람이 없습니다.');
            	return;
            }
            for(var i=0;i<per_ids.length;i++){
               deleteuser+=per_ids[i]+"-/-/-";
            }
            if(ordernum==5){
               $.ajax({
                   url:"ajaxuser.do",
                   type:"post",
                   dataType : "json",
                   data : {
                      req : "deletegrduser",
                      data : deleteuser
                   },
                   success : function(data){
                      alert(data+"명의 인원이 삭제되었습니다.");
                      location.reload();
                   }
                })
            }else if(ordernum==6){
               $.ajax({
                   url:"ajaxuser.do",
                   type:"post",
                   dataType : "json",
                   data : {
                      req : "deletegrdrequser",
                      data : deleteuser
                   },
                   success : function(data){
                      alert(data+"명의 인원이 삭제되었습니다.");
                      location.reload();
                   }
                })
            }else{
               alert("잘못된 접근 방식입니다.");               
            }
         }
         
         function addgrduser(){
             var table=$('#insert_excel');
             var data1=JSON.stringify(table.bootstrapTable('getData'));
             $.ajax({
                url:"ajaxuser.do",
                type:"post",
                dataType : "json",
                data : {
                   req : "insertgrduser",
                   data : data1
                },
                success : function(data){
                   var text = data[data.length-1]+"명의 인원이 추가되었고 "+data[data.length-2]+"명의 인원이 수정되었습니다.\n제외된 인원들  " + (data.length - 2) + "명(유저에 없는 학번) : ";
                   for(var i = 0 ; i < data.length - 2 ; ++i){
                	   text += data[i];
                	   if(i != (data.length - 3))
                		   text += ', ';
                   }
                   alert(text);
               location.reload();
                  
                }
             })
          }
         function insertgrduser(){
            var proflist=<%=proflist%>;
             var list = $('#myModalbody2');
             var today = new Date();
             var year = today.getFullYear();
             var a = '<div class="form-group"><label for="InputID">학번</label><span id="warningID"></span><div class="input-group"><input onkeypress="changeID()" type="text" class="form-control" placeholder="학번를 입력해주세요" id="InputID"><span class="input-group-btn"><button class="btn btn-default" type="button" onclick="checkID();">학번확인</button></span></div></div>';
             a += '<div class="form-group" id="name1"><label for="InputName">이름</label><input type="text" class="form-control" id="InputName" placeholder="이름을 입력해주세요"></div>';
             a += '<div class="form-group"><label for="Inputcapstone" style="display :inline-block">지도교수 배정</label><select class="form-control" id="Inputprofessor">';
             for(var i=0;i<proflist.length;i++){
                a+='<option>'+proflist[i]+'</option>';
             }
             a+='</select></div>';
             a += '<div class="form-group"><label for="Inputcapstone" style="display :inline-block">캡스톤이수여부</label><select class="form-control" id="Inputcapstone"><option>미이수</option><option>이수중</option><option>이수</option><option>해당없음</option></select></div>';   
             a += '<div class="form-group"><label for="Inputdate" style="display :inline-block">졸업년도</label><select class="form-control" id="Inputdate"><option>'+(year)+'-08</option><option>'+(year+1)+'-02(3월~12월)</option><option>'+(year+1)+'-02(9월~12월)</option></select></div>';   
             a += '<div class="col-xs-13 text-right"><button class="btn btn-default" onclick="insertonegrduser()">회원가입</button></div>';
             a += '<input type="submit" onclick="insertonegrduser()" style="display : none">';
              list.html(a);
          }
         function checkID(){
             var id = $('#InputID').val();
             $.ajax({
               url:"ajax.do",
               type:"post",
               data:{
                  req:"checkper_id",
                  data: id
               },
               success:function(data){
                  var result = data.split("-/-/-");
                  if(result[0] == '0'){
                     ischeckID = 0;
                     $('#warningID').html('*존재하는 학번 & 졸업논문 대상자에 들어있지 않습니다');
                     $('#warningID').css('color', 'blue');
                     $('#warningID').css('font-size', '11px');
                     $('#warningID').css('margin-left', '10px');
                     $('#name1').html('<label for="InputName">이름</label><input type="text" class="form-control" id="InputName" placeholder="이름을 입력해주세요" value='+result[1]+'>')
                  }
                  else if (data=='1'){
                     ischeckID = 1;
                     $('#warningID').html('*졸업 대상자에 포함되어있습니다');
                     $('#warningID').css('color', 'red');
                     $('#warningID').css('font-size', '11px');
                     $('#warningID').css('margin-left', '10px');
                  }
                  else{
                     ischeckID = 1;
                     $('#warningID').html('*존재하지 않는 학번입니다');
                     $('#warningID').css('color', 'red');
                     $('#warningID').css('font-size', '11px');
                     $('#warningID').css('margin-left', '10px');
               }
               }
            })
          }
      
      function changeID(){
         ischeckID = 0;
         $('#warningID').html('*학번 중복확인을 해주세요');
         $('#warningID').css('color', 'black');
         $('#warningID').css('font-size', '11px');
         $('#warningID').css('margin-left', '10px');
      }
      function insertonegrduser(){
            if($('#warningID').text() == '*존재하는 학번 & 졸업논문 대상자에 들어있지 않습니다'){
               
                  var per_id =$('#InputID').val();
                  var name = $('#InputName').val();
                  var prof_name = $('#InputProf_Name').val();
                  var date = $('#Inputdate').val();
                  var capstone = $('#Inputcapstone').val();
                  var prof=$('#Inputprofessor').val();
                  if(name!='' && per_id!='' && prof_name!='' && date!=''){
                     var update = per_id+"-/-/-"+name+"-/-/-"+date+"-/-/-"+capstone+"-/-/-"+prof;
                     $.ajax({
                        url:"ajaxuser.do",
                        type:"post",
                        data:{
                           req:"insertonegrduser",
                           data: update
                        },
                        success:function(data){
                           alert("학번 : "+data+"  추가 완료");
                           location.reload();
                           }
                        })
                     }
                  else{
                     alert("빈칸을 채워주세요");
                  }
               }
            else
               alert("아이디 중복확인을 해주세요");
            }
     
      
   
                  </script>
</body>
</html>