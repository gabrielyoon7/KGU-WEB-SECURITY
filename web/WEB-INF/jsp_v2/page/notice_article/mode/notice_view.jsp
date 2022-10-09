<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 2022-01-25
  Time: 오전 11:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String user = (String) session.getAttribute("user");
    String type = (String) session.getAttribute("type");

    String boards = (String) request.getAttribute("boards");
    String boardLevel = (String) request.getAttribute("boardLevel");
    String num = (String) request.getAttribute("num");
    String id = (String) request.getAttribute("id");
    String tabmenulist = (String) request.getAttribute("tabmenulist");
    String file = (String) request.getAttribute("file");
    String nextlist = (String) request.getAttribute("nextlist");
%>

<ul>
    <li>
        <div id="articlename" class="contenttitle"></div>
    </li>
</ul>

<div id="post">
    <div id="posttitle" style="overflow-wrap:break-word;">
        <!-- 제목 -->

    </div>
    <div id="postinfo">
        <!-- 작성자, 조회수, 작성일 -->
        <div id="postname"></div>
        <div>
            <div id="postviews"
                 style="border-right : 1px solid black; margin-right:10px; padding-right: 10px">조회수 :
            </div>
            <div id="postlast"> 작성일 :</div>
        </div>
    </div>
    <div id="post_box" class="post_box">
    </div>
    <div>
        <div id="postmain">
            <!-- 메인내용 (content) -->
        </div>
    </div>
    <div id="post_button" class="post_button">
    </div>
</div>

<!-- 댓글 -->
<div id="comment">
    <div id="commenttitle"></div>
    <div id="commentall"></div>
    <div></div>
</div>
<div id="comment_edit_container">
    <form name="commentInsertForm">
        <div class="input-group">
            <input type="hidden" name="student_id" value="anomyous"><!-- 세션 -->
            <input type="hidden" name="article_id" value=<%=id %>>
            <div id="for_comment"></div>
        </div>
    </form>
</div>
<div id="next_post" class="post_box">
    <ul>
        <li>
            <div>다음글</div>
            <div>|</div>
            <div id="nextpost" class="one-line"></div>
        <li>
            <div>이전글</div>
            <div>|</div>
            <div id="previouspost" class="one-line"></div>
    </ul>
</div>

<script>
    $(document).ready(function () { //본문 제어
        makePageTitle('articlename'); // 본문 안에 제목 넣어주는 역할 (page.jsp에서 함수를 찾아보세요)
    })

    if (<%=boardLevel%>.write_comment_level >= <%=type%>.board_level){
        $('#for_comment').append('<textarea style="resize:none" name="content" class="form-control" cols="100" rows="1" placeholder="댓글을 입력하세요." required></textarea><div class="post_button" id="post_submit_btn"><a id="post_submit" class="btn btn-default">쓰기</a></div>');
    }
</script>

<script>   //post
var title = $('#posttitle');
var postauthor = $('#postname');
var views = $('#postviews');
var lastmodified = $('#postlast');
var content = $('#postmain');
var button = $('#post_button');
var arr =<%=boards%>//관련된 모든 정보
var num = <%=num%>;
var value = arr;

function formatDate(date) {
    var d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();
    hour = d.getHours();
    minute = d.getMinutes();

    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;

    return [year, month, day].join('-') + ' ' + [hour, minute].join(':');
}


content.append(makemain(value));
title.append(value.title);
postauthor.append('<strong>' + value.student_name + '</strong>');
views.append(value.views);
lastmodified.append(formatDate(value.last_modified));


button.append(makelistbutton(num));
if (<%=user%> !=null){
    if (arr.student_id == <%=user%>.id || <%=user%>.type.includes('관리자')){
        button.append(makeFixedButton(value));
        button.append(makemodifybutton(value, num));
        button.append(makedeletebutton(value));
    }
}

function makemain(str) {
    return str.content;
}

function makeFixedButton(str){ //공지사항 고정 관련 코드
    if ( <%=user%>.type.includes('관리자') )
    {
        let button = '<div><a onclick="fixed_button(\'' + str.fixed +'-/-/-'+str.id+'\')" class="btn btn-default">';
        if (str.fixed == 'false') {
            button += '게시글 고정 등록'
        } else {
            button += '게시글 고정 해제'
        }
        button += '</a></div>'
        return button;
    }
}

function makelistbutton(num) {
    return '<div><a href="notice_article_list.kgu?num=' + num + '" class="btn btn-default">목록</a></div>';
}

function makemodifybutton(str, num) {
    return '<div><a href="notice_article_modifier.kgu?num=' + num + '&id=' + str.id + '" id="modifier" class="btn btn-default">수정</a></div>';
}

function makedeletebutton(str) {
    return '<div><input type="hidden" name="article_id" value="' + str.id + '">' +
        '<a onclick="boardDelete(' + <%=id%> +')" class="btn btn-default">삭제</a>' + '</div>';
}

function fixed_button(status){
    $.ajax({
        url: 'ajax.kgu',
        type: 'post',
        data: {
            req: "fixed_button",
            data: status
        },
        dataType: "json",
        success: function (data) {
            location.reload();
        }
    });
}

</script>



<script>//comment
var id = <%=id%>; //게시글 번호
var comment = $('#commentall');
var commenttitle = $('#commenttitle');


$('#post_submit').click(function () { //댓글 등록 버튼 클릭시
    var user = <%=user%>;
    var student_id = user.id;
    var student_name = user.name;
    var article_id = $('[name=article_id]').val();
    var content = $('[name=content]').val();
    if (content == "") {
        alert("댓글이 입력되지 않았습니다.");
        return;
    }
    if (content.length >= 125) {
        alert("댓글이 너무 깁니다!");
        return;
    }
    var insertData = student_id + "-/-/-" + student_name + "-/-/-" + article_id + "-/-/-" + content;
    commentInsert(insertData); //Insert 함수호출(아래)
});


//댓글 목록
function commentList() {
    $.ajax({
        url: 'ajax.do',
        type: 'post',
        data: {
            req: "noticegetcomment",
            data: id,
        },
        dataType: "json",
        success: function (data) {
            var arr = data;
            commenttitle.append('Comment (' + arr.length + '개)');
            for (var a = 0; a < data.length; a++) {
                var value = arr[a];
                comment.append(commentlist(value));
            }

            function commentlist(value) {
                if (<%=user%> != null)
                {
                    if (value.writer_id == <%=user%>.id || <%=type%>.type_name.includes("관리자")){
                    return '<div class="commentmain"><div><strong>' + value.writer_name + '</strong></div>' +
                        '<div id="comment_' + value.id + '_main" class="comment_main_content" style="max-width : 420px">' + value.content + '</div>' +
                        '<div>' + formatDate(value.last_modified) + '</div>' +
                        '<div id="commentmodify' + value.id + '">' + commentmodify(value) + '</div></div>';
                }
                else
                    {
                        {
                            return '<div class="commentmain"><div><strong>' + value.writer_name + '</strong></div>' +
                                '<div id="comment_' + value.id + '_main" class="comment_main_content">' + value.content + '</div>' +
                                '<div>' + formatDate(value.last_modified) + '</div>' +
                                '</div>';
                        }
                    }
                }
            else
                {
                    return '<div class="commentmain"><div><strong>' + value.writer_name + '</strong></div>' +
                        '<div id="comment_' + value.id + '_main" class="comment_main_content">' + value.content + '</div>' +
                        '<div>' + formatDate(value.last_modified) + '</div>' +
                        '</div>';
                }
            }

            function commentmodify(value) {
                return '<a onclick="commentUpdate(' + value.id + ',\'' + value.content + '\')" class="btn btn-default">수정 </a>' +
                    '<a onclick="commentDelete(' + value.id + ')" class="btn btn-default">삭제</a>';
            }
        }
    });
}

//댓글 등록
function commentInsert(insertData) {
    var data = insertData + '-/-/-' +
    <%=boardLevel%>.
    write_comment_level;
    $.ajax({
        url: 'ajax.do',
        type: 'post',
        typeData: "gson",
        data: {
            req: "noticecommentInsert",
            data: data
        },
        success: function (data) {
            if (data == 'fail') {
                alert('SERVER ERROR, Please try again later...');
                return;
            }
            var a = '';
            comment.html(a);
            commenttitle.html(a);
            commentList(); //댓글 작성 후 댓글 목록 reload
            $('[name=content]').val('');
        }
    });
}

//댓글 수정 - 댓글 내용 출력을 input 폼으로 변경
function commentUpdate(id, content) {
    $('#commentmodify' + id).empty();
    var a = '';
    a += '<form name="commentupdate">';
    a += '<div class="input-group">';
    a += '<input type="hidden" name="comment_id" value=' + id + '>';
    a += '<textarea style="resize:none" name="content2" class="form-control" cols="100" rows="1" placeholder="댓글을 입력하세요." required>' + content + '</textarea>';
    a += '</div></form>';
    $('#commentmodify' + id).append('<a href="javascript:commentUpdateProc()" id="update_submit1" class="btn btn-default" style="margin-left:30px;">완료</a>');
    $('#comment_' + id + '_main').html(a);

}


//댓글 수정
function commentUpdateProc() {
    var id = $('[name=comment_id]').val();
    var content = $('[name=content2]').val();
    var updateContent = id + "-/-/-" + content;
    if (updateContent.length >= 125) {
        alert("댓글이 너무 깁니다!");
        return;
    }
    if (updateContent.length == 0) {
        alert('댓글을 입력해주세요!');
        return;
    }

    $.ajax({
        url: 'ajax.do',
        type: 'post',
        data: {
            req: "noticemodifycomment",
            data: updateContent
        },
        success: function (data) {
            comment.empty();
            commenttitle.empty();
            commentList(); //댓글 작성 후 댓글 목록 reload
        }
    });
}

//댓글 삭제
function commentDelete(id) {
    var check = confirm("정말 삭제하시겠습니까?");
    if (!check)
        return;
    $.ajax({
        url: 'ajax.do',
        type: 'post',
        data: {
            req: "noticedeletecomment",
            data: id
        },
        success: function (data) {
            if (data == 1) {
                var a = '';
                commenttitle.html(a);
                comment.html(a);
                commentList(); //댓글 삭제후 목록 출력
            } else {
                alert('SERVER ERROR, Please try again later...');
            }
        }
    });
}


$(document).ready(function () {
    if (<%=boardLevel%>.
    read_comment_level >=
    <%=type%>.
    board_level
)
    commentList(); //페이지 로딩시 댓글 목록 출력
});

function boardDelete(id) {//board 삭제
    var check = confirm('정말 삭제하시겠습니까?');
    if (!check)
        return;
    $.ajax({
        url: 'notice_boarddelete.do',
        type: 'post',
        data: {data: id},
        success: function (data) {
            alert("삭제가 완료 되었습니다.");
            window.location.href = 'notice_article_list.kgu?num=' +<%=num%>;
        }
    });
}

//글에 저장된 파일
var postbox = $('#post_box');
var file = <%=file%>;
var a = '';
if (file.length > 0)
    a += '첨부파일: ';
if (file.length == 0)
    $('#post_box').remove();
var isAvailable = 0;

for (var i = 0; i < file.length; i++) {
    var it = file[i];
    if (<%=type%>.
    board_level <=
    <%=boardLevel%>.
    file_download_level
)
    a += '<a href="notice_download.kgu?id=' + it.id + '">' + it.filename + '</a>&nbsp&nbsp';
else
    a += it.filename + '<span>&nbsp&nbsp</span>';
}
postbox.append(a);


var nlist = <%=nextlist%>;
var next = $('#nextpost');
var previous = $('#previouspost');
if (nlist[0].title == undefined)
    next.append('다음글이 없습니다.');
else
    next.append('<a href="notice_article_reader.kgu?id=' + nlist[0].id + '&num=' + num + '">' + nlist[0].title + '</a>');
if (nlist[1].title == undefined)
    previous.append('이전글이 없습니다.');
else
    previous.append('<a href="notice_article_reader.kgu?id=' + nlist[1].id + '&num=' + num + '">' + nlist[1].title + '</a>');
</script>