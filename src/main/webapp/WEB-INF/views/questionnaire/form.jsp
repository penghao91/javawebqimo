<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty questionnaire.id ? '创建问卷' : '编辑问卷'} - 问卷系统</title>
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
            margin-bottom: 1.5rem; /* Added margin for consistency */
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
        .btn-primary {
            background-color: rgba(var(--bs-primary-rgb), 1);
            border-color: rgba(var(--bs-primary-rgb), 1);
            transition: background-color 0.2s;
        }
        .btn-primary:hover {
            background-color: rgba(var(--bs-primary-rgb), 0.9);
        }
        .btn-secondary {
            background-color: #858796;
            border-color: #858796;
            transition: background-color 0.2s;
        }
        .btn-secondary:hover {
            background-color: #71727f;
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
        <div class="row">
            <div class="col-lg-8 mx-auto">
                <div class="page-header d-flex justify-content-between">
                    <h1>${empty questionnaire.id ? '创建新问卷' : '编辑问卷'}</h1>
                    <a href="<c:url value='/questionnaire/list'/>" class="btn btn-secondary align-self-center">
                        <i class="bi bi-arrow-left"></i> 返回列表
                    </a>
                </div>

                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">问卷信息</h5>
                    </div>
                    <div class="card-body">
                        <c:url value='/questionnaire/${empty questionnaire.id ? "create" : "edit/"}${questionnaire.id}' var="formAction"/>
                        
                        <form:form modelAttribute="questionnaire" action="${formAction}" method="post">
                            <div class="mb-3">
                                <form:label path="title" class="form-label">问卷标题 <span class="text-danger">*</span></form:label>
                                <form:input path="title" class="form-control" required="true" maxlength="200" placeholder="请输入问卷标题"/>
                                <form:errors path="title" cssClass="text-danger small mt-1"/>
                            </div>
                            
                            <div class="mb-4">
                                <form:label path="description" class="form-label">问卷描述</form:label>
                                <form:textarea path="description" class="form-control" rows="5" maxlength="1000" placeholder="请输入问卷描述"/>
                                <form:errors path="description" cssClass="text-danger small mt-1"/>
                            </div>
                            
                            <div class="d-flex justify-content-end">
                                <button type="submit" class="btn btn-primary btn-lg">
                                    <i class="bi bi-check-lg"></i> ${empty questionnaire.id ? '创建' : '保存'}
                                </button>
                            </div>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>