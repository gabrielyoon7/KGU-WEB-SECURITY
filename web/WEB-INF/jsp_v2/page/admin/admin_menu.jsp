<%--
  Created by IntelliJ IDEA.
  User: ssky6
  Date: 2022-02-03
  Time: 오전 1:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //String tabmenulist=(String) request.getAttribute("tabmenulist");//관리자탭메뉴
    String typelist=(String) request.getAttribute("typelist");
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
    <title>메뉴 관리 :경기대학교 AI컴퓨터공학부</title>
    <style>
        #maincontent {
            padding: 0;
        }

        #maincontent>ul {
            padding: 10px;
        }
        .fixed-table-body{
            height:auto;
        }
        .boardtable > thead > tr > th:nth-child(1), .boardtable > tbody > tr > td:nth-child(1) {
            min-width: 100px;
            max-width: 100px;
            width: 100px;
        }
        .boardtable > thead > tr > th:nth-child(2), .boardtable > tbody > tr > td:nth-child(2) {
            min-width: 340px;
            max-width: 340px;
            width: 340px;
        }
        .boardtable > thead > tr > th, .boardtable > tbody > tr > td{
            text-overflow: ellipsis;
            overflow: hidden;
            white-space: nowrap;
            text-align: center;
            border-left:none;
            border-right:none;
        }
        .boardtable > thead > tr > th:nth-child(4), .boardtable > tbody > tr > td:nth-child(4) {
            min-width: 100px;
            max-width: 90px;
            width: 90px;
        }
        .boardtable > thead > tr > th:nth-child(5), .boardtable > tbody > tr > td:nth-child(5) {
            min-width: 100px;
            max-width: 100px;
            width: 100px;
        }
        .fixed-table-container{
            border:none;
        }
    </style>
</head>
<body>
<script>
    function makeboard(id) {
        var list = $(id);
        var arr = <%=pageMenuList%>;
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

<div id="maincontent">
    <ul>
        <li>
            <div class="contenttitle">메뉴 관리</div>
        </li>
    </ul>
    <table class="boardtable" id="table" data-toggle="table"
           data-pagination="true"
           data-search="true" data-side-pagination="true"
           data-page-list="[10]">
        <thead>
        <tr>
            <th data-field="index" data-sortable="true">번호</th>
            <th data-field="title_menu" data-sortable="true">이름</th>
            <th data-field="type" data-sortable="true">타입</th>
            <th data-field="header_menu" data-sortable="true">구분</th>
            <th data-field="show_detail" data-sortable="true">상세보기</th>
        </tr>
        </thead>
    </table>
    <div class="col-md-11"></div>
    <div id="inoutbtn">
        <a href="#insertModal" data-toggle="modal" onclick ="insertMenu()" class="btn btn-default col-md-1">추가</a>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="modifyModal" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Modify Menu</h4>
            </div>
            <div class="modal-body" id = "modifyModalbody">
            </div>
            <div class="modal-footer" id = "modifyModalfooter">
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="insertModal" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Insert Menu</h4>
            </div>
            <div class="modal-body">
                <div id = "insertModalbody1"></div>
                <div id = "insertModalbody2"></div>
            </div>

            <div class="modal-footer" id = "insertModalfooter">
            </div>
        </div>
    </div>
</div>

<script>
    makeboard(tab_2)
</script>
<script>
    var menulist = <%=menulist%>;
    var headermenulist = <%=headermenulist%>;
    function callSetupTableView(){
        $('#table').bootstrapTable('append',data());
        $('#table').bootstrapTable('refresh');
    }


    function data(){
        var rows = [];
        var typeName="";
        var indexID=1;
        for(var i=0;i<menulist.length;i++){
            var value=menulist[i];
            if(value.tab_id<8){
                var headvalue=headermenulist[(value.tab_id-1)];
                if(value.show_in_menus==1){
                    if(value.path=="information.kgu"){
                        typeName = "정보 페이지";
                    }
                    else if(value.path=="notice_article_list.kgu"){
                        typeName = "공지사항 게시판";
                    }
                    else{
                        typeName = "ETC";
                    }
                    rows.push({
                        index: indexID,
                        title_menu: value.page_title,
                        type: typeName,
                        header_menu: headvalue.tab_title,
                        show_detail: '<a data-toggle="modal" href="#modifyModal" onclick="modifyMenu('+value.id+')">상세보기</a>'
                    });
                    indexID++;
                }
                else
                    continue;
            }
        }
        return rows;
    }

    $(document).ready(function(){
        callSetupTableView();
    })
    function insertMenu(){
        var list = $('#insertModalbody1');
        var a="";
        a += '<div class="form-group"><span>메뉴 타입 :</span><select onchange="selectType()" style="display : inline-block; width:200px;" class="form-control" name="menutype"><option value="default">선택해주세요</option><option value="static">정보 페이지</option><option value="notice">공지사항 게시판</option></div><br>'
        list.html(a);
    }
    function selectType(){
        var list=$('#insertModalbody2');
        list.empty();
        var val = $('[name=menutype]').val();
        if(val=='static'){
            list.append(
                '<div class="form-group"><span>메뉴 이름 :</span><input style="display : inline-block; width:200px;" type="text" class="form-control" name = "title"></div><br>'+
                '<div class="form-group"><span>메뉴 구분 :</span><select onchange="selectOrder(insert)" style="display : inline-block; width:200px;" class="form-control" name="insertheader"><option value="0">선택해주세요</option><option value="1">학과소개</option><option value="2">교육활동</option><option value="3">구성원</option><option value="4">학과알림</option><option value="5">신청접수</option><option value="6">동아리</option><option value="7">인공지능</option></select></div><br>'+
                '<div class="form-group"><span>위 치 :</span><select id="insert" style="display : inline-block; width:200px;" class="form-control" name="ordernum"></select></div><br>');
            var foot = $('#insertModalfooter');
            foot.html('<button type="button" class="btn btn-default" data-dismiss="modal" onclick="insertMu()">완료</button>');
        }
        else if(val=='notice'){
            list.append(
                '<div class="form-group"><span>메뉴 이름 :</span><input style="display : inline-block; width:200px;" type="text" class="form-control" name = "title"></div><br>'+
                '<div class="form-group"><span>메뉴 구분 :</span><select onchange="selectOrder(insert)" style="display : inline-block; width:200px;" class="form-control" name="insertheader"><option value="0">선택해주세요</option><option value="1">학과소개</option><option value="2">교육활동</option><option value="3">구성원</option><option value="4">학과알림</option><option value="5">신청접수</option><option value="6">동아리</option><option value="7">인공지능</option></select></div><br>'+
                '<div class="form-group"><span>위 치 :</span><select id="insert" style="display : inline-block; width:200px;" class="form-control" name="ordernum"></select></div><br>'+
                '<div class="form-group"><span>게시글 읽기  :</span><select id="insertType1" style="display : inline-block; width:200px;" class="form-control" name="read_level"></select></div><br>'+
                '<div class="form-group"><span>게시글 쓰기 :</span><select id="insertType2" style="display : inline-block; width:200px;" class="form-control" name="write_level"></select></div><br>'+
                '<div class="form-group"><span>댓글 보기 :</span><select id="insertType3" style="display : inline-block; width:200px;" class="form-control" name="read_comment_level"></select></div><br>'+
                '<div class="form-group"><span>댓글 쓰기 :</span><select id="insertType4" style="display : inline-block; width:200px;" class="form-control" name="write_comment_level"></select></div><br>'+
                '<div class="form-group"><span>파일 다운로드 :</span><select id="insertType5" style="display : inline-block; width:200px;" class="form-control" name="file_download_level"></select></div><br>');
            selectInsertType();
            var foot = $('#insertModalfooter');
            foot.html('<button type="button" class="btn btn-default" data-dismiss="modal" onclick="insertMu_notice()">완료</button>');
        }
    }
    $('#insertModal').on('hidden.bs.modal',function(){
        var clear = $('#insertModalbody2');
        clear.empty();
    })
    function modifyMenu(id){
        var list = $('#modifyModalbody');
        $.ajax({
            url:"ajax.kgu",
            type:"post",
            data : {
                req : "getonemenu",
                data : id
            },
            dataType:"json",
            success:function(data){
                var a="";
                var it = data;
                var itlevel = "";
                $.ajax({
                    url:"ajax.kgu",
                    type:"post",
                    async : false,
                    data : {
                        req : "getonemenulevel",
                        data : it.id
                    },
                    dataType:"json",
                    success:function(data){
                        itlevel = data;
                    }
                });
                if(it.path=="notice_article_list.kgu"){
                    a += '<div class="form-group"><span>메뉴 이름 :</span><input style="display : inline-block; width:200px;" type="text" class="form-control" name = "title" value = '+it.page_title+'></div><br>';
                    a += '<div class="form-group"><span>메뉴 구분 :</span><select onchange="selectOrder(modify)" style="display : inline-block; width:200px;" class="form-control" name="modifyheader"><option value="0">선택해주세요</option><option value="1">학과소개</option><option value="2">교육활동</option><option value="3">구성원</option><option value="4">학과알림</option><option value="5">신청접수</option><option value="6">동아리</option><option value="7">인공지능</option></select></div><br>';
                    a += '<div class="form-group"><span>위 치 :</span><select id="modify" style="display : inline-block; width:200px;" class="form-control" name="ordernum"></select></div><br>';
                    a += '<div class="form-group"><span>게시글 읽기  :</span><select id="modifyType1" style="display : inline-block; width:200px;" class="form-control" name="read_level"></select></div><br>';
                    a += '<div class="form-group"><span>게시글 쓰기 :</span><select id="modifyType2" style="display : inline-block; width:200px;" class="form-control" name="write_level"></select></div><br>';
                    a += '<div class="form-group"><span>댓글 보기 :</span><select id="modifyType3" style="display : inline-block; width:200px;" class="form-control" name="read_comment_level"></select></div><br>';
                    a += '<div class="form-group"><span>댓글 쓰기 :</span><select id="modifyType4" style="display : inline-block; width:200px;" class="form-control" name="write_comment_level"></select></div><br>';
                    a += '<div class="form-group"><span>파일 다운로드 :</span><select id="modifyType5" style="display : inline-block; width:200px;" class="form-control" name="file_download_level"></select></div><br>';
                    list.html(a);
                    selectModifyType();
                    setModifyType(itlevel);
                    var foot = $('#modifyModalfooter');
                    foot.html('<button type="button" class="btn btn-default" data-dismiss="modal" onclick="modifyMu_notice('+it.id+')">완료</button>'+
                        '<button type="button" class="btn btn-default" data-dismiss="modal" onclick="deleteMu_notice('+it.id+')">삭제</button>');
                }
                else {
                    a += '<div class="form-group"><span>메뉴 이름 :</span><input style="display : inline-block; width:200px;" type="text" class="form-control" name = "title" value = '+it.page_title+'></div><br>';
                    a += '<div class="form-group"><span>메뉴 구분 :</span><select onchange="selectOrder(modify)" style="display : inline-block; width:200px;" class="form-control" name="modifyheader"><option value="0">선택해주세요</option><option value="1">학과소개</option><option value="2">교육활동</option><option value="3">구성원</option><option value="4">학과알림</option><option value="5">신청접수</option><option value="6">동아리</option><option value="7">인공지능</option></select></div><br>';
                    a += '<div class="form-group"><span>위 치 :</span><select id="modify" style="display : inline-block; width:200px;" class="form-control" name="ordernum"></select></div><br>';
                    list.html(a);
                    var foot = $('#modifyModalfooter');
                    foot.html('<button type="button" class="btn btn-default" data-dismiss="modal" onclick="modifyMu('+it.id+')">완료</button>'+
                        '<button type="button" class="btn btn-default" data-dismiss="modal" onclick="deleteMu('+it.id+')">삭제</button>');
                }
            }
        });
    }
    function modifyMu_notice(id){
        var name = $('[name=title]').val();
        if(name.length>=25){
            alert("이름이 너무 깁니다!");
            return;
        }
        if(name.length==0){
            alert("이름을 한 글자 이상 입력해주세요.");
            return;
        }
        var header = $('[name=modifyheader]').val();
        if(header=="0"){
            alert("메뉴 구분을 먼저 선택해주세요");
            return;
        }
        var ordernum = $('[name=ordernum]').val();
        var read_level = $('[name=read_level]').val();
        var write_level = $('[name=write_level]').val();
        var read_comment_level = $('[name=read_comment_level]').val();
        var write_comment_level = $('[name=write_comment_level]').val();
        var file_download_level = $('[name=file_download_level]').val();
        var update = name + "-/-/-" + header + "-/-/-" + ordernum + "-/-/-" + read_level + "-/-/-" + write_level + "-/-/-" + read_comment_level + "-/-/-" + write_comment_level + "-/-/-" + file_download_level + "-/-/-" + id;
        var check = confirm("정말 수정하시겠습니까?");
        if(check){
            $.ajax({
                url : "ajax.kgu",
                type : "post",
                data : {
                    req : "modify_notice_menu",
                    data : update
                },
                success : function(data) {
                    if(data == 'fail'){
                        alert('하나 밖에 존재하지 않는 메뉴에요. 아껴주세요.');
                        return;
                    }
                    alert("수정이 완료되었습니다");
                    location.reload();
                }
            });
        }
    }
    function modifyMu(id){
        var name = $('[name=title]').val();
        if(name.length>=25){
            alert("이름이 너무 깁니다!");
            return;
        }
        if(name.length==0){
            alert("이름을 한 글자 이상 입력해주세요.");
            return;
        }
        var header = $('[name=modifyheader]').val();
        if(header=="0"){
            alert("메뉴 구분을 먼저 선택해주세요");
            return;
        }
        var ordernum = $('[name=ordernum]').val();
        var update = name + "-/-/-" + header + "-/-/-" + ordernum + "-/-/-" + id;
        var check = confirm("정말 수정하시겠습니까?");
        if(check){
            $.ajax({
                url : "ajax.kgu",
                type : "post",
                data : {
                    req : "modify_menu",
                    data : update
                },
                success : function(data) {
                    if(data == 'fail'){
                        alert('하나 밖에 존재하지 않는 메뉴에요. 아껴주세요.');
                        return;
                    }
                    alert("수정이 완료되었습니다");
                    location.reload();
                }
            });
        }
    }
    function insertMu_notice(){
        var name = $('[name=title]').val();
        if(name.length>=25){
            alert("이름이 너무 깁니다!");
            return;
        }
        if(name.length==0){
            alert("이름을 한 글자 이상 입력해주세요.");
            return;
        }
        var header = $('[name=insertheader]').val();
        if(header=="0"){
            alert("메뉴 구분을 먼저 선택해주세요");
            return;
        }
        var ordernum = $('[name=ordernum]').val();
        var read_level = $('[name=read_level]').val();
        var write_level = $('[name=write_level]').val();
        var read_comment_level = $('[name=read_comment_level]').val();
        var write_comment_level = $('[name=write_comment_level]').val();
        var file_download_level = $('[name=file_download_level]').val();
        var insert = name + "-/-/-" + header + "-/-/-" + ordernum + "-/-/-" + read_level + "-/-/-" + write_level + "-/-/-" + read_comment_level + "-/-/-" + write_comment_level + "-/-/-" + file_download_level;
        var check = confirm("정말 추가하시겠습니까?");
        if(check){
            $.ajax({
                url : "ajax.kgu",
                type : "post",
                data : {
                    req : "insert_notice_menu",
                    data : insert
                },
                success : function(data) {
                    alert("추가가 완료되었습니다");
                    location.reload();
                }
            });
        }
    }

    function insertMu(){
        var name = $('[name=title]').val();
        if(name.length>=25){
            alert("이름이 너무 깁니다!");
            return;
        }
        if(name.length==0){
            alert("이름을 한 글자 이상 입력해주세요.");
            return;
        }
        var header = $('[name=insertheader]').val();
        if(header=="0"){
            alert("메뉴 구분을 먼저 선택해주세요");
            return;
        }
        var ordernum = $('[name=ordernum]').val();
        var insert = name + "-/-/-" + header + "-/-/-" + ordernum;
        var check = confirm("정말 추가하시겠습니까?");
        if(check){
            $.ajax({
                url : "ajax.kgu",
                type : "post",
                data : {
                    req : "insert_menu",
                    data : insert
                },
                success : function(data) {
                    alert("추가가 완료되었습니다");
                    location.reload();
                }
            });
        }
    }
    function selectOrder(type){
        var list = $(type);
        var val='';
        if(type.id=='modify')
            val = $('[name=modifyheader]').val();
        else if(type.id=='insert')
            val = $('[name=insertheader]').val();
        var text='';
        if(val=="0"){
            text += '<option>메뉴 구분을 먼저 선택해주세요</option>';
            list.empty();
            list.append(text);
        }
        else{
            $.ajax({
                url : "ajax.kgu",
                type : "post",
                data : {
                    req : "getnumorder",
                    data : val
                },
                success : function(data){
                    var it = data;
                    for(var i=0;i<=it;i++){
                        text += '<option>'+(i+1)+'</option>';
                    }
                    list.empty();
                    list.append(text);
                }
            });
        }
    }
    function selectInsertType(){
        var type = <%=typelist%>;
        var memory = [];
        for(var i=0; i<5;i++){
            var list=$('#insertType'+(i+1))
            for(var j=0; j<type.length;j++){
                var value = type[j];
                if(j>0){
                    if(value.board_level==type[j-1].board_level){
                        var recentIndex = memory[memory.length - 1];
                        $('#insert'+i+recentIndex).append(', '+value.type_name);
                    }
                    else{
                        list.append('<option id="insert'+i+j+'" value="'+(memory.length%10)+'">'+value.type_name +'</option');
                        memory.push(j);
                    }
                }
                else{
                    list.append('<option id="insert'+i+j+'" value="'+(memory.length%10)+'">'+value.type_name +'</option');
                    memory.push(j);
                }
            }
        }
    }
    function selectModifyType(){
        var type = <%=typelist%>;
        var memory = [];
        for(var i=0; i<5;i++){
            var list=$('#modifyType'+(i+1))
            for(var j=0; j<type.length;j++){
                var value = type[j];
                if(j>0){
                    if(value.board_level==type[j-1].board_level){
                        var recentIndex = memory[memory.length - 1];
                        $('#modify'+i+recentIndex).append(', '+value.type_name);
                    }
                    else{
                        list.append('<option id="modify'+i+j+'" value="'+(memory.length%10)+'">'+value.type_name +'</option');
                        memory.push(j);
                    }
                }
                else{
                    list.append('<option id="modify'+i+j+'" value="'+(memory.length%10)+'">'+value.type_name +'</option');
                    memory.push(j);
                }
            }
        }
    }

    function setModifyType(data){
        var value = data;
        $('#modifyType1 [value = "' + data.read_level + '" ]').attr('selected', true);
        $('#modifyType2 [value = "' + data.write_level + '" ]').attr('selected', true);
        $('#modifyType3 [value = "' + data.read_comment_level + '" ]').attr('selected', true);
        $('#modifyType4 [value = "' + data.write_comment_level + '" ]').attr('selected', true);
        $('#modifyType5 [value = "' + data.file_download_level + '" ]').attr('selected', true);
    }

    function deleteMu_notice(id){
        var check = confirm("정말 삭제하시겠습니까?");
        if(check){
            $.ajax({
                url : "ajax.kgu",
                type : "post",
                data : {
                    req : "delete_notice_menu",
                    data : id
                },
                success : function(data) {
                    if(data == 'fail'){
                        alert('하나 밖에 존재하지 않는 메뉴에요. 아껴주세요.');
                        return;
                    }
                    alert("삭제가 완료되었습니다");
                    location.reload();
                }
            });
        }
    }
    function deleteMu(id){
        var check = confirm("정말 삭제하시겠습니까?");
        if(check){
            $.ajax({
                url : "ajax.kgu",
                type : "post",
                data : {
                    req : "delete_menu",
                    data : id
                },
                success : function(data) {
                    if(data == 'fail'){
                        alert('하나 밖에 존재하지 않는 메뉴에요. 아껴주세요.');
                        return;
                    }
                    alert("삭제가 완료되었습니다");
                    location.reload();
                }
            });
        }
    }


</script>
</body>
</html>
