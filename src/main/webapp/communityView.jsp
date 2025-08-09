<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<link rel="stylesheet" href="/css/communityView.css"/>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<jsp:include page="header.jsp"/>

<div class="view-wrapper">
    <article>
        <header class="post-header">
            <h1>${post.title}</h1>
            <div class="post-meta">
                <div>
                    <span class="post-author">작성자: ${post.userName}</span>
                    <span class="post-date"><fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd HH:mm"/></span>
                </div>
                <c:if test="${post.userId == user.userId}">
                    <div class="post-actions">
                        <button onclick="location.href='/community/edit'" type="button" id="editPostBtn" class="btn btn-primary">수정</button>
                        <button type="button" id="deletePostBtn" class="btn btn-danger">삭제</button>
                    </div>
                </c:if>
            </div>
        </header>

        <section class="post-content">
            <p>${post.content}</p>
        </section>
    </article>

    <section class="comment-section">
        <h2>댓글 (${comments.size()})</h2>
        <div class="comment-list">
            <c:forEach var="comment" items="${comments}">
                <div class="comment">
                    <div class="comment-author">${comment.userName}</div>
                    <div class="comment-content">${comment.content}</div>
                    <div class="comment-date"><fmt:formatDate value="${comment.createdAt}" pattern="yyyy-MM-dd HH:mm"/></div>
                    <c:if test="${comment.userId == user.userId}">
                        <div class="comment-actions">
                            <button class="btn btn-edit-comment" data-comment-id="${comment.communityCommentId}">수정</button>
                            <button class="btn btn-delete-comment" data-comment-id="${comment.communityCommentId}">삭제</button>
                        </div>
                    </c:if>
                </div>
            </c:forEach>
        </div>

        <div class="comment-form-box">
            <c:if test="${not empty user.email}">
                <h3>댓글 작성</h3>
                <form id="commentForm">
                    <input type="hidden" name="communityPostId" value="${post.communityPostId}">
                    <input type="hidden" name="userName" value="${user.userName}">
                    <input type="hidden" name="userId" value="${user.userId}">
                    <textarea name="content" placeholder="따뜻한 댓글을 남겨주세요..."></textarea>
                    <button type="submit" class="btn btn-primary">등록</button>
                </form>
            </c:if>
            <c:if test="${empty user.email}">
                <div class="post-comment-notlogin">
                    <span>로그인하고 따뜻한 댓글을 남겨보세요.</span>
                    <a href="/login" class="btn btn-login">로그인 하러 가기</a>
                </div>
            </c:if>
        </div>
    </section>

    <div class="view-actions">
        <a href="/community" class="btn btn-secondary">목록으로</a>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const commentForm = document.getElementById('commentForm');
        if (commentForm) {
            commentForm.addEventListener('submit', function (e) {
                e.preventDefault();

                const targetForm = e.target;
                const communityPostId = targetForm.communityPostId.value;
                const userName = targetForm.userName.value;
                const userId = targetForm.userId.value;
                const content = targetForm.content.value;

                if (!content.trim()) {
                    alert("댓글 내용을 입력해주세요.");
                    return;
                }

                axios.post("/community/comment", {
                    communityPostId: communityPostId,
                    userName: userName,
                    userId: userId,
                    content: content
                })
                .then(response => {
                    alert("댓글이 등록되었습니다.");
                    location.reload();
                })
                .catch(error => {
                    console.error(error);
                    alert("댓글 등록에 실패했습니다.");
                });
            });
        }

        const editPostBtn = document.getElementById('editPostBtn');
        if (editPostBtn) {
            editPostBtn.addEventListener('click', function () {
                window.location.href = `/community/edit?communityPostId=${post.communityPostId}`;
            });
        }

        const deletePostBtn = document.getElementById('deletePostBtn');
        if (deletePostBtn) {
            deletePostBtn.addEventListener('click', function () {
                if (confirm('정말로 이 게시글을 삭제하시겠습니까?')) {
                    axios.post(`/postdelete?communityPostId=${post.communityPostId}`)
                        .then(response => {
                            alert('게시글이 삭제되었습니다.');
                            window.location.href = '/community';
                        })
                        .catch(error => {
                            console.error(error);
                            alert('게시글 삭제에 실패했습니다.');
                        });
                }
            });
        }

        document.querySelectorAll('.btn-edit-comment').forEach(button => {
            button.addEventListener('click', function () {
                const commentDiv = this.closest('.comment');
                const commentContent = commentDiv.querySelector('.comment-content');
                const originalContent = commentContent.textContent;

                // Turn the comment content into a textarea for editing
                commentContent.innerHTML = `<textarea class="edit-comment-textarea">${originalContent}</textarea>`;

                // Hide edit/delete buttons and show save/cancel buttons
                const actionsDiv = commentDiv.querySelector('.comment-actions');
                actionsDiv.style.display = 'none';

                const newActions = document.createElement('div');
                newActions.className = 'comment-actions-edit';
                newActions.innerHTML = 
                    `<button class="btn btn-save-comment">저장</button>
                     <button class="btn btn-cancel-edit">취소</button>`;
                commentDiv.appendChild(newActions);

                // Handle save
                newActions.querySelector('.btn-save-comment').addEventListener('click', () => {
                    const newContent = commentDiv.querySelector('.edit-comment-textarea').value;
                    const commentId = this.getAttribute('data-comment-id');

                    axios.post('/community/comment/update', { 
                        communityCommentId: commentId,
                        content: newContent
                    })
                    .then(response => {
                        alert('댓글이 수정되었습니다.');
                        location.reload();
                    })
                    .catch(error => {
                        console.error(error);
                        alert('댓글 수정에 실패했습니다.');
                        // Restore original view on failure
                        commentContent.textContent = originalContent;
                        commentDiv.removeChild(newActions);
                        actionsDiv.style.display = 'block';
                    });
                });

                // Handle cancel
                newActions.querySelector('.btn-cancel-edit').addEventListener('click', () => {
                    commentContent.textContent = originalContent;
                    commentDiv.removeChild(newActions);
                    actionsDiv.style.display = 'block';
                });
            });
        });

        document.querySelectorAll('.btn-delete-comment').forEach(button => {
            button.addEventListener('click', function () {
                const commentId = this.getAttribute('data-comment-id');
                if (confirm('정말로 이 댓글을 삭제하시겠습니까?')) {
                    axios.post('/postcommentdelete?communityCommentId=' + commentId)
                        .then(response => {
                            alert('댓글이 삭제되었습니다.');
                            location.reload();
                        })
                        .catch(error => {
                            console.error(error);
                            alert('댓글 삭제에 실패했습니다.');
                        });
                }
            });
        });
    });
</script>