<%--
  Created by IntelliJ IDEA.
  User: YOON
  Date: 2021-09-05
  Time: 오전 1:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String getLecture = (String) request.getAttribute("getLecture");
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
<div id="container">
    <%@include file="lecture_list.jsp"%>
    <div class="d-flex justify-content-between">
        <a href="#myModal2" data-toggle="modal" class="btn btn-success lecBtn" id="directaddLecture">강좌 수동추가</a>
        <a onclick="deleteselectlecture()" class="btn btn-danger lecBtn" id="checkdelete">선택한 강좌 삭제</a>
    </div>

    <hr>

    <div class="">
        <h3><b>강좌 일괄 관리 기능</b></h3>
        <p>1. 학과 강좌 엑셀을 다운로드합니다.</p>
        <a href="excel.kgu?writeorread=write" class="btn btn-primary lecBtn" id="exceldownbtn">엑셀 다운로드</a>
        <p>2. 다운로드 받은 엑셀 파일을 직접 수정합니다.</p>
        <p>3. 모든 강좌를 삭제합니다.</p>
        <a onclick="deletealllecture()" class="btn btn-danger lecBtn" id="alldelete">강좌 전체 삭제</a>
        <p>4. 수정된 엑셀 파일을 업로드합니다. (업로드 시 약간의 처리 시간이 필요합니다.)</p>
        <div class="d-flex justify-content-start">
            <div><input type="file" name="uploadFile" id="uploadFile" accept=".xls, .xlsx"></div>
            <div><a href="#myModal" id="exceladdbtn" type="button" data-toggle="modal" onclick="insertexcelreader()" class="btn btn-success lecBtn mt-1">엑셀 업로드</a></div>
        </div>
    </div>
    <div class="alert alert-warning" role="alert">
        <h4 class="alert-heading">강좌 데이터 입력 시 검토 바랍니다!</h4>
        <p>잘못된 계산이 될 수 있으므로 수차례 검토 해주셔야 합니다.</p>
        <hr>
        <p class="mb-0">
            컴퓨터공학부, 컴퓨터공학전공, AI컴퓨터공학부 수업은 전부 '컴퓨터공학'으로 등록해주셔야 한 개의 전공처럼 취급하실 수 있습니다.
        </p>
    </div>
</div>
<div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-lg">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">강좌 엑셀</h4>
            </div>
            <div id="howmany"></div>

            <div class="modal-body" id="myModalbody">
                <table class="newLecTable" id="insert_excel" data-toggle="table"
                       data-pagination="true" data-toolbar="#toolbar"
                       data-search="true" data-side-pagination="true"
                       data-page-list="[10]">
                    <thead>
                    <tr>
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
                    </tr>
                    </thead>
                </table>
            </div>
            <div class="modal-footer" id="footer"></div>
        </div>
    </div>
</div>
<div class="modal fade" id="myModal2" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">강좌 추가</h4>
            </div>
            <div class="modal-body" id="myModalbody2">
                <div class="row">
                    <div class="col-xs-4">
                        <div>연도</div><input type="number" class="form-control addModalInput" id="add_year" name="new_table" value="" placeholder="(예:2021)" required>
                    </div>
                    <div class="col-xs-4">
                        <div>학기</div>
                        <select class="form-control addModalInput" id="add_semester" required>
                            <option value="1">1학기</option>
                            <option value="2">2학기</option>
                            <option value="여름">여름학기</option>
                            <option value="겨울">겨울학기</option>
                        </select>
                    </div>
                    <div class="col-xs-4">
                        <div>학년</div>
                        <select class="form-control addModalInput" id="add_grade" required>
                            <option value="1">1학년</option>
                            <option value="2">2학년</option>
                            <option value="3">3학년</option>
                            <option value="4">4학년</option>
                        </select>
                    </div>
                </div></br>
                <div class="row">
                    <div class="col-xs-4">
                        <div>학수코드</div><input type="text" class="form-control addModalInput" id="add_lecture_id" name="new_table" value="" placeholder="(예:A1234)" required>
                    </div>
                    <div class="col-xs-4">
                        <div>전공</div><input type="text" class="form-control addModalInput" id="add_major" name="new_table" value="" placeholder="(예:컴퓨터과학과)" required>
                    </div>
                    <div class="col-xs-4">
                        <div>학점</div>
                        <select class="form-control addModalInput" id="add_credit" required>
                            <option value="3">3학점</option>
                            <option value="2">2학점</option>
                            <option value="1">1학점</option>
                        </select>
                    </div>
                </div></br>
                <div class="row">
                    <div class="col-xs-4">
                        <div>설계점수</div>
                        <select class="form-control addModalInput" id="add_design_credit" required>
                            <option value="1">1</option>
                            <option value="1.5">1.5</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                        </select>
                    </div>
                    <div class="col-xs-4">
                        <div>과목명</div>
                        <input type="text" class="form-control addModalInput" id="add_name" name="new_table" value=""
                               placeholder="과목명" required>
                    </div>
                    <div class="col-xs-4">
                        <div>교양/전공</div>
                        <select class="form-control addModalInput" id="add_big_type" required>
                            <option value="전공">전공</option>
                            <option value="교양">교양</option>
                        </select>
                    </div>
                </div></br>
                <div class="row">
                    <div class="col-xs-4">
                        <div>이수구분</div><input type="text" class="form-control addModalInput" id="add_small_type" name="new_table" value="" placeholder="(예:컴공)" required>
                    </div>
                </div></br>
            </div>
            <div class="modal-footer" id="footer2">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary pull-right" data-dismiss="modal" aria-label="Close" onclick="addLecture()">추가하기</button>
            </div>
        </div>
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
                <h4 class="modal-title">강좌 수정</h4>
            </div>
            <div class="modal-body" id = "modifyModalbody">
            </div>
            <div class="modal-footer" id = "modifyModalfooter">
            </div>
        </div>
    </div>
</div>


<script>

    function modifylecture(i){
        var list = $('#modifyModalbody');
        var foot = $('#modifyModalfooter');

        var modal_body = '';
        modal_body += ' <div class="row"><div class="col-xs-4"><div>연도</div><input type="number" class="form-control addModalInput" id="modify_lecture_year" name="new_table" value="'+(allLectures[i].year)+'" placeholder="연도를 입력해주세요(예:2021)"></div>'
            +'<div class="col-xs-4"><div>학기</div><input type="number" class="form-control addModalInput" id="modify_lecture_semester" name="new_table" value="'+(allLectures[i].semester)+'" placeholder="학기를 선택해주세요"></div>'
            +'<div class="col-xs-4"><div>학년</div><input type="number" class="form-control addModalInput" id="modify_lecture_grade" name="new_table" value="'+(allLectures[i].grade)+'" placeholder="학년을 입력해주세요"></div></div>'
            +'<div class="row"><div class="col-xs-4"><div>학수코드</div><input type="text" class="form-control addModalInput" id="modify_lecture_lecture_id" name="new_table" value="'+(allLectures[i].lecture_id)+'" placeholder="학수코드를 입력해주세요(예:A1234)"> </div>'
            +'<div class="col-xs-4"><div>교양/전공</div><input type="text" class="form-control addModalInput" id="modify_lecture_big_type" name="new_table" value="'+(allLectures[i].big_type)+'" placeholder="교양/전공을 선택해주세요"></div>'
            +'<div class="col-xs-4"><div>이수구분</div><input type="text" class="form-control addModalInput" id="modify_lecture_small_type" name="new_table" value="'+(allLectures[i].small_type)+'" placeholder="소분류를 입력해주세요(예:컴공)"></div></div>'
            +'<div class="row"><div class="col-xs-4"><div>전공</div><input type="text" class="form-control addModalInput" id="modify_lecture_major" name="new_table" value="'+(allLectures[i].major)+'" placeholder="전공을 입력해주세요(예:)"></div>'
            +'<div class="col-xs-4"><div>학점</div><input type="number" class="form-control addModalInput" id="modify_lecture_credit" name="new_table" value="'+(allLectures[i].credit)+'" placeholder="학점을 입력해주세요(예:3)"></div>'
            +'<div class="col-xs-4"><div>설계점수</div><input type="number" class="form-control addModalInput" id="modify_lecture_design_credit" name="new_table" value="'+(allLectures[i].design_credit)+'" placeholder="설계점수를 입력해주세요(예:1)"></div></div>'
            +'<div class="row"><div class="col-xs-4"><div>과목명</div><input type="text" class="form-control addModalInput" id="modify_lecture_name" name="new_table" value="'+(allLectures[i].name)+'" placeholder="과목명을 입력해주세요"></div></div>'


        list.html(modal_body);

        var modal_footer = '';
        modal_footer += '<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>';
        modal_footer += '<button type="button" class="btn btn-primary pull-right" data-dismiss="modal" aria-label="Close" onclick="modifyLecture('+i+')">완료</button>';

        foot.html(modal_footer);

    }

    function modifyLecture(i){
        var target_id=allLectures[i].id;
        var year=$('#modify_lecture_year').val();
        var semester=$('#modify_lecture_semester').val();
        var grade = $('#modify_lecture_grade').val();
        var lecture_id=$('#modify_lecture_lecture_id').val();
        var big_type=$('#modify_lecture_big_type').val();
        var small_type = $('#modify_lecture_small_type').val();
        var major=$('#modify_lecture_major').val();
        var credit=$('#modify_lecture_credit').val();
        var design_credit = $('#modify_lecture_design_credit').val();
        var name=$('#modify_lecture_name').val();
        // var selective_essential = $('#modify_lecture_selective_essential').val();

        var data= target_id+ '-/-/-' + year +'-/-/-'+semester+'-/-/-'+grade+'-/-/-'+lecture_id +'-/-/-'+big_type+'-/-/-'+small_type+'-/-/-'+
            major +'-/-/-'+credit+'-/-/-'+design_credit+'-/-/-'+name;

        $.ajax({
            url: "ajax.kgu", //AjaxAction에서
            type: "post", //post 방식으로
            data: {
                req: "modifylecture", //이 메소드를 찾아서
                data: data //이 데이터를 파라미터로 넘겨줍니다.
            },
            success: function (data) { //성공 시
                if(data=='success'){
                    alert('해당 강좌가 수정되었습니다.')
                    location.reload();
                }
                // else{
                //     swal.fire({
                //         title : '권한이 부족합니다.',
                //         icon : 'warning',
                //         showConfirmButton: true
                //
                //     });
                // }
            }
        })
    }

    function insertexcelreader() {
        // alert("파일 추가하셔야 수정 가능합니다!!");
        var address=uploadexcel();
        $.ajax({
            url : "excel.kgu",
            type : "post",
            data : {
                writeorread : "read",
                address : address
            },
            dataType : "json",
            success : function(data) {
                // var modal = $('#myModalbody');
                var howmany = $('#howmany');

                var it = data;
                var a = '<h3> 총 ' + (data.length)
                    + '개의 Row가 등록될 예정입니다.</h3>';
                howmany.html(a);
                var table2 = $('#insert_excel');
                var footer = $('#footer');
                footer
                    .html('<button id="addbutton" type="button" class="btn btn-success" style = "margin : 1px;">일괄 추가</button>');
                $('#addbutton').attr('onclick', 'insertlecture()');
                table2.bootstrapTable('load', insertdata(data));
                table2.bootstrapTable('refresh');

            }
        })
    }

    function insertdata(data) {
        var rows = [];
        for (var i = 0; i < data.length; i++) {
            var lecture = data[i];
            rows.push({
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
        return rows;
    }

    function insertlecture() {
        var address = uploadexcel();
        $.ajax({
            url : "ajax.kgu",
            type : "post",
            data : {
                req : "insertexcellecture",
                data : "true",
                address : address
            },
            success : function(data) {
                    alert(data + "개의 강좌가 등록되었습니다.");
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

    var $table = $('#lecture_table');

    function deleteselectlecture(){
        var ids=$.map($table.bootstrapTable('getSelections'),function(row){
            return row.id;
        });
        var check = confirm(ids.length+"개의 과목을 정말 삭제하시겠습니까?");
        if(check){
            var id="";
            for(var i=0;i<ids.length;i++){
                id+=ids[i]+"-/-/-";
            }

            dataType:"json"
            $.ajax({
                url:"ajax.kgu",
                type:"post",
                data : {
                    req:"deleteselectlecture",
                    data : id
                },
                success : function(data){
                    $table.bootstrapTable('remove',{
                        field : 'id',
                        values : ids
                    })
                }
            })
        };
    }

    function deletealllecture(){
        var check = confirm("과목 전체를 삭제하시겠습니까?");
        if(check){
            $.ajax({
                url: "ajax.kgu",
                type: "post",
                data: {
                    req: "deletealllecture",
                },
                success: function (data) {
                    if(data=='success'){
                        alert("삭제되었습니다.")
                        location.reload();
                    }
                }
            })
        };
    }

    function addLecture(){
        // var id=$('#add_id').val();
        var year=$('#add_year').val();
        var semester=$('#add_semester').val();
        var grade = $('#add_grade').val();
        var lecture_id=$('#add_lecture_id').val();
        var big_type=$('#add_big_type').val();
        var small_type = $('#add_small_type').val();
        var major=$('#add_major').val();
        var credit=$('#add_credit').val();
        var design_credit = $('#add_design_credit').val();
        var name=$('#add_name').val();
        // var selective_essential = $('#add_selective_essential').val();

        var data= year +'-/-/-'+semester+'-/-/-'+grade+'-/-/-'+lecture_id +'-/-/-'+big_type+'-/-/-'+small_type+'-/-/-'+
            major +'-/-/-'+credit+'-/-/-'+design_credit+'-/-/-'+name;

        $.ajax({
            url: "ajax.kgu", //AjaxAction에서
            type: "post", //post 방식으로
            data: {
                req: "addLecture", //이 메소드를 찾아서
                data: data //이 데이터를 파라미터로 넘겨줍니다.
            },
            success: function (data) { //성공 시
                if(data=='success'){
                    alert("해당 강좌가 추가되었습니다.")
                    location.reload();
                } else{
                    alert("모든 항목을 채워주셔야 합니다.")
                }
            }
        })
    }
</script>
<style>
    table:not([class]) td {
        border: 1px solid grey;
    }

    .newLecTable {
        align-content: center;
        margin: 0;
        border-collapse: collapse;
        font-size: 13px;
    }

    .newLecTable td {
        padding-top:4px;
        padding-bottom:4px;
        min-width: 30px;
        text-align: center;
        border-bottom: 1px solid gainsboro;
    }

    .newLecTable > thead > tr > th {
        text-align: center;
    }

    .newLecTable > tbody > tr > td {
        vertical-align: middle;
    }
<%--    &lt;%&ndash;    수정 필요&ndash;%&gt;--%>
<%--    #maincontent {--%>
<%--        padding: 0;--%>
<%--    }--%>

<%--    #maincontent>ul {--%>
<%--        padding: 10px;--%>
<%--    }--%>
    .newLecTable > thead > tr > th:nth-child(1), .newLecTable > tbody > tr > td:nth-child(1) {
        width: 50px;
    }

    .newLecTable > thead > tr > th:nth-child(2), .newLecTable > tbody > tr > th:nth-child(2) {
        width: 60px;
        min-width: 30px;
    }

    .newLecTable > thead > tr > th:nth-child(3), .newLecTable > tbody > tr > td:nth-child(3) {
        width: 55px;
        min-width: 30px;
    }

    .newLecTable > thead > tr > th:nth-child(4), .newLecTable > tbody > tr > th:nth-child(4) {
        width: 55px;
        min-width: 30px;
    }

    .newLecTable > thead > tr > th:nth-child(5), .newLecTable > tbody > tr > th:nth-child(5) {
        width: 85px;
        min-width: 30px;
    }

    .newLecTable > thead > tr > th:nth-child(6), .newLecTable > tbody > tr > td:nth-child(6) {
        width: 70px;
        min-width: 50px;
    }

    .newLecTable > thead > tr > th:nth-child(7), .newLecTable > tbody > tr > th:nth-child(7) {
        width: 50px;
        min-width: 30px;
    }

    .newLecTable > thead > tr > th:nth-child(8), .newLecTable > tbody > tr > th:nth-child(8) {
        width: 129px;
        min-width: 100px;
    }

    .newLecTable > thead > tr > th:nth-child(9), .newLecTable > tbody > tr > th:nth-child(9) {
        width: 65px;
        min-width: 30px;
    }

    .newLecTable > thead > tr > th:nth-child(10), .newLecTable > tbody > tr > th:nth-child(10) {
        width: 55px;
        min-width: 30px;
    }

    .newLecTable > thead > tr > th:nth-child(11), .newLecTable > tbody > tr > th:nth-child(11) {
        width: 200px;
        min-width: 100px;
    }

    .newLecTable th {
        margin: 0;
        border-bottom: 1px solid #607D8B;
        border-top: 2px solid #607D8B;
        background-color: #ECEFF1;
    }
    /*.input-group{*/
    /*    margin-top: 20px;*/
    /*    margin-bottom: 10px;*/
    /*}*/
    /*.form-control{*/
    /*    margin: 0 20px;*/
    /*}*/

    .fixed-table-loading{
        display: none;
    }
    .lecBtn{
        margin-bottom: 10px;
    }
    #myModalbody2{
        text-align: center;
    }
    #modifyModalbody {
        text-align: center;
    }
</style>