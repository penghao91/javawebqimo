<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${questionnaire.title} - 问卷系统</title>
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
        .main-container {
            padding: 1.5rem 0;
        }
        .questionnaire-card {
            border: 1px solid var(--border-color);
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
        }
        .card-header {
            background-color: #f8f9fc;
            border-bottom: 1px solid var(--border-color);
            padding: 1.5rem;
        }
        .card-header h3 {
            font-size: 1.75rem;
            font-weight: 600;
            color: #5a5c69;
        }
        .card-body {
            padding: 1.5rem;
        }
        .question-item {
            border-bottom: 1px solid #eee;
            padding-bottom: 1.5rem;
            margin-bottom: 1.5rem;
        }
        .question-item:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }
        .question-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: #4e4e5b;
            margin-bottom: 1rem;
        }
        .required-star {
            color: #e74a3b;
            margin-left: 0.25rem;
        }
        .progress-bar-container {
            height: 0.5rem;
            background-color: #e9ecef;
            border-radius: 0.25rem;
            margin-bottom: 1rem;
        }
        .progress-bar-fill {
            height: 100%;
            background-color: rgba(var(--bs-primary-rgb), 1);
            border-radius: 0.25rem;
            width: 0%;
            transition: width 0.3s ease-in-out;
        }
        .btn-primary {
            background-color: rgba(var(--bs-primary-rgb), 1);
            border-color: rgba(var(--bs-primary-rgb), 1);
        }
        .btn-primary:hover {
            background-color: rgba(var(--bs-primary-rgb), 0.9);
        }
        .sticky-footer {
            position: sticky;
            bottom: 0;
            left: 0;
            width: 100%;
            background-color: #fff;
            padding: 1rem 0;
            box-shadow: 0 -0.15rem 1.75rem 0 rgba(58, 59, 69, 0.05);
            z-index: 1000;
        }
    </style>
</head>
<body>
    <div class="container main-container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="questionnaire-card">
                    <div class="card-header text-center">
                        <h3>${questionnaire.title}</h3>
                        <c:if test="${not empty questionnaire.description}">
                            <p class="text-muted mb-0">${questionnaire.description}</p>
                        </c:if>
                    </div>
                    
                    <div class="card-body">
                        <div class="progress-bar-container">
                            <div id="progressBar" class="progress-bar-fill"></div>
                        </div>

                        <form id="questionnaireForm" action="<c:url value='/answer/submit/${questionnaire.id}'/>" method="post">
                            <c:forEach items="${questions}" var="question" varStatus="status">
                                <div class="question-item" data-question-id="${question.id}" data-question-type="${question.questionType}">
                                    <p class="question-title mb-3">
                                        <span class="me-2">${status.index + 1}.</span>
                                        ${question.questionText}
                                        <c:if test="${question.isRequired == 1}">
                                            <span class="required-star">*</span>
                                        </c:if>
                                        <span class="badge bg-secondary ms-2">${question.typeDesc}</span>
                                    </p>
                                    
                                    <c:choose>
                                        <c:when test="${question.questionType == 1}">
                                            <!-- 单选题 -->
                                            <div class="form-group">
                                                <c:forEach items="${question.options}" var="option">
                                                    <div class="form-check mb-2">
                                                        <input class="form-check-input" type="radio" 
                                                               name="question_${question.id}" 
                                                               value="${option.optionText}" 
                                                               id="option_${option.id}"
                                                               ${question.isRequired == 1 ? 'required' : ''}
                                                               onchange="updateProgress()">
                                                        <label class="form-check-label" for="option_${option.id}">
                                                            ${option.optionText}
                                                        </label>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </c:when>
                                        
                                        <c:when test="${question.questionType == 2}">
                                            <!-- 多选题 -->
                                            <div class="form-group">
                                                <c:forEach items="${question.options}" var="option">
                                                    <div class="form-check mb-2">
                                                        <input class="form-check-input" type="checkbox" 
                                                               name="question_${question.id}" 
                                                               value="${option.optionText}" 
                                                               id="option_${option.id}"
                                                               onchange="updateProgress()">
                                                        <label class="form-check-label" for="option_${option.id}">
                                                            ${option.optionText}
                                                        </label>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </c:when>
                                        
                                        <c:when test="${question.questionType == 3}">
                                            <!-- 简答题 -->
                                            <div class="form-group">
                                                <textarea class="form-control" 
                                                          name="question_${question.id}" 
                                                          rows="4"
                                                          placeholder="请输入您的回答..."
                                                          ${question.isRequired == 1 ? 'required' : ''}
                                                          oninput="updateProgress()"></textarea>
                                            </div>
                                        </c:when>
                                    </c:choose>
                                </div>
                            </c:forEach>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="sticky-footer d-flex justify-content-center">
        <div class="container text-center">
            <button type="submit" form="questionnaireForm" class="btn btn-primary btn-lg px-5">
                <i class="bi bi-send-fill me-2"></i>提交问卷
            </button>
            <a href="<c:url value='/questionnaire/list'/>" class="btn btn-secondary btn-lg ms-3">
                <i class="bi bi-arrow-left-circle me-2"></i>返回
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const form = document.getElementById('questionnaireForm');
        const progressBar = document.getElementById('progressBar');
        const questions = document.querySelectorAll('.question-item');
        const totalQuestions = questions.length;

        function updateProgress() {
            let answeredQuestions = 0;
            questions.forEach(question => {
                const questionType = question.dataset.questionType;
                const questionId = question.dataset.questionId;
                
                let isAnswered = false;
                if (questionType === '1') { // Single choice
                    isAnswered = question.querySelector(`input[name="question_${questionId}"]:checked`) !== null;
                } else if (questionType === '2') { // Multiple choice
                    isAnswered = question.querySelector(`input[name="question_${questionId}"]:checked`) !== null;
                } else if (questionType === '3') { // Text
                    isAnswered = question.querySelector(`textarea[name="question_${questionId}"]`).value.trim() !== '';
                }
                
                if (isAnswered) {
                    answeredQuestions++;
                }
            });

            const progress = (answeredQuestions / totalQuestions) * 100;
            progressBar.style.width = `${progress}%`;
        }

        // Initial progress update
        document.addEventListener('DOMContentLoaded', updateProgress);
        
        // Form submission validation (minimal, as 'required' handles most)
        form.addEventListener('submit', function(event) {
            // Check for required questions not handled by native 'required' (e.g., checkbox groups)
            let allRequiredAnswered = true;
            questions.forEach(question => {
                const questionType = question.dataset.questionType;
                const questionId = question.dataset.questionId;
                const isRequired = question.querySelector('.required-star'); // Check for visual required indicator

                if (isRequired) { // Only check if visually marked as required
                    if (questionType === '2') { // For multiple choice, ensure at least one is checked
                        const checkedCount = question.querySelectorAll(`input[name="question_${questionId}"]:checked`).length;
                        if (checkedCount === 0) {
                            allRequiredAnswered = false;
                            // Optionally, add a visual cue to the user for this specific question
                            question.querySelector('.question-title').style.color = '#e74a3b'; // Highlight title
                        } else {
                            question.querySelector('.question-title').style.color = '#4e4e5b'; // Reset color
                        }
                    }
                    // For radio/text, native 'required' attribute handles it
                }
            });

            if (!allRequiredAnswered) {
                event.preventDefault();
                alert('请填写所有必填项！'); // Simple alert, can be replaced by Bootstrap alerts
            }
        });
    </script>
</body>
</html>