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
            <form action="/community/write" method="post" onsubmit="confirm('글을 작성하시겠습니까?')" enctype="multipart/form-data">
                <div class="input-group">
                    <label for="title">Title</label>
                    <input type="text" id="title" name="title" required>
                </div>
                <div class="input-group">
                    <label for="content">Content</label>
                    <textarea id="content" name="content" rows="10" required></textarea>
                </div>
                <div class="input-group">
                    <label for="file">Image File</label>
                    <input type="file" id="file" name="file" multiple>
                    <div id="image-preview-container" style="margin-top: 10px;"></div>
                </div>
                <button type="submit" class="submit-btn">Submit</button>
            </form>
        </div>
    </div>
<script>
    document.getElementById('file').addEventListener('change', function(event) {
        const files = event.target.files;
        const previewContainer = document.getElementById('image-preview-container');
        previewContainer.innerHTML = ''; // 기존 미리보기 초기화

        Array.from(files).forEach(file => {
            if (file.type.startsWith('image/')) {
                const img = document.createElement('img');
                img.src = URL.createObjectURL(file);
                img.style.borderRadius = '10px';
                img.style.width = '100px';
                img.style.height = '100px';
                img.style.marginRight = '10px';
                img.style.marginBottom = '10px';
                previewContainer.appendChild(img);
            }
        });
    });
</script>
</body>
</html>
