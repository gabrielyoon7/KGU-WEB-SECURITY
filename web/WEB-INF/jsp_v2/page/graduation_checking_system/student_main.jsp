<%--
  Created by IntelliJ IDEA.
  User: gabri
  Date: 2021-08-28
  Time: 오후 12:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String getStudent = (String) request.getAttribute("getStudent");
    String getOneGraduationRequirement = (String) request.getAttribute("getOneGraduationRequirement");
    String getOneEngineeringRequirement = (String) request.getAttribute("getOneEngineeringRequirement");
    String getUserExternalLecture = (String) request.getAttribute("getUserExternalLecture");
    String getLectureHistory = (String) request.getAttribute("getLectureHistory");
    String getLecture = (String) request.getAttribute("getLecture");
    String getSpecialLecture = (String) request.getAttribute("getSpecialLecture");
    String getTrackRequirement = (String) request.getAttribute("getTrackRequirement");
    String getLectureByCode = (String) request.getAttribute("getLectureByCode");
    String getSimilarSub = (String) request.getAttribute("getSimilarSub");
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
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script>
<style>
    .card {
        position: relative;
        display: flex;
        flex-direction: column;
        min-width: 0;
        word-wrap: break-word;
        background-color: #fff;
        background-clip: border-box;
        border: 1px solid rgba(0, 0, 0, .125);
        border-radius: .7rem;
        margin-bottom: 2.2rem;
        border: none;
        box-shadow: 0 0 1px rgb(0 0 0 / 13%), 0 1px 3px rgb(0 0 0 / 20%);
    }
    .mouse-over-light:hover {
        background-color: rgba(202, 224, 255, 0.15);
    }
    .card-full {
        position: relative;
        /*display: flex;*/
        flex-direction: column;
        min-width: 0;
        word-wrap: break-word;
        background-color: #fff;
        background-clip: border-box;
        border: 1px solid rgba(0, 0, 0, .125);
        border-radius: .7rem
    }
    .progress-bar {
        width: 0;
        animation: progress 1.5s ease-in-out forwards;
    }
    @keyframes progress {
        from {
            width: 0;
        }
    }
    .accordion {
        /*background-color: #eee;*/
        color: #444;
        cursor: pointer;
        padding: 18px;
        width: 100%;
        border: none;
        text-align: left;
        outline: none;
        font-size: 15px;
        transition: 0.4s;
    }
    .panel {
        padding: 0 18px;
        background-color: white;
        max-height: 0;
        overflow: hidden;
        transition: max-height 0.2s ease-out;
    }
</style>
<div class="row align-items-center py-5">
<%--    <c:if test="${user==null}">--%>
<%--        &lt;%&ndash;    비로그인 상태에서만 나옴 start&ndash;%&gt;--%>
<%--        <div class="alert alert-warning d-flex align-items-center" role="alert">--%>
<%--            <div><i class="bi bi-exclamation-triangle-fill"></i> 로그인이 필요한 서비스입니다.</div>--%>
<%--        </div>--%>
<%--        &lt;%&ndash;    비로그인 상태에서만 나옴 end&ndash;%&gt;--%>
<%--    </c:if>--%>
<%--    <c:if test="${user!=null}">--%>
        <%
            if (getStudent.equals("null")) { //잘못된거 아니니깐 삭제하지 마세요
        %>
        <%--    로그인은 했지만 사용 등록을 하지 않은 경우 start--%>
        <div class="row">
            <div class="col-xs-12 mb-5">
                <div class="card-full bg-light p-5">
                    <div class="row" id="student_data">
                        <div class="px-5"><a class="text-primary" href="graduation_checking_system.kgu?num=122">수강이력
                            입력하기</a> 페이지에서 프로필을 작성해주세요!
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%--    로그인은 했지만 사용 등록을 하지 않은 경우 end--%>
        <%
        } else { //잘못된거 아니니깐 삭제하지 마세요
        %>
        <div class="alert alert-danger d-flex align-items-center" role="alert">
            <div><i class="bi bi-exclamation-triangle-fill"></i> 컴퓨터공학전공 ↔ 인공지능전공 교차 수강 시 계산 문제가 발생하고 있습니다. 유의 바랍니다. (수정예정)</div>
        </div>
        <div class="alert alert-success d-flex align-items-center" role="alert">
            <div><i class="bi bi-exclamation-triangle-fill"></i> [중요] 설계학점이 잘못 계산되던 문제를 해결하였습니다. 유의 바랍니다.</div>
        </div>

        <%--경기대학교 졸업요건 시작--%>
        <%--    졸업요건 타이틀 start--%>
        <div class="row">
            <div class="col-xs-12 mb-5">
                <div class="card-full bg-light p-5 mouse-over-light">
                    <h2 class="mt-0" id="graduation_requirement"></h2>
                </div>
            </div>
        </div>
        <%--    졸업요건 타이틀 end--%>
        <%--    졸업요건 차트 1번째 줄 start--%>
        <div class="row align-items-md-stretch">
            <div class="col-xs-4">
                <div class="card bg-light py-5 mouse-over-light">
                    <div class="text-center h2" id="GradReqAllCreditTitle"></div>
                    <canvas id="GradReqAllCreditChart"></canvas>
                    <div class="text-center h3 mb-5" id="GradReqAllCreditLabel"></div>
                </div>
            </div>
            <div class="col-xs-4">
                <div class="card bg-light py-5 mouse-over-light">
                    <div class="text-center h2" id="GradReqMajorCreditTitle"></div>
                    <canvas id="GradReqMajorCreditChart"></canvas>
                    <div class="text-center h3 mb-5" id="GradReqMajorCreditLabel"></div>
                </div>
            </div>
            <div class="col-xs-4">
                <div class="card bg-light py-5 mouse-over-light">
                    <div class="text-center h2" id="GradReqElectiveCreditTitle"></div>
                    <canvas id="GradReqElectiveCreditChart"></canvas>
                    <div class="text-center h3 mb-5" id="GradReqElectiveCreditLabel"></div>
                </div>
            </div>
        </div>
        <%--    졸업요건 차트 1번째 줄 end--%>
        <%--    졸업요건 차트 2번째 줄 start--%>
        <div class="row align-items-md-stretch">
            <div class="col-xs-3">
                <div class="card bg-light py-5 mouse-over-light">
                    <div class="text-center h3" id="GradReqJinSeongAeCreditTitle"></div>
                    <canvas id="GradReqJinSeongAeCreditChart"></canvas>
                    <div class="text-center h3 mb-5" id="GradReqJinSeongAeCreditLabel"></div>
                </div>
            </div>
            <div class="col-xs-3">
                <div class="card bg-light py-5 mouse-over-light">
                    <div class="text-center h3" id="GradReqMscCreditTitle"></div>
                    <canvas id="GradReqMscCreditChart"></canvas>
                    <div class="text-center h3 mb-5" id="GradReqMscCreditLabel"></div>
                </div>
            </div>
            <div class="col-xs-3">
                <div class="card bg-light py-5 mouse-over-light">
                    <div class="text-center h3" id="GradReqMajorEssentialCountTitle"></div>
                    <canvas id="GradReqMajorEssentialCountChart"></canvas>
                    <div class="text-center h3 mb-5" id="GradReqMajorEssentialCountLabel"></div>
                </div>
            </div>
            <div class="col-xs-3">
                <div class="card bg-light py-5 mouse-over-light">
                    <div class="text-center h3" id="GradReqMajorSelectiveCountTitle"></div>
                    <canvas id="GradReqMajorSelectiveCountChart"></canvas>
                    <div class="text-center h3 mb-5" id="GradReqMajorSelectiveCountLabel"></div>
                </div>
            </div>
        </div>
        <%--    졸업요건 차트 2번째 줄 end--%>
        <%--    졸업요건 진단 로그 start--%>
        <button class="accordion card mouse-over-light">자세한 내용 보기 (클릭)</button>
        <div class="panel card mouse-over-light" id="GraduationRequirementLog"></div>
        <%--    졸업요건 진단 로그 end--%>
        <%--경기대학교 졸업요건 끝--%>
        <%--안내문 시작--%>
        <div class="warning_alert"></div>
        <%--안내문 끝--%>
        <%-- 공학인증요건 시작--%>
        <%-- 공학인증요건 타이틀 start--%>
        <div class="row">
            <div class="col-xs-12 mb-5">
                <div class="card-full bg-light p-5 mouse-over-light">
                    <h2 class="mt-0" id="engineering_requirement"></h2>
                </div>
            </div>
        </div>
        <%-- 공학인증요건 타이틀 end--%>
        <%-- 공학인증요건 차트 start--%>
        <div class="row align-items-md-stretch">
            <div class="col-xs-3">
                <div class="card bg-light py-5 mouse-over-light">
                    <div class="text-center h3 py-3" id="EngineReqBsmCreditTitle"></div>
                    <canvas id="EngineReqBsmCreditChart"></canvas>
                    <div class="text-center h3 mb-5" id="EngineReqBsmCreditLabel"></div>
                </div>
            </div>
            <div class="col-xs-3">
                <div class="card bg-light py-5 mouse-over-light">
                    <div class="text-center h3 py-3" id="EngineReqSpecialElectiveCreditTitle"></div>
                    <canvas id="EngineReqSpecialElectiveCreditChart"></canvas>
                    <div class="text-center h3 mb-5" id="EngineReqSpecialElectiveCreditLabel"></div>
                </div>
            </div>
            <div class="col-xs-3">
                <div class="card bg-light py-5 mouse-over-light">
                    <div class="text-center h3 py-3" id="EngineReqDesignCreditTitle"></div>
                    <canvas id="EngineReqDesignCreditChart"></canvas>
                    <div class="text-center h3 mb-5" id="EngineReqDesignCreditLabel"></div>
                </div>
            </div>
            <div class="col-xs-3">
                <div class="card bg-light py-5 mouse-over-light">
                    <div class="text-center h3 py-3" id="EngineReqMajorCreditTitle"></div>
                    <canvas id="EngineReqMajorCreditChart"></canvas>
                    <div class="text-center h3 mb-5" id="EngineReqMajorCreditLabel"></div>
                </div>
            </div>
            <div class="col-xs-12">
                <div class="card bg-light py-3 mouse-over-light">
                    <div>
                        <div class="col-xs-3 text-center h4 py-2 my-2" id="EngineReqEssentialLecturesTitle"></div>
                        <div class="col-xs-6 text-center h4 py-2 my-2" id="EngineReqEssentialLecturesChart"></div>
                        <div class="col-xs-3 text-center h4 py-2 my-2" id="EngineReqEssentialLecturesLabel"></div>
                    </div>
                </div>
            </div>
            <div class="col-xs-12">
                <div class="card bg-light p-5 mouse-over-light">
                    <div id="lectureOrder">
                        <h3 class="mt-0 mb-5">선후수 충족 여부 검사</h3>
                    </div>
                </div>
            </div>
        </div>
        <%-- 공학인증요건 차트 end--%>
        <%-- 공학인증요건 로그 start--%>
        <button class="accordion card mouse-over-light">자세한 내용 보기 (클릭)</button>
        <div class="panel card mouse-over-light" id="EngineeringRequirementLog"></div>
        <%-- 공학인증요건 로그 end--%>
        <%-- 공학인증요건 끝--%>
        <%--안내문 시작--%>
        <div class="warning_alert"></div>
        <%--안내문 끝--%>
        <%
            if (!getTrackRequirement.equals("[]")) { //삭제 금지
        %>
        <%-- 트랙 시작--%>
        <%-- 트랙 타이틀 start--%>
        <div class="row">
            <div class="col-xs-12 mb-5">
                <div class="card-full bg-light p-5 mouse-over-light">
                    <h2 class="mt-0" id="track_requirement"></h2>
                </div>
            </div>
        </div>
        <%-- 트랙 타이틀 end--%>
        <%-- 트랙 차트 start--%>
        <div class="row align-items-md-stretch">
            <div class="col-xs-12">
                <div class="card bg-light py-5 mouse-over-light" id="tracks"></div>
            </div>
        </div>
        <%-- 트랙 차트 end--%>
        <%-- 트랙 로그 start--%>
        <button class="accordion card mouse-over-light">자세한 내용 보기 (클릭)</button>
        <div class="panel card mouse-over-light" id="TrackLog"></div>
        <%-- 트랙 로그 end--%>
        <%-- 트랙 끝--%>
        <%
            }
        %>

        <div class="alert alert-danger d-flex align-items-center" role="alert">
            <div><i class="bi bi-exclamation-triangle-fill"></i> 외국인 유학생, 전과생, 복수전공생, 편입생의 경우에는 사용이 불가능합니다.</div>
        </div>

        <div class="alert alert-success" role="alert">
            <h4 class="alert-heading">AI컴퓨터공학부 졸업요건 진단시스템 안내사항</h4>
            <p>위 진단 결과는 단순 참고용으로만 사용해주세요. 강좌 데이터나 설정의 오류로 인해 잘못된 결과가 산출 될 수도 있습니다. 졸업 요건을 판단하는 기준이 굉장히 복잡하여 예상치 못한 부분에서 잘못된 계산을 진행할 수도 있습니다. 단, 입력해주신 모든 강좌를 계산 할 때 마다 반드시 로그(자세한 내용 보기 탭)에 출력되도록 하였으니 로그를 기준으로 오류가 있는지 판단 해주시면 될 것 같습니다. 발견된 오류에 대해서는 반드시 제보해주시면 감사하겠습니다.</p>
            <hr>
            <p class="mb-0">
                ※ 시스템 업데이트 내역 (관리자의 수정은 패치 내역에 반영되지 않습니다.)<br>
                [2022-01-29] 설계학점이 소숫점인 과목(지능웹설계,분산및병렬처리)에 대한 오류 수정 <br>
                [2021-12-04] 서비스 개시
            </p>
        </div>

        <div class="alert alert-danger" role="alert">
            <h4 class="alert-heading">현재 알려진 문제</h4>
            <p>
                - 컴퓨터공학 ↔ 인공지능전공 간 교차 수강 시 마치 같은 과 처럼 계산이 되는 문제<br>
                - A와 B과목이 과거에는 별개의 과목이었다가 미래에 한 과목 C로 합쳐지게 되어 유사과목 변환 시 재수강으로 처리되는 문제<br>
            </p>
            <hr>
            <p class="mb-0">
                오류관련 제보는 학교 측이 아닌 gabrielyoon7@kyonggi.ac.kr으로 메일 보내주시면 감사하겠습니다.<br>
                빠른 시일 내에 수정하겠습니다.
            </p>
        </div>
        <%
            } //오타 아니니깐 삭제하지 마세요. 올바른 문법입니다.
        %>
<%--    </c:if>--%>
</div>
<script>
    let getOneGraduationRequirement = <%=getOneGraduationRequirement%>; //졸업요건 DB
    let getOneEngineeringRequirement = <%=getOneEngineeringRequirement%>; //공학인증요건 DB
    let getStudent = <%=getStudent%>; //학생정보
    let getLectureHistory = <%=getLectureHistory%>; //학생이 역대 수강한 모든 강좌
    let getUserExternalLecture = <%=getUserExternalLecture%>; //학생이 직접 입력한 강좌를 받는 기능
    let getLecture = <%=getLecture%>; //전체 강좌 정보
    let getSpecialLecture = <%=getSpecialLecture%>; //특수 강좌를 담는 테이블
    let personalData = []; // 효율적인 DOM 조작을 위한 배열
    let lectureHistory = []; //학생이 들었던 과목 이력을 재가공할 배열
    let lectureHistorySet = new Set([]); //학생이 들었던 과목들을 집합으로 관리하기 위한 배열
    let getTrackRequirement = <%=getTrackRequirement%>; //트랙 관련 요건 불러옴
    let getLectureByCode = <%=getLectureByCode%>; //강좌별 코드만 불러옴
    let getSimilarSubject = <%=getSimilarSub%>; //유사과목 불러옴
    let similarSubject = []; //유사과목을 다룰 배열
    let log = []; //계산된 학점이 들어갈 배열

    $(document).ready(function () { //본문 제어
        makeTitles();
        makeSimilarSubject();
        makeLectureHistory();
        computeHistory();
        makeCards();
        console.log(log);
        makeLogs();
    })

    function makeSimilarSubject() {
        //유사과목을 리스트화 하는 곳 (이 작업을 통해 JS에서 데이터를 다루기 더 편해집니다.)
        for (let i = 0; i < getSimilarSubject.length; i++) {
            let lectureList = getSimilarSubject[i].lectures.split('-/@/-');
            for (let j = 0; j < lectureList.length; j++) {
                similarSubject.push({
                    similar_lecture_id : getSimilarSubject[i].oid,
                    lecture : lectureList[j]
                });
            }
        }
        console.log(similarSubject);
    }

    function makeTitles() {
        // 타이틀 만드는 함수

        $('#graduation_requirement').html('경기대학교 졸업요건(' + getStudent.major + '/' + getStudent.enter_year + '학번)');

        let engineering_requirement = $('#engineering_requirement');
        engineering_requirement.html('공학인증 요건(' + getStudent.major + '/' + getStudent.enter_year + '학번)');

        let track_requirement = $('#track_requirement');
        track_requirement.html('트랙(' + getStudent.major + '/' + getStudent.enter_year + '학번)');


        let warning_alert = $('.warning_alert');
        warning_alert.html('<div class="alert alert-warning d-flex align-items-center" role="alert"> <div><i class="bi bi-exclamation-triangle-fill"></i> 이 프로그램은 학점 계산 시 참고하는 용으로만 사용되어야 합니다. 사용 시 문제가 발생할 수 있습니다.</div> </div>');
    }

    function makeLectureSimilar(lecture_id){
        //강좌가 유사과목 리스트에 있다면 유사과목으로 치환 시켜주는 함수 (학수코드를 변환시킨다)
        let result = similarSubject.find(lecture => (lecture.lecture == lecture_id));
        if(result==null){ //유사과목 목록에 없으면 아무런 조치를 하지 않는다.
            return lecture_id;
        }
        else { //유사과목 목록에 있는 경우에는 아래와 같이 변환해준다
            return '유사과목그룹'+result.similar_lecture_id;
        }
    }

    function makeLectureHistory() {
        //사용자의 수강이력을 분석하여 JSON으로 가공하는 함수. (이 작업을 통해 JS에서 데이터를 다루기 더 편해집니다.)
        for (let i = 0; i < getLectureHistory.length; i++) {
            let lectures = getLectureHistory[i].history.split('-/@/-'); //내가 여태까지 들은 과목들의 학수코드를 배열화 한다.(코드만)
            for (let j = 0; j < lectures.length; j++) {
                //내 수강 이력에 있는 과목이 전체 강좌 리스트에 있는지 find 하여 result 변수에 담아준다.
                const result = getLecture.find(lecture => (lecture.year === getLectureHistory[i].year) && (lecture.semester === getLectureHistory[i].semester) && (lecture.lecture_id === lectures[j]));

                let lecture_id = makeLectureSimilar(lectures[j]); // 유사과목 처리 (상세 살명은 해당 함수 안에 있음)

                //사용자가 들은 과목들이 학수코드로만 되어있었는데, 그 과목들에게 부가적인 정보를 부여하는 작업 (ex. 과목 이름, 학점, 설계학점, 분류 등)
                lectureHistory.push({
                    year: getLectureHistory[i].year,
                    semester: getLectureHistory[i].semester,
                    // grade: getLectureHistory[i].grade,
                    lecture_id: lecture_id,
                    name: result.name,
                    credit: result.credit,
                    design_credit: result.design_credit,
                    big_type: result.big_type,
                    small_type: result.small_type
                });
                //for문이 돌면서 여태까지 수강한 과목들을 리스트화 함
            }
        }
        // 외부 강좌에 관한 처리
        for(let i = 0 ; i < getUserExternalLecture.length; i++){
            let big_type = '';
            if(getUserExternalLecture[i].big_type=='전공'){
                big_type='기타';
            }
            else {
                big_type=getUserExternalLecture[i].big_type;
            }
            lectureHistory.push({
                year: getUserExternalLecture[i].year,
                semester: getUserExternalLecture[i].semester,
                // grade: getLectureHistory[i].grade,
                lecture_id: '-', //이렇게 해놓으면 makeSetIdentifier()에서 Math.random()으로 랜덤 식별자를 만들어 줄 것이다.
                name: getUserExternalLecture[i].name,
                credit: getUserExternalLecture[i].credit,
                design_credit: 0,
                big_type: big_type,
                small_type: '사용자가 직접 입력한 강좌'
            });
        }
        console.log(lectureHistory);
    }

    function computeHistory() { // 첫 줄
        //학생이 들었던 모든 과목을 계산하여 personalData 배열을 만든다. makeLectureHistory 이후에 업데이트 해줘야 최신 사용자 데이터를 기준으로 연산한다.

        let computed_GradReqAllCredit = computeAllCredit('전체 학점');
        let limit_GradReqAllCredit = getOneGraduationRequirement.all_credit;
        let rest_GradReqAllCredit = restCalculator(limit_GradReqAllCredit, computed_GradReqAllCredit);

        let computed_GradReqMajorCredit = computeBigTypeCredit('전체 전공학점', '전공');
        let limit_GradReqMajorCredit = getOneGraduationRequirement.major_credit;
        let rest_GradReqMajorCredit = restCalculator(limit_GradReqMajorCredit, computed_GradReqMajorCredit);

        let computed_GradReqElectiveCredit = computeBigTypeCredit('전체 교양학점', '교양');
        let limit_GradReqElectiveCredit = getOneGraduationRequirement.elective_credit;
        let rest_GradReqElectiveCredit = restCalculator(limit_GradReqElectiveCredit, computed_GradReqElectiveCredit);

        let computed_GradReqMajorEssentialCount = computeSpecialCount('전공필수', 'major_essential');
        let limit_GradReqMajorEssentialCount = getOneGraduationRequirement.major_essential;
        let rest_GradReqMajorEssentialCount = restCalculator(limit_GradReqMajorEssentialCount, computed_GradReqMajorEssentialCount);

        let computed_GradReqMajorSelectiveCount = computeSpecialCount('선택필수', 'major_selective');
        let limit_GradReqMajorSelectiveCount = getOneGraduationRequirement.major_selective;
        let rest_GradReqMajorSelectiveCount = restCalculator(limit_GradReqMajorSelectiveCount, computed_GradReqMajorSelectiveCount);

        let computed_GradReqJinSeongAeCredit = computeSpecialCredit('진성애', 'jin_seong_ae');
        let limit_GradReqJinSeongAeCredit = getOneGraduationRequirement.jin_seong_ae_credit;
        let rest_GradReqJinSeongAeCredit = restCalculator(limit_GradReqJinSeongAeCredit, computed_GradReqJinSeongAeCredit);

        let computed_GradReqMscCredit = computeSpecialCredit('수리와과학(MSC)', 'MSC');
        let limit_GradReqMscCredit = getOneGraduationRequirement.msc_credit;
        let rest_GradReqMscCredit = restCalculator(limit_GradReqMscCredit, computed_GradReqMscCredit);

        let computed_EngineReqBsmCredit = computeSpecialCredit('BSM', 'BSM');
        let limit_EngineReqBsmCredit = getOneEngineeringRequirement.bsm_credit;
        let rest_EngineReqBsmCredit = restCalculator(limit_EngineReqBsmCredit, computed_EngineReqBsmCredit);

        let computed_EngineReqSpecialElectiveCredit = computeSpecialCredit('전문교양', 'special_elective');
        let limit_EngineReqSpecialElectiveCredit = getOneEngineeringRequirement.elective_credit;
        let rest_EngineReqSpecialElectiveCredit = restCalculator(limit_EngineReqSpecialElectiveCredit, computed_EngineReqSpecialElectiveCredit);

        let computed_EngineReqDesignCredit = computeDesignCredit('설계점수');
        let limit_EngineReqDesignCredit = getOneEngineeringRequirement.design_credit;
        let rest_EngineReqDesignCredit = restCalculator(limit_EngineReqDesignCredit, computed_EngineReqDesignCredit);

        let computed_EngineReqMajorCredit = computeBigTypeCredit('전공점수', '전공');
        let limit_EngineReqMajorCredit = getOneEngineeringRequirement.major_credit;
        let rest_EngineReqMajorCredit = restCalculator(limit_EngineReqMajorCredit, computed_EngineReqMajorCredit);


        let computed_EngineReqEssentialLecturesCount = computeSpecialCount('필수과목', 'essential');
        let limit_EngineReqEssentialLecturesCount = countSpecialLectures('essential');
        let rest_EngineReqEssentialLecturesCount = restCalculator(limit_EngineReqEssentialLecturesCount, computed_EngineReqEssentialLecturesCount);


        personalData = [
            {"chart": "doughnut", "title": "전체 학점", "chartID": "GradReqAllCredit", "type": "credit", "done": computed_GradReqAllCredit, "rest": rest_GradReqAllCredit, "limit": limit_GradReqAllCredit},
            {"chart": "doughnut", "title": "전체 전공학점", "chartID": "GradReqMajorCredit", "type": "credit", "done": computed_GradReqMajorCredit, "rest": rest_GradReqMajorCredit, "limit": limit_GradReqMajorCredit},
            {"chart": "doughnut", "title": "전체 교양학점", "chartID": "GradReqElectiveCredit", "type": "credit", "done": computed_GradReqElectiveCredit, "rest": rest_GradReqElectiveCredit, "limit": limit_GradReqElectiveCredit},
            {"chart": "doughnut", "title": "전공필수", "chartID": "GradReqMajorEssentialCount", "type": "count", "done": computed_GradReqMajorEssentialCount, "rest": rest_GradReqMajorEssentialCount, "limit": limit_GradReqMajorEssentialCount},
            {"chart": "doughnut", "title": "선택필수", "chartID": "GradReqMajorSelectiveCount", "type": "count", "done": computed_GradReqMajorSelectiveCount, "rest": rest_GradReqMajorSelectiveCount, "limit": limit_GradReqMajorSelectiveCount},
            {"chart": "doughnut", "title": "진성애", "chartID": "GradReqJinSeongAeCredit", "type": "credit", "done": computed_GradReqJinSeongAeCredit, "rest": rest_GradReqJinSeongAeCredit, "limit": limit_GradReqJinSeongAeCredit},
            {"chart": "doughnut", "title": "수리와과학", "chartID": "GradReqMscCredit", "type": "credit", "done": computed_GradReqMscCredit, "rest": rest_GradReqMscCredit, "limit": limit_GradReqMscCredit},
            {"chart": "doughnut", "title": "BSM", "chartID": "EngineReqBsmCredit", "type": "credit", "done": computed_EngineReqBsmCredit, "rest": rest_EngineReqBsmCredit, "limit": limit_EngineReqBsmCredit},
            {"chart": "doughnut", "title": "전문교양", "chartID": "EngineReqSpecialElectiveCredit", "type": "credit", "done": computed_EngineReqSpecialElectiveCredit, "rest": rest_EngineReqSpecialElectiveCredit, "limit": limit_EngineReqSpecialElectiveCredit},
            {"chart": "doughnut", "title": "설계점수", "chartID": "EngineReqDesignCredit", "type": "credit", "done": computed_EngineReqDesignCredit, "rest": rest_EngineReqDesignCredit, "limit": limit_EngineReqDesignCredit},
            {"chart": "doughnut", "title": "전공점수", "chartID": "EngineReqMajorCredit", "type": "credit", "done": computed_EngineReqMajorCredit, "rest": rest_EngineReqMajorCredit, "limit": limit_EngineReqMajorCredit},
            {"chart": "progressBar", "title": "필수과목", "chartID": "EngineReqEssentialLectures", "type": "count", "done": computed_EngineReqEssentialLecturesCount, "rest": rest_EngineReqEssentialLecturesCount, "limit": limit_EngineReqEssentialLecturesCount}
        ];

        makeTrackData();
        makeLectureOrderData();
    }

    function makeLectureOrderData(){ // 선후수 충족 여부 검사
        let lectureOrderCard = $('#lectureOrder');
        let temp = getOneEngineeringRequirement.lecture_order; // [DB]gcs_engineering_requirement
        let lectureOrder=temp.split('-/@/-');
        let text='';
        if(lectureOrder!='') { //이거 왜 안먹힘?
            for (let i = 0; i < lectureOrder.length; i++) { // 선후수 과목 루프
                let lectures = lectureOrder[i].split('->');
                let former_lecture = makeLectureSimilar(lectures[0]); // 유사과목 검사
                let later_lecture = makeLectureSimilar(lectures[1]);
                let checked = checkLectureOrder(former_lecture,later_lecture); // 선후수 비교

                getLectureByCode.forEach(function (lec) {
                    let lecture_id = makeLectureSimilar(lec.lecture_id);
                    if(lecture_id==former_lecture){ // 강의가 선수 과목이면
                        former_lecture=lec.name+'('+lecture_id+')';
                    }
                    if(lecture_id==later_lecture){ // 후수 과목이면
                        later_lecture=lec.name+'('+lecture_id+')';
                    }
                });

                text += '<div class="d-flex justify-content-between">'
                    +'<div>'+former_lecture + '</div><div> → </div><div>' + later_lecture+'</div>';

                if(checked=='pass'){
                    text +='<div>충족</div>'
                }
                else if (checked == 'fail'){
                    text +='<div>미충족</div>'
                }
                else if (checked == 'none'){
                    text +='<div>판별불가(미수강有)</div>'
                }
                else {
                    text +='<div>에러</div>'
                }
                text+='</div>';
            }
        }
        else {
            text+='<div class="my-3">설정된 선후수 조건이 없습니다.</div>';
        }
        lectureOrderCard.append(text);
    }

    function checkLectureOrder(former_lecture, later_lecture){ // 선후수 비교
        //검사하는 로직을 넣읍시다!
        let former_time='';
        let later_time='';
        let reversed_lectureHistory = lectureHistory.reverse(); // 재수강 과목이 있을 수 있으므로 수강 이력을 reverse 해준다
        console.log(former_lecture+' -> '+later_lecture); // ??

        //1. former_lecture에 대한 검사
        const former_lecture_of_history = reversed_lectureHistory.find(lecture => (lecture.lecture_id === former_lecture));
        //2. later_lecture에 대한 검사
        const later_lecture_of_history = reversed_lectureHistory.find(lecture => (lecture.lecture_id === later_lecture));

        if((former_lecture_of_history!=null) && (later_lecture_of_history!=null)){ //일단 두 과목 검색했을 때 존재한다면
            let former_semester = former_lecture_of_history.semester;
            if(former_semester=='여름'){
                former_semester='1.5';
            }
            if(former_semester=='겨울'){
                former_semester='2.5';
            }
            former_time+=parseFloat(former_lecture_of_history.year+former_semester); //20211 처럼 년도+학기로 실수 값을 만들어줌
            // console.log(former_lecture_of_history.name+'('+former_time+')');

            let later_semester = later_lecture_of_history.semester;
            if(later_semester=='여름'){
                later_semester='1.5';
            }
            if(later_semester=='겨울'){
                later_semester='2.5';
            }
            later_time+=parseFloat(later_lecture_of_history.year+later_semester);
            // console.log(later_lecture_of_history.name+'('+later_time+')');

            //선후수를 검사한다.
            if(former_time<=later_time){
                return 'pass';
            }
            else {
                return 'fail';
            }

        }
        return 'none';
    }

    function makeTrackData() {
        for (let i = 0; i < getTrackRequirement.length; i++) { // 트랙 요건
            let trackRequirement = getTrackRequirement[i];

            //카드 제작
            let trackCard = $('#tracks');
            trackCard.append('<div><div class="col-xs-3 text-center h4 py-2 my-2" id="'+trackRequirement.chart_id+'Title"></div><div class="col-xs-6 text-center h4 py-2 my-2" id="'+trackRequirement.chart_id+'Chart"></div><div class="col-xs-3 text-center h4 py-2 my-2" id="'+trackRequirement.chart_id+'Label"></div></div>');

            //트랙 학점 계산 및 personalData에 push
            let computed_track = computeSpecialCredit('트랙(' + trackRequirement.name + ')', trackRequirement.code);
            let limit_track = trackRequirement.credit;
            let rest_track = restCalculator(limit_track, computed_track);
            personalData.push({
                "chart": "progressBar",
                "title": trackRequirement.name,
                "chartID": trackRequirement.chart_id,
                "type": "credit",
                "done": computed_track,
                "rest": rest_track,
                "limit": limit_track
            });
        }
    }


    function restCalculator(all, done) {
        let rest = all - done;
        if (rest < 0) {
            rest = 0;
        }
        return rest;
    }

    function pushToLog(year, semester, title, name, credit, computed_credit) {
        log.push({
            title: title,
            description: '<div>• [' + year + '-' + semester + '] ' + name + '(+' + credit + ')</div><div>····································· 누적 : ' + computed_credit + '</div>'
        });
    }

    function countSpecialLectures(type) {
        let count = 0;
        for (let i = 0; i < getSpecialLecture.length; i++) {
            if (getSpecialLecture[i].type == type) {
                count++;
            }
        }
        return count;
    }

    function makeSetIdentifier(title, lecture_id) {
        let text = '[' + title + ']';
        if (lecture_id == '-') {
            text += '학수코드 없는 과목을 위한 랜덤 식별자 처리' + Math.random();
        } else {
            text += lecture_id;
        }
        return text;
    }

    function computeAllCredit(title) {
        let credit = 0;
        for (let i = 0; i < lectureHistory.length; i++) { // 수강한 과목 중에서
            if (lectureHistorySet.has(makeSetIdentifier(title, lectureHistory[i].lecture_id))) {//재수강 여부 검사
                pushToLog(lectureHistory[i].year, lectureHistory[i].semester, title, lectureHistory[i].name + '<b class="text-danger">(재수강)</b>', 0, credit);
            } else {
                credit += parseFloat(lectureHistory[i].credit); // credit에 수강한 과목 학점 추가
                lectureHistorySet.add(makeSetIdentifier(title, lectureHistory[i].lecture_id));
                pushToLog(lectureHistory[i].year, lectureHistory[i].semester, title, lectureHistory[i].name, lectureHistory[i].credit, credit);
            }
        }
        return credit;
    }

    function computeDesignCredit(title) {
        let credit = 0;
        for (let i = 0; i < lectureHistory.length; i++) {
            if (lectureHistorySet.has(makeSetIdentifier(title, lectureHistory[i].lecture_id))) {//재수강 여부 검사
                pushToLog(lectureHistory[i].year, lectureHistory[i].semester, title, lectureHistory[i].name + '<b class="text-danger">(재수강)</b>', 0, credit);
            } else {
                if (parseFloat(lectureHistory[i].design_credit) != 0) {
                    credit += parseFloat(lectureHistory[i].design_credit);
                    lectureHistorySet.add(makeSetIdentifier(title, lectureHistory[i].lecture_id));
                    pushToLog(lectureHistory[i].year, lectureHistory[i].semester, title, lectureHistory[i].name, lectureHistory[i].design_credit, credit);
                }
            }
        }
        return credit;
    }

    function computeBigTypeCredit(title, big_type) {
        let credit = 0;
        for (let i = 0; i < lectureHistory.length; i++) {
            if (lectureHistorySet.has(makeSetIdentifier(title, lectureHistory[i].lecture_id))) {//재수강 여부 검사
                pushToLog(lectureHistory[i].year, lectureHistory[i].semester, title, lectureHistory[i].name + '<b class="text-danger">(재수강)</b>', 0, credit);
            } else {
                if (lectureHistory[i].big_type == big_type) {
                    credit += parseFloat(lectureHistory[i].credit);
                    lectureHistorySet.add(makeSetIdentifier(title, lectureHistory[i].lecture_id));
                    pushToLog(lectureHistory[i].year, lectureHistory[i].semester, title, lectureHistory[i].name, lectureHistory[i].credit, credit);
                }
            }

        }
        return credit;
    }

    function computeSpecialCredit(title, type) {
        let credit = 0;
        for (let i = 0; i < lectureHistory.length; i++) {
            if (lectureHistorySet.has(makeSetIdentifier(title, lectureHistory[i].lecture_id))) {//재수강 여부 검사
                pushToLog(lectureHistory[i].year, lectureHistory[i].semester, title, lectureHistory[i].name + '<b class="text-danger">(재수강)</b>', 0, credit);
            } else {
                for (let j = 0; j < getSpecialLecture.length; j++) {
                    let special_lecture_id = makeLectureSimilar(getSpecialLecture[j].lecture_id); // 유사과목 처리
                    if ((lectureHistory[i].lecture_id == special_lecture_id) && (getSpecialLecture[j].type == type)) {
                        credit += parseFloat(lectureHistory[i].credit);
                        lectureHistorySet.add(makeSetIdentifier(title, lectureHistory[i].lecture_id));
                        pushToLog(lectureHistory[i].year, lectureHistory[i].semester, title, lectureHistory[i].name, lectureHistory[i].credit, credit);
                    }
                }
            }
        }
        return credit;
    }

    function computeSpecialCount(title, type) {
        let count = 0;
        for (let i = 0; i < lectureHistory.length; i++) {
            if (lectureHistorySet.has(makeSetIdentifier(title, lectureHistory[i].lecture_id))) {//재수강 여부 검사
                pushToLog(lectureHistory[i].year, lectureHistory[i].semester, title, lectureHistory[i].name + '<b class="text-danger">(재수강)</b>', 0, count);
            } else {
                for (let j = 0; j < getSpecialLecture.length; j++) {
                    let special_lecture_id = makeLectureSimilar(getSpecialLecture[j].lecture_id); // 유사과목 처리
                    if ((lectureHistory[i].lecture_id == special_lecture_id) && (getSpecialLecture[j].type == type)) {
                        count++;
                        lectureHistorySet.add(makeSetIdentifier(title, lectureHistory[i].lecture_id));
                        pushToLog(lectureHistory[i].year, lectureHistory[i].semester, title, lectureHistory[i].name, 1, count);
                    }
                }
            }
        }
        return count;
    }

    function makeCards() {
        //만들어진 personalData를 기반으로 Card를 제작하여 붙인다.

        for (let i = 0; i < personalData.length; i++) {

            //상단바
            let title = $('#' + personalData[i].chartID + 'Title'); // #은 왜 들어가지
            title.html(personalData[i].title);

            //차트 GUI
            if (personalData[i].chart == 'doughnut') {
                makeDoughnutChart(personalData[i].type, personalData[i].chartID + 'Chart', personalData[i].done, personalData[i].rest);
            } else if (personalData[i].chart == 'progressBar') {
                makeProgressBar(personalData[i].chartID + 'Chart', personalData[i].done, personalData[i].rest)
            } else {
                console.log('오류');
            }

            // 잔여 강좌
            let label = $('#' + personalData[i].chartID + 'Label');
            let limit = personalData[i].limit;
            let postfix;

            if (personalData[i].type == 'count') {
                postfix = '개';
            } else if (personalData[i].type == 'credit') {
                postfix = '점';
            } else {
                postfix = 'error';
            }

            if (limit < personalData[i].done) {
                label.html('<div>'+personalData[i].done + ' / ' + limit + ' ' + postfix +'</div><div>(초과)</div>')
            } else {
                label.html('<div>'+personalData[i].done + ' / ' + limit + ' ' + postfix +'</div><div>…</div>')
            }
        }
    }

    function makeProgressBar(id, done, rest) {
        let bar = $('#' + id);
        let percentage = parseFloat(done / (done + rest) * 100);
        let text = '<div class="progress my-0"><div class="progress-bar" role="progressbar" style="width: ' + percentage + '%" aria-valuenow="' + percentage + '" aria-valuemin="0" aria-valuemax="100">' + percentage + '%</div></div>'
        bar.append(text);
    }

    function makeDoughnutChart(type, id, done, rest) {
        let label = null;
        if (type == 'count') {
            label = ['이수 강좌 수', '잔여 강좌 수'];
        } else if (type == 'credit') {
            label = ['이수 학점', '잔여 학점'];
        } else {
            //이게 나오면 오류임
            label = ['null', 'null'];
        }
        new Chart(document.getElementById(id), {
            type: 'doughnut',
            data: {
                labels: label, //타입에 따라 다른 라벨을 붙여줌
                datasets: [{
                    data: [done, rest],      // 이수, 잔여
                    backgroundColor: ['#337ab7', '#F2F3F6'],
                    borderWidth: 0,
                    scaleBeginAtZero: true,
                }
                ]
            },
            options: {
                legend: {
                    display: false
                },
            }
        });
    }


    function makeLogs() {
        // 그동안 계산됐던 로그를 붙여주는 함수

        let logSettings = [
            {"id": "GraduationRequirementLog", "titles": ['전체 학점', '전체 전공학점', '전체 교양학점', '진성애', '수리와과학(MSC)', '전공필수', '선택필수']},
            {"id": "EngineeringRequirementLog", "titles": ['BSM', '전문교양', '설계점수', '전공점수', '필수과목']},
            {"id": "TrackLog", "titles": ['트랙(소프트웨어과학)', '트랙(지능정보)', '트랙(IoT임베디드)', '트랙(블록체인보안)']}
        ];
        for (let i = 0; i < logSettings.length; i++) {
            makeLog(logSettings[i]);
        }
    }

    function makeLog(setting) {
        //logSettings에 있는 객체 하나하나를 바탕으로 로그를 출력함
        let titles = setting.titles;
        let card = $('#' + setting.id);
        let text = '';
        for (let i = 0; i < titles.length; i++) {
            let isNull = 'yes';
            text += '<div class="py-2 px-5">'
                + '<div class="h2">' + titles[i] + '</div>'
                + '<div class="row">'
                + '<div class="col-xs-12">'
            for (let j = 0; j < log.length; j++) {
                if (log[j].title == titles[i]) {
                    isNull = 'no';
                    text += '<div class="d-flex justify-content-between">' + log[j].description + '</div>'
                }
            }
            if (isNull == 'yes') {
                text += '<div>수강 내역이 없습니다.</div>'
            }
            text += '</div>'
                + '</div>'
                + '</div>'
        }
        card.append(text);
    }
</script>


<script>
    var acc = document.getElementsByClassName("accordion");
    var i;

    for (i = 0; i < acc.length; i++) {
        acc[i].addEventListener("click", function () {
            this.classList.toggle("active");
            var panel = this.nextElementSibling;
            if (panel.style.maxHeight) {
                panel.style.maxHeight = null;
            } else {
                panel.style.maxHeight = panel.scrollHeight + "px";
            }
        });
    }
</script>
