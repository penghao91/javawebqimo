<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty questionnaire.id ? '创建问卷' : '编辑问卷'} - 问卷星</title>

    <!-- 依赖，与首页保持一致 -->
    <link href="/resources/css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link href="/resources/css/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="/resources/css/font-awesome/all.min.css" rel="stylesheet">

    <style>
        :root {
            --primary-color: #4e73df;
            --primary-dark: #224abe;
            --secondary-color: #858796;
            --success-color: #1cc88a;
            --danger-color: #e74a3b;
            --light-color: #f8f9fc;
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

        a {
            text-decoration: none;
        }

        /* 顶部导航（参考首页） */
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

        .navbar-nav .nav-link:hover::after,
        .navbar-nav .nav-link.active::after {
            width: 60%;
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

        .custom-toggler[aria-expanded="true"] .toggler-lines span:nth-child(1) {
            transform: translateY(7px) rotate(45deg);
        }

        .custom-toggler[aria-expanded="true"] .toggler-lines span:nth-child(2) {
            opacity: 0;
        }

        .custom-toggler[aria-expanded="true"] .toggler-lines span:nth-child(3) {
            transform: translateY(-7px) rotate(-45deg);
        }

        /* 右上角用户信息 */
        .user-pill {
            display: inline-flex;
            align-items: center;
            gap: .35rem;
            padding: 0.35rem 0.9rem;
            border-radius: 999px;
            border: 1px solid var(--border-soft);
            background: #f9fafb;
            color: var(--secondary-color);
            font-size: .9rem;
        }

        .user-pill i {
            color: var(--primary-color);
        }

        .btn-logout {
            border-radius: 999px;
            padding: 0.35rem 0.9rem;
            font-size: .9rem;
            margin-left: .6rem;
        }

        .page-wrapper {
            padding-top: 88px;  /* 顶部导航高度 */
            padding-bottom: 48px;
        }

        /* 子页面头部（轻量版 hero） */
        .subpage-hero {
            padding: 28px 0 14px;
        }

        .subpage-hero-inner {
            background: linear-gradient(135deg, #4f46e5 0, #1d4ed8 40%, #2563eb 100%);
            border-radius: 20px;
            padding: 18px 22px;
            color: #fff;
            box-shadow: 0 14px 36px rgba(37, 99, 235, 0.35);
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 1rem;
        }

        .subpage-hero-title {
            margin: 0;
            font-size: 1.5rem;
            font-weight: 700;
        }

        .subpage-hero-sub {
            margin: .25rem 0 0;
            font-size: .96rem;
            opacity: .92;
        }

        .subpage-hero-breadcrumb {
            font-size: .85rem;
            opacity: .9;
        }

        .subpage-hero-breadcrumb a {
            color: #e0f2fe;
        }

        .subpage-hero-badge {
            display: inline-flex;
            align-items: center;
            gap: .3rem;
            padding: .2rem .7rem;
            border-radius: 999px;
            border: 1px solid rgba(248,250,252,.9);
            background: rgba(15,23,42,.15);
            font-size: .8rem;
        }

        /* 布局：左侧菜单 + 右侧表单 */
        .content-layout {
            padding-top: 20px;
        }

        /* 左侧竖向菜单卡片 */
        .side-nav-card {
            background: #ffffff;
            border-radius: 18px;
            padding: 16px 16px 14px;
            box-shadow: 0 12px 32px rgba(15, 23, 42, 0.08);
            border: 1px solid rgba(226, 232, 240, 0.9);
        }

        .side-nav-title {
            font-size: .95rem;
            font-weight: 700;
            margin-bottom: 4px;
            color: #111827;
        }

        .side-nav-sub {
            font-size: .8rem;
            color: var(--muted-color);
            margin-bottom: 10px;
        }

        .side-nav-menu {
            list-style: none;
            padding-left: 0;
            margin: 0;
        }

        .side-nav-item + .side-nav-item {
            margin-top: 4px;
        }

        .side-nav-link {
            display: flex;
            align-items: center;
            padding: 0.45rem 0.65rem;
            border-radius: 10px;
            font-size: .9rem;
            color: var(--secondary-color);
            transition: all 0.18s ease;
        }

        .side-nav-link i {
            font-size: 1rem;
            margin-right: .5rem;
            width: 18px;
            text-align: center;
        }

        .side-nav-link:hover {
            background: #f1f5ff;
            color: var(--primary-color);
            transform: translateX(2px);
        }

        .side-nav-link.active {
            background: linear-gradient(135deg, rgba(78,115,223,0.1), rgba(78,115,223,0.2));
            color: var(--primary-dark);
            font-weight: 600;
        }

        .side-nav-link.active i {
            color: var(--primary-dark);
        }

        /* 右侧表单卡片 */
        .form-card {
            background: #ffffff;
            border-radius: 18px;
            padding: 22px 24px 20px;
            box-shadow: 0 14px 40px rgba(15, 23, 42, 0.08);
            border: 1px solid rgba(226, 232, 240, 0.9);
        }

        @media (max-width: 576px) {
            .form-card {
                padding: 18px 16px;
            }
        }

        .form-card-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 14px;
        }

        .form-card-title {
            display: flex;
            align-items: center;
            gap: .5rem;
        }

        .form-card-title-icon {
            width: 36px;
            height: 36px;
            border-radius: 12px;
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
        }

        .form-card-title-text {
            font-size: 1rem;
            font-weight: 700;
        }

        .form-card-subtitle {
            font-size: .86rem;
            color: var(--muted-color);
            margin-top: 2px;
        }

        .badge-step {
            border-radius: 999px;
            padding: .25rem .8rem;
            font-size: .78rem;
            background: #eef2ff;
            color: #4f46e5;
            display: inline-flex;
            align-items: center;
            gap: .25rem;
        }

        .badge-step i {
            font-size: .9rem;
        }

        .form-label {
            font-weight: 600;
            font-size: .9rem;
            color: #1f2937;
        }

        .form-label .text-danger {
            font-size: .86rem;
        }

        .form-control,
        textarea.form-control {
            border-radius: 12px;
            border: 1px solid var(--border-soft);
            font-size: .95rem;
            padding: .55rem .85rem;
            transition: border-color .18s ease, box-shadow .18s ease, transform .08s ease;
        }

        .form-control::placeholder,
        textarea.form-control::placeholder {
            color: #9ca3af;
        }

        .form-control:focus,
        textarea.form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 1px rgba(78, 115, 223, 0.35);
            outline: none;
            transform: translateY(-1px);
        }

        textarea.form-control {
            resize: vertical;
            min-height: 110px;
        }

        .form-control.is-invalid {
            border-color: var(--danger-color);
        }

        .form-control.is-invalid:focus {
            box-shadow: 0 0 0 1px rgba(231, 74, 59, 0.4);
        }

        .field-footer-row {
            margin-top: .3rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: .5rem;
        }

        .form-text {
            font-size: .82rem;
            color: var(--muted-color);
        }

        .char-counter {
            font-size: .8rem;
            color: var(--muted-color);
            white-space: nowrap;
        }

        .char-counter span {
            font-variant-numeric: tabular-nums;
        }

        .form-errors {
            font-size: .8rem;
            color: var(--danger-color);
            margin-top: .2rem;
        }

        .form-actions {
            margin-top: 16px;
            display: flex;
            justify-content: flex-end;
            gap: .6rem;
        }

        .btn-pill {
            border-radius: 999px;
            padding: .55rem 1.4rem;
            font-size: .9rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: .35rem;
        }

        .btn-primary-pill {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            border: none;
            color: #fff;
            box-shadow: 0 12px 24px rgba(78, 115, 223, 0.45);
        }

        .btn-primary-pill:hover {
            background: linear-gradient(135deg, #4663ce, #1f3fa6);
            box-shadow: 0 14px 28px rgba(78, 115, 223, 0.55);
            transform: translateY(-1px);
        }

        .btn-outline-secondary-pill {
            border-radius: 999px;
            border: 1px solid var(--border-soft);
            background: #f9fafb;
            color: var(--secondary-color);
        }

        .btn-outline-secondary-pill:hover {
            background: #e5e7eb;
            color: #111827;
        }

        /* Toast 通知 */
        .toast-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
        }

        .toast-custom {
            background: white;
            border-radius: 16px;
            box-shadow: 0 18px 40px rgba(15, 23, 42, 0.18);
            border: 1px solid rgba(226, 232, 240, 0.9);
            overflow: hidden;
            min-width: 320px;
            max-width: 420px;
            animation: slideInRight 0.3s ease-out;
            position: relative;
        }

        .toast-custom-header {
            display: flex;
            align-items: center;
            gap: .45rem;
            padding: .65rem .9rem;
            color: #fff;
        }

        .toast-custom-header.success {
            background: linear-gradient(135deg, var(--success-color), #17a673);
        }

        .toast-custom-header.error {
            background: linear-gradient(135deg, var(--danger-color), #b91c1c);
        }

        .toast-custom-header i {
            font-size: 1.1rem;
        }

        .toast-custom-title {
            font-weight: 600;
            font-size: .95rem;
        }

        .toast-custom-body {
            padding: .9rem .95rem .85rem;
            font-size: .9rem;
            color: var(--dark-color);
        }

        .toast-custom-progress {
            position: absolute;
            bottom: 0;
            left: 0;
            height: 3px;
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.4), rgba(255, 255, 255, 0.9));
            animation: toastProgress 3s linear forwards;
        }

        .toast-custom-close {
            margin-left: auto;
            background: none;
            border: none;
            color: #fff;
            font-size: 1rem;
            cursor: pointer;
            opacity: .85;
        }

        .toast-custom-close:hover {
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

        @media (max-width: 991.98px) {
            .navbar-collapse {
                background: #ffffff;
                padding: 0.8rem 0 1rem;
            }

            .toast-custom {
                min-width: 260px;
                max-width: 90vw;
            }

            .subpage-hero-inner {
                flex-direction: column;
                align-items: flex-start;
            }
        }

        /* ===== 用户下拉菜单美化 ===== */
        .user-menu-dropdown {
            border-radius: 16px;
            padding: 0;
            border: 1px solid rgba(226,232,240,0.95);
            box-shadow: 0 18px 40px rgba(15,23,42,0.18);
            min-width: 260px;
            overflow: hidden;
        }

        /* 顶部用户信息区域 */
        .user-menu-header {
            padding: .75rem 1rem .8rem;
            background: linear-gradient(135deg, #4e73df, #224abe);
            color: #fff;
            font-size: .85rem;
        }

        .user-menu-title {
            font-weight: 600;
            margin-bottom: .2rem;
            display: flex;
            align-items: center;
        }

        .user-menu-title i {
            font-size: 1rem;
        }

        .user-menu-sub {
            opacity: .92;
            line-height: 1.5;
        }

        /* 分割线 */
        .user-menu-divider {
            margin: .3rem 0;
            border-color: rgba(226,232,240,0.9);
        }

        /* 菜单项 */
        .user-menu-item {
            padding: .55rem 1rem;
            font-size: .9rem;
            display: flex;
            align-items: center;
            gap: .5rem;
            color: #4b4d63;
        }

        .user-menu-item i {
            font-size: 1rem;
        }

        .user-menu-item:hover {
            background-color: #f3f4ff;
            color: #111827;
        }

        .user-menu-item.text-danger {
            color: #e74a3b;
        }

        .user-menu-item.text-danger:hover {
            background-color: #fee2e2;
            color: #b91c1c;
        }

        /* ===== 移动端导航折叠样式修复 ===== */
        @media (max-width: 991.98px) {

            /* 折叠后的整体区域做成一个白色卡片 */
            .navbar-collapse {
                background: transparent;
                padding: 0.75rem 1rem 1rem;
            }

            .navbar-collapse.show {
                /* bootstrap 会显示 block，这里只补充样式 */
            }

            .navbar-collapse .navbar-nav,
            .navbar-collapse > .d-flex {
                background: #ffffff;
                border-radius: 18px;
                box-shadow: 0 18px 40px rgba(15,23,42,0.18);
                padding: 1rem 1.1rem;
            }

            /* 菜单项纵向排列，左右留白 */
            .navbar-nav .nav-link {
                display: block;
                padding-left: 0;
                padding-right: 0;
                margin-bottom: .25rem;
            }

            /* 关闭移动端那条小蓝条 */
            .navbar-nav .nav-link::after {
                display: none;
                width: 0;
            }

            /* 用户信息放在卡片底部，和菜单有一点分隔 */
            .navbar-collapse > .d-flex {
                margin-top: .5rem;
                border-top: 1px solid #e5e7eb;
                padding-top: .7rem;
                flex-direction: row;
                justify-content: space-between;
                align-items: center;
            }

            .navbar-collapse > .d-flex .user-pill {
                margin-top: 0;
            }

            .navbar-collapse > .d-flex .btn-logout {
                margin-left: .5rem;
            }
        }
    </style>
</head>
<body>

<!-- Toast 容器 -->
<div class="toast-container" id="toastContainer" style="display:none;"></div>

<!-- 顶部导航（全站统一） -->
<nav class="navbar navbar-expand-lg navbar-light fixed-top">
    <div class="container">
        <a class="navbar-brand" href="<c:url value='/'/>">
            <i class="fas fa-poll"></i> 问卷星
        </a>

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
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value='/'/>">首页</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="<c:url value='/questionnaire/list'/>">我的问卷</a>
                </li>
            </ul>

            <div class="d-flex align-items-center mt-3 mt-lg-0">
                <c:if test="${not empty user}">
                    <div class="dropdown">
                        <button class="btn btn-link user-dropdown-btn dropdown-toggle"
                                type="button"
                                id="userDropdown"
                                data-bs-toggle="dropdown"
                                aria-expanded="false">
                            <i class="bi bi-person-circle me-1"></i>${user.username}
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end user-menu-dropdown" aria-labelledby="userDropdown">
                            <li class="user-menu-header">
                                <div class="user-menu-title">
                                    <i class="bi bi-person-circle me-2"></i> 账号中心
                                </div>
                                <div class="user-menu-sub">
                                    用户名：${user.username}<br/>
                                    账号ID：${user.id}<br/>
                                    <c:choose>
                                        <c:when test="${empty user.email}">
                                            邮箱：未设置
                                        </c:when>
                                        <c:otherwise>
                                            邮箱：${user.email}
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </li>

                            <li><hr class="dropdown-divider user-menu-divider"></li>

                            <li>
                                <a class="dropdown-item user-menu-item" href="<c:url value='/user/profile'/>">
                                    <i class="bi bi-person-lines-fill"></i> 账号信息
                                </a>
                            </li>

                            <li><hr class="dropdown-divider user-menu-divider"></li>

                            <li>
                                <a class="dropdown-item user-menu-item text-danger" href="<c:url value='/user/logout'/>">
                                    <i class="bi bi-box-arrow-right"></i> 退出登录
                                </a>
                            </li>
                        </ul>
                    </div>
                </c:if>
                <c:if test="${empty user}">
                    <a href="<c:url value='/user/login'/>" class="btn btn-outline-primary btn-logout">
                        登录
                    </a>
                </c:if>
            </div>
        </div>
    </div>
</nav>

<div class="page-wrapper">
    <div class="container">
        <!-- 子页面头部 -->
        <section class="subpage-hero">
            <div class="subpage-hero-inner">
                <div>
                    <p class="subpage-hero-breadcrumb mb-1">
                        <a href="<c:url value='/'/>">首页</a>
                        <span> / </span>
                        <a href="<c:url value='/questionnaire/list'/>">我的问卷</a>
                        <span> / </span>
                        <span>${empty questionnaire.id ? '创建问卷' : '编辑问卷'}</span>
                    </p>
                    <h1 class="subpage-hero-title">
                        ${empty questionnaire.id ? '创建新问卷' : '编辑问卷'}
                    </h1>
                    <p class="subpage-hero-sub">
                        先完善问卷标题与描述，后续可以继续添加题目并发布收集。
                    </p>
                </div>
                <div>
                    <span class="subpage-hero-badge">
                        <i class="bi ${empty questionnaire.id ? 'bi-lightning-charge-fill' : 'bi-pencil-square'}"></i>
                        ${empty questionnaire.id ? '快速新建' : '修改中'}
                    </span>
                </div>
            </div>
        </section>

        <!-- 左边菜单 + 右边表单 -->
        <section class="content-layout">
            <div class="row g-3">
                <!-- 左侧竖向菜单 -->
                <aside class="col-lg-3">
                    <div class="side-nav-card">
                        <div class="side-nav-title">问卷导航</div>
                        <div class="side-nav-sub">快速切换不同功能模块</div>
                        <ul class="side-nav-menu">
                            <li class="side-nav-item">
                                <a href="<c:url value='/questionnaire/create'/>" class="side-nav-link active">
                                    <i class="bi bi-plus-circle"></i>
                                    创建问卷
                                </a>
                            </li>
                            <li class="side-nav-item">
                                <a href="<c:url value='/questionnaire/list'/>" class="side-nav-link">
                                    <i class="bi bi-list-ul"></i>
                                    全部问卷
                                </a>
                            </li>
                            <li class="side-nav-item">
                                <a href="<c:url value='/questionnaire/starred'/>" class="side-nav-link">
                                    <i class="bi bi-star"></i>
                                    星标问卷
                                </a>
                            </li>
                            <li class="side-nav-item">
                                <a href="<c:url value='/questionnaire/folders'/>" class="side-nav-link">
                                    <i class="bi bi-folder"></i>
                                    文件夹
                                </a>
                            </li>
                            <li class="side-nav-item">
                                <a href="<c:url value='/questionnaire/recycle'/>" class="side-nav-link">
                                    <i class="bi bi-trash"></i>
                                    回收站
                                </a>
                            </li>
                        </ul>
                    </div>
                </aside>

                <!-- 右侧表单 -->
                <section class="col-lg-9">
                    <div class="form-card">
                        <div class="form-card-header">
                            <div class="form-card-title">
                                <div class="form-card-title-icon">
                                    <i class="bi bi-card-text"></i>
                                </div>
                                <div>
                                    <div class="form-card-title-text">问卷基本信息</div>
                                    <div class="form-card-subtitle">
                                        这些内容会直接展示给填写者，后续可以随时修改。
                                    </div>
                                </div>
                            </div>
                            <div class="d-none d-md-block">
                                <span class="badge-step">
                                    <i class="bi bi-1-circle"></i> 第一步：填写基本信息
                                </span>
                            </div>
                        </div>

                        <!-- Spring 消息：用 Toast 显示 -->
                        <c:if test="${not empty message}">
                            <script>
                                window.addEventListener('load', function () {
                                    showToast('success', '${message}');
                                });
                            </script>
                        </c:if>
                        <c:if test="${not empty error}">
                            <script>
                                window.addEventListener('load', function () {
                                    showToast('error', '${error}');
                                });
                            </script>
                        </c:if>

                        <hr class="mb-3"/>

                        <c:url value='/questionnaire/${empty questionnaire.id ? "create" : "edit/"}${questionnaire.id}' var="formAction"/>

                        <form:form modelAttribute="questionnaire" action="${formAction}" method="post">
                            <!-- 标题 -->
                            <div class="mb-3">
                                <form:label path="title" class="form-label">
                                    问卷标题 <span class="text-danger">*</span>
                                </form:label>
                                <form:input path="title" id="title" class="form-control"
                                            required="true" maxlength="200"
                                            autocomplete="off"
                                            placeholder="例如：2025 年度用户满意度调研"/>
                                <div class="form-errors">
                                    <form:errors path="title"/>
                                </div>
                                <div class="field-footer-row">
                                    <div class="form-text">
                                        建议控制在 50 字以内，直接点出调研主题，避免过于抽象。
                                    </div>
                                    <div class="char-counter" data-char-target="title" data-char-max="200">
                                        <span>0</span>/200
                                    </div>
                                </div>
                            </div>

                            <!-- 描述 -->
                            <div class="mb-3">
                                <form:label path="description" class="form-label">
                                    问卷描述
                                </form:label>
                                <form:textarea path="description" id="description"
                                               class="form-control" rows="4" maxlength="1000"
                                               placeholder="向填写者说明：本次问卷的目的、预计耗时、是否匿名、数据将如何使用等内容。（选填）"/>
                                <div class="form-errors">
                                    <form:errors path="description"/>
                                </div>
                                <div class="field-footer-row">
                                    <div class="form-text">
                                        例如：本问卷预计耗时 3–5 分钟，所有信息仅用于统计分析，不会泄露给第三方。
                                    </div>
                                    <div class="char-counter" data-char-target="description" data-char-max="1000">
                                        <span>0</span>/1000
                                    </div>
                                </div>
                            </div>

                            <!-- 操作按钮 -->
                            <div class="form-actions">
                                <a href="<c:url value='/questionnaire/list'/>" class="btn btn-outline-secondary-pill">
                                    <i class="bi bi-arrow-left"></i> 返回列表
                                </a>
                                <button type="submit" class="btn btn-primary-pill">
                                    <i class="bi bi-check-lg"></i>
                                        ${empty questionnaire.id ? '保存并继续设计问卷' : '保存修改'}
                                </button>
                            </div>
                        </form:form>
                    </div>
                </section>
            </div>
        </section>
    </div>
</div>

<script src="/resources/js/bootstrap/bootstrap.bundle.min.js"></script>
<script>
    // 导航展开/收起（和首页一致的写法）
    const navbar = document.querySelector('.navbar');
    const navbarCollapseEl = document.getElementById('navbarNav');
    const navbarToggler = document.querySelector('.navbar-toggler');

    let collapseInstance = null;
    if (navbarCollapseEl) {
        collapseInstance = new bootstrap.Collapse(navbarCollapseEl, {toggle: false});
    }

    if (navbarToggler && collapseInstance) {
        navbarToggler.addEventListener('click', function () {
            const isShown = navbarCollapseEl.classList.contains('show');
            if (isShown) {
                collapseInstance.hide();
            } else {
                collapseInstance.show();
            }
        });

        navbarCollapseEl.addEventListener('shown.bs.collapse', function () {
            navbarToggler.setAttribute('aria-expanded', 'true');
            navbarToggler.classList.remove('collapsed');
        });
        navbarCollapseEl.addEventListener('hidden.bs.collapse', function () {
            navbarToggler.setAttribute('aria-expanded', 'false');
            navbarToggler.classList.add('collapsed');
        });
    }

    window.addEventListener('scroll', function () {
        const currentY = window.scrollY || 0;
        if (currentY > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });

    // 字数统计 + 标题聚焦
    document.addEventListener('DOMContentLoaded', function () {
        const titleInput = document.getElementById('title');
        if (titleInput) {
            titleInput.focus();
        }

        document.querySelectorAll('.char-counter').forEach(function(counter) {
            const targetId = counter.getAttribute('data-char-target');
            const max = parseInt(counter.getAttribute('data-char-max'), 10) || 0;
            const target = document.getElementById(targetId);
            const span = counter.querySelector('span');

            if (!target || !span) return;

            const updateCount = function () {
                const len = (target.value || '').length;
                span.textContent = len;
            };

            updateCount();
            target.addEventListener('input', updateCount);
        });
    });

    // Toast 显示函数
    function showToast(type, message, duration = 3000) {
        const container = document.getElementById('toastContainer');
        if (!container) return;

        container.innerHTML = '';
        container.style.display = 'block';

        const isSuccess = type === 'success';
        const headerClass = isSuccess ? 'success' : 'error';
        const icon = isSuccess ? 'check-circle-fill' : 'exclamation-triangle-fill';
        const title = isSuccess ? '操作成功' : '操作失败';

        const toast = document.createElement('div');
        toast.className = 'toast-custom';
        toast.innerHTML =
            '<div class="toast-custom-header ' + headerClass + '">' +
            '<i class="bi bi-' + icon + '"></i>' +
            '<span class="toast-custom-title">' + title + '</span>' +
            '<button type="button" class="toast-custom-close" aria-label="关闭">' +
            '<i class="bi bi-x-lg"></i>' +
            '</button>' +
            '</div>' +
            '<div class="toast-custom-body">' + message + '</div>' +
            '<div class="toast-custom-progress"></div>';

        container.appendChild(toast);

        const close = () => {
            toast.style.opacity = '0';
            toast.style.transform = 'translateX(20px)';
            setTimeout(() => {
                container.style.display = 'none';
                container.innerHTML = '';
            }, 250);
        };

        toast.querySelector('.toast-custom-close').addEventListener('click', close);
        setTimeout(close, duration);
    }
</script>
</body>
</html>
