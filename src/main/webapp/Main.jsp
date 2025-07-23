<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="/css/Main.css">
    <title>home</title>
</head>
<body>
    <jsp:include page="/header.jsp"/>
    <div class="main-wrapper">
        <div class="main-container">
            <div class="main-img-container">
                <img class="main-img" onclick="location.href='/surfing'" src="/img/main-surfing.jpg">
                <div class="main-img-text">떠나보자</div>
            </div>
            <div class="main-img-container">
                <img class="main-img" onclick="location.href=''" src="/img/main-surfing2.jpg">
                <div class="main-img-text">함께가자</div>
            </div>
        </div>

    </div>
</body>
</html>
