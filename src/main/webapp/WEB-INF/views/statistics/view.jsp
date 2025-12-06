<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>问卷统计 - ${questionnaire.title} - 问卷系统</title>
    <link href="/resources/css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link href="/resources/css/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --bs-primary-rgb: 78, 115, 223;
            --bs-body-bg: #f8f9fc;
            --bs-body-color: #5a5c69;
            --border-color: #e3e6f0;
        }
        body {
            background-color: var(--bs-body-bg);
            color: var(--bs-body-color);
        }
        .navbar {
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
        }
        .main-container {
            margin-top: 1.5rem;
            margin-bottom: 3rem;
        }
        .page-header {
            margin-bottom: 1.5rem;
        }
        .page-header h1 {
            font-size: 1.75rem;
            font-weight: 400;
        }
        .card {
            border: 1px solid var(--border-color);
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            margin-bottom: 1.5rem;
        }
        .card-header {
            background-color: #f8f9fc;
            border-bottom: 1px solid var(--border-color);
            padding: 1.25rem 1.5rem;
        }
        .card-header h5 {
            margin-bottom: 0;
            font-weight: 600;
            color: #5a5c69;
        }
        .table thead th {
            background-color: #f8f9fc;
            border-bottom: 2px solid #e3e6f0;
            font-weight: 600;
            color: rgba(var(--bs-primary-rgb), 1);
        }
        .table td, .table th {
            vertical-align: middle;
        }
        .progress {
            height: 1.2rem;
            font-size: 0.75rem;
            line-height: 1.2rem;
        }
        .progress-bar {
            background-color: rgba(var(--bs-primary-rgb), 1);
        }
        .empty-state {
            padding: 3rem 1rem;
            text-align: center;
            color: #858796;
            border: 2px dashed var(--border-color);
            border-radius: 0.5rem;
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
    <nav class="navbar navbar-expand-lg navbar-dark" style="background-color: rgba(var(--bs-primary-rgb), 1);">
        <div class="container">
            <a class="navbar-brand" href="<c:url value='/questionnaire/list'/>">
                <i class="bi bi-card-checklist"></i>
                问卷系统
            </a>
            <div class="d-flex align-items-center">
                <!-- 用户下拉菜单 -->
                <div class="dropdown me-2">
                    <button class="btn btn-light btn-sm dropdown-toggle" type="button"
                            id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
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
    </nav>

    <div class="container main-container">
        <div class="page-header d-flex justify-content-between align-items-center mb-4">
            <div>
                <h1>问卷统计：${questionnaire.title}</h1>
                <p class="text-muted mb-0">总提交数量：<strong class="text-primary">${statistics.totalSubmissions}</strong> 份</p>
            </div>
            <a href="<c:url value='/questionnaire/list'/>" class="btn btn-secondary">
                <i class="bi bi-arrow-left"></i> 返回列表
            </a>
        </div>

        <c:choose>
            <c:when test="${not empty statistics.questionStats}">
                <c:forEach items="${statistics.questionStats}" var="qStat" varStatus="status">
                    <div class="card mb-4">
                        <div class="card-header">
                            <h5 class="mb-0">
                                ${status.index + 1}. ${qStat.questionText}
                                <span class="badge bg-info ms-2">${qStat.typeDesc}</span>
                            </h5>
                        </div>
                        <div class="card-body">
                            <c:choose>
                                <c:when test="${qStat.questionType == 3}">
                                    <!-- 简答题 -->
                                    <div class="empty-state border-0">
                                        <i class="bi bi-chat-left-text" style="font-size: 3rem; color: #ccc;"></i>
                                        <p class="mt-3 mb-0 text-muted">简答题答案统计功能开发中，请稍候...</p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <!-- 选择题 -->
                                    <c:if test="${not empty qStat.optionStats}">
                                        <div class="table-responsive">
                                            <table class="table table-hover mb-0">
                                                <thead>
                                                    <tr>
                                                        <th>选项</th>
                                                        <th style="width: 15%;">选择次数</th>
                                                        <th style="width: 30%;">占比</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach items="${qStat.optionStats}" var="option">
                                                        <tr>
                                                            <td>${option.optionText}</td>
                                                            <td>${option.count}</td>
                                                            <td>
                                                                <c:set var="percentage" value="${statistics.totalSubmissions > 0 ? (option.count / statistics.totalSubmissions * 100) : 0}"/>
                                                                <div class="progress">
                                                                    <div class="progress-bar" role="progressbar" 
                                                                         style="width: ${percentage}%" 
                                                                         aria-valuenow="${percentage}" 
                                                                         aria-valuemin="0" 
                                                                         aria-valuemax="100">
                                                                        <fmt:formatNumber value="${percentage}" pattern="#.#"/>%
                                                                    </div>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </c:if>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <i class="bi bi-bar-chart-line" style="font-size: 3rem;"></i>
                    <p class="mt-3 mb-0">暂无统计数据。</p>
                    <small class="text-muted">请先收集问卷回答。</small>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="/resources/js/bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>