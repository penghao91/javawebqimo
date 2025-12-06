<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>设计问卷: ${questionnaire.title}</title>

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

        /* 顶部导航（和首页/创建页同一家族） */
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

        /* 保留你原来的用户下拉：结构不变，只是颜色适配浅色导航 */
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

        /* 页面整体框架 */
        .page-wrapper {
            padding-top: 88px;
            padding-bottom: 40px;
        }

        /* 顶部问卷信息条 */
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

        .design-header-meta span + span {
            margin-left: .8rem;
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

        /* 布局：左侧添加问题 + 右侧问题列表 */
        .design-layout {
            margin-top: 10px;
        }

        /* 左侧添加问题卡片 */
        .add-question-card {
            background: #ffffff;
            border-radius: 18px;
            padding: 18px 18px 16px;
            box-shadow: 0 14px 40px rgba(15, 23, 42, 0.08);
            border: 1px solid rgba(226, 232, 240, 0.9);
        }

        .add-question-header {
            font-weight: 700;
            font-size: .95rem;
            display: flex;
            align-items: center;
            gap: .4rem;
            margin-bottom: 10px;
        }

        .add-question-header i {
            color: var(--primary-color);
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
        .form-select {
            border-radius: 12px;
            border: 1px solid var(--border-soft);
            font-size: .9rem;
            padding: .5rem .75rem;
            transition: border-color .18s ease, box-shadow .18s ease, transform .08s ease;
        }
        .form-control:focus,
        .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 1px rgba(78,115,223,0.35);
            outline: none;
            transform: translateY(-1px);
        }
        textarea.form-control {
            resize: vertical;
            min-height: 90px;
        }

        .form-check-label {
            font-size: .9rem;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            border: none;
            box-shadow: 0 10px 22px rgba(78,115,223,0.45);
            font-weight: 600;
        }
        .btn-primary:hover {
            background: linear-gradient(135deg, #4663ce, #1f3fa6);
            box-shadow: 0 12px 26px rgba(78,115,223,0.55);
            transform: translateY(-1px);
        }

        /* 右侧问题列表卡片 */
        .questions-card {
            background: #ffffff;
            border-radius: 18px;
            padding: 18px 18px 16px;
            box-shadow: 0 14px 40px rgba(15, 23, 42, 0.08);
            border: 1px solid rgba(226, 232, 240, 0.9);
        }

        .questions-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 6px;
        }

        .questions-header-title {
            display: flex;
            align-items: center;
            gap: .4rem;
            font-weight: 700;
            font-size: .95rem;
        }

        .questions-header-title i {
            color: var(--primary-color);
        }

        .questions-header-meta {
            font-size: .8rem;
            color: var(--muted-color);
        }

        /* 单个问题卡片 */
        .question-card {
            border-radius: 14px;
            border: 1px solid var(--border-soft);
            padding: 12px 12px 10px;
            margin-bottom: 10px;
            transition: box-shadow 0.18s ease, transform 0.18s ease, border-color 0.18s ease;
            background: #ffffff;
        }
        .question-card:hover {
            box-shadow: 0 6px 18px rgba(15, 23, 42, 0.08);
            border-color: rgba(78,115,223,0.35);
            transform: translateY(-1px);
        }

        .question-title {
            font-weight: 600;
            font-size: .95rem;
            margin-bottom: 3px;
        }

        .question-badges {
            margin-bottom: 5px;
        }

        .question-badges .badge {
            font-weight: 500;
            font-size: .75rem;
        }

        .question-actions .btn {
            padding: .15rem .4rem;
        }

        .question-options {
            font-size: .86rem;
        }

        .question-options .badge {
            border-radius: 999px;
            font-weight: 500;
        }

        /* 空状态 */
        .empty-state {
            padding: 3rem 1rem;
            text-align: center;
            color: #858796;
            border: 2px dashed var(--border-soft);
            border-radius: 0.75rem;
            background: #f9fafb;
        }
        .empty-state i {
            font-size: 3rem;
            color: #cbd5f5;
        }

        /* 顶部的消息 alert 美化一下 */
        .alert {
            border-radius: 12px;
            border: 1px solid transparent;
            box-shadow: 0 8px 22px rgba(15,23,42,.08);
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

<!-- 导航 -->
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

            <!-- 保留原来的下拉结构，只是加个 class 调整颜色 -->
            <div class="d-flex align-items-center">
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
            </div>

        </div>
    </div>
</nav>

<div class="page-wrapper">
    <div class="container">

        <!-- 顶部问卷信息条 -->
        <section class="design-header">
            <div class="design-header-inner">
                <div>
                    <h1 class="design-header-title">设计问卷</h1>
                    <p class="design-header-subtitle mb-1">
                        ${questionnaire.title}
                    </p>
                    <p class="design-header-meta mb-0">
                        <span><i class="bi bi-file-text me-1"></i>问卷 ID：${questionnaire.id}</span>
                        <c:if test="${not empty questionnaire.createTime}">
                            <span>
                                <i class="bi bi-calendar3 me-1"></i>
                                创建时间：
                                <fmt:formatDate value="${questionnaire.createTime}" pattern="yyyy-MM-dd HH:mm"/>
                            </span>
                        </c:if>
                    </p>
                </div>
                <div class="text-end">
                    <span class="badge-step mb-2 d-inline-flex">
                        <i class="bi bi-2-circle"></i> 步骤 2：设计题目
                    </span>
                    <div>
                        <a href="<c:url value='/questionnaire/list'/>" class="btn btn-sm btn-outline-light">
                            <i class="bi bi-arrow-left"></i> 返回列表
                        </a>
                    </div>
                </div>
            </div>
        </section>

        <!-- Spring 消息，沿用但换成圆角卡片 -->
        <c:if test="${not empty message}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle-fill me-1"></i>${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="关闭"></button>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-1"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="关闭"></button>
            </div>
        </c:if>

        <!-- 主体区域：左侧添加问题 / 右侧问题列表 -->
        <section class="design-layout">
            <div class="row g-4">
                <!-- 左：添加问题 -->
                <div class="col-lg-4">
                    <div class="add-question-card position-sticky" style="top: 90px;">
                        <div class="add-question-header">
                            <i class="bi bi-plus-circle-dotted"></i>
                            <span>添加新问题</span>
                        </div>
                        <p class="small text-muted mb-3">
                            建议先确定题型，再编辑选项内容，简短清晰更易作答。
                        </p>
                        <form action="<c:url value='/question/add'/>" method="post">
                            <input type="hidden" name="questionnaireId" value="${questionnaire.id}"/>

                            <div class="mb-3">
                                <label for="questionText" class="form-label">
                                    问题内容 <span class="text-danger">*</span>
                                </label>
                                <textarea id="questionText" name="questionText" class="form-control" rows="3" required
                                          placeholder="例如：您对本次活动整体满意度如何？"></textarea>
                            </div>

                            <div class="mb-3">
                                <label for="questionType" class="form-label">
                                    题型 <span class="text-danger">*</span>
                                </label>
                                <select id="questionType" name="questionType"
                                        class="form-select" required onchange="toggleOptions(this)">
                                    <option value="" disabled selected>请选择题型</option>
                                    <option value="1">单选题</option>
                                    <option value="2">多选题</option>
                                    <option value="3">简答题</option>
                                </select>
                            </div>

                            <div class="mb-3" id="optionsContainer" style="display:none;">
                                <label for="options" class="form-label">
                                    选项（每行一个）
                                </label>
                                <textarea id="options" name="options" class="form-control" rows="4"
                                          placeholder="选项1&#10;选项2&#10;选项3"></textarea>
                                <div class="form-text">
                                    建议 3–7 个选项，使用简短、互斥且不重叠的描述。
                                </div>
                            </div>

                            <div class="form-check form-switch mb-4">
                                <input type="checkbox" class="form-check-input" id="isRequired" name="isRequired" value="1" checked>
                                <label class="form-check-label" for="isRequired">是否必填</label>
                            </div>

                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary">
                                    <i class="bi bi-plus-lg me-1"></i> 添加问题
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- 右：问题列表 -->
                <div class="col-lg-8">
                    <div class="questions-card">
                        <div class="questions-header">
                            <div class="questions-header-title">
                                <i class="bi bi-list-ul"></i>
                                <span>问题列表</span>
                            </div>
                            <div class="questions-header-meta">
                                <c:choose>
                                    <c:when test="${not empty questions}">
                                        共 ${fn:length(questions)} 题
                                    </c:when>
                                    <c:otherwise>
                                        暂无题目
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <hr class="mt-2 mb-3"/>

                        <c:choose>
                            <c:when test="${not empty questions}">
                                <c:forEach items="${questions}" var="question" varStatus="status">
                                    <div class="question-card">
                                        <div class="d-flex justify-content-between align-items-start">
                                            <div class="pe-3">
                                                <div class="question-title">
                                                        ${status.count}. ${question.questionText}
                                                </div>
                                                <div class="question-badges">
                                                    <span class="badge bg-info text-dark me-1">
                                                            ${question.typeDesc}
                                                    </span>
                                                    <c:if test="${question.isRequired == 1}">
                                                        <span class="badge bg-danger">必填</span>
                                                    </c:if>
                                                </div>
                                            </div>
                                            <div class="question-actions">
                                                <a href="<c:url value='/question/delete/${question.id}'/>"
                                                   class="btn btn-sm btn-outline-danger"
                                                   onclick="return confirm('确定要删除此问题吗？')"
                                                   title="删除">
                                                    <i class="bi bi-trash"></i>
                                                </a>
                                            </div>
                                        </div>

                                        <c:if test="${question.questionType != 3 && not empty question.options}">
                                            <hr class="my-2">
                                            <div class="question-options d-flex flex-wrap gap-2">
                                                <c:forEach items="${question.options}" var="option">
                                                    <span class="badge bg-light text-dark border">
                                                            ${option.optionText}
                                                    </span>
                                                </c:forEach>
                                            </div>
                                        </c:if>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-state">
                                    <i class="bi bi-question-circle"></i>
                                    <p class="mt-3 mb-1 fs-5">暂无问题</p>
                                    <p class="mb-0 small text-muted">
                                        请在左侧添加问题来丰富您的问卷。建议先从 1–2 个关键问题开始，再逐步补充细节。
                                    </p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </section>

    </div>
</div>

<script src="/resources/js/bootstrap/bootstrap.bundle.min.js"></script>
<script>
    // 导航折叠 & 滚动效果（和首页保持一致）
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

    // 题型切换时显示/隐藏选项
    function toggleOptions(select) {
        const container = document.getElementById('optionsContainer');
        if (select.value === '1' || select.value === '2') {
            container.style.display = 'block';
        } else {
            container.style.display = 'none';
        }
    }
</script>
</body>
</html>
