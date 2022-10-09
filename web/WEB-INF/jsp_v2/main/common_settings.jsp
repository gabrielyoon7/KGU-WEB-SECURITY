<%--
  Created by IntelliJ IDEA.
  User: Gabriel Yoon
  Date: 2021-08-28
  Time: 오후 12:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <meta name="subject"
          content="Kyonggi University Department of Computer Science">
    <meta name="author" content="Kyonggi Univ. SSF">
    <meta name="keyword"
          content="경기대학교, 컴퓨터과학과, Kyonggi University, Computer Science">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="utf-8">
    <title>경기대학교 AI컴퓨터공학부</title>
    <link rel="stylesheet" href="css/bootstrap-table.css">
    <link href='css/default.css' rel='stylesheet' type='text/css'>
    <link href='css/boardtable.css' rel='stylesheet' type='text/css'>
    <link href='css/content.css' rel='stylesheet' type='text/css'>
    <link href='css/bootstrap.css' rel='stylesheet' type='text/css'>
    <link href='css/information.css' rel='stylesheet' type='text/css'>
    <link href='css/progress-bar.css' rel='stylesheet' type='text/css'>
    <link href='css/step-progress-bar.css' rel='stylesheet' type='text/css'>
    <link href='css/post.css' rel='stylesheet' type='text/css'>
    <link href='css/fileinput.min.css' rel='stylesheet' type='text/css'>
    <link href='css/fileinput-rtl.min.css' rel='stylesheet' type='text/css'>
    <link href="css/theme.css" media="all" rel="stylesheet" type="text/css" />
    <link
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
            media="all" rel="stylesheet" type="text/css" />
    <link href='css/bootstrap-table.css' rel='stylesheet' type='text/css'>
    <script src="js/default.js"></script>
    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="js/step-progress-bar.js"></script>
    <script src="js/default.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/bootstrap-table.js"></script>
    <script src="js/bootstrap-table-cookie.js"></script>
    <script src="js/bootstrap-table-export.min.js"></script>
    <script src='js/sha256.js'></script>
    <script src="//cdn.ckeditor.com/4.8.0/standard/ckeditor.js"></script>
    <script src="js/fileinput.min.js"></script>
    <script src="js/sortable.min.js" type="text/javascript"></script>
    <script src="js/theme.js" type="text/javascript"></script>
    <script src="js/jquery.cookie.js"></script>

<%--    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">--%>
<%--    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>--%>

    <%--    icon    --%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
</head>

<style>
<%--    부트스트랩 5.0과 호환을 위한 작업 시작 --%>
    .m-0 { margin:0!important; }
    .m-1 { margin:.25rem!important; }
    .m-2 { margin:.5rem!important; }
    .m-3 { margin:1rem!important; }
    .m-4 { margin:1.5rem!important; }
    .m-5 { margin:3rem!important; }

    .mt-0 { margin-top:0!important; }
    .me-0 { margin-right:0!important; }
    .mb-0 { margin-bottom:0!important; }
    .ms-0 { margin-left:0!important; }
    .mx-0 { margin-left:0 !important;margin-right:0 !important; }
    .my-0 { margin-top:0!important;margin-bottom:0!important; }

    .mt-1 { margin-top:.25rem!important; }
    .me-1 { margin-right:.25rem!important; }
    .mb-1 { margin-bottom:.25rem!important; }
    .ms-1 { margin-left:.25rem!important; }
    .mx-1 { margin-left:.25rem!important;margin-right:.25rem!important; }
    .my-1 { margin-top:.25rem!important;margin-bottom:.25rem!important; }

    .mt-2 { margin-top:.5rem!important; }
    .me-2 { margin-right:.5rem!important; }
    .mb-2 { margin-bottom:.5rem!important; }
    .ms-2 { margin-left:.5rem!important; }
    .mx-2 { margin-right:.5rem!important;margin-left:.5rem!important; }
    .my-2 { margin-top:.5rem!important;margin-bottom:.5rem!important; }

    .mt-3 { margin-top:1rem!important; }
    .me-3 { margin-right:1rem!important; }
    .mb-3 { margin-bottom:1rem!important; }
    .ms-3 { margin-left:1rem!important; }
    .mx-3 { margin-right:1rem!important;margin-left:1rem!important; }
    .my-3 { margin-bottom:1rem!important;margin-top:1rem!important; }

    .mt-4 { margin-top:1.5rem!important; }
    .me-4 { margin-right:1.5rem!important; }
    .mb-4 { margin-bottom:1.5rem!important; }
    .ms-4 { margin-left:1.5rem!important; }
    .mx-4 { margin-right:1.5rem!important;margin-left:1.5rem!important; }
    .my-4 { margin-top:1.5rem!important;margin-bottom:1.5rem!important; }

    .mt-5 { margin-top:3rem!important; }
    .me-5 { margin-right:3rem!important; }
    .mb-5 { margin-bottom:3rem!important; }
    .ms-5 { margin-left:3rem!important; }
    .mx-5 { margin-right:3rem!important;margin-left:3rem!important; }
    .my-5 { margin-top:3rem!important;margin-bottom:3rem!important; }

    .mt-auto { margin-top:auto!important; }
    .me-auto { margin-right:auto!important; }
    .mb-auto { margin-bottom:auto!important; }
    .ms-auto { margin-left:auto!important; }
    .mx-auto { margin-right:auto!important;margin-left:auto!important; }
    .my-auto { margin-bottom:auto!important;margin-top:auto!important; }

    .p-0 { padding:0!important; }
    .p-1 { padding:.25rem!important; }
    .p-2 { padding:.5rem!important; }
    .p-3 { padding:1rem!important; }
    .p-4 { padding:1.5rem!important; }
    .p-5 { padding:3rem!important; }

    .pt-0 { padding-top:0!important; }
    .pe-0 { padding-right:0!important; }
    .pb-0 { padding-bottom:0!important; }
    .ps-0 { padding-left:0!important; }
    .px-0 { padding-left:0!important;padding-right:0!important; }
    .py-0 { padding-top:0!important;padding-bottom:0!important; }

    .pt-1 { padding-top:.25rem!important; }
    .pe-1 { padding-right:.25rem!important; }
    .pb-1 { padding-bottom:.25rem!important; }
    .ps-1 { padding-left:.25rem!important; }
    .px-1 { padding-left:.25rem!important;padding-right:.25rem!important; }
    .py-1 { padding-top:.25rem!important;padding-bottom:.25rem!important; }

    .pt-2 { padding-top:.5rem!important; }
    .pe-2 { padding-right:.5rem!important; }
    .pb-2 { padding-bottom:.5rem!important; }
    .ps-2 { padding-left:.5rem!important; }
    .px-2 { padding-right:.5rem!important;padding-left:.5rem!important; }
    .py-2 { padding-top:.5rem!important;padding-bottom:.5rem!important; }

    .pt-3 { padding-top:1rem!important; }
    .pe-3 { padding-right:1rem!important; }
    .pb-3 { padding-bottom:1rem!important; }
    .ps-3 { padding-left:1rem!important; }
    .py-3 { padding-bottom:1rem!important;padding-top:1rem!important; }
    .px-3 { padding-right:1rem!important;padding-left:1rem!important; }

    .pt-4 { padding-top:1.5rem!important; }
    .pe-4 { padding-right:1.5rem!important; }
    .pb-4 { padding-bottom:1.5rem!important; }
    .ps-4 { padding-left:1.5rem!important; }
    .px-4 { padding-right:1.5rem!important;padding-left:1.5rem!important; }
    .py-4 { padding-top:1.5rem!important;padding-bottom:1.5rem!important; }

    .pt-5 { padding-top:3rem!important; }
    .pe-5 { padding-right:3rem!important; }
    .pb-5 { padding-bottom:3rem!important; }
    .ps-5 { padding-left:3rem!important; }
    .px-5 { padding-right:3rem!important;padding-left:3rem!important; }
    .py-5 { padding-top:3rem!important;padding-bottom:3rem!important; }

    .align-items-md-stretch{
        align-items: stretch !important;
    }
    .justify-content-between {
        justify-content: space-between !important;
    }
    .justify-content-start {
        justify-content: flex-start!important;
    }
    .d-flex {
        display: flex !important;
    }
<%--    부트스트랩 5.0과 호환을 위한 작업 끝 --%>
</style>


<style>

    a{
        color: black; !important;
    }

    /**
    *
    *추가
    */

    /*#maincontent {*/
    /*    padding: 0;*/
    /*}*/

    /*#maincontent > ul {*/
    /*    padding: 10px;*/
    /*}*/

    /*.boardtable > thead > tr > th, .boardtable > tbody > tr > td {*/
    /*    text-overflow: ellipsis;*/
    /*    overflow: hidden;*/
    /*    white-space: nowrap;*/
    /*    text-align: center;*/
    /*    border-right: none;*/
    /*    border-left: none;*/
    /*}*/

    /*.boardtable > thead > tr > th:nth-child(1), .boardtable > tbody > tr > td:nth-child(1) {*/
    /*    min-width: 65px;*/
    /*    max-width: 65px;*/
    /*    width: 65px;*/
    /*}*/

    /*.boardtable > thead > tr > th:nth-child(2), .boardtable > tbody > tr > td:nth-child(2) {*/
    /*    min-width: 400px;*/
    /*    max-width: 400px;*/
    /*    width: 400px;*/
    /*}*/

    /*.boardtable > thead > tr > th:nth-child(3), .boardtable > tbody > tr > td:nth-child(3), .boardtable > thead > tr > th:nth-child(5), .boardtable > tbody > tr > td:nth-child(5) {*/
    /*    min-width: 80px;*/
    /*    max-width: 80px;*/
    /*    width: 80px;*/
    /*}*/

    /*.boardtable > thead > tr > th:nth-child(4), .boardtable > tbody > tr > td:nth-child(4) {*/
    /*    min-width: 100px;*/
    /*    max-width: 100px;*/
    /*    width: 100px;*/
    /*}*/

    /*.fixed-table-container {*/
    /*    border: none;*/
    /*}*/

    /*.pagination-info {*/
    /*    display: none;*/
    /*}*/

    /*.pull-right-pagination {*/
    /*    width: 100%;*/
    /*}*/

    /*.pull-right {*/
    /*    float: none !important;*/
    /*}*/

    /*.fixed-table-pagination {*/
    /*    width: 100%;*/
    /*    text-align: center;*/
    /*}*/

    /*div .search {*/
    /*    width: fit-content;*/
    /*    float: right !important;*/
    /*}*/

    /*.file-drop-zone-title{*/
    /*    padding : 25px 10px;*/
    /*}*/

    /*.kv-file-content {*/
    /*    width : 500px !important;*/
    /*}*/

    /*.file-details-cell {*/
    /*    display : none;*/
    /*}*/

    /*.kv-zoom-thumb {*/
    /*    display : none;*/
    /*}*/

    /*.fileinput-remove{*/
    /*    display : none;*/
    /*}*/
</style>