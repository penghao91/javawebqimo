<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle}</title>
    <link href="/resources/css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link href="/resources/css/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="/resources/css/font-awesome/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #4e73df;
            --secondary-color: #858796;
            --success-color: #1cc88a;
            --info-color: #36b9cc;
            --warning-color: #f6c23e;
            --danger-color: #e74a3b;
            --light-color: #f8f9fc;
            --dark-color: #5a5c69;
        }

        body {
            font-family: 'Nunito', -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Helvetica Neue', Arial, sans-serif;
            line-height: 1.6;
            color: var(--dark-color);
        }

        /* 导航栏样式 */
        .navbar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
            color: var(--primary-color) !important;
        }

        .navbar-nav .nav-link {
            font-weight: 600;
            color: var(--dark-color) !important;
            transition: color 0.3s ease;
        }

        .navbar-nav .nav-link:hover {
            color: var(--primary-color) !important;
        }

        /* 主要内容区域 */
        .hero-section {
            background: linear-gradient(135deg, var(--primary-color) 0%, #224abe 100%);
            color: white;
            padding: 100px 0;
            position: relative;
            overflow: hidden;
        }

        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 100" fill="rgba(255,255,255,0.1)"><polygon points="0,0 1000,100 1000,0"/></svg>');
            background-size: cover;
        }

        .hero-content {
            position: relative;
            z-index: 2;
        }

        .hero-title {
            font-size: 3.5rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            animation: fadeInUp 0.8s ease;
        }

        .hero-subtitle {
            font-size: 1.3rem;
            margin-bottom: 2rem;
            opacity: 0.9;
            animation: fadeInUp 0.8s ease 0.2s both;
        }

        .btn-hero {
            padding: 15px 40px;
            font-size: 1.1rem;
            font-weight: 600;
            border-radius: 50px;
            transition: all 0.3s ease;
            animation: fadeInUp 0.8s ease 0.4s both;
        }

        .btn-hero:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }

        /* 特色功能区域 */
        .features-section {
            padding: 80px 0;
            background: var(--light-color);
        }

        .section-title {
            font-size: 2.5rem;
            font-weight: 700;
            text-align: center;
            margin-bottom: 3rem;
            color: var(--dark-color);
            position: relative;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 4px;
            background: var(--primary-color);
            border-radius: 2px;
        }

        .feature-card {
            background: white;
            border-radius: 15px;
            padding: 40px 30px;
            text-align: center;
            box-shadow: 0 5px 25px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            height: 100%;
            border: none;
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
        }

        .feature-icon {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 2rem;
            color: white;
        }

        .feature-title {
            font-size: 1.3rem;
            font-weight: 600;
            margin-bottom: 15px;
            color: var(--dark-color);
        }

        .feature-description {
            color: var(--secondary-color);
            line-height: 1.6;
        }

        /* 统计数据区域 */
        .stats-section {
            padding: 60px 0;
            background: linear-gradient(135deg, var(--success-color) 0%, #17a673 100%);
            color: white;
        }

        .stat-item {
            text-align: center;
            padding: 20px;
        }

        .stat-number {
            font-size: 3rem;
            font-weight: 700;
            display: block;
            margin-bottom: 10px;
        }

        .stat-label {
            font-size: 1.1rem;
            opacity: 0.9;
        }

        /* 页脚 */
        .footer {
            background: var(--dark-color);
            color: white;
            padding: 40px 0 20px;
        }

        .footer h5 {
            color: var(--primary-color);
            margin-bottom: 20px;
        }

        .footer a {
            color: #ccc;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer a:hover {
            color: var(--primary-color);
        }

        /* 动画效果 */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            .hero-title {
                font-size: 2.5rem;
            }
            
            .hero-subtitle {
                font-size: 1.1rem;
            }
            
            .section-title {
                font-size: 2rem;
            }
            
            .feature-card {
                margin-bottom: 30px;
            }
        }

        /* 按钮样式 */
        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            padding: 10px 25px;
            font-weight: 600;
            border-radius: 25px;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #2e59d9;
            border-color: #2e59d9;
            transform: translateY(-2px);
        }

        .btn-outline-light {
            border-radius: 25px;
            padding: 10px 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-outline-light:hover {
            transform: translateY(-2px);
        }

        /* Toast通知样式 */
        .toast-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
        }

        .toast {
            background: white;
            border-radius: 12px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.12);
            border: none;
            overflow: hidden;
            min-width: 350px;
            max-width: 500px;
            animation: slideInRight 0.3s ease-out;
        }

        .toast-header {
            background: linear-gradient(135deg, var(--success-color), #17a673);
            color: white;
            border-bottom: none;
            padding: 1rem 1.25rem;
            font-weight: 600;
        }

        /* 回到顶部按钮样式 */
        .back-to-top {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-color), #224abe);
            color: white;
            border: none;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            cursor: pointer;
            display: none;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            transition: all 0.3s ease;
            z-index: 999;
        }

        .back-to-top:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.3);
        }

        .back-to-top.show {
            display: flex;
            animation: fadeIn 0.3s ease;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .toast-body {
            padding: 1.25rem;
            color: var(--dark-color);
            font-size: 0.95rem;
        }

        .toast-progress {
            position: absolute;
            bottom: 0;
            left: 0;
            height: 3px;
            background: linear-gradient(135deg, var(--success-color), #17a673);
            animation: toastProgress 3s linear;
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

        @keyframes toastProgress {
            from {
                width: 100%;
            }
            to {
                width: 0%;
            }
        }

        .toast-close {
            background: none;
            border: none;
            color: white;
            font-size: 1.2rem;
            cursor: pointer;
            padding: 0;
            margin-left: auto;
            opacity: 0.8;
            transition: opacity 0.2s;
        }

        .toast-close:hover {
            opacity: 1;
        }
    </style>
</head>
<body>
    <!-- 导航栏 -->
    <nav class="navbar navbar-expand-lg navbar-light fixed-top">
        <div class="container">
            <a class="navbar-brand" href="<c:url value='/'/>">
                <i class="fas fa-poll"></i> 问卷星
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="#features">功能特色</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#about">关于我们</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/user/login'/>">登录</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/user/register'/>">
                            <button class="btn btn-primary btn-sm">免费注册</button>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- 主要内容区域 -->
    <main>
        <!-- 英雄区域 -->
        <section class="hero-section">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-6">
                        <div class="hero-content">
                            <h1 class="hero-title">专业的在线问卷调查平台</h1>
                            <p class="hero-subtitle">简单易用的问卷设计工具，强大的数据统计分析，让调研更高效</p>
                            <div class="d-flex gap-3 flex-wrap">
                                <a href="<c:url value='/user/register'/>" class="btn btn-light btn-lg btn-hero">
                                    <i class="fas fa-rocket me-2"></i>立即开始
                                </a>
                                <a href="<c:url value='/user/login'/>" class="btn btn-outline-light btn-lg btn-hero">
                                    <i class="fas fa-sign-in-alt me-2"></i>登录系统
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="text-center">
                            <i class="fas fa-chart-pie" style="font-size: 15rem; opacity: 0.2;"></i>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- 功能特色 -->
        <section class="features-section" id="features">
            <div class="container">
                <h2 class="section-title">为什么选择我们？</h2>
                <div class="row g-4">
                    <div class="col-md-4">
                        <div class="feature-card">
                            <div class="feature-icon" style="background: linear-gradient(135deg, var(--primary-color), #224abe);">
                                <i class="fas fa-edit"></i>
                            </div>
                            <h4 class="feature-title">简单易用</h4>
                            <p class="feature-description">拖拽式问卷设计，丰富的题型选择，无需编程知识即可创建专业问卷</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="feature-card">
                            <div class="feature-icon" style="background: linear-gradient(135deg, var(--success-color), #17a673);">
                                <i class="fas fa-chart-bar"></i>
                            </div>
                            <h4 class="feature-title">数据可视化</h4>
                            <p class="feature-description">实时数据统计，多维度图表分析，让数据洞察一目了然</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="feature-card">
                            <div class="feature-icon" style="background: linear-gradient(135deg, var(--info-color), #2c9faf);">
                                <i class="fas fa-share-alt"></i>
                            </div>
                            <h4 class="feature-title">多渠道发布</h4>
                            <p class="feature-description">支持链接、二维码、邮件等多种发布方式，轻松触达目标受众</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="feature-card">
                            <div class="feature-icon" style="background: linear-gradient(135deg, var(--warning-color), #dda20a);">
                                <i class="fas fa-mobile-alt"></i>
                            </div>
                            <h4 class="feature-title">移动适配</h4>
                            <p class="feature-description">完美适配各种设备，手机、平板、电脑都能获得最佳体验</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="feature-card">
                            <div class="feature-icon" style="background: linear-gradient(135deg, var(--danger-color), #b91d0a);">
                                <i class="fas fa-shield-alt"></i>
                            </div>
                            <h4 class="feature-title">安全可靠</h4>
                            <p class="feature-description">数据加密存储，多重安全防护，确保您的信息安全</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="feature-card">
                            <div class="feature-icon" style="background: linear-gradient(135deg, var(--secondary-color), #6c6e7e);">
                                <i class="fas fa-headset"></i>
                            </div>
                            <h4 class="feature-title">专业支持</h4>
                            <p class="feature-description">专业的技术团队，7×24小时客服支持，随时为您解决问题</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- 统计数据 -->
        <section class="stats-section">
            <div class="container">
                <div class="row">
                    <div class="col-md-3">
                        <div class="stat-item">
                            <span class="stat-number">10,000+</span>
                            <span class="stat-label">活跃用户</span>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stat-item">
                            <span class="stat-number">50,000+</span>
                            <span class="stat-label">创建问卷</span>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stat-item">
                            <span class="stat-number">1,000,000+</span>
                            <span class="stat-label">收集答卷</span>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stat-item">
                            <span class="stat-number">99.9%</span>
                            <span class="stat-label">系统稳定性</span>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- 关于我们 -->
        <section class="features-section" id="about" style="background: var(--light-color);">
            <div class="container">
                <h2 class="section-title">关于我们</h2>
                <div class="row align-items-center">
                    <div class="col-lg-6">
                        <h3 class="mb-4">问卷星 - 专业的在线调研平台</h3>
                        <p class="lead text-muted mb-4">
                            问卷星致力于为用户提供简单、高效、专业的在线问卷调查服务。无论您是企业、学校还是个人，都能轻松创建专业的问卷，收集宝贵的数据。
                        </p>
                        <div class="row g-3">
                            <div class="col-6">
                                <div class="d-flex align-items-center">
                                    <i class="fas fa-check-circle text-success me-2"></i>
                                    <span>10年行业经验</span>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="d-flex align-items-center">
                                    <i class="fas fa-check-circle text-success me-2"></i>
                                    <span>百万用户信赖</span>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="d-flex align-items-center">
                                    <i class="fas fa-check-circle text-success me-2"></i>
                                    <span>数据安全保障</span>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="d-flex align-items-center">
                                    <i class="fas fa-check-circle text-success me-2"></i>
                                    <span>7×24小时支持</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="text-center">
                            <i class="fas fa-users" style="font-size: 15rem; color: var(--primary-color); opacity: 0.1;"></i>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <!-- 页脚 -->
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <h5><i class="fas fa-poll"></i> 问卷星</h5>
                    <p>专业的在线问卷调查平台，让调研变得更简单、更高效。</p>
                </div>
                <div class="col-md-2">
                    <h5>产品</h5>
                    <ul class="list-unstyled">
                        <li><a href="#">问卷设计</a></li>
                        <li><a href="#">数据分析</a></li>
                        <li><a href="#">模板库</a></li>
                    </ul>
                </div>
                <div class="col-md-2">
                    <h5>帮助</h5>
                    <ul class="list-unstyled">
                        <li><a href="#">使用指南</a></li>
                        <li><a href="#">常见问题</a></li>
                        <li><a href="#">联系客服</a></li>
                    </ul>
                </div>
                <div class="col-md-2">
                    <h5>关于</h5>
                    <ul class="list-unstyled">
                        <li><a href="#">公司介绍</a></li>
                        <li><a href="#">联系我们</a></li>
                        <li><a href="#">加入我们</a></li>
                    </ul>
                </div>
                <div class="col-md-2">
                    <h5>关注我们</h5>
                    <div class="d-flex gap-2">
                        <a href="#" class="btn btn-outline-light btn-sm"><i class="fab fa-weixin"></i></a>
                        <a href="#" class="btn btn-outline-light btn-sm"><i class="fab fa-weibo"></i></a>
                        <a href="#" class="btn btn-outline-light btn-sm"><i class="fab fa-qq"></i></a>
                    </div>
                </div>
            </div>
            <hr class="my-4" style="border-color: #6c6e7e;">
            <div class="text-center">
                <p class="mb-0">&copy; 2025 问卷星. 保留所有权利.</p>
            </div>
        </div>
    </footer>

    <!-- Toast通知容器 -->
    <div class="toast-container" id="toastContainer" style="display: none;">
        <div class="toast" id="logoutToast" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header">
                <i class="bi bi-check-circle-fill me-2"></i>
                <strong class="me-auto">退出成功</strong>
                <button type="button" class="toast-close" data-bs-dismiss="toast" aria-label="关闭">
                    <i class="bi bi-x-lg"></i>
                </button>
            </div>
            <div class="toast-body">
                您已成功退出登录，欢迎下次使用！
            </div>
            <div class="toast-progress"></div>
        </div>
    </div>

    <script src="/resources/js/bootstrap/bootstrap.bundle.min.js"></script>
    <script>
        // 平滑滚动
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });

        // 导航栏滚动效果
        window.addEventListener('scroll', function() {
            const navbar = document.querySelector('.navbar');
            if (window.scrollY > 50) {
                navbar.style.background = 'rgba(255, 255, 255, 0.98)';
                navbar.style.boxShadow = '0 2px 20px rgba(0, 0, 0, 0.15)';
            } else {
                navbar.style.background = 'rgba(255, 255, 255, 0.95)';
                navbar.style.boxShadow = '0 2px 20px rgba(0, 0, 0, 0.1)';
            }
        });

        // 数字动画效果
        function animateNumbers() {
            const numbers = document.querySelectorAll('.stat-number');
            numbers.forEach(number => {
                const finalValue = number.textContent;
                const numericValue = parseInt(finalValue.replace(/[^\d]/g, ''));
                if (numericValue) {
                    let currentValue = 0;
                    const increment = numericValue / 50;
                    const timer = setInterval(() => {
                        currentValue += increment;
                        if (currentValue >= numericValue) {
                            number.textContent = finalValue;
                            clearInterval(timer);
                        } else {
                            number.textContent = Math.floor(currentValue).toLocaleString() + (finalValue.includes('+') ? '+' : '');
                        }
                    }, 30);
                }
            });
        }

        // 当统计区域进入视口时触发动画
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    animateNumbers();
                    observer.unobserve(entry.target);
                }
            });
        });

        const statsSection = document.querySelector('.stats-section');
        if (statsSection) {
            observer.observe(statsSection);
        }

        // Toast通知功能
        function showLogoutToast() {
            const toastContainer = document.getElementById('toastContainer');
            const toast = document.getElementById('logoutToast');
            
            // 显示容器
            toastContainer.style.display = 'block';
            
            // 显示Toast
            toast.classList.add('show');
            
            // 3秒后自动隐藏
            setTimeout(() => {
                hideToast();
            }, 3000);
            
            // 进度条动画
            const progressBar = toast.querySelector('.toast-progress');
            progressBar.style.animation = 'toastProgress 3s linear';
        }
        
        function hideToast() {
            const toast = document.getElementById('logoutToast');
            const toastContainer = document.getElementById('toastContainer');
            
            toast.classList.remove('show');
            
            // 动画结束后隐藏容器
            setTimeout(() => {
                toastContainer.style.display = 'none';
            }, 300);
        }
        
        // 检查URL参数，如果是从退出登录过来的，显示Toast
        window.addEventListener('load', function() {
            const urlParams = new URLSearchParams(window.location.search);
            // 只有用户之前登录过（localStorage中有标记）才显示退出提示
            const hasLoggedIn = localStorage.getItem('hasLoggedIn');
            if (urlParams.get('logout') === 'success' && hasLoggedIn === 'true') {
                // 清除登录标记
                localStorage.removeItem('hasLoggedIn');
                // 稍微延迟显示，让页面先加载完成
                setTimeout(() => {
                    showLogoutToast();
                }, 500);
            }
        });
        
        // 关闭按钮事件
        document.querySelector('.toast-close').addEventListener('click', function() {
            hideToast();
        });
        
        // 点击Toast外部也可以关闭
        document.getElementById('logoutToast').addEventListener('click', function(e) {
            if (e.target === this) {
                hideToast();
            }
        });

        // 回到顶部功能
        // 创建回到顶部按钮
        const backToTopBtn = document.createElement('button');
        backToTopBtn.className = 'back-to-top';
        backToTopBtn.innerHTML = '<i class="fas fa-arrow-up"></i>';
        backToTopBtn.title = '回到顶部';
        document.body.appendChild(backToTopBtn);

        // 监听滚动事件，显示/隐藏按钮
        window.addEventListener('scroll', function() {
            if (window.pageYOffset > 300) {
                backToTopBtn.classList.add('show');
            } else {
                backToTopBtn.classList.remove('show');
            }
        });

        // 点击按钮回到顶部
        backToTopBtn.addEventListener('click', function() {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });
    </script>
</body>
</html>