<%--
  Created by IntelliJ IDEA.
  User: ssky6
  Date: 2022-02-03
  Time: 오전 1:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //String tabmenulist=(String) request.getAttribute("tabmenulist");//관리자탭메뉴
    String schedulelist = (String) request.getAttribute("schedulelist");//스케쥴 리스트
    String images = (String) request.getAttribute("images");
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
    <title>메인관리 : 경기대학교 AI컴퓨터공학부</title>
    <style>
        #maincontent {
            padding: 0;
        }

        #maincontent>ul {
            padding: 10px;
        }
        .boardtable > thead > tr > th, .boardtable > tbody > tr > td{
            text-overflow: ellipsis;
            overflow: hidden;
            white-space: nowrap;
            text-align: center;
            border-right : none;
            border-left : none;
        }
        .boardtable > thead > tr > th:nth-child(1), .boardtable > tbody > tr > td:nth-child(1) {
            min-width: 100px;
            max-width: 100px;
            width: 100px;
        }
        .boardtable > thead > tr > th:nth-child(3), .boardtable > tbody > tr > td:nth-child(3) {
            min-width: 200px;
            max-width: 200px;
            width: 200px;
        }
        .boardtable > thead > tr > th:nth-child(2), .boardtable > tbody > tr > td:nth-child(2) {
            min-width: 390px;
            max-width: 390px;
            width: 390px;
        }
        .fixed-table-container{
            border : none;
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
            <div class="contenttitle">일정 관리</div>
        </li>
    </ul>
    <table class="boardtable" id="scheduleTable" data-toggle="table"
           data-pagination="true"
           data-search="true" data-side-pagination="true"
           data-page-list="[10]">
        <thead>
        <tr>
            <th data-field="index" data-sortable="true">번호</th>
            <th data-field="content" data-sortable="true">일정</th>
            <th data-field="date" data-sortable="true">날짜</th>
        </tr>
        </thead>
    </table>

    <div style="margin-top:10px;"> <div class="col-md-10"></div>
        <a href="#myModal" data-toggle="modal" onclick="insertSch()" class="btn btn-default col-md-1">추가</a>
        <button type="button" class="btn btn-default col-md-1" onclick="updateSch()" style="height:34px;">갱신</button>
    </div>
    <hr style="border :1px dotted black; margin-top : 60px">
    <ul>
        <li>
            <div class="contenttitle">사진 관리</div>
        </li>
    </ul>
    <span style="font-size : 13px">※사진은 최신 업로드순으로 보여지며, 무조건 하나 이상의 사진이 남아있어야 합니다.</span>
    <table class="boardtable" id="imageTable" data-toggle="table">
        <thead>
        <tr>
            <th data-field="index" data-sortable="true">현재 순서</th>
            <th data-field="name" data-sortable="true">이름</th>
            <th data-field="for_delete"></th>
        </tr>
        </thead>
    </table>
    <div style="margin : 20px 0; float :right"">
    <input type="file" style="display:inline-block; margin-right : 10px"><button class="btn btn-default" onclick="submitImage()">추가</button>
</div>
</div>
<div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">일정관리</h4>
            </div>
            <div class="modal-body" id = "myModalbody">
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>

<script>
    makeboard(tab_2)
</script>
<script>

    function updateSch(){
        var date = new Date();
        $.ajax({
            url:"ajax.kgu",
            type:"post",
            data : {
                req : "updateSchedule",
                data : date
            },
            success : function(){
                alert("일정 갱신 완료");
                location.reload();
            }

        })

    }

    function insertSch(){
        var list = $('#myModalbody');
        var a = '';
        a += '<div class="form-group"><label for="InputBirth">날짜</label><input type="date" class="form-control" id="InputBirth" name = "new_date" value ='+formatDate(new Date())+' placeholder="Date of Birth" required></div><br/>';
        a += '<div><input type = "text" class="form-control" name = "new_text" placeholder="내용을 입력하세요" required/></div><br/>';
        a += '<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>'
        a += '<button type="button" class="btn btn-default pull-right" data-dismiss="modal"aria-label="Close" onclick="insertSchedule()">완료</button>';
        list.html(a);
    }

    function formatDate(date) {
        var d = new Date(date),
            month = '' + (d.getMonth() + 1),
            day = '' + d.getDate(),
            year = d.getFullYear();

        if (month.length < 2) month = '0' + month;
        if (day.length < 2) day = '0' + day;

        return [year, month, day].join('-');
    }

    function insertSchedule(){
        var date = $('[name = new_date]').val();
        var text = $('[name = new_text]').val();
        if(text.length>=50){
            alert("내용이 너무 깁니다!");
            return;
        }
        var data = date + '-/-/-' + text;
        $.ajax({
            url:"ajax.kgu",
            type:"post",
            data : {
                req : "insertschedule",
                data : data
            },
            success : function(){
                location.reload();
            }

        })

    }

    function modifySchedule(str){
        var list = $('#myModalbody');
        $.ajax({
            url:"ajax.kgu",
            type:"post",
            data : {
                req : "getoneschedule",
                data : str
            },
            dataType:"json",
            success:function(data){
                var a = "";
                var it = data;
                a += '<div class="form-group"><label for="InputBirth">날짜</label><input type="date" class="form-control" id="InputBirth" name = "w_date" value ='+formatDate(it.date)+' placeholder="Date of Birth" required></div><br/>';
                a += '<div><input type = "text" class="form-control" name = "w_content" value = '+it.content+' required/></div><br/>';
                a += '<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>'
                a += '<button type="button" class="btn btn-default pull-right" onclick="deleteSch('+it.index+')">삭제</button>';
                a += '<button type="button" class="btn btn-default pull-right" data-dismiss="modal"aria-label="Close" onclick="modifySch('+it.index+')">완료</button>';
                list.html(a);
            }
        });

    }

    function deleteSch(index){
        $.ajax({
            url : "ajax.kgu",
            type : "post",
            data : {
                req : "deleteschedule",
                data : index
            },
            success : function(data) {
                alert("삭제가 완료되었습니다");
                location.reload();
            }
        })

    }

    function modifySch(str){
        var index = str;
        var date = $('[name=w_date]').val();
        var content = $('[name=w_content]').val();
        if(content.length>=50){
            alert("내용이 너무 깁니다!");
            return;
        }
        if(date==""||content=="") {
            alert("수정할 값을 전부 입력해주세요.")
            return;
        }
        var update = index + "-/-/-" + date + "-/-/-" + content;

        $.ajax({
            url : "ajax.kgu",
            type : "post",
            data : {
                req : "modifyschedule",
                data : update
            },
            dataType : "json",
            success : function(data) {
                alert("수정이 완료되었습니다");
                location.reload();
            }
        })
    }

    var schedules=<%=schedulelist%>;

    function callSetupTableView1(){
        $('#scheduleTable').bootstrapTable('append',data1());
        $('#scheduleTable').bootstrapTable('refresh');
    }

    function callSetupTableView2(){
        $('#imageTable').bootstrapTable('append',data2());
        $('#imageTable').bootstrapTable('refresh');
    }

    function data1(){
        var rows = [];
        for(var i=0;i<schedules.length;i++){
            var value=schedules[i];
            rows.push({
                index: i+1,
                date: formatDate(value.date),
                content:'<a data-toggle="modal" href="#myModal" onclick="modifySchedule('+value.index+')">'+value.content+'</a>'
            });
        }
        return rows;
    }
    var images = <%=images%>;

    function data2(){
        var rows = [];
        for(var i=0 ; i < images.length ; ++i){
            var value = images[i];
            rows.push({
                index : i+1,
                name : value.original_name,
                for_delete : '<a onclick="deleteImage(' + value.id + ')" class="btn btn-default" style="padding : 3px 10px">삭제</a>'
            })
        }
        return rows;
    }

    function deleteImage(id){
        if(images.length == 1){
            alert('이미지가 한개밖에 남지 않았습니다. 지울 수 없습니다.');
            return;
        }
        $.ajax({
            url : 'ajax.kgu',
            type : 'post',
            data : {
                req : 'deleteSlider',
                data : id
            },
            success : function(data){
                if(data == 'success'){
                    alert('삭제 성공');
                    window.location.href = 'admin.kgu?num=81';
                }else
                    alert('SERVER ERROR, Please try again later...');}
        });
    }

    function submitImage(){
        var formData = new FormData();
        if($('input[type=file]')[0].files[0]==undefined){
            alert('사진을 선택해주세요!');
            return;
        }
        formData.append('file', $('input[type=file]')[0].files[0]);
        $.ajax({
            url : 'slider_upload.kgu',
            type : 'post',
            data : formData,
            processData : false,
            contentType : false,
            success : function(data){
                if(data == 'success'){
                    alert('등록 성공');
                    window.location.href = 'admin.kgu?num=81';
                }
                else
                    alert('SERVER ERROR, Please try again later...');}
        })
    }


    $(document).ready(function(){
        callSetupTableView1();
        callSetupTableView2();
    })
</script>
</body>
</html>
