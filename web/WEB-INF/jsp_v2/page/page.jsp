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
    String subdomainJSON = (String) session.getAttribute("subdomain"); // ai 또는 cs로 도착함
    String subdomain = subdomainJSON.substring(1, subdomainJSON.length()-1 ); //JSON 형태를 Java 형식으로 만들어주기 위한 작업
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
     * for page.jsp
     * */
    String jsp = (String) request.getAttribute("jsp");
    System.out.println("ㄹㄹ");
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
            <div id="tab">
                <ul id="page_menu"></ul>
            </div>
            <div id="maincontent">
                <c:choose>

                    <%--    menu    --%>
                    <c:when test="${jsp == '\"information\"'}">
<%--                        <%@include file="/WEB-INF/jsp_v2/page/menu/information.jsp" %>--%>
                        <jsp:include page="/WEB-INF/jsp_v2/page/menu/information.jsp" flush="false"></jsp:include>
                    </c:when>
                    <c:when test="${jsp == '\"curriculum\"'}">
<%--                        <%@include file="/WEB-INF/jsp_v2/page/menu/curriculum.jsp" %>--%>
                        <jsp:include page="/WEB-INF/jsp_v2/page/menu/curriculum.jsp" flush="false"></jsp:include>
                    </c:when>
                    <c:when test="${jsp == '\"community_club\"'}">
<%--                        <%@include file="/WEB-INF/jsp_v2/page/menu/community_club.jsp" %>--%>
                        <jsp:include page="/WEB-INF/jsp_v2/page/menu/community_club.jsp" flush="false"></jsp:include>
                    </c:when>
                    <c:when test="${jsp == '\"professor\"'}">
<%--                        <%@include file="/WEB-INF/jsp_v2/page/menu/professor.jsp" %>--%>
                        <jsp:include page="/WEB-INF/jsp_v2/page/menu/professor.jsp" flush="false"></jsp:include>
                    </c:when>
                    <c:when test="${jsp == '\"laboratory\"'}">
<%--                        <%@include file="/WEB-INF/jsp_v2/page/menu/laboratory.jsp" %>--%>
                        <jsp:include page="/WEB-INF/jsp_v2/page/menu/laboratory.jsp" flush="false"></jsp:include>
                    </c:when>

                    <%--    notice  --%>
                    <c:when test="${jsp == '\"notice_list\"'}">
<%--                        <%@include file="/WEB-INF/jsp_v2/page/notice_article/mode/notice_list.jsp" %>--%>
                        <jsp:include page="/WEB-INF/jsp_v2/page/notice_article/mode/notice_list.jsp" flush="false"></jsp:include>
                    </c:when>
                    <c:when test="${jsp == '\"notice_view\"'}">
<%--                        <%@include file="/WEB-INF/jsp_v2/page/notice_article/mode/notice_view.jsp" %>--%>
                        <jsp:include page="/WEB-INF/jsp_v2/page/notice_article/mode/notice_view.jsp" flush="false"></jsp:include>
                    </c:when>
                    <c:when test="${jsp == '\"notice_modify\"'}">
<%--                        <%@include file="/WEB-INF/jsp_v2/page/notice_article/mode/notice_modifier.jsp" %>--%>
                        <jsp:include page="/WEB-INF/jsp_v2/page/notice_article/mode/notice_modifier.jsp" flush="false"></jsp:include>
                    </c:when>
                    <c:when test="${jsp == '\"notice_write\"'}">
<%--                        <%@include file="/WEB-INF/jsp_v2/page/notice_article/mode/notice_writer.jsp" %>--%>
                        <jsp:include page="/WEB-INF/jsp_v2/page/notice_article/mode/notice_writer.jsp" flush="false"></jsp:include>
                    </c:when>

                    <%--   webzine  --%>
                    <c:when test="${jsp == '\"webzine_list\"'}">
<%--                        <%@include file="/WEB-INF/jsp_v2/webzine/webzine_list.jsp" %>--%>
                        <jsp:include page="/WEB-INF/jsp_v2/webzine/webzine_list.jsp" flush="false"></jsp:include>
                    </c:when>
                    <c:when test="${jsp == '\"webzine_modifier\"'}">
<%--                        <%@include file="/WEB-INF/jsp_v2/webzine/webzine_modifier.jsp" %>--%>
                        <jsp:include page="/WEB-INF/jsp_v2/webzine/webzine_modifier.jsp" flush="false"></jsp:include>
                    </c:when>
                    <c:when test="${jsp == '\"webzine_reader\"'}">
<%--                        <%@include file="/WEB-INF/jsp_v2/webzine/webzine_reader.jsp" %>--%>
                        <jsp:include page="/WEB-INF/jsp_v2/webzine/webzine_reader.jsp" flush="false"></jsp:include>
                    </c:when>
                    <c:when test="${jsp == '\"webzine_writer\"'}">
<%--                        <%@include file="/WEB-INF/jsp_v2/webzine/webzine_writer.jsp" %>--%>
                        <jsp:include page="/WEB-INF/jsp_v2/webzine/webzine_writer.jsp" flush="false"></jsp:include>
                    </c:when>

                    <%--    admin  --%>
                    <c:when test="${jsp == '\"admin_main\"'}">
                        <jsp:include page="/WEB-INF/jsp_v2/page/admin/admin_main.jsp" flush="false"></jsp:include>
                    </c:when>
                    <c:when test="${jsp == '\"admin_excel\"'}">
                        <jsp:include page="/WEB-INF/jsp_v2/page/admin/admin_excel.jsp" flush="false"></jsp:include>
                    </c:when>
                    <c:when test="${jsp == '\"admin_menu\"'}">
                        <jsp:include page="/WEB-INF/jsp_v2/page/admin/admin_menu.jsp" flush="false"></jsp:include>
                    </c:when>
                    <c:when test="${jsp == '\"admin_user\"'}">
                        <jsp:include page="/WEB-INF/jsp_v2/page/admin/admin_user.jsp" flush="false"></jsp:include>
                    </c:when>
                    <c:when test="${jsp == '\"admin_log\"'}">
                        <jsp:include page="/WEB-INF/jsp_v2/page/admin/admin_log.jsp" flush="false"></jsp:include>
                    </c:when>
                    <c:when test="${jsp == '\"admin_user_ai\"'}">
                        <jsp:include page="/WEB-INF/jsp_v2/page/admin/admin_user_ai.jsp" flush="false"></jsp:include>
                    </c:when>

                    <%--    req_article --%>
                    <c:when test="${jsp == '\"req_article_list\"'}">
<%--                        <%@include file="/WEB-INF/jsp_v2/page/request_article/req_article_list.jsp" %>--%>
                        <jsp:include page="/WEB-INF/jsp_v2/page/request_article/req_article_list.jsp" flush="false"></jsp:include>
                    </c:when>
                    <c:when test="${jsp == '\"req_article_reader\"'}">
                        <%--                        <%@include file="/WEB-INF/jsp_v2/page/request_article/req_article_list.jsp" %>--%>
                        <jsp:include page="/WEB-INF/jsp_v2/page/request_article/req_article_reader.jsp" flush="false"></jsp:include>
                    </c:when>
                    <c:when test="${jsp == '\"req_article_writer\"'}">
                        <%--                        <%@include file="/WEB-INF/jsp_v2/page/request_article/req_article_list.jsp" %>--%>
                        <jsp:include page="/WEB-INF/jsp_v2/page/request_article/req_article_writer.jsp" flush="false"></jsp:include>
                    </c:when>
                    <c:when test="${jsp == '\"req_article_modifier\"'}">
                        <%--                        <%@include file="/WEB-INF/jsp_v2/page/request_article/req_article_list.jsp" %>--%>
                        <jsp:include page="/WEB-INF/jsp_v2/page/request_article/req_article_modifier.jsp" flush="false"></jsp:include>
                    </c:when>

                    <%--    gallery --%>
                    <c:when test="${jsp == '\"gallery_board_list\"'}">
                        <jsp:include page="/WEB-INF/jsp_v2/page/gallery/gallery_list.jsp" flush="false"></jsp:include>
                    </c:when>
                    <c:when test="${jsp == '\"gallery_board_reader\"'}">
                        <jsp:include page="/WEB-INF/jsp_v2/page/gallery/gallery_reader.jsp" flush="false"></jsp:include>
                    </c:when>
                    <c:when test="${jsp == '\"gallery_board_writer\"'}">
                        <jsp:include page="/WEB-INF/jsp_v2/page/gallery/gallery_writer.jsp" flush="false"></jsp:include>
                    </c:when>
                    <c:when test="${jsp == '\"gallery_board_modifier\"'}">
                        <jsp:include page="/WEB-INF/jsp_v2/page/gallery/gallery_modifier.jsp" flush="false"></jsp:include>
                    </c:when>

                    <%--    gcs --%>
                    <c:when test="${jsp == '\"student_main\"'}">
<%--                        <%@include file="/WEB-INF/jsp_v2/page/graduation_checking_system/student_main.jsp" %>--%>
                        <jsp:include page="/WEB-INF/jsp_v2/page/graduation_checking_system/student_main.jsp" flush="false"></jsp:include>
                    </c:when>
                    <c:when test="${jsp == '\"student_lecture_insert\"'}">
<%--                        <%@include file="/WEB-INF/jsp_v2/page/graduation_checking_system/student_lecture_insert.jsp" %>--%>
                        <jsp:include page="/WEB-INF/jsp_v2/page/graduation_checking_system/student_lecture_insert.jsp" flush="false"></jsp:include>
                    </c:when>
                    <c:when test="${jsp == '\"admin_requirement_main\"'}">
<%--                        <%@include file="/WEB-INF/jsp_v2/page/graduation_checking_system/admin_requirement_main.jsp" %>--%>
                        <jsp:include page="/WEB-INF/jsp_v2/page/graduation_checking_system/admin_requirement_main.jsp" flush="false"></jsp:include>
                    </c:when>
                    <c:when test="${jsp == '\"admin_requirement_manager\"'}">
<%--                        <%@include file="/WEB-INF/jsp_v2/page/graduation_checking_system/admin_requirement_manager.jsp" %>--%>
                        <jsp:include page="/WEB-INF/jsp_v2/page/graduation_checking_system/admin_requirement_manager.jsp" flush="false"></jsp:include>
                    </c:when>
                    <c:when test="${jsp == '\"admin_lecture_manager\"'}">
<%--                        <%@include file="/WEB-INF/jsp_v2/page/graduation_checking_system/admin_lecture_manager.jsp" %>--%>
                        <jsp:include page="/WEB-INF/jsp_v2/page/graduation_checking_system/admin_lecture_manager.jsp" flush="false"></jsp:include>
                    </c:when>
                    <c:when test="${jsp == '\"admin_student_list\"'}">
<%--                        <%@include file="/WEB-INF/jsp_v2/page/graduation_checking_system/admin_student_list.jsp" %>--%>
                        <jsp:include page="/WEB-INF/jsp_v2/page/graduation_checking_system/admin_student_list.jsp" flush="false"></jsp:include>
                    </c:when>

                    <%--    locker  --%>
                    <c:when test="${jsp == '\"locker_schedule\"'}">
                        <%--                        <%@include file="/WEB-INF/jsp_v2/page/graduation_checking_system/student_main.jsp" %>--%>
                        <jsp:include page="/WEB-INF/jsp_v2/page/locker/locker_schedule.jsp" flush="false"></jsp:include>
                    </c:when>
                    <c:when test="${jsp == '\"locker_main\"'}">
                        <%--                        <%@include file="/WEB-INF/jsp_v2/page/graduation_checking_system/student_lecture_insert.jsp" %>--%>
                        <jsp:include page="/WEB-INF/jsp_v2/page/locker/locker_main.jsp" flush="false"></jsp:include>
                    </c:when>
             <%--       <c:when test="${jsp == '\"admin_requirement_main\"'}">
                        &lt;%&ndash;                        <%@include file="/WEB-INF/jsp_v2/page/graduation_checking_system/admin_requirement_main.jsp" %>&ndash;%&gt;
                        <jsp:include page="/WEB-INF/jsp_v2/page/graduation_checking_system/admin_requirement_main.jsp" flush="false"></jsp:include>
                    </c:when>
                    <c:when test="${jsp == '\"admin_requirement_manager\"'}">
                        &lt;%&ndash;                        <%@include file="/WEB-INF/jsp_v2/page/graduation_checking_system/admin_requirement_manager.jsp" %>&ndash;%&gt;
                        <jsp:include page="/WEB-INF/jsp_v2/page/graduation_checking_system/admin_requirement_manager.jsp" flush="false"></jsp:include>
                    </c:when>
                    <c:when test="${jsp == '\"admin_lecture_manager\"'}">
                        &lt;%&ndash;                        <%@include file="/WEB-INF/jsp_v2/page/graduation_checking_system/admin_lecture_manager.jsp" %>&ndash;%&gt;
                        <jsp:include page="/WEB-INF/jsp_v2/page/graduation_checking_system/admin_lecture_manager.jsp" flush="false"></jsp:include>
                    </c:when>
                    <c:when test="${jsp == '\"admin_student_list\"'}">
                        &lt;%&ndash;                        <%@include file="/WEB-INF/jsp_v2/page/graduation_checking_system/admin_student_list.jsp" %>&ndash;%&gt;
                        <jsp:include page="/WEB-INF/jsp_v2/page/graduation_checking_system/admin_student_list.jsp" flush="false"></jsp:include>
                    </c:when>--%>


                   <%-- &lt;%&ndash;   webzine  &ndash;%&gt;
                    <c:when test="${jsp == '\"webzine_list\"'}">
                        <%@include file="/WEB-INF/jsp_v2/webzine/webzine_list.jsp" %>
                    </c:when>
                    <c:when test="${jsp == '\"webzine_modifier\"'}">
                        <%@include file="/WEB-INF/jsp_v2/webzine/webzine_modifier.jsp" %>
                    </c:when>
                    <c:when test="${jsp == '\"webzine_reader\"'}">
                        <%@include file="/WEB-INF/jsp_v2/webzine/webzine_reader.jsp" %>
                    </c:when>
                    <c:when test="${jsp == '\"webzine_writer\"'}">
                        <%@include file="/WEB-INF/jsp_v2/webzine/webzine_writer.jsp" %>
                    </c:when>--%>

                    <c:otherwise>
                        <div>잘못된 jsp 변수가 넘어왔습니다. page.jsp 에서 jsp 변수가 제대로 받아지는지 확인 바랍니다.</div>
                        <%
                            System.out.println(jsp);
                        %>
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
        makePageTitle('page_title');
        makePageMenu();
    })
    var pageMenu = <%=pageMenuList%>;
    function makePageTitle(id){
        var title = $('#'+id);
        var url_number =<%=num%>;
        for (var i = 0; i < pageMenu.length; ++i) {
            var value = pageMenu[i];
            var num = value.tab_id * 10 + value.orderNum;
            if(url_number==num){
                title.append(value.page_title);
                break;
            }
        }
    }
    function makePageMenu() {
        var list = $('#page_menu');
        for (var i = 0; i < pageMenu.length; ++i) {
            var value = pageMenu[i];
            var num = value.tab_id * 10 + value.orderNum;
            var text = '<li><span class="deco_dot">●</span><a href="' + value.path + '?num=' + num + '">' + value.page_title + '</a></li>'
            list.append(text);
        }
    }
</script>

