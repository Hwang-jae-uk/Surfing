<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Title</title>
    <link rel="stylesheet" href="/css/header.css"/>
</head>
<body>
    <div class="header-wrapper">
        <div>
            <h2 class="header-title" onclick="location.href='/main'">Surfing</h2>
        </div>
        <div class="header-menu">
            <span class="header-btn" onclick="location.href='/main'">home</span>
            <span class="header-btn" onclick="location.href='/surfing'">surfing</span>
            <span class="header-btn" onclick="location.href='/community'">community</span>
            <span class="header-btn" onclick="location.href='/groups'">groups</span>

            <c:if test="${empty sessionScope.email}">
                <span class="header-btn" onclick="location.href='/login'">login</span>
                <span class="header-btn" onclick="location.href='/signup'">sign up</span>
            </c:if>
            <c:if test="${not empty sessionScope.email}">
                <span class="header-btn" onclick="location.href='/profile'">profile</span>
                <span class="header-btn" onclick="location.href='/logout.jsp'">logout</span>
            </c:if>
        </div>
    </div>
</body>
</html>
