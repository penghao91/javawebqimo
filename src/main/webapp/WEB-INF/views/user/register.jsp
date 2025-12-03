<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户注册 - 问卷系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f5f5f5;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .register-container {
            width: 100%;
            max-width: 450px;
            padding: 15px;
            margin: auto;
        }
        .form-signup {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .form-signup h1 {
            margin-bottom: 20px;
            text-align: center;
        }
        .alert {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <form:form class="form-signup" modelAttribute="user" action="${pageContext.request.contextPath}/user/register" method="post">
            <h1 class="h3 mb-3 fw-normal">用户注册</h1>
            
            <c:if test="${error != null}">
                <div class="alert alert-danger" role="alert">
                    ${error}
                </div>
            </c:if>

            <div class="form-floating mb-3">
                <form:input type="text" class="form-control" path="username" placeholder="用户名" required="true" autofocus="true"/>
                <label for="username">用户名</label>
                <form:errors path="username" cssClass="text-danger"/>
            </div>
            
            <div class="form-floating mb-3">
                <form:input type="email" class="form-control" path="email" placeholder="邮箱地址"/>
                <label for="email">邮箱地址（可选）</label>
                <form:errors path="email" cssClass="text-danger"/>
            </div>
            
            <div class="form-floating mb-3">
                <form:input type="password" class="form-control" path="password" placeholder="密码" required="true"/>
                <label for="password">密码</label>
                <form:errors path="password" cssClass="text-danger"/>
            </div>
            
            <div class="form-floating mb-3">
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="确认密码" required>
                <label for="confirmPassword">确认密码</label>
            </div>
            
            <button class="w-100 btn btn-lg btn-primary" type="submit">注册</button>
            
            <div class="text-center mt-3">
                <p>已有账号？<a href="<c:url value='/user/login'/>">立即登录</a></p>
            </div>
            
            <p class="mt-3 mb-0 text-muted text-center">&copy; 2025 问卷系统</p>
        </form:form>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.querySelector('form').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password !== confirmPassword) {
                e.preventDefault();
                alert('两次输入的密码不一致！');
                return false;
            }
            
            if (password.length < 6) {
                e.preventDefault();
                alert('密码长度至少为6位！');
                return false;
            }
        });
    </script>
</body>
</html>