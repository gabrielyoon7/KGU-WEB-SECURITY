<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-01-11
  Time: 오후 2:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="utf-8">
        <title>게시판:경기대학교 AI컴퓨터공학부</title>
        <link rel="stylesheet" href="css/bootstrap-table.css">
        <link href='css/bootstrap.css' rel='stylesheet' type='text/css'>
        <link href='css/default.css' rel='stylesheet' type='text/css'>
        <link href='css/boardtable.css' rel='stylesheet' type='text/css'>
        <link href='css/information.css' rel='stylesheet' type='text/css'>
        <link href='css/content.css' rel='stylesheet' type='text/css'>
        <style>
            #maincontent {
                padding: 0;
            }

            #maincontent > ul {
                padding: 10px;
            }

            .boardtable > thead > tr > th, .boardtable > tbody > tr > td {
                text-overflow: ellipsis;
                overflow: hidden;
                white-space: nowrap;
                text-align: center;
                border-right: none;
                border-left: none;
            }

            .boardtable > thead > tr > th:nth-child(1), .boardtable > tbody > tr > td:nth-child(1) {
                min-width: 65px;
                max-width: 65px;
                width: 65px;
            }

            .boardtable > thead > tr > th:nth-child(2), .boardtable > tbody > tr > td:nth-child(2) {
                min-width: 400px;
                max-width: 400px;
                width: 400px;
            }

            .boardtable > thead > tr > th:nth-child(3), .boardtable > tbody > tr > td:nth-child(3), .boardtable > thead > tr > th:nth-child(5), .boardtable > tbody > tr > td:nth-child(5) {
                min-width: 80px;
                max-width: 80px;
                width: 80px;
            }

            .boardtable > thead > tr > th:nth-child(4), .boardtable > tbody > tr > td:nth-child(4) {
                min-width: 100px;
                max-width: 100px;
                width: 100px;
            }

            .fixed-table-container {
                border: none;
            }

            .pagination-info {
                display: none;
            }

            .pull-right-pagination {
                width: 100%;
            }

            .pull-right {
                float: none !important;
            }

            .fixed-table-pagination {
                width: 100%;
                text-align: center;
            }

            div .search {
                width: fit-content;
                float: right !important;
            }

        </style>
</head>
<body>

</body>
</html>
