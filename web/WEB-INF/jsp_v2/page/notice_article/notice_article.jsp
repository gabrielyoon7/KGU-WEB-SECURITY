<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 2022-01-25
  Time: 오전 11:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    /**
     * BBS 공통 설정
     * */
//    System.out.println("jsp:"+jsp);
    String id = (String) request.getAttribute("id");
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
<c:choose>
    <c:when test="${jsp == '\"notice_list\"'}">
        <%@include file="/WEB-INF/jsp_v2/page/notice_article/mode/notice_list.jsp" %>
    </c:when>
    <c:when test="${jsp == '\"notice_view\"'}">
        <%@include file="/WEB-INF/jsp_v2/page/notice_article/mode/notice_view.jsp" %>
    </c:when>
    <c:when test="${jsp == '\"notice_modify\"'}">
        <%@include file="/WEB-INF/jsp_v2/page/notice_article/mode/notice_modifier.jsp" %>
    </c:when>
    <c:when test="${jsp == '\"notice_write\"'}">
        <%@include file="/WEB-INF/jsp_v2/page/notice_article/mode/notice_writer.jsp" %>
    </c:when>
</c:choose>
