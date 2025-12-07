<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>我的问卷 - 问卷星</title>

    <!-- 和创建页保持一致的资源引用 -->
    <link href="<c:url value='/resources/css/bootstrap/bootstrap.min.css'/>" rel="stylesheet">
    <link href="<c:url value='/resources/css/bootstrap-icons/bootstrap-icons.css'/>" rel="stylesheet">

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

        * { box-sizing: border-box; }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'SF Pro Text', 'Segoe UI', 'Roboto', 'Helvetica Neue', Arial, sans-serif;
            background: radial-gradient(circle at top left, #f0f4ff 0, #f8f9fc 45%, #fdfdfd 100%);
            color: var(--dark-color);
            line-height: 1.6;
        }

        a { text-decoration: none; }

        /* --- 顶部导航栏统一修复开始 --- */
        .navbar {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(16px);
            box-shadow: 0 8px 24px rgba(15, 23, 42, 0.08);
            transition: all 0.3s ease;
            
            /* 【核心修复】固定高度，杜绝抖动 */
            height: 76px; 
            padding: 0; /* 重置 padding，改用 Flex 布局垂直居中 */
        }

        /* 确保内容在 76px 高度内垂直居中 */
        .navbar > .container {
            height: 100%;
            display: flex;
            align-items: center;
        }

        .navbar-brand {
            font-weight: 800;
            font-size: 1.45rem;
            color: var(--primary-color) !important;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            height: 100%; /* 继承高度 */
            padding: 0;   /* 移除默认 padding */
            margin-right: 2rem;
        }

        .navbar-brand i {
            font-size: 1.4rem;
            color: var(--primary-dark);
            transform: translateY(-1px); /* 微调图标视觉中心 */
        }

        .navbar-nav .nav-link {
            font-weight: 600;
            color: var(--secondary-color) !important;
            padding: 0.5rem 1rem !important;
            transition: all 0.2s ease;
        }
        
        /* 配合固定 Header 的页面顶部间距调整 */
        .page-wrapper {
            padding-top: 96px; /* 增加到 96px (76px Header + 20px 间距)，防止内容被遮挡 */
            padding-bottom: 40px;
        }
        /* --- 顶部导航栏统一修复结束 --- */

        .navbar.scrolled {
            padding-top: 0.4rem;
            padding-bottom: 0.4rem;
            background: rgba(255, 255, 255, 0.98);
            box-shadow: 0 10px 30px rgba(15, 23, 42, 0.14);
        }

        .navbar-brand {
            font-weight: 800;
            font-size: 1.45rem;
            color: var(--primary-color) !important;
            display: flex;
            align-items: center;
            gap: .4rem;
        }

        .navbar-brand i {
            font-size: 1.4rem;
            color: var(--primary-dark);
        }

        .navbar-collapse {
            flex-grow: 0;
        }

        .user-dropdown-btn {
            text-decoration: none;
            font-weight: 500;
            color: var(--secondary-color) !important;
        }

        .user-dropdown-btn i { color: var(--primary-color); }

        .user-dropdown-btn:hover {
            color: var(--primary-color) !important;
        }

        /* --- 头部区域统一修复开始 --- */
        .page-wrapper {
            padding-top: 88px; /* 保持各页面顶部避让导航的高度一致 */
            padding-bottom: 40px;
        }
        
        .design-header {
            margin-bottom: 24px; /* 统一底部间距，原代码中有 18px 也有 10px */
        }

        .design-header-inner {
            background: linear-gradient(135deg, #4f46e5 0, #1d4ed8 40%, #2563eb 100%);
            border-radius: 20px;
            /* 统一内边距：上下增加到 24px，左右 28px */
            padding: 24px 28px; 
            color: #fff;
            box-shadow: 0 14px 36px rgba(37, 99, 235, 0.35);
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 1rem;
            
            /* 【核心修复】强制最小高度 */
            /* 设置为 136px 可以完美容纳文件夹页面的三行文字，同时让其他页面保持一致高度 */
            min-height: 136px; 
            box-sizing: border-box;
        }

        .design-header-title {
            margin: 0;
            font-size: 1.5rem;
            font-weight: 700;
            line-height: 1.3; /* 统一行高，防止字体差异导致微小位移 */
        }

        .design-header-subtitle {
            margin: 0.35rem 0 0;
            font-size: 0.96rem;
            opacity: 0.9;
            line-height: 1.5;
        }
        
        /* 文件夹页面特有的 meta 标签样式也需要统一定义，防止在其他页面报错（虽然没用到） */
        .design-header-meta {
            font-size: 0.85rem;
            opacity: 0.85;
            margin-top: 0.25rem;
        }
        /* --- 头部区域统一修复结束 --- */

        .badge-step {
            display: inline-flex;
            align-items: center;
            gap: .25rem;
            padding: .25rem .8rem;
            border-radius: 999px;
            border: 1px solid rgba(248, 250, 252, 0.9);
            background: rgba(15,23,42,.15);
            font-size: .8rem;
        }

        .folder-layout { margin-top: 10px; }

        /* --- 左侧导航卡片统一修复开始 --- */
        .nav-card {
            background: #ffffff;
            border-radius: 18px;
            box-shadow: 0 14px 40px rgba(15, 23, 42, 0.08);
            border: 1px solid rgba(226, 232, 240, 0.9);
            
            /* 【核心修复】统一内边距 */
            padding: 24px 20px; 
            
            /* 【核心修复】强制最小高度，防止因内容行数不同导致的侧边栏高度跳动 */
            min-height: 360px; 
            box-sizing: border-box;
        }

        .nav-card-title {
            font-weight: 700;
            font-size: 1rem; /* 统一字体大小 */
            display: flex;
            align-items: center;
            gap: 0.6rem;
            margin-bottom: 0.5rem;
            color: #111827;
        }

        .nav-card-title i {
            color: var(--primary-color);
            font-size: 1.1rem;
        }

        .nav-card-sub {
            font-size: 0.82rem;
            color: var(--muted-color);
            margin-bottom: 1.4rem; /* 增加与列表的间距 */
            line-height: 1.4;
        }

        .nav-card-menu {
            list-style: none;
            padding-left: 0;
            margin: 0;
        }

        .nav-card-menu li + li {
            margin-top: 0.6rem; /* 统一列表间距 */
        }

        .nav-link-chip {
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.6rem;
            padding: 0.65rem 1rem; /* 增大点击区域 */
            border-radius: 12px;
            font-size: 0.9rem;
            color: #4b5563;
            border: 1px solid transparent;
            background: #f9fafb;
            transition: all 0.2s ease;
        }

        .nav-link-chip i {
            font-size: 1.1rem;
            width: 22px;
            text-align: center;
            color: var(--primary-color);
        }

        .nav-link-chip:hover {
            background: #eef2ff;
            border-color: rgba(78, 115, 223, 0.45);
            color: var(--primary-color);
            transform: translateY(-1px);
        }

        .nav-link-chip.active {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            color: #fff;
            border-color: transparent;
            box-shadow: 0 8px 20px rgba(78,115,223,0.4);
        }

        .nav-link-chip.active i {
            color: #fff;
        }
        /* --- 左侧导航卡片统一修复结束 --- */

        /* 右侧主内容卡片，与创建页 content-card 统一 */
        .content-card {
            background: #ffffff;
            border-radius: 18px;
            padding: 22px 24px 20px;
            box-shadow: 0 14px 40px rgba(15, 23, 42, 0.08);
            border: 1px solid rgba(226, 232, 240, 0.9);
        }

        @media (max-width: 576px) {
            .content-card { padding: 18px 16px; }
        }

        .content-card-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 14px;
        }

        .content-card-title {
            display: flex;
            align-items: center;
            gap: .5rem;
        }

        .content-card-title-icon {
            width: 36px;
            height: 36px;
            border-radius: 12px;
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
        }

        .content-card-title-text {
            font-size: 1rem;
            font-weight: 700;
        }

        .content-card-subtitle {
            font-size: .86rem;
            color: var(--muted-color);
            margin-top: 2px;
        }

        /* Toast 通知（与创建页保持一致风格） */
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

        .toast-custom-header i { font-size: 1.1rem; }

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

        .toast-custom-close:hover { opacity: 1; }

        @keyframes slideInRight {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        @keyframes toastProgress {
            from { width: 100%; }
            to { width: 0%; }
        }

        /* 筛选栏 + 列表样式（沿用你原来的逻辑但换到 content-card 内） */
        .filter-bar {
            background: #f9fafb;
            border-radius: 12px;
            border: 1px solid var(--border-soft);
            padding: .65rem 1rem;
            margin-bottom: 0.9rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .filter-group {
            display: flex;
            align-items: center;
            gap: .6rem;
            font-size: .9rem;
            color: var(--secondary-color);
        }

        .filter-select {
            border: 1px solid var(--border-soft);
            border-radius: 999px;
            padding: .35rem .9rem;
            background: #fff;
            color: var(--dark-color);
            font-size: .9rem;
        }

        .questionnaire-card {
            background: #fff;
            border-radius: 12px;
            border: 1px solid #e5e7eb;
            margin-bottom: .7rem;
            padding: 1rem 1.1rem .9rem;
            border-left: 4px solid transparent;
            transition: all .16s ease;
        }

        .questionnaire-card:hover {
            transform: translateY(-1px);
            box-shadow: 0 12px 28px rgba(15, 23, 42, 0.12);
            border-left-color: rgba(78,115,223,.6);
        }

        .questionnaire-card.status-published {
            border-left-color: #28a745;
        }

        .questionnaire-card.status-draft {
            border-left-color: #6c757d;
        }

        .questionnaire-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: .55rem;
        }

        .questionnaire-title {
            font-size: 1.05rem;
            font-weight: 600;
            color: #111827;
            margin: 0 0 .15rem;
        }

        .questionnaire-id {
            color: #9ca3af;
            font-size: .82rem;
        }

        .questionnaire-stats {
            display: flex;
            gap: 1.2rem;
            margin: .35rem 0 .55rem;
            flex-wrap: wrap;
            font-size: .86rem;
        }

        .stat-item {
            display: inline-flex;
            align-items: center;
            gap: .35rem;
            color: #6b7280;
        }

        .stat-item i { font-size: .95rem; }

        .stat-value {
            font-weight: 600;
            color: var(--primary-color);
        }

        .questionnaire-actions {
            display: flex;
            gap: .4rem;
            flex-wrap: wrap;
        }

        .action-btn {
            padding: .32rem .85rem;
            border: 1px solid var(--border-soft);
            background: #fff;
            color: var(--dark-color);
            text-decoration: none;
            border-radius: 999px;
            font-size: .82rem;
            transition: all .16s ease;
            display: inline-flex;
            align-items: center;
            gap: .25rem;
        }

        .action-btn i { font-size: .9rem; }

        .action-btn:hover {
            background-color: #f3f4ff;
            color: var(--primary-color);
            border-color: rgba(78,115,223,.7);
        }

        .action-btn.primary {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            color: #fff;
            border-color: transparent;
        }

        .action-btn.primary:hover {
            background: linear-gradient(135deg, #4663ce, #1f3fa6);
            box-shadow: 0 10px 24px rgba(78, 115, 223, 0.4);
        }

        .action-btn.danger {
            color: #dc3545;
            border-color: rgba(220,53,69,.7);
        }

        .action-btn.danger:hover {
            background-color: #dc3545;
            color: #fff;
        }

        .status-badge {
            padding: .15rem .65rem;
            border-radius: 999px;
            font-size: .78rem;
            font-weight: 500;
        }

        .status-published {
            background-color: #d4edda;
            color: #155724;
        }

        .status-draft {
            background-color: #e2e3e5;
            color: #6c757d;
        }

        .empty-state {
            background: #f9fafb;
            border-radius: 14px;
            border: 1px dashed #d1d5db;
            padding: 2.2rem 1.6rem;
            text-align: center;
            color: #6c757d;
            margin-top: .4rem;
        }

        .empty-state .icon {
            font-size: 3rem;
            color: #e5e7eb;
            margin-bottom: .7rem;
        }

        /* 样本服务推广模块（右侧下方，风格不变） */
        .sample-service-promo { margin-top: 1rem; }

        .promo-card {
            background: linear-gradient(135deg, #e3f2fd, #bbdefb);
            border-radius: 18px;
            padding: 1.8rem 1.6rem;
            border: 1px solid #90caf9;
            position: relative;
            overflow: hidden;
        }

        .promo-card::before {
            content: '';
            position: absolute;
            top: -45%;
            right: -8%;
            width: 260px;
            height: 260px;
            background: rgba(255,255,255,0.25);
            border-radius: 50%;
        }

        .promo-icon {
            position: absolute;
            top: 1.5rem;
            right: 1.6rem;
            font-size: 2.8rem;
            color: #1976d2;
            opacity: .28;
        }

        .promo-content { position: relative; z-index: 1; }

        .promo-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: #1565c0;
            margin-bottom: .4rem;
        }

        .promo-desc {
            color: #424242;
            margin-bottom: 1.1rem;
            font-size: .95rem;
        }

        .promo-stats {
            display: flex;
            gap: 1.1rem;
            margin-bottom: 1.15rem;
            flex-wrap: wrap;
        }

        .promo-stats .stat-item {
            text-align: center;
            background: rgba(255,255,255,.8);
            padding: .75rem 1.1rem;
            border-radius: 12px;
            min-width: 110px;
        }

        .promo-stats .stat-number {
            display: block;
            font-size: 1.35rem;
            font-weight: 700;
            color: #1565c0;
        }

        .promo-stats .stat-label {
            font-size: .8rem;
            color: #546e7a;
            font-weight: 500;
        }

        .promo-btn {
            background: linear-gradient(135deg,#1976d2,#0d47a1);
            border: none;
            padding: .5rem 1.3rem;
            font-weight: 600;
            border-radius: 999px;
            font-size: .88rem;
            color: #fff;
        }

        .promo-btn i { margin-right: .3rem; }

        .promo-btn:hover {
            box-shadow: 0 5px 16px rgba(25,118,210,.45);
        }

        /* 删除模态框样式 */
        .delete-modal .modal-content {
            border-radius: 12px;
            border: none;
            box-shadow: 0 10px 30px rgba(0,0,0,.15);
            overflow: hidden;
        }

        .delete-modal .modal-header {
            background: linear-gradient(135deg,#ff6b6b,#ff5252);
            color:#fff;
            border-bottom:none;
            padding:1rem 1.3rem;
        }

        .delete-modal .modal-body {
            padding:1.8rem 1.4rem;
            text-align:center;
        }

        .delete-modal .warning-icon {
            font-size:2.6rem;
            color:#ff6b6b;
            margin-bottom:.6rem;
        }

        .delete-modal .delete-message {
            font-size:1.05rem;
            color:#2c3e50;
            margin-bottom:.4rem;
            font-weight:500;
        }

        .delete-modal .delete-hint {
            color:#6c757d;
            font-size:.88rem;
        }

        .delete-modal .modal-footer {
            border-top:1px solid #e9ecef;
            padding:.75rem 1.3rem;
            gap:.6rem;
        }

        .delete-modal .btn-cancel {
            background:#f8f9fa;
            border:1px solid #dee2e6;
            color:#6c757d;
            padding:.4rem 1.4rem;
            border-radius:999px;
            font-weight:500;
        }

        .delete-modal .btn-delete {
            background:linear-gradient(135deg,#ff6b6b,#ff5252);
            border:none;
            color:#fff;
            padding:.4rem 1.4rem;
            border-radius:999px;
            font-weight:500;
        }

        /* 分享模态框二维码容器 */
        #qrContainer {
            width: 170px;
            height: 170px;
            margin: 0 auto;
        }

        /* 文件夹选择弹窗的小卡片样式（供 moveToFolder 使用） */
        .folder-select-grid {
            display: flex;
            flex-direction: column;
            gap: .6rem;
        }

        .folder-select-card {
            display: flex;
            align-items: center;
            padding: .6rem .75rem;
            border-radius: 10px;
            border: 1px solid #e5e7eb;
            cursor: pointer;
            transition: all .16s ease;
        }

        .folder-select-card-icon {
            width: 32px;
            height: 32px;
            border-radius: 999px;
            background: #eff6ff;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: .6rem;
            color: var(--primary-color);
        }

        .folder-select-card-title {
            font-size: .95rem;
            font-weight: 600;
            color: #111827;
        }

        .folder-select-card-desc {
            font-size: .82rem;
            color: #6b7280;
        }

        .folder-select-card-check {
            margin-left: auto;
            color: var(--primary-color);
            opacity: 0;
            transition: opacity .16s ease;
        }

        .folder-select-card.active {
            border-color: rgba(78,115,223,.9);
            background: #eef2ff;
        }

        .folder-select-card.active .folder-select-card-check {
            opacity: 1;
        }

        @media (max-width: 991.98px) {
            .toast-custom {
                min-width: 260px;
                max-width: 90vw;
            }
        }
    </style>
</head>
<body>

<!-- Toast 容器 -->
<div class="toast-container" id="toastContainer" style="display:none;"></div>

<!-- 顶部导航（和创建页保持一致） -->
<nav class="navbar navbar-expand-lg navbar-light fixed-top">
    <div class="container">
        <a class="navbar-brand" href="<c:url value='/questionnaire/list'/>">
            <i class="bi bi-card-checklist"></i> 问卷星
        </a>

        <div class="navbar-collapse">
            <ul class="navbar-nav me-auto"></ul>
            <div class="d-flex align-items-center">
                <c:if test="${not empty user}">
                    <div class="dropdown">
                        <button class="btn btn-link user-dropdown-btn dropdown-toggle"
                                type="button" id="userDropdown"
                                data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-person-circle me-1"></i>${user.username}
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                            <li class="dropdown-header small text-muted px-3 py-2">
                                用户名：${user.username}<br>
                                账号ID：${user.id}<br>
                                <c:if test="${not empty user.email}">
                                    邮箱：${user.email}
                                </c:if>
                            </li>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <a class="dropdown-item" href="<c:url value='/user/profile'/>">
                                    <i class="bi bi-person-lines-fill me-1"></i>账号信息
                                </a>
                            </li>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <a class="dropdown-item text-danger" href="<c:url value='/user/logout'/>">
                                    <i class="bi bi-box-arrow-right me-1"></i>退出
                                </a>
                            </li>
                        </ul>
                    </div>
                </c:if>
                <c:if test="${empty user}">
                    <a href="<c:url value='/user/login'/>" class="btn btn-outline-primary btn-sm">
                        登录
                    </a>
                </c:if>
            </div>
        </div>
    </div>
</nav>

<div class="page-wrapper">
    <div class="container">
        <!-- 顶部大卡片：我的问卷 -->
        <section class="design-header">
            <div class="design-header-inner">
                <div>
                    <h1 class="design-header-title">我的问卷</h1>
                    <p class="design-header-subtitle mb-1">
                        统一管理你创建的所有问卷，支持状态筛选、排序、预览与统计分析。
                    </p>
                </div>
                <div class="text-end">
                    <span class="badge-step mb-2 d-inline-flex">
                        <i class="bi bi-collection"></i> 问卷管理中心
                    </span>
                    <div>
                        <a href="<c:url value='/questionnaire/create'/>"
                           class="btn btn-sm btn-light mt-2" style="border-radius:999px;">
                            <i class="bi bi-plus-lg me-1"></i> 创建问卷
                        </a>
                    </div>
                </div>
            </div>
        </section>

        <!-- 左侧导航 + 右侧列表 -->
        <section class="folder-layout">
            <div class="row g-4">
                <!-- 左侧导航卡片 -->
                <div class="col-lg-3">
                    <div class="nav-card">
                        <div class="nav-card-title">
                            <i class="bi bi-compass"></i>
                            <span>快速导航</span>
                        </div>
                        <div class="nav-card-sub">切换不同的问卷视图</div>
                        <ul class="nav-card-menu">
                            <li>
                                <a href="<c:url value='/questionnaire/create'/>"
                                   class="nav-link-chip">
                                    <i class="bi bi-plus-circle"></i> 创建问卷
                                </a>
                            </li>
                            <li>
                                <a href="<c:url value='/questionnaire/list'/>"
                                   class="nav-link-chip active">
                                    <i class="bi bi-list-ul"></i> 全部问卷
                                </a>
                            </li>
                            <li>
                                <a href="<c:url value='/questionnaire/starred'/>"
                                   class="nav-link-chip">
                                    <i class="bi bi-star"></i> 星标问卷
                                </a>
                            </li>
                            <li>
                                <a href="<c:url value='/questionnaire/folders'/>"
                                   class="nav-link-chip">
                                    <i class="bi bi-folder"></i> 文件夹
                                </a>
                            </li>
                            <li>
                                <a href="<c:url value='/questionnaire/recycle'/>"
                                   class="nav-link-chip">
                                    <i class="bi bi-trash"></i> 回收站
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>

                <!-- 右侧内容区域 -->
                <div class="col-lg-9">
                    <div class="content-card">
                        <div class="content-card-header">
                            <div class="content-card-title">
                                <div class="content-card-title-icon">
                                    <i class="bi bi-card-checklist"></i>
                                </div>
                                <div>
                                    <div class="content-card-title-text">问卷列表</div>
                                    <div class="content-card-subtitle">
                                        按状态筛选和排序，支持预览、发送、分析、星标与分类管理。
                                    </div>
                                </div>
                            </div>
                            <div class="d-none d-md-block">
                                <a href="<c:url value='/questionnaire/create'/>"
                                   class="btn btn-sm btn-primary" style="border-radius:999px;">
                                    <i class="bi bi-plus-lg me-1"></i> 创建问卷
                                </a>
                            </div>
                        </div>

                        <!-- Spring 消息改为 Toast 提示 -->
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

                        <!-- 筛选栏 -->
                        <div class="filter-bar">
                            <div class="filter-group">
                                <span>状态：</span>
                                <select class="filter-select" id="statusFilter">
                                    <option value="">全部状态</option>
                                    <option value="draft">未发布</option>
                                    <option value="published">已发布</option>
                                </select>
                            </div>
                            <div class="filter-group">
                                <span>排序：</span>
                                <select class="filter-select" id="sortFilter">
                                    <option value="time-desc">时间倒序</option>
                                    <option value="time-asc">时间正序</option>
                                    <option value="title">标题排序</option>
                                </select>
                            </div>
                        </div>

                        <!-- 问卷列表 -->
                        <div id="questionnaireListContainer">
                            <c:choose>
                                <c:when test="${not empty questionnaires}">
                                    <c:forEach items="${questionnaires}" var="q">
                                        <c:url value="/answer/fill/${q.id}" var="fillUrl"/>

                                        <div class="questionnaire-card ${q.status == 2 ? 'status-published' : 'status-draft'}">
                                            <div class="questionnaire-header">
                                                <div>
                                                    <h3 class="questionnaire-title">${q.title}</h3>
                                                    <div class="questionnaire-id">ID：${q.id}</div>
                                                </div>
                                                <div class="status-badge ${q.status == 2 ? 'status-published' : 'status-draft'}">
                                                        ${q.statusDesc}
                                                </div>
                                            </div>

                                            <div class="questionnaire-stats">
                                                <div class="stat-item">
                                                    <i class="bi bi-calendar3"></i>
                                                    <span data-create-time="${q.createTime}">
                                                        创建时间：<fmt:formatDate value="${q.createTime}" pattern="MM月dd日 HH:mm"/>
                                                    </span>
                                                </div>
                                                <div class="stat-item">
                                                    <i class="bi bi-file-text"></i>
                                                    <span>答卷：<span class="stat-value">0</span></span>
                                                </div>
                                                <div class="stat-item">
                                                    <i class="bi bi-eye"></i>
                                                    <span>浏览：<span class="stat-value">0</span></span>
                                                </div>
                                            </div>

                                            <div class="questionnaire-actions">
                                                <c:choose>
                                                    <c:when test="${pageTitle == '回收站'}">
                                                        <a href="<c:url value='/questionnaire/restore/${q.id}'/>"
                                                           class="action-btn">
                                                            <i class="bi bi-arrow-counterclockwise"></i> 恢复
                                                        </a>
                                                        <a href="<c:url value='/questionnaire/permanentdelete/${q.id}'/>"
                                                           class="action-btn danger"
                                                           onclick="showDeleteConfirm(event, 'permanent', '${q.title}')">
                                                            <i class="bi bi-trash-fill"></i> 永久删除
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:if test="${q.status == 2}">
                                                            <a href="${fillUrl}?preview=true"
                                                               class="action-btn" target="_blank">
                                                                <i class="bi bi-eye"></i> 预览问卷
                                                            </a>
                                                            <div class="dropdown">
                                                                <button class="action-btn" type="button"
                                                                        data-bs-toggle="dropdown">
                                                                    <i class="bi bi-send"></i> 发送问卷
                                                                </button>
                                                                <ul class="dropdown-menu">
                                                                    <li>
                                                                        <a class="dropdown-item" href="javascript:void(0);"
                                                                           onclick="showQRCode('${fillUrl}')">
                                                                            <i class="bi bi-qr-code me-1"></i> 二维码
                                                                        </a>
                                                                    </li>
                                                                    <li>
                                                                        <a class="dropdown-item" href="javascript:void(0);"
                                                                           onclick="copyLink('${fillUrl}')">
                                                                            <i class="bi bi-link-45deg me-1"></i> 复制链接
                                                                        </a>
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                        </c:if>

                                                        <c:if test="${q.status == 1}">
                                                            <a href="<c:url value='/questionnaire/publish/${q.id}'/>"
                                                               class="action-btn primary">
                                                                <i class="bi bi-send"></i> 发布
                                                            </a>
                                                        </c:if>

                                                        <a href="<c:url value='/questionnaire/design/${q.id}'/>"
                                                           class="action-btn">
                                                            <i class="bi bi-gear"></i> 设计问卷
                                                        </a>
                                                        <a href="<c:url value='/statistics/view/${q.id}'/>"
                                                           class="action-btn">
                                                            <i class="bi bi-pie-chart"></i> 分析&下载
                                                        </a>

                                                        <c:if test="${q.createdBy == user.id || user.role == 'admin' || user.role == 'administrator'}">
                                                            <c:choose>
                                                                <c:when test="${q.isStarred == 0}">
                                                                    <a href="<c:url value='/questionnaire/star/${q.id}'/>"
                                                                       class="action-btn">
                                                                        <i class="bi bi-star"></i> 星标
                                                                    </a>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <a href="<c:url value='/questionnaire/unstar/${q.id}'/>"
                                                                       class="action-btn">
                                                                        <i class="bi bi-star-fill" style="color:#ffc107;"></i> 取消星标
                                                                    </a>
                                                                </c:otherwise>
                                                            </c:choose>

                                                            <a href="<c:url value='/questionnaire/edit/${q.id}'/>"
                                                               class="action-btn">
                                                                <i class="bi bi-pencil"></i> 编辑
                                                            </a>
                                                            <a href="javascript:void(0);" class="action-btn"
                                                               onclick="copyQuestionnaire(${q.id})">
                                                                <i class="bi bi-files"></i> 复制
                                                            </a>
                                                            <a href="javascript:void(0);" class="action-btn"
                                                               onclick="moveToFolder(${q.id})">
                                                                <i class="bi bi-tag"></i> 分类
                                                            </a>
                                                            <a href="<c:url value='/questionnaire/softdelete/${q.id}'/>"
                                                               class="action-btn danger"
                                                               onclick="showDeleteConfirm(event, 'soft', '${q.title}')">
                                                                <i class="bi bi-trash"></i> 删除
                                                            </a>
                                                        </c:if>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="empty-state" id="filterEmptyState">
                                        <div class="icon"><i class="bi bi-journal-x"></i></div>
                                        <h4>暂无问卷</h4>
                                        <p class="text-muted mb-3">
                                            点击右上角「创建问卷」按钮，开始你的第一次创建吧！
                                        </p>
                                        <a href="<c:url value='/questionnaire/create'/>"
                                           class="btn btn-primary" style="border-radius:999px;">
                                            <i class="bi bi-plus-lg me-1"></i> 创建问卷
                                        </a>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- 样本服务推广模块（保留原样，只是跟整体风格统一） -->
                    <div class="sample-service-promo">
                        <div class="promo-card">
                            <div class="promo-icon">
                                <i class="bi bi-people-fill"></i>
                            </div>
                            <div class="promo-content">
                                <h5 class="promo-title">使用问卷星样本服务，快速回收高质量答卷</h5>
                                <p class="promo-desc">已精准收集超过 5800 万样本，登记人群需求，助您快速完成调研目标。</p>
                                <div class="promo-stats">
                                    <div class="stat-item">
                                        <span class="stat-number">5800万+</span>
                                        <span class="stat-label">精准样本</span>
                                    </div>
                                    <div class="stat-item">
                                        <span class="stat-number">95%</span>
                                        <span class="stat-label">有效回收率</span>
                                    </div>
                                    <div class="stat-item">
                                        <span class="stat-number">24小时</span>
                                        <span class="stat-label">快速回收</span>
                                    </div>
                                </div>
                                <button class="promo-btn" type="button">
                                    <i class="bi bi-clipboard-data"></i> 登记人群需求
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>

<!-- 删除确认模态框 -->
<div class="modal fade delete-modal" id="deleteConfirmModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                    <span id="modalTitle">确认删除</span>
                </h5>
            </div>
            <div class="modal-body">
                <div class="warning-icon">
                    <i class="bi bi-exclamation-circle"></i>
                </div>
                <div class="delete-message" id="deleteMessage">确定要删除此问卷吗？</div>
                <div class="delete-hint" id="deleteHint">删除后可在回收站恢复。</div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-cancel" data-bs-dismiss="modal">
                    <i class="bi bi-x-lg me-1"></i>取消
                </button>
                <button type="button" class="btn btn-delete" id="confirmDeleteBtn">
                    <i class="bi bi-trash-fill me-1"></i><span id="confirmBtnText">确认删除</span>
                </button>
            </div>
        </div>
    </div>
</div>

<!-- 永久删除验证模态框 -->
<div class="modal fade delete-modal" id="permanentDeleteVerifyModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                    永久删除验证
                </h5>
            </div>
            <div class="modal-body">
                <div class="warning-icon">
                    <i class="bi bi-exclamation-circle"></i>
                </div>
                <div class="delete-message" id="verifyMessage">请手动输入问卷标题</div>
                <div class="delete-hint" style="color:#dc3545;">此操作不可恢复，请谨慎操作！</div>
                <div class="input-verify-area mt-3">
                    <input type="text" class="form-control" id="permanentVerifyInput" placeholder="请输入问卷标题">
                    <div class="alert alert-danger mt-2" id="verifyErrorAlert"
                         style="display:none;font-size:.86rem;padding:.4rem .9rem;">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>
                        <span id="verifyErrorText">输入错误，请重新输入问卷标题！</span>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-cancel" data-bs-dismiss="modal">取消</button>
                <button type="button" class="btn btn-delete" id="permanentConfirmBtn">
                    <span id="permanentConfirmBtnText">完成验证</span>
                </button>
            </div>
        </div>
    </div>
</div>

<!-- 分享问卷模态框 -->
<div class="modal fade" id="shareModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="bi bi-share me-2"></i> 分享问卷
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="row g-3 align-items-center">
                    <div class="col-md-5 text-center">
                        <div id="qrContainer"></div>
                        <small class="text-muted d-block mt-2">手机扫码即可填写</small>
                    </div>
                    <div class="col-md-7">
                        <label class="form-label mb-1">问卷链接</label>
                        <div class="input-group mb-2">
                            <input type="text" class="form-control" id="shareLinkInput" readonly>
                            <button class="btn btn-primary" type="button" id="shareCopyBtn">
                                <i class="bi bi-clipboard me-1"></i>复制
                            </button>
                        </div>
                        <div class="alert alert-info py-2 px-3 mb-0 d-none"
                             id="shareCopyAlert" style="font-size:.86rem;">
                            <i class="bi bi-check-circle-fill me-1"></i>
                            链接已复制，可以直接分享～
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="<c:url value='/resources/js/bootstrap/bootstrap.bundle.min.js'/>"></script>
<script src="https://cdn.jsdelivr.net/npm/qrcodejs/qrcode.min.js"></script>
<script>
    // 顶部导航滚动效果（与创建页相同）
    const navbar = document.querySelector('.navbar');
    window.addEventListener('scroll', function () {
        if (window.scrollY > 50) navbar.classList.add('scrolled');
        else navbar.classList.remove('scrolled');
    });

    // Toast 显示
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

    // 分享相关
    let currentShareLink = '';

    function openShareModal(link) {
        currentShareLink = link || '';
        const input = document.getElementById('shareLinkInput');
        const alertBox = document.getElementById('shareCopyAlert');
        const qrContainer = document.getElementById('qrContainer');
        if (input) input.value = currentShareLink;
        if (alertBox) alertBox.classList.add('d-none');
        if (qrContainer) {
            qrContainer.innerHTML = '';
            if (currentShareLink) {
                new QRCode(qrContainer, {
                    text: currentShareLink,
                    width: 170,
                    height: 170
                });
            }
        }
        const modalEl = document.getElementById('shareModal');
        if (modalEl) bootstrap.Modal.getOrCreateInstance(modalEl).show();
    }

    function showQRCode(link) { openShareModal(link); }

    function copyLink(link) {
        if (link) currentShareLink = link;
        if (!currentShareLink) return;

        const doCopy = (text) => {
            if (navigator.clipboard && navigator.clipboard.writeText) {
                return navigator.clipboard.writeText(text);
            } else {
                const input = document.createElement('input');
                input.value = text;
                document.body.appendChild(input);
                input.select();
                document.execCommand('copy');
                document.body.removeChild(input);
                return Promise.resolve();
            }
        };

        doCopy(currentShareLink).then(() => {
            const modalEl = document.getElementById('shareModal');
            if (modalEl && !modalEl.classList.contains('show')) {
                openShareModal(currentShareLink);
            }
            const alertBox = document.getElementById('shareCopyAlert');
            if (alertBox) {
                alertBox.classList.remove('d-none');
                setTimeout(() => alertBox.classList.add('d-none'), 2200);
            }
        }).catch(err => {
            console.error('复制失败:', err);
            alert('复制失败，请手动复制链接。');
        });
    }

    // 删除相关
    let pendingDeleteUrl = null;
    let pendingPermanentUrl = null;
    let pendingPermanentTitle = '';

    function showDeleteConfirm(ev, type, title) {
        ev.preventDefault();
        const link = ev.currentTarget;
        const href = link.getAttribute('href');
        if (!href) return;

        if (type === 'soft') {
            pendingDeleteUrl = href;
            const modalEl = document.getElementById('deleteConfirmModal');
            if (!modalEl) {
                window.location.href = href;
                return;
            }
            document.getElementById('modalTitle').textContent = '确认删除问卷';
            document.getElementById('deleteMessage').textContent = '确定要删除问卷「' + title + '」吗？';
            document.getElementById('deleteHint').textContent = '删除后可在回收站恢复。';
            document.getElementById('confirmBtnText').textContent = '确认删除';
            bootstrap.Modal.getOrCreateInstance(modalEl).show();
        } else if (type === 'permanent') {
            pendingPermanentUrl = href;
            pendingPermanentTitle = title || '';
            const input = document.getElementById('permanentVerifyInput');
            const alertBox = document.getElementById('verifyErrorAlert');
            if (input) input.value = '';
            if (alertBox) alertBox.style.display = 'none';

            const modalEl = document.getElementById('permanentDeleteVerifyModal');
            if (!modalEl) {
                window.location.href = href;
                return;
            }
            bootstrap.Modal.getOrCreateInstance(modalEl).show();
        }
    }

    function copyQuestionnaire(id) {
        if (confirm('确定要复制这份问卷吗？')) {
            alert('复制问卷功能开发中，问卷ID: ' + id);
        }
    }

    // 文件夹分类相关
    function moveToFolder(questionnaireId) {
        const old = document.getElementById('folderSelectModal');
        if (old) old.remove();
        const modal = document.createElement('div');
        modal.className = 'modal fade show';
        modal.id = 'folderSelectModal';
        modal.style.display = 'block';
        modal.style.backgroundColor = 'rgba(0,0,0,.5)';
        modal.innerHTML =
            '<div class="modal-dialog modal-dialog-centered">' +
            ' <div class="modal-content">' +
            '  <div class="modal-header">' +
            '    <h5 class="modal-title"><i class="bi bi-folder me-2"></i>选择文件夹</h5>' +
            '    <button type="button" class="btn-close" onclick="closeFolderModal()"></button>' +
            '  </div>' +
            '  <div class="modal-body">' +
            '    <div class="text-center py-4">' +
            '      <div class="spinner-border text-primary" role="status"><span class="visually-hidden">加载中...</span></div>' +
            '      <p class="mt-2 text-muted">正在加载文件夹...</p>' +
            '    </div>' +
            '  </div>' +
            ' </div>' +
            '</div>';
        document.body.appendChild(modal);

        fetch('/folder/api/list')
            .then(r => r.json())
            .then(data => {
                if (!data || !data.success) {
                    alert('获取文件夹失败：' + (data && data.message ? data.message : '未知错误'));
                    closeFolderModal();
                    return;
                }
                const folders = data.folders || [];
                let html = '';
                if (folders.length > 0) {
                    folders.forEach(f => {
                        const cnt = f.questionnaireCount != null ? f.questionnaireCount : 0;
                        const desc = (f.name === '未分类'
                            ? '系统默认文件夹，当前包含 ' + cnt + ' 份问卷'
                            : '当前包含 ' + cnt + ' 份问卷');
                        const icon = (f.name === '未分类' ? 'bi-inbox-fill' : 'bi-folder2');
                        html +=
                            '<div class="folder-select-card" data-id="' + f.id + '">' +
                            '  <div class="folder-select-card-icon"><i class="bi ' + icon + '"></i></div>' +
                            '  <div>' +
                            '    <div class="folder-select-card-title">' + f.name + '</div>' +
                            '    <div class="folder-select-card-desc">' + desc + '</div>' +
                            '  </div>' +
                            '  <div class="folder-select-card-check"><i class="bi bi-check-lg"></i></div>' +
                            '</div>';
                    });
                } else {
                    html =
                        '<div class="alert alert-light border" role="alert">' +
                        ' <i class="bi bi-info-circle me-1"></i>暂无文件夹，请先在下方创建一个新的文件夹。' +
                        '</div>';
                }

                modal.innerHTML =
                    '<div class="modal-dialog modal-dialog-centered">' +
                    ' <div class="modal-content">' +
                    '  <div class="modal-header">' +
                    '    <h5 class="modal-title"><i class="bi bi-folder me-2"></i>选择文件夹</h5>' +
                    '    <button type="button" class="btn-close" onclick="closeFolderModal()"></button>' +
                    '  </div>' +
                    '  <div class="modal-body">' +
                    '    <div class="mb-3">' +
                    '      <label class="form-label fw-semibold">请选择要移动到的文件夹：</label>' +
                    '      <div class="folder-select-grid" id="folderSelectGrid">' + html + '</div>' +
                    '    </div>' +
                    '    <hr class="my-3">' +
                    '    <div>' +
                    '      <h6 class="mb-2"><i class="bi bi-plus-circle me-2"></i>创建新文件夹</h6>' +
                    '      <div class="input-group">' +
                    '        <input type="text" class="form-control" id="newFolderName" placeholder="输入新文件夹名称">' +
                    '        <button class="btn btn-outline-primary" type="button" onclick="createNewFolder()">' +
                    '          <i class="bi bi-plus-lg me-1"></i>创建' +
                    '        </button>' +
                    '      </div>' +
                    '      <div class="form-text">快速创建新的文件夹分类。</div>' +
                    '      <div id="createFolderAlert" class="mt-2" style="display:none;"></div>' +
                    '    </div>' +
                    '    <div class="alert alert-info mt-3 mb-0" style="font-size:.86rem;">' +
                    '      <i class="bi bi-info-circle-fill me-1"></i>先选择上方文件夹，再点击“确定”完成移动。' +
                    '    </div>' +
                    '  </div>' +
                    '  <div class="modal-footer">' +
                    '    <button type="button" class="btn btn-cancel" onclick="closeFolderModal()">取消</button>' +
                    '    <button type="button" class="btn btn-primary" onclick="confirmMoveToFolder(' + questionnaireId + ')">' +
                    '      <i class="bi bi-check-lg me-1"></i>确定' +
                    '    </button>' +
                    '  </div>' +
                    ' </div>' +
                    '</div>';

                const grid = document.getElementById('folderSelectGrid');
                if (grid) {
                    const cards = grid.querySelectorAll('.folder-select-card');
                    cards.forEach(c => {
                        c.addEventListener('click', function () {
                            cards.forEach(x => x.classList.remove('active'));
                            this.classList.add('active');
                        });
                    });
                }
            })
            .catch(e => {
                console.error('获取文件夹失败:', e);
                alert('获取文件夹失败，请稍后重试。');
                closeFolderModal();
            });
    }

    function closeFolderModal() {
        const modal = document.getElementById('folderSelectModal');
        if (modal) modal.remove();
    }

    function createNewFolder() {
        const folderNameInput = document.getElementById('newFolderName');
        const folderName = folderNameInput ? folderNameInput.value.trim() : '';
        const alertDiv = document.getElementById('createFolderAlert');

        if (!alertDiv) return;
        alertDiv.style.display = 'none';

        if (!folderName) {
            alertDiv.className = 'alert alert-danger mt-2';
            alertDiv.innerHTML = '<i class="bi bi-exclamation-circle-fill me-2"></i>请输入文件夹名称';
            alertDiv.style.display = 'block';
            if (folderNameInput) folderNameInput.focus();
            return;
        }

        fetch('/folder/api/create', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({name: folderName})
        })
            .then(r => r.json())
            .then(data => {
                if (!data || !data.success) {
                    alertDiv.className = 'alert alert-danger mt-2';
                    alertDiv.innerHTML =
                        '<i class="bi bi-exclamation-circle-fill me-2"></i>' +
                        (data && data.message ? data.message : '创建文件夹失败，请稍后重试');
                    alertDiv.style.display = 'block';
                    return;
                }

                const folder = data.folder || {};
                const newId = folder.id;
                const newName = folder.name;

                if (!newId || !newName) {
                    alertDiv.className = 'alert alert-warning mt-2';
                    alertDiv.innerHTML =
                        '<i class="bi bi-exclamation-circle-fill me-2"></i>文件夹已创建，但返回数据不完整，请检查后端。';
                    alertDiv.style.display = 'block';
                    return;
                }

                alertDiv.className = 'alert alert-success mt-2';
                alertDiv.innerHTML = '<i class="bi bi-check-circle-fill me-2"></i>文件夹创建成功！';
                alertDiv.style.display = 'block';

                if (folderNameInput) folderNameInput.value = '';

                const grid = document.getElementById('folderSelectGrid');
                if (grid) {
                    const cards = grid.querySelectorAll('.folder-select-card');
                    cards.forEach(c => c.classList.remove('active'));

                    const card = document.createElement('div');
                    card.className = 'folder-select-card active';
                    card.setAttribute('data-id', newId);
                    card.innerHTML = `
                        <div class="folder-select-card-icon">
                            <i class="bi bi-folder2"></i>
                        </div>
                        <div>
                            <div class="folder-select-card-title">${newName}</div>
                            <div class="folder-select-card-desc">当前包含 0 份问卷</div>
                        </div>
                        <div class="folder-select-card-check">
                            <i class="bi bi-check-lg"></i>
                        </div>
                    `;
                    card.addEventListener('click', function () {
                        const all = grid.querySelectorAll('.folder-select-card');
                        all.forEach(c => c.classList.remove('active'));
                        this.classList.add('active');
                    });
                    grid.appendChild(card);
                }

                setTimeout(() => {
                    alertDiv.style.display = 'none';
                }, 3000);
            })
            .catch(error => {
                console.error('创建文件夹失败:', error);
                alertDiv.className = 'alert alert-danger mt-2';
                alertDiv.innerHTML =
                    '<i class="bi bi-exclamation-circle-fill me-2"></i>创建文件夹失败，请稍后重试';
                alertDiv.style.display = 'block';
            });
    }

    function confirmMoveToFolder(questionnaireId) {
        const grid = document.getElementById('folderSelectGrid');
        if (!grid) return;
        const active = grid.querySelector('.folder-select-card.active');
        if (!active) {
            alert('请先选择一个文件夹');
            return;
        }
        const folderId = active.getAttribute('data-id');
        if (!folderId) {
            alert('文件夹信息异常，请重试');
            return;
        }
        window.location.href = '/questionnaire/moveToFolder?questionnaireId=' + questionnaireId + '&folderId=' + folderId;
    }

    // 筛选 + 排序
    function filterAndSortQuestionnaires() {
        const statusFilter = document.getElementById('statusFilter');
        const sortFilter = document.getElementById('sortFilter');
        const listContainer = document.getElementById('questionnaireListContainer');
        if (!statusFilter || !sortFilter || !listContainer) return;

        const cards = Array.from(listContainer.querySelectorAll('.questionnaire-card'));
        if (cards.length === 0) return;

        const statusValue = statusFilter.value;
        const sortValue = sortFilter.value;

        cards.forEach(card => {
            const statusText = card.querySelector('.status-badge').textContent.trim();
            let show = true;
            if (statusValue === 'draft') show = statusText === '草稿';
            else if (statusValue === 'published') show = statusText === '已发布';
            card.style.display = show ? '' : 'none';
        });

        const visible = cards.filter(card => card.style.display !== 'none');

        visible.sort((a, b) => {
            switch (sortValue) {
                case 'time-desc': {
                    const tA = a.querySelector('[data-create-time]').getAttribute('data-create-time') || '';
                    const tB = b.querySelector('[data-create-time]').getAttribute('data-create-time') || '';
                    return new Date(tB.replace(' ', 'T')) - new Date(tA.replace(' ', 'T'));
                }
                case 'time-asc': {
                    const tA2 = a.querySelector('[data-create-time]').getAttribute('data-create-time') || '';
                    const tB2 = b.querySelector('[data-create-time]').getAttribute('data-create-time') || '';
                    return new Date(tA2.replace(' ', 'T')) - new Date(tB2.replace(' ', 'T'));
                }
                case 'title': {
                    const ta = a.querySelector('.questionnaire-title').textContent.trim().toLowerCase();
                    const tb = b.querySelector('.questionnaire-title').textContent.trim().toLowerCase();
                    return ta.localeCompare(tb);
                }
                default:
                    return 0;
            }
        });

        const oldEmpty = document.getElementById('filterEmptyState');
        if (oldEmpty) oldEmpty.remove();

        visible.forEach(card => listContainer.appendChild(card));

        if (visible.length === 0) {
            const empty = document.createElement('div');
            empty.className = 'empty-state';
            empty.id = 'filterEmptyState';

            const statusText = statusValue === 'draft' ? '草稿' : (statusValue === 'published' ? '已发布' : '');
            let title = '暂无问卷';
            let msg = '没有找到符合条件的问卷。';

            if (statusText === '草稿') {
                title = '暂无草稿问卷';
                msg = '创建新的问卷或编辑已有问卷后再试试。';
            } else if (statusText === '已发布') {
                title = '暂无已发布问卷';
                msg = '发布问卷后即可在此查看。';
            }

            empty.innerHTML =
                '<div class="icon"><i class="bi bi-journal-x"></i></div>' +
                '<h4>' + title + '</h4>' +
                '<p class="text-muted mb-3">' + msg + '</p>';

            listContainer.appendChild(empty);
        }
    }

    function formatTime(timeStr) {
        if (!timeStr || timeStr === 'Invalid Date') return '时间未知';
        const normalized = timeStr.toString().replace(' ', 'T');
        const d = new Date(normalized);
        if (isNaN(d.getTime())) return '时间未知';
        const now = new Date();
        const diff = now - d;
        const days = Math.floor(diff / (1000*60*60*24));
        if (days < 0) {
            return d.toLocaleDateString('zh-CN',{year:'numeric',month:'numeric',day:'numeric',hour:'2-digit',minute:'2-digit'});
        } else if (days === 0) {
            return '今天 ' + d.toLocaleTimeString('zh-CN',{hour:'2-digit',minute:'2-digit'});
        } else if (days === 1) {
            return '昨天 ' + d.toLocaleTimeString('zh-CN',{hour:'2-digit',minute:'2-digit'});
        } else if (days < 7) {
            return days + '天前';
        } else {
            return d.toLocaleDateString('zh-CN',{year:'numeric',month:'numeric',day:'numeric',hour:'2-digit',minute:'2-digit'});
        }
    }

    document.addEventListener('DOMContentLoaded', function () {
        const copyBtn = document.getElementById('shareCopyBtn');
        if (copyBtn) copyBtn.addEventListener('click', () => copyLink(currentShareLink));

        const statusFilter = document.getElementById('statusFilter');
        const sortFilter = document.getElementById('sortFilter');
        if (statusFilter && sortFilter) {
            statusFilter.addEventListener('change', filterAndSortQuestionnaires);
            sortFilter.addEventListener('change', filterAndSortQuestionnaires);
        }

        document.querySelectorAll('[data-create-time]').forEach(function(span) {
            const t = span.getAttribute('data-create-time');
            if (t && t !== 'Invalid Date') {
                span.textContent = '创建时间：' + formatTime(t);
            }
        });

        const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');
        if (confirmDeleteBtn) {
            confirmDeleteBtn.addEventListener('click', function () {
                if (pendingDeleteUrl) {
                    window.location.href = pendingDeleteUrl;
                }
            });
        }

        const permanentConfirmBtn = document.getElementById('permanentConfirmBtn');
        if (permanentConfirmBtn) {
            permanentConfirmBtn.addEventListener('click', function () {
                const input = document.getElementById('permanentVerifyInput');
                const alertBox = document.getElementById('verifyErrorAlert');
                if (!input) return;
                const v = input.value.trim();
                if (!v || v !== (pendingPermanentTitle || '').trim()) {
                    if (alertBox) {
                        alertBox.style.display = 'block';
                    } else {
                        alert('输入的标题不正确，请重新输入。');
                    }
                    return;
                }
                if (pendingPermanentUrl) {
                    window.location.href = pendingPermanentUrl;
                }
            });
        }
    });
</script>
</body>
</html>
