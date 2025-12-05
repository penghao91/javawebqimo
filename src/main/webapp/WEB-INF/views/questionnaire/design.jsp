<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        .page-header .text-muted {
            font-size: 1rem;
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
        .question-card {
            transition: box-shadow 0.2s;
        }
        .question-card:hover {
            box-shadow: 0 0.2rem 0.5rem rgba(0,0,0,0.1);
        }
        .btn-primary {
            background-color: rgba(var(--bs-primary-rgb), 1);
            border-color: rgba(var(--bs-primary-rgb), 1);
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
            <a class="navbar-brand" href="<c:url value='/questionnaire/list'/>"><i class="bi bi-card-checklist"></i> 问卷系统</a>
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
        <div class="page-header">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h1>设计问卷</h1>
                    <p class="text-muted mb-0">${questionnaire.title}</p>
                </div>
                <a href="<c:url value='/questionnaire/list'/>" class="btn btn-secondary"><i class="bi bi-arrow-left"></i> 返回列表</a>
            </div>
        </div>

        <c:if test="${not empty message}"><div class="alert alert-success">${message}</div></c:if>
        <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

        <div class="row g-4">
            <!-- Add Question Form -->
            <div class="col-lg-4">
                <div class="card position-sticky" style="top: 1.5rem;">
                    <div class="card-header"><i class="bi bi-plus-circle-dotted me-2"></i>添加新问题</div>
                    <div class="card-body">
                        <form action="<c:url value='/question/add'/>" method="post">
                            <input type="hidden" name="questionnaireId" value="${questionnaire.id}"/>
                            
                            <div class="mb-3">
                                <label for="questionText" class="form-label">问题内容<span class="text-danger">*</span></label>
                                <textarea id="questionText" name="questionText" class="form-control" rows="3" required></textarea>
                            </div>
                            
                            <div class="mb-3">
                                <label for="questionType" class="form-label">题型<span class="text-danger">*</span></label>
                                <select id="questionType" name="questionType" class="form-select" required onchange="toggleOptions(this)">
                                    <option value="" disabled selected>请选择题型</option>
                                    <option value="1">单选题</option>
                                    <option value="2">多选题</option>
                                    <option value="3">简答题</option>
                                </select>
                            </div>
                            
                            <div class="mb-3" id="optionsContainer" style="display:none;">
                                <label for="options" class="form-label">选项 (每行一个)</label>
                                <textarea id="options" name="options" class="form-control" rows="4" placeholder="选项1&#10;选项2&#10;选项3"></textarea>
                            </div>

                            <div class="form-check form-switch mb-4">
                                <input type="checkbox" class="form-check-input" id="isRequired" name="isRequired" value="1" checked>
                                <label class="form-check-label" for="isRequired">是否必填</label>
                            </div>
                            
                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary"><i class="bi bi-plus-lg"></i> 添加问题</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            
            <!-- Question List -->
            <div class="col-lg-8">
                 <div class="card">
                    <div class="card-header"><i class="bi bi-list-ul me-2"></i>问题列表</div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty questions}">
                                <c:forEach items="${questions}" var="question" varStatus="status">
                                    <div class="card question-card mb-3">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between">
                                                <div class="pe-3">
                                                    <h6 class="mb-1">
                                                        ${status.count}. ${question.questionText}
                                                    </h6>
                                                     <div>
                                                        <span class="badge bg-info fw-normal">${question.typeDesc}</span>
                                                        <c:if test="${question.isRequired == 1}">
                                                            <span class="badge bg-danger fw-normal">必填</span>
                                                        </c:if>
                                                    </div>
                                                </div>
                                                <div class="btn-group-vertical">
                                                    <a href="<c:url value='/question/delete/${question.id}'/>" 
                                                       class="btn btn-sm btn-outline-danger" 
                                                       onclick="return confirm('确定要删除此问题吗？')"
                                                       title="删除"><i class="bi bi-trash"></i>
                                                    </a>
                                                </div>
                                            </div>
                                            <c:if test="${question.questionType != 3 && not empty question.options}">
                                                <hr>
                                                <div class="d-flex flex-wrap gap-2">
                                                    <c:forEach items="${question.options}" var="option">
                                                        <span class="badge rounded-pill bg-light text-dark border">${option.optionText}</span>
                                                    </c:forEach>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-state">
                                     <i class="bi bi-question-circle" style="font-size: 3rem;"></i>
                                     <p class="mt-3 mb-0">暂无问题</p>
                                     <small class="text-muted">请在左侧添加问题来丰富您的问卷。</small>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="/resources/js/bootstrap/bootstrap.bundle.min.js"></script>
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