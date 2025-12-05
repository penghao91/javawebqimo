<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>我的问卷 - 问卷系统</title>
    <link href="/resources/css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link href="/resources/css/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --bs-primary-rgb: 78, 115, 223;
            --bs-body-bg: #f8f9fc;
            --bs-body-color: #5a5c69;
            --border-color: #e3e6f0;
            --sidebar-width: 250px;
        }
        body {
            background-color: var(--bs-body-bg);
            color: var(--bs-body-color);
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
        }
        
        /* 顶部导航栏 */
        .top-navbar {
            background: linear-gradient(135deg, rgba(var(--bs-primary-rgb), 1), rgba(var(--bs-primary-rgb), 0.8));
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            height: 70px;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1030; /* Bootstrap's default for fixed-top */
        }
        .top-navbar .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
            color: white !important;
        }
        .top-nav-menu {
            display: flex;
            align-items: center;
            gap: 2rem;
            margin-left: 2rem;
        }
        .top-nav-item {
            color: rgba(255,255,255,0.9) !important;
            text-decoration: none;
            font-weight: 500;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        .top-nav-item:hover, .top-nav-item.active {
            background-color: rgba(255,255,255,0.15);
            color: white !important;
        }
        .user-info {
            display: flex;
            align-items: center;
            gap: 1rem;
            color: white;
        }
        .user-phone {
            font-weight: 500;
        }
        
        /* 主体布局 */
        .main-container {
            display: flex;
            min-height: calc(100vh - 70px);
            margin-top: 70px;
            position: relative;
            z-index: 1;
        }
        
        /* 左侧边栏 */
        .sidebar {
            width: var(--sidebar-width);
            background: white;
            border-right: 1px solid var(--border-color);
            padding: 1.5rem 0;
            box-shadow: 2px 0 5px rgba(0,0,0,0.05);
            position: relative;
            z-index: 100;
        }
        .sidebar-menu {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .sidebar-menu-item {
            margin: 0.25rem 0;
        }
        .sidebar-menu-link {
            display: flex;
            align-items: center;
            padding: 0.75rem 1.5rem;
            color: var(--bs-body-color);
            text-decoration: none;
            transition: all 0.3s ease;
            border-left: 3px solid transparent;
        }
        .sidebar-menu-link:hover {
            background-color: #f8f9fc;
            color: rgba(var(--bs-primary-rgb), 1);
        }
        .sidebar-menu-link.active {
            background-color: rgba(var(--bs-primary-rgb), 0.1);
            color: rgba(var(--bs-primary-rgb), 1);
            border-left-color: rgba(var(--bs-primary-rgb), 1);
        }
        .sidebar-menu-link i {
            margin-right: 0.75rem;
            font-size: 1.1rem;
            width: 20px;
            text-align: center;
        }
        
        /* 内容区域 */
        .content-area {
            flex: 1;
            padding: 2rem;
            background-color: var(--bs-body-bg);
        }
        
        /* 微信绑定提示 */
        .wechat-bind-alert {
            background: linear-gradient(135deg, #07c160, #06ae56);
            color: white;
            border: none;
            border-radius: 12px;
            margin-bottom: 2rem;
        }
        .wechat-bind-alert .btn-outline-light {
            border-color: rgba(255,255,255,0.5);
            color: white;
        }
        .wechat-bind-alert .btn-outline-light:hover {
            background-color: rgba(255,255,255,0.2);
        }
        
        /* 页面头部 */
        .page-header {
            background: white;
            padding: 1.5rem 2rem;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .page-title {
            font-size: 1.75rem;
            font-weight: 600;
            color: #2c3e50;
            margin: 0;
        }
        .create-btn {
            background: linear-gradient(135deg, rgba(var(--bs-primary-rgb), 1), rgba(var(--bs-primary-rgb), 0.8));
            border: none;
            padding: 0.75rem 1.5rem;
            font-weight: 500;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        .create-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(var(--bs-primary-rgb), 0.3);
        }
        
        /* 筛选栏 */
        .filter-bar {
            background: white;
            padding: 1rem 2rem;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .filter-group {
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        .filter-select {
            border: 1px solid var(--border-color);
            border-radius: 6px;
            padding: 0.5rem 1rem;
            background: white;
            color: var(--bs-body-color);
        }
        
        /* 问卷卡片 */
        .questionnaire-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 1rem;
            padding: 1.5rem 2rem;
            transition: all 0.3s ease;
            border-left: 4px solid transparent;
        }
        
        /* 下拉菜单样式 */
        .action-dropdown .dropdown-menu {
            border-radius: 8px;
            border: 1px solid var(--border-color);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            padding: 0.5rem 0;
        }
        .action-dropdown .dropdown-item {
            padding: 0.5rem 1rem;
            color: var(--bs-body-color);
            transition: all 0.3s ease;
            font-size: 0.9rem;
        }
        .action-dropdown .dropdown-item:hover {
            background-color: #f8f9fc;
            color: rgba(var(--bs-primary-rgb), 1);
        }
        .action-dropdown .dropdown-item i {
            font-size: 1rem;
        }
        .questionnaire-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
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
            margin-bottom: 1rem;
        }
        .questionnaire-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: #2c3e50;
            margin: 0;
        }
        .questionnaire-id {
            color: #6c757d;
            font-size: 0.9rem;
        }
        
        .questionnaire-stats {
            display: flex;
            gap: 2rem;
            margin: 1rem 0;
        }
        .stat-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #6c757d;
        }
        .stat-value {
            font-weight: 600;
            color: rgba(var(--bs-primary-rgb), 1);
        }
        
        .questionnaire-actions {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }
        .action-btn {
            padding: 0.5rem 1rem;
            border: 1px solid var(--border-color);
            background: white;
            color: var(--bs-body-color);
            text-decoration: none;
            border-radius: 6px;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.25rem;
        }
        .action-btn:hover {
            background-color: #f8f9fc;
            color: rgba(var(--bs-primary-rgb), 1);
            border-color: rgba(var(--bs-primary-rgb), 1);
        }
        .action-btn.primary {
            background: rgba(var(--bs-primary-rgb), 1);
            color: white;
            border-color: rgba(var(--bs-primary-rgb), 1);
        }
        .action-btn.primary:hover {
            background: rgba(var(--bs-primary-rgb), 0.9);
        }
        .action-btn.danger {
            color: #dc3545;
            border-color: #dc3545;
        }
        .action-btn.danger:hover {
            background-color: #dc3545;
            color: white;
        }
        
        /* 状态标签 */
        .status-badge {
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
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
        
        /* 空状态 */
        .empty-state {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            padding: 4rem 2rem;
            text-align: center;
            color: #6c757d;
        }
        .empty-state .icon {
            font-size: 4rem;
            color: #dee2e6;
            margin-bottom: 1rem;
        }
        
        /* 简单欢迎提示 */
        .welcome-toast {
            position: fixed;
            top: 20px;
            right: 20px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.12);
            border: none;
            overflow: hidden;
            min-width: 350px;
            max-width: 500px;
            animation: slideInRight 0.3s ease-out;
            z-index: 9999;
            display: none;
        }
        .welcome-toast.show {
            display: block;
        }
        .welcome-toast-header {
            background: linear-gradient(135deg, #4e73df, #224abe);
            color: white;
            border-bottom: none;
            padding: 1rem 1.25rem;
            font-weight: 600;
            display: flex;
            align-items: center;
        }
        .welcome-toast-body {
            padding: 1.25rem;
            color: #5a5c69;
            font-size: 0.95rem;
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
        
        /* 样本服务推广模块 */
        .sample-service-promo {
            margin-top: 3rem;
        }
        .promo-card {
            background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
            border-radius: 16px;
            padding: 2.5rem;
            border: 1px solid #90caf9;
            position: relative;
            overflow: hidden;
        }
        .promo-card::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -10%;
            width: 300px;
            height: 300px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
        }
        .promo-icon {
            position: absolute;
            top: 2rem;
            right: 2rem;
            font-size: 3rem;
            color: #1976d2;
            opacity: 0.3;
        }
        .promo-content {
            position: relative;
            z-index: 1;
        }
        .promo-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: #1565c0;
            margin-bottom: 0.5rem;
        }
        .promo-desc {
            color: #424242;
            margin-bottom: 1.5rem;
            font-size: 1.1rem;
        }
        .promo-stats {
            display: flex;
            gap: 2rem;
            margin-bottom: 1.5rem;
            flex-wrap: wrap;
        }
        .promo-stats .stat-item {
            text-align: center;
            background: rgba(255, 255, 255, 0.7);
            padding: 1rem 1.5rem;
            border-radius: 12px;
            backdrop-filter: blur(10px);
        }
        .promo-stats .stat-number {
            display: block;
            font-size: 1.8rem;
            font-weight: 700;
            color: #1565c0;
        }
        .promo-stats .stat-label {
            font-size: 0.9rem;
            color: #546e7a;
            font-weight: 500;
        }
        .promo-btn {
            background: linear-gradient(135deg, #1976d2, #0d47a1);
            border: none;
            padding: 0.75rem 2rem;
            font-weight: 600;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        .promo-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(25, 118, 210, 0.4);
        }
        
        /* 下拉菜单样式 */
        .action-dropdown .dropdown-menu {
            border-radius: 8px;
            border: 1px solid var(--border-color);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            padding: 0.5rem 0;
            min-width: 150px;
        }
        .action-dropdown .dropdown-item {
            padding: 0.5rem 1rem;
            color: var(--bs-body-color);
            transition: all 0.3s ease;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
        }
        .action-dropdown .dropdown-item:hover {
            background-color: #f8f9fc;
            color: rgba(var(--bs-primary-rgb), 1);
        }
        .action-dropdown .dropdown-item i {
            font-size: 1rem;
            margin-right: 0.5rem;
        }
        .action-dropdown .action-btn::after {
            display: inline-block;
            margin-left: 0.5rem;
            vertical-align: middle;
            content: "";
            border-top: 0.3em solid;
            border-right: 0.3em solid transparent;
            border-left: 0.3em solid transparent;
        }
        
        /* 页面类型标识 */
        .page-indicator {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 500;
            margin-left: 1rem;
            background: rgba(var(--bs-primary-rgb), 0.1);
            color: rgba(var(--bs-primary-rgb), 1);
        }
        .page-indicator.starred {
            background: rgba(255, 193, 7, 0.1);
            color: #ffc107;
        }
        .page-indicator.recycle {
            background: rgba(220, 53, 69, 0.1);
            color: #dc3545;
        }

        /* 删除确认模态框 */
        .delete-modal .modal-content {
            border-radius: 12px;
            border: none;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            overflow: hidden;
        }
        .delete-modal .modal-header {
            background: linear-gradient(135deg, #ff6b6b, #ff5252);
            color: white;
            border-bottom: none;
            padding: 1.25rem 1.5rem;
        }
        .delete-modal .modal-title {
            font-weight: 600;
            font-size: 1.1rem;
        }
        .delete-modal .modal-body {
            padding: 2rem 1.5rem;
            text-align: center;
        }
        .delete-modal .warning-icon {
            font-size: 3rem;
            color: #ff6b6b;
            margin-bottom: 1rem;
        }
        .delete-modal .delete-message {
            font-size: 1.1rem;
            color: #2c3e50;
            margin-bottom: 0.5rem;
            font-weight: 500;
        }
        .delete-modal .delete-hint {
            color: #6c757d;
            font-size: 0.9rem;
        }
        .delete-modal .modal-footer {
            border-top: 1px solid #e9ecef;
            padding: 1rem 1.5rem;
            gap: 0.75rem;
        }
        .delete-modal .btn-cancel {
            background: #f8f9fa;
            border: 1px solid #dee2e6;
            color: #6c757d;
            padding: 0.5rem 1.5rem;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .delete-modal .btn-cancel:hover {
            background: #e9ecef;
            color: #495057;
        }
        .delete-modal .btn-delete {
            background: linear-gradient(135deg, #ff6b6b, #ff5252);
            border: none;
            color: white;
            padding: 0.5rem 1.5rem;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .delete-modal .btn-delete:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.4);
        }
        
        /* 响应式设计 */
        @media (max-width: 768px) {
            .sidebar {
                display: none;
            }
            .content-area {
                padding: 1rem;
            }
            .page-header {
                flex-direction: column;
                gap: 1rem;
                text-align: center;
            }
            .questionnaire-header {
                flex-direction: column;
                gap: 1rem;
            }
            .questionnaire-actions {
                justify-content: center;
            }
            .promo-stats {
                justify-content: center;
            }
            .promo-card {
                padding: 1.5rem;
            }
            .promo-title {
                font-size: 1.2rem;
            }
            .promo-icon {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
    <!-- 顶部导航栏 -->
    <nav class="navbar navbar-expand-lg top-navbar fixed-top">
        <div class="container-fluid">
            <a class="navbar-brand" href="<c:url value='/questionnaire/list'/>">
                <i class="bi bi-card-checklist"></i>
                问卷星
            </a>
            <div class="top-nav-menu">
                <a href="<c:url value='/questionnaire/list'/>" class="top-nav-item active">
                    <i class="bi bi-journal-text"></i> 我的问卷
                </a>
                <a href="#" class="top-nav-item">
                    <i class="bi bi-people"></i> 通讯录
                </a>
                <a href="#" class="top-nav-item">
                    <i class="bi bi-grid-3x3-gap"></i> 应用
                </a>
            </div>
            <div class="user-info ms-auto">
                <span class="user-phone">${user.username}</span>
                <a class="btn btn-outline-light btn-sm" href="<c:url value='/user/logout'/>">
                    <i class="bi bi-box-arrow-right"></i> 退出
                </a>
            </div>
        </div>
    </nav>

    <div class="main-container">
        <!-- 左侧边栏 -->
        <div class="sidebar">
            <ul class="sidebar-menu">
                <li class="sidebar-menu-item">
                    <a href="<c:url value='/questionnaire/create'/>" class="sidebar-menu-link">
                        <i class="bi bi-plus-circle"></i>
                        创建问卷
                    </a>
                </li>
                <li class="sidebar-menu-item">
                    <a href="<c:url value='/questionnaire/list'/>" class="sidebar-menu-link ${empty pageTitle || pageTitle == '问卷列表' ? 'active' : ''}">
                        <i class="bi bi-list-ul"></i>
                        全部问卷
                    </a>
                </li>
                <li class="sidebar-menu-item">
                    <a href="<c:url value='/questionnaire/starred'/>" class="sidebar-menu-link ${pageTitle == '星标问卷' ? 'active' : ''}">
                        <i class="bi bi-star"></i>
                        星标问卷
                    </a>
                </li>
                <li class="sidebar-menu-item">
                    <a href="<c:url value='/questionnaire/folders'/>" class="sidebar-menu-link">
                        <i class="bi bi-folder"></i>
                        文件夹
                    </a>
                </li>
                <li class="sidebar-menu-item">
                    <a href="<c:url value='/questionnaire/recycle'/>" class="sidebar-menu-link ${pageTitle == '回收站' ? 'active' : ''}">
                        <i class="bi bi-trash"></i>
                        回收站
                    </a>
                </li>
            </ul>
        </div>

        <!-- 内容区域 -->
        <div class="content-area">
            <!-- 微信绑定提示 -->
            <div class="alert wechat-bind-alert alert-dismissible fade show" role="alert">
                <div class="d-flex align-items-center justify-content-between">
                    <div class="d-flex align-items-center">
                        <i class="bi bi-wechat me-3" style="font-size: 2rem;"></i>
                        <div>
                            <h6 class="mb-1">绑定微信，随时随地管理问卷</h6>
                            <p class="mb-0 small">绑定微信后，可在手机同步编辑、管理问卷，实时掌握数据动态</p>
                        </div>
                    </div>
                    <div>
                        <button type="button" class="btn btn-outline-light btn-sm me-2">绑定微信</button>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert"></button>
                    </div>
                </div>
            </div>

            <!-- 页面头部 -->
            <div class="page-header">
                <div style="display: flex; align-items: center;">
                    <h1 class="page-title">
                        <c:choose>
                            <c:when test="${pageTitle == '星标问卷'}">
                                <i class="bi bi-star-fill me-2" style="color: #ffc107;"></i>星标问卷
                            </c:when>
                            <c:when test="${pageTitle == '回收站'}">
                                <i class="bi bi-trash-fill me-2" style="color: #dc3545;"></i>回收站
                            </c:when>
                            <c:when test="${not empty param.folderId}">
                                <i class="bi bi-folder2 me-2" style="color: #4e73df;"></i>${pageTitle}
                            </c:when>
                            <c:otherwise>
                                <i class="bi bi-list-ul me-2"></i>全部问卷
                            </c:otherwise>
                        </c:choose>
                    </h1>
                    <c:if test="${pageTitle == '星标问卷'}">
                        <span class="page-indicator starred">
                            <i class="bi bi-star-fill"></i> 星标问卷
                        </span>
                    </c:if>
                    <c:if test="${pageTitle == '回收站'}">
                        <span class="page-indicator recycle">
                            <i class="bi bi-trash"></i> 回收站
                        </span>
                    </c:if>
                    <c:if test="${not empty param.folderId}">
                        <span class="page-indicator">
                            <i class="bi bi-folder2"></i> 文件夹
                        </span>
                    </c:if>
                </div>
                <c:if test="${pageTitle != '回收站'}">
                    <a href="<c:url value='/questionnaire/create'/>" class="btn btn-primary create-btn">
                        <i class="bi bi-plus-lg"></i> 创建问卷
                    </a>
                </c:if>
            </div>

            <!-- 筛选栏 -->
            <div class="filter-bar">
                <div class="filter-group">
                    <label class="form-label mb-0">状态：</label>
                    <select class="filter-select">
                        <option value="">全部状态</option>
                        <option value="draft">未发布</option>
                        <option value="published">已发布</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label class="form-label mb-0">排序：</label>
                    <select class="filter-select">
                        <option value="time-desc">时间倒序</option>
                        <option value="time-asc">时间正序</option>
                        <option value="title">标题排序</option>
                    </select>
                </div>
            </div>

            <!-- 消息提示 -->
            <c:if test="${not empty message}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="bi bi-check-circle-fill me-2"></i>${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- 问卷列表 -->
            <c:choose>
                <c:when test="${not empty questionnaires}">
                    <c:forEach items="${questionnaires}" var="q">
                        <div class="questionnaire-card ${q.status == 2 ? 'status-published' : 'status-draft'}">
                            <div class="questionnaire-header">
                                <div>
                                    <h3 class="questionnaire-title">${q.title}</h3>
                                    <div class="questionnaire-id">ID: ${q.id}</div>
                                </div>
                                <div class="status-badge ${q.status == 2 ? 'status-published' : 'status-draft'}">
                                    ${q.statusDesc}
                                </div>
                            </div>
                            
                            <div class="questionnaire-stats">
                                <div class="stat-item">
                                    <i class="bi bi-calendar3"></i>
                                    <span data-create-time="${q.createTime}">创建时间：<fmt:formatDate value="${q.createTime}" pattern="MM月dd日 HH:mm"/></span>
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
                                        <a href="<c:url value='/questionnaire/restore/${q.id}'/>" class="action-btn">
                                            <i class="bi bi-arrow-counterclockwise"></i> 恢复
                                        </a>
                                        <a href="<c:url value='/questionnaire/permanentdelete/${q.id}'/>" class="action-btn danger" onclick="showDeleteConfirm(event, 'permanent', '${q.title}')">
                                            <i class="bi bi-trash-fill"></i> 永久删除
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <c:if test="${q.status == 2}">
                                            <a href="<c:url value='/answer/fill/${q.id}?preview=true'/>" class="action-btn" target="_blank">
                                                <i class="bi bi-eye"></i> 预览问卷
                                            </a>
                                            <div class="dropdown action-dropdown">
                                                <button class="action-btn" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                    <i class="bi bi-send"></i> 发送问卷
                                                </button>
                                                <ul class="dropdown-menu">
                                                    <li><a class="dropdown-item" href="#" onclick="showQRCode(${q.id})"><i class="bi bi-qr-code me-2"></i>二维码</a></li>
                                                    <li><a class="dropdown-item" href="#" onclick="copyLink(${q.id})"><i class="bi bi-link-45deg me-2"></i>复制链接</a></li>
                                                </ul>
                                            </div>
                                        </c:if>
                                        <c:if test="${q.status == 1}">
                                            <a href="<c:url value='/questionnaire/publish/${q.id}'/>" class="action-btn primary">
                                                <i class="bi bi-send"></i> 发布
                                            </a>
                                        </c:if>
                                        <a href="<c:url value='/questionnaire/design/${q.id}'/>" class="action-btn">
                                            <i class="bi bi-gear"></i> 设计问卷
                                        </a>
                                        <a href="<c:url value='/statistics/view/${q.id}'/>" class="action-btn">
                                            <i class="bi bi-pie-chart"></i> 分析&下载
                                        </a>
                                        <c:if test="${q.createdBy == user.id || user.role == 'admin' || user.role == 'administrator'}">
                                            <c:choose>
                                                <c:when test="${q.isStarred == 0}">
                                                    <a href="<c:url value='/questionnaire/star/${q.id}'/>" class="action-btn">
                                                        <i class="bi bi-star"></i> 星标
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="<c:url value='/questionnaire/unstar/${q.id}'/>" class="action-btn">
                                                        <i class="bi bi-star-fill" style="color: #ffc107;"></i> 取消星标
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                            <a href="<c:url value='/questionnaire/edit/${q.id}'/>" class="action-btn">
                                                <i class="bi bi-pencil"></i> 编辑
                                            </a>
                                            <a href="#" class="action-btn" onclick="copyQuestionnaire(${q.id})">
                                                <i class="bi bi-files"></i> 复制
                                            </a>
                                            <a href="#" class="action-btn" onclick="moveToFolder(${q.id})">
                                                <i class="bi bi-tag"></i> 分类
                                            </a>
                                            <a href="<c:url value='/questionnaire/softdelete/${q.id}'/>" class="action-btn danger" onclick="showDeleteConfirm(event, 'soft', '${q.title}')">
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
                    <div class="empty-state">
                        <div class="icon"><i class="bi bi-journal-x"></i></div>
                        <h4>
                            <c:choose>
                                <c:when test="${pageTitle == '星标问卷'}">暂无星标问卷</c:when>
                                <c:otherwise>暂无问卷</c:otherwise>
                            </c:choose>
                        </h4>
                        <p class="text-muted">
                            <c:choose>
                                <c:when test="${pageTitle == '星标问卷'}">
                                    点击问卷的星标按钮，将问卷添加到星标
                                </c:when>
                                <c:otherwise>
                                    点击上方的"创建问卷"按钮，开始你的第一次创建吧！
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <c:if test="${pageTitle != '星标问卷'}">
                            <a href="<c:url value='/questionnaire/create'/>" class="btn btn-primary mt-3">
                                <i class="bi bi-plus-lg"></i> 创建问卷
                            </a>
                        </c:if>
                    </div>
                </c:otherwise>
            </c:choose>

            <!-- 样本服务推广模块 -->
            <div class="sample-service-promo mt-5">
                <div class="promo-card">
                    <div class="promo-icon">
                        <i class="bi bi-people-fill"></i>
                    </div>
                    <div class="promo-content">
                        <h5 class="promo-title">使用问卷星样本服务，快速回收高质量答卷</h5>
                        <p class="promo-desc">已精准收集超过 5800 万样本，登记人群需求，助您快速完成调研目标</p>
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
                        <button class="btn btn-primary promo-btn">
                            <i class="bi bi-clipboard-data"></i> 登记人群需求
                        </button>
                    </div>
                </div>
            </div>
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
                    <div class="delete-hint" style="color: #dc3545;">此操作不可恢复，请谨慎操作！</div>
                    <div class="input-verify-area" style="margin-top: 1.5rem;">
                        <input type="text" class="form-control" id="permanentVerifyInput" placeholder="请输入问卷标题">
                        <div class="alert alert-danger mt-2" id="verifyErrorAlert" style="display: none; font-size: 0.9rem; padding: 0.5rem 1rem;">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>
                            <span id="verifyErrorText">输入错误，请重新输入问卷标题！</span>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-cancel" data-bs-dismiss="modal">
                        取消
                    </button>
                    <button type="button" class="btn btn-delete" id="permanentConfirmBtn">
                        <span id="permanentConfirmBtnText">完成验证</span>
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script src="/resources/js/bootstrap/bootstrap.bundle.min.js"></script>
    <script>
        // 设置登录标记，表示用户已经登录过
        document.addEventListener('DOMContentLoaded', function() {
            localStorage.setItem('hasLoggedIn', 'true');
            
            // 检查是否是刚登录进来的
            const justLoggedIn = sessionStorage.getItem('justLoggedIn');
            if (justLoggedIn === 'true') {
                // 显示简单欢迎提示
                showWelcomeToast();
                sessionStorage.removeItem('justLoggedIn');
            }
        });
        
        // 简单欢迎提示函数
        function showWelcomeToast() {
            const welcomeToast = document.createElement('div');
            welcomeToast.className = 'welcome-toast show';
            welcomeToast.innerHTML = `
                <div class="welcome-toast-header">
                    <i class="bi bi-check-circle-fill me-2"></i>
                    <strong>登录成功</strong>
                </div>
                <div class="welcome-toast-body">
                    欢迎回来！正在为您加载问卷管理后台...
                </div>
            `;
            
            document.body.appendChild(welcomeToast);
            
            // 3秒后自动隐藏
            setTimeout(() => {
                welcomeToast.remove();
            }, 3000);
        }
        
        // 状态筛选功能
        const statusFilter = document.querySelector('.filter-bar select');
        const sortFilter = document.querySelectorAll('.filter-bar select')[1];
        
        // 状态筛选
        statusFilter.addEventListener('change', function() {
            filterAndSortQuestionnaires();
        });
        
        // 排序筛选
        sortFilter.addEventListener('change', function() {
            filterAndSortQuestionnaires();
        });
        
        // 筛选和排序问卷
        function filterAndSortQuestionnaires() {
            const statusValue = statusFilter.value;
            const sortValue = sortFilter.value;
            const questionnaireCards = document.querySelectorAll('.questionnaire-card');
            
            // 转换问卷卡片为数组以便排序
            const cardsArray = Array.from(questionnaireCards);
            
            // 筛选
            cardsArray.forEach(card => {
                const statusBadge = card.querySelector('.status-badge');
                const statusText = statusBadge.textContent.trim();
                
                let shouldShow = true;
                
                if (statusValue === 'draft') {
                    shouldShow = statusText === '草稿';
                } else if (statusValue === 'published') {
                    shouldShow = statusText === '已发布';
                }
                
                if (shouldShow) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
            
            // 排序
            const visibleCards = cardsArray.filter(card => card.style.display !== 'none');
            const container = document.querySelector('.content-area');
            
            // 移除所有卡片
            visibleCards.forEach(card => card.remove());
            
            // 按排序规则重新排列
            visibleCards.sort((a, b) => {
                switch (sortValue) {
                    case 'time-desc': // 时间倒序（最新在前）
                        const timeA = a.querySelector('[data-create-time]').getAttribute('data-create-time');
                        const timeB = b.querySelector('[data-create-time]').getAttribute('data-create-time');
                        return new Date(timeB) - new Date(timeA);
                    
                    case 'time-asc': // 时间正序（最旧在前）
                        const timeA2 = a.querySelector('[data-create-time]').getAttribute('data-create-time');
                        const timeB2 = b.querySelector('[data-create-time]').getAttribute('data-create-time');
                        return new Date(timeA2) - new Date(timeB2);
                    
                    case 'title': // 标题排序（按字母顺序）
                        const titleA = a.querySelector('.questionnaire-title').textContent.trim().toLowerCase();
                        const titleB = b.querySelector('.questionnaire-title').textContent.trim().toLowerCase();
                        return titleA.localeCompare(titleB);
                    
                    default:
                        return 0;
                }
            });
            
            // 重新插入排序后的卡片
            const sampleServicePromo = document.querySelector('.sample-service-promo');
            
            // 检查是否有可见的卡片
            if (visibleCards.length === 0) {
                // 没有问卷，显示空状态
                const emptyState = document.createElement('div');
                emptyState.className = 'empty-state';
                emptyState.id = 'filterEmptyState';
                
                // 根据当前页面类型显示不同的提示
                const pageTitle = document.querySelector('.page-title').textContent.trim();
                let emptyTitle = '暂无问卷';
                let emptyMessage = '没有找到符合条件的问卷';
                let buttonHtml = '';
                
                if (pageTitle.includes('星标问卷')) {
                    emptyTitle = '暂无星标问卷';
                    emptyMessage = '点击问卷的星标按钮，将问卷添加到星标';
                } else if (statusValue === 'draft') {
                    emptyTitle = '暂无草稿问卷';
                    emptyMessage = '创建新的问卷或编辑已有问卷';
                } else if (statusValue === 'published') {
                    emptyTitle = '暂无已发布问卷';
                    emptyMessage = '发布问卷后即可查看';
                }
                
                emptyState.innerHTML = `
                    <div class="icon"><i class="bi bi-journal-x"></i></div>
                    <h4>${emptyTitle}</h4>
                    <p class="text-muted">${emptyMessage}</p>
                    ${buttonHtml}
                `;
                
                container.insertBefore(emptyState, sampleServicePromo);
            } else {
                // 有问卷，如果有空状态则移除
                const existingEmptyState = document.getElementById('filterEmptyState');
                if (existingEmptyState) {
                    existingEmptyState.remove();
                }
                
                // 插入问卷卡片
                visibleCards.forEach(card => {
                    container.insertBefore(card, sampleServicePromo);
                });
            }
        }
        
        // 时间格式化函数
        function formatTime(timeStr) {
            if (!timeStr || timeStr === 'Invalid Date') return '时间未知';
            
            const date = new Date(timeStr);
            if (isNaN(date.getTime())) return '时间未知';
            
            const now = new Date();
            const diff = now - date;
            const days = Math.floor(diff / (1000 * 60 * 60 * 24));
            
            if (days < 0) {
                // 未来时间，显示具体日期（带年份）
                return date.toLocaleDateString('zh-CN', {year: 'numeric', month: 'numeric', day: 'numeric', hour: '2-digit', minute: '2-digit'});
            } else if (days === 0) {
                return '今天 ' + date.toLocaleTimeString('zh-CN', {hour: '2-digit', minute: '2-digit'});
            } else if (days === 1) {
                return '昨天 ' + date.toLocaleTimeString('zh-CN', {hour: '2-digit', minute: '2-digit'});
            } else if (days < 7) {
                return days + '天前';
            } else {
                // 超过7天显示完整日期（带年份）
                return date.toLocaleDateString('zh-CN', {year: 'numeric', month: 'numeric', day: 'numeric', hour: '2-digit', minute: '2-digit'});
            }
        }
        
        // 更新所有时间显示
        document.querySelectorAll('.questionnaire-stats .stat-item span[data-create-time]').forEach(function(span) {
            const timeStr = span.getAttribute('data-create-time');
            if (timeStr && timeStr !== 'Invalid Date' && timeStr !== '') {
                span.textContent = '创建时间：' + formatTime(timeStr);
            }
        });
        
        // 显示二维码功能
        function showQRCode(id) {
            alert('二维码功能开发中，问卷ID: ' + id);
            // 这里可以添加显示问卷二维码的逻辑
        }
        
        // 复制链接功能
        function copyLink(id) {
            const link = window.location.origin + '/answer/fill/' + id;
            
            // 创建链接弹窗
            const linkModal = document.createElement('div');
            linkModal.className = 'modal fade show';
            linkModal.style.display = 'block';
            linkModal.style.backgroundColor = 'rgba(0,0,0,0.5)';
            linkModal.innerHTML = `
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">
                                <i class="bi bi-link-45deg me-2"></i>
                                问卷链接
                            </h5>
                            <button type="button" class="btn-close" onclick="closeLinkModal()"></button>
                        </div>
                        <div class="modal-body">
                            <div class="mb-3">
                                <label class="form-label">问卷链接：</label>
                                <div class="input-group">
                                    <input type="text" class="form-control" id="shareLinkInput" value="${link}" readonly>
                                    <button class="btn btn-primary" type="button" onclick="copyLinkToClipboard()">
                                        <i class="bi bi-clipboard me-1"></i>复制
                                    </button>
                                </div>
                            </div>
                            <div class="alert alert-info" style="font-size: 0.9rem; display: none;" id="copySuccessAlert">
                                <i class="bi bi-info-circle-fill me-2"></i>
                                链接已复制到剪贴板，可以直接分享给受访者
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" onclick="closeLinkModal()">关闭</button>
                        </div>
                    </div>
                </div>
            `;
            
            document.body.appendChild(linkModal);
            
            // 自动复制到剪贴板
            setTimeout(() => {
                copyLinkToClipboard();
            }, 100);
        }
        
        // 复制到剪贴板
        function copyLinkToClipboard() {
            const linkInput = document.getElementById('shareLinkInput');
            if (linkInput) {
                linkInput.select();
                navigator.clipboard.writeText(linkInput.value).then(function() {
                    // 显示复制成功提示
                    const alert = document.getElementById('copySuccessAlert');
                    if (alert) {
                        alert.style.display = 'block';
                    }
                }).catch(function(err) {
                    console.error('复制失败:', err);
                });
            }
        }
        
        // 关闭链接弹窗
        function closeLinkModal() {
            const modal = document.querySelector('.modal.show');
            if (modal) {
                modal.remove();
            }
        }
        
        // 复制问卷功能
        function copyQuestionnaire(id) {
            if (confirm('确定要复制这份问卷吗？')) {
                alert('复制问卷功能开发中，问卷ID: ' + id);
                // 这里可以添加复制问卷的逻辑
            }
        }
        
        // 移动到文件夹功能（弹出文件夹选择）
        function moveToFolder(questionnaireId) {
            // 创建文件夹选择弹窗
            const folderModal = document.createElement('div');
            folderModal.className = 'modal fade show';
            folderModal.style.display = 'block';
            folderModal.style.backgroundColor = 'rgba(0,0,0,0.5)';
            
            // 先显示加载状态
            folderModal.innerHTML = `
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">
                                <i class="bi bi-folder me-2"></i>
                                选择文件夹
                            </h5>
                            <button type="button" class="btn-close" onclick="closeFolderModal()"></button>
                        </div>
                        <div class="modal-body">
                            <div class="text-center py-4">
                                <div class="spinner-border text-primary" role="status">
                                    <span class="visually-hidden">加载中...</span>
                                </div>
                                <p class="mt-2 text-muted">正在加载文件夹...</p>
                            </div>
                        </div>
                    </div>
                </div>
            `;
            
            document.body.appendChild(folderModal);
            
            // 从后端获取文件夹列表
            fetch('/folder/api/list')
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        // 构建下拉框选项HTML
                        let folderOptions = '';
                        const folders = data.folders;
                        
                        if (folders && folders.length > 0) {
                            folders.forEach(function(folder) {
                                folderOptions += '<option value="' + folder.id + '">' + folder.name + '</option>';
                            });
                        } else {
                            folderOptions = '<option value="" disabled>暂无文件夹</option>';
                        }
                        
                        // 更新弹窗内容
                        folderModal.innerHTML = 
                            '<div class="modal-dialog modal-dialog-centered">' +
                                '<div class="modal-content">' +
                                    '<div class="modal-header">' +
                                        '<h5 class="modal-title">' +
                                            '<i class="bi bi-folder me-2"></i>' +
                                            '选择文件夹' +
                                        '</h5>' +
                                        '<button type="button" class="btn-close" onclick="closeFolderModal()"></button>' +
                                    '</div>' +
                                    '<div class="modal-body">' +
                                        '<div class="mb-3">' +
                                            '<label class="form-label">请选择要移动到的文件夹：</label>' +
                                            '<select class="form-select form-select-lg" id="folderSelect" style="padding: 0.75rem 1rem; font-size: 1rem;">' +
                                                '<option value="">-- 请选择文件夹 --</option>' +
                                                folderOptions +
                                            '</select>' +
                                        '</div>' +
                                        '<hr class="my-4">' +
                                        '<div class="create-folder-section">' +
                                            '<h6 class="mb-3"><i class="bi bi-plus-circle me-2"></i>创建新文件夹</h6>' +
                                            '<div class="input-group">' +
                                                '<input type="text" class="form-control" id="newFolderName" placeholder="输入新文件夹名称">' +
                                                '<button class="btn btn-outline-primary" type="button" onclick="createNewFolder()">' +
                                                    '<i class="bi bi-plus-lg me-1"></i>创建' +
                                                '</button>' +
                                            '</div>' +
                                            '<div class="form-text">快速创建新的文件夹分类</div>' +
                                            '<div id="createFolderAlert" class="mt-2" style="display: none;"></div>' +
                                        '</div>' +
                                        '<div class="alert alert-info mt-3 mb-0" style="font-size: 0.9rem;">' +
                                            '<i class="bi bi-info-circle-fill me-2"></i>' +
                                            '选择文件夹后，点击确定移动问卷' +
                                        '</div>' +
                                    '</div>' +
                                    '<div class="modal-footer">' +
                                        '<button type="button" class="btn btn-cancel" onclick="closeFolderModal()">取消</button>' +
                                        '<button type="button" class="btn btn-primary" onclick="confirmMoveToFolder(' + questionnaireId + ')">' +
                                            '<i class="bi bi-check-lg me-1"></i>确定' +
                                        '</button>' +
                                    '</div>' +
                                '</div>' +
                            '</div>';
                    } else {
                        alert('获取文件夹失败：' + data.message);
                        closeFolderModal();
                    }
                })
                .catch(error => {
                    console.error('获取文件夹失败:', error);
                    alert('获取文件夹失败，请稍后重试');
                    closeFolderModal();
                });
        }
        
        // 创建新文件夹
        function createNewFolder() {
            const folderNameInput = document.getElementById('newFolderName');
            const folderName = folderNameInput.value.trim();
            const alertDiv = document.getElementById('createFolderAlert');
            
            // 隐藏之前的提示
            alertDiv.style.display = 'none';
            
            if (!folderName) {
                // 使用Bootstrap样式显示错误
                alertDiv.className = 'alert alert-danger mt-2';
                alertDiv.innerHTML = '<i class="bi bi-exclamation-circle-fill me-2"></i>请输入文件夹名称';
                alertDiv.style.display = 'block';
                folderNameInput.focus();
                return;
            }
            
            // 调用后端API创建文件夹
            fetch('/folder/api/create', {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify({name: folderName})
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // 使用Bootstrap样式显示成功
                    alertDiv.className = 'alert alert-success mt-2';
                    alertDiv.innerHTML = '<i class="bi bi-check-circle-fill me-2"></i>文件夹创建成功！';
                    alertDiv.style.display = 'block';
                    
                    folderNameInput.value = '';
                    
                    // 重新加载文件夹列表
                    const folderSelect = document.getElementById('folderSelect');
                    const newOption = document.createElement('option');
                    newOption.value = data.folder.id;
                    newOption.textContent = data.folder.name;
                    newOption.selected = true;
                    folderSelect.appendChild(newOption);
                    
                    // 3秒后隐藏提示
                    setTimeout(() => {
                        alertDiv.style.display = 'none';
                    }, 3000);
                } else {
                    // 使用Bootstrap样式显示错误
                    alertDiv.className = 'alert alert-danger mt-2';
                    alertDiv.innerHTML = `<i class="bi bi-exclamation-circle-fill me-2"></i>${data.message}`;
                    alertDiv.style.display = 'block';
                }
            })
            .catch(error => {
                console.error('创建文件夹失败:', error);
                alertDiv.className = 'alert alert-danger mt-2';
                alertDiv.innerHTML = '<i class="bi bi-exclamation-circle-fill me-2"></i>创建文件夹失败，请稍后重试';
                alertDiv.style.display = 'block';
            });
        }
        
        // 确认移动到文件夹
        function confirmMoveToFolder(questionnaireId) {
            const folderSelect = document.getElementById('folderSelect');
            const selectedFolderId = folderSelect.value;
            const selectedFolderName = folderSelect.options[folderSelect.selectedIndex].text;
            
            if (selectedFolderId && selectedFolderId !== '') {
                const folderId = parseInt(selectedFolderId);
                
                // 调用后端API移动问卷到指定文件夹
                fetch('/questionnaire/api/moveToFolder', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify({questionnaireId: questionnaireId, folderId: folderId})
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert(`已将问卷移动到文件夹：${selectedFolderName}`);
                        // 刷新页面或更新UI
                        location.reload();
                    } else {
                        alert('移动失败：' + data.message);
                    }
                })
                .catch(error => {
                    console.error('移动失败:', error);
                    alert('移动失败，请稍后重试');
                })
                .finally(() => {
                    closeFolderModal();
                });
            } else {
                alert('请选择一个文件夹！');
            }
        }
        
        // 关闭文件夹弹窗
        function closeFolderModal() {
            const modal = document.querySelector('.modal.show');
            if (modal) {
                modal.remove();
            }
        }
        
        // 删除确认模态框相关函数
        let deleteFormUrl = '';
        let deleteType = '';
        let questionnaireTitle = '';
        let countdownInterval = null;
        
        function showDeleteConfirm(event, type, title) {
            event.preventDefault();
            const link = event.currentTarget;
            deleteFormUrl = link.href;
            deleteType = type;
            questionnaireTitle = title;
            
            if (type === 'permanent') {
                // 永久删除直接显示验证弹窗，传递标题参数
                showPermanentDeleteVerify(title);
            } else {
                // 软删除显示确认弹窗
                const deleteMessage = document.getElementById('deleteMessage');
                const deleteHint = document.getElementById('deleteHint');
                const confirmBtnText = document.getElementById('confirmBtnText');
                const confirmBtn = document.getElementById('confirmDeleteBtn');
                const modalTitle = document.getElementById('modalTitle');
                
                // 重置按钮
                confirmBtn.disabled = false;
                confirmBtnText.textContent = '删除';
                
                modalTitle.textContent = '确认删除';
                deleteMessage.textContent = '确定要删除此问卷吗？';
                deleteHint.textContent = '删除后可在回收站恢复。';
                deleteHint.style.color = '#6c757d';
                
                const modal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
                modal.show();
            }
        }
        
        // 显示永久删除验证模态框
        function showPermanentDeleteVerify(title) {
            const verifyModal = new bootstrap.Modal(document.getElementById('permanentDeleteVerifyModal'));
            const verifyBtn = document.getElementById('permanentConfirmBtn');
            const verifyBtnText = document.getElementById('permanentConfirmBtnText');
            const verifyInput = document.getElementById('permanentVerifyInput');
            const verifyMessage = document.getElementById('verifyMessage');
            
            // 重置
            verifyInput.value = '';
            verifyBtn.disabled = false; // 按钮不禁用，点击时验证
            
            // 使用传递的标题参数（而不是全局变量）
            const actualTitle = title || questionnaireTitle || '未命名问卷';
            
            // 动态显示问卷标题
            const message = '请手动输入问卷标题"' + actualTitle + '"';
            const placeholder = '输入问卷标题"' + actualTitle + '"';
            
            verifyMessage.textContent = message;
            verifyInput.placeholder = placeholder;
            
            // 启动验证按钮倒计时
            let remaining = 3;
            countdownInterval = setInterval(function() {
                if (remaining > 0) {
                    verifyBtnText.textContent = '请稍候 (' + remaining + '秒)';
                    verifyBtn.disabled = true; // 倒计时期间禁用
                    remaining--;
                } else {
                    clearInterval(countdownInterval);
                    countdownInterval = null;
                    verifyBtnText.textContent = '完成验证';
                    verifyBtn.disabled = false; // 倒计时结束启用
                }
            }, 1000);
            
            verifyModal.show();
        }
        
        // 软删除确认按钮点击事件
        document.getElementById('confirmDeleteBtn').addEventListener('click', function() {
            if (deleteFormUrl) {
                window.location.href = deleteFormUrl;
            }
        });
        
        // 永久删除验证确认按钮
        document.getElementById('permanentConfirmBtn').addEventListener('click', function() {
            const verifyInput = document.getElementById('permanentVerifyInput');
            const inputValue = verifyInput.value.trim();
            const errorAlert = document.getElementById('verifyErrorAlert');
            
            // 验证输入是否正确
            if (inputValue === questionnaireTitle) {
                // 输入正确，执行删除
                if (deleteFormUrl) {
                    window.location.href = deleteFormUrl;
                }
            } else {
                // 输入错误，显示错误提示
                errorAlert.style.display = 'block';
                verifyInput.value = '';
                verifyInput.focus();
                
                // 3秒后自动隐藏错误提示
                setTimeout(function() {
                    errorAlert.style.display = 'none';
                }, 3000);
            }
        });
        
        // 输入时隐藏错误提示
        document.getElementById('permanentVerifyInput').addEventListener('input', function() {
            const errorAlert = document.getElementById('verifyErrorAlert');
            errorAlert.style.display = 'none';
        });
        
        // 模态框关闭时重置状态
        document.getElementById('deleteConfirmModal').addEventListener('hidden.bs.modal', function() {
            deleteFormUrl = '';
            deleteType = '';
            questionnaireTitle = '';
        });
        
        // 永久删除验证模态框关闭时重置
        document.getElementById('permanentDeleteVerifyModal').addEventListener('hidden.bs.modal', function() {
            document.getElementById('permanentVerifyInput').value = '';
            document.getElementById('permanentConfirmBtn').disabled = true;
            
            // 清除倒计时
            if (countdownInterval) {
                clearInterval(countdownInterval);
                countdownInterval = null;
            }
            
            // 重置表单数据
            deleteFormUrl = '';
            deleteType = '';
            questionnaireTitle = '';
        });
        
        // 绑定微信功能
        document.addEventListener('DOMContentLoaded', function() {
            const bindWechatBtn = document.querySelector('.wechat-bind-alert .btn-outline-light');
            if (bindWechatBtn) {
                bindWechatBtn.addEventListener('click', function() {
                    alert('微信绑定功能开发中，敬请期待！');
                });
            }
            
            // 样本服务推广按钮
            const promoBtn = document.querySelector('.promo-btn');
            if (promoBtn) {
                promoBtn.addEventListener('click', function() {
                    alert('样本服务登记功能开发中，敬请期待！');
                });
            }
        });
    </script>
</body>
</html>