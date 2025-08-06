<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Log In</title>
    <link rel="stylesheet" href="css/login.css"/>
</head>
<body>
    <jsp:include page="header.jsp"/>
    <div class="login-wrapper">
        <div class="login-box">
            <h1>Log In</h1>
            <form action="/login" method="post">
                <div class="input-group">
                    <label for="email">Email</label>
                    <input type="text" id="email" name="email" required>
                </div>
                <div class="input-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <button type="submit" class="login-btn">Log In</button>
            </form>
            <div class="signup-link">
                <p>Don't have an account? <a href="signup.jsp">Sign Up</a></p>
            </div>
        </div>
    </div>
</body>
</html>