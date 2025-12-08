<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

    /* 核心修复：启用平滑滚动 */
    html {
        scroll-behavior: smooth;
    }

    body {
        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Helvetica Neue', Arial, sans-serif;
        background: radial-gradient(circle at top left, #f0f4ff 0, #f8f9fc 45%, #fdfdfd 100%);
        color: var(--dark-color);
        line-height: 1.6;
        /* 核心修复：防止滚动时的抖动 */
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
    }

    a {
        text-decoration: none;
    }

    /* ===========================================
       顶部导航栏 - 统一样式
       =========================================== */
    .navbar {
        background: rgba(255, 255, 255, 0.9);
        backdrop-filter: blur(16px);
        box-shadow: 0 8px 24px rgba(15, 23, 42, 0.08);
        transition: background 0.2s ease, box-shadow 0.2s ease;
        /* 核心修复：固定高度，防止抖动 */
        height: 76px;
        padding: 0;
        /* 核心修复：使用GPU加速，减少重绘 */
        will-change: background, box-shadow;
        transform: translateZ(0);
        -webkit-backface-visibility: hidden;
        backface-visibility: hidden;
    }

    .navbar > .container {
        height: 100%;
        display: flex;
        align-items: center;
    }

    .navbar.scrolled {
        /* 滚动时不改变高度，只改变背景和阴影 */
        background: rgba(255, 255, 255, 0.98);
        box-shadow: 0 10px 30px rgba(15, 23, 42, 0.14);
    }

    .navbar-brand {
        font-weight: 800;
        font-size: 1.45rem;
        color: var(--primary-color) !important;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        height: 100%;
        padding: 0;
        margin-right: 2rem;
    }

    .navbar-brand i {
        font-size: 1.4rem;
        color: var(--primary-dark);
        transform: translateY(-1px);
    }

    .navbar-collapse {
        flex-grow: 0;
    }

    .navbar-nav .nav-link {
        font-weight: 600;
        color: var(--secondary-color) !important;
        padding: 0.5rem 1rem !important;
        transition: all 0.2s ease;
    }

    .navbar-nav .nav-link:hover {
        color: var(--primary-color) !important;
        transform: translateY(-1px);
    }

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

    /* ===========================================
       页面容器 - 统一间距
       =========================================== */
    .page-wrapper {
        /* 核心修复：统一顶部间距 = 76px 导航 + 20px 留白 */
        padding-top: 96px;
        padding-bottom: 40px;
        /* 核心修复：优化滚动性能 */
        position: relative;
        z-index: 1;
    }

    /* ===========================================
       设计头部区域 - 统一样式
       =========================================== */
    .design-header {
        /* 核心修复：统一底部间距 */
        margin-bottom: 24px;
    }

    .design-header-inner {
        background: linear-gradient(135deg, #4f46e5 0, #1d4ed8 40%, #2563eb 100%);
        border-radius: 20px;
        /* 核心修复：统一内边距 */
        padding: 24px 28px;
        color: #fff;
        box-shadow: 0 14px 36px rgba(37, 99, 235, 0.35);
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 1rem;
        /* 核心修复：统一最小高度，防止不同页面高度跳动 */
        min-height: 136px;
        box-sizing: border-box;
    }

    .design-header-title {
        margin: 0;
        font-size: 1.5rem;
        font-weight: 700;
        line-height: 1.3;
    }

    .design-header-subtitle {
        margin: 0.35rem 0 0;
        font-size: 0.96rem;
        opacity: 0.9;
        line-height: 1.5;
    }

    .design-header-meta {
        font-size: 0.85rem;
        opacity: 0.85;
        margin-top: 0.25rem;
    }

    .badge-step {
        display: inline-flex;
        align-items: center;
        gap: 0.25rem;
        padding: 0.25rem 0.8rem;
        border-radius: 999px;
        border: 1px solid rgba(248, 250, 252, 0.9);
        background: rgba(15, 23, 42, 0.15);
        font-size: 0.8rem;
    }

    .badge-step i {
        font-size: 0.9rem;
    }

    /* ===========================================
       布局容器
       =========================================== */
    .folder-layout,
    .design-layout {
        margin-top: 10px;
    }

    /* ===========================================
       左侧导航卡片 - 统一样式
       =========================================== */
    .nav-card {
        background: #ffffff;
        border-radius: 18px;
        box-shadow: 0 14px 40px rgba(15, 23, 42, 0.08);
        border: 1px solid rgba(226, 232, 240, 0.9);
        /* 核心修复：统一内边距 */
        padding: 24px 20px;
        /* 核心修复：统一最小高度，防止内容不同导致高度跳动 */
        min-height: 360px;
        box-sizing: border-box;
    }

    .nav-card-title {
        font-weight: 700;
        font-size: 1rem;
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
        margin-bottom: 1.4rem;
        line-height: 1.4;
    }

    .nav-card-menu {
        list-style: none;
        padding-left: 0;
        margin: 0;
    }

    .nav-card-menu li + li {
        margin-top: 0.6rem;
    }

    .nav-link-chip {
        text-decoration: none;
        display: flex;
        align-items: center;
        gap: 0.6rem;
        padding: 0.65rem 1rem;
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
        box-shadow: 0 8px 20px rgba(78, 115, 223, 0.4);
    }

    .nav-link-chip.active i {
        color: #fff;
    }

    /* ===========================================
       内容卡片 - 统一样式
       =========================================== */
    .content-card,
    .add-question-card,
    .questions-card,
    .folders-card {
        background: #ffffff;
        border-radius: 18px;
        padding: 22px 24px 20px;
        box-shadow: 0 14px 40px rgba(15, 23, 42, 0.08);
        border: 1px solid rgba(226, 232, 240, 0.9);
        min-height: 400px;
        box-sizing: border-box;
    }

    .add-question-card,
    .questions-card {
        padding: 18px 18px 16px;
    }

    .folders-card {
        padding: 16px 16px 14px;
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
        gap: 0.5rem;
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
        font-size: 0.86rem;
        color: var(--muted-color);
        margin-top: 2px;
    }

    /* ===========================================
       表单控件 - 统一样式
       =========================================== */
    .form-control,
    .form-select {
        border-radius: 12px;
        border: 1px solid var(--border-soft);
        font-size: 0.9rem;
        padding: 0.5rem 0.75rem;
    }

    .form-control:focus,
    .form-select:focus {
        border-color: var(--primary-color);
        box-shadow: 0 0 0 1px rgba(78, 115, 223, 0.35);
        outline: none;
    }

    /* ===========================================
       问卷/文件夹卡片
       =========================================== */
    .questionnaire-card,
    .folder-card {
        background: #fff;
        border-radius: 14px;
        border: 1px solid var(--border-soft);
        padding: 12px 12px 10px;
        margin-bottom: 10px;
        transition: all 0.18s ease;
    }

    .questionnaire-card {
        border-left: 4px solid transparent;
        padding: 1rem 1.1rem 0.9rem;
        margin-bottom: 0.7rem;
    }

    .questionnaire-card:hover,
    .folder-card:hover {
        transform: translateY(-1px);
        box-shadow: 0 12px 28px rgba(15, 23, 42, 0.12);
    }

    .questionnaire-card:hover {
        border-left-color: rgba(78, 115, 223, 0.6);
    }

    .folder-card:hover {
        border-color: rgba(78, 115, 223, 0.35);
    }

    /* ===========================================
       问题卡片
       =========================================== */
    .question-card {
        border-radius: 14px;
        border: 1px solid var(--border-soft);
        padding: 12px 12px 10px;
        margin-bottom: 10px;
        background: #ffffff;
    }

    .question-title {
        font-weight: 600;
        font-size: 0.95rem;
    }

    /* ===========================================
       空状态
       =========================================== */
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

    /* ===========================================
       移动端导航
       =========================================== */
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

    /* ===========================================
       模态框 - 统一样式
       =========================================== */
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

    .delete-modal .modal-header {
        background: linear-gradient(135deg, #f97373, #ef4444);
        color: white;
        border-bottom: none;
        padding: 1.1rem 1.5rem;
    }

    /* ===========================================
       平滑过渡 - 减少抖动感
       =========================================== */
    .design-header,
    .nav-card,
    .content-card,
    .folders-card,
    .folder-card,
    .questionnaire-card {
        transition: transform 0.2s cubic-bezier(0.4, 0, 0.2, 1),
                    box-shadow 0.2s cubic-bezier(0.4, 0, 0.2, 1);
        /* 核心修复：使用GPU加速，减少重绘 */
        will-change: transform, box-shadow;
        transform: translateZ(0);
        -webkit-backface-visibility: hidden;
        backface-visibility: hidden;
    }

    /* ===========================================
       用户下拉菜单 - 美化样式
       =========================================== */
    .dropdown-menu {
        border-radius: 16px;
        padding: 0;
        border: 1px solid rgba(226, 232, 240, 0.95);
        box-shadow: 0 18px 40px rgba(15, 23, 42, 0.18);
        min-width: 260px;
        overflow: hidden;
    }

    .dropdown-header {
        padding: 0.75rem 1rem 0.8rem;
        background: linear-gradient(135deg, #4e73df, #224abe);
        color: #fff;
        font-size: 0.85rem;
        border-bottom: none;
    }

    .dropdown-item {
        padding: 0.55rem 1rem;
        font-size: 0.9rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        color: #4b4d63;
    }

    .dropdown-item i {
        font-size: 1rem;
    }

    .dropdown-item:hover {
        background-color: #f3f4ff;
        color: #111827;
    }

    .dropdown-item.text-danger {
        color: #e74a3b;
    }

    .dropdown-item.text-danger:hover {
        background-color: #fee2e2;
        color: #b91c1c;
    }

    /* ===========================================
       响应式设计
       =========================================== */
    @media (max-width: 991.98px) {
        /* 折叠后的导航区域 */
        .navbar-collapse {
            background: transparent;
            padding: 0.75rem 1rem 1.2rem;
        }

        /* 菜单部分变成白色卡片 */
        .navbar-collapse .navbar-nav {
            background: #ffffff;
            border-radius: 18px;
            box-shadow: 0 18px 40px rgba(15, 23, 42, 0.18);
            padding: 0.9rem 1.1rem;
            margin-bottom: 0.6rem;
        }

        .navbar-nav .nav-link {
            display: block;
            padding-left: 0;
            padding-right: 0;
            margin-bottom: 0.25rem;
        }

        /* 底部用户区域也放进白色卡片 */
        .navbar-collapse > .d-flex {
            background: #ffffff;
            border-radius: 18px;
            box-shadow: 0 18px 40px rgba(15, 23, 42, 0.18);
            padding: 0.6rem 1.1rem 0.7rem;
            flex-direction: row;
            justify-content: space-between;
            align-items: center;
        }

        .design-header-inner {
            flex-direction: column;
            align-items: flex-start;
            gap: 1.5rem;
        }

        /* 移动端用户下拉按钮样式优化 */
        .navbar .dropdown {
            width: 100%;
        }

        .navbar .user-dropdown-btn {
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            text-align: left;
            padding: 0.45rem 0.9rem;
            border-radius: 999px;
            border: 1px solid rgba(78, 115, 223, 0.35);
            background: #ffffff;
            color: #4b4d63 !important;
        }

        .navbar .user-dropdown-btn i {
            color: #4e73df;
        }

        /* 移动端下拉菜单定位修复 */
        .navbar .dropdown-menu {
            position: static !important;
            transform: none !important;
            inset: auto !important;
            margin-top: 0.55rem;
            width: 100%;
            max-width: 100%;
            border-radius: 16px;
            box-shadow: 0 14px 32px rgba(15, 23, 42, 0.16);
            overflow: hidden;
        }
    }

    @media (max-width: 768px) {
        .page-wrapper {
            padding-top: 90px;
        }

        .nav-card {
            min-height: auto;
        }

        .content-card,
        .folders-card {
            padding: 18px 16px;
        }
    }

    @media (max-width: 576px) {
        .content-card {
            padding: 18px 16px;
        }
    }
</style>
