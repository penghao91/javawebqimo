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
            padding: 2rem 0;
            background: linear-gradient(135deg, rgba(var(--bs-primary-rgb), 0.1), rgba(var(--bs-primary-rgb), 0));
        }
        .register-card {
            width: 100%;
            max-width: 500px;
            border: none;
            border-radius: 1rem;
            box-shadow: 0 0.5rem 1.5rem rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        .register-card .card-header {
            background-color: #fff;
            border-bottom: none;
            padding: 2rem 1.5rem 1.5rem;
            text-align: center;
        }
        .register-card .icon {
            font-size: 3rem;
            color: rgba(var(--bs-primary-rgb), 1);
        }
        .register-card .card-title {
            font-weight: 300;
            color: #6e707e;
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
        .form-control.is-invalid {
             background-image: none; /* Hide default BS icon to prevent overlap */
        }
    </style>
</head>
<body>
    <div class="main-container">
        <div class="register-card">
            <div class="card-header">
                <i class="bi bi-person-plus-fill icon"></i>
                <h1 class="card-title h4 mt-2">创建新账户</h1>
            </div>
            <div class="card-body p-4 p-md-5">

                <form:form id="registerForm" modelAttribute="user" action="${pageContext.request.contextPath}/user/register" method="post" class="needs-validation" novalidate="true">
                    
                    <c:if test="${error != null}">
                        <div class="alert alert-danger d-flex align-items-center" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>
                            <div>${error}</div>
                        </div>
                    </c:if>

                    <div class="form-floating mb-3">
                        <form:input type="text" path="username" class="form-control" id="username" placeholder="用户名" required="true" autofocus="true"/>
                        <label for="username">用户名</label>
                        <div class="invalid-feedback">请输入一个用户名。</div>
                        <form:errors path="username" cssClass="text-danger small mt-1"/>
                    </div>
                    
                    <div class="form-floating mb-3">
                        <form:input type="email" path="email" class="form-control" id="email" placeholder="邮箱地址"/>
                        <label for="email">邮箱地址（可选）</label>
                         <form:errors path="email" cssClass="text-danger small mt-1"/>
                    </div>
                    
                    <div class="form-floating mb-3">
                        <form:input type="password" path="password" class="form-control" id="password" placeholder="密码" required="true"/>
                        <label for="password">密码</label>
                        <div class="invalid-feedback">请输入密码（至少6位）。</div>
                        <form:errors path="password" cssClass="text-danger small mt-1"/>
                    </div>
                    
                    <div class="form-floating mb-4">
                        <input type="password" class="form-control" id="confirmPassword" placeholder="确认密码" required>
                        <label for="confirmPassword">确认密码</label>
                        <div class="invalid-feedback">两次输入的密码不一致。</div>
                    </div>
                    
                    <div class="d-grid">
                        <button class="btn btn-primary btn-lg" type="submit">注 册</button>
                    </div>

                </form:form>
                
                <hr class="my-4">

                <div class="text-center">
                    <a href="<c:url value='/user/login'/>" class="text-decoration-none">已有账号？立即登录</a>
                </div>
            </div>
             <div class="card-footer text-center py-3 bg-light">
                 <p class="mb-0 text-muted footer-text">&copy; 2025 问卷系统</p>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        (function () {
            'use strict';

            const form = document.getElementById('registerForm');
            const password = document.getElementById('password');
            const confirmPassword = document.getElementById('confirmPassword');

            form.addEventListener('submit', function (event) {
                // Reset custom validity
                password.classList.remove('is-invalid');
                confirmPassword.classList.remove('is-invalid');
                
                let customValidationFailed = false;

                if (password.value.length < 6) {
                    password.classList.add('is-invalid');
                    customValidationFailed = true;
                }
                
                if (password.value !== confirmPassword.value) {
                    confirmPassword.classList.add('is-invalid');
                    customValidationFailed = true;
                }

                if (!form.checkValidity() || customValidationFailed) {
                    event.preventDefault();
                    event.stopPropagation();
                }

                form.classList.add('was-validated');
            }, false);
        })();
    </script>
</body>
</html>
