<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    StringBuffer url2_locker_apply_main = request.getRequestURL();
    String logo_img_locker_apply_main;

    //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
    //ai이면 ai로고 cs이면 cs로고
    if (url2_locker_apply_main.substring(7, 9).equals("ai") || url2_locker_apply_main.substring(7, 9).equals("lo")) {
        logo_img_locker_apply_main = "img/notice_ai.png";
    } else {
        logo_img_locker_apply_main = "img/notice.png";
    }
    //System.out.println((logo_img_locker_apply_main));
%>
<%
    String num = (String) request.getAttribute("num");
    String tabMenu = (String) request.getAttribute("tabMenu");//관리자탭메뉴
    String info = (String) request.getAttribute("info");
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
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <title>경기대학교 AI컴퓨터공학부</title>
    <link href='./css/default.css' rel='stylesheet' type='text/css'>
    <link href='./css/boardtable.css' rel='stylesheet' type='text/css'>
    <link href='./css/content.css' rel='stylesheet' type='text/css'>
    <link href='css/bootstrap.css' rel='stylesheet' type='text/css'>
    <link href='./css/information.css' rel='stylesheet' type='text/css'>
    <link href='css/progress-bar.css' rel='stylesheet' type='text/css'>
    <link href='css/step-progress-bar.css' rel='stylesheet' type='text/css'>
    <script src="./js/default.js"></script>
    <script src="./js/jquery-3.2.1.min.js"></script>
    <script src="js/step-progress-bar.js"></script>
    <style>
        #circle {
            width: 100px;
            height: 100px;
            background: red;
            -moz-border-radius: 50px;
            -webkit-border-radius: 50px;
            border-radius: 50px;
        }

        table {
            width: 100%;
            margin-top: 40px;
            text-align: center;
        }

        .graduation_info {
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
            width: 250px;
        }

        .profile {
            display: inline-block;
            margin-right: 5px;
            padding-right: 5px;
            width: 80px;
            text-align: center;
        }

        .explain {
            display: inline-block;
            border: 1px solid #607D8B;
            margin-right: 5px;
            padding-right: 5px;
            text-align: left;
            width: 380px;
            height: 120px
        }

        .boardtable > thead > tr > th:nth-child(1), .boardtable > tbody > tr > td:nth-child(1) {
            width: 15%;
            text-align: center;
            min-width: 80px;
        }

        .boardtable > thead > tr > th:nth-child(2), .boardtable > tbody > tr > td:nth-child(2) {
            width: 30%;
            text-align: center;
            min-width: 80px;
        }

        .boardtable > thead > tr > th:nth-child(3), .boardtable > tbody > tr > td:nth-child(3) {
            width: 25%;
            text-align: center;
            min-width: 80px;
        }

        .boardtable > thead > tr > th:nth-child(4), .boardtable > tbody > tr > td:nth-child(4) {
            width: 30%;
            text-align: center;
            min-width: 80px;
        }

        .btn {
            padding: 4px 15px;
            font-size: 12px;
        }

        .complete_M {
            border: 1px solid #ddd;
            position: absolute;
            width: 400px;
            height: 200px;
            margin-top: 50px;
            margin-left: 165px;
            background-color: white;
            z-index: 6;
            display: none;
        }
    </style>

</head>
<body>
<%@include file="../main/header.jsp" %>
<main>
    <div id="content">
        <div id="title">
<%--            <img src=<%=logo_img_locker_apply_main%>/>--%>
            <div>나의 사물함</div>
        </div>
        <div id="container">
            <div id="tab">
                <ul id="tabMenu">
                </ul>
            </div>
            <div id="maincontent">
                <table id="usertable" class="table table-bordered"
                       style="font-size: 13px; border: 2px solid #ddd; margin-bottom: 0;">
                    <tr style="border-bottom: 1px solid #ddd">
                        <td style="background-color: #ECEFF1; font-weight: 600;">학번</td>
                        <td>${user.per_id}</td>
                        <td style="background-color: #ECEFF1; font-weight: 600;">이름</td>
                        <td>${user.name}</td>
                        <td style="background-color: #ECEFF1; font-weight: 600;">소속학과</td>
                        <td>${user.major}</td>
                    </tr>
                </table>

                <div>
                    <!-- 여기에 상태 -->
                    <table class="boardtable" id="statetable">
                        <thead>
<%--						첫줄--%>
                        <tr>
                            <th>단계</th>
                            <th>일정</th>
                            <th>제출</th>
                            <th>비고</th>
                        </tr>
<%--						둘째줄--%>
                        <tr>
                            <td>${request.schedule_name}</td>
                            <td>${request.starting_date_str}~${request.end_date_str}</td>

                            <c:if test="${reqstudent==null}">
                            <td><a href="locker_apply_form.do?per_id=${user.per_id}&num=94&stage=1&modify=0">
                                <button
                                        type="button" class="btn btn-default">신청 하기
                                </button>
                            </a></td>
                            <td>미신청 상태</td>
                        </tr>
                        </c:if>
                        <c:if test="${reqstudent!=null}">
                            <c:if test="${reqstudent.state!='배정완료'&&reqstudent.deposit!='입금완료'}">

                                <td><a href="locker_apply_form.do?per_id=${reqstudent.per_id}&num=94&stage=1&modify=1">
                                    <button
                                            type="button" class="btn btn-default">신청서 보기
                                    </button>
                                </a></td>
                            </c:if>
                            <c:if test="${reqstudent.state=='배정완료'||reqstudent.deposit=='입금완료'}">

                                <td>${reqstudent.locker_num} 신청</td>
                            </c:if>
                            <td>${reqstudent.state}</td>
                            </tr>
<%--							셋째줄--%>
                            <tr>
                                <td>↳</td>
                                <td>보증금 입금</td>
                                <c:if test="${reqstudent.deposit!='입금완료'}">
                                    <td>
                                        <button type="button" class="btn btn-default btn btn-xs" style="margin : 1px;"
                                                onclick="checkMyDeposit(${reqstudent.per_id})">보증금입금 확인요청
                                        </button>
                                    </td>
                                    <td>보증금 입금하고 버튼을 눌러주세요</td>
                                    </tr>
<%--                                    보증금 입금 정보--%>
                                    <tr id="info1"></tr>
<%--                                   학생회 연락처--%>
                                    <tr id="info2"></tr>
                                </c:if>
                                <c:if test="${reqstudent.deposit=='입금완료'}">
                                    <c:if test="${reqstudent.state!='배정완료'}">
                                        <td>관리자확인 후 사물함배정 예정</td>
                                        <td>${reqstudent.deposit}</td>
                                    </c:if>
                                    <c:if test="${reqstudent.state=='배정완료'}">
                                        <td>-</td>
                                        <td>${reqstudent.deposit}</td>
                                    </c:if>
                                    </tr>
                                </c:if>
                        </c:if>

                        <c:if test="${assignedStudent!=null}">
							<%--넷째줄--%>
                            <tr>
                                <td>${using.schedule_name}</td>
                                <td>${using.starting_date_str}~${using.end_date_str}</td>
                                <td>${assignedStudent.locker_num} 배정</td>
                                <td>${assignedStudent.state}</td>
                            </tr>
                            <tr>
                                <td>↳</td>
                                <td>사물함 사용안내</td>
                                <td colspan="2">${assignedStudent.locker_num} 사물함에 들어있는 열쇠를 사용하시면 됩니다.</td>
                            </tr>
<%--							다섯째줄--%>
                            <tr>
                                <td>${returning.schedule_name}</td>
                                <td>${returning.starting_date_str}~${returning.end_date_str}</td>
                                <c:if test="${(assignedStudent.img_front!='사진제출완료'||assignedStudent.img_inside!='사진제출완료')&&assignedStudent.state!='반납완료'}">
                                    <td>
                                        <c:if test="${assignedStudent.img_inside!='사진제출완료'}">
                                            <a href="locker_return.do?per_id=${assignedStudent.per_id}&num=94&stage=1&modify=1">
                                            <button type="button" class="btn btn-default">반납사진 제출 (사물함 내부)</button>
                                            </a>
                                        </c:if>
                                        <c:if test="${assignedStudent.img_front!='사진제출완료'}">
                                        <a href="locker_return2.do?per_id=${assignedStudent.per_id}&num=94&stage=1&modify=1">
                                            <button type="button" class="btn btn-default">반납사진 제출 (사물함 외부)</button>
                                        </a>
                                        </c:if>
                                    </td>
                                </c:if>
                                <c:if test="${(assignedStudent.img_front=='사진제출완료'&&assignedStudent.img_inside=='사진제출완료')||assignedStudent.state=='반납완료'}">
                                    <td>반납요청 완료</td>
                                </c:if>
                                <td>${assignedStudent.deposit}</td>
                            </tr>
                            <tr>
                                <td>↳</td>
                                <td>사물함 반납안내</td>
                                <td colspan="2">비운 사물함에 열쇠를 넣고 찍은 인증사진을 업로드 해주세요.</td>
                            </tr>
                        </c:if>
<%--                            여섯째줄--%>
<c:if test="${assignedStudent.state=='반납완료'}">
    <tr>
        <td>↳</td>
        <td>-</td>
        <td>-</td>
        <td>반납완료</td>
    </tr>
</c:if>

                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>
</main>
<%@include file="../main/footer.jsp" %>
<div id="shadow">
    <div id="blur"></div>
</div>
<script>
    $(document).ready(function(){
        makeinfo1();
        makeinfo2();
    })

    var list = $('#tabMenu');
    var title = $('#title2');

    var tabmenu = <%=tabMenu%>;
    var number =<%=num%>;
    for (var i = 0; i < tabmenu.length; ++i) {
        var value = tabmenu[i];
        var num = value.tab_id * 10 + value.orderNum;
        var text = '<li><span class="deco_dot">●</span><a href="' + value.path + '?num=' + num + '">' + value.page_title + '</a></li>'
        list.append(text);
        if (number == num) {
            title.append(value.page_title);
        }
    }

    function checkMyDeposit(id) { //사물함 배정
        var check = confirm("[중요] 정말로 보증금을 입금 하셨나요? 취소하실 수 없습니다. 확인버튼 누를 시 사물함 수정 불가합니다.");
        if (check) {
            $.ajax({
                url: "ajax.do", //AjaxAction
                type: "post",
                data: {
                    req: "checkMyDeposit",
                    data: id
                },
                success: function (data) {
                    alert("관리자에게 입금 확인 요청하였습니다.");
                    window.location.href = 'locker_apply.do?num=112';
                }
            })
        }
    }
    function makeinfo1(){
        var info = <%=info%>;
        var info0 = info[0]; //100
        var info1 = info[1]; //101
        var list = $('#info1');
        var a = '';
        a+= '<td>↳</td>'
            +'<td>입금계좌</td>'
            +'<td colspan="2">['+info0.content+'] '+info1.content+'</td>'
        list.append(a);
    }
    function makeinfo2(){
        var info = <%=info%>;
        var info2 = info[2]; //102
        var list = $('#info2');
        var a = '';
        a+= '<td>↳</td>'
            +'<td>문의사항</td>'
            +'<td colspan="2">'+info2.content+'</td>'
        list.append(a);
    }

</script>
</body>
</html>