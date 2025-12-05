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
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                        <li class="dropdown-header small text-muted">
                            用户名：${user.username}<br>
                            账号ID：${user.id}<br>
                            <c:choose>
                                <c:when test="${empty user.email}">
                                    邮箱：未设置
                                </c:when>
                                <c:otherwise>
                                    邮箱：${user.email}
                                </c:otherwise>
                            </c:choose>
                        </li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="<c:url value='/user/profile'/>">
                            <i class="bi bi-person-lines-fill me-1"></i>账号信息
                        </a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item text-danger" href="<c:url value='/user/logout'/>">
                            <i class="bi bi-box-arrow-right me-1"></i>退出
                        </a></li>
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