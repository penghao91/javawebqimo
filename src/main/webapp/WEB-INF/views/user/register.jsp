<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户注册 - 问卷系统</title>
    <link href="/resources/css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link href="/resources/css/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --bs-primary-rgb: 78, 115, 223;
            --primary-color: #4e73df;
            --primary-dark: #224abe;
            --bg-soft: #f8f9fc;
            --text-main: #4b4d63;
            --text-muted: #9ca3af;
            --border-soft: #e1e5f2;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            background:
                    radial-gradient(circle at top left, rgba(var(--bs-primary-rgb), 0.16), transparent 55%),
                    radial-gradient(circle at bottom right, #e0e7ff 0, #f8f9fc 45%, #ffffff 100%);
            font-family: -apple-system, BlinkMacSystemFont, 'SF Pro Text', 'Segoe UI', 'Roboto', 'Helvetica Neue', Arial, sans-serif;
            color: var(--text-main);
        }

        .main-container {
            display: flex;
            min-height: 100vh;
            align-items: center;
            justify-content: center;
            padding: 24px 16px;
        }

        .register-card {
            width: 100%;
            max-width: 520px;
            border-radius: 20px;
            border: 1px solid rgba(226, 232, 240, 0.9);
            background: rgba(255, 255, 255, 0.96);
            box-shadow: 0 20px 60px rgba(15, 23, 42, 0.16);
            overflow: hidden;
            animation: cardIn 0.4s ease-out;
        }

        .card-header {
            background: radial-gradient(circle at top left, rgba(var(--bs-primary-rgb), 0.12), transparent 60%);
            border-bottom: 1px solid rgba(226, 232, 240, 0.7);
            padding: 1.8rem 1.8rem 1.3rem;
            text-align: center;
        }

        .brand-icon {
            width: 52px;
            height: 52px;
            border-radius: 16px;
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            display: flex;
            align-items: center;
            justify-content: center;
            color: #ffffff;
            font-size: 1.6rem;
            box-shadow: 0 12px 30px rgba(59, 130, 246, 0.35);
            margin-bottom: 1rem;
        }

        .card-title-main {
            font-size: 1.4rem;
            font-weight: 700;
            letter-spacing: 0.02em;
            margin: 0;
            color: #111827;
        }

        .card-subtitle {
            margin-top: .4rem;
            font-size: 0.9rem;
            color: var(--text-muted);
        }

        .card-body {
            padding: 1.6rem 1.8rem 1.8rem;
        }

        .card-footer {
            padding: 0.85rem 1.8rem 1rem;
            background: #f3f4f6;
            border-top: 1px solid rgba(226, 232, 240, 0.9);
        }

        .footer-text {
            font-size: 0.78rem;
            color: #9ca3af;
        }

        /* 浮动输入框 */
        .form-floating > .form-control {
            border-radius: 12px;
            border: 1px solid var(--border-soft);
            font-size: 0.95rem;
            padding: 0.8rem 0.9rem;
        }

        .form-floating > label {
            color: #9ca3af;
        }

        .form-floating > .form-control:focus {
            border-color: rgba(var(--bs-primary-rgb), 0.8);
            box-shadow: 0 0 0 0.12rem rgba(var(--bs-primary-rgb), 0.18);
        }

        .form-control.is-invalid {
            background-image: none;
            border-color: #f97316;
        }

        .invalid-feedback {
            font-size: 0.8rem;
        }

        .text-danger.small {
            font-size: 0.8rem;
        }

        /* 密码输入框右侧眼睛图标 */
        .password-wrapper {
            position: relative;
        }

        .password-toggle {
            position: absolute;
            right: 0.85rem;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #9ca3af;
            font-size: 1rem;
        }

        .password-toggle:hover {
            color: #6b7280;
        }

        .password-toggle i {
            pointer-events: none;
        }

        /* 按钮 */
        .btn-primary {
            background-image: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            border-color: transparent;
            transition: all 0.22s ease;
            border-radius: 999px;
            font-weight: 600;
            box-shadow: 0 14px 30px rgba(59, 130, 246, 0.35);
        }

        .btn-primary:hover {
            background-image: linear-gradient(135deg, #3653c8, #1e3a8a);
            transform: translateY(-1px);
            box-shadow: 0 18px 40px rgba(37, 99, 235, 0.55);
        }

        .btn-lg {
            padding-top: 0.75rem;
            padding-bottom: 0.75rem;
            font-size: 1rem;
        }

        /* 链接区域 */
        .link-sm {
            font-size: 0.9rem;
        }

        .link-sm a {
            text-decoration: none;
        }

        .link-sm a:hover {
            text-decoration: underline;
        }

        .home-link {
            font-size: 0.9rem;
            color: #9ca3af;
        }

        .home-link i {
            font-size: 0.95rem;
        }

        /* 顶部错误提示（保留原有逻辑，仅样式优化时可扩展） */
        .alert {
            border-radius: 10px;
        }

        /* 动画 */
        @keyframes cardIn {
            from {
                transform: translateY(20px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        @media (max-width: 576px) {
            .register-card {
                max-width: 100%;
            }
        }
    </style>
</head>
<body>
<div class="main-container">
    <div class="register-card">
        <div class="card-header">
            <div class="brand-icon mx-auto">
                <i class="bi bi-person-plus"></i>
            </div>
            <h1 class="card-title-main">创建新账户</h1>
            <p class="card-subtitle">注册一个账号，开始创建和管理你的问卷</p>
        </div>

        <div class="card-body">

            <form:form
                    id="registerForm"
                    modelAttribute="user"
                    action="${pageContext.request.contextPath}/user/register"
                    method="post"
                    class="needs-validation"
                    novalidate="true">

                <c:if test="${error != null}">
                    <div class="alert alert-danger d-flex align-items-center mb-3" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>
                        <div>${error}</div>
                    </div>
                </c:if>

                <!-- 用户名 -->
                <div class="form-floating mb-3">
                    <form:input
                            type="text"
                            path="username"
                            class="form-control"
                            id="username"
                            placeholder="用户名"
                            required="true"
                            autofocus="true"/>
                    <label for="username">用户名</label>
                    <div class="invalid-feedback">请输入一个用户名。</div>
                    <form:errors path="username" cssClass="text-danger small mt-1"/>
                </div>

                <!-- 邮箱 -->
                <div class="form-floating mb-3">
                    <form:input
                            type="email"
                            path="email"
                            class="form-control"
                            id="email"
                            placeholder="邮箱地址"/>
                    <label for="email">邮箱地址（可选）</label>
                    <form:errors path="email" cssClass="text-danger small mt-1"/>
                </div>

                <!-- 密码 -->
                <div class="form-floating mb-3 password-wrapper">
                    <form:input
                            type="password"
                            path="password"
                            class="form-control"
                            id="password"
                            placeholder="密码"
                            required="true"/>
                    <label for="password">密码</label>
                    <span class="password-toggle" id="passwordToggle" title="显示/隐藏密码">
                            <i class="bi bi-eye-slash" id="passwordToggleIcon"></i>
                        </span>
                    <div class="invalid-feedback">请输入密码（至少6位）。</div>
                    <form:errors path="password" cssClass="text-danger small mt-1"/>
                </div>

                <!-- 确认密码 -->
                <div class="form-floating mb-4 password-wrapper">
                    <input
                            type="password"
                            class="form-control"
                            id="confirmPassword"
                            placeholder="确认密码"
                            required>
                    <label for="confirmPassword">确认密码</label>
                    <span class="password-toggle" id="confirmPasswordToggle" title="显示/隐藏密码">
                            <i class="bi bi-eye-slash" id="confirmPasswordToggleIcon"></i>
                        </span>
                    <div class="invalid-feedback">两次输入的密码不一致。</div>
                </div>

                <div class="d-grid">
                    <button class="btn btn-primary btn-lg" type="submit">注 册</button>
                </div>

            </form:form>

            <hr class="my-4">

            <div class="text-center link-sm mb-2">
                已有账号？
                <a href="<c:url value='/user/login'/>">立即登录</a>
            </div>

            <div class="text-center home-link">
                <a href="<c:url value='/'/>" class="text-decoration-none text-muted">
                    <i class="bi bi-house-door me-1"></i>返回首页
                </a>
            </div>
        </div>

        <div class="card-footer text-center">
            <p class="mb-0 footer-text">&copy; 2025 问卷系统 · 在线问卷与数据服务平台</p>
        </div>
    </div>
</div>

<script src="/resources/js/bootstrap/bootstrap.bundle.min.js"></script>
<script>
    (function () {
        'use strict';

        const form = document.getElementById('registerForm');
        const password = document.getElementById('password');
        const confirmPassword = document.getElementById('confirmPassword');

        // 显示/隐藏密码
        const passwordToggle = document.getElementById('passwordToggle');
        const passwordToggleIcon = document.getElementById('passwordToggleIcon');
        const confirmPasswordToggle = document.getElementById('confirmPasswordToggle');
        const confirmPasswordToggleIcon = document.getElementById('confirmPasswordToggleIcon');

        if (passwordToggle && password && passwordToggleIcon) {
            passwordToggle.addEventListener('click', function () {
                const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
                password.setAttribute('type', type);
                passwordToggleIcon.classList.toggle('bi-eye');
                passwordToggleIcon.classList.toggle('bi-eye-slash');
            });
        }

        if (confirmPasswordToggle && confirmPassword && confirmPasswordToggleIcon) {
            confirmPasswordToggle.addEventListener('click', function () {
                const type = confirmPassword.getAttribute('type') === 'password' ? 'text' : 'password';
                confirmPassword.setAttribute('type', type);
                confirmPasswordToggleIcon.classList.toggle('bi-eye');
                confirmPasswordToggleIcon.classList.toggle('bi-eye-slash');
            });
        }

        // 表单校验
        if (form) {
            form.addEventListener('submit', function (event) {
                // 重置自定义校验样式
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

            // 输入时清除错误样式
            [password, confirmPassword].forEach(input => {
                if (input) {
                    input.addEventListener('input', function () {
                        input.classList.remove('is-invalid');
                    });
                }
            });
        }
    })();
</script>
</body>
</html>
