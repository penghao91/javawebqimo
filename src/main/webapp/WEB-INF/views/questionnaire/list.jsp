<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>我的问卷 - 问卷系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css" rel="stylesheet">
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
                    <a href="<c:url value='/questionnaire/recycle'/>" class="sidebar-menu-link ${pageTitle == '回收站' ? 'active' : ''}">
                        <i class="bi bi-trash"></i>
                        回收站
                    </a>
                </li>
                <li class="sidebar-menu-item">
                    <a href="<c:url value='/questionnaire/folders'/>" class="sidebar-menu-link">
                        <i class="bi bi-folder"></i>
                        文件夹
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
                <h1 class="page-title">问卷列表</h1>
                <a href="<c:url value='/questionnaire/create'/>" class="btn btn-primary create-btn">
                    <i class="bi bi-plus-lg"></i> 创建问卷
                </a>
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
                                    <span>创建时间：<fmt:formatDate value="${q.createTime}" pattern="MM月dd日 HH:mm"/></span>
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
                                <c:if test="${q.status == 2}">
                                    <a href="<c:url value='/answer/fill/${q.id}'/>" class="action-btn" target="_blank">
                                        <i class="bi bi-pencil-square"></i> 填写问卷
                                    </a>
                                    <a href="#" class="action-btn" onclick="sendQuestionnaire(${q.id})">
                                        <i class="bi bi-send"></i> 发送问卷
                                    </a>
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
                                        <c:when test="${pageTitle == '回收站'}">
                                            <a href="<c:url value='/questionnaire/restore/${q.id}'/>" class="action-btn">
                                                <i class="bi bi-arrow-counterclockwise"></i> 恢复
                                            </a>
                                            <a href="<c:url value='/questionnaire/permanentdelete/${q.id}'/>" class="action-btn danger" onclick="return confirm('确定要永久删除此问卷吗？此操作不可恢复！')">
                                                <i class="bi bi-trash-fill"></i> 永久删除
                                            </a>
                                        </c:when>
                                        <c:otherwise>
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
                                            <a href="#" class="action-btn" onclick="setReminder(${q.id})">
                                                <i class="bi bi-bell"></i> 提醒
                                            </a>
                                            <a href="#" class="action-btn" onclick="moveToFolder(${q.id})">
                                                <i class="bi bi-folder"></i> 文件夹
                                            </a>
                                            <a href="<c:url value='/questionnaire/softdelete/${q.id}'/>" class="action-btn danger" onclick="return confirm('确定要删除此问卷吗？删除后可在回收站恢复。')">
                                                <i class="bi bi-trash"></i> 删除
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="icon"><i class="bi bi-journal-x"></i></div>
                        <h4>暂无问卷</h4>
                        <p class="text-muted">点击上方的"创建问卷"按钮，开始你的第一次创建吧！</p>
                        <a href="<c:url value='/questionnaire/create'/>" class="btn btn-primary mt-3">
                            <i class="bi bi-plus-lg"></i> 创建问卷
                        </a>
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
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
        document.querySelector('.filter-bar select').addEventListener('change', function() {
            // 这里可以添加筛选逻辑
            console.log('筛选条件改变:', this.value);
        });
        
        // 时间格式化函数
        function formatTime(timeStr) {
            const date = new Date(timeStr);
            const now = new Date();
            const diff = now - date;
            const days = Math.floor(diff / (1000 * 60 * 60 * 24));
            
            if (days === 0) {
                return '今天 ' + date.toLocaleTimeString('zh-CN', {hour: '2-digit', minute: '2-digit'});
            } else if (days === 1) {
                return '昨天 ' + date.toLocaleTimeString('zh-CN', {hour: '2-digit', minute: '2-digit'});
            } else if (days < 7) {
                return days + '天前';
            } else {
                return date.toLocaleDateString('zh-CN', {month: 'numeric', day: 'numeric', hour: '2-digit', minute: '2-digit'});
            }
        }
        
        // 更新所有时间显示
        document.querySelectorAll('.questionnaire-stats .stat-item span').forEach(function(span) {
            const text = span.textContent;
            if (text.includes('创建时间：')) {
                const timeStr = text.replace('创建时间：', '');
                span.textContent = '创建时间：' + formatTime(timeStr);
            }
        });
        
        // 发送问卷功能
        function sendQuestionnaire(id) {
            alert('发送问卷功能开发中，问卷ID: ' + id);
            // 这里可以添加发送问卷的逻辑，比如打开邮件发送窗口或生成分享链接
        }
        
        // 复制问卷功能
        function copyQuestionnaire(id) {
            if (confirm('确定要复制这份问卷吗？')) {
                alert('复制问卷功能开发中，问卷ID: ' + id);
                // 这里可以添加复制问卷的逻辑
            }
        }
        
        // 设置提醒功能
        function setReminder(id) {
            alert('提醒功能开发中，问卷ID: ' + id);
            // 这里可以添加设置提醒的逻辑
        }
        
        // 移动到文件夹功能
        function moveToFolder(id) {
            alert('文件夹功能开发中，问卷ID: ' + id);
            // 这里可以添加移动到文件夹的逻辑
        }
        
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