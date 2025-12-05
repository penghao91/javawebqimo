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
            --primary-dark: #224abe;
            --secondary-color: #858796;
            --success-color: #1cc88a;
            --info-color: #36b9cc;
            --warning-color: #f6c23e;
            --danger-color: #e74a3b;
            --light-color: #f8f9fc;
            --light-soft: #eef2ff;
            --dark-color: #4b4d63;
            --muted-color: #a0a3b1;
            --border-soft: #e1e5f2;
        }

        * {
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'SF Pro Text', 'Segoe UI', 'Roboto', 'Helvetica Neue', Arial, sans-serif;
            line-height: 1.6;
            color: var(--dark-color);
            background: radial-gradient(circle at top left, #f0f4ff 0, #f8f9fc 45%, #fdfdfd 100%);
        }

        /* 导航栏样式 */
        .navbar {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(16px);
            box-shadow: 0 8px 24px rgba(15, 23, 42, 0.08);
            transition: all 0.3s ease;
            padding-top: 0.8rem;
            padding-bottom: 0.8rem;
        }

        .navbar.scrolled {
            padding-top: 0.4rem;
            padding-bottom: 0.4rem;
            background: rgba(255, 255, 255, 0.98);
            box-shadow: 0 10px 30px rgba(15, 23, 42, 0.14);
        }

        .navbar-brand {
            font-weight: 800;
            font-size: 1.5rem;
            color: var(--primary-color) !important;
            letter-spacing: 0.04em;
            display: flex;
            align-items: center;
            gap: .4rem;
        }

        .navbar-brand i {
            font-size: 1.4rem;
            color: var(--primary-dark);
        }

        .navbar-nav .nav-link {
            font-weight: 600;
            color: var(--secondary-color) !important;
            transition: color 0.2s ease, transform 0.2s ease;
            position: relative;
            padding-left: 0.9rem !important;
            padding-right: 0.9rem !important;
        }

        .navbar-nav .nav-link::after {
            content: "";
            position: absolute;
            left: 50%;
            bottom: 0.2rem;
            width: 0;
            height: 2px;
            border-radius: 999px;
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            transform: translateX(-50%);
            transition: width 0.2s ease;
        }

        .navbar-nav .nav-link:hover {
            color: var(--primary-color) !important;
            transform: translateY(-1px);
        }

        .navbar-nav .nav-link:hover::after {
            width: 60%;
        }

        .navbar .btn-primary.btn-sm {
            padding: .4rem 1.1rem;
            border-radius: 999px;
        }

        /* 自定义汉堡按钮 */
        .custom-toggler {
            border: none;
            padding: 0.25rem 0.25rem;
            outline: none;
            box-shadow: none;
        }

        .custom-toggler:focus {
            box-shadow: none;
        }

        .custom-toggler .toggler-lines {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            width: 22px;
            height: 16px;
        }

        .custom-toggler .toggler-lines span {
            display: block;
            width: 100%;
            height: 2px;
            border-radius: 999px;
            background: #111827;
            transition: all 0.25s ease;
        }

        /* 三条线变 X 的动画 */
        .custom-toggler[aria-expanded="true"] .toggler-lines span:nth-child(1) {
            transform: translateY(7px) rotate(45deg);
        }

        .custom-toggler[aria-expanded="true"] .toggler-lines span:nth-child(2) {
            opacity: 0;
        }

        .custom-toggler[aria-expanded="true"] .toggler-lines span:nth-child(3) {
            transform: translateY(-7px) rotate(-45deg);
        }

        /* PC 端登录注册按钮 */
        .navbar-nav .btn-auth {
            border-radius: 999px;
            padding: 0.4rem 1.1rem;
            font-weight: 600;
            font-size: 0.9rem;
        }

        .btn-outline-primary {
            border-color: var(--primary-color);
            color: var(--primary-color);
        }

        .btn-outline-primary:hover {
            background-color: var(--primary-color);
            color: #fff;
        }

        /* 手机端菜单样式 + 登录/注册按钮 */
        @media (max-width: 991.98px) {
            .navbar {
                box-shadow: 0 5px 18px rgba(15, 23, 42, 0.12);
            }

            .navbar-collapse {
                background: #ffffff;
                padding: 0.8rem 0 1.3rem;
            }

            .navbar-collapse .navbar-nav .nav-link {
                padding-top: 0.7rem !important;
                padding-bottom: 0.7rem !important;
                text-align: left;
                font-size: 1rem;
            }

            .mobile-auth-actions {
                border-top: 1px solid #e5e7eb;
                margin-top: 0.6rem;
                padding-top: 1rem;
            }

            .mobile-auth-buttons {
                display: flex;
                gap: 0.8rem;
            }

            .mobile-auth-buttons a {
                flex: 1 1 0;
                border-radius: 999px;
                text-align: center;
                padding: 0.7rem 0;
                font-weight: 600;
                font-size: 0.95rem;
                text-decoration: none;
                transition: all 0.2s ease;
            }

            .mobile-auth-buttons .login-btn {
                border: 1.5px solid var(--primary-color);
                color: var(--primary-color);
                background: #ffffff;
            }

            .mobile-auth-buttons .login-btn:hover {
                background: var(--primary-color);
                color: #ffffff;
            }

            .mobile-auth-buttons .register-btn {
                background: var(--primary-color);
                color: #ffffff;
            }

            .mobile-auth-buttons .register-btn:hover {
                background: var(--primary-dark);
            }
        }

        @media (min-width: 992px) {
            .navbar-collapse {
                background: transparent !important;
            }
        }

        /* Hero 区域 */
        .hero-section {
            background: radial-gradient(circle at top left, #4f46e5 0, #1d4ed8 40%, #1e293b 100%);
            color: white;
            padding: 110px 0 90px;
            position: relative;
            overflow: hidden;
            isolation: isolate;
        }

        .hero-section::before,
        .hero-section::after {
            content: "";
            position: absolute;
            width: 420px;
            height: 420px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(255, 255, 255, 0.08), transparent 70%);
            filter: blur(3px);
            z-index: -1;
        }

        .hero-section::before {
            top: -120px;
            right: -90px;
        }

        .hero-section::after {
            bottom: -180px;
            left: -120px;
        }

        .hero-content {
            position: relative;
            z-index: 1;
        }

        .hero-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            padding: 0.25rem 0.85rem;
            border-radius: 999px;
            background: rgba(15, 23, 42, 0.5);
            border: 1px solid rgba(148, 163, 184, 0.35);
            font-size: 0.8rem;
            margin-bottom: 1rem;
        }

        .hero-badge i {
            color: #22c55e;
        }

        .hero-title {
            font-size: 3.1rem;
            font-weight: 800;
            margin-bottom: 1rem;
            letter-spacing: 0.02em;
            animation: fadeInUp 0.7s ease;
        }

        .hero-title span {
            background: linear-gradient(135deg, #fbbf24, #facc15);
            -webkit-background-clip: text;
            color: transparent;
        }

        .hero-subtitle {
            font-size: 1.15rem;
            margin-bottom: 1.8rem;
            opacity: 0.92;
            max-width: 30rem;
            animation: fadeInUp 0.7s ease 0.15s both;
        }

        .hero-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 0.8rem;
            margin-bottom: 1.6rem;
            animation: fadeInUp 0.7s ease 0.25s both;
        }

        .btn-hero {
            padding: 0.9rem 2.3rem;
            font-size: 1.02rem;
            font-weight: 600;
            border-radius: 999px;
            transition: all 0.25s ease;
            border-width: 0;
            white-space: nowrap;
        }

        .btn-hero.btn-light {
            color: #0f172a;
        }

        .btn-hero.btn-light:hover {
            transform: translateY(-2px);
            box-shadow: 0 18px 40px rgba(15, 23, 42, 0.28);
        }

        .btn-hero.btn-outline-light {
            border-width: 1px;
            border-style: solid;
            border-color: rgba(226, 232, 240, 0.8);
            background: rgba(15, 23, 42, 0.3);
            color: #e5e7eb;
        }

        .btn-hero.btn-outline-light:hover {
            background: rgba(15, 23, 42, 0.65);
            transform: translateY(-2px);
            box-shadow: 0 14px 30px rgba(15, 23, 42, 0.45);
        }

        .hero-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 1.4rem;
            font-size: 0.9rem;
            opacity: 0.9;
            animation: fadeInUp 0.7s ease 0.35s both;
        }

        .hero-meta-item {
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
        }

        .hero-meta-item i {
            color: #22c55e;
        }

        /* 手机端 Hero 按钮同宽堆叠 */
        @media (max-width: 576px) {
            .hero-title {
                font-size: 2.1rem;
            }

            .hero-actions .btn-hero {
                flex: 1 0 100%;
                text-align: center;
            }
        }

        /* 右侧 Hero 卡片 */
        .hero-card {
            position: relative;
            background: rgba(15, 23, 42, 0.8);
            border-radius: 26px;
            padding: 1.8rem 1.6rem;
            box-shadow: 0 22px 60px rgba(15, 23, 42, 0.65);
            border: 1px solid rgba(148, 163, 184, 0.35);
            color: #e5e7eb;
            overflow: hidden;
            max-width: 380px;
            margin-left: auto;
            margin-top: 1.2rem;
            animation: fadeInUp 0.7s ease 0.25s both;
        }

        .hero-card::before {
            content: "";
            position: absolute;
            inset: 0;
            background: radial-gradient(circle at top left, rgba(56, 189, 248, 0.18), transparent 55%);
            pointer-events: none;
        }

        .hero-card-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1.1rem;
        }

        .hero-card-title {
            font-weight: 600;
            font-size: 0.95rem;
        }

        .hero-card-tag {
            font-size: 0.75rem;
            padding: 0.2rem 0.6rem;
            border-radius: 999px;
            background: rgba(37, 99, 235, 0.28);
            color: #bfdbfe;
        }

        .hero-card-metric {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 0.8rem;
        }

        .hero-card-metric span:first-child {
            font-size: 0.9rem;
            color: #cbd5f5;
        }

        .hero-card-metric span:last-child {
            font-size: 1.4rem;
            font-weight: 700;
            color: #facc15;
        }

        .hero-card-progress {
            position: relative;
            margin-top: 0.8rem;
            height: 6px;
            border-radius: 999px;
            background: rgba(30, 64, 175, 0.8);
            overflow: hidden;
        }

        .hero-card-progress-bar {
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 78%;
            border-radius: inherit;
            background: linear-gradient(90deg, #22c55e, #facc15);
        }

        .hero-card-footer {
            margin-top: 1.3rem;
            display: flex;
            justify-content: space-between;
            font-size: 0.85rem;
            color: #a5b4fc;
        }

        .hero-card-footer span strong {
            color: #e5e7eb;
        }

        /* 特色功能区域 */
        .features-section {
            padding: 80px 0 70px;
            background: var(--light-color);
        }

        .section-title {
            font-size: 2.3rem;
            font-weight: 700;
            text-align: center;
            margin-bottom: 0.6rem;
            color: #111827;
            position: relative;
        }

        .section-subtitle {
            text-align: center;
            color: var(--muted-color);
            margin-bottom: 2.8rem;
            font-size: 0.98rem;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: -12px;
            left: 50%;
            transform: translateX(-50%);
            width: 70px;
            height: 3px;
            background: linear-gradient(90deg, var(--primary-color), var(--primary-dark));
            border-radius: 999px;
        }

        .feature-card {
            background: white;
            border-radius: 18px;
            padding: 30px 26px;
            text-align: left;
            box-shadow: 0 10px 35px rgba(15, 23, 42, 0.06);
            transition: all 0.25s ease;
            height: 100%;
            border: 1px solid rgba(226, 232, 240, 0.9);
            position: relative;
            overflow: hidden;
        }

        .feature-card::before {
            content: "";
            position: absolute;
            top: -20px;
            right: -20px;
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(79, 70, 229, 0.09), transparent 70%);
            opacity: 0;
            transition: opacity 0.2s ease;
        }

        .feature-card:hover {
            transform: translateY(-8px) translateZ(0);
            box-shadow: 0 18px 45px rgba(15, 23, 42, 0.12);
            border-color: rgba(59, 130, 246, 0.35);
        }

        .feature-card:hover::before {
            opacity: 1;
        }

        .feature-icon {
            width: 56px;
            height: 56px;
            border-radius: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.6rem;
            color: white;
            margin-bottom: 18px;
        }

        .feature-title {
            font-size: 1.15rem;
            font-weight: 700;
            margin-bottom: 8px;
            color: #111827;
        }

        .feature-tag {
            display: inline-flex;
            align-items: center;
            gap: .25rem;
            font-size: 0.75rem;
            padding: 0.12rem 0.55rem;
            border-radius: 999px;
            background: #eff6ff;
            color: #2563eb;
            margin-bottom: 6px;
        }

        .feature-description {
            color: var(--secondary-color);
            line-height: 1.65;
            font-size: 0.95rem;
        }

        /* 统计数据区域 - 悬浮卡片风格 */
        .stats-section-wrapper {
            background: transparent;
            margin-top: -35px;
            padding-bottom: 70px;
        }

        .stats-section {
            padding: 26px 22px;
            background: linear-gradient(135deg, #059669, #16a34a);
            border-radius: 22px;
            color: white;
            box-shadow: 0 18px 50px rgba(22, 163, 74, 0.45);
            position: relative;
            overflow: hidden;
        }

        .stats-section::before {
            content: "";
            position: absolute;
            inset: 0;
            background: radial-gradient(circle at top left, rgba(34, 197, 94, 0.4), transparent 60%);
            opacity: 0.5;
        }

        .stats-inner {
            position: relative;
            z-index: 1;
        }

        .stat-item {
            text-align: center;
            padding: 15px 10px;
        }

        .stat-number {
            font-size: 2.2rem;
            font-weight: 800;
            display: block;
            margin-bottom: 6px;
        }

        .stat-label {
            font-size: 0.95rem;
            opacity: 0.92;
        }

        /* 关于我们 */
        .about-section {
            background: var(--light-soft);
            padding: 80px 0 70px;
        }

        .about-badge {
            display: inline-flex;
            align-items: center;
            gap: .3rem;
            padding: 0.18rem 0.6rem;
            border-radius: 999px;
            background: rgba(59, 130, 246, 0.08);
            color: #1d4ed8;
            font-size: .78rem;
            margin-bottom: 1rem;
        }

        .about-list {
            margin-top: 0.5rem;
        }

        .about-list .item {
            display: flex;
            align-items: center;
            gap: 0.45rem;
            margin-bottom: 0.35rem;
            font-size: 0.95rem;
        }

        .about-list .item i {
            color: #22c55e;
        }

        /* 页脚 */
        .footer {
            background: #0f172a;
            color: #e5e7eb;
            padding: 40px 0 22px;
        }

        .footer h5 {
            color: #e5e7eb;
            margin-bottom: 18px;
            font-weight: 700;
            font-size: 1rem;
        }

        .footer h5 i {
            color: var(--primary-color);
            margin-right: .3rem;
        }

        .footer p {
            font-size: 0.9rem;
            color: #9ca3af;
        }

        .footer a {
            color: #9ca3af;
            text-decoration: none;
            font-size: 0.9rem;
            transition: color 0.2s ease, transform 0.2s ease;
        }

        .footer a:hover {
            color: #e5e7eb;
            transform: translateX(2px);
        }

        .footer hr {
            border-color: #1f2937;
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
            border-radius: 16px;
            box-shadow: 0 18px 40px rgba(15, 23, 42, 0.18);
            border: 1px solid rgba(226, 232, 240, 0.9);
            overflow: hidden;
            min-width: 340px;
            max-width: 480px;
            animation: slideInRight 0.3s ease-out;
            position: relative;
        }

        .toast-header {
            background: linear-gradient(135deg, var(--success-color), #17a673);
            color: white;
            border-bottom: none;
            padding: 0.9rem 1.1rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: .4rem;
        }

        .toast-body {
            padding: 1.05rem 1.1rem 1rem;
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

        .toast-close {
            background: none;
            border: none;
            color: white;
            font-size: 1.1rem;
            cursor: pointer;
            padding: 0;
            margin-left: auto;
            opacity: 0.85;
            transition: opacity 0.2s;
        }

        .toast-close:hover {
            opacity: 1;
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

        /* 回到顶部按钮样式 */
        .back-to-top {
            position: fixed;
            bottom: 26px;
            right: 26px;
            width: 48px;
            height: 48px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            color: white;
            border: none;
            box-shadow: 0 18px 40px rgba(37, 99, 235, 0.4);
            cursor: pointer;
            display: none;
            align-items: center;
            justify-content: center;
            font-size: 1.1rem;
            transition: all 0.25s ease;
            z-index: 999;
        }

        .back-to-top:hover {
            transform: translateY(-4px);
            box-shadow: 0 22px 55px rgba(37, 99, 235, 0.6);
        }

        .back-to-top.show {
            display: flex;
            animation: fadeIn 0.25s ease;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(14px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* 动画效果 */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(24px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* 响应式细节 */
        @media (max-width: 991.98px) {
            .hero-section {
                padding-top: 90px;
                padding-bottom: 60px;
            }

            .hero-title {
                font-size: 2.4rem;
            }

            .hero-subtitle {
                font-size: 1rem;
            }

            .hero-card {
                margin: 2rem auto 0;
            }

            .toast {
                min-width: 280px;
                max-width: 90vw;
            }
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

        <!-- 注意：去掉 data-bs-toggle / data-bs-target，改为 JS 手动控制 -->
        <button class="navbar-toggler custom-toggler collapsed"
                type="button"
                aria-controls="navbarNav"
                aria-expanded="false"
                aria-label="切换导航">
            <span class="toggler-lines">
                <span></span>
                <span></span>
                <span></span>
            </span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-lg-center">
                <li class="nav-item">
                    <a class="nav-link" href="#features">功能特色</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#about">关于我们</a>
                </li>

                <!-- PC 端右上角登录 / 注册 -->
                <li class="nav-item d-none d-lg-block">
                    <a class="btn btn-outline-primary btn-auth me-2" href="<c:url value='/user/login'/>">登录</a>
                </li>
                <li class="nav-item d-none d-lg-block">
                    <a class="btn btn-primary btn-auth" href="<c:url value='/user/register'/>">免费注册</a>
                </li>
            </ul>

            <!-- 手机端导航底部登录 / 注册按钮 -->
            <div class="mobile-auth-actions d-lg-none">
                <div class="mobile-auth-buttons">
                    <a href="<c:url value='/user/login'/>" class="login-btn">登录</a>
                    <a href="<c:url value='/user/register'/>" class="register-btn">免费注册</a>
                </div>
            </div>
        </div>
    </div>
</nav>

<!-- 主要内容区域 -->
<main>
    <!-- 英雄区域 -->
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <!-- 左侧文案 -->
                <div class="col-lg-6">
                    <div class="hero-content">
                        <div class="hero-badge">
                            <i class="bi bi-patch-check-fill"></i>
                            已为超过 10,000+ 用户提供专业调研服务
                        </div>
                        <h1 class="hero-title">
                            一站式 <span>在线问卷</span> 调研平台
                        </h1>
                        <p class="hero-subtitle">
                            拖拽式问卷设计 · 实时数据统计 · 多渠道发布
                            帮你在几分钟内完成一份专业的调研问卷。
                        </p>
                        <div class="hero-actions">
                            <a href="<c:url value='/user/register'/>" class="btn btn-light btn-lg btn-hero">
                                <i class="fas fa-rocket me-2"></i>免费创建我的第一份问卷
                            </a>
                            <a href="<c:url value='/user/login'/>" class="btn btn-outline-light btn-lg btn-hero">
                                <i class="fas fa-sign-in-alt me-2"></i>已有账号，立即登录
                            </a>
                        </div>
                        <div class="hero-meta">
                            <div class="hero-meta-item">
                                <i class="bi bi-shield-check"></i> 企业级安全防护
                            </div>
                            <div class="hero-meta-item">
                                <i class="bi bi-cloud-arrow-down"></i> 数据实时统计与导出
                            </div>
                            <div class="hero-meta-item">
                                <i class="bi bi-phone"></i> 多终端完美适配
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 右侧卡片 -->
                <div class="col-lg-6 d-none d-lg-block">
                    <div class="hero-card">
                        <div class="hero-card-header">
                            <div>
                                <div class="hero-card-title">
                                    今日问卷概览
                                </div>
                                <small style="color:#9ca3af;">
                                    实时同步 · 自动汇总
                                </small>
                            </div>
                            <span class="hero-card-tag">
                                <i class="bi bi-lightning-charge-fill me-1"></i>实时更新
                            </span>
                        </div>
                        <div class="hero-card-metric">
                            <span>今日已收集答卷</span>
                            <span>1,248</span>
                        </div>
                        <div class="hero-card-progress">
                            <div class="hero-card-progress-bar"></div>
                        </div>
                        <div class="hero-card-footer mt-3">
                            <span>
                                平均完成率：<strong>92.6%</strong>
                            </span>
                            <span>
                                在线问卷：<strong>38</strong> 份
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- 统计数据 -->
    <section class="stats-section-wrapper">
        <div class="container">
            <div class="stats-section">
                <div class="stats-inner">
                    <div class="row align-items-center">
                        <div class="col-md-3 col-6">
                            <div class="stat-item">
                                <span class="stat-number">10,000+</span>
                                <span class="stat-label">活跃用户</span>
                            </div>
                        </div>
                        <div class="col-md-3 col-6">
                            <div class="stat-item">
                                <span class="stat-number">50,000+</span>
                                <span class="stat-label">创建问卷</span>
                            </div>
                        </div>
                        <div class="col-md-3 col-6 mt-3 mt-md-0">
                            <div class="stat-item">
                                <span class="stat-number">1,000,000+</span>
                                <span class="stat-label">收集答卷</span>
                            </div>
                        </div>
                        <div class="col-md-3 col-6 mt-3 mt-md-0">
                            <div class="stat-item">
                                <span class="stat-number">99.9%</span>
                                <span class="stat-label">系统稳定性</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- 功能特色 -->
    <section class="features-section" id="features">
        <div class="container">
            <h2 class="section-title">为什么选择问卷星？</h2>
            <p class="section-subtitle">从设计到回收，从统计到导出，为你的每一次调研保驾护航</p>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="feature-icon" style="background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));">
                            <i class="fas fa-edit"></i>
                        </div>
                        <div class="feature-tag">
                            <i class="bi bi-mouse"></i> 所见即所得
                        </div>
                        <h4 class="feature-title">简单易用的问卷编辑器</h4>
                        <p class="feature-description">
                            支持单选、多选、矩阵、评分、填空等多种题型，拖拽式操作，无需任何编程基础，即可轻松搭建专业问卷。
                        </p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="feature-icon" style="background: linear-gradient(135deg, var(--success-color), #17a673);">
                            <i class="fas fa-chart-bar"></i>
                        </div>
                        <div class="feature-tag">
                            <i class="bi bi-graph-up"></i> 实时可视化
                        </div>
                        <h4 class="feature-title">强大的数据统计与分析</h4>
                        <p class="feature-description">
                            自动生成柱状图、饼图、折线图等可视化图表，支持交叉分析与数据导出，让你快速洞察调研结果。
                        </p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="feature-icon" style="background: linear-gradient(135deg, var(--info-color), #2c9faf);">
                            <i class="fas fa-share-alt"></i>
                        </div>
                        <div class="feature-tag">
                            <i class="bi bi-share"></i> 全渠道分发
                        </div>
                        <h4 class="feature-title">多渠道发布与回收</h4>
                        <p class="feature-description">
                            支持链接、二维码、邮件、社交平台等多种发布方式，一键分享，快速触达目标人群，提高回收效率。
                        </p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="feature-icon" style="background: linear-gradient(135deg, var(--warning-color), #dda20a);">
                            <i class="fas fa-mobile-alt"></i>
                        </div>
                        <div class="feature-tag">
                            <i class="bi bi-phone"></i> 响应式体验
                        </div>
                        <h4 class="feature-title">多终端自适应</h4>
                        <p class="feature-description">
                            深度优化移动端体验，无论是手机、平板还是电脑，都能为答卷人提供顺滑流畅的作答体验。
                        </p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="feature-icon" style="background: linear-gradient(135deg, var(--danger-color), #b91d0a);">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <div class="feature-tag">
                            <i class="bi bi-lock-fill"></i> 数据加密
                        </div>
                        <h4 class="feature-title">企业级安全防护</h4>
                        <p class="feature-description">
                            多重加密存储、权限控制与备份机制，符合行业安全规范，确保问卷与答卷数据的私密与安全。
                        </p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="feature-icon" style="background: linear-gradient(135deg, var(--secondary-color), #6c6e7e);">
                            <i class="fas fa-headset"></i>
                        </div>
                        <div class="feature-tag">
                            <i class="bi bi-headset"></i> 专人服务
                        </div>
                        <h4 class="feature-title">专业服务与支持</h4>
                        <p class="feature-description">
                            提供7×24小时在线支持，遇到任何问题都可以第一时间获得帮助，保障你的调研工作顺利进行。
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- 关于我们 -->
    <section class="about-section" id="about">
        <div class="container">
            <h2 class="section-title">关于我们</h2>
            <p class="section-subtitle">让每一次调研都有价值，让每一份数据都能被看见</p>
            <div class="row align-items-center">
                <div class="col-lg-6 mb-4 mb-lg-0">
                    <span class="about-badge">
                        <i class="bi bi-people-fill"></i> 专注在线调研服务
                    </span>
                    <h3 class="mb-3">问卷星 · 专业值得信赖的在线问卷平台</h3>
                    <p class="lead text-muted mb-3" style="font-size: 1.02rem;">
                        问卷星致力于为企业、学校、机构及个人提供专业、高效、安全的在线问卷解决方案，
                        覆盖满意度调研、市场调研、教学评估、报名登记等多种场景。
                    </p>
                    <div class="about-list">
                        <div class="item">
                            <i class="fas fa-check-circle"></i>
                            <span>10 年+ 在线问卷与数据服务经验</span>
                        </div>
                        <div class="item">
                            <i class="fas fa-check-circle"></i>
                            <span>服务行业覆盖教育、互联网、金融、政务等多个领域</span>
                        </div>
                        <div class="item">
                            <i class="fas fa-check-circle"></i>
                            <span>专业技术团队与完善的运维体系，保障平台稳定运行</span>
                        </div>
                        <div class="item">
                            <i class="fas fa-check-circle"></i>
                            <span>严格遵循隐私保护要求，重视每一位用户的数据安全</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 text-center">
                    <i class="fas fa-users" style="font-size: 13rem; color: var(--primary-color); opacity: 0.08;"></i>
                </div>
            </div>
        </div>
    </section>
</main>

<!-- 页脚 -->
<footer class="footer">
    <div class="container">
        <div class="row gy-3">
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
        <hr class="my-4">
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
    // 平滑滚动（仅处理站内锚点）
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            const href = this.getAttribute('href');
            if (!href || href === '#') return;
            const target = document.querySelector(href);
            if (target) {
                e.preventDefault();
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });

    const navbar = document.querySelector('.navbar');
    const navbarCollapseEl = document.getElementById('navbarNav');
    const navbarToggler = document.querySelector('.navbar-toggler');

    let collapseInstance = null;
    if (navbarCollapseEl) {
        collapseInstance = new bootstrap.Collapse(navbarCollapseEl, {toggle: false});
    }

    // 手动控制折叠菜单，避免「闪一下」问题
    if (navbarToggler && collapseInstance) {
        navbarToggler.addEventListener('click', function () {
            const isShown = navbarCollapseEl.classList.contains('show');
            if (isShown) {
                collapseInstance.hide();
            } else {
                collapseInstance.show();
            }
        });

        // 同步 aria-expanded 与按钮样式
        navbarCollapseEl.addEventListener('shown.bs.collapse', function () {
            navbarToggler.setAttribute('aria-expanded', 'true');
            navbarToggler.classList.remove('collapsed');
        });
        navbarCollapseEl.addEventListener('hidden.bs.collapse', function () {
            navbarToggler.setAttribute('aria-expanded', 'false');
            navbarToggler.classList.add('collapsed');
        });

        // 点击菜单项后自动收起（仅移动端）
        navbarCollapseEl.querySelectorAll('.nav-link').forEach(link => {
            link.addEventListener('click', function () {
                if (window.innerWidth < 992 && navbarCollapseEl.classList.contains('show')) {
                    collapseInstance.hide();
                }
            });
        });
    }

    // 导航栏滚动效果 + 下滑时自动收起菜单
    let lastScrollY = window.scrollY || 0;
    window.addEventListener('scroll', function () {
        const currentY = window.scrollY || 0;

        if (currentY > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }

        // 只有在移动端并且菜单已展开时才处理
        if (window.innerWidth < 992 && navbarCollapseEl && navbarCollapseEl.classList.contains('show')) {
            // 用户明显向下滑动时收起菜单（有一个小阈值）
            if (currentY > lastScrollY + 15 && collapseInstance) {
                collapseInstance.hide();
            }
        }

        lastScrollY = currentY;
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
                const hasPlus = finalValue.includes('+');
                const suffix = hasPlus ? '+' : (finalValue.endsWith('%') ? '%' : '');
                const timer = setInterval(() => {
                    currentValue += increment;
                    if (currentValue >= numericValue) {
                        number.textContent = numericValue.toLocaleString() + suffix;
                        clearInterval(timer);
                    } else {
                        number.textContent = Math.floor(currentValue).toLocaleString() + suffix;
                    }
                }, 30);
            }
        });
    }

    // 当统计区域进入视口时触发动画
    const statsSection = document.querySelector('.stats-section');
    if (statsSection) {
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    animateNumbers();
                    observer.unobserve(entry.target);
                }
            });
        });
        observer.observe(statsSection);
    }

    // Toast通知功能
    function showLogoutToast() {
        const toastContainer = document.getElementById('toastContainer');
        const toast = document.getElementById('logoutToast');

        toastContainer.style.display = 'block';
        toast.classList.add('show');

        setTimeout(() => {
            hideToast();
        }, 3000);

        const progressBar = toast.querySelector('.toast-progress');
        if (progressBar) {
            progressBar.style.animation = 'toastProgress 3s linear';
        }
    }

    function hideToast() {
        const toast = document.getElementById('logoutToast');
        const toastContainer = document.getElementById('toastContainer');
        if (!toast || !toastContainer) return;

        toast.classList.remove('show');
        setTimeout(() => {
            toastContainer.style.display = 'none';
        }, 300);
    }

    // 检查URL参数，如果是从退出登录过来的，显示Toast
    window.addEventListener('load', function () {
        const urlParams = new URLSearchParams(window.location.search);
        const hasLoggedIn = localStorage.getItem('hasLoggedIn');
        if (urlParams.get('logout') === 'success' && hasLoggedIn === 'true') {
            localStorage.removeItem('hasLoggedIn');
            setTimeout(() => {
                showLogoutToast();
            }, 500);
        }
    });

    const toastCloseBtn = document.querySelector('.toast-close');
    if (toastCloseBtn) {
        toastCloseBtn.addEventListener('click', function () {
            hideToast();
        });
    }

    const logoutToast = document.getElementById('logoutToast');
    if (logoutToast) {
        logoutToast.addEventListener('click', function (e) {
            if (e.target === this) {
                hideToast();
            }
        });
    }

    // 回到顶部功能
    const backToTopBtn = document.createElement('button');
    backToTopBtn.className = 'back-to-top';
    backToTopBtn.innerHTML = '<i class="fas fa-arrow-up"></i>';
    backToTopBtn.title = '回到顶部';
    document.body.appendChild(backToTopBtn);

    window.addEventListener('scroll', function () {
        if (window.pageYOffset > 300) {
            backToTopBtn.classList.add('show');
        } else {
            backToTopBtn.classList.remove('show');
        }
    });

    backToTopBtn.addEventListener('click', function () {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    });
</script>
</body>
</html>
