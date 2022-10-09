<%--
  Created by IntelliJ IDEA.
  User: YOON
  Date: 2021-09-05
  Time: 오전 1:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String getLecture = (String) request.getAttribute("getLecture");
    String getExternalLecture = (String) request.getAttribute("getExternalLecture");
    String getStudent = (String) request.getAttribute("getStudent");
    String getAllYear = (String) request.getAttribute("getAllYear");
    String getLectureHistory = (String) request.getAttribute("getLectureHistory");
    String getExternalLectureHistory = (String) request.getAttribute("getExternalLectureHistory");
    String getGraduationRequirement = (String) request.getAttribute("getGraduationRequirement");
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
<div>
    <div class="py-5">
        <div class="alert alert-danger d-flex align-items-center" role="alert">
            <div><i class="bi bi-exclamation-triangle-fill"></i> 외국인 유학생, 전과생, 복수전공생, 편입생의 경우에는 사용이 불가능합니다. 유의바랍니다.</div>
        </div>
        <h2>개인정보 설정</h2>
        <div class="profile_info">
            <div class="col-xs-6">
                <!-- 학생정보 div -->
                <div class="contenttitle2">학생정보</div>
                <ul id="student_data"></ul>
            </div>
            <div class="col-xs-6">
                <!-- 학생정보 div -->
                <div class="contenttitle2">안내사항</div>
                <ul>
                    <div>
                       <textarea id="schedule" class="explain" readonly>
* [2021-12-05 기준 작성]
* 이 시스템은 현재 테스트 중으로 오류가 있을 수 있으며 사용 간 발생하는 문제에 대해 책임지지 않습니다. 참고용으로만 사용해주세요.
* 수강 이력을 정확하게 입력하지 않는 경우 학점 계산 및 상담 시 문제가 발생할 수 있습니다.
* 이 시스템은 KUTIS와 연동되지 않습니다. 관리자가 설정을 잘못하는 경우 잘못된 결과가 출력될 수 있으므로 사용 시 주의바랍니다. (강좌 정보가 KUTIS와 상이한 경우 학과 사무실로 연락주시면 감사하겠습니다.)
* 모든 처리결과는 판단 및 계산 근거가 출력되므로 계산 결과가 맞는지 검토바랍니다.
* 이 시스템은 17학번 이후 학부생부터 사용이 가능하며, 컴퓨터공학부(AI컴퓨터공학부 포함), 컴퓨터공학전공, 인공지능전공을 대상으로 서비스합니다. (17학번 이전 및 복수전공 및 전과의 경우에는 서비스하지 않으므로 학과 사무실로 연락주세요.)
* 여기서 입력 된 정보는 외부로 유출되지 않으며, 본인 이외에는 관리자만 확인할 수 있습니다.
                       </textarea>
                    </div>
                    <div id="agreecheck"><input type="checkbox" id="checkbox1" name="agreement" VALUE="agree"/> 위 안내문 및 사용약관에 동의합니다.</div><br>
                </ul>
            </div>
        </div>
        <div id="student_button" class="text-right my-5"></div>
        <div class="alert alert-success d-flex align-items-center" role="alert">
            <div><i class="bi bi-exclamation-triangle-fill"></i> 컴퓨터과학과, 컴퓨터공학부, AI컴퓨터공학부, 컴퓨터공학전공은 모두 '컴퓨터공학'으로 등록되어 있습니다.</div>
        </div>
    </div>
</div>
<hr>
<div id="history">
    <div class="d-flex w-100 align-items-center justify-content-between">
        <h2>수강이력 입력하기</h2>
        <div class="text-right mt-4">
            <!-- Button trigger modal -->
            <a href="#lectureModal" data-toggle="modal" class="btn btn-warning">학부 전체 강좌 보기</a>
            <!-- Button trigger modal -->
            <a href="#lectureSpecialModal" data-toggle="modal" class="btn btn-default ">특별한 강좌를 확인해보세요!</a>
        </div>
    </div>
    <table class="boardtable" id="taken_table" data-toggle="table"
           data-pagination="true" data-toolbar="#toolbar"
           data-search="true" data-side-pagination="true" data-click-to-select="true"
           data-page-list="[10]">
        <thead>
        <tr>
            <th class="col-2" data-field="action">설정</th>
            <th data-field="year" data-sortable="true">연도</th>
            <th data-field="semester" data-sortable="true">학기</th>
            <th data-field="code" data-sortable="true">학수코드</th>
            <th data-field="name" data-sortable="true">과목명</th>
        </tr>
        </thead>
    </table>

    <div class="text-right">
        <div class="" id="insertButtons">
            <!-- Button trigger modal -->
            <a href="#modifyModal" onclick="addTakenLectureModal()" data-toggle="modal" class="btn btn-success mb-2">수강과목 추가하기</a>
            <a href="#modifyModal" onclick="addExternalLectureModal()" data-toggle="modal" class="btn btn-default mb-2">강좌목록에 없는 과목이 있나요?</a>
        </div>
    </div>

    <div class="alert alert-success" role="alert">
        <h4 class="alert-heading">기능 소개</h4>
        <p>컴퓨터공학부 학우분들이 자주 듣는 수업은 DB화 되어있습니다. 타학과 강좌를 듣는 경우 우측에 있는 버튼을 통해 수동으로 등록해주셔야 합니다. 이 강좌 데이터들은 KUTIS에서 자동으로 받아오는 것이 아닌 관리자의 수기로 작성되는 정보들 입니다. 따라서 오류가 발생할 수 있으므로 KUTIS와 비교 바랍니다.</p>
        <hr>
        <p class="mb-0">타학과 전공은 기타 학점으로 계산됩니다.</p>
    </div>
</div>
<hr>

<!-- 수강과목 추가, 수정 Modal -->
<div class="modal fade" id="modifyModal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header text-center" id="takenModalHeader"></div>
            <div class="modal-body" id="takenModalBody"></div>
            <div class="modal-footer" id="takenModalFooter"></div>
        </div>
    </div>
</div>

<!-- 강좌목록용 wide Modal -->
<div class="modal fade" id="lectureModal" role="dialog">
    <div class="modal-xl">
        <div class="modal-content">
            <div class="modal-header text-center">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="staticBackdrop1">전체 강좌 리스트 보기</h4>
            </div>
            <div class="alert alert-warning d-flex align-items-center" role="alert">
                <div><i class="bi bi-exclamation-triangle-fill"></i> 잘못된 정보 발견 시 반드시 신고 바랍니다.</div>
            </div>
            <div class="modal-body">
                <%@include file="lecture_list.jsp"%>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
            </div>
        </div>
    </div>
</div>

<!-- 강좌목록용 wide Modal -->
<div class="modal fade" id="lectureSpecialModal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header text-center">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="staticBackdrop2">특수 강좌 리스트 보기</h4>
            </div>
            <div class="alert alert-warning d-flex align-items-center" role="alert">
                <div><i class="bi bi-exclamation-triangle-fill"></i> 잘못된 정보 발견 시 반드시 신고 바랍니다.</div>
            </div>
            <div class="modal-body">
                <%@include file="special_lecture_list.jsp"%>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
            </div>
        </div>
    </div>
</div>


<script>
    let getGraduationRequirement = <%=getGraduationRequirement%>;
<%--    학생 프로필 관련 스크립트--%>
    $(document).ready(function () {
        set_student_data();
        makeStudentButtons();
        // deleteStudentDB();
    })

    function set_student_data() {//학생정보 조건문에따라 설정
        let list = $('#student_data');
        let a = '';
        let user =<%=user%>;
        let getStudent =<%=getStudent%>;
        let currentYear = new Date().getFullYear();
        if (getStudent != null) {
            // alert("신청 수정");
            // a += '<li><div class="profile">학번</div><div class="inform"><input type="text" name="per_id" placeholder="학번을 입력해주세요" value="' + getStudent.per_id + ' "readonly/></div></li>'
            a += ''
                + '<li><div class="profile px-2">이름</div><div class="inform"><input class="form-control" type="text" id="name" name="name" placeholder="이름을 입력해주세요" value="' + getStudent.name + '" readonly/></div></li>'
                + '<li><div class="profile px-2">연락처</div><div class="inform"><input class="form-control" type="text" id="phone" name="phone" placeholder="연락처를 입력해주세요" value="' + getStudent.phone + '" readonly/></div></li>'
                + '<li><div class="profile px-2">졸업요건</div><div class="inform"><input class="form-control" id="major" value="['+getStudent.enter_year+'입학] '+getStudent.major+'" readonly/></div></li>'
                + '<li><div class="profile px-2">학년</div><div class="inform"><input class="form-control" id="grade" value="'+getStudent.grade+'" readonly/></div></li>';
        } else {
            // alert("신규 등록");
            // a += '<li><div class="profile">학번</div><div class="inform"><input type="text" name="per_id" placeholder="학번을 입력해주세요" value="' + user.per_id + ' "readonly/></div></li>'
            a += ''
                + '<li><div class="profile px-2">이름</div><div class="inform"><input class="form-control" type="text" id="name" name="name" placeholder="이름을 입력해주세요" value="' + user.name + '" readonly/></div></li>'
                + '<li><div class="profile px-2">연락처</div><div class="inform"><input class="form-control" type="text" id="phone" name="phone" placeholder="연락처를 입력해주세요" /></div></li>'
                + '<li><div class="profile px-2">졸업요건</div><div class="inform"><select class="form-control" id="major" required></select></div></li>'
                + '<li><div class="profile px-2">학년</div><div class="inform"><select class="form-control" id="grade" required><option value="1">1학년</option><option value="2">2학년</option><option value="3">3학년</option><option value="4">4학년</option></select></div></li>';
        }
        list.prepend(a);
        makeMajorList();
    }

    function makeMajorList(){
        let text = '';
        let majorSelect = $('#major');
        for (let i = 0; i < getGraduationRequirement.length; i++) {
            text += '<option value="'+i+'">['+getGraduationRequirement[i].year+'입학] '+getGraduationRequirement[i].major+'</option>';
        }
        majorSelect.html(text);
    }

    function makeStudentButtons(){
        let buttons = $('#student_button');
        let text = '';
        let getStudent =<%=getStudent%>;
        if (getStudent != null) {
            // alert("신청 수정");
            $("#agreecheck").hide();
            text+='<button class="btn btn-primary m-1" onclick="modifyStudentProfileForm()" >프로필 수정</button>';
            text+='<button class="btn btn-danger m-1" id="deleteData" onclick="deleteStudentData('+getStudent.per_id+')" >개인정보 초기화</button>';
        } else {
            // alert("신규 등록");
            text+='<button class="btn btn-success" onclick="addStudentProfile()">프로필 추가</button>';
        }
        buttons.append(text);
    }
    function deleteStudentDB(){
        let buttons = $('#student_del_button');
        let text = '';
        let getStudent =<%=getStudent%>;
        if (getStudent != null) {
            text+='<button class="btn btn-danger" id="deleteData" onclick="deleteStudentData('+getStudent.per_id+')" >개인정보 초기화</button>';
        }
        buttons.append(text);
    }

    function modifyStudentProfileForm(){
        $('#agreecheck').show();
        let list = $('#student_data');
        let a = '';
        let user =<%=user%>;
        let getStudent =<%=getStudent%>;

        a += ''
            + '<li><div class="profile px-2">이름</div><div class="inform"><input class="form-control" type="text" id="name" name="name" placeholder="이름을 입력해주세요" value="' + user.name + '" readonly/></div></li>'
            + '<li><div class="profile px-2">연락처</div><div class="inform"><input class="form-control" type="text" id="phone" name="phone" placeholder="연락처를 입력해주세요" value="'+getStudent.phone+'"/></div></li>'
            + '<li><div class="profile px-2">졸업요건</div><div class="inform"><select class="form-control" id="major" required></select></div></li>'
            + '<li><div class="profile px-2">학년</div><div class="inform"><select class="form-control" id="grade" required><option value="1">1학년</option><option value="2">2학년</option><option value="3">3학년</option><option value="4">4학년</option></select></div></li>';
        list.html(a);
        $('#student_button').html('<button class="btn btn-primary" onclick="modifyStudentProfile()" >프로필 수정</button>');
        makeMajorList();
    }

    function modifyStudentProfile(){
        const checked = $('#checkbox1').is(":checked");
        if(!checked){
            alert('사용약관에 동의해주시길 바랍니다.');
            return;
        }
        const name = $('#name').val();
        const phone = $('#phone').val();
        const major = $('#major').val();
        const grade = $('#grade').val();

        const data = user.id + '-/-/-' + name + '-/-/-' + phone + '-/-/-' + getGraduationRequirement[major].major + '-/-/-' + grade + '-/-/-' + getGraduationRequirement[major].year; //추후 전공도 추가
        $.ajax({
            url: "ajax.kgu", //AjaxAction에서
            type: "post", //post 방식으로
            data: {
                req: "modifyGcsStudent", //이 메소드를 찾아서
                data: data //이 데이터를 파라미터로 넘겨줍니다.
            },
            success: function (data) { //성공 시
                if (data == 'success') {
                    alert("프로필이 수정되었습니다.")
                    location.reload();
                }
            }
        });
    }

    function addStudentProfile(){
        const checked = $('#checkbox1').is(":checked");
        if(!checked){
            alert('사용약관에 동의해주시길 바랍니다.');
            return;
        }
        const name = $('#name').val();
        const phone = $('#phone').val();
        const major = $('#major').val();
        const grade = $('#grade').val();

        const data = user.id + '-/-/-' + name + '-/-/-' + phone + '-/-/-' + getGraduationRequirement[major].major + '-/-/-' + grade + '-/-/-' + getGraduationRequirement[major].year; //추후 전공도 추가
        $.ajax({
            url: "ajax.kgu", //AjaxAction에서
            type: "post", //post 방식으로
            data: {
                req: "addGcsStudent", //이 메소드를 찾아서
                data: data //이 데이터를 파라미터로 넘겨줍니다.
            },
            success: function (data) { //성공 시
                if (data == 'success') {
                    alert("프로필이 추가되었습니다.")
                    location.reload();
                }
            }
        });
    }
    function deleteStudentData(id){
        var check = confirm("개인정보를 초기화 하시겠습니까?");
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
                        alert('개인정보가 삭제되었습니다.')
                        location.reload();
                    }
                }
            })
        }
    }

</script>

<script>
    const getStudent = <%=getStudent%>;
    const getAllYear = <%=getAllYear%>;
    const getLecture = <%=getLecture%>;
    const getExternalLecture = <%=getExternalLecture%>;
    const getLectureHistory = <%=getLectureHistory%>;
    const getExternalLectureHistory = <%=getExternalLectureHistory%>;
    let modalHeader = $('#takenModalHeader');
    let modalBody = $('#takenModalBody');
    let modalFooter = $('#takenModalFooter');
    let total_credit = 0;
    let clicked_lectures = new Array();   //선택한 과목 리스트

    $(document).ready(function () {
        callSetupTableView();
        if(getStudent != null){
            $('#history').show();
        }
        else{
            $('#history').hide();
        }
    })

    function callSetupTableView() {
        $('#taken_table').bootstrapTable('append', data());
        $('#taken_table').bootstrapTable('refresh');
    }

    function data() {
        let rows = [];
        if (getLectureHistory != null) {
            for (let i = 0; i < getLectureHistory.length; i++) {
                let history = getLectureHistory[i];
                let lecture = history.history.split('-/@/-');
                let lecture_name = '';
                for (let j = 0; j<lecture.length; j++){
                    getLecture.forEach(function (lec) {
                        if (lec.year == history.year && lec.semester == history.semester && lec.lecture_id == lecture[j]) {
                            lecture_name = lec.name;
                        }
                    });
                    rows.push({
                        action: '<a href="#modifyModal" onClick="modifyTakenLecture(' + history.year + ',' + history.semester + ')" data-toggle="modal" class="btn btn-default">수정</a>',
                        year: history.year,
                        semester: history.semester,
                        code: lecture[j],
                        name: lecture_name //강의 리스트에서 찾기
                    });
                }
            }
        }
        if (getExternalLectureHistory != null) {
            for (let i = 0; i < getExternalLectureHistory.length; i++) {
                let history = getExternalLectureHistory[i];
                let lecture = history.history.split('-/@/-');
                console.log(lecture);
                for (let j = 0; j<lecture.length; j++){
                    rows.push({
                        action: '<a href="#modifyModal" onClick="deleteExternalLecture(' + i + ',' + j + ')" data-toggle="modal" class="btn btn-default">삭제</a>',
                        year: history.year,
                        semester: history.semester,
                        code: '-',
                        name: lecture[j] //강의 리스트에서 찾기
                    });
                }
            }
        }
        return rows;
    }

    function makeTypeList() {
        let type = $('#add_year');
        console.log(type);
        let currentYear = new Date().getFullYear();
        let text = '';
        for (let i = 2017; i <= currentYear; i++) {
            text += '<option value="' + i + '">' + i + '</option>';
        }
        type.append(text);
    }

    function addTakenLectureModal() {
        let text = '';
        modalHeader.html('<button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">&times;</span></button><h4 class="modal-title" id="staticBackdrop">수강과목 추가하기</h4>');
        text += '<div class="row"> <div class="col-md-6"><label for="add_year">연도</label><select class="form-control" id="add_year" onchange="setLectures()"> <option selected value="' + getAllYear[0].year + '">' + getAllYear[0].year + '</option>';
        for (let i = 1; i < getAllYear.length; i++) {
            text += '<option value="' + getAllYear[i].year + '">' + getAllYear[i].year + '</option>'
        }
        text += '</select></div><div class="col-md-6"><label for="add_semester">학기</label>'
            + '<select class="form-control" id="add_semester" onchange="setLectures()"> <option value="1" selected>1학기</option> <option value="2">2학기</option> <option value="여름">여름학기</option> <option value="겨울">겨울학기</option> </select></div></div>'
            +' <div class="alert alert-warning d-flex align-items-center" role="alert"> <div><i class="bi bi-exclamation-triangle-fill"></i>눌러진 버튼이 있다면 이미 추가되어 있는 과목입니다. 해당 과목을 삭제하고 싶은 경우 버튼을 눌러 눌리지 않은 상태로 만들고 추가하기 버튼을 눌러주세요.</div></div>'
            + '<div class="g-3"><div class="md-6"><label for="majorButton" class="form-label">전공</label><div id="majorButton"><span>강좌가 존재하지 않습니다.</span></div></div>'
            + '<div class="md-6"><label for="electiveButton" class="form-label">교양</label><div id="electiveButton"><span>강좌가 존재하지 않습니다.</span></div></div></div>';
        modalBody.html(text);
        modalFooter.html('<button type="button" class="btn btn-primary" id="reset_button" onclick="deleteTakenLecture()" disabled>초기화</button><button type="button" class="btn btn-default" data-dismiss="modal">취소</button><button type="button" class="btn btn-primary" id="submit_button" onclick="addTakenLecture()" disabled>추가하기</button>');
        setLectures()
    }

    function modifyTakenLecture(year, semester) {
        addTakenLectureModal();
        $('#add_year').val(year);
        $('#add_semester').val(semester);
        setLectures();
    }

    function setLectures() {
        clicked_lectures = [];
        total_credit = 0;
        let year = $('#add_year').val();
        let semester = $('#add_semester').val();
        //let grade = $('#add_grade').val();
        $('#majorButton').empty();
        $('#electiveButton').empty();
        getLecture.forEach(function (lecture) {
            if (lecture.year == year && lecture.semester == semester) {
                if (lecture.big_type == '전공')
                    $('#majorButton').append('<input type="button" id="' + lecture.lecture_id + '" class="btn btn-default m-1" name="' + lecture.credit + '" value="' + lecture.name + '" onclick=selectLecture(this)>');
                else if (lecture.big_type == '교양')
                    $('#electiveButton').append('<input type="button" id="' + lecture.lecture_id + '" class="btn btn-default m-1" name="' + lecture.credit + '" value="' + lecture.name + '" onclick=selectLecture(this)>');
            }
        });
        for(let i=0; i<getLectureHistory.length; i++){
            let takenLecture = getLectureHistory[i];
            if (takenLecture.year == year && takenLecture.semester == semester){ // && takenLecture.grade == grade
                let takenLectures = takenLecture.history.split('-/@/-');
                clicked_lectures = takenLectures; //이미 저장된 강의들의 코드
            }
        }
        for(let i=0; i<clicked_lectures.length; i++){
            const id = '#' + clicked_lectures[i];
            $(id).addClass('clicked');
            total_credit += parseInt($(id).attr("name"));
        }
        if (total_credit <= 0) {
            $("#submit_button").attr("disabled", true);
            $("#reset_button").attr("disabled", true);
        } else {
            $("#submit_button").attr("disabled", false);
            $("#reset_button").attr("disabled", false);
        }
        if(document.getElementById('majorButton').childElementCount == 0)
            $('#majorButton').html('<span>강좌가 존재하지 않습니다.</span>');
        if(document.getElementById('electiveButton').childElementCount == 0)
            $('#electiveButton').html('<span>강좌가 존재하지 않습니다.</span>');
    }

    function selectLecture(button) {
        button.blur();
        const target = button.id;
        let id = "#" + target;
        let classes = $(id).attr("class");
        console.log(classes);
        if (!classes.includes("clicked")) {
            //클릭되지않은 버튼을 클릭했을때
            $(id).addClass('clicked');
            clicked_lectures.push(target);
            total_credit += parseInt($(id).attr("name")); //총 학점 계산
        } else {
            //클릭된 버튼을 클릭 해제
            $(id).removeClass('clicked');
            let tmp = clicked_lectures.splice(clicked_lectures.indexOf(target), 1); //제거
            console.log(tmp);
            total_credit -= parseInt($(id).attr("name"));
        }
        if (total_credit <= 0) {
            $("#submit_button").attr("disabled", true);
            $("#reset_button").attr("disabled", true);
        } else {
            $("#submit_button").attr("disabled", false);
            $("#reset_button").attr("disabled", false);
        }
        if (total_credit > 24)
            alert("수강학점이 매우 높습니다.\n(현재 학점: " + total_credit + ")");
        //document.querySelector("#total_credit_label").innerHTML = total_credit; 전체학점 나타내야하나??
        // alert("NOW CLICKED: " + clicked_subject);
    }

    function addExternalLectureModal(){
        modalHeader.html('<button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">&times;</span></button><h4 class="modal-title" id="staticBackdrop">미등록 강좌 수동 추가</h4>');
        modalBody.html('<div class="alert alert-success" role="alert"><div>강좌목록에 없는 강좌를 직접 추가해주세요!</div>'
            + '<div><div><i class="bi bi-exclamation-triangle-fill"></i>수강과목 추가하기에 존재하지 않은 과목만 추가하여 주시기 바랍니다. 해당 과목을 외부 강좌로 추가하면 졸업 요건 계산에 문제가 생길 수 있습니다.</div></div>'
            + '<div> <div><i class="bi bi-exclamation-triangle-fill"></i> 재수강 한 과목은 둘 중 하나만 입력해주셔야 계산 오류가 발생하지 않습니다.</div></div>'
            + '<div> <div><i class="bi bi-exclamation-triangle-fill"></i> 타학과 전공 수업은 기타 학점으로 처리됩니다.</div></div>'
            +'</div>'
            + '<div class="row"> <div class="col-md-6"><label for="add_year">연도</label><select class="form-control" id="add_year" required></select></div>'
            + '<div class="col-md-6"> <label for="add_big_type">전공/교양</label> <select class="form-control" id="add_big_type" required> <option value="전공">전공(타과)</option> <option value="교양">교양</option> </select> </div>'
            + '<div class="col-md-6"> <label for="add_semester">학기</label> <select class="form-control" id="add_semester" required> <option value="1">1학기</option> <option value="2">2학기</option> <option value="0">계절학기</option> </select> </div>'
            //+ '<div class="col-md-6"> <label for="add_grade">학년</label> <select class="form-control" id="add_grade" required> <option value="1">1학년</option> <option value="2">2학년</option> <option value="3">3학년</option> <option value="4">4학년</option> </select> </div>'
            + '<div class="col-md-6"> <label for="add_name">과목명</label> <input type="text" class="form-control" id="add_name" placeholder="과목명을 입력해주세요(예:웹프로그래밍)"> </div>'
            + '<div class="col-md-6"> <label for="add_credit">학점</label> <select class="form-control" id="add_credit" required> <option value="3">3학점</option> <option value="2">2학점</option> <option value="1">1학점</option> </select> </div> </div>');
        modalFooter.html('<button type="button" class="btn btn-default" data-dismiss="modal">취소</button><button type="button" class="btn btn-primary" id="modify_button" onclick="addExternalLecture()">추가하기</button>');
        makeTypeList();
    }

    function addExternalLecture() {
        const year = $('#add_year').val();
        const semester = $('#add_semester').val();
        //const grade = $('#add_grade').val();
        const name = $('#add_name').val();
        const credit = $('#add_credit').val();
        const big_type = $('#add_big_type').val();
        let history = '';

        for(let i = 0; i<getExternalLectureHistory.length; i++){
            let lec = getExternalLectureHistory[i];
            if(lec.year == year && lec.semester == semester){ // && lec.grade == grade
                history = lec.history + '-/@/-';
                alert(history);
            }
        }
        history += name;
        const data = user.id + '-/-/-' + year + '-/-/-' + semester + '-/-/-' + name + '-/-/-' + credit + '-/-/-' + big_type  + '-/-/-' + history; // + '-/-/-' + grade

        $.ajax({
            url: "ajax.kgu", //AjaxAction에서
            type: "post", //post 방식으로
            data: {
                req: "addExternalLecture", //이 메소드를 찾아서
                data: data //이 데이터를 파라미터로 넘겨줍니다.
            },
            success: function (data) { //성공 시
                if (data == 'success') {
                    alert("해당 강좌가 추가되었습니다.")
                    location.reload();
                }
            }
        });
        //add_year add_semester add_grade add_name add_credit add_big_type
    }

    // function modifyExternalLecModal(index1, index2) {
    //     let info = getExternalLectureHistory[index1];
    //     let lectures = info.history.split('-/@/-');
    //     const name = lectures[index2];
    //     let ExternalLec;
    //     for(let i=0; i<getExternalLecture.length; i++){
    //         let lecture = getExternalLecture[i];
    //         if (lecture.year==info.year && lecture.semester==info.semester && lecture.name==name)
    //             ExternalLec = lecture;
    //     }
    //     console.log(ExternalLec);
    //     modalHeader.html('<h5 class="modal-title" id="staticBackdropLabel">수정하기</h5>'
    //         + '<button type="button" class="close" data-dismiss="modal" aria-label="Close">');
    //     modalBody.html('<div class="row"> <div class="col-md-6"><label for="add_year">연도</label> <select class="form-control" id="add_year" required></select></div>'
    //         + '<div class="col-md-6"> <label for="add_big_type">전공/교양</label> <select class="form-control" id="add_big_type" required> <option value="전공">전공</option> <option value="교양">교양</option> </select> </div>'
    //         + '<div class="col-md-6"> <label for="add_semester">학기</label> <select class="form-control" id="add_semester" required> <option value="1">1학기</option> <option value="2">2학기</option> <option value="0">계절학기</option> </select> </div>'
    //         + '<div class="col-md-6"> <label for="add_grade">학년</label> <select class="form-control" id="add_grade" required> <option value="1">1학년</option> <option value="2">2학년</option> <option value="3">3학년</option> <option value="4">4학년</option> </select> </div>'
    //         + '<div class="col-md-6"> <label for="add_name">과목명</label> <input type="text" class="form-control" id="add_name" value="'+name+'"> </div>'
    //         + '<div class="col-md-6"> <label for="add_credit">학점</label> <select class="form-control" id="add_credit" required> <option value="3">3학점</option> <option value="2">2학점</option> <option value="1">1학점</option> </select> </div> </div>');
    //     modalFooter.html('<button type="button" class="btn btn-default" data-dismiss="modal">취소</button><button type="button" class="btn btn-primary" id="modify_button" onclick="modifyExternalLecture(' + index1 + ',' + index2 + ')">수정</button><button type="button" class="btn btn-primary" id="delete_button" onclick="deleteExternalLecture(' + index1 + ',' + index2 + ')">삭제</button>');
    //     makeTypeList();
    // }

    // function modifyExternalLecture(index1, index2) {
    //     let big_type = $('#add_big_type');
    //     let credit = $('#add_credit');
    //     let info = getExternalLectureHistory[index1];
    //     let lectures = info.history.split('-/@/-');
    //     const name = lectures[index2];
    //     var check = confirm(name + " 과목을 정말 수정하시겠습니까?");
    //     if (check) {
    //         lectures.splice(index2, 1);
    //         let history = 'empty';
    //         if(lectures.length != 0){
    //             history = lectures[0];
    //             for(let i=1;i<lectures.length;i++)
    //                 history += '-/@/-' + lectures[i];
    //         }
    //         const data = user.id + '-/-/-' + info.year + '-/-/-' + info.semester + '-/-/-' + info.grade + '-/-/-' + name + '-/-/-' + history + '-/-/-' + big_type + '-/-/-' + credit;
    //         $.ajax({
    //             url: "ajax.kgu",
    //             type: "post",
    //             data: {
    //                 req: "deleteExternalLecture",
    //                 data: data
    //             },
    //             success: function (data) {
    //                 if (data == 'success') {
    //                     alert("add?")
    //                     addExternalLecture();
    //                     location.reload();
    //                 }
    //             }
    //         })
    //     }
    // }

    function deleteExternalLecture(index1, index2) {
        let info = getExternalLectureHistory[index1];
        let lectures = info.history.split('-/@/-');
        const name = lectures[index2];
        var check = confirm(name + " 과목을 정말 삭제하시겠습니까?");
        if (check) {
            lectures.splice(index2, 1);
            let history = 'empty';
            if(lectures.length != 0){
                history = lectures[0];
                for(let i=1;i<lectures.length;i++)
                    history += '-/@/-' + lectures[i];
            }
            const data = user.id + '-/-/-' + info.year + '-/-/-' + info.semester + '-/-/-' + name + '-/-/-' + history; // + '-/-/-' + info.grade
            $.ajax({
                url: "ajax.kgu",
                type: "post",
                data: {
                    req: "deleteExternalLecture",
                    data: data
                },
                success: function (data) {
                    if (data == 'success') {
                        alert('해당 강좌가 삭제되었습니다.')
                        location.reload();
                    }
                }
            })
        }
    }

    function addTakenLecture() {
        let selectedYear = $('#add_year').val();
        let selectedSemester = $('#add_semester').val();
        const size = clicked_lectures.length;
        if(size === 0){
            deleteTakenLecture();
            return;
        }
        let history = clicked_lectures[0];
        for (let i = 1; i < size; i++) {
            // const data = id + '-/-/-' + year + '-/-/-' + semester + '-/-/-' + name + '-/-/-' + credit + '-/-/-' + big_type;  + '-/-/-' + grade +
            history += '-/@/-' + clicked_lectures[i];
            // 학수코드1-/@/-학수코드2-/@/-학수코드3...
        }
        const data = user.id + '-/-/-' + selectedYear + '-/-/-' + selectedSemester + '-/-/-' + history; //추후 전공도 추가   + '-/-/-' + selectedGrade
        $.ajax({
            url: "ajax.kgu", //AjaxAction에서
            type: "post", //post 방식으로
            data: {
                req: "addLectureHistory", //이 메소드를 찾아서
                data: data //이 데이터를 파라미터로 넘겨줍니다.
            },
            success: function (data) { //성공 시
                if (data == 'success') {
                    alert("해당 강좌가 추가되었습니다.")
                    location.reload();
                }
            }
        });
    }

    function deleteTakenLecture(){
        let selectedYear = $('#add_year').val();
        let selectedSemester = $('#add_semester').val();
        //let selectedGrade = $('#add_grade').val();
        var check = confirm(selectedYear + "년" + selectedSemester + "학기" + "수강과목을 정말 모두 삭제하시겠습니까?");  //+ selectedGrade + "학년"
        if (check) {
            const data = user.id + '-/-/-' + selectedYear + '-/-/-' + selectedSemester;  // + '-/-/-' + selectedGrade
            $.ajax({
                url: "ajax.kgu",
                type: "post",
                data: {
                    req: "deleteTakenLecture",
                    data: data
                },
                success: function (data) {
                    if (data == 'success') {
                        alert('해당 강좌 이력이 삭제되었습니다.')
                        location.reload();
                    }
                }
            })
        }
    }
</script>

<style>
    .clicked {
        background-color: lightblue;
    }
</style>


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

    .boardtable > thead > tr > th:nth-child(2), .boardtable > tbody > tr > td:nth-child(2) {
        width: 150px;
        min-width: 30px;
    }

    .boardtable > thead > tr > th:nth-child(3), .boardtable > tbody > tr > td:nth-child(3) {
        width: 150px;
        min-width: 30px;
    }

    .boardtable > thead > tr > th:nth-child(5), .boardtable > tbody > tr > td:nth-child(5) {
        min-width: 120px;
    }

    .boardtable > thead > tr > th:nth-child(4), .boardtable > tbody > tr > th:nth-child(4) {
        width: 150px;
        min-width: 30px;
    }

    .boardtable > thead > tr > th:nth-child(1), .boardtable > tbody > tr > td:nth-child(1) {
        width: 70px;
        min-width: 50px;
    }
</style>

<style>
    .profile_info {
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
        width: 340px;
        height: 180px;
        resize: none;
    }
    #student_del_button{
        margin-top: 5px;
    }

</style>

<style>
    #lecture_table > thead > tr > th:nth-child(1), #lecture_table > tbody > tr > td:nth-child(1),
    #lecture_table > thead > tr > th:nth-child(2), #lecture_table > tbody > tr > td:nth-child(2),
    #lecture_table > thead > tr > th:nth-child(3), #lecture_table > tbody > tr > td:nth-child(3){
        display:none;
    }
</style>
<style>
    #specialLectureTable > thead > tr > th:nth-child(1), #specialLectureTable > tbody > tr > td:nth-child(1){
        display:none;
    }
    #specialLectureTable > thead > tr > th:nth-child(2), #specialLectureTable > tbody > tr > td:nth-child(2){
       width:80px;
    }
</style>