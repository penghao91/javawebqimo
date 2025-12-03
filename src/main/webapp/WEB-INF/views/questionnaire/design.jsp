<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>设计问卷 - ${questionnaire.title} - 问卷系统</title>
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
                <h3>设计问卷：${questionnaire.title}</h3>
                <p class="text-muted">${questionnaire.description}</p>
            </div>
            <div class="col-md-4 text-end">
                <a href="<c:url value='/questionnaire/list'/>" class="btn btn-secondary">返回列表</a>
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

        <div class="row">
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header">
                        <h5>添加问题</h5>
                    </div>
                    <div class="card-body">
                        <form action="<c:url value='/question/add'/>" method="post">
                            <input type="hidden" name="questionnaireId" value="${questionnaire.id}"/>
                            
                            <div class="mb-3">
                                <label class="form-label">问题内容 <span class="text-danger">*</span></label>
                                <textarea name="questionText" class="form-control" rows="3" required></textarea>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">题型 <span class="text-danger">*</span></label>
                                <select name="questionType" class="form-select" required onchange="toggleOptions(this)">
                                    <option value="">请选择题型</option>
                                    <option value="1">单选题</option>
                                    <option value="2">多选题</option>
                                    <option value="3">简答题</option>
                                </select>
                            </div>
                            
                            <div class="mb-3">
                                <div class="form-check">
                                    <input type="checkbox" class="form-check-input" name="isRequired" value="1" checked>
                                    <label class="form-check-label">是否必填</label>
                                </div>
                            </div>
                            
                            <div id="optionsContainer" style="display:none;">
                                <label class="form-label">选项（每行一个）</label>
                                <textarea name="options" class="form-control" rows="4" 
                                          placeholder="选项1&#10;选项2&#10;选项3"></textarea>
                            </div>
                            
                            <button type="submit" class="btn btn-primary w-100">添加问题</button>
                        </form>
                    </div>
                </div>
            </div>
            
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">
                        <h5>问题列表</h5>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty questions}">
                                <c:forEach items="${questions}" var="question" varStatus="status">
                                    <div class="card mb-3">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-start">
                                                <div class="flex-grow-1">
                                                    <h6 class="card-title">
                                                        ${status.index + 1}. ${question.questionText}
                                                        <span class="badge bg-${question.isRequired == 1 ? 'danger' : 'secondary'} ms-2">
                                                            ${question.requiredDesc}
                                                        </span>
                                                        <span class="badge bg-info ms-2">${question.typeDesc}</span>
                                                    </h6>
                                                    
                                                    <c:if test="${question.questionType != 3 && not empty question.options}">
                                                        <div class="mt-2">
                                                            <small class="text-muted">选项：</small>
                                                            <c:forEach items="${question.options}" var="option" varStatus="optStatus">
                                                                <span class="badge bg-light text-dark me-1">${option.optionText}</span>
                                                            </c:forEach>
                                                        </div>
                                                    </c:if>
                                                </div>
                                                
                                                <div class="btn-group btn-group-sm ms-3">
                                                    <a href="<c:url value='/question/delete/${question.id}'/>" 
                                                       class="btn btn-outline-danger" 
                                                       onclick="return confirm('确定要删除此问题吗？')"
                                                       title="删除">
                                                        <i class="bi bi-trash"></i>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-5">
                                    <i class="bi bi-inbox" style="font-size: 2rem; color: #ccc;"></i>
                                    <p class="mt-3 text-muted">暂无问题，请添加问题</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
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
