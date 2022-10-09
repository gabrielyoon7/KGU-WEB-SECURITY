<%--
  Created by IntelliJ IDEA.
  User: YOON
  Date: 2022-01-20
  Time: 오후 3:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String text = (String) request.getAttribute("text");
%>
<style>
    #container {
        display: flex;
        flex-direction: column;
    }

    #maincontent {
        display: flex;
        padding: 0;
    }

    #maincontent > ul {
        padding: 10px;
        min-width: 150px;
    }
    #map{
        height:600px;
    }
</style>
<script>
    var panel = $('#maincontent');
    var text = <%=text%>;
    panel.append(text.content);
</script>