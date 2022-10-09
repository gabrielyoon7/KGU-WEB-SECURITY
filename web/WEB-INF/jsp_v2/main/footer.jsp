<%--
  Created by IntelliJ IDEA.
  User: 윤주현
  Date: 2021-08-28
  Time: 오후 1:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    /**
     * Footer V2
     * */

%>
<footer>
    <div class="" id="footercontainer">
        <div>
            <p class="footer_menu">
                <span><a href="location.kgu" style="padding-right : 5px; border-right : 1px white solid;">연락처 및 오시는 길</a><a href="sitemap.kgu" style="margin-left : 5px;">사이트맵</a><a onclick="esterEgg()" style="color : #455a64">.</a>
                    </span>
                <span style="float:right;"><a href="http://www.kyonggi.ac.kr/webService.kgu?menuCode=K00M0502" style="padding-right : 5px; border-right : 1px white solid; margin-right : 5px;">개인정보처리방침</a>© KYONGGI Univ. COMPUTER SCIENCE Dept.</span>
            </p>
        </div>
    </div>
</footer>

<script>
    var clickCount = 0;
    function esterEgg(){
        if(clickCount == 10)
            window.location.href = 'madeby.kgu';
        clickCount++;

    }
</script>