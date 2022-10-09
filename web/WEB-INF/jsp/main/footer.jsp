<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    //url이 ai~이면 default_ai.css해서 백그라운드 색깔만 달라지게
    //url이 cs~이면 default.css
    StringBuffer url_ = request.getRequestURL();
    if(url_.substring(7,9).equals("ai") || url_.substring(7,9).equals("lo")){
        out.print("<link href='css/default_ai.css' rel='stylesheet' type='text/css'>");
    }
    else{
        out.print("<link href='css/default.css' rel='stylesheet' type='text/css'>");
    }
%>
<footer>
    <div class="" id="footercontainer">
        <div>
            <p class="footer_menu">
                <span><a href="location.do" style="padding-right : 5px; border-right : 1px white solid;">연락처 및 오시는 길</a><a href="sitemap.do" style="margin-left : 5px;">사이트맵</a><a onclick="esterEgg()" style="color : #455a64">.</a>
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
			window.location.href = 'madeby.do';
		clickCount++;
		
	}
</script>