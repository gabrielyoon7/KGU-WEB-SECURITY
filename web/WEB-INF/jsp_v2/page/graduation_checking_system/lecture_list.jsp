<%--
  Created by IntelliJ IDEA.
  User: YOON
  Date: 2021-11-11
  Time: 오후 5:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="mt-4">
    <table class="lecTable" id="lecture_table" data-toggle="table"
           data-pagination="true" data-toolbar="#toolbar"
           data-search="true" data-side-pagination="true" data-click-to-select="true"
           data-page-list="[20]">
        <thead>
        <tr>
            <th data-field="check" data-checkbox="true"></th>
            <th data-field="action">-</th>
            <th data-field="id" data-sortable="true">id</th>
            <th data-field="year" data-sortable="true">연도</th>
            <th data-field="semester" data-sortable="true">학기</th>
            <th data-field="grade" data-sortable="true">학년</th>
            <th data-field="lecture_id" data-sortable="true">학수코드</th>
            <th data-field="big_type" data-sortable="true">교양/전공</th>
            <th data-field="small_type" data-sortable="true">이수구분</th>
            <th data-field="major" data-sortable="true">전공</th>
            <th data-field="credit" data-sortable="true">학점</th>
            <th data-field="design_credit" data-sortable="true">설계점수</th>
            <th data-field="name" data-sortable="true">과목명</th>
            <%--            <th data-field="lecture_history" data-sortable="true">lecture_history</th>--%>
        </tr>
        </thead>
    </table>
</div>

<script>
    //얘를 include 하려는 애는 반드시 getLecture를 setAttribute 해줘야 함!
    let allLectures = <%=getLecture%>;
    $(document).ready(function(){
        callSetupLectureTableView();
    })
    function callSetupLectureTableView(){
        $('#lecture_table').bootstrapTable('append',lectureData());
        $('#lecture_table').bootstrapTable('refresh');
    }



    function lectureData(){
        var rows = [];
        if(allLectures!=null){
            for(var i=0; i<allLectures.length; i++){
                var lecture=allLectures[i];
                rows.push({
                    action : '<a href="#modifyModal" id="modifybtn" data-toggle="modal" class="btn btn-default btn-sm" onclick="modifylecture('+i+')">수정</a>',
                    id: lecture.id,
                    year: lecture.year,
                    semester : lecture.semester,
                    grade : lecture.grade,
                    lecture_id : lecture.lecture_id,
                    big_type : lecture.big_type,
                    small_type : lecture.small_type,
                    major : lecture.major,
                    credit : lecture.credit,
                    design_credit : lecture.design_credit,
                    name : lecture.name
                });
            }
        }
        return rows;
    }
</script>

<style>
    table:not([class]) td {
        border: 1px solid grey;
    }

    .lecTable {
        align-content: center;
        margin: 0;
        border-collapse: collapse;
        font-size: 13px;
    }

    .lecTable td {
        padding-top:4px;
        padding-bottom:4px;
        min-width: 30px;
        text-align: center;
        border-bottom: 1px solid gainsboro;
    }
    .lecTable > thead > tr > th {
        text-align: center;
    }

    .lecTable > tbody > tr > td {
        vertical-align: middle;
    }

    .lecTable > thead > tr > th:nth-child(1), .lecTable > tbody > tr > td:nth-child(1) {
        width: 36px;
        min-width: 30px;
    }

    .lecTable > thead > tr > th:nth-child(2), .lecTable > tbody > tr > td:nth-child(2) {
        width: 66px;
        min-width: 66px;
    }

    .lecTable > thead > tr > th:nth-child(3), .lecTable > tbody > tr > td:nth-child(3) {
        width: 40px;
    }

    .lecTable > thead > tr > th:nth-child(4), .lecTable > tbody > tr > th:nth-child(4) {
        width: 50px;
        min-width: 30px;
    }

    .lecTable > thead > tr > th:nth-child(5), .lecTable > tbody > tr > td:nth-child(5) {
        width: 45px;
        min-width: 30px;
    }

    .lecTable > thead > tr > th:nth-child(6), .lecTable > tbody > tr > th:nth-child(6) {
        width: 45px;
        min-width: 30px;
    }

    .lecTable > thead > tr > th:nth-child(7), .lecTable > tbody > tr > th:nth-child(7) {
        width: 75px;
        min-width: 30px;
    }

    .lecTable > thead > tr > th:nth-child(8), .lecTable > tbody > tr > td:nth-child(8) {
        width: 50px;
        min-width: 50px;
    }

    .lecTable > thead > tr > th:nth-child(9), .lecTable > tbody > tr > th:nth-child(9) {
        width: 50px;
        min-width: 30px;
    }

    .lecTable > thead > tr > th:nth-child(10), .lecTable > tbody > tr > th:nth-child(10) {
        width: 95px;
        min-width: 50px;
    }

    .lecTable > thead > tr > th:nth-child(11), .lecTable > tbody > tr > th:nth-child(11) {
        width: 45px;
        min-width: 30px;
    }

    .lecTable > thead > tr > th:nth-child(12), .lecTable > tbody > tr > th:nth-child(12) {
        width: 45px;
        min-width: 30px;
    }

    .lecTable > thead > tr > th:nth-child(13), .lecTable > tbody > tr > th:nth-child(13) {
        width: 108px;
        min-width: 100px;
    }

    .lecTable th {
        margin: 0;
        border-bottom: 1px solid #607D8B;
        border-top: 2px solid #607D8B;
        background-color: #ECEFF1;
    }
</style>