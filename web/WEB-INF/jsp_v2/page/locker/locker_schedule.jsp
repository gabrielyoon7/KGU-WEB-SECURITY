<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
    StringBuffer url2_locker_schedule = request.getRequestURL();
    String logo_img_locker_schedule;

    //로컬에서는 http:// local~ 로컬 테스트를 위해 equals "lo" 추가
    //ai이면 ai로고 cs이면 cs로고
    if(url2_locker_schedule.substring(7,9).equals("ai") || url2_locker_schedule.substring(7,9).equals("lo")){
        logo_img_locker_schedule = "img/graduation_ai.png";
    }
    else{
        logo_img_locker_schedule = "img/graduation.png";
    }
    //System.out.println((logo_img_locker_schedule));
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
<%
    String schedulelist = (String) request.getAttribute("schedulelist");
    //String num = (String) request.getAttribute("num");
    String tabmenulist=(String) request.getAttribute("tabmenulist");//관리자탭메뉴
    String lockerList1 = (String) request.getAttribute("lockerList1");
    String lockerList2 = (String) request.getAttribute("lockerList2");
    String lockerList3 = (String) request.getAttribute("lockerList3");
    String lockerList4 = (String) request.getAttribute("lockerList4");
    String lockerList5 = (String) request.getAttribute("lockerList5");
    String lockerList6 = (String) request.getAttribute("lockerList6");
    String lockerList7 = (String) request.getAttribute("lockerList7");

%>


        <div id="title">
            <img src=<%=logo_img_locker_schedule%> />
            <!--          <img src="img/graduation.png" alt="">  여기만 특이하게 이거인데 삭제함 prepend가 없음.-->
            <div>사물함 신청</div>
        </div>
        <div id="container">
            <div id="tab">
                <ul id="tabMenu">
                </ul>
            </div>
            <div id="maincontent">
                <ul>
                    <li>
                        <div class="contenttitle" id="title2"></div>
                        <ul>
                            <li>
                                <table class="boardtable" id="scheduletable">

                                </table>
                                <div class="col-md-11"></div>
                                <div class="col-md-1" id="modifydate"></div>
                                <div id="graduationcontent"> </div>
                                <div class="col-md-12">
                                    <div class="contenttitle2">실시간 사물함 현황</div>
                                    <div class="col-md-5">
                                        <div class="contenttitle2">위치 1</div>
                                        <div class="locker-wrapper-1"></div>
                                        <div class="contenttitle2">위치 2</div>
                                        <div class="locker-wrapper-2"></div>
                                        <div class="contenttitle2">위치 3</div>
                                        <div class="locker-wrapper-3"></div>
                                        <div class="contenttitle2">위치 4</div>
                                        <div class="locker-wrapper-4"></div>
                                    </div>
                                    <div class="col-md-7">
                                        <div class="contenttitle2">위치 5</div>
                                        <div class="locker-wrapper-5"></div>
                                        <div class="contenttitle2">위치 6</div>
                                        <div class="locker-wrapper-6"></div>
                                        <div class="contenttitle2">위치 7</div>
                                        <div class="locker-wrapper-7"></div>
                                    </div>
                                </div>

                                <%--                                <hr>--%>
                                <div class="col-md-11">
                                    <div class="contenttitle2" >사물함 사진 : 위치1</div>
                                    <div id="image01"><img src="./img/사물함01.jpg" id="locker01"></div>
                                    <div class="contenttitle2" >사물함 사진 : 위치2</div>
                                    <div id="image02"><img src="./img/사물함02.jpg" id="locker02"></div>
                                    <div class="contenttitle2" >사물함 사진 : 위치3</div>
                                    <div id="image03"><img src="./img/사물함03.jpg" id="locker03"></div>
                                    <div class="contenttitle2" >사물함 사진 : 위치4</div>
                                    <div id="image04"><img src="./img/사물함04.jpg" id="locker04"></div>
                                </div>
                                <div class="col-md-11">
                                    <div class="contenttitle2" >사물함 사진 : 위치5</div>
                                    <div id="image05"><img src="./img/사물함05.jpg" id="locker05"></div>
                                    <div class="contenttitle2" >사물함 사진 : 위치6</div>
                                    <div id="image06"><img src="./img/사물함06.jpg" id="locker06"></div>
                                    <div class="contenttitle2" >사물함 사진 : 위치7</div>
                                    <div id="image07"><img src="./img/사물함07.jpg" id="locker07"></div>
                                </div>
                                <br>
<%--                                <hr>--%>
                            </li>
                        </ul>
                    </li>
                </ul>
        </div>

    </div>


<div id="shadow">
    <div id="blur"></div>
</div>
<!-- modal -->
<div class="modal fade" id="modifyModal" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">사물함신청 일정수정</h4>
            </div>
            <div class="modal-body" id = "myModalbody">
            </div>
            <div class="modal-body" id = "myModalbody2">
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function() {//바로시작하는 function
        Locker(1, ".locker-wrapper-1");
        Locker(2, ".locker-wrapper-2");
        Locker(3, ".locker-wrapper-3");
        Locker(4, ".locker-wrapper-4");
        Locker(5, ".locker-wrapper-5");
        Locker(6, ".locker-wrapper-6");
        Locker(7, ".locker-wrapper-7");
    })

    var lockerList1 = <%=lockerList1%>;
    var lockerList2 = <%=lockerList2%>;
    var lockerList3 = <%=lockerList3%>;
    var lockerList4 = <%=lockerList4%>;
    var lockerList5 = <%=lockerList5%>;
    var lockerList6 = <%=lockerList6%>;
    var lockerList7 = <%=lockerList7%>;

    function Locker(location, lockerWrapClass) {
        let selectLocker = new Array();
        const lockerWrapper = document.querySelector(lockerWrapClass);
        let clicked = "";
        let div = "";
        //받은 location 값에 따라 lockerList 변수를 다르게 정해줌. 여기서부터 lockerList는 location번째 위치의 사물함을 의미함!
        if (location==1){var lockerList=lockerList1;}
        if (location==2){var lockerList=lockerList2;}
        if (location==3){var lockerList=lockerList3;}
        if (location==4){var lockerList=lockerList4;}
        if (location==5){var lockerList=lockerList5;}
        if (location==6){var lockerList=lockerList6;}
        if (location==7){var lockerList=lockerList7;}
        var index=0; //index는 lockerList를 탐색하는데 사용됨.
        var row=lockerList[0].locker_row; //row변수를 만들어서 기존의 mapping 함수들을 삭제하고 중복 코드도 삭제해버림.
        for (let i = 0; i < lockerList.length/row; i++) {
            //선애가 구현한 방식을 최대한 살리기 위해 반복해서 쌓는 구조로 구현함. 대신 전체갯수/가로열 만큼 반복하게 해서 열에 따라 크기가 자동으로 조절되게 처리함.
            div = document.createElement("div");
            lockerWrapper.append(div);
            for (let j = 0; j < row; j++) {
                var lockerData=lockerList[index]; //lockerData는 index를 이용해여 데이터 1줄만 불러오게 한다.
                const input = document.createElement('input');
                input.type = "button";
                input.name = "lockers"
                input.classList = "locker";
                input.value = "["+lockerData.locker_type+"] "+lockerData.locker_num+"번";
                index+=1; //다음 데이터 사용을 위해 index 1 증가
                div.append(input);
                if(lockerData.available=='사용가능'){

                }
                else if(lockerData.available=='사용중'){
                    input.classList.add("used");
                }
                else{
                    input.classList.add("unavailable");
                }
            }
        }
    };



    function formatData(date) {
        var d = new Date(date), month = '' + (d.getMonth() + 1), day = ''
            + d.getDate(), year = d.getFullYear();

        if (month.length < 2)
            month = '0' + month;
        if (day.length < 2)
            day = '0' + day;

        return [ year, month, day ].join('-');
    }
    var list = $('#tabMenu');
    var title = $('#title2');

    var tabmenu = <%=tabmenulist%>; //좌측 탭 메뉴 불러오는곳
    var number=<%=num%>;
    for (var i = 0; i < tabmenu.length; ++i) {
        var value = tabmenu[i];
        var num = value.tab_id*10+value.orderNum;
        var text = '<li><span class="deco_dot">●</span><a href="'+value.path+'?num='+num+'">'+ value.page_title + '</a></li>'
        list.append(text);
        if(number==num){
            title.append(value.page_title);
        }
    }



    var mod=$('#modifydate');
    // alert(type.type_name+"(으)로 접속했습니다.");//접속자 정보 표시. 나중에 삭제 예정
    if(type.type_name =='사물함관리자')
        mod.append('<a href="#modifyModal" data-toggle="modal" onclick="modifydate()" class="btn btn-default">수정</a>');
    var table = $('#scheduletable');
    var content=$('#graduationcontent');
    var schedule=<%=schedulelist%>;
    table.append('<thead><tr><th>단계</th><th>시작 일정</th><th>종료 일정</th><th>상태</th></tr></thead>');//head부분
    table.append('<tbody>');

    for(var i=0;i<schedule.length;i++){ //스케쥴 데이터 호출 총괄함
        var value=schedule[i];//단계 진행일정 상태
        table.append(addtable(value)); //스케쥴에 들어갈 '테이블' 데이터 불러오기
        content.append('<div class="contenttitle2" >'+value.schedule_name+'</div>'); //테이블 하단에 들어갈 스케쥴 이름 불러오기
        content.append('<div id="content'+i+'_modi">'+value.schedule_contents+'</div>'); //그 아래 들어올 스케쥴 설명 불러오기
        if(type.type_name =='사물함관리자')
            content.append('<div class="col-xs-10"></div><div id="button'+i+'"><a onclick="modifycontent('+i+')" class="btn btn-default">수정</a></div>');
    }
    table.append('</tbody>');

    function addtable(value){ //테이블 생성하는 곳
        var a='';
        var closing=new Date(value.end_date);
        var dayOfMonth = closing.getDate();
        closing.setDate(dayOfMonth - 1); //종료날짜가 0시 기준이라 표시를 전날로 해줘야함.
        a+='<tr>';
        a+='<td>'+value.schedule_name+'</td>'; //이름
        a+='<td>'+formatData(value.starting_date)+'</td>'; //시작날짜
        a+='<td>'+formatData(closing)+'</td>'; //종료날짜
        a+='<td>'+value.grd_state+'</td>'; //상태
        a+='</tr>';
        return a;
    }

    function modifydate(){ //일정 수정하는 경우
        var list = $('#myModalbody');
        var a = '';
        a += '<div class="form-group"><span>변경할 일정 :</span><select onchange="selectType()" style="display : inline-block; width:200px;" class="form-control" name="menutype"><option value="default">선택해주세요</option>';
        a +=   addvalue()+'</div><br>';
        a += '<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>'
        a += '<button type="button" class="btn btn-default pull-right" data-dismiss="modal"aria-label="Close" onclick="insertSchedule()">완료</button>';
        list.html(a);
    }
    function selectType(){ //수정 데이터 설정
        var list =$('#myModalbody2');
        list.empty();
        var val=$('[name=menutype]').val();
        var a='';
        for(var i=0;i<schedule.length;i++){
            if(val==schedule[i].schedule_name){
                var start =formatData(schedule[i].starting_date);
                var closing=new Date(schedule[i].end_date);
                var dayOfMonth = closing.getDate();
                closing.setDate(dayOfMonth - 1);
                var close = formatData(closing);
                a += '<div class="form-group"><label for="Inputstart">날짜</label><input type="date" class="form-control" id="Inputstart" name = "starting_date" value ="'+start+'" placeholder="Date of Birth" required></div><br/>';
                a += '<div class="form-group"><label for="Inputclose">날짜</label><input type="date" class="form-control" id="Inputclose" name = "closing_date" value ="'+close+'" placeholder="Date of Birth" required></div><br/>';
                a += '<button type="button" class="btn btn-default pull-right" data-dismiss="modal"aria-label="Close" onclick="modifySchedule()">수정</button>';
                a += '<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>'

            }
        }
        list.html(a);
    }
    function addvalue(){ //일정 수정할때 사용함
        var a='';
        for(var i=0;i<schedule.length;i++){
            var value =schedule[i];
            a+='<option value="'+value.schedule_name+'">'+value.schedule_name+'</option>';
        }
        return a;
    }

    function modifySchedule(){ //수정할 데이터를 Action으로 보내는 역할 함.
        var val=$('[name=menutype]').val();
        var start=new Date($('[name=starting_date]').val());
        var close=new Date($('[name=closing_date]').val());
        if(start.getTime()>close.getTime()){ //전송 전 문제 있는지 검사
            alert("종료일정이 시작일정보다 빠릅니다");
            location.reload();
            return;
        }
        var data=val+"-/-/-"+$('[name=starting_date]').val()+"-/-/-"+$('[name=closing_date]').val();
        //중간에 -/-/- 으로 표시하는건 데이터의 구분을 주기 위함. (받는쪽에서 저 문장을 기준으로 split 해서 나눠버림.)
        alert(data); //data가 잘 전송되고 있나 검사하려고 만든건데 없어져야 할듯.
        $.ajax({ //ajax 프레임워크( jQuery)로 위 data를 서버로 보냄.
            url:"ajax.do", //ajax.do(ajaxAction)에 있는
            type:"post",
            data : {
                req : "insertLockerSchedule", //insertLockerSchedule 메소드를 실행하겠다는 의미.
                data : data //근데 해당 메소드로 같이 보낼 데이터는 이것임.
            },
            success : function(data){
                alert(data+" 상태로 변경이 되었습니다");
                location.reload();
            }
        })
    }


    function modifycontent(i){ //뭐였는지 까먹음. 스케쥴 설명 수정에 관련된 거였음.
        var a='';
        var b='';

        var button = $('#button'+i);
        b+='<a class="btn btn-default" style = "margin : 2px;" onclick="modifycon('+i+')">수정</button><a class="btn btn-default" style = "margin : 2px;" onclick="back('+i+')">뒤로</button>';
        a+='<textarea name="content'+i+'" id="editor'+i+'" required>'+schedule[i].schedule_contents+'</textarea>';
        button.html(b);
        $('#content'+i+'_modi').html(a);
        var edi ='editor'+i;
        CKEDITOR.replace(edi, {
            allowedContent: true,
            height: 100,
            'filebrowserUploadUrl': '/Uploader'
        });
    }
    function back(i){
        var a=schedule[i].schedule_contents;
        var b='';
        var button =$('#button'+i);
        b+='<a onclick="modifycontent('+i+')" class="btn btn-default">수정</a>';
        $('#content'+i+'_modi').html(a);
        button.html(b);
    }
    function modifycon(i){
        var schedulename=schedule[i].schedule_name;
        var id='editor'+i;
        var content=CKEDITOR.instances[id].getData();
        var modify=schedulename+"-/-/-"+content;

        $.ajax({
            url : "ajax.do",
            type : "post",
            data : {
                req : "modifyLockerCon",
                data : modify
            },
            success : function(data){
                var a=data;//content만 받아오자
                var button =$('#button'+i);
                var b='<a onclick="modifycontent('+i+')" class="btn btn-default">수정</a>';
                $('#content'+i+'_modi').html(a);
                button.html(b);
                alert("완료되었습니다");
            }
        })
    }

</script>
