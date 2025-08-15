<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>
    <link rel="stylesheet" href="css/signup.css"/>
</head>
<body>
    <jsp:include page="header.jsp"/>
    <div class="signup-wrapper">
        <div class="signup-box">
            <h1>Sign Up</h1>
            <form action="/signup"  method="post" enctype="multipart/form-data">
                <div class="input-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" required>
                </div>
                <div class="input-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email"  required>
                </div>
                <div class="input-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password"  placeholder="8자이상" required>
                </div>
                <div class="input-group">
                    <label for="confirm-password">Confirm Password</label>
                    <input type="password" id="confirm-password" name="confirm-password" required>
                </div>
                <div class="input-group">
                    <label for="file">Profile Picture</label>
                    <input type="file" id="file" name="file" >
                    <img id="image-preview" src="#" alt="Image preview" style="border-radius: 50% ; width: 100px; height: 100px; margin-top: 10px; display: none;"/>
                </div>
                <div class="input-group">
                    <label for="phone">Phone</label>
                    <input type="tel" id="phone" name="phone" oninput="this.value = this.value.replace(/[^0-9]/g, '')" required placeholder="숫자만 입력하세요.">
                </div>
                <button type="submit" class="signup-btn">Create Account</button>
            </form>
            <div class="login-link">
                <p>Already have an account? <a href="login.jsp">Log In</a></p>
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
        return true;
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