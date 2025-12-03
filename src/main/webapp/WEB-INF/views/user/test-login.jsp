<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Test Login</title>
</head>
<body>
    <h2>Test Login Form</h2>
    
    <c:if test="${param.error != null}">
        <div style="color: red;">用户名或密码错误！</div>
    </c:if>
    
    <form action="/user/login" method="post">
        <div>
            <label>用户名:</label>
            <input type="text" name="username" value="admin" required>
        </div>
        <div>
            <label>密码:</label>
            <input type="password" name="password" value="admin123" required>
        </div>
        <div>
            <button type="submit">登录</button>
        </div>
    </form>
</body>
</html>
