<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
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
            <button class="write-btn" onclick="location.href='write.jsp'">Write</button>
        </div>
        <table class="post-table">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Title</th>
                    <th>Author</th>
                    <th>Date</th>
                </tr>
            </thead>
            <tbody>
                <!-- Sample Data -->
                <tr>
                    <td>1</td>
                    <td><a href="post.jsp?id=1">First post</a></td>
                    <td>Admin</td>
                    <td>2024-07-29</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td><a href="post.jsp?id=2">Second post</a></td>
                    <td>User1</td>
                    <td>2024-07-29</td>
                </tr>
            </tbody>
        </table>
        <div class="pagination">
            <a href="#">&laquo;</a>
            <a href="#" class="active">1</a>
            <a href="#">2</a>
            <a href="#">3</a>
            <a href="#">&raquo;</a>
        </div>
    </div>
</body>
</html>