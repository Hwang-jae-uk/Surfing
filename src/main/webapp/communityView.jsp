<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<link rel="stylesheet" href="/css/communityView.css"/>

<jsp:include page="header.jsp"/>
<div class="view-wrapper">
    <table class="post-table">
        <tr>
            <td class="label">제목</td>
            <td>${post.title}</td>
        </tr>
        <tr>
            <td class="label">작성자</td>
            <td>
                <div class="post-meta">
                    <span>${post.userName}</span>
                    <span><fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd HH:MM"/></span>

                </div>
            </td>
        </tr>
        <tr>
            <td colspan="2" class="content">
                <p>${post.content}</p>
            </td>
        </tr>
    </table>

    <div class="comment-section">
        <h2>댓글</h2>
        <div class="comment-list">
            <div class="comment">
                <div class="comment-author">서퍼123</div>
                <div class="comment-content">좋은 정보 감사합니다!</div>
                <div class="comment-date">2024-08-07</div>
            </div>
        </div>

        <div class="comment-form">
            <h3>댓글 작성</h3>
            <form>
                <input type="hidden" name="userName" value="${user.userName}">
                <input type="hidden" name="userId" value="${user.userId}">
                <textarea name="content" placeholder="댓글을 입력하세요..."></textarea>
                <button type="submit">등록</button>
            </form>
        </div>
    </div>

    <div class="view-actions">
        <a href="/community" class="btn list-btn">목록으로</a>
    </div>
</div>
