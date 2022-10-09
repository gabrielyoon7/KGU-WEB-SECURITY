<%--
  Created by IntelliJ IDEA.
  User: YOON
  Date: 2021-09-05
  Time: 오전 1:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String getAllStudent = (String) request.getAttribute("getAllStudent");
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
<div class="py-5">
    <div class="alert alert-success" role="alert">
        <h4 class="alert-heading">기능 소개</h4>
        <p>이 시스템을 사용하는 학생들의 데이터를 모아놓는 곳 입니다.</p>
        <hr>
        <p class="mb-0">
            ※ 전화 상담 시 같은 화면을 보면서 상담이 가능할 것입니다.<br>
            ※ 이 기능을 통해 학생 데이터에 오류가 있는지 검토가 가능합니다.
        </p>
    </div>
    <table class="boardtable" id="student_table" data-toggle="table"
           data-pagination="true" data-toolbar="#toolbar"
           data-search="true" data-side-pagination="true" data-click-to-select="true"
           data-page-list="[10]">
        <thead>
        <tr>
            <th data-field="option"></th>
            <th data-field="per_id" data-sortable="true" data-formatter="LinkFormatter">학번</th>
            <th data-field="name" data-sortable="true">이름</th>
            <th data-field="phone" data-sortable="true">연락처</th>
            <th data-field="grade" data-sortable="true">학년</th>
            <th data-field="major" data-sortable="true">전공</th>
<%--            <th data-field="lecture_history" data-sortable="true">lecture_history</th>--%>
        </tr>
        </thead>
    </table>
</div>


<script>
    var allStudent = <%=getAllStudent%>
    $(document).ready(function(){
        callSetupTableView();
    })
    function callSetupTableView(){
        $('#student_table').bootstrapTable('append',data());
        $('#student_table').bootstrapTable('refresh');
    }
    function data(){
        var rows = [];
        if(allStudent!=null){
            for(var i=0; i<allStudent.length; i++){
                var student=allStudent[i];
                if(student.name != "홈피관리자"){
                    rows.push({
                        option : '<button id="deletebtn" class="btn btn-danger" onclick="deleteData('+student.per_id+')">삭제</button>',
                        per_id: student.per_id,
                        name: student.name,
                        phone : student.phone,
                        grade : student.grade,
                        major : student.major
                    });
                }
            }
        }
        return rows;
    }
    function LinkFormatter(value) {
        return "<a href='/webp/graduation_checking_system.kgu?num=121&id="+value+"'>"+value+"</a>";
    }
    function deleteData(id){
        var check = confirm("해당 학생의 정보를 삭제하시겠습니까?");
        if(check) {
            $.ajax({
                url: "ajax.kgu", //AjaxAction에서
                type: "post", //post 방식으로
                data: {
                    req: "deleteStudent", //이 메소드를 찾아서
                    data: id //이 데이터를 파라미터로 넘겨줍니다.
                },
                success: function (data) { //성공 시
                    if(data=='success'){
                        alert('학생 정보가 삭제되었습니다.')
                        location.reload();
                    }
                }
            })
        }
    }
</script>


<style>
    #maincontent {
        padding: 0;
    }
    #maincontent>ul {
        padding: 10px;
    }
    .boardtable > thead > tr > th:nth-child(1) {
        min-width: 20px;
    }
    .boardtable > tbody > tr > td:nth-child(1) {
        min-width: 25px;
    }
    .boardtable > thead > tr > th:nth-child(2) {
        min-width: 20px;
        text-align: center;
    }
    .boardtable > tbody > tr > td:nth-child(2) {
        min-width: 40px;
    }
    .boardtable > thead > tr > th:nth-child(3) {
        min-width: 20px;
        text-align: center;
    }
    .boardtable > tbody > tr > td:nth-child(3) {
        min-width: 40px;
    }
    .boardtable > thead > tr > th:nth-child(4) {
        text-align: center;
        min-width: 40px;
    }
    .boardtable > tbody > tr > td:nth-child(4) {
        text-align: center;
        min-width: 25px;
    }
    .boardtable > thead > tr > th:nth-child(5) {
        text-align: center;
        min-width: 50px;
    }
    .boardtable > tbody > tr > td:nth-child(5) {
        text-align: center;
        min-width: 30px;
    }
    .boardtable > thead > tr > th:nth-child(6) {
        text-align: center;
        min-width: 50px;
    }
    .boardtable > tbody > tr > td:nth-child(6) {
        text-align: center;
        min-width: 30px;
    }
    .fixed-table-loading{
        display: none;
    }
</style>