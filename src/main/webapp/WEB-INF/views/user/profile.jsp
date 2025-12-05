<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>账号信息</title>
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
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
        }
        .navbar {
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
        }
        .container {
            margin-top: 2rem;
        }
        .card {
            border: 1px solid var(--border-color);
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
        }
        .card-header {
            background-color: #f8f9fc;
            border-bottom: 1px solid var(--border-color);
            font-weight: 600;
            color: rgba(var(--bs-primary-rgb), 1);
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark" style="background-color:#4e73df;">
    <div class="container">
        <a class="navbar-brand" href="<c:url value='/questionnaire/list'/>">
            <i class="bi bi-card-checklist"></i> 问卷系统
        </a>
    </div>
</nav>

<div class="container">
    <div class="card">
        <div class="card-header">
            <i class="bi bi-person-lines-fill me-2"></i>账号信息
        </div>
        <div class="card-body">
            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <form method="post" action="<c:url value='/user/profile'/>">
                <div class="mb-3">
                    <label class="form-label">用户名</label>
                    <input type="text" class="form-control" value="${user.username}" disabled>
                    <div class="form-text">用户名由注册时确定，暂不支持修改。</div>
                </div>

                <div class="mb-3">
                    <label class="form-label">账号ID</label>
                    <input type="text" class="form-control" value="${user.id}" disabled>
                </div>

                <div class="mb-3">
                    <label class="form-label">邮箱地址</label>
                    <input type="email" class="form-control" name="email"
                           value="${user.email}" placeholder="未设置">
                    <div class="form-text">
                        设置邮箱后，可以使用邮箱 + 密码登录。
                    </div>
                </div>

                <hr class="my-4">
                <h6 class="mb-3"><i class="bi bi-key-fill me-1"></i>修改密码（可选）</h6>

                <div class="mb-3">
                    <label class="form-label">原密码（不修改请留空）</label>
                    <input type="password" name="oldPassword" class="form-control" placeholder="输入原密码">
                </div>
                <div class="mb-3">
                    <label class="form-label">新密码</label>
                    <input type="password" name="newPassword" class="form-control" placeholder="输入新密码">
                </div>
                <div class="mb-3">
                    <label class="form-label">确认新密码</label>
                    <input type="password" name="confirmPassword" class="form-control" placeholder="再次输入新密码">
                </div>

                <div class="d-flex justify-content-between">
                    <a class="btn btn-outline-secondary" href="<c:url value='/questionnaire/list'/>">
                        返回问卷列表
                    </a>
                    <button type="submit" class="btn btn-primary">
                        保存修改
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="/resources/js/bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>