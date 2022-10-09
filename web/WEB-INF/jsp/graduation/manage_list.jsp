<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
String userlist = (String) request.getAttribute("userlist");
String tabmenulist = (String) request.getAttribute("tabmenulist");
String ordernum = (String) request.getAttribute("ordernum");

String request_list =(String) request.getAttribute("request_list");
String suggest_list =(String) request.getAttribute("suggest_list");
String mid_list =(String) request.getAttribute("mid_list");
String final_list =(String) request.getAttribute("final_list");
String etc_list =(String) request.getAttribute("etc_list");

%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="utf-8">
<title>관리리스트 : 경기대학교 AI컴퓨터공학부</title>
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
   min-width: 40px;
   max-width: 40px;
}

.boardtable>thead>tr>th:nth-child(4) {
   width: 80px;
}

.boardtable>tbody>tr>td:nth-child(2) {
   font-family: 'Nanum Gothic', sans-serif;
   min-width: 40px;
   max-width: 40px;
}

.boardtable>tbody>tr>td:nth-child(4) {
   width: 100px;
}
.boardtable>tbody>tr>td:nth-child(5), .boardtable>thead>tr>th:nth-child(5){
   min-width : 65px;
   max-width : 65px;
}
.boardtable>tbody>tr>td:nth-child(6), .boardtable>thead>tr>th:nth-child(6){
   min-width : 75px;
   max-width : 75px;
}

.boardtable>tbody>tr>td:nth-child(7),.boardtable>tbody>tr>td:nth-child(8),.boardtable>tbody>tr>td:nth-child(9),.boardtable>tbody>tr>td:nth-child(10),.boardtable>tbody>tr>td:nth-child(11),
.boardtable>thead>tr>th:nth-child(7),.boardtable>thead>tr>th:nth-child(8),.boardtable>thead>tr>th:nth-child(9),.boardtable>thead>tr>th:nth-child(10),.boardtable>thead>tr>th:nth-child(11){
   min-width: 65px;
   max-width: 65px;
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
                  <div class="contenttitle">졸업논문 관리</div>
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
                     <th data-field="graduation_date" data-sortable="true">졸업</th>
                     <th data-field="form_request" data-sortable="true">신청</th>
                     <th data-field="form_suggest" data-sortable="true">제안</th>
                     <th data-field="form_mid" data-sortable="true">중간</th>
                     <th data-field="form_final" data-sortable="true">최종</th>
                     <th data-field="form_etc" data-sortable="true">기타</th>
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
   <script>
                 var users=<%=userlist%>;
                 var request_list=<%=request_list%>;
                 var suggest_list=<%=suggest_list%>;
                 var mid_list=<%=mid_list%>;
                 var final_list=<%=final_list%>;
                 var etc_list=<%=etc_list%>;
                 
                 function set_state(list,value,stage_number){//list=log_list의 종류 / value = user 객체
                     var answer='';//미제출:"x" 제출:"O" 지연:"?" 승인:"success_date"
                     var data='';
                    if(list!='')   
                     data=list[0].schedule_name;    
                       for(var i=0;i<list.length;i++){//신청log만 - 미제출/제출/승인 만있음
          
                          if(value.per_id==list[i].per_id){//per_id = 학번이 같으면 ==log가 있으면
                             
                                if(list[i].success_date!=null){//승인까지됬으면
                             
                                   answer = '<span title="'+formatmd(list[i].success_date,".")+'">승인</span   >';//승인날짜띄움
                                   break;
                                }else if(list[i].submit_date!=null){//제출'만'했으면
                                      if(list[i].refuse_date!=null){
                                         answer='<span title="'+formatmd(list[i].refuse_date,".")+'">반려</span>';
                                         break;
                                      }else{
                                         answer='<a title="'+formatmd(list[i].submit_date,".")+'" href="graduation_form.do?modify=2&stage='+stage_number+'&num=94&per_id='+value.per_id+'">O</a>';//'o'띄우고 보기링크
                                         break;
                                      }
                                }      
                             }
                       }
                  if(stage_number=='6'&&answer==''){
                    if(value.capstone!=0){
                     if(value.etc_level=="지연"){
                           
                         answer='<a href="graduation_manage.do?num=94&perid='+value.per_id+'">지연</a>';
                      }else if(value.delay_date!=null&&!(value.etc_level=='대기')){
                         answer='<span title="'+formatmd(value.delay_date,".")+'">연장</span>';
                      }else{
                            answer='X';
                      }   
                    }else
                       answer='-';
                  }else{
                  if(answer==''){
                      if(value.grd_state_level=="지연"){
                         //지연,연장 구분
                            answer='<a href="graduation_manage.do?num=94&perid='+value.per_id+'">지연</a>';//'?'띄우고 보기링크
                         }else if(value.delay_date!=null&&value.grd_state==data){
                            answer='<span title="'+formatmd(value.delay_date,".")+'">연장</span>';//대기,불가 구분
                         }
                            else
                               answer='X';
                  }
                  }   
                      return answer;
                  }
                 
                
                 
                 
                  function callSetupTableView(){
                     $('#table').bootstrapTable('append',data());
                       $('#table').bootstrapTable('refresh');
                  }
                  function data(){
                      var rows = [];
                       for(var i=0;i<users.length;i++){//전체유저
                              var value=users[i];
                             var result_1 = set_state(request_list,value,"1");
                            var result_2=null;
                            var result_3=null;
                             var result_4=null;
                             var result_5=null;
                             if(!(result_1.includes("승인"))){
                               result_2="-"
                                  result_5="-"
                            }else{
                               result_2 = set_state(suggest_list,value,"2");
                                result_5 =set_state(etc_list,value,"6");
                       }
                            if(!(result_2.includes("승인"))){
                            result_3="-"
                         }else
                               result_3 = set_state(mid_list,value,"3");
                            if(!(result_3.includes("승인"))){
                            result_4="-"
                         }else
                            result_4 = set_state(final_list,value,"4");                       
                           
                            
                             
                         rows.push({
                            index:i+1,
                             per_id:value.per_id,
                             name:'<a href="graduation_manage.do?num=94&perid='+value.per_id+'">'+value.name+'</a>',
                             prof_name:value.prof_name,
                             graduation_date:value.graduation_date,
                             form_request : result_1,
                             form_suggest : result_2,
                             form_mid : result_3,
                             form_final : result_4,
                             form_etc : result_5
                         });
                          }
                   return rows;
                }
                
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
                
                $(document).ready(function(){
                    callSetupTableView();
                    makeboard(tab_2)
                    })
                    
              function formatmd(date,comma) {
                  var d = new Date(date), month = '' + (d.getMonth() + 1), day = ''
                  + d.getDate();

            if (month.length < 2)
               month = '0' + month;
            if (day.length < 2)
               day = '0' + day;
         
            return [month, day ].join(comma);
         }
</script>
</body>
</html>