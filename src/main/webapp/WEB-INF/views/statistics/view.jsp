<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>问卷统计 - ${questionnaire.title} - 问卷系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
                <h3>问卷统计：${questionnaire.title}</h3>
                <p class="text-muted">总提交数量：<strong>${statistics.totalSubmissions}</strong> 份</p>
            </div>
            <div class="col-md-4 text-end">
                <a href="<c:url value='/questionnaire/list'/>" class="btn btn-secondary">返回列表</a>
            </div>
        </div>

        <c:if test="${not empty statistics.questionStats}">
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
                                <div class="alert alert-info">
                                    <i class="bi bi-info-circle"></i> 简答题答案统计功能开发中...
                                </div>
                            </c:when>
                            <c:otherwise>
                                <!-- 选择题 -->
                                <c:if test="${not empty qStat.optionStats}">
                                    <div class="table-responsive">
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th>选项</th>
                                                    <th>选择次数</th>
                                                    <th>占比</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${qStat.optionStats}" var="option">
                                                    <tr>
                                                        <td>${option.optionText}</td>
                                                        <td>${option.count}</td>
                                                        <td>
                                                            <div class="progress" style="height: 20px;">
                                                                <c:set var="percentage" value="${statistics.totalSubmissions > 0 ? (option.count / statistics.totalSubmissions * 100) : 0}"/>
                                                                <div class="progress-bar" role="progressbar" 
                                                                     style="width: ${percentage}%">
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
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
