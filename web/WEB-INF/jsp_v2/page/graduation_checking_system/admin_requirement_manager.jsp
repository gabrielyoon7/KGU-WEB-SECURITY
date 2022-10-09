<%--
  Created by IntelliJ IDEA.
  User: YOON
  Date: 2021-09-05
  Time: 오전 1:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String major = (String) request.getAttribute("major");
    String year = (String) request.getAttribute("year");

    String EngineeringRequirement = (String) request.getAttribute("getEngineeringRequirement");
    String getOneGraduationRequirement = (String) request.getAttribute("getOneGraduationRequirement");
    String getSpecialLecture = (String) request.getAttribute("getSpecialLecture");
    String getLecture = (String) request.getAttribute("getLecture");
    String getLectureByCode = (String) request.getAttribute("getLectureByCode");
    String getTrackRequirement = (String) request.getAttribute("getTrackRequirement");
//    System.out.println(getTrackRequirement);
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
            <div class="modal-header" id="specialLectureModalHeader">
            </div>
            <div class="modal-body" id="specialLectureModalBody"></div>
            <div class="modal-footer" id="specialLectureModalFooter">
            </div>
        </div>
    </div>
</div>
<%--수정 제안 시작--%>
<div id="currentInfo"></div>
<div class="py-3">
    <div class="row">
        <div class="col-xs-12" id="graduation_requirement_modify"></div>
    </div>
    <div class="row">
        <div class="text-right py-3"><button class="btn btn-primary" onclick="modifyGraduationRequirement()">졸업요건 수정하기</button></div>
    </div>
</div>
<hr>
<div class="py-3">
    <div class="row">
        <div class="col-xs-12" id="engineering_requirement_modify"></div>
    </div>
    <div class="row">
        <div class="text-right py-3"><button class="btn btn-primary" onclick="modifyEngineeringRequirement()">공학인증요건 수정하기</button></div>
    </div>
<%--    <div class="row py-4">--%>
<%--        <div class="col-xs-12" id="electiveLectures">--%>
<%--            <div class="d-flex justify-content-between py-3">--%>
<%--                <div>--%>
<%--                    <h3>필수이수과목</h3>--%>
<%--                </div>--%>
<%--                <div>--%>
<%--                    <button class="btn btn-success mt-4" onclick="addElectiveLectures()">과목 입력칸 추가</button>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--    <div class="row">--%>
<%--        <div class="text-right col-xs-12"><button class="btn btn-primary" onclick="modifyElectiveLectures()">필수과목 전체 저장하기</button></div>--%>
<%--    </div>--%>
    <div class="row py-4">
        <div class="col-xs-12" id="lectureOrder">
            <div class="d-flex justify-content-between py-3">
                <div>
                    <h3>공학인증용 선후수 과목</h3>
                </div>
                <div>
                    <button class="btn btn-success mt-4" onclick="addLectureOrder()">과목 입력칸 추가</button>
                </div>
            </div>
            <div class="alert alert-warning d-flex align-items-center" role="alert">
                <div><i class="bi bi-exclamation-triangle-fill"></i>수정, 삭제, 추가를 포함한 수정을 할 때 모두 수정하기 버튼을 눌러야 저장됩니다. 학수 코드의 대소문자를 정확하게 입력해주셔야 합니다.</div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="text-right col-xs-12 py-2"><button class="btn btn-primary" onclick="modifyLectureOrder()">공학인증 선후수 조건 수정하기</button></div>
    </div>
</div>
<hr>
<div class="py-3">
    <div class="row">
        <div class="col-xs-12" id="specialLecture">
            <div class="d-flex justify-content-between py-3">
                <div>
                    <h3>특별한 강좌 지정하기</h3>
                </div>
                <div>
                    <a href="#staticBackdrop" onclick="addSpecialLectureModal()" data-toggle="modal"
                       class="btn btn-success mt-4">등록 하기</a>
                </div>
            </div>
            <%@include file="special_lecture_list.jsp"%>
        </div>
    </div>
</div>
<hr>
<div class="py-3">
    <div class="row">
        <div class="col-xs-12" id="trackRequirement">
            <div class="d-flex justify-content-between py-3">
                <div>
                    <h3>트랙 요건 관리하기</h3>
                </div>
                <div>
                    <a href="#staticBackdrop" onclick="addTrackRequirementModal()" data-toggle="modal"
                       class="btn btn-success mt-4">등록 하기</a>
                </div>
            </div>
            <%
                if(getTrackRequirement.equals("[]")){ //삭제 금지
            %>
            <div class="text-danger">등록된 트랙이 없습니다.</div>
            <%
                }else{ //삭제 금지
            %>
            <table class="boardtable" id="track_requirement_table" data-toggle="table"
                   data-pagination="true" data-toolbar="#toolbar"
                   data-search="true" data-side-pagination="true" data-click-to-select="true"
                   data-page-list="[20]">
                <thead>
                <tr>
                    <th data-field="action">-</th>
                    <th data-field="code" data-sortable="true">시스템코드</th>
                    <th data-field="chart_id" data-sortable="true">차트코드</th>
                    <th data-field="name" data-sortable="true">트랙이름</th>
                    <th data-field="credit" data-sortable="true">학점</th>
                </tr>
                </thead>
            </table>
            <%
                } //삭제 금지
            %>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        makeCurrentInfo();
        makeGraduationRequirementModify();
        makeEngineeringRequirementModify();
        // makeElectiveLectures();
        makeLectureOrder();
        callSetupTrackRequirementTableView();
    })
    let major = <%=major%>;
    let year = <%=year%>;
    let getSpecialLecture =<%=getSpecialLecture%>;
    let getLectureByCode = <%=getLectureByCode%>;
    let clicked_lectures = new Array();
    let getTrackRequirement = <%=getTrackRequirement%>;

    function makeCurrentInfo(){
        let title = $('#currentInfo');
        let text = '';
        text+='<h1><b>['+year+'학번] '+major +'관리 페이지</b></h1>';
        title.append(text);
    }

    function makeGraduationRequirementModify() {
        let list = $('#graduation_requirement_modify');
        let a = '';
        let getOneGraduationRequirement = <%=getOneGraduationRequirement%>;

        a += '<div class="profile px-2 py-4"><h2><b>경기대졸업요건</b></h2></div>'
            + '<div class="px-2">'
            + '<div class="row"> '
            + '<div class="col-xs-4"><div class="profile">전체 학점</div><div class="inform"><input class="form-control" type="number"  id="a_all_credit" name="a_all_credit" value="' + getOneGraduationRequirement.all_credit + '" /></div></div>'
            + '<div class="col-xs-4"><div class="profile">전체 전공학점</div><div class="inform"><input class="form-control" type="number" id="a_major_credit" name="a_major_credit" value="' + getOneGraduationRequirement.major_credit + '" /></div></div>'
            + '<div class="col-xs-4"><div class="profile">전체 교양학점</div><div class="inform"><input class="form-control" type="number"  id="a_elective_credit" name="a_elective_credit" value="' + getOneGraduationRequirement.elective_credit + '" /></div></div>'
            + '</div>'
            + '<div class="row">'
            + '<div class="col-xs-3"><div class="profile">전공 필수 개수</div><div class="inform"><input class="form-control" type="number" id="a_major_essential" name="a_major_essential" value="' + getOneGraduationRequirement.major_essential + '" /></div></div>'
            + '<div class="col-xs-3"><div class="profile">전공 선택 개수</div><div class="inform"><input class="form-control" type="number" id="a_major_selective" name="a_major_selective" value="' + getOneGraduationRequirement.major_selective + '" /></div></div>'
            + '<div class="col-xs-3"><div class="profile">진성애 학점</div><div class="inform"><input class="form-control" type="number" id="a_jin_seong_ae_credit" name="a_jin_seong_ae_credit" value="' + getOneGraduationRequirement.jin_seong_ae_credit + '" /></div></div>'
            + '<div class="col-xs-3"><div class="profile">수리와과학(MSC) 학점</div><div class="inform"><input class="form-control" type="number" id="a_msc_credit" name="a_msc_credit" value="' + getOneGraduationRequirement.msc_credit + '" /></div></div>'
            + '</div>'
            +'</div>';
        list.append(a);
    }

    function makeEngineeringRequirementModify(){
        let list = $('#engineering_requirement_modify');
        let EngineeringRequirement = <%=EngineeringRequirement%>;
        let a = '';

        // alert("신청 수정");
        // a += '<li><div class="profile">학번</div><div class="inform"><input type="text" name="per_id" placeholder="학번을 입력해주세요" value="' + getStudent.per_id + ' "readonly/></div></li>'
        a += '<div class="profile px-2 py-4"><h2><b>공학인증요건</b></h2></div>'
            + '<div class="px-2">'
            + '<div class="row">'
            + '<div class="col-xs-3"><div class="profile">BSM 학점</div><div class="inform"><input class="form-control" type="number" id="b_bsm_credit" name="b_bsm_credit" value="' + EngineeringRequirement.bsm_credit + '" /></div></div>'
            + '<div class="col-xs-3"><div class="profile px-2">전문교양 학점</div><div class="inform"><input class="form-control" type="number" id="b_elective_credit" name="b_elective_credit" value="' + EngineeringRequirement.elective_credit + '" /></div></div>'
            + '<div class="col-xs-3"><div class="profile px-2">설계 학점</div><div class="inform"><input class="form-control" type="number" id="b_design_credit" name="b_design_credit" value="' + EngineeringRequirement.design_credit + '" /></div></div>'
            + '<div class="col-xs-3"><div class="profile px-2">전공 학점</div><div class="inform"><input class="form-control" type="number" id="b_major_credit" name="b_major_credit" value="' + EngineeringRequirement.major_credit + '" /></div></div>'
            + '</div>'
            +'</div>';
        list.append(a);
    }


    function modifyGraduationRequirement(){
        var all_credit=$('#a_all_credit').val();
        var major_credit=$('#a_major_credit').val();
        var elective_credit=$('#a_elective_credit').val();
        var major_essential = $('#a_major_essential').val();
        var major_selective=$('#a_major_selective').val();
        var jin_seong_ae_credit=$('#a_jin_seong_ae_credit').val();
        var msc_credit = $('#a_msc_credit').val();

        var data= major+'-/-/-'+year+'-/-/-'+all_credit +'-/-/-'+major_credit+'-/-/-'+elective_credit+'-/-/-'+major_essential +'-/-/-'+major_selective+'-/-/-'+jin_seong_ae_credit+'-/-/-'+ msc_credit ;

        $.ajax({
            url: "ajax.kgu", //AjaxAction에서
            type: "post", //post 방식으로
            data: {
                req: "modifyGraduationRequirement", //이 메소드를 찾아서
                data: data //이 데이터를 파라미터로 넘겨줍니다.
            },
            success: function (data) { //성공 시
                alert('수정되었습니다.');
                location.reload();
            }
        })
    }

    function modifyEngineeringRequirement(){
        var bsm_credit=$('#b_bsm_credit').val();
        var elective_credit=$('#b_elective_credit').val();
        var design_credit=$('#b_design_credit').val();
        var major_credit = $('#b_major_credit').val();

        var data= major+'-/-/-'+year+'-/-/-'+bsm_credit +'-/-/-'+elective_credit+'-/-/-'+design_credit+'-/-/-'+major_credit;

        $.ajax({
            url: "ajax.kgu", //AjaxAction에서
            type: "post", //post 방식으로
            data: {
                req: "modifyEngineeringRequirement", //이 메소드를 찾아서
                data: data //이 데이터를 파라미터로 넘겨줍니다.
            },
            success: function (data) { //성공 시
                location.reload();
            }
        })
    }

    let electiveLecturesLength = 0;
    <%--function makeElectiveLectures(){--%>
    <%--    let list = $('#electiveLectures');--%>
    <%--    let text='';--%>
    <%--    let EngineeringRequirement = <%=EngineeringRequirement%>;--%>
    <%--    let temp = EngineeringRequirement.elective_lectures;--%>
    <%--    let electiveLectures=temp.split('-/@/-');--%>
    <%--    console.log('makeElectiveLectures'+electiveLectures.length);--%>
    <%--    console.log('makeElectiveLectures'+electiveLectures);--%>
    <%--    if(electiveLectures!=''){ //이거 왜 안먹힘?--%>
    <%--        for(let i = 0 ; i<electiveLectures.length; i++){--%>
    <%--            text+='<div class="d-flex justify-content-between py-2 col-xs-3" id="elective_lecture'+i+'"><input class="form-control elective_lecture" type="text" id="b_elective_lecture'+i+'" name="b_elective_lecture" value="' + electiveLectures[i] + '" /><button class="btn btn-danger" onclick="removeElectiveLecture(\'elective_lecture'+i+'\')">삭제</button></div>';--%>
    <%--            electiveLecturesLength=i;--%>
    <%--        }--%>
    <%--    }--%>
    <%--    list.append(text);--%>
    <%--}--%>

    function addElectiveLectures(){
        let list = $('#electiveLectures');
        let text='';
        electiveLecturesLength+=1;
        text+='<div class="d-flex justify-content-between py-2 col-xs-3" id="elective_lecture'+electiveLecturesLength+'"><input class="form-control elective_lecture" type="text" id="b_elective_lecture'+electiveLecturesLength+'" name="b_elective_lecture" /><button class="btn btn-danger" onclick="removeElectiveLecture(\'elective_lecture'+electiveLecturesLength+'\')">삭제</button></div>';
        list.append(text);
    }

    function modifyElectiveLectures(){
        let length = $("input[name=b_elective_lecture]").length;
        for(let i=0; i<length; i++) {
            if($("input[name=b_elective_lecture]").eq(i).val()==''){
                alert('빈 칸이 1곳 이상 있습니다. 다시 입력해주세요');
                return
            }
        }
        let data = '';
        if(length>0){
            data += $("input[name=b_elective_lecture]").eq(0).val();
            for(let i=1; i<length; i++) {
                data += '-/@/-'+$("input[name=b_elective_lecture]").eq(i).val();
            }
        }
        if(length==0){
            data+='#';
        }
//        alert('저장할 과목 : '+data);
        $.ajax({
            url: "ajax.kgu", //AjaxAction에서
            type: "post", //post 방식으로
            data: {
                req: "modifyElectiveLectures", //이 메소드를 찾아서
                data: major+'-/-/-'+year+'-/-/-'+data //이 데이터를 파라미터로 넘겨줍니다.
            },
            success: function (data) { //성공 시
                alert('수정되었습니다.');
                location.reload();
            }
        })
    }

    function removeElectiveLecture(elective_lecture_id){
        $('div').remove('#'+elective_lecture_id);
    }


    let lectureOrderLength = 0;
    function makeLectureOrder(){
        let list = $('#lectureOrder');
        let EngineeringRequirement = <%=EngineeringRequirement%>;
        let temp = EngineeringRequirement.lecture_order;
        let lectureOrder=temp.split('-/@/-');
        let text = '';
        console.log('makeLectureOrder'+lectureOrder.length);
        console.log('makeLectureOrder'+lectureOrder);
        if(lectureOrder!=''){ //이거 왜 안먹힘?
            for(let i = 0 ; i<lectureOrder.length; i++){
                let lectures = lectureOrder[i].split('->');
                let former_lecture = lectures[0];
                let later_lecture = lectures[1];
                text+='<div class="d-flex justify-content-between py-2" id="lecture_order'+i+'">'
                    +'<div>선수과목</div>'
                    +'<div><input class="form-control lecture_order col-xs-3" type="text" id="b_former_lecture_order'+i+'" name="b_lecture_order" value="' + former_lecture + '"/></div>'
                    +'<div>후수과목</div>'
                    +'<div><input class="form-control lecture_order col-xs-3" type="text" id="b_later_lecture_order'+i+'" name="b_lecture_order" value="' + later_lecture + '"/></div>'
                    +'<button class="btn btn-danger" onclick="removeLectureOrder(\'lecture_order'+i+'\')">삭제</button>'
                    +'</div>';
                lectureOrderLength=i;
            }
        }
        list.append(text);
    }
    function addLectureOrder(){
        let list = $('#lectureOrder');
        let text='';
        lectureOrderLength+=1;
        text+='<div class="d-flex justify-content-between py-2" id="lecture_order'+lectureOrderLength+'">'
            +'<div>선수과목</div><div><input class="form-control lecture_order col-xs-3" type="text" id="b_former_lecture_order'+lectureOrderLength+'" name="b_lecture_order" /></div>'
            +'<div>후수과목</div><div><input class="form-control lecture_order col-xs-3" type="text" id="b_later_lecture_order'+lectureOrderLength+'" name="b_lecture_order" /></div>'
            +'<button class="btn btn-danger" onclick="removeLectureOrder(\'lecture_order'+lectureOrderLength+'\')">삭제</button>'
            +'</div>';
        list.append(text);
    }
    function modifyLectureOrder(){
        let length = $("input[name=b_lecture_order]").length;
        for(let i=0; i<length; i++) {
            if($("input[name=b_lecture_order]").eq(i).val()==''){
                alert('빈 칸이 1곳 이상 있습니다. 다시 입력해주세요');
                return
            }
        }
        let data = '';
        if(length>0){
            data += $("input[name=b_lecture_order]").eq(0).val();
            for(let i=1; i<length; i++) {
                if(i%2==1){
                    data += '->';
                }
                if(i%2==0){
                    data += '-/@/-';
                }
                data += $("input[name=b_lecture_order]").eq(i).val();
            }
        }
        if(length==0){
            data+='#';
        }
//        alert('저장할 과목 : '+data);
        $.ajax({
            url: "ajax.kgu", //AjaxAction에서
            type: "post", //post 방식으로
            data: {
                req: "modifyLectureOrder", //이 메소드를 찾아서
                data: major+'-/-/-'+year+'-/-/-'+data //이 데이터를 파라미터로 넘겨줍니다.
            },
            success: function (data) { //성공 시
                alert('수정되었습니다.');
                location.reload();
            }
        })
    }
    function removeLectureOrder(lecture_order_id){
        $('div').remove('#'+lecture_order_id);
    }

    function addSpecialLectureModal(){
        let modalHeader = $('#specialLectureModalHeader');
        let textHeader = '';
        let modalBody = $('#specialLectureModalBody');
        let textBody = '';
        let modalFooter = $('#specialLectureModalFooter');
        let textFooter = '';

        textHeader = '<button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">&times;</span></button><h4 class="modal-title" id="staticBackdrop">특수 강좌 지정하기</h4>';
        modalHeader.html(textHeader);
        textBody += '<div>종류</div><select class="form-control" id="special_lecture_type" name="special_lecture_type" value="" required onchange="setLectures()">'
            + '<option value="MSC">MSC</option>'
            + '<option value="BSM">BSM</option>'
            + '<option value="major_essential">전공필수</option>'
            + '<option value="major_selective">선택필수</option>'
            + '<option value="jin_seong_ae">진성애</option>'
            + '<option value="special_elective">전문교양</option>'
            + '<option value="essential">필수과목</option>'

        //학번에 따른 트랙 선택지 만듦
        for(let i = 0 ; i < getTrackRequirement.length ; i++){
            textBody+= '<option value="'+getTrackRequirement[i].code+'">트랙('+getTrackRequirement[i].name+')</option>'
        }

        textBody += '</select>';

        textBody += '<div><label for="major" class="form-label">전공</label><div id="majorButton"></div><label for="electiveButton" class="form-label">교양</label><div id="electiveButton"></div></div>';

        modalBody.html(textBody);
        textFooter = '<button type="button" class="btn btn-default" data-dismiss="modal">취소</button><button type="button" class="btn btn-primary" id="modify_button" onclick="addSpecialLecture()">추가하기</button>';

        modalFooter.html(textFooter);
        setLectures();
    }

    function setLectures() {
        clicked_lectures = [];
        $('#majorButton').empty();
        $('#electiveButton').empty();
        let type = $('#special_lecture_type').val();
        for (let i=0;i<getSpecialLecture.length;i++){
            if(getSpecialLecture[i].type == type){
                clicked_lectures.push(getSpecialLecture[i].lecture_id);
            }
        }
        getLectureByCode.forEach(function (lecture) {
            if (lecture.big_type == '전공')
                $('#majorButton').append('<input type="button" id="' + lecture.lecture_id + '" class="btn btn-default m-1" name="' + lecture.credit + '" value="' + lecture.name + '" onclick=selectLecture(this)>');
            else if (lecture.big_type == '교양')
                $('#electiveButton').append('<input type="button" id="' + lecture.lecture_id + '" class="btn btn-default m-1" name="' + lecture.credit + '" value="' + lecture.name + '" onclick=selectLecture(this)>');
        });
        for(let i=0; i<clicked_lectures.length; i++){
            const id = '#' + clicked_lectures[i];
            $(id).addClass('clicked');
        }
    }

    function selectLecture(button) {
        button.blur();
        const target = button.id;
        let id = "#" + target;
        let classes = $(id).attr("class");
        if (!classes.includes("clicked")) {
            //클릭되지않은 버튼을 클릭했을때
            $(id).addClass('clicked');
            clicked_lectures.push(target);
        } else {
            //클릭된 버튼을 클릭 해제
            $(id).removeClass('clicked');
            let tmp = clicked_lectures.splice(clicked_lectures.indexOf(target), 1); //제거
        }
    }

    function addSpecialLecture(){
        let type = $('#special_lecture_type').val();
        const size = clicked_lectures.length;
        let lectures = clicked_lectures[0];
        for (let i = 1; i < size; i++) {
            lectures += '-/@/-' + clicked_lectures[i];
            // 학수코드1-/@/-학수코드2-/@/-학수코드3...
        }
        const data = year + '-/-/-' + major + '-/-/-' + type + '-/-/-' + lectures; //추후 전공도 추가   + '-/-/-' + selectedGrade
        $.ajax({
            url: "ajax.kgu", //AjaxAction에서
            type: "post", //post 방식으로
            data: {
                req: "addSpecialLecture", //이 메소드를 찾아서
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

    function callSetupTrackRequirementTableView(){
        $('#track_requirement_table').bootstrapTable('append',trackRequirementData());
        $('#track_requirement_table').bootstrapTable('refresh');
    }

    function trackRequirementData(){
        var rows = [];
        if(getTrackRequirement!=null){
            for(var i=0; i<getTrackRequirement.length; i++){
                var trackRequirement=getTrackRequirement[i];
                rows.push({
                    action : '<button class="btn btn-danger" onclick="deleteTrackRequirement('+i+')">삭제</button>',
                    code: trackRequirement.code,
                    chart_id : trackRequirement.chart_id,
                    name: trackRequirement.name,
                    credit : trackRequirement.credit
                });
            }
        }
        return rows;
    }

    function addTrackRequirementModal(){
        let modalHeader = $('#specialLectureModalHeader');
        let textHeader = '';
        let modalBody = $('#specialLectureModalBody');
        let textBody = '';
        let modalFooter = $('#specialLectureModalFooter');
        let textFooter = '';

        textHeader = '<button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">&times;</span></button><h4 class="modal-title" id="staticBackdrop">트랙 요건 지정하기</h4>';
        modalHeader.html(textHeader);

        textBody = '<div class="alert alert-warning d-flex align-items-center" role="alert"> <div><i class="bi bi-exclamation-triangle-fill"></i>시스템 코드와 차트ID는 다른 트랙과 절대 겹칠 수 없습니다. 영어로만 작성해주셔야 합니다. 트랙 요건을 비우는 경우 트랙이 없는 학번으로 여겨집니다. 트랙을 추가하는 경우 위 메뉴인 특별한 강좌 지정하기에도 연동됩니다.</div></div>'
                + '<div> <label for="add_code">시스템 코드</label> <input type="text" class="form-control" id="add_code" placeholder="예시와 비슷하게 영문자로 시스템 코드를 입력해주세요(예:software_science)"> </div>'
                + '<div> <label for="add_chart_id">차트ID</label> <input type="text" class="form-control" id="add_chart_id" placeholder="예시와 비슷하게 영문자로 HTML용 코드를 입력해주세요(예:SoftwareScience)"> </div>'
                + '<div> <label for="add_name">트랙 이름</label> <input type="text" class="form-control" id="add_name" placeholder="트랙 이름을 입력해주세요(예:소프트웨어과학)"> </div>'
                + '<div> <label for="add_credit">학점</label> <input type="number" class="form-control" id="add_credit" placeholder="학점을 입력해주세요(예:21)"> </div>';
        modalBody.html(textBody);

        textFooter = '<button type="button" class="btn btn-default" data-dismiss="modal">취소</button><button type="button" class="btn btn-primary" id="modify_button" onclick="addTrackRequirement()">추가하기</button>';
        modalFooter.html(textFooter);
    }

    function addTrackRequirement(){
        let code = $('#add_code').val();
        let name = $('#add_name').val();
        let credit = $('#add_credit').val();
        let chart_id = $('#add_chart_id').val();
        let data = year + '-/-/-' + major + '-/-/-' +code + '-/-/-'+chart_id+ '-/-/-' +name + '-/-/-' +credit;

        $.ajax({
            url: "ajax.kgu", //AjaxAction에서
            type: "post", //post 방식으로
            data: {
                req: "addTrackRequirement", //이 메소드를 찾아서
                data: data //이 데이터를 파라미터로 넘겨줍니다.
            },
            success: function (data) { //성공 시
                alert('트랙 정보가 추가되었습니다.');
                location.reload();
            }
        })
    }

    function deleteTrackRequirement(index){
        let data = getTrackRequirement[index].oid;
        console.log(getTrackRequirement[index]);
        var check = confirm("정말 삭제하시겠습니까?");
        if (check) {
            $.ajax({
                url: "ajax.kgu",
                type: "post",
                data: {
                    req: "deleteTrackRequirement",
                    data: data
                },
                success: function (data) {
                    if (data == 'success') {
                        alert('해당 트랙 정보가 삭제되었습니다.')
                        location.reload();
                    }
                }
            })
        }
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

    .clicked {
        background-color: lightblue;
    }
</style>