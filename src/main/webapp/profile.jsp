<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile</title>
    <link rel="stylesheet" href="css/profile.css"/>
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="profile-wrapper">
    <div class="profile-box">
        <h1>Profile</h1>
        <form action="/profile" method="post" enctype="multipart/form-data">
            <div class="input-group">
                <label for="username">User Name</label>
                <input type="text" id="username" name="username" value="${user.userName}" required>
            </div>
            <div class="input-group">
                <label for="currentpassword">Current Password</label>
                <input type="password" id="currentpassword" name="currentpassword" required>
            </div>
            <div class="input-group">
                <label for="newpassword">New Password</label>
                <input type="password" id="newpassword" name="newpassword" >
            </div>
            <div class="input-group">
                <label for="confirmnewpassword">Confirm New Password</label>
                <input type="password" id="confirmnewpassword" name="confirmnewpassword" >
            </div>
            <div class="input-group">
                <label for="file">Profile Picture</label>
                <input type="file" id="file" name="file" accept="image/*">
                <img id="image-preview" src="#" alt="Image preview" style="border-radius: 50% ; width: 100px; height: 100px; margin-top: 10px; display: none;"/>
            </div>
            <div class="input-group">
                <label for="phone">Phone</label>
                <input type="tel" id="phone" name="phone" value="${user.phone}" oninput="this.value = this.value.replace(/[^0-9]/g, '')" required placeholder="숫자만 입력하세요.">
            </div>
            <button type="submit" class="profile-btn">Update Profile</button>
        </form>
        <div class="delete-link" onclick="confirm('삭제하시겠습니까?')">
            <p><a href="/user/delete">Delete Account</a></p>
        </div>
    </div>
</div>
<c:if test="${not empty error}">
    <script>
        alert('${error}')
    </script>
</c:if>
<script>
    document.querySelector('form').addEventListener('submit' , function (e){

        const phone = document.getElementById('phone').value;
        if(phone.length !==11){
            alert("전화번호는 11자리여야 합니다.")
            e.preventDefault()
            return false;
        }
    })
    document.getElementById('file').addEventListener('change', function(event) {
        const file = event.target.files[0];
        if (file && file.type.startsWith('image/')) {
            const preview = document.getElementById('image-preview');
            preview.src = URL.createObjectURL(file);
            preview.style.display = 'block';
        }
    });
</script>
</body>
</html>