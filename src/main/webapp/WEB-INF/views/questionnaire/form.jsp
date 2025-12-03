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
        <div class="row">
            <div class="col-md-8 mx-auto">
                <div class="card">
                    <div class="card-header">
                        <h4>${empty questionnaire.id ? '创建新问卷' : '编辑问卷'}</h4>
                    </div>
                    <div class="card-body">
                        <c:url value='/questionnaire/${empty questionnaire.id ? "create" : "edit/"}${questionnaire.id}' var="formAction"/>
                        
                        <form:form modelAttribute="questionnaire" action="${formAction}" method="post">
                            <div class="mb-3">
                                <form:label path="title" class="form-label">问卷标题 <span class="text-danger">*</span></form:label>
                                <form:input path="title" class="form-control" required="true" maxlength="200"/>
                            </div>
                            
                            <div class="mb-3">
                                <form:label path="description" class="form-label">问卷描述</form:label>
                                <form:textarea path="description" class="form-control" rows="4" maxlength="1000"/>
                            </div>
                            
                            <div class="d-flex justify-content-between">
                                <a href="<c:url value='/questionnaire/list'/>" class="btn btn-secondary">返回列表</a>
                                <button type="submit" class="btn btn-primary">
                                    ${empty questionnaire.id ? '创建' : '保存'}
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
