<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sign Up</title>
    <link rel="stylesheet" href="css/signup.css"/>
</head>
<body>
    <jsp:include page="header.jsp"/>
    <div class="signup-wrapper">
        <div class="signup-box">
            <h1>Sign Up</h1>
            <form action="signup_process.jsp" method="post">
                <div class="input-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" required>
                </div>
                <div class="input-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" required>
                </div>
                <div class="input-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <div class="input-group">
                    <label for="confirm-password">Confirm Password</label>
                    <input type="password" id="confirm-password" name="confirm-password" required>
                </div>
                <button type="submit" class="signup-btn">Create Account</button>
            </form>
            <div class="login-link">
                <p>Already have an account? <a href="login.jsp">Log In</a></p>
            </div>
        </div>
    </div>
</body>
</html>