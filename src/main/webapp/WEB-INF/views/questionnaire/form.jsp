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
            --primary-color: #4e73df; --primary-dark: #224abe; --secondary-color: #858796;
            --success-color: #1cc88a; --danger-color: #e74a3b; --light-color: #f8f9fc;
            --dark-color: #4b4d63; --muted-color: #a0a3b1; --border-soft: #e1e5f2;
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
        
        .navbar.scrolled {
            padding-top: 0.45rem;
            padding-bottom: 0.45rem;
            background: rgba(255, 255, 255, 0.98);
            box-shadow: 0 10px 30px rgba(15, 23, 42, 0.14);
        }
        
        /* 移动端导航按钮样式统一 */
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
        /* --- 顶部导航栏统一修复结束 --- */
        .navbar-brand { font-weight: 800; font-size: 1.45rem; color: var(--primary-color) !important; display: flex; align-items: center; gap: .4rem; }
        .navbar-brand i { font-size: 1.4rem; color: var(--primary-dark); }
        .user-dropdown-btn { text-decoration: none; font-weight: 500; color: var(--secondary-color) !important; }
        .user-dropdown-btn i { color: var(--primary-color); }
        .user-dropdown-btn:hover { color: var(--primary-color) !important; }
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
        .badge-step { display: inline-flex; align-items: center; gap: .25rem; padding: .25rem .8rem; border-radius: 999px; border: 1px solid rgba(248, 250, 252, 0.9); background: rgba(15,23,42,.15); font-size: .8rem; }
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
        .content-card { 
            background: #ffffff; 
            border-radius: 18px; 
            padding: 22px 24px 20px; 
            box-shadow: 0 14px 40px rgba(15, 23, 42, 0.08); 
            border: 1px solid rgba(226, 232, 240, 0.9); 
            min-height: 400px; /* 统一内容区域最小高度 */
            box-sizing: border-box;
        }
        
        /* 平滑过渡效果，减少抖动感知 */
        .navbar, .design-header, .nav-card, .content-card {
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        
        /* 移动端响应式样式统一 */
        @media (max-width: 991.98px) {
            .navbar-collapse {
                background: #ffffff;
                padding: 0.8rem 0 1rem;
            }
            
            .navbar-collapse .navbar-nav,
            .navbar-collapse > .d-flex {
                background: #ffffff;
                border-radius: 18px;
                box-shadow: 0 18px 40px rgba(15,23,42,0.18);
                padding: 1rem 1.1rem;
            }
            
            .navbar-nav .nav-link {
                display: block;
                padding-left: 0;
                padding-right: 0;
                margin-bottom: 0.25rem;
            }
            
            .navbar-collapse > .d-flex {
                margin-top: 0.5rem;
                border-top: 1px solid #e5e7eb;
                padding-top: 0.7rem;
                flex-direction: row;
                justify-content: space-between;
                align-items: center;
            }
        }
        
        @media (max-width: 768px) {
            .page-wrapper {
                padding-top: 90px; /* 移动端稍微减少顶部间距 */
            }
            
            .design-header-inner {
                flex-direction: column;
                align-items: flex-start;
                gap: 1.5rem;
            }
            
            .nav-card {
                min-height: auto; /* 移动端移除最小高度限制 */
            }
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light fixed-top">
    <div class="container">
        <a class="navbar-brand" href="<c:url value='/'/>">
            <i class="bi bi-card-checklist"></i> 问卷星
        </a>
        <button class="navbar-toggler custom-toggler collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" 
                aria-controls="navbarNav" aria-expanded="false" aria-label="切换导航">
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
        <section class="design-header">
            <div class="design-header-inner">
                <div>
                    <h1 class="design-header-title">${empty questionnaire.id ? '创建新问卷' : '编辑问卷'}</h1>
                    <p class="design-header-subtitle mb-1">为你的问卷填写标题和描述，开启信息收集之旅的第一步。</p>
                </div>
                <div class="text-end"><span class="badge-step mb-2 d-inline-flex"><i class="bi bi-pencil-square"></i> 基本信息</span></div>
            </div>
        </section>

        <section class="folder-layout">
            <div class="row g-4">
                <div class="col-lg-3">
                    <div class="nav-card">
                        <div class="nav-card-title"><i class="bi bi-compass"></i><span>快速导航</span></div>
                        <div class="nav-card-sub">切换不同的问卷视图</div>
                        <ul class="nav-card-menu">
                            <li><a href="<c:url value='/questionnaire/create'/>" class="nav-link-chip active"><i class="bi bi-plus-circle"></i> 创建问卷</a></li>
                            <li><a href="<c:url value='/questionnaire/list'/>" class="nav-link-chip"><i class="bi bi-list-ul"></i> 全部问卷</a></li>
                            <li><a href="#" class="nav-link-chip"><i class="bi bi-star"></i> 星标问卷</a></li>
                            <li><a href="<c:url value='/questionnaire/folders'/>" class="nav-link-chip"><i class="bi bi-folder"></i> 文件夹</a></li>
                            <li><a href="#" class="nav-link-chip"><i class="bi bi-trash"></i> 回收站</a></li>
                        </ul>
                    </div>
                </div>

                <div class="col-lg-9">
                    <div class="content-card">
                        <c:url value='/questionnaire/${empty questionnaire.id ? "create" : "edit/"}${questionnaire.id}' var="formAction"/>
                        <form:form modelAttribute="questionnaire" action="${formAction}" method="post">
                            <div class="mb-4">
                                <form:label path="title" class="form-label">问卷标题 <span class="text-danger">*</span></form:label>
                                <form:input path="title" class="form-control form-control-lg" required="true" maxlength="200" placeholder="请输入问卷标题"/>
                            </div>
                            <div class="mb-4">
                                <form:label path="description" class="form-label">问卷描述</form:label>
                                <form:textarea path="description" class="form-control" rows="4" maxlength="1000" placeholder="请输入问卷描述，帮助填写者了解问卷目的"/>
                            </div>
                            <div class="d-flex justify-content-end gap-3">
                                <a href="<c:url value='/questionnaire/list'/>" class="btn btn-secondary">取消</a>
                                <button type="submit" class="btn btn-primary">${empty questionnaire.id ? '创建并设计问卷' : '保存修改'}</button>
                            </div>
                        </form:form>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>

<script src="/resources/js/bootstrap/bootstrap.bundle.min.js"></script>
<script>
    // 导航折叠 & 滚动效果（与 folders.jsp 统一）
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
</script>

</body>
</html>