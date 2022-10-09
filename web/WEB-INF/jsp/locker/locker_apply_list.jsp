<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
    StringBuffer url2_locker_apply_list = request.getRequestURL();
    String logo_img_locker_apply_list;

    //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
    //ai이면 ai로고 cs이면 cs로고
    if(url2_locker_apply_list.substring(7,9).equals("ai") || url2_locker_apply_list.substring(7,9).equals("lo")){
        logo_img_locker_apply_list = "img/notice_ai.png";
    }
    else{
        logo_img_locker_apply_list = "img/notice.png";
    }
    //System.out.println((logo_img_locker_apply_list));
%>
<%
    String tabmenulist=(String) request.getAttribute("tabmenulist");//관리자탭메뉴
    String alluser = (String) request.getAttribute("alluser");//스케쥴 리스트
    String AIuser = (String) request.getAttribute("AIuser");//스케쥴 리스트
    String allAppliedStudents = (String) request.getAttribute("allAppliedStudents");

%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="utf-8">
    <title>사물함 관리</title>
    <link rel="stylesheet" href="css/bootstrap-table.css">
    <link href='css/bootstrap.css' rel='stylesheet' type='text/css'>
    <link href='css/default.css' rel='stylesheet' type='text/css'>
    <link href='css/boardtable.css' rel='stylesheet' type='text/css'>
    <link href='css/information.css' rel='stylesheet' type='text/css'>
    <link href='css/content.css' rel='stylesheet' type='text/css'>
    <link href='css/bootstrap-table.css' rel='stylesheet' type='text/css'>

    <style>
        #maincontent {
            padding: 0;
        }

        #maincontent>ul {
            padding: 10px;
        }
        .boardtable > thead > tr > th:nth-child(2) {
            min-width: 30px;
        }

        .boardtable > tbody > tr > td:nth-child(2) {
            min-width: 30px;
        }
        .boardtable > thead > tr > th:nth-child(3) {
            min-width: 100px;
        }

        .boardtable > thead > tr > th:nth-child(5) {
            width: 120px;
            min-width:120px;
        }

        .boardtable > tbody > tr > td:nth-child(3) {
            font-family: 'Nanum Gothic', sans-serif;
            min-width: 100px;
        }

        .boardtable > tbody > tr > td:nth-child(5) {
            width: 120px;
            min-width:120px;
        }
        .boardtable > thead > tr > th:nth-child(2) {
            min-width: 150px;
        }
        .boardtable > thead > tr > th:nth-child(7), .boardtable > tbody > tr > td:nth-child(7){
            width:60px;
            min-width:60px;
        }
        .boardtable > thead > tr > th:nth-child(1), .boardtable > tbody > tr > td:nth-child(1){
            width:50px;
            min-width:50px;
        }
    </style>
</head>
<body>
<script src="js/default.js"></script>
<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrap-table.js"></script>
<script src="js/bootstrap-table-cookie.js"></script>
<script src="js/bootstrap-table-export.min.js"></script>
<script src='js/sha256.js'></script>
<%@include file="../main/header.jsp"%>
<script>
    function makeboard(id) {
        var list = $(id);
        var arr = <%=tabmenulist%>;
        for (var i = 0; i < arr.length; i++) {
            var value = arr[i];
            if(value.show_in_menus)
                list.append(makeone(value));
        }
    }
    function makeone(str) {
        var num=str.tab_id*10+str.orderNum;
        var text = '<li><span class="deco_dot">●</span><a href="'+str.path+'?num='+num+'">'+ str.page_title + '</li>'
        return text;
    }
</script>
<main>
    <div id="content">
        <div id="title">
            <img src=<%=logo_img_locker_apply_list%> />
            <div>사물함 신청자 관리</div>
        </div>
        <div id="container">
            <div id="tab">
                <ul id="tab_2">
                </ul>
            </div>
            <div id="maincontent">
                <ul>
                    <li>
                        <div class="contenttitle">사물함 신청자를 관리하는 페이지. (배정해주셔야 사용이 가능합니다.)</div>
                    </li>
                </ul>
                <table class="boardtable" id="table" data-toggle="table"
                       data-pagination="true" data-toolbar="#toolbar"
                       data-search="true" data-side-pagination="true" data-click-to-select="true"
                       data-page-list="[10]">
                    <thead>
                    <tr>
                        <th data-field="check" data-checkbox="true"></th>
                        <th data-field="del">설정</th>
                        <th data-field="locker" data-sortable="true">사물함</th>
                        <th data-field="id" data-sortable="true">학번</th>
                        <th data-field="name" data-sortable="true">이름</th>
                        <th data-field="state" data-sortable="true">상태</th>
                        <th data-field="deposit" data-sortable="true">보증금</th>
                        <th data-field="major" data-sortable="true">학과</th>
                        <th data-field="phoneNum" data-sortable="true">연락처</th>
                        <th data-field="bank" data-sortable="true">은행</th>
                        <th data-field="accountNum" data-sortable="true">계좌번호</th>
                    </tr>
                    </thead>
                </table>
                <div class="col-md-6"></div>
            </div>
        </div>
    </div>
    </div>
</main>
<%@include file="../main/footer.jsp"%>
<div id="shadow">
    <div id="blur"></div>
</div>

<script>
    makeboard(tab_2)
</script>
<script>

    var alluser=<%=allAppliedStudents%>;

    function callSetupTableView(){
        $('#table').bootstrapTable('append',data());
        $('#table').bootstrapTable('refresh');
    }


    function data(){
        var rows = [];
        for(var i=0;i<alluser.length;i++){
            var user=alluser[i];
            rows.push({
                locker: user.locker_num,
                id: user.per_id,
                name: user.name,
                state : user.state,
                deposit : user.deposit,
                major : user.major,
                phoneNum: user.phoneNum,
                bank: user.bank,
                accountNum : user.accountNum,
                del : '<button type="button" class="btn btn-default btn btn-xs" style = "margin : 1px;" onclick="deleteApply('+i+')">신청삭제</button>' +
                    '<button type="button" class="btn btn-default btn btn-xs" style = "margin : 1px;" onclick="allocateLocker('+i+')">사물함배정</button>'
            });
        }
        return rows;
    }

    $(document).ready(function(){
        callSetupTableView();
    })

    function deleteApply(id){ //신청 삭제
        var user =alluser[id];
        var data=user.per_id+"-/-/-"+user.locker_num;
        alert(data);
        var check = confirm(user.name+"["+user.per_id+"]님의 사물함 신청을 삭제 하시겠습니까? (삭제 시 재신청 해야함.)");
        if(check){
            $.ajax({
                url : "ajax.do", //AjaxAction
                type : "post",
                data : {
                    req : "deleteAppliedStudent",
                    data : data
                },
                success :function(data){
                    alert("삭제되었습니다.");
                    window.location.href = 'locker_apply_list.do?num=115';
                }
            })
        }
    }

    function allocateLocker(id){ //사물함 배정
        var user =alluser[id];
        var data = alluser[id].locker_num+"-/-/-"+alluser[id].per_id+"-/-/-"+alluser[id].name+"-/-/-"+alluser[id].major+"-/-/-"+alluser[id].phoneNum+"-/-/-"+alluser[id].bank+"-/-/-"+alluser[id].accountNum;
        var check = confirm(user.name+"["+user.per_id+"]님을 사물함 배정 하시겠습니까?");
        if(check){
            $.ajax({
                url : "ajax.do", //AjaxAction
                type : "post",
                data : {
                    req : "allocateLocker",
                    data : data
                },
                success :function(data){
                    alert("배정되었습니다.");
                    window.location.href = 'locker_apply_list.do?num=115';
                }
            })
        }
    }

</script>
</body>
</html>