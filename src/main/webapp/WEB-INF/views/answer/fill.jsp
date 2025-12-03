<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${questionnaire.title} - 问卷系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="#">问卷系统</a>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-md-8 mx-auto">
                <div class="card">
                    <div class="card-header text-center">
                        <h3>${questionnaire.title}</h3>
                        <c:if test="${not empty questionnaire.description}">
                            <p class="text-muted mb-0">${questionnaire.description}</p>
                        </c:if>
                    </div>
                    <div class="card-body">
                        <form action="<c:url value='/answer/submit/${questionnaire.id}'/>" method="post">
                            <c:forEach items="${questions}" var="question" varStatus="status">
                                <div class="mb-4">
                                    <label class="form-label fw-bold">
                                        ${status.index + 1}. ${question.questionText}
                                        <c:if test="${question.isRequired == 1}">
                                            <span class="text-danger">*</span>
                                        </c:if>
                                        <span class="badge bg-secondary ms-2">${question.typeDesc}</span>
                                    </label>
                                    
                                    <c:choose>
                                        <c:when test="${question.questionType == 1}">
                                            <!-- 单选题 -->
                                            <c:forEach items="${question.options}" var="option">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="radio" 
                                                           name="question_${question.id}" 
                                                           value="${option.optionText}" 
                                                           id="option_${option.id}"
                                                           ${question.isRequired == 1 ? 'required' : ''}>
                                                    <label class="form-check-label" for="option_${option.id}">
                                                        ${option.optionText}
                                                    </label>
                                                </div>
                                            </c:forEach>
                                        </c:when>
                                        
                                        <c:when test="${question.questionType == 2}">
                                            <!-- 多选题 -->
                                            <c:forEach items="${question.options}" var="option">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" 
                                                           name="question_${question.id}" 
                                                           value="${option.optionText}" 
                                                           id="option_${option.id}">
                                                    <label class="form-check-label" for="option_${option.id}">
                                                        ${option.optionText}
                                                    </label>
                                                </div>
                                            </c:forEach>
                                        </c:when>
                                        
                                        <c:when test="${question.questionType == 3}">
                                            <!-- 简答题 -->
                                            <textarea class="form-control" 
                                                      name="question_${question.id}" 
                                                      rows="3"
                                                      ${question.isRequired == 1 ? 'required' : ''}></textarea>
                                        </c:when>
                                    </c:choose>
                                </div>
                                
                                <c:if test="${not status.last}">
                                    <hr>
                                </c:if>
                            </c:forEach>
                            
                            <div class="text-center">
                                <button type="submit" class="btn btn-primary btn-lg">提交问卷</button>
                                <a href="<c:url value='/questionnaire/list'/>" class="btn btn-secondary">返回</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
