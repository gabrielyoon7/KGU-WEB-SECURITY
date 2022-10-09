<%--
  Created by IntelliJ IDEA.
  User: YOON
  Date: 2022-01-20
  Time: 오후 3:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String bigMenu= (String) session.getAttribute("headermenulist");
    String smallMenu= (String) session.getAttribute("menulist");
%>
<style>
    #container {
        display: flex;
        flex-direction: column;
    }

    #maincontent {
        min-height: 0px; !important;
        display: flex;
        padding: 0;
    }

    #maincontent>ul {
        padding: 10px;
        min-width: 150px;
    }

    #maincontent>ul>li>ul {
        border: none;
    }
</style>
<script>
    var sequence = 0;
    var tabs=<%=bigMenu%>;
    var pages=<%=smallMenu%>;
    var container = $('#container');
    for(var i=1;i<=7;i++){
        if(i % 4 == 1){
            sequence++;
            container.append('<div id="maincontent" class="maincontent'+ sequence +'"></div>');
        }
        var main = $('.maincontent'+sequence);
        var value1=tabs[i-1];
        main.append('<ul style="margin-left : 45px"><li><div class="contenttitle">'+value1.tab_title+'</div><ul id="site'+ i +'">');
        for(var j = 0 ; j < pages.length ; j++){
            var value2=pages[j];
            var mainsite = $('#site'+i);
            if(value2.tab_id==i && value2.show_in_menus){//이거 다르게 바꾸고싶음
                var num = value2.tab_id*10+value2.orderNum;
                if(value2.page_title == '졸업논문')
                    var text = '<li><a href="'+value2.path+'">'
                        + value2.page_title + '</a></li>';
                else
                    var text = '<li><a href="' + value2.path + '?num=' + num + '">' + value2.page_title + '</a></li>';
                mainsite.append(text);
            }
        }
        main.append('</li></ul>');
    }
</script>