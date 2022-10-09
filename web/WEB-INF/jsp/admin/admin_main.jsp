<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
    StringBuffer url2_admin_main = request.getRequestURL();
    String logo_img_admin_main;

    //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
    //ai이면 ai로고 cs이면 cs로고
    if(url2_admin_main.substring(7,9).equals("ai") || url2_admin_main.substring(7,9).equals("lo")){
        logo_img_admin_main = "img/notice_ai.png";
    }
    else{
        logo_img_admin_main = "img/notice.png";
    }
    //System.out.println((logo_img_admin_main));
%>
<% 
String tabmenulist=(String) request.getAttribute("tabmenulist");//관리자탭메뉴
String schedulelist = (String) request.getAttribute("schedulelist");//스케쥴 리스트
String images = (String) request.getAttribute("images");
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="utf-8">
<title>메인관리 : 경기대학교 AI컴퓨터공학부</title>
<link rel="stylesheet" href="css/bootstrap-table.css">
<link href='css/bootstrap.css' rel='stylesheet' type='text/css'>
<link href='css/default.css' rel='stylesheet' type='text/css'>
<link href='css/boardtable.css' rel='stylesheet' type='text/css'>
<link href='css/information.css' rel='stylesheet' type='text/css'>
<link href='css/content.css' rel='stylesheet' type='text/css'>

<style>
#maincontent {
   padding: 0;
}

#maincontent>ul {
   padding: 10px;
}
.boardtable > thead > tr > th, .boardtable > tbody > tr > td{
   text-overflow: ellipsis;
    overflow: hidden;
    white-space: nowrap;
      text-align: center;
      border-right : none;
      border-left : none;
}
.boardtable > thead > tr > th:nth-child(1), .boardtable > tbody > tr > td:nth-child(1) {
    min-width: 100px;
    max-width: 100px;
    width: 100px;
}
.boardtable > thead > tr > th:nth-child(3), .boardtable > tbody > tr > td:nth-child(3) {
    min-width: 200px;
    max-width: 200px;
    width: 200px;
}
.boardtable > thead > tr > th:nth-child(2), .boardtable > tbody > tr > td:nth-child(2) {
    min-width: 390px;
    max-width: 390px;
    width: 390px;
}
.fixed-table-container{
	border : none;
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
          <img src=<%=logo_img_admin_main%> />
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
                  <div class="contenttitle">일정 관리</div>
               </li>
            </ul>
            <table class="boardtable" id="scheduleTable" data-toggle="table"
               data-pagination="true"
               data-search="true" data-side-pagination="true"
               data-page-list="[10]">
               <thead>
                  <tr>
                     <th data-field="index" data-sortable="true">번호</th>
                     <th data-field="content" data-sortable="true">일정</th>
                     <th data-field="date" data-sortable="true">날짜</th>
                  </tr>
               </thead>
            </table>
            
            <div style="margin-top:10px;"> <div class="col-md-10"></div>
               <a href="#myModal" data-toggle="modal" onclick="insertSch()" class="btn btn-default col-md-1">추가</a>
               <button type="button" class="btn btn-default col-md-1" onclick="updateSch()" style="height:34px;">갱신</button>
            </div>
            <hr style="border :1px dotted black; margin-top : 60px">
            <ul>
               <li>
                  <div class="contenttitle">사진 관리</div>
               </li>
            </ul>
            <span style="font-size : 13px">※사진은 최신 업로드순으로 보여지며, 무조건 하나 이상의 사진이 남아있어야 합니다.</span>
             <table class="boardtable" id="imageTable" data-toggle="table">
               <thead>
                  <tr>
                     <th data-field="index" data-sortable="true">현재 순서</th>
                     <th data-field="name" data-sortable="true">이름</th>
                     <th data-field="for_delete"></th>
                  </tr>
               </thead>
            </table>
            <div style="margin : 20px 0; float :right"">
            	<input type="file" style="display:inline-block; margin-right : 10px"><button class="btn btn-default" onclick="submitImage()">추가</button>
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
          <h4 class="modal-title">일정관리</h4>
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
   function updateSch(){
      var date = new Date();
      $.ajax({
         url:"ajax.do",
            type:"post",
            data : {
                  req : "updateSchedule",
                  data : date
            },
            success : function(){
               alert("일정 갱신 완료");
               location.reload();
            }
         
      })
      
   }
   
   function insertSch(){
      var list = $('#myModalbody');
      var a = '';
       a += '<div class="form-group"><label for="InputBirth">날짜</label><input type="date" class="form-control" id="InputBirth" name = "new_date" value ='+formatDate(new Date())+' placeholder="Date of Birth" required></div><br/>';
       a += '<div><input type = "text" class="form-control" name = "new_text" placeholder="내용을 입력하세요" required/></div><br/>';
       a += '<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>'
       a += '<button type="button" class="btn btn-default pull-right" data-dismiss="modal"aria-label="Close" onclick="insertSchedule()">완료</button>';
       list.html(a);
   }
   
   function formatDate(date) {
       var d = new Date(date),
           month = '' + (d.getMonth() + 1),
           day = '' + d.getDate(),
           year = d.getFullYear();

       if (month.length < 2) month = '0' + month;
       if (day.length < 2) day = '0' + day;

       return [year, month, day].join('-');
   } 
   
   function insertSchedule(){
      var date = $('[name = new_date]').val();
      var text = $('[name = new_text]').val();
      if(text.length>=50){
         alert("내용이 너무 깁니다!");
         return;
      }
      var data = date + '-/-/-' + text;
      $.ajax({
         url:"ajax.do",
            type:"post",
            data : {
                  req : "insertschedule",
                  data : data
            },
            success : function(){
               location.reload();
            }
         
      })
      
   }
   
   function modifySchedule(str){
      var list = $('#myModalbody');
      $.ajax({
         url:"ajax.do",
         type:"post",
         data : {
               req : "getoneschedule",
               data : str
         },
         dataType:"json",
         success:function(data){
            var a = "";
            var it = data;
            a += '<div class="form-group"><label for="InputBirth">날짜</label><input type="date" class="form-control" id="InputBirth" name = "w_date" value ='+formatDate(it.date)+' placeholder="Date of Birth" required></div><br/>';
            a += '<div><input type = "text" class="form-control" name = "w_content" value = '+it.content+' required/></div><br/>';
            a += '<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>'
            a += '<button type="button" class="btn btn-default pull-right" onclick="deleteSch('+it.index+')">삭제</button>';
            a += '<button type="button" class="btn btn-default pull-right" data-dismiss="modal"aria-label="Close" onclick="modifySch('+it.index+')">완료</button>';
            list.html(a);
         }
      });
     
   } 
   
   function deleteSch(index){
      $.ajax({
           url : "ajax.do",
           type : "post",
           data : {
              req : "deleteschedule",
              data : index
           },
           success : function(data) {
              alert("삭제가 완료되었습니다");
              location.reload();
           }
        })
      
   }
   
   function modifySch(str){
            var index = str;
            var date = $('[name=w_date]').val();
            var content = $('[name=w_content]').val();
            if(content.length>=50){
               alert("내용이 너무 깁니다!");
               return;
            }
            if(date==""||content=="") {
               alert("수정할 값을 전부 입력해주세요.")
               return;
               }
            var update = index + "-/-/-" + date + "-/-/-" + content;

            $.ajax({
                     url : "ajax.do",
                     type : "post",
                     data : {
                        req : "modifyschedule",
                        data : update
                     },
                     dataType : "json",
                     success : function(data) {
                        alert("수정이 완료되었습니다");
                        location.reload();
                     }
                  })
         }
   
                 var schedules=<%=schedulelist%>;
                 
                  function callSetupTableView1(){
                     $('#scheduleTable').bootstrapTable('append',data1());
                       $('#scheduleTable').bootstrapTable('refresh');
                  }
                 
                  function callSetupTableView2(){
                      $('#imageTable').bootstrapTable('append',data2());
                        $('#imageTable').bootstrapTable('refresh');
                   }
                
                function data1(){
                   var rows = [];
                   for(var i=0;i<schedules.length;i++){
                      var value=schedules[i];
                      rows.push({
                         index: i+1,
                         date: formatDate(value.date),
                         content:'<a data-toggle="modal" href="#myModal" onclick="modifySchedule('+value.index+')">'+value.content+'</a>'
                      });
                   }
                   return rows;
                }
                var images = <%=images%>;
                
                function data2(){
                	var rows = [];
                	for(var i=0 ; i < images.length ; ++i){
                		var value = images[i];
                		rows.push({
                			index : i+1,
                			name : value.original_name,
                			for_delete : '<a onclick="deleteImage(' + value.id + ')" class="btn btn-default" style="padding : 3px 10px">삭제</a>'
                		})
                	}
                	return rows;
                }
                
                function deleteImage(id){
                	if(images.length == 1){
                		alert('이미지가 한개밖에 남지 않았습니다. 지울 수 없습니다.');
                		return;
                	}
                	$.ajax({
                		url : 'ajax.do',
                		type : 'post',
                		data : {
                			req : 'deleteSlider',
                			data : id
                			},
                		success : function(data){
                			if(data == 'success'){
                				alert('삭제 성공');
                				window.location.href = 'admin.do?num=81';
                			}else
                				alert('SERVER ERROR, Please try again later...');}
                	});
                }
                
                function submitImage(){
                	var formData = new FormData();
                	  if($('input[type=file]')[0].files[0]==undefined){
                     	 alert('사진을 선택해주세요!');
                     	 return;
                      }
                	formData.append('file', $('input[type=file]')[0].files[0]);
                	$.ajax({
                		url : 'slider_upload.do',
                		type : 'post',
                		data : formData,
                		processData : false,
                        contentType : false,
                		success : function(data){
                			if(data == 'success'){
                				alert('등록 성공');
                				window.location.href = 'admin.do?num=81';
                			}
                			else
                				alert('SERVER ERROR, Please try again later...');}
                		})
                }
                
                
                $(document).ready(function(){
                    callSetupTableView1();
                    callSetupTableView2();
                    }) 
                  </script>
</body>
</html>