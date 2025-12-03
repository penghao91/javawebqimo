<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>问卷列表 - 问卷系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="<c:url value='/questionnaire/list'/>">问卷系统</a>
            <div class="navbar-nav ms-auto">
                <span class="navbar-text text-white me-3">欢迎, ${user.username}</span>
                <a class="btn btn-outline-light btn-sm" href="<c:url value='/user/logout'/>">退出</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row mb-4">
            <div class="col-md-8">
                <h2>问卷列表</h2>
            </div>
            <div class="col-md-4 text-end">
                <a href="<c:url value='/questionnaire/create'/>" class="btn btn-primary">
                    <i class="bi bi-plus-circle"></i> 创建问卷
                </a>
            </div>
        </div>

        <c:if test="${not empty message}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="card">
            <div class="card-body">
                <c:choose>
                    <c:when test="${not empty questionnaires}">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>标题</th>
                                        <th>描述</th>
                                        <th>创建者</th>
                                        <th>状态</th>
                                        <th>创建时间</th>
                                        <th>操作</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${questionnaires}" var="q">
                                        <tr>
                                            <td>${q.id}</td>
                                            <td>${q.title}</td>
                                            <td>${q.description}</td>
                                            <td>${q.creator.username}</td>
                                            <td>
                                                <span class="badge bg-${q.status == 2 ? 'success' : 'secondary'}">
                                                    ${q.statusDesc}
                                                </span>
                                            </td>
                                            <td><fmt:formatDate value="${q.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                                            <td>
                                                <div class="btn-group btn-group-sm">
                                                    <c:if test="${q.status == 1 && (q.createdBy == user.id || user.role == 'admin' || user.role == 'administrator')}">
                                                        <a href="<c:url value='/questionnaire/publish/${q.id}'/>" 
                                                           class="btn btn-outline-success" 
                                                           onclick="return confirm('确定要发布此问卷吗？')"
                                                           title="发布">
                                                            <i class="bi bi-upload"></i>
                                                        </a>
                                                    </c:if>
                                                    
                                                    <c:if test="${q.status == 2}">
                                                        <a href="<c:url value='/answer/fill/${q.id}'/>" 
                                                           class="btn btn-outline-primary" 
                                                           title="填写问卷" target="_blank">
                                                            <i class="bi bi-pencil-square"></i>
                                                        </a>
                                                    </c:if>
                                                    
                                                    <a href="<c:url value='/questionnaire/design/${q.id}'/>" 
                                                       class="btn btn-outline-info" 
                                                       title="设计问卷">
                                                        <i class="bi bi-gear"></i>
                                                    </a>
                                                    
                                                    <a href="<c:url value='/statistics/view/${q.id}'/>" 
                                                       class="btn btn-outline-warning" 
                                                       title="查看统计">
                                                        <i class="bi bi-bar-chart"></i>
                                                    </a>
                                                    
                                                    <c:if test="${q.createdBy == user.id || user.role == 'admin' || user.role == 'administrator'}">
                                                        <a href="<c:url value='/questionnaire/edit/${q.id}'/>" 
                                                           class="btn btn-outline-secondary" 
                                                           title="编辑">
                                                            <i class="bi bi-pencil"></i>
                                                        </a>
                                                        
                                                        <a href="<c:url value='/questionnaire/delete/${q.id}'/>" 
                                                           class="btn btn-outline-danger" 
                                                           onclick="return confirm('确定要删除此问卷吗？')"
                                                           title="删除">
                                                            <i class="bi bi-trash"></i>
                                                        </a>
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
                        <div class="text-center py-5">
                            <i class="bi bi-inbox" style="font-size: 3rem; color: #ccc;"></i>
                            <p class="mt-3 text-muted">暂无问卷数据</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
