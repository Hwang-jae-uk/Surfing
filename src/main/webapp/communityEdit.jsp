<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit Post</title>
    <link rel="stylesheet" href="../css/communityWrite.css">
    <link rel="stylesheet" href="../css/communityEdit.css">
</head>
<jsp:include page="/header.jsp"/>
<body>
    <div class="write-container">
        <div class="write-box">
            <h2>Edit Post</h2>
            <form action="/community/edit" method="post" enctype="multipart/form-data">
                <input type="hidden" name="deletedImages" id="deletedImages">
                <div class="input-group">
                    <label for="title">Title</label>
                    <input type="text" id="title" name="title" value="${communityPostDTO.getTitle()}" required>
                    <input type="hidden" id="communityPostId" name="communityPostId" value="${communityPostDTO.getCommunityPostId()}">
                </div>
                <c:forEach var="image" items="${postImage}">
                    <div class="image-container" id="image-container-${image.getPostImagePath()}">
                        <img style="width: 300px; height: 300px;" src="${pageContext.servletContext.getInitParameter('postImage')}/${image.getPostImagePath()}"/>
                        <span class="delete-btn" onclick="deleteImage('${image.getPostImagePath()}')">X</span>
                    </div>
                </c:forEach>
                <div class="input-group">
                    <label for="content">Content</label>
                    <textarea id="content" name="content" rows="10" required>${communityPostDTO.getContent()}</textarea>
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
        function deleteImage(imageName) {
            // Hide the image container
            document.getElementById('image-container-' + imageName).style.display = 'none';

            // Add the image name to the hidden input
            let deletedImagesInput = document.getElementById('deletedImages');
            if (deletedImagesInput.value) {
                deletedImagesInput.value += ',';
            }
            deletedImagesInput.value += imageName;
        }


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
