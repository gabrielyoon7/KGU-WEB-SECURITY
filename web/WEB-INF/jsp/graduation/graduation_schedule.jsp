<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
    StringBuffer url2_grd_schedule = request.getRequestURL();
    String logo_img_grd_schedule;

    //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
    //ai이면 ai로고 cs이면 cs로고
    if(url2_grd_schedule.substring(7,9).equals("ai") || url2_grd_schedule.substring(7,9).equals("lo")){
        logo_img_grd_schedule = "img/graduation_ai.png";
    }
    else{
        logo_img_grd_schedule = "img/graduation.png";
    }
    //System.out.println((logo_img_grd_schedule));
%>
<%
   String schedulelist = (String) request.getAttribute("schedulelist");
   String num = (String) request.getAttribute("num");
   String tabmenulist=(String) request.getAttribute("tabmenulist");//관리자탭메뉴
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
<link href='./css/graduation.css' rel='stylesheet' type='text/css'>
<link href='./css/content.css' rel='stylesheet' type='text/css'>
<link href='./css/boardtable.css' rel='stylesheet' type='text/css'>
<link href='./css/bootstrap.css' rel='stylesheet' type='text/css'>
<link href='./css/information.css' rel='stylesheet' type='text/css'>
<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="//cdn.ckeditor.com/4.8.0/standard/ckeditor.js"></script>
<style>
#maincontent>ul {
   padding: 10px;
}

.input_container input {
   width: 200px;
}

th {
   text-align: center;
}

.boardtable>tbody>tr>td:nth-child(2) {
   min-width: 100px;
}

.boardtable {
   margin: 0 auto;
   width: 700px;
   font-size: 15px;
}
</style>
</head>
<body>
   <script src="js/default.js"></script>

   <%@include file="../main/header.jsp"%>
   <main>
   <div id="content">
      <div id="title">
          <img src=<%=logo_img_grd_schedule%> />
<!--          <img src="img/graduation.png" alt="">  여기만 특이하게 이거인데 삭제함 prepend가 없음.-->
         <div>졸업논문</div>
      </div>
      <div id="container">
         <div id="tab">
            <ul id="tabMenu">
            </ul>
         </div>
         <div id="maincontent">
            <ul>
               <li>
                  <div class="contenttitle" id="title2"></div>
                  <ul>
                     <li>
                        <table class="boardtable" id="scheduletable">

                        </table>
                        <div class="col-md-11"></div>
                        <div class="col-md-1" id="modifydate"></div>
                        <div id="graduationcontent">
                        </div>
                     </li>
                  </ul>
               </li>
            </ul>
         </div>

      </div>
   </div>
   
   </main>
   <%@include file="../main/footer.jsp"%>
   <div id="shadow">
      <div id="blur"></div>
   </div>
   <!-- modal -->
   <div class="modal fade" id="modifyModal" role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal"aria-label="Close">
                     <span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title">졸업논문 일정 수정</h4>
        </div>
        <div class="modal-body" id = "myModalbody">
        </div>
        <div class="modal-body" id = "myModalbody2">
        </div>
        <div class="modal-footer">
        </div>
      </div>
    </div>
  </div>
   <script>
    function formatData(date) {
         var d = new Date(date), month = '' + (d.getMonth() + 1), day = ''
               + d.getDate(), year = d.getFullYear();

         if (month.length < 2)
            month = '0' + month;
         if (day.length < 2)
            day = '0' + day;
      
         return [ year, month, day ].join('-');
      }
   var list = $('#tabMenu');
   var title = $('#title2');
   
   var tabmenu = <%=tabmenulist%>;
   var number=<%=num%>;
   for (var i = 0; i < tabmenu.length; ++i) {
      var value = tabmenu[i];
      var num = value.tab_id*10+value.orderNum;
      var text = '<li><span class="deco_dot">●</span><a href="'+value.path+'?num='+num+'">'+ value.page_title + '</a></li>'
               list.append(text);
      if(number==num){
         title.append(value.page_title);
      }
      }
   
   
   
      var mod=$('#modifydate');
      if(type.type_name =='졸업논문관리자')
      mod.append('<a href="#modifyModal" data-toggle="modal" onclick="modifydate()" class="btn btn-default">수정</a>');
      var table = $('#scheduletable');
      var content=$('#graduationcontent');
      var schedule=<%=schedulelist%>;
      table.append('<thead><tr><th>단계</th><th>시작 일정</th><th>종료 일정</th><th>상태</th></tr></thead>');//head부분
      table.append('<tbody>');
      
      for(var i=0;i<schedule.length;i++){
         var value=schedule[i];//단계 진행일정 상태
         table.append(addtable(value));
         content.append('<div class="contenttitle2" >'+value.schedule_name+'</div>');
         content.append('<div id="content'+i+'_modi">'+value.schedule_contents+'</div>');
         if(type.type_name =='졸업논문관리자')
         content.append('<div class="col-xs-10"></div><div id="button'+i+'"><a onclick="modifycontent('+i+')" class="btn btn-default">수정</a></div>');
      }
      table.append('</tbody>');
      
      function addtable(value){
         var a='';
         var closing=new Date(value.end_date);
         var dayOfMonth = closing.getDate();  
         closing.setDate(dayOfMonth - 1); 
         a+='<tr>';
         a+='<td>'+value.schedule_name+'</td>';
         a+='<td>'+formatData(value.starting_date)+'</td>';
         a+='<td>'+formatData(closing)+'</td>';
         a+='<td>'+value.grd_state+'</td>';
         a+='</tr>';
         return a;
      }
      function addvalue(){
         var a='';
         for(var i=0;i<schedule.length;i++){
            var value =schedule[i];
            a+='<option value="'+value.schedule_name+'">'+value.schedule_name+'</option>';
         }   
         return a;
      }
      
      function modifydate(){
          var list = $('#myModalbody');
            var a = '';
             a += '<div class="form-group"><span>변경할 일정 :</span><select onchange="selectType()" style="display : inline-block; width:200px;" class="form-control" name="menutype"><option value="default">선택해주세요</option>';
             a +=   addvalue()+'</div><br>';
             a += '<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>'
             a += '<button type="button" class="btn btn-default pull-right" data-dismiss="modal"aria-label="Close" onclick="insertSchedule()">완료</button>';
             list.html(a);
      }
      function selectType(){
         var list =$('#myModalbody2');
         list.empty();
         var val=$('[name=menutype]').val();
         var a='';
         for(var i=0;i<schedule.length;i++){
               if(val==schedule[i].schedule_name){
                  var start =formatData(schedule[i].starting_date);
                  var closing=new Date(schedule[i].end_date);
                  var dayOfMonth = closing.getDate();  
                  closing.setDate(dayOfMonth - 1); 
                  var close = formatData(closing);
                   a += '<div class="form-group"><label for="Inputstart">날짜</label><input type="date" class="form-control" id="Inputstart" name = "starting_date" value ="'+start+'" placeholder="Date of Birth" required></div><br/>';
                   a += '<div class="form-group"><label for="Inputclose">날짜</label><input type="date" class="form-control" id="Inputclose" name = "closing_date" value ="'+close+'" placeholder="Date of Birth" required></div><br/>';
                   a += '<button type="button" class="btn btn-default pull-right" data-dismiss="modal"aria-label="Close" onclick="modifySchedule()">수정</button>';
                   a += '<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>'
                         
               }
         }
         list.html(a);
      }
      function modifySchedule(){
         var val=$('[name=menutype]').val();
         var start=new Date($('[name=starting_date]').val());
         var close=new Date($('[name=closing_date]').val());
         if(start.getTime()>close.getTime()){
            alert("종료일정이 시작일정보다 빠릅니다");
            location.reload();
            return;
         }
         var data=val+"-/-/-"+$('[name=starting_date]').val()+"-/-/-"+$('[name=closing_date]').val();
         $.ajax({
            url:"ajax.do",
            type:"post",
            data : {
               req : "insertgradschedule",
               data : data
            },
            success : function(data){
               alert(data+" 상태로 변경이 되었습니다");
               location.reload();
            }
         })
      }
      
      
      function modifycontent(i){
         var a='';
         var b='';
      
         var button = $('#button'+i);
         b+='<a class="btn btn-default" style = "margin : 2px;" onclick="modifycon('+i+')">수정</button><a class="btn btn-default" style = "margin : 2px;" onclick="back('+i+')">뒤로</button>';
         a+='<textarea name="content'+i+'" id="editor'+i+'" required>'+schedule[i].schedule_contents+'</textarea>';
         button.html(b);
         $('#content'+i+'_modi').html(a);
         var edi ='editor'+i;
         CKEDITOR.replace(edi, {
                allowedContent: true,
                height: 100,
                'filebrowserUploadUrl': '/Uploader'
            });
      }
      function back(i){
         var a=schedule[i].schedule_contents;
         var b='';
         var button =$('#button'+i);
         b+='<a onclick="modifycontent('+i+')" class="btn btn-default">수정</a>';
         $('#content'+i+'_modi').html(a);
         button.html(b);
      }
      function modifycon(i){
         var schedulename=schedule[i].schedule_name;
         var id='editor'+i;
         var content=CKEDITOR.instances[id].getData();
         var modify=schedulename+"-/-/-"+content;
         
         $.ajax({
            url : "ajax.do",
            type : "post",
            data : {
               req : "modifygracon",
               data : modify
            },
            success : function(data){
               var a=data;//content만 받아오자
               var button =$('#button'+i);
               var b='<a onclick="modifycontent('+i+')" class="btn btn-default">수정</a>';
               $('#content'+i+'_modi').html(a);
               button.html(b);
               alert("완료되었습니다");
            }
         })
      }
      
   </script>
</body>
</html>