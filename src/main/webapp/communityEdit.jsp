<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Create Post</title>
    <link rel="stylesheet" href="../css/communityWrite.css">
</head>
<jsp:include page="/header.jsp"/>
<body>
    <div class="write-container">
        <div class="write-box">
            <h2>Create a New Post</h2>
            <form action="/community/edit" method="post">
                <div class="input-group">
                    <label for="title">Title</label>
                    <input type="text" id="title" name="title" value="" required>
                </div>
                <div class="input-group">
                    <label for="content">Content</label>
                    <textarea id="content" name="content" rows="10" required value="" required></textarea>
                </div>
                <button type="submit" class="submit-btn">Submit</button>
            </form>
        </div>
    </div>
</body>
</html>
