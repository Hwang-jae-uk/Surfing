<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Community</title>
    <link rel="stylesheet" href="css/community.css"/>
</head>
<body>
    <jsp:include page="header.jsp"/>
    <div class="community-wrapper">
        <h1>Community</h1>
        <div class="community-header">
            <form class="search-form">
                <input type="text" placeholder="Search...">
                <button type="submit">Search</button>
            </form>
            <button class="write-btn" onclick="location.href='/community/write'">Write</button>
        </div>
        <table class="post-table">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Title</th>
                    <th>userName</th>
                    <th>Date</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${empty posts}">
                    <tr>
                        <td colspan="4">아직 게시글이 없습니다.</td>
                    </tr>
                </c:if>
                <c:if test="${not empty posts}">
                    <c:forEach var="post" items="${posts}" varStatus="status">
                        <tr>
                            <td>${status.index+1}</td>
                            <td><a href="/community/view?id=${post.communityPostId}">${post.title}</a></td>
                            <td>${post.userName}</td>
                            <td><fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd"/></td>
                        </tr>
                    </c:forEach>
                </c:if>
            </tbody>
        </table>
    </div>
</body>
</html>