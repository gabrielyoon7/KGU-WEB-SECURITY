<%--
  Created by IntelliJ IDEA.
  User: Gabriel Yoon
  Date: 2021-03-04
  Time: 오후 5:22
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
    String strReferer = request.getHeader("referer"); //이전 URL 가져오기
    if(strReferer == null){ //브라우저 URL 입력창에 URL 입력 호출 했을 때 null이 됨
%>
<script language="javascript">
    alert("URL 주소로 직접 접근하셨습니다.\n정상적인 경로를 통해 다시 접근해 주세요.");
    document.location.href="locker_main.jsp"; //경로로 이동하게 함
</script>
<%
        return;
    }
%>

<%
    StringBuffer url2_locker_apply_form = request.getRequestURL();
    String logo_img_locker_apply_form;

    //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
    //ai이면 ai로고 cs이면 cs로고
    if(url2_locker_apply_form.substring(7,9).equals("ai") || url2_locker_apply_form.substring(7,9).equals("lo")){
        logo_img_locker_apply_form = "img/graduation_ai.png";
    }
    else{
        logo_img_locker_apply_form = "img/graduation.png";
    }
    //System.out.println((logo_img_locker_apply_form));
%>
<%
    String num = (String) request.getAttribute("num");
    String stage_data = (String) request.getAttribute("stage_data");
    String tabmenulist = (String) request.getAttribute("tabMenu");
//    String grduser = (String) request.getAttribute("grduser");
//    String subDBuser = (String) request.getAttribute("graduationuser");
    String modify = (String) request.getAttribute("modify");
//    String proflist = (String) request.getAttribute("proflist");
//    String schedulelist= (String) request.getAttribute("schedulelist");
    String reqstudent = (String) request.getAttribute("reqstudent");
    String lockerList1 = (String) request.getAttribute("lockerList1");
    String lockerList2 = (String) request.getAttribute("lockerList2");
    String lockerList3 = (String) request.getAttribute("lockerList3");
    String lockerList4 = (String) request.getAttribute("lockerList4");
    String lockerList5 = (String) request.getAttribute("lockerList5");
    String lockerList6 = (String) request.getAttribute("lockerList6");
    String lockerList7 = (String) request.getAttribute("lockerList7");

%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta name="subject"
          content="Kyonggi University Department of Computer Science">
    <meta name="author" content="Kyonggi Univ. SSF">
    <meta name="keyword"
          content="경기대학교, 컴퓨터과학과, Kyonggi University, Computer Science">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="utf-8">
    <title>경기대학교 AI컴퓨터공학부</title>
    <link href='./css/default.css' rel='stylesheet' type='text/css'>
    <link href='./css/boardtable.css' rel='stylesheet' type='text/css'>
    <link href='./css/content.css' rel='stylesheet' type='text/css'>
    <link href='css/bootstrap.css' rel='stylesheet' type='text/css'>
    <link href='./css/information.css' rel='stylesheet' type='text/css'>
    <style>
        table {
            margin-top: 40px;
        }

        .graduation_write_info {
            padding: 5px;
            border: 1px solid #607D8B;
            font-size: 13px;
            display: flex;
            width: 748px;
            margin: auto;
            margin-bottom: 10px;
        }

        .graduation_read_info {
            padding: 5px;
            border: 1px solid #607D8B;
            font-size: 13px;
            display: flex;
            width: 748px;
            margin: auto;
            margin-bottom: 10px;
        }

        .inform {
            display: inline-block;
            text-align: center;
            width: 200px;
        }

        .profile {
            font-weight: bold;
            display: inline-block;
            margin-right: 5px;
            padding-right: 5px;
            width: 70px;
            text-align: center;
        }

        .explain {
            display: inline-block;
            border: 1px solid #607D8B;
            margin-right: 5px;
            padding-right: 5px;
            text-align: left;
            width: 440px;
            height: 220px
        }
        .locker {
            width: 100px;
            height: 30px;
            display: inline-block;
        }

        .clicked {
            background-color: #2a6496;
            color: white;
        }

        .used {
            background-color: #222222;
            color: white;
        }

        .unavailable {
            background-color: red;
            color: white;
        }

        .locker-wrapper-1, .locker-wrapper-2, .locker-wrapper-3, .locker-wrapper-4,.locker-wrapper-5, .locker-wrapper-6, .locker-wrapper-7{
            display:inline-block;
        }
    </style>
</head>
<body>
<script src="./js/jquery-3.2.1.min.js"></script>
<script src="./js/bootstrap.min.js"></script>
<script src="./js/default.js"></script>
<%--<script src="./js/lockerSelect.js"></script>--%>
<%@include file="../../main/header.jsp"%>
<main>
    <div id="content">
        <div id="title">
            <img src=<%=logo_img_locker_apply_form%> />
            <div>사물함 신청 하기</div>
        </div>
        <div id="container">
            <div id="tab">
                <ul id="tab_2">
                </ul>
            </div>
            <div id="maincontent">
                <ul>
                    <li>
                        <div class="contenttitle">신청서 제출</div>
                    </li>
                </ul>
                <div>
                    <div class="graduation_write_info">
                        <div col-md-6>
                            <!-- 학생정보 div -->
                            <div class="contenttitle2">학생정보</div>
                            <ul id="student_data"></ul>
                        </div>
                        <div col-md-6>
                            <!-- 학생정보 div -->
                            <div class="contenttitle2">안내사항</div>
                            <ul>
                                <div>
                           <textarea id="schedule" class="explain" readonly>
* 사물함 신청 시스템은 선착순으로 운영되고 있습니다.
* 좌측에 개인정보를 정확하게 입력해주시고, 사물함은 하단에서 버튼을 눌러 선택해주세요.
* 아래 사물함은 페이지를 띄운 시점에서의 상태입니다.
* 아래서 사물함을 선택이 가능하다고 나오더라도 누군가 해당 자리에 먼저 신청을 하게 되면 신청 거부 처리됩니다.
* 신청을 처리하는 순서는 하단에 있는 신청 혹은 수정 버튼을 누른 순서대로 처리됩니다. 신청에 성공하시면 '나의 사물함'에 보증금을 입금할 수 있는 안내가 나옵니다.
* 학우님의 개인정보는 절대 유출되지 않으며, 사물함 대여기간이 종료되면 삭제하겠습니다.
                           </textarea>
                                </div>
                                <input type="checkbox" id="checkbox1" name="agreement" VALUE="agree" /> 위 안내문을 확인 했고 동의합니다.
                            </ul>
                        </div>

                    </div>
                    <div class="contenttitle2">아래에서 사물함을 선택하세요.</div>
                    <div class="graduation_write_info">
                        <div class="col-md-6">
                            <div class="contenttitle2">위치 1</div>
                            <div class="locker-wrapper-1"></div>
                            <div class="contenttitle2">위치 2</div>
                            <div class="locker-wrapper-2"></div>
                            <div class="contenttitle2">위치 3</div>
                            <div class="locker-wrapper-3"></div>
                            <div class="contenttitle2">위치 4</div>
                            <div class="locker-wrapper-4"></div>
                        </div>
                        <div class="col-md-6">
                            <div class="contenttitle2">위치 5</div>
                            <div class="locker-wrapper-5"></div>
                            <div class="contenttitle2">위치 6</div>
                            <div class="locker-wrapper-6"></div>
                            <div class="contenttitle2">위치 7</div>
                            <div class="locker-wrapper-7"></div>
                        </div>
<%--                        <script>init()</script>--%>
                    </div>

                    <div>
                        <div class="col-md-9"></div>
                        <div id="button_area" class="text-right">
                            <!-- java script -->
                        </div>
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
<div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">신청접수 승인</h4>
            </div>
            <div id="howmany2"></div>
            <div class="modal-body" id="myModalbody2">
                <!-- java script -->
            </div>
            <div class="modal-footer" id="footer2"></div>
        </div>
    </div>
</div>
<div>
</div>
<script>
    $(document).ready(function() {//바로시작하는 function

        set_student_Data();
        button_change();
        Locker(1, ".locker-wrapper-1");
        Locker(2, ".locker-wrapper-2");
        Locker(3, ".locker-wrapper-3");
        Locker(4, ".locker-wrapper-4");
        Locker(5, ".locker-wrapper-5");
        Locker(6, ".locker-wrapper-6");
        Locker(7, ".locker-wrapper-7");

    })
    var list = $('#tab_2');
    var tabmenu =<%=tabmenulist%>;
    var number =<%=num%>;
    var agreement;
    if ($('input[name=agreement]').is(":checked")) {
        agreement=true;
    }
    for (var i = 0; i < tabmenu.length; ++i) {// tabmenu설정
        var value = tabmenu[i];
        var num = value.tab_id * 10 + value.orderNum;
        var text = '<li><span class="deco_dot">●</span><a href="'
            + value.path + '?num=' + num + '">' + value.page_title
            + '</a></li>'
        list.append(text);
    }


    function set_student_Data(){//학생정보 조건문에따라 설정
        var reqstudent = <%=reqstudent%>
        var user = <%=user%>
        var list = $('#student_data');
        var a='';
        if((user.type.includes("관리자"))){

        }
        else {
            if(reqstudent!=null){
                // alert("신청 수정");
                a+='<li><div class="profile">학번</div><div class="inform"><input type="text" name="per_id" placeholder="학번을 입력해주세요" value="'+reqstudent.per_id+' "readonly/></div></li>'
                    +'<li><div class="profile">이름</div><div class="inform"><input type="text" name="name" placeholder="이름을 입력해주세요" value="'+reqstudent.name+'" readonly/></div></li>'
                    +'<li><div class="profile">학과</div><div class="inform"><input type="text" name="major" placeholder="학과를 입력해주세요" value="'+reqstudent.major+'" readonly/></div></li>'
                    +'<li><div class="profile">연락처</div><div class="inform"><input type="text" id="phoneNum" name="phoneNum" placeholder="연락처를 입력해주세요" value="'+reqstudent.phoneNum+'" /></div></li>'
                    +'<li><div class="profile">은행명</div><div class="inform"><input type="text" id="bank" name="bank" placeholder="은행명을 입력해주세요" value="'+reqstudent.bank+'" /></div></li>'
                    +'<li><div class="profile">계좌번호</div><div class="inform"><input type="text" id="accountNum" name="accountNum" placeholder="계좌번호를 입력해주세요" value="'+reqstudent.accountNum+'" /></div></li>'
                    +'<li><div class="profile">사물함</div><div class="inform"><input type="text" id="lockerNum" name="lockerNum" placeholder="아래서 사물함을 선택하세요." value="'+reqstudent.locker_num+'" readonly/></div></li>'

            }

            else {
                // alert("신규 등록");
                a+='<li><div class="profile">학번</div><div class="inform"><input type="text" name="per_id" placeholder="학번을 입력해주세요" value="'+user.per_id+' "readonly/></div></li>'
                    +'<li><div class="profile">이름</div><div class="inform"><input type="text" name="name" placeholder="이름을 입력해주세요" value="'+user.name+'" readonly/></div></li>'
                    +'<li><div class="profile">학과</div><div class="inform"><input type="text" name="major" placeholder="학과를 입력해주세요" value="'+user.major+'" readonly/></div></li>'
                    +'<li><div class="profile">연락처</div><div class="inform"><input type="text" id="phoneNum" name="phoneNum" placeholder="연락처를 입력해주세요" /></div></li>'
                    +'<li><div class="profile">은행명</div><div class="inform"><input type="text" id="bank" name="bank" placeholder="은행명을 입력해주세요" /></div></li>'
                    +'<li><div class="profile">계좌번호</div><div class="inform"><input type="text" id="accountNum" name="accountNum" placeholder="계좌번호를 입력해주세요" /></div></li>'
                    +'<li><div class="profile">사물함</div><div class="inform"><input type="text" id="lockerNum" name="lockerNum" placeholder="아래서 사물함을 선택하세요." readonly/></div></li>'
            }

        }
        list.prepend(a);
    }
    function selectedbox(){//설정된 checkbox 값 받아넘기기
        var checked_etc='';
        var etc = document.getElementsByName("etc");//체크박스들 이름
        if ($('input[name=agreement]').is(":checked")) {
            //check이름을 가진 check중에서 체크된 것만 값 가져오기
            var size = document.getElementsByName("etc").length;
            for(var i = 0; i < size; i++){
                if(document.getElementsByName("etc")[i].checked == true){
                    if(i==4){
                        checked_etc+=($('input[name=etc4_text]').val());
                        checked_etc+="(기타)/";
                    }
                    else{
                        checked_etc+=(document.getElementsByName("etc")[i].value);
                        checked_etc+="/";
                    }
                }
            }
        }else{
            alert("약관 동의를 체크해주세요!");
            return 0;
        }

        return checked_etc;
    }


    function submit_apply(){//신청서 접수하는 function
        var check = 1
        var date = $('#Inputdate').val();
        var lockerNum = $('#lockerNum').val();
        var user = <%=user%>
        var phoneNum = $('#phoneNum').val();
        var bank = $('#bank').val();
        var accountNum = $('#accountNum').val();
        var answer = user.per_id+"-/-/-"+user.name+"-/-/-"+date+"-/-/-"+check+"-/-/-"+lockerNum+"-/-/-"+phoneNum+"-/-/-"+bank+"-/-/-"+accountNum+"-/-/-"+user.major;
        // alert(answer);
        if(check!=0){
            $.ajax({
                url:"ajax.do",
                type:"post",
                data : {
                    req : "submit_apply",
                    data : answer
                },
                success : function(data){
                    if(data=="부정신청"){
                        alert("부정된 방법으로 신청을 시도하였습니다. 해당 로그는 관리자에게 통보됩니다.");
                        window.location.href="locker_apply.do?num=112"
                    }
                    else if (data=="중복신청"){
                        alert("해당 사물함은 사용중 입니다. 다시 신청해주세요.");
                        window.location.href="locker_apply_form.do?per_id="+user.per_id+"&num=94&stage=1&modify=0"
                    }
                    else if(data=="신청성공"){
                        alert("신청서 접수 완료!");
                        window.location.href="locker_apply.do?num=112"
                    }
                }

            })}
    }
    function submit_update_apply(){//신청서-update(수정)하는 function
//        var check = selectedbox();
        var check = 1;
        var date = $('#Inputdate').val();
        var lockerNum = $('#lockerNum').val();
        var user = <%=user%>
        var beforeData = <%=reqstudent%>;
        var phoneNum = $('#phoneNum').val();
        var bank = $('#bank').val();
        var accountNum = $('#accountNum').val();
        var answer = user.per_id+"-/-/-"+user.name+"-/-/-"+date+"-/-/-"+check+"-/-/-"+lockerNum+"-/-/-"+phoneNum+"-/-/-"+bank+"-/-/-"+accountNum+"-/-/-"+user.major+"-/-/-"+beforeData.locker_num;
        if(check!=0){
            $.ajax({
                url:"ajax.do",
                type:"post",
                data : {
                    req : "submit_update_apply",
                    data : answer
                },
                success : function(data){
                    if (data=="중복신청"){
                        alert("해당 사물함은 사용중 입니다. 다시 신청해주세요.");
                        window.location.href="locker_apply_form.do?per_id="+user.per_id+"&num=94&stage=1&modify=1"
                    }
                    else if(data=="신청성공"){
                        alert("신청서 수정 완료!");
                        window.location.href="locker_apply.do?num=112"
                    }
                }

            })}
    }
    function button_change(){//버튼 조건문통해 설정 후 생성
        var log = <%=stage_data%>
        var button_area = $('#button_area');
        var user = <%=user%>
        var modify = <%=modify%>
        var a='';

        if(modify==1){
            a+='<a href="javascript:history.go(-1)"><button type="button" style = "margin : 2px;" class="btn btn-default">뒤로</button></a>'
                +'<button onclick="submit_update_apply()" type="button" style="margin: 2px;" class="btn btn-default">수정</button>'
        }
        else{
            a+='<a href="javascript:history.go(-1)"><button type="button" style = "margin : 2px;" class="btn btn-default">뒤로</button></a>'
                +'<button onclick="submit_apply()" type="button" style="margin: 2px;" class="btn btn-default">신청</button>'
        }

        button_area.append(a);
    }

    var lockerList1 = <%=lockerList1%>;
    var lockerList2 = <%=lockerList2%>;
    var lockerList3 = <%=lockerList3%>;
    var lockerList4 = <%=lockerList4%>;
    var lockerList5 = <%=lockerList5%>;
    var lockerList6 = <%=lockerList6%>;
    var lockerList7 = <%=lockerList7%>;

    function Locker(location, lockerWrapClass) {
        let selectLocker = new Array();
        const lockerWrapper = document.querySelector(lockerWrapClass);
        let clicked = "";
        let div = "";
        //받은 location 값에 따라 lockerList 변수를 다르게 정해줌. 여기서부터 lockerList는 location번째 위치의 사물함을 의미함!
        if (location==1){var lockerList=lockerList1;}
        if (location==2){var lockerList=lockerList2;}
        if (location==3){var lockerList=lockerList3;}
        if (location==4){var lockerList=lockerList4;}
        if (location==5){var lockerList=lockerList5;}
        if (location==6){var lockerList=lockerList6;}
        if (location==7){var lockerList=lockerList7;}
        var index=0; //index는 lockerList를 탐색하는데 사용됨.
        var row=lockerList[0].locker_row; //row변수를 만들어서 기존의 mapping 함수들을 삭제하고 중복 코드도 삭제해버림.
        for (let i = 0; i < lockerList.length/row; i++) {
            //선애가 구현한 방식을 최대한 살리기 위해 반복해서 쌓는 구조로 구현함. 대신 전체갯수/가로열 만큼 반복하게 해서 열에 따라 크기가 자동으로 조절되게 처리함.
            div = document.createElement("div");
            lockerWrapper.append(div);
            for (let j = 0; j < row; j++) {
                var lockerData=lockerList[index]; //lockerData는 index를 이용해여 데이터 1줄만 불러오게 한다.
                const input = document.createElement('input');
                input.type = "button";
                input.name = "lockers"
                input.classList = "locker";
                input.value = "["+lockerData.locker_type+"] "+lockerData.locker_num+"번";
                index+=1; //다음 데이터 사용을 위해 index 1 증가
                div.append(input);
                if(lockerData.available=='사용가능'){
                    input.addEventListener('click', function(e) {
                        console.log(e.target.value);
                        selectLocker = selectLocker.filter((element, index) => selectLocker.indexOf(element) != index);
                        if (input.classList.contains("clicked")) {
                            input.classList.remove("clicked");
                            clicked = document.querySelectorAll(".clicked");
                            selectLocker.splice(selectLocker.indexOf(e.target.value), 1);
                            clicked.forEach((data) => {
                                selectLocker.push(data.value);
                            });
                        } else {
                            clicked = document.querySelectorAll(".clicked"); //clicked를 모두 선택
                            clicked.forEach((data) => { //기존에 눌린 버튼 다 지워버리기
                                data.classList.remove("clicked");
                            })
                            input.classList.add("clicked"); //이번에 누른 버튼 추가
                            clicked = document.querySelectorAll(".clicked");
                            clicked.forEach((data) => {
                                selectLocker.push(data.value);
                            })
                        }
                        console.log(selectLocker);
                        var text = input.value;
                        $('#lockerNum').val(text);
                        alert(text+"을 선택하셨습니다.");
                    })
                }
                else if(lockerData.available=='사용중'){
                    input.classList.add("used");
                }
                else{
                    input.classList.add("unavailable");
                }
            }
        }
    };

    window.history.forward();

    function noBack() {

        window.history.forward();

    }

</script>
</body>
</html>