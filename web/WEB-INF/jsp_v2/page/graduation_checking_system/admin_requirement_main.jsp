<%--
  Created by IntelliJ IDEA.
  User: gykim
  Date: 2021-09-24
  Time: 오후 12:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String getGraduationRequirement = (String) request.getAttribute("getGraduationRequirement");
    String getLectureByCode = (String) request.getAttribute("getLectureByCode");
    String getSimilarSubject = (String) request.getAttribute("getSimilarSubject");
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
<!-- 수강과목 추가, 수정 Modal -->
<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" id="graduationReqModalHeader">
            </div>
            <div class="modal-body" id="graduationReqModalBody"></div>
            <div class="modal-footer" id="graduationReqModalFooter">
            </div>
        </div>
    </div>
</div>

<div class="py-5">
    <div><h2>전공/학번별 진단요건 관리 페이지로 이동하기</h2></div>
    <div class="text-right">(리스트를 클릭하면 관리 페이지로 넘어갑니다.)</div>
    <div id="buttons"></div>
    <table class="boardtable" id="requirementTable" data-toggle="table"
           data-pagination="true" data-toolbar="#toolbar"
           data-search="true" data-side-pagination="true"
           data-page-list="[10]">
        <thead>
        <tr>
            <th data-field="action" data-sortable="true">설정</th>
            <th data-field="year" data-sortable="true">학번</th>
            <th data-field="major" data-sortable="true">전공</th>
            <th data-field="all_credit" data-sortable="true">전체학점</th>
            <th data-field="major_credit" data-sortable="true">전체전공학점</th>
            <th data-field="major_essential" data-sortable="true">전공필수개수</th>
            <th data-field="major_selective" data-sortable="true">전공선택개수</th>
            <th data-field="elective_credit" data-sortable="true">전체교양학점</th>
            <th data-field="jin_seong_ae_credit" data-sortable="true">진성애학점</th>
            <th data-field="msc_credit" data-sortable="true">msc학점</th>
<%--            <th data-field="major_lecture" data-sortable="true">전공과목</th>--%>
        </tr>
        </thead>
    </table>
    <div class="text-right mb-4">
        <a href="#staticBackdrop" onclick="addGraduationReqModal()" data-toggle="modal" class="btn btn-success">진단요건 추가하기</a>
    </div>
    <div class="alert alert-success" role="alert">
        <h4 class="alert-heading">기능 소개</h4>
        <p>매해 1월에 해주셔야 하는 작업</p>
        <hr>
        <p class="mb-0">
            1. 진단요건 추가하기 버튼을 눌러 진단요건을 추가합니다. (ex.2022 / OOO학과)
            2. 추가된 진단요건의 상세설정에 들어가서 각종 설정을 해줍니다.
            3. 기능 연습 등 테스트를 원하시는 경우에도 이와 같은 방법으로 열고 연습해주신다음 삭제해주시면 됩니다.
        </p>
    </div>
    <div class="py-5"><h2>유사과목 지정하기</h2></div>
    <div class="row" id="similarLectureCard"></div>
    <div class="text-right mb-4">
        <a href="#staticBackdrop" onclick="addSimilarLecModal()" data-toggle="modal" class="btn btn-success ms-1">유사과목 추가하기</a>
    </div>
</div>

<script>
    let modalHeader = $('#graduationReqModalHeader');
    let modalBody = $('#graduationReqModalBody');
    let modalFooter = $('#graduationReqModalFooter');

    let getGraduationRequirement = <%=getGraduationRequirement%>;
    let getLectureByCode = <%=getLectureByCode%>;
    let getSimilarSubject = <%=getSimilarSubject%>;

    $(document).ready(function () {
        callSetupTableView();
        similarLectureData();
        // makeButtons();
    })

    function callSetupTableView() {
        $('#requirementTable').bootstrapTable('append', data());
        $('#requirementTable').bootstrapTable('refresh');
        // $('#similarLecTable').bootstrapTable('append', similarLectureData());
        // $('#similarLecTable').bootstrapTable('refresh');
    }

    function data() {
        var rows = [];
        for (let i = 0; i < getGraduationRequirement.length; i++) {
            let graduationRequirementElement = getGraduationRequirement[i];
            let anchor_first = '<a href="graduation_checking_system.kgu?num=123&year=' + graduationRequirementElement.year + '&major=' + graduationRequirementElement.major + '">';
            let anchor_last = '</a>';
            rows.push({
                action : '<button class="btn btn-danger mx-2" onclick="deleteGraduationReq(' + i + ')">삭제</button>',
                year: anchor_first+graduationRequirementElement.year+anchor_last,
                major: anchor_first+graduationRequirementElement.major+anchor_last,
                all_credit: anchor_first+graduationRequirementElement.all_credit+anchor_last,
                major_credit: anchor_first+graduationRequirementElement.major_credit+anchor_last,
                major_essential: anchor_first+graduationRequirementElement.major_essential+anchor_last,
                major_selective: anchor_first+graduationRequirementElement.major_selective+anchor_last,
                elective_credit: anchor_first+graduationRequirementElement.elective_credit+anchor_last,
                jin_seong_ae_credit: anchor_first+graduationRequirementElement.jin_seong_ae_credit+anchor_last,
                msc_credit: anchor_first+graduationRequirementElement.msc_credit+anchor_last
            });
        }
        return rows;
    }

    function similarLectureData(){
        //새롭게 만든 테이블
        let text = '';
        for (let i = 0; i < getSimilarSubject.length; i++) {
            let similarLectures = getSimilarSubject[i];
            text += '<div class="col-xs-6"><div class="card"><ul class="list-group list-group-flush"><li class="list-group-item disabled">유사과목그룹'+similarLectures.oid+'</li>';
            let lectures = similarLectures.lectures.split("-/@/-");
            let lecturesText = ''
            for (let j=0; j<lectures.length; j++){
                getLectureByCode.forEach(function (lec) {
                    if(lec.lecture_id==lectures[j]){
                        lecturesText+='/'+lec.name+'('+lec.lecture_id+')';
                        text += '<li class="list-group-item"><input class="btn btn-danger me-3" type="button" onclick="deleteSimilarLec('+i+','+j+')" value="삭제">'+lec.name+'('+lec.lecture_id+')'+'</li>'
                    }
                });
            }
            text += '</ul></div></div>';
        }
        $('#similarLectureCard').html(text);
    }

    function makeButtons() {
        let text = ''
        let yearButton = $('#buttons');
        for (let i = 0; i < getGraduationRequirement.length; i++) {
            text += '<div class="py-2"><button type="button" class="btn btn-primary btn-lg" onclick="location.href=\'graduation_checking_system.kgu?num=123&year=' + getGraduationRequirement[i].year + '&major=' + getGraduationRequirement[i].major + '\'">[' + getGraduationRequirement[i].year + '학번] ' + getGraduationRequirement[i].major + '</button>'
                + '<button class="btn btn-danger mx-2" onclick="deleteGraduationReq(' + i + ')">삭제</button></div>';

        }
        yearButton.append(text);
    }


    function addGraduationReqModal() {
        let textHeader = '';
        let textBody = '';
        let textFooter = '';
        let currentYear = new Date().getFullYear();
        textHeader = '<button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">&times;</span></button><h4 class="modal-title" id="staticBackdrop">진단요건 추가</h4>';
        modalHeader.html(textHeader);
        //GR은 graduation requirement
        textBody += '<div>학번</div><select class="form-control" id="year" name="gcs_GR_year" value="" required>';
        for (let i = 2017; i <= currentYear + 2; i++) {
            textBody += '<option value="' + i + '">' + i + '</option>';
        }
        textBody += '</select>';

        textBody += '<div>전공</div><input type="text" class="form-control" id="major" name="gcs_GR_major" value="" placeholder="전공">'
            + '<div class="profile px-2"><h2>경기대졸업요건</h2></div>'
            + '<div class="px-2">'
            + '<div class="row"> '
            + '<div class="col-xs-12"><div class="profile">전체 학점</div><div class="inform"><input class="form-control" type="number"  id="all_credit" name="a_all_credit" value="" /></div></div>'
            + '</div>'
            + '<div class="row">'
            + '<div class="col-xs-4"><div class="profile">전체 전공학점</div><div class="inform"><input class="form-control" type="number" id="major_credit" name="a_major_credit" value="" /></div></div>'
            + '<div class="col-xs-4"><div class="profile">전체 교양학점</div><div class="inform"><input class="form-control" type="number" id="elective_credit" name="a_elective_credit" value="" /></div></div>'
            + '<div class="col-xs-4"><div class="profile">전공 필수 개수</div><div class="inform"><input class="form-control" type="number" id="major_essential" name="a_major_essential" value="" /></div></div>'
            + '</div>'
            + '<div class="row">'
            + '<div class="col-xs-4"><div class="profile">전공 선택 개수</div><div class="inform"><input class="form-control" type="number"  id="major_selective" name="a_major_selective" value="" /></div></div>'
            + '<div class="col-xs-4"><div class="profile">진성애 학점</div><div class="inform"><input class="form-control" type="number" id="jin_seong_ae_credit" name="a_jin_seong_ae_credit" value="" /></div></div>'
            + '<div class="col-xs-4"><div class="profile">수리와과학(MSC) 학점</div><div class="inform"><input class="form-control" type="number" id="msc_credit" name="a_msc_credit" value="" /></div></div>'
            + '</div>'
            + '</div>'
            + '<div class="profile px-2"><h2>공학인증요건</h2></div>'
            + '<div class="px-2">'
            + '<div class="row">'
            + '<div class="col-xs-3"><div class="profile">BSM 학점</div><div class="inform"><input class="form-control" type="number" id="bsm_credit" name="b_bsm_credit" value="" /></div></div>'
            + '<div class="col-xs-3"><div class="profile px-2">전문교양 학점</div><div class="inform"><input class="form-control" type="number" id="engineering_elective_credit" name="b_engineering_elective_credit" value="" /></div></div>'
            + '<div class="col-xs-3"><div class="profile px-2">설계 학점</div><div class="inform"><input class="form-control" type="number" id="design_credit" name="b_design_credit" value="" /></div></div>'
            + '<div class="col-xs-3"><div class="profile px-2">전공 학점</div><div class="inform"><input class="form-control" type="number" id="engineering_major_credit" name="b_engineering_major_credit" value="" /></div></div>'
            + '</div>'
            + '</div>';
        modalBody.html(textBody);
        textFooter = '<button type="button" class="btn btn-default" data-dismiss="modal">취소</button><button type="button" class="btn btn-primary" id="modify_button" onclick="addGraduationReq()">추가하기</button>';

        modalFooter.html(textFooter);

    }

    function addGraduationReq() {
        //졸업요건
        let year = $('#year').val();
        let major = $('#major').val();
        let all_credit = $('#all_credit').val();
        let major_credit = $('#major_credit').val();
        let elective_credit = $('#elective_credit').val();
        let major_essential = $('#major_essential').val();
        let major_selective = $('#major_selective').val();
        let jin_seong_ae_credit = $('#jin_seong_ae_credit').val();
        let msc_credit = $('#msc_credit').val();

        //공학인증
        let bsm_credit = $('#bsm_credit').val();
        let engineering_elective_credit = $('#engineering_elective_credit').val();
        let design_credit = $('#design_credit').val();
        let engineering_major_credit = $('#engineering_major_credit').val();

        let data = year + '-/-/-' + major + '-/-/-' + all_credit + '-/-/-' + major_credit + '-/-/-' + elective_credit + '-/-/-' + major_essential + '-/-/-' + major_selective + '-/-/-' + jin_seong_ae_credit + '-/-/-' + msc_credit + '-/-/-' + bsm_credit + '-/-/-' + engineering_elective_credit + '-/-/-' + design_credit + '-/-/-' + engineering_major_credit;


        if (year <= 2000 || year >= 2500) {
            alert("해당 연도를 4자리로 입력해주시기 바랍니다.")

        }

        if (year != '' && major != '' && all_credit != '' && major_credit != '' && elective_credit != '' && major_essential != '' && major_selective != '' && jin_seong_ae_credit != '' && msc_credit != '' && bsm_credit != '' && engineering_elective_credit != '' && design_credit != '' && engineering_major_credit != '') {


            $.ajax({
                url: "ajax.kgu", //AjaxAction에서
                type: "post",
                data: {
                    req: "insertGraduationRequirement", //이 메소드를 찾아서
                    data: data//이 데이터를 파라미터로 넘겨줍니다.
                },
                success: function (data) { //성공 시
                    if (data == 'success') {
                        alert("졸업요건이 추가 되었습니다")
                        location.reload();
                    }
                }
            })
        } else {
            alert("빈칸을 채워주세요")
        }
    }

    function deleteGraduationReq(i) {
        let GraduationRequirement = <%=getGraduationRequirement%>;
        let id = GraduationRequirement[i].id;
        let check = prompt("정말 삭제하시겠습니까? 삭제하시려는 학번 전공을 띄어쓰기 없이 연달아 입력한 후 엔터를 누르세요. (ex. 2015컴퓨터과학과)");
        let answer = GraduationRequirement[i].year+GraduationRequirement[i].major
        if (check==answer) {
            $.ajax({
                url: "ajax.kgu",
                type: "post",
                data: {
                    req: "deleteGraduationRequirement",
                    data: id

                },
                success: function (data) {
                    if (data == 'success') {
                        alert("삭제되었습니다.")
                        location.reload();
                    }
                }
            })
        }
        else {
            alert('잘못 입력하셨습니다.')
        }
    }

    let selectedType;
    let recognizeLectures = new Array(); //유사 과목 들어감

    function addSimilarLecModal(){
        modalHeader.html('<button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">&times;</span></button><h4 class="modal-title" id="staticBackdrop">유사과목 추가</h4>');
        let body = '<div>'
            + '<div class="profile">인정할 유사 과목</div><div class="inform row ms-1" id="recognizeLectures"></div></div>'
            + '<div><label for="major" class="form-label">전공</label><div id="majorButton"></div><label for="electiveButton" class="form-label">교양</label><div id="electiveButton"></div></div>';
        modalBody.html(body);
        modalFooter.html('<button type="button" class="btn btn-default" data-dismiss="modal">취소</button><button type="button" class="btn btn-primary" id="modify_button" onclick="addSimilarLec()">추가하기</button>');
        selectedType = 'recognizeFrom';
        setLectures();
    }

    function setLectures() {
        getLectureByCode.forEach(function (lecture) {
            if (lecture.big_type == '전공')
                $('#majorButton').append('<input type="button" id="' + lecture.lecture_id + '" class="btn btn-default m-1" name="' + lecture.credit + '" value="' + lecture.name + '" onclick=selectLecture(this)>');
            else if (lecture.big_type == '교양')
                $('#electiveButton').append('<input type="button" id="' + lecture.lecture_id + '" class="btn btn-default m-1" name="' + lecture.credit + '" value="' + lecture.name + '" onclick=selectLecture(this)>');
        });
    }

    function selectLecture(button){
        button.blur();
        const target = button.id;
        let id = "#" + target;
        let classes = $(id).attr("class");
        if (!classes.includes("clicked")) {
            //클릭되지않은 버튼을 클릭했을때
            $(id).addClass('clicked');
            recognizeLectures.push(target);
        } else {
            //클릭된 버튼을 클릭 해제
            $(id).removeClass('clicked');
            let tmp = recognizeLectures.splice(recognizeLectures.indexOf(target), 1); //제거
        }
        showResult();
    }

    function showResult() {
        let fromButtons = '';
        let name='';
        let code='';
        for(let i=0; i<recognizeLectures.length; i++){
            code = '#'+recognizeLectures[i];
            name = $(code).val();
            fromButtons += '<button class="col btn btn-primary m-1" id="from:'+recognizeLectures[i]+'">'+name+'</button>';
        }
        $('#recognizeLectures').html(fromButtons);
    }

    function addSimilarLec(){
        let text = recognizeLectures[0];
        for(let i=1; i<recognizeLectures.length; i++){
            text += '-/@/-'+recognizeLectures[i];
        }
        let data = text;
        $.ajax({
            url: "ajax.kgu", //AjaxAction에서
            type: "post",
            data: {
                req: "insertSimilarSub", //이 메소드를 찾아서
                data: data//이 데이터를 파라미터로 넘겨줍니다.
            },
            success: function (data) { //성공 시
                if (data == 'success') {
                    alert("유사과목이 추가 되었습니다")
                    location.reload();
                }
            }
        })
    }

    function deleteSimilarLec(index1, index2){
        let similarLectures = getSimilarSubject[index1];
        let lectures = similarLectures.lectures.split("-/@/-");
        lectures.splice(index2,1);
        let text = 'empty';
        if(lectures.length != 0)
            text = lectures[0];
        for (let j = 1; j < lectures.length - 1; j++) {
            text += '-/@/-'+lectures[j];
        }
        let data = similarLectures.oid + '-/-/-' + text;
        $.ajax({
            url: "ajax.kgu", //AjaxAction에서
            type: "post",
            data: {
                req: "ModifySimilarSub", //이 메소드를 찾아서
                data: data//이 데이터를 파라미터로 넘겨줍니다.
            },
            success: function (data) { //성공 시
                if (data == 'success') {
                    alert("유사과목이 삭제 되었습니다")
                    location.reload();
                }
            }
        })
    }
</script>
<style>
    <%--    수정 필요--%>
    #maincontent {
        padding: 0;
    }

    #maincontent > ul {
        padding: 10px;
    }

    .boardtable > thead > tr > th {
        text-align: center;
    }

    .boardtable > tbody > tr > td {
        vertical-align: middle;
    }

    .boardtable > thead > tr > th:nth-child(1), .boardtable > tbody > tr > td:nth-child(1) {
        width: 80px;
        min-width: 50px;
    }

    .boardtable > thead > tr > th:nth-child(2), .boardtable > tbody > tr > td:nth-child(2) {
        width: 50px;
        min-width: 30px;
    }

    .boardtable > thead > tr > th:nth-child(3), .boardtable > tbody > tr > td:nth-child(3) {
        width: 110px;
        min-width: 80px;
    }

    .boardtable > thead > tr > th:nth-child(4), .boardtable > tbody > tr > th:nth-child(4) {
        width: 77px;
        min-width: 30px;
    }

    .boardtable > thead > tr > th:nth-child(5), .boardtable > tbody > tr > td:nth-child(5) {
        width: 77px;
        min-width: 30px;
    }

    .boardtable > thead > tr > th:nth-child(6), .boardtable > tbody > tr > th:nth-child(6) {
        width: 77px;
        min-width: 30px;
    }

    .boardtable > thead > tr > th:nth-child(7), .boardtable > tbody > tr > th:nth-child(7) {
        width: 77px;
        min-width: 30px;
    }

    .boardtable > thead > tr > th:nth-child(8), .boardtable > tbody > tr > td:nth-child(8) {
        width: 77px;
        min-width: 50px;
    }

    .boardtable > thead > tr > th:nth-child(9), .boardtable > tbody > tr > th:nth-child(9) {
        width: 60px;
        min-width: 30px;
    }

    .boardtable > thead > tr > th:nth-child(10), .boardtable > tbody > tr > th:nth-child(10) {
        width: 65px;
        min-width: 30px;
    }

    .boardtable td {
         min-width: 0px !important;
    }

    .boardtable > tbody > tr > td:nth-child(4) {
        min-width: 0px !important;
        width: auto !important;
    }
    .boardtable > thead > tr > th:nth-child(4) {
        width: auto !important;
    }

    .clicked {
        background-color: lightblue;
    }

    .boardtable > thead > tr > th {
        text-align: center;
    }

    .boardtable > tbody > tr > td {
        vertical-align: middle;
    }
</style>
