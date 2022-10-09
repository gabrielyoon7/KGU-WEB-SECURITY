<%--
  Created by IntelliJ IDEA.
  User: gabri
  Date: 2021-08-28
  Time: 오후 12:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    /**
     * 현재 URL을 검사하는 과정 시작.
     * 서브도메인 == http://subdomain.kyonggi.ac.kr에서의 subdomain
     * 그 중 맨 앞자리 두 글자를 가지고 현재 접속한 페이지를 판별하고 있음
     * */
    String subdomain = request.getRequestURL().toString().split("://")[1].substring(0,2);
    if(subdomain.equals("lo")){ //로컬에서 아무것도 안뜰까봐 추가
        subdomain="ai";
    }
    /**
     * 현재 URL을 검사하는 과정 끝
     * */

    /**
     * 테마 설정
     * */
    String logo_img_page;
    if (subdomain.equals("ai")) {
        logo_img_page = "img/notice_ai.png";
    }
    else if (subdomain.equals("cs")) {
        logo_img_page = "img/notice.png";
    }
    else {
        logo_img_page = "도메인 오류";
    }
%>
<%
    String num = (String) request.getAttribute("num");
    String pageMenuList = (String) request.getAttribute("pageMenuList");//좌측 소메뉴 리스트

    /**
     * for page_stand_alone.jsp
     * */
    String jsp = (String) request.getAttribute("jsp");
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<%@include file="../main/common_settings.jsp" %>
<body>
<%@include file="../main/header.jsp" %>
<main>
    <div id="content">
        <div id="title">
            <img src=<%=logo_img_page%> />
            <div id="page_title"></div>
        </div>
        <div id="container">
            <div id="maincontent">
                <c:choose>

                    <%--    etc    --%>
                    <c:when test="${jsp == '\"location\"'}">
                        <%@include file="/WEB-INF/jsp_v2/page_stand_alone/etc/location.jsp" %>
                    </c:when>
                    <c:when test="${jsp == '\"sitemap\"'}">
                        <%@include file="/WEB-INF/jsp_v2/page_stand_alone/etc/sitemap.jsp" %>
                    </c:when>
                    <c:when test="${jsp == '\"madeby\"'}">
                        <%@include file="/WEB-INF/jsp_v2/page_stand_alone/etc/madeby.jsp" %>
                    </c:when>

                    <c:otherwise>
                        <div>잘못된 jsp 변수가 넘어왔습니다. page_stand_alone.jsp 에서 jsp 변수가 제대로 받아지는지 확인 바랍니다.</div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</main>
<%@include file="../main/footer.jsp" %>
<div id="shadow">
    <div id="blur"></div>
</div>
</body>
</html>

<script>
    $(document).ready(function () { //본문 제어
        makePageTitle();
    })
    function makePageTitle(){
        const jsp = <%=jsp%>;
        const title = $('#page_title');
        let text="";
        switch (jsp) {
            case 'location':
                text='연락처 및 오시는 길';
                break;
            case 'sitemap':
                text='사이트맵';
                break;
            case 'madeby':
                text='컴퓨터공학부 웹 공부 및 개발팀';
                break;
            default:
                text='[jsp 변수 오류] makePageTitle()에서 설정하세요.';
        }
        title.append(text);
    }
</script>

