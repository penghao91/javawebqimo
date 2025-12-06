<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>文件夹管理 - 问卷系统</title>

    <link href="/resources/css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link href="/resources/css/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">

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

        /* 顶部导航（和 design.jsp 一致） */
        .navbar {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(16px);
            box-shadow: 0 8px 24px rgba(15, 23, 42, 0.08);
            transition: all 0.3s ease;
            padding-top: 0.75rem;
            padding-bottom: 0.75rem;
        }

        .navbar.scrolled {
            padding-top: 0.45rem;
            padding-bottom: 0.45rem;
            background: rgba(255, 255, 255, 0.98);
            box-shadow: 0 10px 30px rgba(15, 23, 42, 0.14);
        }

        .navbar-brand {
            font-weight: 800;
            font-size: 1.45rem;
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

        /* 保留你原来的下拉按钮，只是改一下颜色适配浅色背景 */
        .user-dropdown-btn {
            text-decoration: none;
            font-weight: 500;
            color: var(--secondary-color) !important;
        }
        .user-dropdown-btn i {
            color: var(--primary-color);
        }
        .user-dropdown-btn:hover {
            color: var(--primary-color) !important;
        }

        .custom-toggler {
            border: none;
            padding: 0.25rem;
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

        /* 整体框架 */
        .page-wrapper {
            padding-top: 88px;
            padding-bottom: 40px;
        }

        /* 顶部标题条：复用 design-header 风格 */
        .design-header {
            margin-bottom: 18px;
        }

        .design-header-inner {
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

        .design-header-title {
            margin: 0;
            font-size: 1.5rem;
            font-weight: 700;
        }

        .design-header-subtitle {
            margin: .25rem 0 0;
            font-size: .96rem;
            opacity: .9;
        }

        .design-header-meta {
            font-size: .85rem;
            opacity: .9;
        }

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

        .badge-step i {
            font-size: .9rem;
        }

        .btn-outline-light.btn-sm {
            border-radius: 999px;
            font-size: .85rem;
            padding: .3rem .9rem;
        }

        /* 文件夹布局（左导航+右内容） */
        .folder-layout {
            margin-top: 10px;
        }

        /* 左侧导航卡片 */
        .nav-card {
            background: #ffffff;
            border-radius: 18px;
            padding: 14px 14px 10px;
            box-shadow: 0 14px 40px rgba(15, 23, 42, 0.08);
            border: 1px solid rgba(226, 232, 240, 0.9);
        }

        .nav-card-title {
            font-weight: 700;
            font-size: .95rem;
            display: flex;
            align-items: center;
            gap: .35rem;
            margin-bottom: 8px;
        }

        .nav-card-title i {
            color: var(--primary-color);
        }

        .nav-card-sub {
            font-size: .8rem;
            color: var(--muted-color);
            margin-bottom: .6rem;
        }

        .nav-card-menu {
            list-style: none;
            padding-left: 0;
            margin: 0;
        }

        .nav-card-menu li + li {
            margin-top: .25rem;
        }

        .nav-link-chip {
            display: flex;
            align-items: center;
            gap: .35rem;
            padding: .42rem .75rem;
            border-radius: 999px;
            font-size: .86rem;
            color: #4b5563;
            border: 1px solid transparent;
            background: #f9fafb;
            transition: all .15s ease;
        }

        .nav-link-chip i {
            font-size: 1rem;
            width: 18px;
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
            box-shadow: 0 10px 24px rgba(78,115,223,0.55);
        }

        .nav-link-chip.active i {
            color: #fff;
        }

        /* 右侧：文件夹列表卡片容器 */
        .folders-card {
            background: #ffffff;
            border-radius: 18px;
            padding: 16px 16px 14px;
            box-shadow: 0 14px 40px rgba(15, 23, 42, 0.08);
            border: 1px solid rgba(226, 232, 240, 0.9);
        }

        .folders-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: .6rem;
            margin-bottom: 6px;
        }

        .folders-header-title {
            display: flex;
            align-items: center;
            gap: .4rem;
            font-weight: 700;
            font-size: .95rem;
        }

        .folders-header-title i {
            color: var(--primary-color);
        }

        .folders-header-meta {
            font-size: .8rem;
            color: var(--muted-color);
        }

        .btn-create-folder-top {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            border: none;
            color: #fff;
            font-size: .86rem;
            border-radius: 999px;
            padding: .35rem .95rem;
            display: inline-flex;
            align-items: center;
            gap: .25rem;
            box-shadow: 0 10px 22px rgba(78,115,223,0.40);
            transition: all .18s ease;
        }

        .btn-create-folder-top:hover {
            box-shadow: 0 12px 26px rgba(78,115,223,0.55);
            transform: translateY(-1px);
        }

        /* 单个文件夹卡片 */
        .folder-card {
            background: #ffffff;
            border-radius: 14px;
            padding: 12px 12px 10px;
            border: 1px solid var(--border-soft);
            margin-bottom: 10px;
            transition: box-shadow .18s ease, transform .18s ease, border-color .18s ease;
        }

        .folder-card:hover {
            box-shadow: 0 6px 18px rgba(15, 23, 42, 0.08);
            border-color: rgba(78,115,223,0.35);
            transform: translateY(-1px);
        }

        .folder-header-row {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: .8rem;
        }

        .folder-title {
            font-size: 1rem;
            font-weight: 700;
            color: #111827;
            display: flex;
            align-items: center;
            gap: .45rem;
            margin-bottom: 3px;
        }

        .folder-title i {
            font-size: 1.2rem;
        }

        .folder-sub {
            font-size: .82rem;
            color: var(--muted-color);
        }

        .folder-badge-default {
            display: inline-flex;
            align-items: center;
            gap: .25rem;
            font-size: 0.75rem;
            padding: 0.12rem 0.6rem;
            border-radius: 999px;
            background: rgba(251, 191, 36, 0.12);
            color: #b45309;
        }

        .folder-stats {
            display: flex;
            flex-wrap: wrap;
            gap: 1.4rem;
            margin-top: .6rem;
            font-size: .86rem;
        }

        .stat-item {
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            color: #6b7280;
        }

        .stat-item i {
            color: var(--primary-color);
        }

        .stat-value {
            font-weight: 600;
            color: var(--primary-color);
        }

        .folder-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 0.35rem;
        }

        .action-btn {
            padding: 0.32rem 0.8rem;
            border-radius: 999px;
            border: 1px solid var(--border-soft);
            background: #ffffff;
            font-size: 0.82rem;
            color: #4b5563;
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
            transition: all 0.15s ease;
        }

        .action-btn i {
            font-size: 0.95rem;
        }

        .action-btn:hover {
            background: #eef2ff;
            border-color: rgba(78,115,223,0.7);
            color: var(--primary-color);
            transform: translateY(-1px);
        }

        .action-btn.danger {
            border-color: #ef4444;
            color: #dc2626;
        }

        .action-btn.danger:hover {
            background: #ef4444;
            color: #ffffff;
        }

        /* 空状态：沿用 design.jsp 风格 */
        .empty-state {
            padding: 3rem 1rem;
            text-align: center;
            color: #858796;
            border: 2px dashed var(--border-soft);
            border-radius: 0.75rem;
            background: #f9fafb;
        }
        .empty-state .icon {
            font-size: 3.2rem;
            color: #cbd5f5;
            margin-bottom: 1rem;
        }

        /* alert 美化 */
        .alert {
            border-radius: 12px;
            border: 1px solid transparent;
            box-shadow: 0 8px 22px rgba(15,23,42,.08);
        }

        /* 顶部右侧提醒容器（你原来的 toast 风格） */
        #alert-container {
            position: fixed;
            top: 80px;
            right: 20px;
            z-index: 1055;
            width: 360px;
        }
        .pretty-alert {
            border-radius: 12px;
            border: none;
            box-shadow: 0 8px 30px rgba(15, 23, 42, 0.2);
            padding: 0.85rem 1rem;
            display: flex;
            align-items: center;
            gap: 0.6rem;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
        }
        .pretty-alert i {
            font-size: 1.1rem;
        }

        /* 模态框：复用之前文件夹页面的样式，略调圆角以统一 */
        .folder-modal .modal-content,
        .delete-modal .modal-content {
            border-radius: 16px;
            border: none;
            box-shadow: 0 16px 40px rgba(15, 23, 42, 0.35);
            overflow: hidden;
        }

        .folder-modal .modal-header {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            color: white;
            border-bottom: none;
            padding: 1.1rem 1.5rem;
        }
        .folder-modal .modal-title {
            font-weight: 600;
            font-size: 1.05rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .folder-modal .modal-body {
            padding: 1.6rem 1.5rem 1.2rem;
        }
        .folder-modal .modal-footer {
            border-top: 1px solid #e5e7eb;
            padding: 0.85rem 1.5rem;
            gap: 0.7rem;
        }
        .folder-modal .folder-icon {
            width: 48px;
            height: 48px;
            border-radius: 16px;
            background: rgba(78,115,223,0.08);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 0.75rem;
        }
        .folder-modal .folder-icon i {
            font-size: 1.8rem;
            color: var(--primary-color);
        }
        .folder-modal .input-label {
            font-weight: 600;
            font-size: 0.9rem;
            margin-bottom: 0.3rem;
        }
        .folder-modal .form-control {
            border-radius: 12px;
            border: 1px solid var(--border-soft);
            font-size: 0.9rem;
            padding: 0.5rem 0.75rem;
        }
        .folder-modal .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 1px rgba(78,115,223,0.35);
        }
        .folder-modal .btn-cancel,
        .delete-modal .btn-cancel {
            background: #f9fafb;
            border: 1px solid #e5e7eb;
            color: #4b5563;
            padding: 0.45rem 1.5rem;
            border-radius: 999px;
            font-weight: 500;
            font-size: 0.9rem;
            transition: all 0.2s ease;
        }
        .folder-modal .btn-cancel:hover,
        .delete-modal .btn-cancel:hover {
            background: #e5e7eb;
        }
        .folder-modal .btn-save {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            border: none;
            color: white;
            padding: 0.45rem 1.6rem;
            border-radius: 999px;
            font-weight: 600;
            font-size: 0.9rem;
            transition: all 0.2s ease;
        }
        .folder-modal .btn-save:hover {
            box-shadow: 0 10px 24px rgba(78,115,223,0.45);
            transform: translateY(-1px);
        }

        .delete-modal .modal-header {
            background: linear-gradient(135deg, #f97373, #ef4444);
            color: white;
            border-bottom: none;
            padding: 1.1rem 1.5rem;
        }
        .delete-modal .modal-title {
            font-weight: 600;
            font-size: 1.05rem;
        }
        .delete-modal .modal-body {
            padding: 1.9rem 1.8rem 1.4rem;
            text-align: center;
        }
        .delete-modal .warning-icon {
            font-size: 2.6rem;
            color: #ef4444;
            margin-bottom: 0.8rem;
        }
        .delete-modal .delete-message {
            font-size: 1.05rem;
            color: #111827;
            margin-bottom: 0.4rem;
            font-weight: 600;
        }
        .delete-modal .delete-hint {
            color: #6b7280;
            font-size: 0.86rem;
        }
        .delete-modal .modal-footer {
            border-top: 1px solid #e5e7eb;
            padding: 0.9rem 1.5rem;
            gap: 0.8rem;
        }
        .delete-modal .btn-delete {
            background: linear-gradient(135deg, #f97373, #ef4444);
            border: none;
            color: white;
            padding: 0.45rem 1.5rem;
            border-radius: 999px;
            font-weight: 600;
            font-size: 0.9rem;
            transition: all 0.2s ease;
        }
        .delete-modal .btn-delete:hover {
            box-shadow: 0 10px 24px rgba(239,68,68,0.45);
            transform: translateY(-1px);
        }

        @media (max-width: 991.98px) {
            .navbar-collapse {
                background: #ffffff;
                padding: 0.8rem 0 1rem;
            }
            .design-header-inner {
                flex-direction: column;
                align-items: flex-start;
            }
        }

        @media (max-width: 768px) {
            .folder-layout {
                margin-top: 14px;
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

        /* 1. 去掉移动端的那条蓝色下划线 */
        @media (max-width: 991.98px) {
            .navbar-nav .nav-link::after {
                content: none !important;
                display: none !important;
                width: 0 !important;
                height: 0 !important;
            }
        }

        /* 2. 移动端折叠导航改成白色卡片 */
        @media (max-width: 991.98px) {

            /* 折叠区域整体留出一些内边距 */
            .navbar-collapse {
                background: transparent;
                padding: .75rem 1rem 1.2rem;
            }

            /* 菜单部分变成卡片 */
            .navbar-collapse .navbar-nav {
                background: #ffffff;
                border-radius: 18px;
                box-shadow: 0 18px 40px rgba(15,23,42,0.18);
                padding: .9rem 1.1rem;
                margin-bottom: .6rem;
            }

            .navbar-nav .nav-link {
                display: block;
                padding-left: 0;
                padding-right: 0;
                margin-bottom: .25rem;
                font-size: .95rem;
            }

            /* 底部账号区域也放进卡片里 */
            .navbar-collapse > .d-flex {
                background: #ffffff;
                border-radius: 18px;
                box-shadow: 0 18px 40px rgba(15,23,42,0.18);
                padding: .6rem 1.1rem .7rem;
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

        /* 3.1 手机端 admin 按钮铺满一行，像输入框 */
        @media (max-width: 991.98px) {
            .navbar .dropdown {
                width: 100%;
            }

            .navbar .user-dropdown-btn {
                width: 100%;
                display: flex;
                align-items: center;
                justify-content: space-between;
                text-align: left;
                padding: .45rem .9rem;
                border-radius: 999px;
                border: 1px solid rgba(78,115,223,.35);
                background: #ffffff;
                color: #4b4d63 !important;
            }

            .navbar .user-dropdown-btn i {
                color: #4e73df;
            }
        }

        /* 3.2 手机端下拉菜单：不再绝对定位，宽度跟随卡片 */
        @media (max-width: 991.98px) {
            .navbar .user-menu-dropdown {
                position: static !important;          /* 不用绝对定位 */
                transform: none !important;           /* 取消 translate3d */
                inset: auto !important;               /* 清掉 top/left 等 */
                margin-top: .55rem;
                width: 100%;
                max-width: 100%;
                border-radius: 16px;
                box-shadow: 0 14px 32px rgba(15,23,42,0.16);
                overflow: hidden;
            }
        }
    </style>
</head>
<body>

<div id="alert-container"></div>

<!-- 顶部导航（结构和 design.jsp 一致，保留 userDropdown 按钮） -->
<nav class="navbar navbar-expand-lg navbar-light fixed-top">
    <div class="container">
        <a class="navbar-brand" href="<c:url value='/'/>">
            <i class="bi bi-card-checklist"></i> 问卷星
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

            <div class="d-flex align-items-center">
                <div class="dropdown">
                    <!-- 这里保留 id / data-bs-toggle 等结构，方便你之前的逻辑复用 -->
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
            </div>

        </div>
    </div>
</nav>

<div class="page-wrapper">
    <div class="container">
        <!-- 顶部标题条：文件夹管理 -->
        <section class="design-header">
            <div class="design-header-inner">
                <div>
                    <h1 class="design-header-title">文件夹管理</h1>
                    <p class="design-header-subtitle mb-1">
                        对问卷进行分组和归类，让你的问卷列表更清晰、有条理。
                    </p>
                    <p class="design-header-meta mb-0">
                        <i class="bi bi-info-circle me-1"></i>你可以创建多个文件夹，用于区分不同业务、场景或项目。
                    </p>
                </div>
                <div class="text-end">
                    <span class="badge-step mb-2 d-inline-flex">
                        <i class="bi bi-folder"></i> 问卷文件夹
                    </span>
                    <div>
                        <button class="btn btn-sm btn-outline-light" type="button" onclick="openCreateFolderModal()">
                            <i class="bi bi-plus-lg me-1"></i> 新建文件夹
                        </button>
                    </div>
                </div>
            </div>
        </section>

        <!-- 主体：左导航 + 右文件夹列表 -->
        <section class="folder-layout">
            <div class="row g-4">
                <!-- 左侧导航 -->
                <div class="col-lg-3">
                    <div class="nav-card">
                        <div class="nav-card-title">
                            <i class="bi bi-collection"></i>
                            <span>问卷导航</span>
                        </div>
                        <div class="nav-card-sub">
                            快速跳转到常用问卷页面
                        </div>
                        <ul class="nav-card-menu">
                            <li>
                                <a href="<c:url value='/questionnaire/create'/>" class="nav-link-chip">
                                    <i class="bi bi-plus-circle"></i> 创建问卷
                                </a>
                            </li>
                            <li>
                                <a href="<c:url value='/questionnaire/list'/>" class="nav-link-chip">
                                    <i class="bi bi-list-ul"></i> 全部问卷
                                </a>
                            </li>
                            <li>
                                <a href="<c:url value='/questionnaire/starred'/>" class="nav-link-chip">
                                    <i class="bi bi-star"></i> 星标问卷
                                </a>
                            </li>
                            <li>
                                <a href="<c:url value='/folder/list'/>" class="nav-link-chip active">
                                    <i class="bi bi-folder"></i> 文件夹
                                </a>
                            </li>
                            <li>
                                <a href="<c:url value='/questionnaire/recycle'/>" class="nav-link-chip">
                                    <i class="bi bi-trash"></i> 回收站
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>

                <!-- 右侧文件夹列表 -->
                <div class="col-lg-9">
                    <div class="folders-card">
                        <div class="folders-header">
                            <div class="folders-header-title">
                                <i class="bi bi-folder2-open"></i>
                                <span>文件夹列表</span>
                            </div>
                            <div class="folders-header-meta">
                                管理文件夹的创建、重命名和删除
                            </div>
                            <button class="btn-create-folder-top d-none d-md-inline-flex" type="button"
                                    onclick="openCreateFolderModal()">
                                <i class="bi bi-plus-lg"></i> 新建
                            </button>
                        </div>
                        <hr class="mt-2 mb-3"/>

                        <!-- JS 渲染文件夹列表 -->
                        <div id="folder-list-container"></div>

                        <!-- 空状态 -->
                        <div id="empty-state-container" class="empty-state" style="display: none;">
                            <div class="icon"><i class="bi bi-folder2-open"></i></div>
                            <h4 class="mb-2">暂无文件夹</h4>
                            <p class="text-muted mb-3">
                                点击“新建文件夹”按钮，为你的问卷创建第一个分组。
                            </p>
                            <button class="btn-create-folder-top" type="button" onclick="openCreateFolderModal()">
                                <i class="bi bi-plus-lg"></i> 新建文件夹
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </section>

    </div>
</div>

<!-- 新建 / 重命名 文件夹模态框 -->
<div class="modal fade folder-modal" id="folderEditModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="folderModalTitle">
                    <i class="bi bi-folder-plus"></i> 新建文件夹
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="d-flex mb-3">
                    <div class="folder-icon">
                        <i class="bi bi-folder2"></i>
                    </div>
                    <div>
                        <div class="fw-semibold mb-1" style="font-size: 0.95rem;">
                            合理使用文件夹，可以更高效地管理问卷
                        </div>
                        <div class="text-muted" style="font-size: 0.85rem;" id="folderModalHint">
                            例如：“市场调研”、“满意度调查”、“内部问卷”等
                        </div>
                    </div>
                </div>

                <div class="mb-2">
                    <label class="input-label" for="folderNameInput">文件夹名称</label>
                    <input type="text" class="form-control" id="folderNameInput" maxlength="50"
                           placeholder="请输入文件夹名称">
                    <div class="invalid-feedback" id="folderNameError" style="display: none;"></div>
                </div>
                <div class="form-text text-muted">
                    建议使用简短且能清晰表达用途的名称，最多 50 个字符。
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-cancel" data-bs-dismiss="modal">
                    <i class="bi bi-x-lg me-1"></i>取消
                </button>
                <button type="button" class="btn btn-save" onclick="submitFolderModal()">
                    <i class="bi bi-check-lg me-1"></i>确定
                </button>
            </div>
        </div>
    </div>
</div>

<!-- 删除文件夹确认模态框 -->
<div class="modal fade delete-modal" id="folderDeleteModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i> 确认删除文件夹
                </h5>
            </div>
            <div class="modal-body">
                <div class="warning-icon">
                    <i class="bi bi-exclamation-circle"></i>
                </div>
                <div class="delete-message">
                    确定要删除文件夹 <span class="text-danger" id="deleteFolderName">该文件夹</span> 吗？
                </div>
                <div class="delete-hint">
                    文件夹删除后，文件夹中的问卷不会被删除，将自动移动到“未分类”文件夹中。
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-cancel" data-bs-dismiss="modal">
                    <i class="bi bi-x-lg me-1"></i>取消
                </button>
                <button type="button" class="btn btn-delete" onclick="confirmDeleteFolder()">
                    <i class="bi bi-trash-fill me-1"></i>确认删除
                </button>
            </div>
        </div>
    </div>
</div>

<script src="/resources/js/bootstrap/bootstrap.bundle.min.js"></script>
<script>
    let currentFolderId = null;
    let deleteFolderId = null;

    // 导航折叠 & 滚动效果（复用 design.jsp 的逻辑）
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

    document.addEventListener('DOMContentLoaded', function () {
        loadFolders();
    });

    function showAlert(type, message, duration) {
        if (duration === undefined) duration = 3000;
        const alertContainer = document.getElementById('alert-container');
        if (!alertContainer) return;

        const alertId = 'alert-' + Date.now();
        const icon = type === 'success' ? 'check-circle-fill' : 'exclamation-triangle-fill';
        const bsClass = type === 'success' ? 'alert-success' : 'alert-danger';

        const html =
            '<div id="' + alertId + '" class="alert ' + bsClass + ' pretty-alert alert-dismissible fade show" role="alert">' +
            '<i class="bi bi-' + icon + '"></i>' +
            '<div class="flex-grow-1">' + message + '</div>' +
            '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>' +
            '</div>';

        alertContainer.insertAdjacentHTML('beforeend', html);

        setTimeout(function () {
            const alertElement = document.getElementById(alertId);
            if (alertElement) {
                const bsAlert = bootstrap.Alert.getOrCreateInstance(alertElement);
                if (bsAlert) bsAlert.close();
            }
        }, duration);
    }

    function formatDate(dateString) {
        if (!dateString) return 'N/A';
        const normalized = dateString.replace(' ', 'T');
        const date = new Date(normalized);
        if (isNaN(date.getTime())) return dateString;
        return date.toLocaleDateString('zh-CN', {
            year: 'numeric',
            month: '2-digit',
            day: '2-digit'
        });
    }

    function escapeHtml(text) {
        if (text === null || typeof text === 'undefined') return '';
        const map = {
            '&': '&amp;',
            '<': '&lt;',
            '>': '&gt;',
            '"': '&quot;',
            "'": '&#039;'
        };
        return text.toString().replace(/[&<>"']/g, function (m) { return map[m]; });
    }

    function loadFolders() {
        fetch('<c:url value="/folder/api/list"/>')
            .then(function (response) {
                return response.ok ? response.json() : Promise.reject('Network response was not ok');
            })
            .then(function (data) {
                if (data.success) {
                    renderFolders(data.folders);
                } else {
                    showAlert('danger', '加载文件夹失败: ' + data.message);
                }
            })
            .catch(function (error) {
                console.error('加载文件夹失败:', error);
                showAlert('danger', '加载文件夹失败，请检查网络或联系管理员。');
            });
    }

    function openCreateFolderModal() {
        currentFolderId = null;
        const titleEl = document.getElementById('folderModalTitle');
        const hintEl = document.getElementById('folderModalHint');
        const inputEl = document.getElementById('folderNameInput');
        const errorEl = document.getElementById('folderNameError');

        titleEl.innerHTML = '<i class="bi bi-folder-plus"></i> 新建文件夹';
        hintEl.textContent = '例如：“市场调研”、“满意度调查”、“内部问卷”等';
        inputEl.value = '';
        inputEl.placeholder = '请输入文件夹名称';
        inputEl.classList.remove('is-invalid');
        errorEl.style.display = 'none';

        const modalEl = document.getElementById('folderEditModal');
        const modal = bootstrap.Modal.getOrCreateInstance(modalEl);
        modal.show();

        setTimeout(function () { inputEl.focus(); }, 200);
    }

    function openEditFolderModal(id, name) {
        currentFolderId = parseInt(id, 10);
        const titleEl = document.getElementById('folderModalTitle');
        const hintEl = document.getElementById('folderModalHint');
        const inputEl = document.getElementById('folderNameInput');
        const errorEl = document.getElementById('folderNameError');

        titleEl.innerHTML = '<i class="bi bi-pencil-square"></i> 重命名文件夹';
        hintEl.textContent = '重命名不会影响文件夹中的问卷，仅修改显示名称';
        inputEl.value = name || '';
        inputEl.placeholder = '';
        inputEl.classList.remove('is-invalid');
        errorEl.style.display = 'none';

        const modalEl = document.getElementById('folderEditModal');
        const modal = bootstrap.Modal.getOrCreateInstance(modalEl);
        modal.show();

        setTimeout(function () {
            inputEl.focus();
            inputEl.select();
        }, 200);
    }

    function submitFolderModal() {
        const inputEl = document.getElementById('folderNameInput');
        const errorEl = document.getElementById('folderNameError');
        const rawName = inputEl.value;
        const name = rawName.replace(/^\s+|\s+$/g, '');

        inputEl.classList.remove('is-invalid');
        errorEl.style.display = 'none';

        if (!name) {
            inputEl.classList.add('is-invalid');
            errorEl.textContent = '文件夹名称不能为空';
            errorEl.style.display = 'block';
            inputEl.focus();
            return;
        }
        if (name.length > 50) {
            inputEl.classList.add('is-invalid');
            errorEl.textContent = '文件夹名称不能超过 50 个字符';
            errorEl.style.display = 'block';
            inputEl.focus();
            return;
        }

        let url;
        let method;
        const bodyObj = { name: name };

        if (currentFolderId === null) {
            url = '<c:url value="/folder/api/create"/>';
            method = 'POST';
        } else {
            url = '<c:url value="/folder/api/update"/>' + '/' + currentFolderId;
            method = 'PUT';
        }

        fetch(url, {
            method: method,
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify(bodyObj)
        })
            .then(function (response) { return response.json(); })
            .then(function (data) {
                if (data.success) {
                    const modalEl = document.getElementById('folderEditModal');
                    const modal = bootstrap.Modal.getOrCreateInstance(modalEl);
                    modal.hide();

                    if (currentFolderId === null) {
                        showAlert('success', '文件夹创建成功！');
                    } else {
                        showAlert('success', '文件夹重命名成功！');
                    }
                    loadFolders();
                } else {
                    inputEl.classList.add('is-invalid');
                    errorEl.textContent = data.message || '操作失败，请稍后重试';
                    errorEl.style.display = 'block';
                }
            })
            .catch(function () {
                inputEl.classList.add('is-invalid');
                errorEl.textContent = '请求失败，请稍后重试';
                errorEl.style.display = 'block';
            });
    }

    function openDeleteFolderModal(id, name) {
        deleteFolderId = parseInt(id, 10);
        const nameEl = document.getElementById('deleteFolderName');
        nameEl.textContent = name || '该文件夹';

        const modalEl = document.getElementById('folderDeleteModal');
        const modal = bootstrap.Modal.getOrCreateInstance(modalEl);
        modal.show();
    }

    function confirmDeleteFolder() {
        if (deleteFolderId === null || isNaN(deleteFolderId)) return;

        const url = '<c:url value="/folder/api/delete"/>' + '/' + deleteFolderId;

        fetch(url, {method: 'DELETE'})
            .then(function (response) { return response.json(); })
            .then(function (data) {
                const modalEl = document.getElementById('folderDeleteModal');
                const modal = bootstrap.Modal.getOrCreateInstance(modalEl);
                modal.hide();

                if (data.success) {
                    showAlert('success', '文件夹删除成功！');
                    loadFolders();
                } else {
                    showAlert('danger', data.message || '文件夹删除失败');
                }
            })
            .catch(function () {
                showAlert('danger', '请求失败，请稍后重试。');
            })
            .finally(function () {
                deleteFolderId = null;
            });
    }

    function renderFolders(folders) {
        const container = document.getElementById('folder-list-container');
        const emptyState = document.getElementById('empty-state-container');

        if (!folders || folders.length === 0) {
            container.innerHTML = '';
            emptyState.style.display = 'block';
            return;
        }

        emptyState.style.display = 'none';

        const html = folders.map(function (folder) {
            const isDefault = folder.name === '未分类';
            const folderColor = isDefault ? '#f59e0b' : '#4e73df';

            // 展示用（防 XSS）
            const safeName = escapeHtml(folder.name);

            // JS 字符串用：把 \ 和 ' 处理一下，避免 onclick 里字符串断掉
            const jsName = (folder.name || '')
                .replace(/\\/g, '\\\\')
                .replace(/'/g, '\\\'');

            // 查看问卷按钮
            let actionButtons =
                '<a href="<c:url value="/questionnaire/list"/>' +
                '?folderId=' + folder.id + '" class="action-btn">' +
                    '<i class="bi bi-eye"></i> 查看问卷' +
                '</a>';

            // 非默认文件夹才允许重命名/删除
            if (!isDefault) {
                actionButtons +=
                    // 直接把 id 和 name 写到函数参数里，**不再用 this.getAttribute**
                    '<button type="button" class="action-btn" ' +
                        'onclick="openEditFolderModal(' + folder.id + ', \'' + jsName + '\')">' +
                        '<i class="bi bi-pencil"></i> 重命名' +
                    '</button>' +
                    '<button type="button" class="action-btn danger" ' +
                        'onclick="openDeleteFolderModal(' + folder.id + ', \'' + jsName + '\')">' +
                        '<i class="bi bi-trash"></i> 删除' +
                    '</button>';
            }

            return '' +
                '<div class="folder-card" style="border-left: 4px solid ' + folderColor + ';">' +
                    '<div class="folder-header-row">' +
                        '<div>' +
                            '<div class="folder-title">' +
                                '<i class="bi bi-folder2" style="color: ' + folderColor + ';"></i>' +
                                safeName +
                                (isDefault
                                    ? '<span class="folder-badge-default"><i class="bi bi-shield-check"></i> 默认</span>'
                                    : '') +
                            '</div>' +
                            (isDefault
                                ? '<div class="folder-sub"><i class="bi bi-info-circle me-1"></i>系统默认文件夹，所有未分类问卷将自动归入此处</div>'
                                : '') +
                        '</div>' +
                        '<div class="folder-actions">' + actionButtons + '</div>' +
                    '</div>' +
                    '<div class="folder-stats">' +
                        '<div class="stat-item">' +
                            '<i class="bi bi-file-earmark-text"></i>' +
                            '<span>问卷数量：<span class="stat-value">' + (folder.questionnaireCount || 0) + '</span></span>' +
                        '</div>' +
                        '<div class="stat-item">' +
                            '<i class="bi bi-calendar3"></i>' +
                            '<span>创建时间：' + formatDate(folder.createTime) + '</span>' +
                        '</div>' +
                    '</div>' +
                '</div>';
        }).join('');

        container.innerHTML = html;
    }
</script>
</body>
</html>
