<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty questionnaire.id ? '创建问卷' : '编辑问卷'} - 问卷星</title>
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
        
        /* 表单样式 */
        .form-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            border: none;
        }
        .form-header {
            padding: 1.5rem 2rem;
            border-bottom: 1px solid var(--border-color);
        }
        .form-header h5 {
            margin: 0;
            font-weight: 600;
            color: #2c3e50;
        }
        .form-body {
            padding: 2rem;
        }
        .form-label {
            font-weight: 500;
            color: #5a5c69;
        }
        .form-control:focus {
            border-color: rgba(var(--bs-primary-rgb), 0.5);
            box-shadow: 0 0 0 0.2rem rgba(var(--bs-primary-rgb), 0.25);
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
                    <a href="<c:url value='/questionnaire/create'/>" class="sidebar-menu-link active">
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
                    <a href="<c:url value='/questionnaire/folders'/>" class="sidebar-menu-link">
                        <i class="bi bi-folder"></i>
                        文件夹
                    </a>
                </li>
                <li class="sidebar-menu-item">
                    <a href="<c:url value='/questionnaire/recycle'/>" class="sidebar-menu-link">
                        <i class="bi bi-trash"></i>
                        回收站
                    </a>
                </li>
            </ul>
        </div>

        <!-- 内容区域 -->
        <div class="content-area">
            <!-- 页面头部 -->
            <div class="page-header">
                <h1 class="page-title">${empty questionnaire.id ? '创建新问卷' : '编辑问卷'}</h1>
                <a href="<c:url value='/questionnaire/list'/>" class="btn btn-secondary">
                    <i class="bi bi-arrow-left"></i> 返回列表
                </a>
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

            <!-- 表单卡片 -->
            <div class="form-card">
                <div class="form-header">
                    <h5>问卷信息</h5>
                </div>
                <div class="form-body">
                    <c:url value='/questionnaire/${empty questionnaire.id ? "create" : "edit/"}${questionnaire.id}' var="formAction"/>
                    
                    <form:form modelAttribute="questionnaire" action="${formAction}" method="post">
                        <div class="mb-3">
                            <form:label path="title" class="form-label">问卷标题 <span class="text-danger">*</span></form:label>
                            <form:input path="title" class="form-control form-control-lg" required="true" maxlength="200" placeholder="请输入问卷标题"/>
                            <form:errors path="title" cssClass="text-danger small mt-1"/>
                            <div class="form-text">建议标题简洁明了，不超过50个字</div>
                        </div>
                        
                        <div class="mb-4">
                            <form:label path="description" class="form-label">问卷描述</form:label>
                            <form:textarea path="description" class="form-control" rows="4" maxlength="1000" placeholder="请输入问卷描述，帮助填写者了解问卷目的"/>
                            <form:errors path="description" cssClass="text-danger small mt-1"/>
                            <div class="form-text">描述问卷的目的、填写说明等，选填项</div>
                        </div>
                        
                        <div class="d-flex justify-content-end gap-2">
                            <a href="<c:url value='/questionnaire/list'/>" class="btn btn-secondary btn-lg">
                                <i class="bi bi-x-lg"></i> 取消
                            </a>
                            <button type="submit" class="btn btn-primary btn-lg">
                                <i class="bi bi-check-lg"></i> ${empty questionnaire.id ? '创建问卷' : '保存修改'}
                            </button>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </div>

    <script src="/resources/js/bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>