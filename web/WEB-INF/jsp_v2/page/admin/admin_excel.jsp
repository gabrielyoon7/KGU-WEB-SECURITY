<%--
  Created by IntelliJ IDEA.
  User: ssky6
  Date: 2022-02-02
  Time: 오후 11:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //String tabmenulist = (String) request.getAttribute("tabmenulist");//관리자탭메뉴
    String alluser = (String) request.getAttribute("alluser");//스케쥴 리스트
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
    <title>엑셀관리 : 경기대학교 AI컴퓨터공학부</title>
    <style>
        #maincontent {
            padding: 0;
        }

        #maincontent>ul {
            padding: 10px;
        }

        .boardtable>thead>tr>th:nth-child(1) {
            min-width: 30px;
        }

        .boardtable>tbody>tr>td:nth-child(1) {
            min-width: 30px;
        }

        .boardtable>thead>tr>th:nth-child(2) {
            min-width: 100px;
        }

        .boardtable>thead>tr>th:nth-child(4) {
            width: 100px;
        }

        .boardtable>tbody>tr>td:nth-child(2) {
            font-family: 'Nanum Gothic', sans-serif;
            min-width: 100px;
        }

        .boardtable>tbody>tr>td:nth-child(4) {
            width: 100px;
        }

        .boardtable>thead>tr>th:nth-child(12) {
            min-width: 150px;
        }
    </style>
</head>
<body>
<script>
    function makeboard(id) {
        var list = $(id);
        var arr =<%=pageMenuList%>;
        for (var i = 0; i < arr.length; i++) {
            var value = arr[i];
            if (value.show_in_menus)
                list.append(makeone(value));
        }
    }
    function makeone(str) {
        var num = str.tab_id * 10 + str.orderNum;
        var text = '<li><span class="deco_dot">●</span><a href="'
            + str.path + '?num=' + num + '">' + str.page_title
            + '</li>'
        return text;
    }
</script>

<div id="maincontent">
    <ul>
        <li>
            <div class="contenttitle">사용자 관리</div>
        </li>
    </ul>
    <fieldset>
        <div class="col-xs-3">수정 필드(일괄 수정)</div>
        <label class="checkbox-inline"><input type="checkbox"
                                              id="subscribeNews" name="modify" value="type">구분</label> <label
            class="checkbox-inline"><input type="checkbox"
                                           id="subscribeNews" name="modify" value="grade">학년</label> <label
            class="checkbox-inline"><input type="checkbox"
                                           id="subscribeNews" name="modify" value="per_id">학번</label> <label
            class="checkbox-inline"><input type="checkbox"
                                           id="subscribeNews" name="modify" value="major">학과</label> <label
            class="checkbox-inline"><input type="checkbox"
                                           id="subscribeNews" name="modify" value="state">학적상태</label>
    </fieldset>
    <table class="boardtable" id="table" data-toggle="table"
           data-pagination="true"
           data-toolbar="#toolbar" data-search="true"
           data-side-pagination="true" data-click-to-select="true"
           data-page-list="[20]">
        <thead>
        <tr>
            <th data-field="id" data-sortable="true">ID</th>
            <th data-field="per_id" data-sortable="true">학번</th>
            <th data-field="type" data-sortable="true">타입</th>
            <th data-field="name" data-sortable="true">이름</th>
            <th data-field="birth" data-sortable="true">생년월일</th>
            <th data-field="hope_type" data-sortable="true">희망구분</th>
            <th data-field="reg_date" data-sortable="true">가입일자</th>
            <th data-field="major" data-sortable="true">전공</th>
            <th data-field="grade" data-sortable="true">학년</th>
            <th data-field="state" data-sortable="true">학적상태</th>
            <th data-field="homeID" data-sortable="true">H.ID</th>
        </tr>
        </thead>
    </table>
    <div class="col-md-6">
        <input type="file" name="uploadFile" id="uploadFile"accept=".xls, .xlsx">
    </div>
    <a href="excel.kgu?writeorread=write" class="btn btn-default col-md-2">Excel로 보내기</a>
    <a href="#myModal" data-toggle="modal" onclick="insertexcelreader()" class="btn btn-default col-md-2">일괄 추가</a>
    <a href="#myModal2" data-toggle="modal" onclick="modifyexcelreader()" class="btn btn-default col-md-2">일괄 수정</a>
</div>

<script>
    makeboard(tab_2)
</script>
<script>
    var $table = $('#table');
    var $remove = $('#remove');

    var alluser =<%=alluser%>;
    function callSetupTableView() {

        $('#table').bootstrapTable('append', data());
        $('#table').bootstrapTable('refresh');
    }

    function data() {
        var rows = [];
        for (var i = 0; i < alluser.length; i++) {
            var user = alluser[i];
            var date = formatData(user.reg_date);
            rows.push({
                id : user.id,
                per_id : user.per_id,
                type : user.type,
                name : user.name,
                birth : user.birth,
                hope_type : user.hope_type,
                reg_date : date,
                major : user.major,
                grade : user.grade,
                state : user.state,
                homeID : user.myhomeid,
            });
        }
        return rows;
    }

    $(document).ready(function() {
        callSetupTableView();
    })

    function formatData(date) {
        var d = new Date(date), month = '' + (d.getMonth() + 1), day = ''
            + d.getDate(), year = d.getFullYear();

        if (month.length < 2)
            month = '0' + month;
        if (day.length < 2)
            day = '0' + day;

        return [ year, month, day ].join('-');
    }

    function deleteuser(id) {
        var user = alluser[id];
        var check = confirm(user.name + "[" + user.id + "]를 정말 삭제하시겠습니까?");
        if (check) {
            $.ajax({
                url : "ajaxuser.kgu",
                type : "post",
                data : {
                    req : "deleteuser",
                    data : alluser[i].id
                },
                success : function(data) {

                    alert("삭제되었습니다.");
                }
            })

        }
    }
    function insertexcelreader() {
        alert("파일 추가하셔야 수정 가능합니다!!");
        var address=uploadexcel();
        $.ajax({
            url : "excel.kgu",
            type : "post",
            data : {
                writeorread : "read",
                type : "user",
                address : address
            },
            dataType : "json",
            success : function(data) {
                var modal = $('#myModalbody');
                var howmany = $('#howmany');

                var it = data;
                var a = '<h3> 총 ' + (data.length)
                    + '명의 회원이 등록될 예정입니다.</h3>';
                howmany.html(a);
                var table2 = $('#insert_excel');

                var footer = $('#footer');
                footer
                    .html('<button id="addbutton" type="button" class="btn btn-default" style = "margin : 1px;">일괄 추가</button>');
                $('#addbutton').attr('onclick', 'insertuser()');
                table2.bootstrapTable('load', insertdata(data));
                table2.bootstrapTable('refresh');

            }
        })
    }
    function insertdata(data) {
        var rows = [];

        for (var i = 0; i < data.length; i++) {
            var user = data[i];
            rows.push({
                id : user.id,
                per_id : user.per_id,
                type : user.type,
                name : user.name,
                birth : user.birth,
                major : user.major,
                grade : user.grade,
                state : user.state,
            });
        }
        return rows;
    }

    function insertuser() {
        var address = uploadexcel();
        $.ajax({
            url : "ajaxuser.kgu",
            type : "post",
            data : {
                req : "insertexceluser",
                data : "true",
                address : address
            },
            success : function(data) {
                alert(data + "명의 회원이 등록되었습니다.");
                location.reload();
            }
        })
    }
    function modifyexcelreader() {
        alert("파일 추가하셔야 수정 가능합니다!!(수정 필드도 선택하셔야합니다 ID 칼럼필수)");
        var address = uploadexcel();
        var values = document.getElementsByName("modify");
        var modify = '';
        for (var i = 0; i < values.length; i++)
            if (values[i].checked) {
                modify += values[i].value + "-/-/-";
            }

        $.ajax({
            url : "excel.kgu",
            type : "post",
            data : {
                writeorread : "read",
                type : "user",
                data : modify,
                address : address
            },
            dataType : "json",
            success : function(data) {
                var modal = $('#myModalbody2');
                var howmany = $('#howmany2');
                var a = '<h3> 총 ' + (data.length)
                    + '명의 회원이 수정될 예정입니다.</h3>';
                howmany.html(a);
                var table2 = $('#modify_excel');
                var footer = $('#footer2');
                footer.html('<button id="addbutton" type="button" class="btn btn-default" style = "margin : 1px;">일괄 수정</button>');
                $('#addbutton').attr('onclick', 'modifyexceluser()');
                table2.bootstrapTable('load', modifydata(data));
                table2.bootstrapTable('refresh');
            }
        })
    }

    function modifydata(data) {
        var rows = [];

        for (var i = 0; i < data.length; i++) {
            var user = data[i];
            rows.push({
                id : user.id,
                type : user.type,
                per_id :user.per_id,
                grade : user.grade,
                major : user.major,
                state : user.state,
                typebefore : user.typebefore,
                per_idbefore : user.per_idbefore,
                gradebefore : user.gradebefore,
                majorbefore : user.majorbefore,
                statebefore : user.statebefore
            });
        }
        return rows;
    }
    function modifyexceluser(){
        var address = uploadexcel();
        var values = document.getElementsByName("modify");
        var modify = '';
        for (var i = 0; i < values.length; i++)
            if (values[i].checked) {
                modify += values[i].value + "-/-/-";
            }
        $.ajax({
            url : "ajaxuser.kgu",
            type : "post",
            data : {
                req : "modifyexceluser",
                data : modify,
                address : address
            },
            success : function(data) {
                alert(data + "명의 회원이 수정되었습니다.");
                location.reload();
            }
        })
    }


    function uploadexcel(){
        var formData = new FormData();
        var address="";
        formData.append("excelfile",$('input[name=uploadFile]')[0].files[0]);
        $.ajax({
            url : "insertExcel.kgu",
            type : "post",
            async:false,
            data : formData,
            processData : false,
            contentType : false,
            success : function(data){//데이터는 주소
                address =data;

            }
        })
        return address;
    }
</script>
</body>
</html>
