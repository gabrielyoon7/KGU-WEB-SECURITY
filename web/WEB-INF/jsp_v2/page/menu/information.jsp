<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    /**
     * v2 code
     * */
    String text = (String) request.getAttribute("text");
    String user = (String) session.getAttribute("user");
    String type = (String) session.getAttribute("type");
    String num = (String) request.getAttribute("num");
%>
<ul>
    <li style="margin-bottom : 5px;">
        <div id="maintitle" class="contenttitle"></div>
        <%--                  <div>내용들어갈부분</div>--%>
        <div id="maintext"></div>
    </li>
</ul>
<div id="modify_button"></div>
<script>
    var maindiv = $('#maintext');
    var txt = <%=text%>;
    maindiv.append(txt.content);

    $(document).ready(function () { //본문 제어
        makePageTitle('maintitle'); // 본문 안에 제목 넣어주는 역할 (page.jsp에서 함수를 찾아보세요)
    })

    var panel = $('#titlename');
    var pane = $('#title');
    var number = <%=num%>;


    var user = <%=user%>;
    if (<%=type%>.type_name == '관리자' || <%=type%>.type_name == '홈페이지관리자' || (<%=num%> == '92' && <%=type%>.type_name == '졸업논문관리자')){
       $('#modify_button').append('<div id="write_post" class="col-xs-13 text-right" style = "margin : 2px;"><button type="button" class="btn btn-default" onclick="modify()">수정</button></div>');
    }

    function modify() {
        var modify_button = $('#modify_button');
        var a = '';
        modify_button.empty();
        a += '<textarea id="editor">' + txt.content + '</textarea>';
        a += '<div id="write_post" class="col-xs-13 text-right"><button type="button" class="btn btn-default" style = "margin : 2px;" onclick="modifyinfo()">수정</button>';
        a += '<button type="button" class="btn btn-default" style = "margin : 2px;" onclick="back()">뒤로</button></div></div>';
        $('#maintext').html(a);
        CKEDITOR.replace('editor', {
            allowedContent: true,
            height: 500,
            'filebrowserUploadUrl': 'Uploader'
        });
    }

    function back() {
        var a = '';
        a += txt.content;
        $('#maintext').html(a);
        var b = '<div id="write_post" class="col-xs-13 text-right" style = "margin : 2px;"><button type="button" class="btn btn-default" onclick="modify()">수정</button></div>';
        $('#modify_button').html(b);
    }

    function modifyinfo() {
        var content = CKEDITOR.instances.editor.getData();
        var text =<%=text%>;
        var modify = text.major+"-/-/-"+text.id + "-/-/-" + content;

        $.ajax({
            url: 'ajax.kgu',
            type: 'post',
            data: {
                req: "modifyinfo",
                data: modify
            },
            dataType: "json",
            success: function (data) {
                if (data != 'fail') {
                    alert("수정완료");
                    txt = data;
                    $('#maintext').html(txt.content);
                    var b = '<div id="write_post" class="col-xs-13 text-right" style = "margin : 2px;"><button type="button" class="btn btn-default" onclick="modify()">수정</button></div>';
                    $('#modify_button').html(b);
                } else
                    alert('SERVER ERROR, Please try again later');
            }
        })
    }
</script>