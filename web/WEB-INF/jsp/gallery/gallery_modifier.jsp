<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
   StringBuffer url2_gal_modifier = request.getRequestURL();
   String logo_img_gal_modifier;

   //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
   //ai이면 ai로고 cs이면 cs로고
   if(url2_gal_modifier.substring(7,9).equals("ai") || url2_gal_modifier.substring(7,9).equals("lo")){
      logo_img_gal_modifier = "img/community_ai.png";
   }
   else{
      logo_img_gal_modifier = "img/community.png";
   }
   //System.out.println((logo_img_gal_modifier));
%>
<% 
String num = (String)request.getAttribute("num");
String tabmenulist=(String) request.getAttribute("tabmenulist");
String images = (String) request.getAttribute("images");
String board = (String) request.getAttribute("boards");
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="utf-8">
<title>갤러리 수정:경기대학교 AI컴퓨터공학부</title>
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
   <script src="js/fileinput.min.js" type="text/javascript"></script>
   <script src="js/theme.js" type="text/javascript"></script>
   <%@include file="../main/header.jsp"%>
   <div id="content">
      <div id="title">
         <img src=<%=logo_img_gal_modifier%> />
         <div id="titlename"></div>
      </div>
      <div id="container">
         <div id="tab">
            <ul id="tab_2">

            </ul>
         </div>
         <div id="maincontent">
            <form name="writeboards" onsubmit="return false;">
               <ul>
                  <li>
                     <div id="articlename" class="contenttitle">
                     </div>
                  </li>
               </ul>
               <div class="form-group">
                     <input type="text" class="form-control" name="title" id="post_title" placeholder="제목 :">
                  </div>
                  <textarea name="content" id="editor" cols="10" rows="10" required></textarea>
            </form>
            <div class="post_button" id="post_submit_btn">
               <a onclick="exit()" class="btn btn-default">취소</a>
               <a onclick="modifyboard()" class="btn btn-default">쓰기</a>
            </div>
            <p style="display:inline-block; margin-top : 40px">사진 첨부</p>
            <input id="image" type="file" accept=".jpg, .jpeg, .png" style="display:inline-block; margin-left : 20px; margin-bottom : 10px; margin-top : 10px">
            <div class="input-group">
               <input type="text" class="form-control" placeholder="간단한 설명을 입력해주세요" id="image_text">
               <span class="input-group-btn"><button class="btn btn-default" type="button" onclick="submitImage();">업로드</button></span>
            </div>
            <div id="what_i_submit" style="border : 1px dotted black; margin-top : 10px">
            <p style="font-weight : 700; font-size : 20px; text-align : center;">사진 목록</p>
            </div>   
         </div>
      </div>
   </div>
   <div class="form-group">
   </div>
   
               <script>
//여기는 쿼리문 변경
         var list = $('#tab_2');
         var articlename=$('#articlename');
         var arr = <%=tabmenulist%>
         var num=<%=num%>;
         var board = <%=board%>;
         $('#post_title').val(board.title);
         $('#editor').val(board.content);
             numo=num%10;
            numt=num/10;
         for (var i = 0; i < arr.length; i++) {
            
            var value = arr[i];
            if(value.show_in_menus)
            list.append(makeone(value));
            if(value.orderNum==numo)
               articlename.append(value.page_title);
         }
      
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
         if(headtitle[i].tab_id < numt && headtitle[i].tab_id > (numt-1))
            {
//            pane.prepend('<img src="'+headtitle[i].tab_img+'" alt="ERROR">');
            panel.append(headtitle[i].tab_title);
            break;
            }
      
      CKEDITOR.replace('editor', {
             allowedContent: true,
             height: 300,
         });
   
   function modifyboard(){
      var title=$('[name=title]').val();
      if(title.length>=125){
              alert("제목이 너무 깁니다!");
              return;
           }
       var content = CKEDITOR.instances.editor.getData();
      var insert=title+"-/-/-"+content + '-/-/-' + <%=board%>.id;
          $.ajax({
              url : 'ajax.do',
              type : 'post',
              data : {
                 req:'gallery_modify_board',
                 data:insert
              },
              success : function(data){
                 if(data == 'success'){
                    alert('수정 성공');
                    is_submit = true;
                    window.location.href= 'gallery_board_reader.do?num=' + <%=num %> + '&id=' + <%=board%>.id;
                 }
                 else
                    alert('SERVER ERROR, Please try again later...');
              }
          });
      }
   
     function submitImage(){
         var formData = new FormData();
         if($('input[type=file]')[0].files[0]==undefined){
        	 alert('사진을 선택해주세요!');
        	 return;
         }
         var writer = <%=user%>;
         var num = <%=num%>
         formData.append('uploadFile',$('input[type=file]')[0].files[0]);
         formData.append('writer_id',writer.id);
         formData.append('text', $('#image_text').val());
         formData.append('num',num);
         $.ajax({
              url : 'gallery_upload_image.do',
              type : 'post',
              data : formData,
              processData : false,
              contentType : false,
              async : false,
              success : function(data) {
                 if(data != 'fail'){
                     addImage(data);
                     $('#image_text').val('');
                 }
                 else
                    alert('SERVER ERROR, Please try again later...');
              }
         })
      }
     
     var src = <%=images%>;
     var AlreadyNames = [];
     var imageCount = 0;
	 for(var i = 0 ; i < src.length ; ++i){
		 $('#what_i_submit').append('<div id="imageDone' + i + '" style = "border-bottom : 1px black solid; padding-bottom:5px; padding-top:5px"><img id="imageValue'+ i + '" src="img/gallery/' + src[i].src + '"><a onclick="deleteImageModify(' + i + ')"><img style="display:inline-block; margin-left : 10px; width : 12px; vertical-align : top;" src="img/denied.png"></a><div style="margin : 10px 0;">: ' + src[i].text + '</div></div>');
	 	AlreadyNames.push(src[i].src);
	 }
     
     var itsNew = []
	 
     function addImage(data){
        var Panel = $('#what_i_submit');
        var arr = data.split('-/-/-');
        Panel.append('<div id="image' + imageCount + '" style = "border-bottom : 1px black solid; padding-bottom:5px; padding-top:5px"><img id="imageValue'+ imageCount + '" src="img/gallery/' + arr[0] + '"><a onclick="deleteImage(' + imageCount + ')"><img style="display:inline-block; margin-left : 10px; width : 17px; vertical-align : top;" src="img/denied.png"></a><div style="margin : 10px 0;">: ' + arr[1] + '</div></div>');
        imageCount++;
         itsNew.push(arr[0]);
     }

     function deleteImageModify(imageCount){
        var imageName = AlreadyNames[imageCount];
        $.ajax({
              url : 'ajax.do',
              type : 'post',
              data : {
            	  req : 'gallery_image_delete_modify',
            	  data : imageName + '-/-/-' + <%=board%>.id},
              success : function(data) {
                 if(data != 'fail'){
                  $('#imageDone'+imageCount).remove();
                  AlreadyNames.splice(AlreadyNames.indexOf(imageName),1);
                 }
                 else
                    alert('SERVER ERROR, Please try again later...');
              }
         })     
     }      
     
     function deleteImage(imageCount){
         var imageName = itsNew[imageCount];
         $.ajax({
               url : 'gallery_image_delete.do',
               type : 'post',
               data : {
             	  data : imageName
             	  },
               success : function(data) {
                  if(data != 'fail'){
                   $('#image'+imageCount).remove();
                   itsNew.splice(itsNew.indexOf(imageName),1);
                  }
                  else
                     alert('SERVER ERROR, Please try again later...');
               }
          })     
      }      
     
     function exit(){
        for(var i = 0 ; i < itsNew.length ; i++){
           var imageName = itsNew[i]; 
           $.ajax({
                 url : 'gallery_image_delete.do',
                 type : 'post',
                 data : {imageName : imageName},
                 success : function(data) {
                    if(data == 'fail'){
                        alert('SERVER ERROR, Please try again later...');
                        return;
                    }
                 }
            })     
        }
            $.ajax({
                url : 'ajax.do',
                type : 'post',
                data : {
                	req : 'gallery_image_modify_exit',
                	data : <%=board%>.id
                	},
                success : function(data) {
                   if(data == 'fail'){
                       alert('SERVER ERROR, Please try again later...');
                       return;
                   }
                }
           })     
           window.location.href = 'gallery_board_list.do?num=' +<%=num%>;
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