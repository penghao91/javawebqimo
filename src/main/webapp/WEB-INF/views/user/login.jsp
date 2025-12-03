<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户登录 - 问卷系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --bs-primary-rgb: 78, 115, 223;
            --bs-body-bg: #f8f9fc;
        }
        body {
            background-color: var(--bs-body-bg);
        }
        .main-container {
            display: flex;
            min-height: 100vh;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, rgba(var(--bs-primary-rgb), 0.1), rgba(var(--bs-primary-rgb), 0));
        }
        .login-card {
            width: 100%;
            max-width: 450px;
            border: none;
            border-radius: 1rem;
            box-shadow: 0 0.5rem 1.5rem rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        .login-card .card-header {
            background-color: #fff;
            border-bottom: none;
            padding: 2rem 1.5rem 1.5rem;
            text-align: center;
        }
        .login-card .icon {
            font-size: 3rem;
            color: rgba(var(--bs-primary-rgb), 1);
        }
        .login-card .card-title {
            font-weight: 300;
            color: #6e707e;
        }
        .alert-icon {
            display: flex;
            align-items: center;
        }
        .alert-icon .bi {
            margin-right: 0.75rem;
            font-size: 1.2rem;
        }
        .btn-primary {
            background-color: rgba(var(--bs-primary-rgb), 1);
            border-color: rgba(var(--bs-primary-rgb), 1);
            transition: background-color 0.2s;
        }
        .btn-primary:hover {
            background-color: rgba(var(--bs-primary-rgb), 0.9);
        }
        .footer-text {
            font-size: 0.8rem;
        }
    </style>
</head>
<body>
    <div class="main-container">
        <div class="login-card">
            <div class="card-header">
                <i class="bi bi-box-arrow-in-right icon"></i>
                <h1 class="card-title h4 mt-2">欢迎回来！</h1>
            </div>
            <div class="card-body p-4 p-md-5">

                <c:if test="${param.error != null}">
                    <div class="alert alert-danger alert-icon d-flex" role="alert">
                        <i class="bi bi-exclamation-triangle-fill"></i>
                        <div>用户名或密码错误！</div>
                    </div>
                </c:if>
                
                <c:if test="${param.logout != null}">
                    <div class="alert alert-success alert-icon d-flex" role="alert">
                        <i class="bi bi-check-circle-fill"></i>
                        <div>已成功退出登录！</div>
                    </div>
                </c:if>
                
                <c:if test="${message != null}">
                    <div class="alert alert-success alert-icon d-flex" role="alert">
                         <i class="bi bi-check-circle-fill"></i>
                        <div>${message}</div>
                    </div>
                </c:if>

                <form action="<c:url value='/user/login'/>" method="post">
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" id="username" name="username" placeholder="用户名" required autofocus>
                        <label for="username">用户名</label>
                    </div>
                    
                    <div class="form-floating mb-4">
                        <input type="password" class="form-control" id="password" name="password" placeholder="密码" required>
                        <label for="password">密码</label>
                    </div>
                    
                    <div class="form-check mb-4">
                        <input type="checkbox" class="form-check-input" id="remember-me" name="remember-me">
                        <label class="form-check-label" for="remember-me">记住我</label>
                    </div>
                    
                    <div class="d-grid">
                        <button class="btn btn-primary btn-lg" type="submit">登 录</button>
                    </div>
                </form>
                
                <hr class="my-4">

                <div class="text-center">
                    <a href="<c:url value='/user/register'/>" class="text-decoration-none">还没有账号？立即注册</a>
                </div>
                
                <div class="text-center mt-3">
                    <a href="<c:url value='/'/>" class="text-decoration-none text-muted">
                        <i class="bi bi-house-door me-1"></i>返回首页
                    </a>
                </div>
            </div>
            <div class="card-footer text-center py-3 bg-light">
                 <p class="mb-0 text-muted footer-text">&copy; 2025 问卷系统</p>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // 清除登录标记，确保从登录页面访问不会显示退出提示
        document.addEventListener('DOMContentLoaded', function() {
            localStorage.removeItem('hasLoggedIn');
        });
    </script>
</body>
</html>
