<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
                <img class="main-img" onclick="location.href='/groups'" src="/img/main-surfing2.jpg">
                <div class="main-img-text">함께가자</div>
            </div>
        </div>
        <div class="group-card-wrapper">
            <c:forEach var="group" items="${groups}">
                <div class="group-cards-container">
                    <span class="group-card">
                        <div class="card-header">
                            <div class="card-header-user">
                                <div class="user-avatar"></div>
                                <span class="user-name">${group.userName}</span>
                            </div>
                        </div>
                        <div class="group-info">
                            ${group.title}
                            <p><strong>From:</strong> ${group.fromLocation}</p>
                            <p><strong>To:</strong> ${group.toLocation}</p>
                            <p><strong>Date:</strong>${group.meetingDate}</p>
                        </div>
                        <button class="join-btn">View Details</button>
                    </span>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>
