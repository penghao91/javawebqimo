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
        .btn-processing {
            position: relative;
            pointer-events: none;
            opacity: 0.8;
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

                <form id="loginForm">
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

    <!-- 全局错误提示框 (与登录提示风格统一) -->
    <div id="globalErrorAlert" class="alert alert-info alert-dismissible fade d-flex align-items-center" role="alert" style="display: none; position: fixed; top: 20px; right: 20px; z-index: 1050; min-width: 350px; box-shadow: 0 0.5rem 1rem rgba(0,0,0,0.15);">
        <i class="bi bi-info-circle-fill flex-shrink-0 me-2"></i>
        <div id="globalErrorAlertMessage" class="flex-grow-1"></div>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    
    <!-- 登录处理中提示 (风格统一后) -->
    <div id="loginToast" class="alert alert-info alert-dismissible fade d-flex" role="alert" style="display: none; position: fixed; top: 20px; right: 20px; z-index: 1050; min-width: 350px; box-shadow: 0 0.5rem 1rem rgba(0,0,0,0.15);">
        <i class="bi bi-info-circle-fill flex-shrink-0 me-2"></i>
        <div class="flex-grow-1">
            <strong>正在登录...</strong>
            <p class="mb-0 small">正在验证您的账号信息，请稍候。</p>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // 强制不使用缓存（调试用）
        console.log('Login page loaded at:', new Date().toLocaleString());
        
        document.addEventListener('DOMContentLoaded', function() {
            // 清除登录标记
            localStorage.removeItem('hasLoggedIn');

            // --- 全局错误提示框 ---
            const globalErrorAlerter = {
                element: document.getElementById('globalErrorAlert'),
                messageElement: document.getElementById('globalErrorAlertMessage'),
                closeButton: document.querySelector('#globalErrorAlert .btn-close'),
                timeout: null,

                init: function() {
                    this.closeButton.addEventListener('click', () => this.hide());
                },

                show: function(message) {
                    clearTimeout(this.timeout);
                    this.messageElement.textContent = message;
                    this.element.style.display = 'flex';
                    
                    setTimeout(() => {
                        this.element.classList.add('show');
                    }, 20);
                    
                    this.timeout = setTimeout(() => this.hide(), 4000);
                },

                hide: function() {
                    this.element.classList.remove('show');
                    const onTransitionEnd = () => {
                        if (this.element.style.display !== 'none') {
                           this.element.style.display = 'none';
                           this.element.removeEventListener('transitionend', onTransitionEnd);
                        }
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
                        if (this.element.style.display !== 'none') {
                            this.element.style.display = 'none';
                            this.element.removeEventListener('transitionend', onTransitionEnd);
                        }
                    };
                    this.element.addEventListener('transitionend', onTransitionEnd);
                }
            };
            
            // --- 登录表单AJAX提交 ---
            const loginForm = document.getElementById('loginForm');
            const submitBtn = document.querySelector('button[type="submit"]');
            
            if (loginForm) {
                loginForm.addEventListener('submit', function(e) {
                    e.preventDefault();
                    
                    const username = document.getElementById('username').value.trim();
                    const password = document.getElementById('password').value.trim();
                    
                    if (!username || !password) {
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
                           throw new Error(`HTTP error! status: ${response.status}`);
                        }
                        return response.json();
                    })
                    .then(data => {
                        if (data.success) {
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
