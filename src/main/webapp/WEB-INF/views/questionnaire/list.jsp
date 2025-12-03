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
        }
        body {
            background-color: var(--bs-body-bg);
            color: var(--bs-body-color);
        }
        .navbar {
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
        }
        .navbar-brand {
            font-weight: 700;
        }
        .main-container {
            margin-top: 1.5rem;
        }
        .page-header {
            margin-bottom: 1.5rem;
            align-items: center;
        }
        .page-header h1 {
            font-size: 1.75rem;
            font-weight: 400;
            color: #5a5c69;
        }
        .card {
            border: 1px solid var(--border-color);
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
        }
        .table {
            color: var(--bs-body-color);
        }
        .table thead th {
            background-color: #f8f9fc;
            border-bottom: 2px solid #e3e6f0;
            font-weight: 600;
            color: rgba(var(--bs-primary-rgb), 1);
        }
        .table tbody tr:hover {
            background-color: #f8f9fc;
        }
        .table td, .table th {
            vertical-align: middle;
        }
        .btn-group-sm > .btn {
            padding: 0.25rem 0.6rem;
        }
        .alert-icon {
            display: flex;
            align-items: center;
        }
        .alert-icon .bi {
            margin-right: 0.75rem;
            font-size: 1.2rem;
        }
        .empty-state {
            padding: 4rem 1rem;
            text-align: center;
            color: #858796;
        }
        .empty-state .icon {
            font-size: 4rem;
            color: #dddfeb;
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
                <span class="navbar-text text-white me-3">欢迎, ${user.username}</span>
                <a class="btn btn-outline-light btn-sm" href="<c:url value='/user/logout'/>">
                    <i class="bi bi-box-arrow-right"></i> 退出
                </a>
            </div>
        </div>
    </nav>

    <div class="container main-container">
        <div class="row page-header">
            <div class="col-8">
                <h1>我的问卷</h1>
            </div>
            <div class="col-4 text-end">
                <a href="<c:url value='/questionnaire/create'/>" class="btn btn-primary">
                    <i class="bi bi-plus-lg"></i> 创建问卷
                </a>
            </div>
        </div>

        <c:if test="${not empty message}">
            <div class="alert alert-success alert-icon d-flex alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle-fill"></i>
                <div>${message}</div>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-icon d-flex alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle-fill"></i>
                <div>${error}</div>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <div class="card">
            <div class="card-body p-0">
                <c:choose>
                    <c:when test="${not empty questionnaires}">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead>
                                    <tr>
                                        <th class="ps-4">ID</th>
                                        <th>标题</th>
                                        <th>状态</th>
                                        <th>创建时间</th>
                                        <th class="text-center">操作</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${questionnaires}" var="q">
                                        <tr>
                                            <td class="ps-4">${q.id}</td>
                                            <td>${q.title}</td>
                                            <td>
                                                <span class="badge rounded-pill bg-${q.status == 2 ? 'success' : (q.status == 1 ? 'warning' : 'secondary')}">
                                                    ${q.statusDesc}
                                                </span>
                                            </td>
                                            <td><fmt:formatDate value="${q.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                                            <td class="text-center">
                                                <div class="btn-group btn-group-sm">
                                                    <c:if test="${q.status == 2}">
                                                        <a href="<c:url value='/answer/fill/${q.id}'/>" class="btn btn-outline-primary" title="填写问卷" target="_blank"><i class="bi bi-pencil-square"></i></a>
                                                    </c:if>
                                                    <a href="<c:url value='/questionnaire/design/${q.id}'/>" class="btn btn-outline-info" title="设计问卷"><i class="bi bi-gear"></i></a>
                                                    <a href="<c:url value='/statistics/view/${q.id}'/>" class="btn btn-outline-warning" title="查看统计"><i class="bi bi-pie-chart"></i></a>
                                                    <c:if test="${q.createdBy == user.id || user.role == 'admin' || user.role == 'administrator'}">
                                                        <a href="<c:url value='/questionnaire/edit/${q.id}'/>" class="btn btn-outline-secondary" title="编辑"><i class="bi bi-pencil"></i></a>
                                                        <a href="<c:url value='/questionnaire/delete/${q.id}'/>" class="btn btn-outline-danger" onclick="return confirm('确定要删除此问卷吗？')" title="删除"><i class="bi bi-trash"></i></a>
                                                    </c:if>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <div class="icon"><i class="bi bi-journal-x"></i></div>
                            <h4 class="mt-4">暂无问卷</h4>
                            <p class="text-muted">点击右上角的“创建问卷”按钮，开始你的第一次创建吧！</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>