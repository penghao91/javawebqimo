<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户登录 - 问卷系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f5f5f5;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-container {
            width: 100%;
            max-width: 400px;
            padding: 15px;
            margin: auto;
        }
        .form-signin {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .form-signin h1 {
            margin-bottom: 20px;
            text-align: center;
        }
        .alert {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <form class="form-signin" action="<c:url value='/user/login'/>" method="post">
            <h1 class="h3 mb-3 fw-normal">用户登录</h1>
            
            <c:if test="${param.error != null}">
                <div class="alert alert-danger" role="alert">
                    用户名或密码错误！
                </div>
            </c:if>
            
            <c:if test="${param.logout != null}">
                <div class="alert alert-success" role="alert">
                    已成功退出登录！
                </div>
            </c:if>
            
            <c:if test="${message != null}">
                <div class="alert alert-success" role="alert">
                    ${message}
                </div>
            </c:if>

            <div class="form-floating mb-3">
                <input type="text" class="form-control" id="username" name="username" placeholder="用户名" required autofocus>
                <label for="username">用户名</label>
            </div>
            
            <div class="form-floating mb-3">
                <input type="password" class="form-control" id="password" name="password" placeholder="密码" required>
                <label for="password">密码</label>
            </div>
            
            <div class="form-check mb-3">
                <input type="checkbox" class="form-check-input" id="remember-me" name="remember-me">
                <label class="form-check-label" for="remember-me">
                    记住我
                </label>
            </div>
            
            <button class="w-100 btn btn-lg btn-primary" type="submit">登录</button>
            
            <div class="text-center mt-3">
                <p>还没有账号？<a href="<c:url value='/user/register'/>">立即注册</a></p>
            </div>
            
            <p class="mt-3 mb-0 text-muted text-center">&copy; 2025 问卷系统</p>
        </form>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>