<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
    StringBuffer url2_na_writer = request.getRequestURL();
    String logo_img_na_writer;

    //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
    //ai이면 ai로고 cs이면 cs로고
    if(url2_na_writer.substring(7,9).equals("ai") || url2_na_writer.substring(7,9).equals("lo")){
        logo_img_na_writer = "img/notice_ai.png";
    }
    else{
        logo_img_na_writer = "img/notice.png";
    }
    //System.out.println((logo_img_na_writer));
%>
<% 
String num = (String)request.getAttribute("num");
String tabmenulist=(String) request.getAttribute("tabmenulist");
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="utf-8">
<title>글 쓰기:경기대학교 AI컴퓨터공학부</title>
<link href='css/bootstrap.css' rel='stylesheet' type='text/css'>
<link href='css/default.css' rel='stylesheet' type='text/css'>
<link href='css/information.css' rel='stylesheet' type='text/css'>
<link href='css/content.css' rel='stylesheet' type='text/css'>
<link href='css/fileinput.min.css' rel='stylesheet' type='text/css'>
<link href='css/fileinput-rtl.min.css' rel='stylesheet' type='text/css'>
<link href="css/theme.css" media="all" rel="stylesheet" type="text/css" />
<link
   href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
   media="all" rel="stylesheet" type="text/css" />
<style>
#maincontent {
   padding: 0;
}

#maincontent>ul {
   padding: 10px;
}

#container {
   width: 1000px;
}

#maincontent {
   margin: 0 auto;
   border: none;
}

#post_title {
   width: 744px;
}

#afile3-list {
   font-size: 13px;
}

#afile3-list a {
   color: tomato;
}

.file-drop-zone-title{
   padding : 25px 10px;
}

.kv-file-content {
   width : 500px !important;
}

.file-details-cell {
   display : none;
}

.kv-zoom-thumb {
	display : none;
}

.fileinput-remove{
	display : none;
}
</style>
</head>
<body>

   <script src="js/default.js"></script>
   <script src="js/jquery-3.2.1.min.js"></script>
   <script src="js/jquery.cookie.js"></script>
   <script src="//cdn.ckeditor.com/4.8.0/standard/ckeditor.js"></script>
   <script src="js/bootstrap.min.js"></script>
   <script src="js/fileinput.min.js"></script>
   <script src="js/sortable.min.js" type="text/javascript"></script>
   <script src="js/theme.js" type="text/javascript"></script>
   <%@include file="../main/header.jsp"%>
   <main>
   <div id="content">
      <div id="title">
          <img src=<%=logo_img_na_writer%> />
          <div id="titlename"></div>
      </div>
      <div id="container">
         <div id="tab">
            <ul id="tab_2">

            </ul>
         </div>
         <div id="maincontent">
               <ul>
                  <li>
                     <div id="articlename" class="contenttitle">글 작성하기</div>
                  </li>
               </ul>
               <div class="form-group">
    				<input type="text" class="form-control" id="post_title" name="title" placeholder="제목 :">
  			   </div>
               <textarea name="content" id="editor"></textarea>
               <!-- 파일첨부 -->
                  <div class="file-loading">
                     <input id="kv-explorer" type="file" multiple>
                  </div>
                   <div class="post_button" id="post_submit_btn">
                     <a href="javascript:exit();history.back()" class="btn btn-default">취소</a> 
                     <a onclick="insertboard()" id="post_submit" class="btn btn-default">쓰기</a> 
                  </div>
               <script>
      
         var list = $('#tab_2');
         var articlename=$('#articlename');
         var arr = <%=tabmenulist%>
         var num=<%=num%>;
             numo=num%10;
            numt=num/10;
         for (var i = 0; i < arr.length; i++) {
            
            var value = arr[i];
            if(value.show_in_menus)
            list.append(makeone(value));
         }
      
         $('#post_submit').mouseenter(function(){
			$('#editor').text('안녕');
			$('#editor').blur();
         });
         
      function makeone(str) {
         var num=str.tab_id*10+str.orderNum;
         return '<li><span class="deco_dot">●</span><a href="'+str.path+'?num='+num+'">'
               + str.page_title + '</a></li>';
      }
      
      var pane = $('#title');
        var panel =$('#titlename');
        var user = <%= user%>;
      var headtitle = <%=headermenulist%>;
      for(var i = 0 ; i < headtitle.length ; ++i)
         if((headtitle[i].tab_id < num) && (headtitle[i].tab_id > (num-1)))
            {
//            pane.prepend('<img src="'+headtitle[i].tab_img+'" alt="">');
            panel.append(headtitle[i].tab_title);
            break;
            }
      
      CKEDITOR.replace('editor', {
             allowedContent: true,
             height: 300,
             'filebrowserUploadUrl': 'Uploader'
         });
      
        $("#kv-explorer").fileinput({
            'theme': 'explorer-fa',
            'uploadUrl': 'notice_board_upload.do',
            showRemove : false,
            showUpload : false,
            overwriteInitial : false,
            uploadExtraData:{
               writer : user.id,
               num : num
               }
       });
        
   function insertboard(){
      var writer_id = user.id;
      var writer_name  = user.name;
      var title=$('[name=title]').val();
      if(title.length>=125){
              alert("제목이 너무 깁니다!");
              return;
           }
      if(title.length == 0){
         alert('제목이 없습니다!');
         return;
      }
       var content = CKEDITOR.instances.editor.getData();
       var num=<%=num%>;
      var insert=num+"-/-/-"+writer_id+"-/-/-"+title+"-/-/-"+content+"-/-/-"+writer_name;

          $.ajax({
              url : 'ajax.do',
              type : 'post',
              data : {
                 req:"noticeinsertboard",
                 data:insert
              },
              async : false,
              success : function(data){       
                 if(data == 'success'){ 
                       alert("등록이 완료되었습니다");
                        is_submit = true;
                        window.location.href = 'notice_article_list.do?num=<%=num %>';
                    }
          }
          });
      }
           
   function exit(){
          $.ajax({
                url : 'notice_board_file_delete.do',
                type : 'post',
                data : {data : <%=user%>.id},
                success : function(data) {
                   if(data != 'fail'){
                    alert('올렸던 글과 파일들은 저장되지 않습니다!');
                   }
                   else{
                      alert('SERVER ERROR, Please try again later...');
                      return;
                      }
                }
           })     
       }
   
   
   var is_submit = false;
   $(window).on("beforeunload", function () {
         if (!is_submit){ 
            exit()
            }
     });
   
   
   
   </script>
</body>
</html>