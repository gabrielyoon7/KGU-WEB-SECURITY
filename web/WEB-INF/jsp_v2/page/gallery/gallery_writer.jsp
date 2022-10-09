<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
   StringBuffer url2_gal_writer = request.getRequestURL();
   String logo_img_gal_writer;

   //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
   //ai이면 ai로고 cs이면 cs로고
   if(url2_gal_writer.substring(7,9).equals("ai") || url2_gal_writer.substring(7,9).equals("lo")){
      logo_img_gal_writer = "img/community_ai.png";
   }
   else{
      logo_img_gal_writer = "img/community.png";
   }
   //System.out.println((logo_img_gal_writer));
%>
<% 
String num = (String)request.getAttribute("num");
String tabmenulist=(String) request.getAttribute("tabmenulist");
%>
<%
   String headermenulist = (String) session.getAttribute("headermenulist");
   String menulist = (String) session.getAttribute("menulist");
   String user = (String) session.getAttribute("user");
   String type = (String) session.getAttribute("type");
%>
<%
   String pageMenuList = (String) request.getAttribute("pageMenuList");//좌측 소메뉴 리스트

   /**
    * for page.jsp
    * */
   String jsp = (String) request.getAttribute("jsp");
%>
<title>갤러리 쓰기:경기대학교 AI컴퓨터공학부</title>
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

.post_button a {
	margin : 0;
}
</style>
         <div id="maincontent">
            <form name="writeboards" onsubmit="return false;">
               <ul>
                  <li>
                     <div id="articlename" class="contenttitle">
                     </div>
                  </li>
               </ul>
               <div class="form-group">
                     <input type="text" class="form-control" name="title" id="post_title" placeholder="제목:">
                  </div>
                  <textarea name="content" id="editor"></textarea>
            </form>
            <div style="height : 40px; margin-top : 5px">
            	<div class="post_button" id="post_submit_btn">
               		<a onclick="exit()" class="btn btn-default">취소</a>
               		<a onclick="insertboard()" class="btn btn-default">쓰기</a>
          	  	</div>
            </div>
            <div style="display : flex">
            <div style="margin-top : 5px; display : inline-block; height : 40px;">
            	<div style="display : inline-block">사진 첨부</div>
            	<input id="image" type="file" accept=".jpg, .jpeg, .png" style="display:inline-block; margin-left : 20px; width : 200px">
            </div>
            <div style="margin-top : 5px; display : inline-block; height : 40px;">
            	<div class="input-group" style="display:inline-block; width : 455px;" >
               		<input type="text" class="form-control" placeholder="간단한 설명을 입력해주세요(생략 가능)" id="image_text" style="width : 413px">
               		<span class="input-group-btn"><button class="btn btn-default" type="button" onclick="submitImage();" style="padding : 1px 5px;"><img src="img/uploadBtn.png" style="width:30px"></button></span>
            	</div>
            </div>
            </div>
            <div id="what_i_submit" style="border : 1px dotted black; margin-top : 10px">
            <p style="font-weight : 700; font-size : 20px; text-align : center;">사진 목록</p>
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
      
   
   function insertboard(){
      var title=$('[name=title]').val();
      if(title.length>=125){
              alert("제목이 너무 깁니다!");
              return;
           }
       var content = CKEDITOR.instances.editor.getData();
       var num=<%=num%>;
      var insert=num+"-/-/-"+title+"-/-/-"+content;
          $.ajax({
              url : 'ajax.do',
              type : 'post',
              data : {
                 req:'galleryInsertBoard',
                 data:insert
              },
              success : function(data){
                 if(data == 'success'){
                    alert('등록 성공');
                    is_submit = true;
                    window.location.href= 'gallery_board_list.kgu?num='+<%=num %>;
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
         var num = <%=num%>
         formData.append('uploadFile',$('input[type=file]')[0].files[0]);
         formData.append('text', $('#image_text').val());
         formData.append('num',num);
         $.ajax({
              url : 'gallery_upload_image.kgu',
              type : 'post',
              data : formData,
              processData : false,
              contentType : false,
              async : false,
              success : function(data) {
                 if(data != 'fail'){
                     addImage(data);
                     $('input[type=file]').val('');
                     $('#image_text').val('');
                 }
                 else
                    alert('SERVER ERROR, Please try again later...');
              }
         })
      }
     
     var imageCount = 0;
     var src = [];

     function addImage(data){
        var Panel = $('#what_i_submit');
        var arr = data.split('-/-/-');
        Panel.append('<div id="image' + imageCount + '" style = "border-bottom : 1px black solid; padding-bottom:5px; padding-top:5px"><img id="imageValue'+ imageCount + '" src="img/gallery/' + arr[0] + '"><a onclick="deleteImage(' + imageCount + ')"><img style="display:inline-block; margin-left : 10px; width : 12px; vertical-align : top;" src="img/denied.png"></a><div style="margin : 10px 0;">: ' + arr[1] + '</div></div>');
         imageCount++;
         src.push(arr[0]);
     }
      
     function deleteImage(imageCount){
        var imageName = src[imageCount];
        $.ajax({
              url : 'gallery_image_delete.kgu',
              type : 'post',
              data : {imageName : imageName},
              success : function(data) {
                 if(data != 'fail'){
                  $('#image'+imageCount).remove();
                  src.splice(src.indexOf(imageName), 1);
                 }
                 else
                    alert('SERVER ERROR, Please try again later...');
              }
         })     
     }      
     
     function exit(){
        for(var i = 0 ; i < src.length ; i++){
           var imageName = src[i]; 
           $.ajax({
                 url : 'gallery_image_delete.kgu',
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
        window.location.href = 'gallery_board_list.kgu?num=' + <%=num%>;
     }
      var is_submit = false;
     $(window).on("beforeunload", function () {
           if (!is_submit){ 
              exit()
              }
       });
   </script>
