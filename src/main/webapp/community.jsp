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
            <form class="search-form" method="POST" action="/community">
                <input type="text" name="searchTitle" placeholder="Search...">
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
        <c:if test="${empty searchTitle}">
            <div class="load-more-container">
                <button id="load-more-btn" data-page="1">Load More</button>
            </div>
        </c:if>
    </div>

    <script>
        const loadMoreBtn = document.getElementById('load-more-btn');
        const tableBody = document.querySelector('.post-table tbody');
        let postIndex = ${posts.size()};

        loadMoreBtn.addEventListener('click', () => {
            console.log('Button clicked.');
            console.log('Button element:', loadMoreBtn);
            console.log('data-page attribute:', loadMoreBtn.dataset.page);

            const currentPage = parseInt(loadMoreBtn.dataset.page, 10);
            console.log('Parsed currentPage:', currentPage);

            const nextPage = currentPage + 1;
            console.log('Calculated nextPage:', nextPage);


            console.log('Fetching page: ' + nextPage);
            fetch('/community?page=' + nextPage, { cache: 'no-cache' })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(newPosts => {
                    console.log(newPosts); // Log the received data
                    if (newPosts && newPosts.length > 0) {
                        loadMoreBtn.dataset.page = nextPage;
                        newPosts.forEach(post => {
                            const row = document.createElement('tr');
                            postIndex++;

                            // No. cell
                            const cellNo = document.createElement('td');
                            cellNo.textContent = postIndex;
                            row.appendChild(cellNo);

                            // Title cell
                            const cellTitle = document.createElement('td');
                            const link = document.createElement('a');
                            link.href = `/community/view?id=${post.communityPostId}`;
                            link.textContent = post.title;
                            cellTitle.appendChild(link);
                            row.appendChild(cellTitle);

                            // User cell
                            const cellUser = document.createElement('td');
                            cellUser.textContent = post.userName;
                            row.appendChild(cellUser);

                            // Date cell
                            const cellDate = document.createElement('td');
                            cellDate.textContent = post.createdAt;
                            row.appendChild(cellDate);

                            tableBody.appendChild(row);
                        });
                    } else {
                        loadMoreBtn.textContent = "불러올 게시글이 없습니다";
                        loadMoreBtn.disabled = true;
                    }
                })
                .catch(error => {
                    console.error('Error loading more posts:', error);
                    loadMoreBtn.textContent = 'Error loading posts';
                    loadMoreBtn.disabled = true;
                });
        });
    </script>
</body>
</html>