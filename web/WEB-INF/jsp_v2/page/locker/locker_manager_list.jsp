<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
    StringBuffer url2_manager_list = request.getRequestURL();
    String logo_img_locker_manager_list;

    //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
    //ai이면 ai로고 cs이면 cs로고
    if(url2_manager_list.substring(7,9).equals("ai") || url2_manager_list.substring(7,9).equals("lo")){
        logo_img_locker_manager_list = "img/notice_ai.png";
    }
    else{
        logo_img_locker_manager_list = "img/notice.png";
    }
    //System.out.println((logo_img_locker_manager_list));
%>
<%
    String tabmenulist=(String) request.getAttribute("tabmenulist");//관리자탭메뉴
    String locker = (String) request.getAttribute("locker"); //사물함 리스트
    String info = (String)  request.getAttribute("info"); // 학생회 계좌 정보
%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="utf-8">
    <title>사물함 관리 페이지</title>
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
<%@include file="../../main/header.jsp"%>
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
            <img src=<%=logo_img_locker_manager_list%> />
            <div>사물함 관리 페이지</div>
        </div>
        <div id="container">
            <div id="tab">
                <ul id="tab_2">
                </ul>
            </div>
            <div id="maincontent">
                <ul>
                    <li>
                        <div class="contenttitle">사물함 관리 페이지</div>
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
                        <th data-field="locker" data-sortable="true">사물함번호</th>
                        <th data-field="type" data-sortable="true">사물함종류</th>
                        <th data-field="available" data-sortable="true">신청가능여부</th>
                        <th data-field="location" data-sortable="true">사물함위치</th>
                        <th data-field="id" data-sortable="true">고유번호</th>

                    </tr>
                    </thead>
                </table>
<%--                <div class="col-md-6"></div>--%>
                <div class="contenttitle2" >학생회정보 설정하기</div>
                <div id="info"></div>
                <button onclick="updateInfo()" type="button" style="margin: 2px;" class="btn btn-default">수정</button>
                <div class="contenttitle2" >사물함 전체 '사용가능' 으로 변경</div>
                <button onclick="setAllLockerAvailableTrue()" type="button" style="margin: 2px;" class="btn btn-default">변경하기</button>
                <hr>
                <h2>사물함 신청시스템 관리방법</h2>
                <h3>대여 전 설정</h3>
                <ol>
                    <li>일정 페이지에서 일정을 수정합니다. 여기서 설정된 일정은 모든 사용자의 시스템에 표시됩니다.</li>
                    <li>일정 페이지에서 내용을 수정합니다. 일정 페이지에서만 표시되는 내용이고, 사용자들이 사물함 신청 전에 볼 수 있는 유일한 설명자료입니다.</li>
                    <li>이 페이지에서 사용이 가능한 사물함과 불가능한 사물함 설정을 해줍니다. 상태전환 버튼을 눌러 고장난 사물함을 지정해줘야 신청이 불가능하게 됩니다.</li>
                    <li>학생회 정보를 수정합니다. 은행, 계좌, 연락처를 설정하게 되면 모든 사용자의 시스템에 표시됩니다.</li>
                </ol>
                <h3>신청자 관리</h3>
                <ol>
                    <li>사용자들이 신청하기 버튼을 눌러 사물함을 신청합니다. 선착순으로 운영되며, 예비 번호는 없습니다. 앞서 지정된 고장 사물함 및 이미 신청자가 있는 사물함에는 신청할 수 없습니다.</li>
                    <li>사물함 신청에 성공한 사용자들은 신청자 관리 명단에 들어오게 됩니다.</li>
                    <li>사용자들은 앞서 관리자가 설정한 학생회 정보를 보고 보증금을 입금합니다. 보증금을 입금한 사용자는 버튼을 눌러 보증금 확인 요청을 합니다.</li>
                    <li>관리자는 '신청자 관리' 페이지에서 보증금을 입금했다고 알리는 학생들의 입금 내역을 계좌에서 확인합니다.</li>
                    <li>혹시 사물함 중복 신청이 되었는지 꼼꼼히 검사하고 이상이 없다면 사물함 배정을 해줍니다. 이때부터 사용자는 사물함을 사용합니다.</li>
                    <li>[주의] 사물함을 배정해준 학생은 여전히 신청자 명단에 남습니다. 사물함을 배정한 학생은 '절대로' 삭제하지 않습니다. (이는 시스템에 영향을 줍니다.)</li>
                    <li>[주의] 학생회에서 정한 기준에 맞지 않는 양식을 제출하거나 보증금을 입금하지 않는 학생은 학생에게 사유를 개별적으로 통보 후 삭제해주셔야 합니다.</li>
                </ol>
                <h3>대상자 관리</h3>
                <ol>
                    <li>앞서 사물함 배정을 받은 학생은 대상자 관리 명단에 들어오게 됩니다. (그와 동시에 사용자의 화면에도 사물함이 배정됐다고 뜹니다.)</li>
                    <li>사용자의 사물함 사용이 끝나면 인증 사진을 업로드 하게 됩니다.</li>
                    <li>사진을 제출한 학생은 대상자 관리에서 사진을 확인하실 수 있습니다. 사진을 확인하고 이상이 없으면 보증금을 돌려줍니다.</li>
                    <li>보증금을 돌려주고 반납처리 버튼을 누르시면, 사용자 화면에 사용자에게 보증금 반환 및 반납처리가 완료됐다고 뜹니다.</li>
                    <li>대상자 삭제 시 신청자 관리에서도 삭제됩니다.</li>
                </ol>
                <h3>모든 작업이 끝난 후</h3>
                <ol>
                    <li>대상자 관리 페이지의 대상자 전체 삭제를 누릅니다.</li>
                    <li>대상자 관리 페이지의 신청자 전체 삭제를 누릅니다.(미구현)</li>
                    <li>귀찮으시다면 전체 초기화 버튼을 누릅니다.(미구현)</li>
                </ol>
            </div>

        </div>
    </div>
    </div>
</main>
<%@include file="../../main/footer.jsp"%>
<div id="shadow">
    <div id="blur"></div>
</div>
<!-- modal -->
<div class="modal fade" id="modifyModal" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">사물함 사용가능 여부 변경</h4>
            </div>
            <div class="modal-body" id = "myModalbody">
            </div>
            <div class="modal-body" id = "myModalbody2">
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

    var lockers=<%=locker%>;

    function callSetupTableView(){
        $('#table').bootstrapTable('append',data());
        $('#table').bootstrapTable('refresh');
    }


    function data(){
        var rows = [];
        for(var i=0; i<lockers.length; i++){
            var locker=lockers[i];
            rows.push({
                id:locker.locker_id,
                locker: locker.locker_num,
                type: locker.locker_type,
                available: locker.available,
                location : locker.locker_location,
                del : '<button href="#modifyModal"  data-toggle="modal" type="button" class="btn btn-default btn btn-xs" style = "margin : 1px;" onclick="changeAvailable('+i+')">상태전환</button>'
                // '<button type="button" class="btn btn-default btn btn-xs" style = "margin : 1px;" onclick="deleteLocker('+i+')">사물함삭제</button>' +
            });
        }
        return rows;
    }

    $(document).ready(function(){
        callSetupTableView();
        makeinfo();
    })

    // function deleteLocker(id){ //사물함삭제
    //     var locker =lockers[id];
    //     var check = confirm("["+locker.locker_type+"]"+locker.locker_num+"번 사물함을 삭제 하시겠습니까?");
    //     if(check){
    //         $.ajax({//데이터 전송하는 규격
    //             url : "ajax.do", //AjaxAction에 있는
    //             type : "post",
    //             data : { //case문으로 data전송
    //                 req : "deleteLocker",
    //                 data : lockers[id].locker_num
    //             },
    //             success :function(data){
    //                 alert("삭제되었습니다.");
    //                 window.location.href = 'locker_manager.do?num=117'; //데이터 전송에 성공한 이후에 연결할 url
    //             }
    //         })
    //     }
    // }

    function changeAvailable(id){ //일정 수정하는 경우
        var list = $('#myModalbody');
        var a = '';
        a += '<div class="form-group"><span>변경할 상태 :</span><select style="display : inline-block; width:200px;" class="form-control" name="menutype"><option value="default">선택해주세요</option>';
        a +=   addvalue()+'</div><br>';
        a += '<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>'
        a += '<button type="button" class="btn btn-default pull-right" data-dismiss="modal" aria-label="Close" onclick="modifyAvailable('+id+')">완료</button>';
        list.html(a);
    }
    function addvalue(){ //available 수정할때 사용함
        var a='';
        a+='<option value="사용가능">사용가능</option>';
        a+='<option value="사용불가">사용불가</option>';
        a+='</select>'
        return a;
    }

    function modifyAvailable(id){ //수정할 데이터를 Action으로 보내는 역할 함.
        var locker =lockers[id];
        var val=$('[name=menutype]').val();
        // alert(val);
        // alert(locker.locker_type)
        // alert(locker.locker_num);
        var data=locker.locker_num+"-/-/-"+locker.locker_type+"-/-/-"+val;
        //중간에 -/-/- 으로 표시하는건 데이터의 구분을 주기 위함. (받는쪽에서 저 문장을 기준으로 split 해서 나눠버림.)
        // alert(data); //data가 잘 전송되고 있나 검사하려고 만든건데 없어져야 할듯.
        var check = confirm("["+locker.locker_type+"]"+locker.locker_num+"번 사물함의 상태를 변경하시겠습니까?");
        if(check) {
            $.ajax({ //ajax 프레임워크( jQuery)로 위 data를 서버로 보냄.
                url: "ajax.do", //ajax.do(ajaxAction)에 있는
                type: "post",
                data: {
                    req: "changeAvailable",
                    data: data
                },
                success: function (data) {
                    alert(data + " 상태로 변경이 되었습니다");
                    location.reload();
                }
            })
        }
    }

    function setAllLockerAvailableTrue(){ //수정할 데이터를 Action으로 보내는 역할 함.
        var data="";
        var check = confirm("모든 사물함의 상태를 사용가능으로 변경하시겠습니까?");
        if(check) {
            $.ajax({ //ajax 프레임워크( jQuery)로 위 data를 서버로 보냄.
                url: "ajax.do", //ajax.do(ajaxAction)에 있는
                type: "post",
                data: {
                    req: "setAllLockerAvailableTrue",
                    data: data
                },
                success: function (data) {
                    alert("모든 사물함의 상태를 사용가능으로 변경했습니다");
                    location.reload();
                }
            })
        }
    }

    function makeinfo(){
        var info = <%=info%>;
        var info0 = info[0]; //100
        var info1 = info[1]; //101
        var info2 = info[2]; //102
        var list = $('#info');
        var a = '';
        a+= '은행명: <input type="text" name="bank" id="bank" value="' + info0.content+ '">'
            +'계좌번호: <input type="text" name="account" id="account" placeholder="' + info1.content+'">'
            +'연락처: <input type="text" name="contact" id="contact" placeholder="' + info2.content+'">'
        list.append(a);
    }

    function updateInfo(){
        var bank=$('#bank').val();
        var account=$('#account').val();
        var contact=$('#contact').val();

        var data = bank+"-/-/-"+account+"-/-/-"+contact;
        var check = confirm("학생회 정보를 수정하시겠습니까?");
        if(check) {
            $.ajax({ //ajax 프레임워크( jQuery)로 위 data를 서버로 보냄.
                url: "ajax.do", //ajax.do(ajaxAction)에 있는
                type: "post",
                data: {
                    req: "modifyInfo",
                    data: data
                },
                success: function (data) {
                    alert(data + " 상태로 변경이 되었습니다");
                    location.reload();
                }
            })
        }
    }

</script>
</body>
</html>