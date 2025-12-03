<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>文件夹管理 - 问卷星</title>
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
            z-index: 1030;
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
        
        /* 文件夹卡片 */
        .folder-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 1rem;
            padding: 1.5rem 2rem;
            transition: all 0.3s ease;
            border-left: 4px solid transparent;
        }
        .folder-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        .folder-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }
        .folder-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: #2c3e50;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .folder-stats {
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
        .folder-actions {
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
        .action-btn.danger {
            color: #dc3545;
            border-color: #dc3545;
        }
        .action-btn.danger:hover {
            background-color: #dc3545;
            color: white;
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
            .folder-header {
                flex-direction: column;
                gap: 1rem;
            }
            .folder-actions {
                justify-content: center;
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
                <a href="<c:url value='/questionnaire/list'/>" class="top-nav-item">
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
                    <a href="<c:url value='/questionnaire/list'/>" class="sidebar-menu-link">
                        <i class="bi bi-list-ul"></i>
                        全部问卷
                    </a>
                </li>
                <li class="sidebar-menu-item">
                    <a href="<c:url value='/questionnaire/starred'/>" class="sidebar-menu-link">
                        <i class="bi bi-star"></i>
                        星标问卷
                    </a>
                </li>
                <li class="sidebar-menu-item">
                    <a href="<c:url value='/questionnaire/recycle'/>" class="sidebar-menu-link">
                        <i class="bi bi-trash"></i>
                        回收站
                    </a>
                </li>
                <li class="sidebar-menu-item">
                    <a href="<c:url value='/questionnaire/folders'/>" class="sidebar-menu-link active">
                        <i class="bi bi-folder"></i>
                        文件夹
                    </a>
                </li>
            </ul>
        </div>

        <!-- 内容区域 -->
        <div class="content-area">
            <!-- 页面头部 -->
            <div class="page-header">
                <h1 class="page-title">文件夹管理</h1>
                <button class="btn btn-primary create-btn" onclick="createFolder()">
                    <i class="bi bi-plus-lg"></i> 新建文件夹
                </button>
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

            <!-- 文件夹列表 -->
            <div class="folder-list">
                <div class="folder-card">
                    <div class="folder-header">
                        <h3 class="folder-title">
                            <i class="bi bi-folder2" style="color: #ffc107;"></i>
                            默认文件夹
                        </h3>
                    </div>
                    <div class="folder-stats">
                        <div class="stat-item">
                            <i class="bi bi-file-text"></i>
                            <span>问卷数量：<span class="stat-value">0</span></span>
                        </div>
                        <div class="stat-item">
                            <i class="bi bi-calendar3"></i>
                            <span>创建时间：2025-12-03</span>
                        </div>
                    </div>
                    <div class="folder-actions">
                        <a href="<c:url value='/questionnaire/list'/>" class="action-btn">
                            <i class="bi bi-eye"></i> 查看问卷
                        </a>
                        <button class="action-btn" onclick="editFolder(0)">
                            <i class="bi bi-pencil"></i> 重命名
                        </button>
                    </div>
                </div>
                
                <div class="folder-card">
                    <div class="folder-header">
                        <h3 class="folder-title">
                            <i class="bi bi-folder2" style="color: #4e73df;"></i>
                            工作项目
                        </h3>
                    </div>
                    <div class="folder-stats">
                        <div class="stat-item">
                            <i class="bi bi-file-text"></i>
                            <span>问卷数量：<span class="stat-value">0</span></span>
                        </div>
                        <div class="stat-item">
                            <i class="bi bi-calendar3"></i>
                            <span>创建时间：2025-12-03</span>
                        </div>
                    </div>
                    <div class="folder-actions">
                        <a href="#" class="action-btn">
                            <i class="bi bi-eye"></i> 查看问卷
                        </a>
                        <button class="action-btn" onclick="editFolder(1)">
                            <i class="bi bi-pencil"></i> 重命名
                        </button>
                        <button class="action-btn danger" onclick="deleteFolder(1)">
                            <i class="bi bi-trash"></i> 删除
                        </button>
                    </div>
                </div>
            </div>
            
            <!-- 空状态 -->
            <div class="empty-state" style="display: none;">
                <div class="icon"><i class="bi bi-folder2"></i></div>
                <h4>暂无文件夹</h4>
                <p class="text-muted">点击上方的"新建文件夹"按钮创建您的第一个文件夹</p>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // 创建文件夹
        function createFolder() {
            const folderName = prompt('请输入文件夹名称：');
            if (folderName && folderName.trim()) {
                alert('创建文件夹功能开发中，名称：' + folderName.trim());
                // 这里可以添加创建文件夹的API调用
            }
        }
        
        // 编辑文件夹
        function editFolder(folderId) {
            const newName = prompt('请输入新的文件夹名称：');
            if (newName && newName.trim()) {
                alert('重命名文件夹功能开发中，ID：' + folderId + '，新名称：' + newName.trim());
                // 这里可以添加重命名文件夹的API调用
            }
        }
        
        // 删除文件夹
        function deleteFolder(folderId) {
            if (confirm('确定要删除这个文件夹吗？文件夹内的问卷将被移动到默认文件夹。')) {
                alert('删除文件夹功能开发中，ID：' + folderId);
                // 这里可以添加删除文件夹的API调用
            }
        }
    </script>
</body>
</html>
