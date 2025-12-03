<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>问卷列表 - 问卷系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="<c:url value='/questionnaire/list'/>">问卷系统</a>
            <div class="navbar-nav ms-auto">
                <sec:authorize access="isAuthenticated()">
                    <span class="navbar-text me-3">
                        欢迎，<sec:authentication property="principal.username"/>
                    </span>
                    <a class="btn btn-outline-light btn-sm" href="<c:url value='/user/logout'/>">退出登录</a>
                </sec:authorize>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <h1>问卷列表</h1>
                <p class="text-muted">这里是您的问卷列表页面</p>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>