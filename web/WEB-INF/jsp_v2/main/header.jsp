<%--
  Created by IntelliJ IDEA.
  User: gabri
  Date: 2021-08-28
  Time: 오후 1:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    /**
     * Header V2
     * */

    String headermenulist = (String) session.getAttribute("headermenulist");
    String menulist = (String) session.getAttribute("menulist");
    String user = (String) session.getAttribute("user");
    String type = (String) session.getAttribute("type");
%>
<header>
    <div id="headercontainer">
        <div id="member">
        </div>
    </div>
</header>


<%
    /**
     * 현재 URL을 검사하는 과정 시작.
     * 서브도메인 == http://subdomain.kyonggi.ac.kr에서의 subdomain
     * 그 중 맨 앞자리 두 글자를 가지고 현재 접속한 페이지를 판별하고 있음
     * */
    String subdomainJSONforHeader = (String) session.getAttribute("subdomain"); // ai 또는 cs로 도착함
    String subdomainForHeader = subdomainJSONforHeader.substring(1, subdomainJSONforHeader.length()-1 ); //JSON 형태를 Java 형식으로 만들어주기 위한 작업
    /**
     * 현재 URL을 검사하는 과정 끝
     * */

    String logo_img;

    //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
    //ai이면 ai로고 cs이면 cs로고
    if (subdomainForHeader.equals("ai")) {
        logo_img = "img/ai_logo.png";
        out.print("<link href='css/default_ai.css' rel='stylesheet' type='text/css'>");
    }
    else if (subdomainForHeader.equals("cs")) {
        logo_img = "img/cs_logo.png";
        out.print("<link href='css/default.css' rel='stylesheet' type='text/css'>");
    }
    else {
        logo_img="오류임";
    }
%>
<header2>
    <div id="headercontainer2">
        <div id="logo_container">
            <a href="Index"><img src=<%=logo_img%> id="logo" title=""></a>
        </div>
        <div id="headermenu">
            <span class="divide">|</span>
        </div>
        <div id="dropcontainer">
            <div id="no-padding" class="dropdowncontents">
                <div id="drop_menu">
                    <script>

                        var headermenu = <%=headermenulist%>;
                        var div = $('#headermenu');

                        // var myurl = window.location.href.slice(7, 9);
                        var myurl = <%=subdomainJSONforHeader%>;
                        var tabLimit;
                        if (myurl == "ai") {
                            //ai 사이트면 메뉴 7개 정상적으로 불러옴.
                            tabLimit = 7;
                        } else {
                            //cs 사이트면 메뉴 6개만 불러오기
                            tabLimit = 6;
                        }

                        for (var i = 0; i < tabLimit; i++) {
                            var it = headermenu[i];
                            var text = '';
                            if (it.tab_title == '신청하기' && <%=user%> == null)
                                text = '<div id=head' + (i + 1) + ' style="font-size : 17px">' + it.tab_title + '</div><span class="divide">|</span>';
                            else
                                text = '<div id=head' + (i + 1) + '><a href="' + it.tab_url + '">' + it.tab_title + '</a></div><span class="divide">|</span>';

                            div.append(text);
                        }

                        if (myurl == "ai") {
                            //ai 사이트면 이상 없음
                        } else {
                            //cs 사이트면 메뉴 6개만 불러오고 마지막을 공백div로 채움. (ai탭 안보이도록하려고)
                            div.append('<div style="font-size: 17px"></div>');
                        }


                        var menu = <%=menulist%>;
                        var type = <%=type%>;
                        var drop = $('#drop_menu');
                        var it;
                        var seqNum = 1;
                        drop.append('<ul id="list2' + seqNum + '">');
                        for (var i = 0; i < menu.length; ++i) {
                            it = menu[i];

                            if (myurl == "cs") {
                                if (it.tab_id == 7) {
                                    continue;
                                }  //ai탭 (tabid=7) 이면 하위메뉴추가안하고 넘겼음.
                            }

                            if (seqNum != it.tab_id && it.tab_id < 8) {
                                drop.append('</ul>');
                                seqNum = it.tab_id;
                                drop.append('<ul id="list2' + seqNum + '">');
                            }
                            var list = $('#list2' + seqNum);
                            if (it.show_in_menus && it.tab_id < 8) {
                                if (it.max_level >= type.board_level && it.min_level <= type.board_level) {
                                    var num = it.tab_id * 10 + it.orderNum;
                                    if (it.page_title == '졸업논문' || it.page_title == '나의 이수 현황' || it.page_title == '사물함 신청' || it.page_title == '졸업요건 진단') {
                                        var text = '<li><a href="' + it.path + '">' + it.page_title + '</a></li>';
                                    } else {
                                        var text = '<li><a href="' + it.path + '?num=' + num + '">' + it.page_title + '</a></li>';
                                    }
                                    list.append(text);
                                } else {
                                    var text = '<li>' + it.page_title + '</li>';
                                    list.append(text);
                                }
                            }
                        }
                        drop.append('</ul>');
                    </script>
                </div>
            </div>
        </div>
    </div>
</header2>
<script>
    $(document).ready(function () {
        var headermenu = $('#headermenu').width();
        $('#drop_menu').css('width', headermenu);
    });


    var user =<%=user%>;
    var type =<%=type%>;
    var it = $('#member');
    var graduation = '';
    if (user == null)
        var text = '<div><a href="loginpage.do" title="로그인">LOGIN</a></div>';
    else if (type.board_level == 0)
        var text = '<div id="login_info">안녕하세요. ' + user.name + ' (' + type.for_header + ')님</div><div><a href="admin.do?num=81" title="관리페이지">관리페이지</a></div><div><a href="logout.do" title=LOGOUT>LOGOUT</a></div>';
    else
        var text = '<div id="login_info">안녕하세요. ' + user.name + ' (' + type.for_header + ')님</div><div><a href="goMyPage.do">마이페이지</a></div><div><a href="logout.do" title=LOGOUT>LOGOUT</a></div>';
    it.append(text);
</script>