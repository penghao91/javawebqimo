<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户登录 - 问卷系统</title>
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

        /* 外层容器 */
        .main-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px 16px;
        }

        /* 登录卡片 */
        .login-card {
            width: 100%;
            max-width: 460px;
            border-radius: 20px;
            border: 1px solid rgba(226, 232, 240, 0.9);
            background: rgba(255, 255, 255, 0.96);
            box-shadow: 0 20px 60px rgba(15, 23, 42, 0.16);
            overflow: hidden;
            animation: cardIn 0.4s ease-out;
        }

        .card-header {
            padding: 1.8rem 1.8rem 1.2rem;
            border-bottom: 1px solid rgba(226, 232, 240, 0.7);
            background: radial-gradient(circle at top left, rgba(var(--bs-primary-rgb), 0.12), transparent 60%);
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

        /* 浮动输入框优化 */
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

        /* 密码输入框右侧“显示密码”图标 */
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

        .form-check-label {
            font-size: 0.87rem;
            color: #6b7280;
        }

        .form-check small {
            color: #9ca3af;
        }

        /* 按钮样式 */
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

        .btn-processing {
            position: relative;
            pointer-events: none;
            opacity: 0.85;
        }

        .btn-processing::after {
            content: "";
            position: absolute;
            right: 1.1rem;
            top: 50%;
            width: 16px;
            height: 16px;
            border-radius: 999px;
            border: 2px solid rgba(255, 255, 255, 0.8);
            border-top-color: rgba(255, 255, 255, 0.1);
            transform: translateY(-50%);
            animation: spin 0.8s linear infinite;
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

        /* 顶部提示条（统一 toast 风格） */
        #globalErrorAlert,
        #loginToast {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1050;
            min-width: 340px;
            max-width: 420px;
            box-shadow: 0 18px 45px rgba(15, 23, 42, 0.18);
            border-radius: 14px;
            border: 1px solid rgba(226, 232, 240, 0.95);
            animation: slideInRight 0.25s ease-out;
        }

        #globalErrorAlert {
            border-left: 4px solid #f97316;
        }

        #loginToast {
            border-left: 4px solid rgba(var(--bs-primary-rgb), 1);
        }

        #globalErrorAlert .bi,
        #loginToast .bi {
            font-size: 1.2rem;
        }

        /* 动画 */
        @keyframes slideInRight {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

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

        @keyframes spin {
            to {
                transform: translateY(-50%) rotate(360deg);
            }
        }

        @media (max-width: 576px) {
            .login-card {
                max-width: 100%;
            }
            #globalErrorAlert,
            #loginToast {
                right: 10px;
                left: 10px;
                min-width: auto;
            }
        }
    </style>
</head>
<body>
<div class="main-container">
    <div class="login-card">
        <div class="card-header text-center">
            <div class="brand-icon mx-auto">
                <i class="bi bi-box-arrow-in-right"></i>
            </div>
            <h1 class="card-title-main">欢迎回来</h1>
            <p class="card-subtitle">登录以管理你的问卷、查看数据统计</p>
        </div>

        <div class="card-body">

            <c:if test="${param.logout != null}">
                <div class="alert alert-success alert-icon d-flex align-items-center mb-3" role="alert" style="border-radius: 10px;">
                    <i class="bi bi-check-circle-fill me-2"></i>
                    <div>已成功退出登录！</div>
                </div>
            </c:if>

            <c:if test="${message != null}">
                <div class="alert alert-success alert-icon d-flex align-items-center mb-3" role="alert" style="border-radius: 10px;">
                    <i class="bi bi-check-circle-fill me-2"></i>
                    <div>${message}</div>
                </div>
            </c:if>

            <form id="loginForm">
                <div class="form-floating mb-3">
                    <input type="text"
                           class="form-control"
                           id="username"
                           name="username"
                           placeholder="用户名"
                           required
                           autofocus>
                    <label for="username">用户名</label>
                </div>

                <div class="form-floating mb-4 password-wrapper">
                    <input type="password"
                           class="form-control"
                           id="password"
                           name="password"
                           placeholder="密码"
                           required>
                    <label for="password">密码</label>
                    <span class="password-toggle" id="passwordToggle" title="显示/隐藏密码">
                            <i class="bi bi-eye-slash" id="passwordToggleIcon"></i>
                        </span>
                </div>

                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div class="form-check">
                        <input type="checkbox"
                               class="form-check-input"
                               id="remember-me"
                               name="remember-me">
                        <label class="form-check-label" for="remember-me">记住我</label><br>
                        <small>公共电脑上请勿勾选</small>
                    </div>
                    <!-- 可预留“忘记密码？”链接位置 -->
                    <!-- <a href="#" class="small text-decoration-none">忘记密码？</a> -->
                </div>

                <div class="d-grid">
                    <button class="btn btn-primary btn-lg" type="submit">
                        登 录
                    </button>
                </div>
            </form>

            <hr class="my-4">

            <div class="text-center link-sm mb-2">
                还没有账号？
                <a href="<c:url value='/user/register'/>">立即注册</a>
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

<!-- 全局错误提示框 -->
<div id="globalErrorAlert"
     class="alert alert-info alert-dismissible fade d-flex align-items-center"
     role="alert"
     style="display: none;">
    <i class="bi bi-info-circle-fill flex-shrink-0 me-2"></i>
    <div id="globalErrorAlertMessage" class="flex-grow-1"></div>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>

<!-- 登录处理中提示 -->
<div id="loginToast"
     class="alert alert-info alert-dismissible fade d-flex align-items-center"
     role="alert"
     style="display: none;">
    <i class="bi bi-info-circle-fill flex-shrink-0 me-2"></i>
    <div class="flex-grow-1">
        <strong>正在登录...</strong>
        <p class="mb-0 small">正在验证您的账号信息，请稍候。</p>
    </div>
</div>

<script src="/resources/js/bootstrap/bootstrap.bundle.min.js"></script>
<script>
    // 强制不使用缓存（调试用）
    console.log('Login page loaded at:', new Date().toLocaleString());

    document.addEventListener('DOMContentLoaded', function() {
        // 清除登录标记，避免首页退出 Toast 误触发
        localStorage.removeItem('hasLoggedIn');

        // --- 全局错误提示框 ---
        const globalErrorAlerter = {
            element: document.getElementById('globalErrorAlert'),
            messageElement: document.getElementById('globalErrorAlertMessage'),
            closeButton: document.querySelector('#globalErrorAlert .btn-close'),
            timeout: null,

            init: function() {
                if (this.closeButton) {
                    this.closeButton.addEventListener('click', () => this.hide());
                }
            },

            show: function(message) {
                clearTimeout(this.timeout);
                this.messageElement.textContent = message;
                this.element.style.display = 'flex';

                // 利用 Bootstrap 的 fade + show 过渡
                setTimeout(() => {
                    this.element.classList.add('show');
                }, 20);

                this.timeout = setTimeout(() => this.hide(), 4000);
            },

            hide: function() {
                this.element.classList.remove('show');
                const onTransitionEnd = () => {
                    this.element.style.display = 'none';
                    this.element.removeEventListener('transitionend', onTransitionEnd);
                };
                this.element.addEventListener('transitionend', onTransitionEnd);
            }
        };
        globalErrorAlerter.init();

        // --- 登录过程中的提示 (Toast) ---
        const loginToast = {
            element: document.getElementById('loginToast'),
            show: function() {
                this.element.style.display = 'flex';
                setTimeout(() => {
                    this.element.classList.add('show');
                }, 20);
            },
            hide: function() {
                this.element.classList.remove('show');
                const onTransitionEnd = () => {
                    this.element.style.display = 'none';
                    this.element.removeEventListener('transitionend', onTransitionEnd);
                };
                this.element.addEventListener('transitionend', onTransitionEnd);
            }
        };

        // --- 显示/隐藏密码 ---
        const passwordInput = document.getElementById('password');
        const passwordToggle = document.getElementById('passwordToggle');
        const passwordToggleIcon = document.getElementById('passwordToggleIcon');

        if (passwordToggle && passwordInput && passwordToggleIcon) {
            passwordToggle.addEventListener('click', function() {
                const currentType = passwordInput.getAttribute('type');
                if (currentType === 'password') {
                    passwordInput.setAttribute('type', 'text');
                    passwordToggleIcon.classList.remove('bi-eye-slash');
                    passwordToggleIcon.classList.add('bi-eye');
                } else {
                    passwordInput.setAttribute('type', 'password');
                    passwordToggleIcon.classList.remove('bi-eye');
                    passwordToggleIcon.classList.add('bi-eye-slash');
                }
            });
        }

        // --- 登录表单 AJAX 提交 ---
        const loginForm = document.getElementById('loginForm');
        const submitBtn = document.querySelector('button[type="submit"]');

        if (loginForm && submitBtn) {
            loginForm.addEventListener('submit', function(e) {
                e.preventDefault();

                const username = document.getElementById('username').value.trim();
                const password = passwordInput.value.trim();

                if (!username || !password) {
                    globalErrorAlerter.show('请输入用户名和密码');
                    return;
                }

                loginToast.show();
                submitBtn.disabled = true;
                submitBtn.classList.add('btn-processing');

                const formData = new FormData();
                formData.append('username', username);
                formData.append('password', password);

                fetch('/user/login', {
                    method: 'POST',
                    body: formData
                })
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('HTTP error! status: ' + response.status);
                        }
                        return response.json();
                    })
                    .then(data => {
                        if (data.success) {
                            // 登录成功标记，用于首页友好提示
                            sessionStorage.setItem('justLoggedIn', 'true');
                            window.location.href = data.redirectUrl;
                        } else {
                            const message = data.message || '用户名或密码错误';
                            globalErrorAlerter.show(message);
                        }
                    })
                    .catch(error => {
                        console.error('Login error:', error);
                        globalErrorAlerter.show('网络或服务器错误，请稍后重试');
                    })
                    .finally(() => {
                        loginToast.hide();
                        submitBtn.disabled = false;
                        submitBtn.classList.remove('btn-processing');
                    });
            });
        }
    });
</script>
</body>
</html>
