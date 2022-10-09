<%--
  Created by IntelliJ IDEA.
  User: ssky6
  Date: 2022-02-03
  Time: 오전 12:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //String tabmenulist=(String) request.getAttribute("tabmenulist");//관리자탭메뉴
    String logs = (String) request.getAttribute("logs"); // 로그 텍스트
%>
<%
    String headermenulist = (String) session.getAttribute("headermenulist");
    String menulist = (String) session.getAttribute("menulist");
    String user = (String) session.getAttribute("user");
    String type = (String) session.getAttribute("type");
%>
<%
    String num = (String) request.getAttribute("num");
    String pageMenuList = (String) request.getAttribute("pageMenuList");//좌측 소메뉴 리스트

    /**
     * for page.jsp
     * */
    String jsp = (String) request.getAttribute("jsp");
%>
<html>
<head>
    <title>로그확인 : 경기대학교 AI컴퓨터공학부</title>
    <style>
        #maincontent {
            padding: 0;
        }

        #maincontent>ul {
            padding: 10px;
        }
    </style>
</head>
<body>
<div id="maincontent">
    <ul>
        <li>
            <div class="contenttitle">로그 확인</div>
        </li>
    </ul>
    <div id="for_log">
        <label style="font-size : 14px"> ※로그에는 회원가입, 관리자 추가, 로그인 기록이 남습니다. 로그가 길어질 시 서버에 영향을 줄 수 있습니다.</label>
        <div class="form-group" style="width : auto; overflow : auto">
            <textarea class="form-control" id="logs" rows=30 placeholder="로그가 비어있습니다." readonly></textarea>
        </div>
    </div>
    <button class="btn btn-default" style="float : right; margin-bottom : 10px;" onclick="deleteLog()">로그삭제</button>
</div>

<script>
    var arr = <%=pageMenuList%>;
    for (var i = 0; i < arr.length; i++) {
        var value = arr[i];
        if(value.show_in_menus)
            $('#tab_2').append(makeone(value));
    }

    function makeone(str) {
        var num=str.tab_id*10+str.orderNum;
        var text = '<li><span class="deco_dot">●</span><a href="'+str.path+'?num='+num+'">'+ str.page_title + '</li>'
        return text;
    }

    var logs = <%=logs%>;
    var logText = '';
    for(var i = 0 ; i < logs.length ; ++i)
        logText += logs[i] + '\n';
    $('#logs').val(logText);

    function deleteLog(){
        $.ajax({
            url : 'ajax.kgu',
            type : 'post',
            data : {
                req : 'deleteLog',
                data : ''
            },
            success : function(data){
                if(data == "success"){
                    window.location.href = 'admin.kgu?num=85';
                }   else{
                    alert('SERVER ERROR, Please try again later...');
                }
            }
        });
    }
</script>
</body>
</html>
