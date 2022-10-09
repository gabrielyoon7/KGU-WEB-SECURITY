<%--
  Created by IntelliJ IDEA.
  User: gabri
  Date: 2022-01-18
  Time: 오후 2:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    /**
     * v2 code
     * */
    String major = (String) session.getAttribute("subdomain");
    String curriculum = (String)request.getAttribute("text");  //커리큘럼 내용
    String getCurriculums = (String)request.getAttribute("getCurriculums");  //해당 전공 연도별 커리큘럼 사진
    String type = (String) session.getAttribute("type");
%>
<ul>
    <li style="margin-bottom : 5px;">
        <div id="maintitle" class="contenttitle"></div>
        <div id="curriculum_content"></div>
        <div id="modify_button" class="d-grid gap-2 d-md-flex justify-content-md-end"></div>
        <div id="curriculum_btn"></div>
        <div id="curriculum_view"></div>
    </li>
</ul>

<!-- 커리큘럼 추가, 수정 Modal -->
<div class="modal fade" id="staticBackdrop" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" id="curriculumModalHeader"></div>
<%--            <div class="alert alert-danger d-flex align-items-center" role="alert">--%>
<%--                <div><i class="bi bi-exclamation-triangle-fill"></i> 파일 업로드 시 파일 이름에 공백(띄어쓰기)가 포함되면 업로드 되지 않는 문제가 있습니다. (수정예정)</div>--%>
<%--            </div>--%>
            <div class="modal-body" id = "curriculumModalBody"></div>
            <div class="modal-footer" id="curriculumModalFooter"></div>
        </div>
    </div>
</div>

<script>

    $(document).ready(function(){
        makePageTitle('maintitle'); // 본문 안에 제목 넣어주는 역할 (page.jsp에서 함수를 찾아보세요)
        makeInformation();
    })

    var type = <%=type%>;
    var curriculum = <%=curriculum%>;
    var curriculumList = <%=getCurriculums%>;
    var modalHeader = $('#curriculumModalHeader');
    var modalBody = $('#curriculumModalBody');
    var modalFooter = $('#curriculumModalFooter');

    function makeInformation() {
        var data = $('#curriculum_content');
        var text = '';
        var yearButton = $('#curriculum_btn');

        if(curriculum!=null){
            text+='<p>'+curriculum.content+'</p>';

            if(type.for_header=='관리자'){
                var button = $('#modify_button');
                button.append('<button type="button" class="btn btn-default m-1" onclick="modify()">내용 수정</button>'
                    +'<a href="#staticBackdrop" onClick="addCurriculumModal()" data-toggle="modal" class="btn btn-default m-1">교육과정 추가</a>');
            }
            if(curriculumList!=null) {
                var yearCount = curriculumList.length;
                if (yearCount == 0) {
                    yearButton.remove();
                    $('#curriculum_view').remove();
                } else {
                    for (var i = 0; i < yearCount; i++) {
                        yearButton.append('<button type="button" class="btn btn-outline-primary m-1" onclick="viewImages(' + i + ')">' + curriculumList[i].year + '년 교육과정</button>');
                    }

                    viewImages(yearCount - 1);
                }
            }
        }
        data.append(text);
    }

    function modify(){  //커리큘럼 수정 화면 띄움
        var modify_button = $('#modify_button');
        var a='';
        modify_button.empty();
        a+='<textarea id="editor">'+curriculum.content+'</textarea>';
        a+='<div id="write_post" class="d-grid gap-2 d-md-flex justify-content-md-end"><button type="button" class="btn btn-outline-primary" onclick="modifyCurriculumText()">수정</button>';
        a+='<button type="button" class="btn btn-outline-secondary" onclick="back()">뒤로</button></div></div>';
        $('#curriculum_content').html(a);
        CKEDITOR.replace('editor', {
            allowedContent: true,
            height: 500,
            'filebrowserUploadUrl': 'Uploader'
        });
    }

    function back(){  //수정하기를 취소하였을 때 원래 페이지가 나오도록함
        location.reload()
    }

    function modifyCurriculumText(){  //커리큘럼 내용 수정
        var content = CKEDITOR.instances.editor.getData();
        var modify=curriculum.id+"-/-/-"+curriculum.major+"-/-/-"+content;
        alert(modify);
        $.ajax({
            url: 'ajax.kgu',
            type : 'post',
            data :{
                req : "modifyCurriculumText",
                data : modify
            },
            // dataType:"json",
            success : function(data){
                // alert(data)
                if(data != 'fail'){
                    alert('수정완료')
                    location.reload();
                }
                else{
                    alert('서버에러. 다음에 다시 시도해주세요')
                }
            }
        })
    }

    function viewImages(num){  //버튼으로 선택한 연도의 교육과정 이미지를 띄움
        var list = $('#curriculum_view');
        list.empty();
        list.append('<div>'+curriculumList[num].year+'년도 교육과정</div>'
            +'<img src='+curriculumList[num].curriculum_img+'"../../../../../../../Users/YOON" id="curriculum_'+curriculumList[num].year+'" onerror="this.src=\'http://placehold.it/300x300\'" class="img-fluid">'
            +'<div>'+curriculumList[num].year+'년도 교육과정 이수체계도</div>'
            +'<img src='+curriculumList[num].edu_img+'"../../../../../../../Users/YOON" id="edu_'+curriculumList[num].year+'" onerror="this.src=\'http://placehold.it/300x300\'" class="img-fluid">');
        if(type.for_header == '관리자')
            list.append('<div class="d-grid gap-2 d-md-flex justify-content-md-end">'
                +'<a href="#staticBackdrop" onClick="modifyCurriculumModal('+num+')" data-toggle="modal" class="btn btn-default">수정</a>'
                +'<button type="button" class="btn btn-outline-danger" onclick="deleteCurriculum('+num+')">삭제</button></div>');
    }

    function addCurriculumModal(){
        var major = <%=major%>;
        curriculumFile_path=null;
        curriculumFile_id=null;
        eduFile_id=null;
        eduFile_path=null;
        modalHeader.html('<h5 class="modal-title" id="staticBackdropLabel">추가하기</h5>');
        modalBody.html(
            '<div class="row g-3">'
            +'<div class="col-md-6">'
            +'<label for="major" class="form-label">전공</label>'
            +'<input class="form-control" id="major" value="'+major+'" readonly>'
            +'</div>'
            +'<div class="col-md-6">'
            +'<label for="year" class="form-label">연도</label>'
            +'<input class="form-control" id="year" type="number" placeholder="ex)2021">'
            +'</div>'
            +'<div class="col-md-12" id="curriculumUpload">'
            +'<label for="curriculumFile" class="form-label">커리큘럼 이미지</label>'
            +'<div class="d-flex justify-content-center mb-3">'
            +'<input type="file" class="form-control" id="curriculumFile" name="curriculumFile" accept="image/*">'
            +'<a class="btn btn-default" onclick="uploadCurriculum()">Upload</a>'
            +'</div>'
            +'</div>'
            +'<div class="col-md-12" id="eduUpload">'
            +'<label for="eduFile" class="form-label">이수체계도 이미지</label>'
            +'<div class="d-flex justify-content-center mb-3">'
            +'<input type="file" class="form-control" id="eduFile" name="eduFile" accept="image/*">'
            +'<a class="btn btn-default" onclick="uploadEdu()">Upload</a>'
            +'</div>'
            +'</div>'
            +'</div>'
        );
        modalFooter.html('<button type="button" class="btn btn-success" data-dismiss="modal">취소</button><button type="button" class="btn btn-primary" onclick="addCurriculum()">추가하기</button>');
    }

    function addCurriculum(){
        var curriculum_img = curriculumFile_path;
        var edu_img = eduFile_path;
        var major = $('#major').val();
        var year = $('#year').val();
        if(year.length != 4){
            alert('해당 연도를 4자리로 입력해주시기 바랍니다.');
            return;
        }
        if (curriculum_img == null){
            curriculum_img = "#";
        }
        if (edu_img == null){
            edu_img = "#";
        }

        $.ajax({
            url: "ajax.kgu", //AjaxAction에서
            type: "post",
            data: {
                req: "insertCurriculum", //이 메소드를 찾아서
                data: major+'-/-/-'+year+'-/-/-'+curriculum_img+'-/-/-'+edu_img //이 데이터를 파라미터로 넘겨줍니다.
            },
            success: function (data) { //성공 시
                alert('커리큘럼 이미지가 추가되었습니다.');
                location.reload();
            }
        })
    }


    function modifyCurriculumModal(num){
        var major = <%=major%>;
        curriculumFile_path=null;
        curriculumFile_id=null;
        eduFile_id=null;
        eduFile_path=null;
        modalHeader.html(
            '<h5 class="modal-title" id="staticBackdropLabel">수정하기</h5>'
        );
        modalBody.html(
            '<div class="row g-3">' +
            '<div class="col-md-6">' +
            '<label for="major" class="form-label">전공</label>' +
            '<input class="form-control" id="major" value="'+major+'" readonly>' +
            '</div>'
            +'<div class="col-md-6">' +
            '<label for="year" class="form-label">연도</label>' +
            '<input class="form-control" id="year" value="'+curriculumList[num].year+'" readonly>' +
            '</div>'
            +'<div class="col-md-12" id="curriculumUpload">' +
            '<label for="curriculumFile" class="form-label">커리큘럼 이미지</label>' +
            '<div class="d-flex justify-content-center mb-3">' +
            '<input type="file" class="form-control" name="curriculumFile" id="curriculumFile" accept="image/*">' +
            '<a class="btn btn-default" type="button" onclick="uploadCurriculum()">Upload</a>' +
            '</div>' +
            '</div>'
            +'<div class="col-md-12" id="eduUpload">' +
            '<label for="eduFile" class="form-label">이수체계도 이미지</label>' +
            '<div class="d-flex justify-content-center mb-3">' +
            '<input type="file" class="form-control" id="eduFile" name="eduFile" accept="image/*">' +
            '<a class="btn btn-default" type="button" onclick="uploadEdu()">Upload</a>' +
            '</div>' +
            '</div>'+
            '</div>'
        );
        modalFooter.html('<button type="button" class="btn btn-primary" data-dismiss="modal">취소</button><button type="button" class="btn btn-primary" onclick="modifyCurriculum('+num+')">수정하기</button>');
    }

    function modifyCurriculum(num){
        var curriculum_img = curriculumFile_path;
        var edu_img = eduFile_path;
        var major = $('#major').val();
        var year = $('#year').val();
        if(curriculum_img == null)
            curriculum_img = curriculumList[num].curriculum_img;
        if(edu_img == null)
            edu_img = curriculumList[num].edu_img;

        $.ajax({
            url: "ajax.kgu", //AjaxAction에서
            type: "post",
            data: {
                req: "modifyCurriculum", //이 메소드를 찾아서
                data: major+'-/-/-'+year+'-/-/-'+curriculum_img+'-/-/-'+edu_img //이 데이터를 파라미터로 넘겨줍니다.
            },
            success: function (data) { //성공 시
                alert('커리큘럼 이미지가 수정되었습니다.');
                location.reload();
            }
        })
    }


    var curriculumFile_id; //나중에 파일 상세정보를 uploadedFile로부터 역참조 하고싶은 경우에 사용하라고 만들어둠 (꼭 사용해야 하는 것은 아님)
    var curriculumFile_path; //파일이 업로드된 상대경로
    var curriculumFile_folder; //파일이 업로드된 상대경로
    function uploadCurriculum(){
        var formData = new FormData();
        var folder='/uploadFile/curriculum';//업로드 된 파일 folder 경로 설정은 여기에서 해줍니다. (마지막에 /가 오면 절대 안됩니다.)
        if($('input[name=curriculumFile]')[0].files[0]!=null){
            formData.append("file_data",$('input[name=curriculumFile]')[0].files[0]);
            formData.append("file_type", "image"); //전송하려는 파일 타입 설정 (제한이 없으려면 null로 한다.)
            formData.append("board_level", "0"); // board_level 제한 (부정 업로드 방지용. 교수까지 하려면 1, 학생까지 하려면 2로 설정하면 됨.)

            $.ajax({
                url : 'upload.kgu?folder='+folder,
                type : "post",
                async:false,
                data : formData,
                processData : false,
                contentType : false,
                success : function(data){//데이터는 주소
                    if(data=='fail'){
                        alert('실패');
                    }
                    else {
                        alert('업로드 성공')
                        var fileLog=data.split("-/-/-");
                        var a='';
                        curriculumFile_id=fileLog[0];
                        curriculumFile_path=folder+'/'+fileLog[1];
                        curriculumFile_folder=folder;
                        a+='<div>파일제출</div><div>'+fileLog[1]+'</div>';
                        a+='<div><a href="download.kgu?id='+curriculumFile_id+'&&path='+curriculumFile_folder+'" target="_blank"><button class="btn btn-secondary"><i class="bi bi-download"></i> 다운로드</button></a>'
                        a+='<button class="btn btn-danger" onclick="modifyCurriculumFile(\'curriculum\')"><i class="bi bi-x-circle-fill"></i> 첨부파일 수정하기</button></div>';
                        $('#curriculumUpload').html(a);
                    }
                }
            })
        }else{
            alert('파일을 등록해주세요.');
        }
        return address;
    }

    var eduFile_id; //나중에 파일 상세정보를 uploadedFile로부터 역참조 하고싶은 경우에 사용하라고 만들어둠 (꼭 사용해야 하는 것은 아님)
    var eduFile_path; //파일이 업로드된 상대경로
    var eduFile_folder; //파일이 업로드된 상대경로

    function uploadEdu(){
        var formData = new FormData();
        var folder='/uploadFile/curriculum';//업로드 된 파일 folder 경로 설정은 여기에서 해줍니다. (마지막에 /가 오면 절대 안됩니다.)
        if($('input[name=eduFile]')[0].files[0]!=null){
            formData.append("file_data",$('input[name=eduFile]')[0].files[0]);
            formData.append("file_type", "image"); //전송하려는 파일 타입 설정 (제한이 없으려면 null로 한다.)
            formData.append("board_level", "0"); // board_level 제한 (부정 업로드 방지용. 교수까지 하려면 1, 학생까지 하려면 2로 설정하면 됨.)

            $.ajax({
                url : 'upload.kgu?folder='+folder,
                type : "post",
                async:false,
                data : formData,
                processData : false,
                contentType : false,
                success : function(data){//데이터는 주소
                    if(data=='fail'){
                        alert('실패');
                    }
                    else {
                        var fileLog=data.split("-/-/-");
                        var a='';
                        eduFile_id=fileLog[0];
                        eduFile_folder=folder;
                        eduFile_path=folder+'/'+fileLog[1];
                        a+='<div>파일제출</div><div>'+fileLog[1]+'</div>';
                        a+='<div><a href="download.kgu?id='+eduFile_id+'&&path='+eduFile_folder+'" target="_blank"><button class="btn btn-secondary"><i class="bi bi-download"></i> 다운로드</button></a>'
                        a+='<button class="btn btn-danger" onclick="modifyCurriculumFile(\'edu\')"><i class="bi bi-x-circle-fill"></i> 첨부파일 수정하기</button></div>';
                        $('#eduUpload').html(a);
                    }
                }
            })
        }else{
            alert('파일을 등록해주세요.');
        }
        return address;
    }

    function deleteCurriculum(num) {
        var major = <%=major%>;
        var year = curriculumList[num].year;
        if(confirm('정말로 삭제하시나요? 다시 되돌릴 수 없습니다.')){
            $.ajax({
                url: "ajax.kgu", //AjaxAction에서
                type: "post",
                data: {
                    req: "deleteCurriculum", //이 메소드를 찾아서
                    data: major + '-/-/-' + year //이 데이터를 파라미터로 넘겨줍니다.
                },
                success: function (data) { //성공 시
                    alert('커리큘럼이 삭제되었습니다.');
                    location.reload();
                }
            })
        }
    }

    function modifyCurriculumFile(type){
        var file_id;
        var file_folder;
        var text = '';
        if(type == 'curriculum'){
            file_id = curriculumFile_id;
            file_folder = curriculumFile_folder;
            text = '<label for="curriculumFile" class="form-label">커리큘럼 이미지</label><div class="d-flex justify-content-center mb-3"><input type="file" class="form-control" name="curriculumFile" id="curriculumFile" accept="image/*"><a class="btn btn-secondary" type="button" onclick="uploadCurriculum()">Upload</a></div>';
        }
        else if(type == 'edu'){
            file_id = eduFile_id;
            file_folder = eduFile_folder;
            text = '<label for="eduFile" class="form-label">이수체계도 이미지</label><div class="d-flex justify-content-center mb-3"><input type="file" class="form-control" id="eduFile" name="eduFile" accept="image/*"><a class="btn btn-secondary" type="button" onclick="uploadEdu()">Upload</a></div>';
        }
        $.ajax({
            url: 'delete.kgu?fileId=' + file_id + '&&folder=' + file_folder,
            type: 'post',
            success: function (data) {//데이터는 주소
                $('#'+type+'Upload').html(text);
            }
        })
    }
</script>
