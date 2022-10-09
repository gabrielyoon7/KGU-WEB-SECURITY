<%--
  Created by IntelliJ IDEA.
  User: YOON
  Date: 2021-11-16
  Time: 오전 9:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String getSpecialLecture2 = (String) request.getAttribute("getSpecialLecture");  //이름 바꾸지 마 세 요
    String getLectureByCode2 = (String) request.getAttribute("getLectureByCode");  //이름 바꾸지 마 세 요
%>
<table class="boardtable" id="specialLectureTable" data-toggle="table"
       data-pagination="true" data-toolbar="#toolbar"
       data-search="true" data-side-pagination="true"
       data-page-list="[20]">
    <thead>
    <tr>
        <th data-field="action" data-sortable="true">설정</th>
        <th data-field="year" data-sortable="true">학번</th>
        <th data-field="major" data-sortable="true">전공</th>
        <th data-field="type" data-sortable="true">타입</th>
        <th data-field="lecture_id" data-sortable="true">과목ID</th>
    </tr>
    </thead>
</table>

<script>
    let getSpecialLecture2 =<%=getSpecialLecture2%>; //이름 바꾸지 마 세 요
    let getLectureByCode2 = <%=getLectureByCode2%>; //이름 바꾸지 마 세 요
    let typeArr = [
        {type:"MSC", name:"MSC"},
        {type:"BSM", name:"BSM"},
        {type:"software_science", name:"트랙(소프트웨어과학)"},
        {type:"intelligence_information", name:"트랙(지능정보)"},
        {type:"iot_embedded", name:"트랙(IoT임베디드)"},
        {type:"blockchain_security", name:"트랙(블록체인보안)"},
        {type:"major_essential", name:"전공필수"},
        {type:"major_selective", name:"선택필수"},
        {type:"jin_seong_ae", name:"진성애"},
        {type:"special_elective", name:"전문교양"},
        {type:"essential", name:"필수과목"}
    ];

    $(document).ready(function(){
        callSetupSpecialLectureTableView();
    })
    function callSetupSpecialLectureTableView() {
        $('#specialLectureTable').bootstrapTable('append', specialLectureData());
        $('#specialLectureTable').bootstrapTable('refresh');
    }

    function specialLectureData() {
        var rows = [];
        if(getSpecialLecture2!=null){
            for (let i = 0; i < getSpecialLecture2.length; i++) {
                let specialLecture = getSpecialLecture2[i];
                let lecture_id = "";
                let lecture_type = "";
                getLectureByCode2.forEach(function (lecture) {
                    if(lecture.lecture_id == specialLecture.lecture_id){
                        lecture_id = lecture.name + "(" +lecture.lecture_id + ")"
                    }
                });
                typeArr.forEach(function (type) {
                    if(type.type == specialLecture.type){
                        lecture_type = type.name;
                    }
                })
                rows.push({
                    action : '',
                    year: specialLecture.year,
                    major: specialLecture.major,
                    type: lecture_type,
                    lecture_id: lecture_id
                });
            }
        }
        return rows;
    }
</script>