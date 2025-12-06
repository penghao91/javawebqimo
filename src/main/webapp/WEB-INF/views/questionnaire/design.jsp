<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>设计问卷: ${questionnaire.title}</title>
    <link href="<c:url value='/resources/css/bootstrap/bootstrap.min.css'/>" rel="stylesheet">
    <link href="<c:url value='/resources/css/bootstrap-icons/bootstrap-icons.css'/>" rel="stylesheet">
    <style>
        :root {
            --primary-color: #4e73df; --primary-dark: #224abe; --secondary-color: #858796;
            --success-color: #1cc88a; --danger-color: #e74a3b; --light-color: #f8f9fc;
            --dark-color: #4b4d63; --muted-color: #a0a3b1; --border-soft: #e1e5f2;
        }
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'SF Pro Text', 'Segoe UI', 'Roboto', 'Helvetica Neue', Arial, sans-serif;
            background: radial-gradient(circle at top left, #f0f4ff 0, #f8f9fc 45%, #fdfdfd 100%);
            color: var(--dark-color);
        }
        .navbar {
            background: rgba(255, 255, 255, 0.9); backdrop-filter: blur(16px);
            box-shadow: 0 8px 24px rgba(15, 23, 42, 0.08); transition: all 0.3s ease;
            padding-top: 0.75rem; padding-bottom: 0.75rem;
        }
        .navbar.scrolled { padding-top: 0.45rem; padding-bottom: 0.45rem; background: rgba(255, 255, 255, 0.98); box-shadow: 0 10px 30px rgba(15, 23, 42, 0.14); }
        .navbar-brand { font-weight: 800; font-size: 1.45rem; color: var(--primary-color) !important; display: flex; align-items: center; gap: .4rem; }
        .navbar-brand i { font-size: 1.4rem; color: var(--primary-dark); }
        .navbar-nav .nav-link { font-weight: 600; color: var(--secondary-color) !important; transition: color 0.2s ease, transform 0.2s ease; position: relative; padding: 0.5rem .9rem !important; }
        .navbar-nav .nav-link:hover { color: var(--primary-color) !important; transform: translateY(-1px); }
        .user-dropdown-btn { text-decoration: none; font-weight: 500; color: var(--secondary-color) !important; }
        .user-dropdown-btn i { color: var(--primary-color); }
        .user-dropdown-btn:hover { color: var(--primary-color) !important; }
        .page-wrapper { padding-top: 88px; padding-bottom: 40px; }
        .design-header { margin-bottom: 18px; }
        .design-header-inner { background: linear-gradient(135deg, #4f46e5 0, #1d4ed8 40%, #2563eb 100%); border-radius: 20px; padding: 18px 22px; color: #fff; box-shadow: 0 14px 36px rgba(37, 99, 235, 0.35); display: flex; align-items: center; justify-content: space-between; gap: 1rem; }
        .design-header-title { margin: 0; font-size: 1.5rem; font-weight: 700; }
        .design-header-subtitle { margin: .25rem 0 0; font-size: .96rem; opacity: .9; }
        .badge-step { display: inline-flex; align-items: center; gap: .25rem; padding: .25rem .8rem; border-radius: 999px; border: 1px solid rgba(248, 250, 252, 0.9); background: rgba(15,23,42,.15); font-size: .8rem; }
        .btn-outline-light.btn-sm { border-radius: 999px; font-size: .85rem; padding: .3rem .9rem; }
        .design-layout { margin-top: 10px; }
        .add-question-card, .questions-card { background: #ffffff; border-radius: 18px; padding: 18px 18px 16px; box-shadow: 0 14px 40px rgba(15, 23, 42, 0.08); border: 1px solid rgba(226, 232, 240, 0.9); }
        .add-question-header, .questions-header-title { font-weight: 700; font-size: .95rem; display: flex; align-items: center; gap: .4rem; margin-bottom: 10px; }
        .add-question-header i, .questions-header-title i { color: var(--primary-color); }
        .form-control, .form-select { border-radius: 12px; border: 1px solid var(--border-soft); font-size: .9rem; padding: .5rem .75rem; }
        .form-control:focus, .form-select:focus { border-color: var(--primary-color); box-shadow: 0 0 0 1px rgba(78,115,223,0.35); outline: none; }
        .question-card { border-radius: 14px; border: 1px solid var(--border-soft); padding: 12px 12px 10px; margin-bottom: 10px; background: #ffffff; }
        .question-title { font-weight: 600; font-size: .95rem; }
        .empty-state { padding: 3rem 1rem; text-align: center; color: #858796; border: 2px dashed var(--border-soft); border-radius: 0.75rem; background: #f9fafb; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light fixed-top">
    <div class="container">
        <a class="navbar-brand" href="<c:url value='/questionnaire/list'/>"><i class="bi bi-card-checklist"></i> 问卷星</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto"></ul>
            <div class="d-flex align-items-center">
                <div class="dropdown">
                    <button class="btn btn-link user-dropdown-btn dropdown-toggle" type="button" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-person-circle me-1"></i>${user.username}
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                        <li><a class="dropdown-item" href="<c:url value='/user/logout'/>">退出</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</nav>

<div class="page-wrapper">
    <div class="container">
        <section class="design-header">
            <div class="design-header-inner">
                <div>
                    <h1 class="design-header-title">设计问卷: ${fn:substring(questionnaire.title, 0, 20)}${fn:length(questionnaire.title) > 20 ? '...' : ''}</h1>
                    <p class="design-header-subtitle mb-1">添加和管理此问卷中的所有问题。</p>
                </div>
                <div class="text-end">
                    <span class="badge-step mb-2 d-inline-flex"><i class="bi bi-pencil-square"></i> 设计阶段</span>
                    <div><a href="<c:url value='/questionnaire/list'/>" class="btn btn-sm btn-outline-light"><i class="bi bi-arrow-left"></i> 返回列表</a></div>
                </div>
            </div>
        </section>

        <section class="design-layout">
            <div class="row g-4">
                <div class="col-lg-4">
                    <div class="add-question-card position-sticky" style="top: 100px;">
                        <div class="add-question-header"><i class="bi bi-plus-circle-dotted"></i><span>添加新问题</span></div>
                        <form action="<c:url value='/question/add'/>" method="post">
                            <input type="hidden" name="questionnaireId" value="${questionnaire.id}"/>
                            <div class="mb-3">
                                <label for="questionText" class="form-label">问题内容 <span class="text-danger">*</span></label>
                                <textarea id="questionText" name="questionText" class="form-control" rows="3" required placeholder="例如：您对本次活动整体满意度如何？"></textarea>
                            </div>
                            <div class="mb-3">
                                <label for="questionType" class="form-label">题型 <span class="text-danger">*</span></label>
                                <select id="questionType" name="questionType" class="form-select" required onchange="toggleOptions(this)">
                                    <option value="" disabled selected>请选择题型</option>
                                    <option value="1">单选题</option>
                                    <option value="2">多选题</option>
                                    <option value="3">简答题</option>
                                </select>
                            </div>
                            <div class="mb-3" id="optionsContainer" style="display:none;">
                                <label for="options" class="form-label">选项（每行一个）</label>
                                <textarea id="options" name="options" class="form-control" rows="4" placeholder="选项1&#10;选项2&#10;选项3"></textarea>
                            </div>
                            <div class="form-check form-switch mb-4">
                                <input type="checkbox" class="form-check-input" id="isRequired" name="isRequired" value="1" checked>
                                <label class="form-check-label" for="isRequired">是否必填</label>
                            </div>
                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary"><i class="bi bi-plus-lg me-1"></i> 添加问题</button>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="col-lg-8">
                    <div class="questions-card">
                        <div class="questions-header">
                            <div class="questions-header-title"><i class="bi bi-list-ul"></i><span>问题列表</span></div>
                            <div class="questions-header-meta">
                                <c:choose>
                                    <c:when test="${not empty questions}">共 ${fn:length(questions)} 题</c:when>
                                    <c:otherwise>暂无题目</c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <hr class="mt-2 mb-3"/>
                        <c:choose>
                            <c:when test="${not empty questions}">
                                <c:forEach items="${questions}" var="question" varStatus="status">
                                    <div class="question-card">
                                        <div class="d-flex justify-content-between align-items-start">
                                            <div class="pe-3">
                                                <div class="question-title">${status.count}. ${question.questionText}</div>
                                                <div class="question-badges">
                                                    <span class="badge bg-info text-dark me-1">${question.typeDesc}</span>
                                                    <c:if test="${question.isRequired == 1}"><span class="badge bg-danger">必填</span></c:if>
                                                </div>
                                            </div>
                                            <div class="question-actions">
                                                <a href="<c:url value='/question/delete/${question.id}'/>" class="btn btn-sm btn-outline-danger" onclick="return confirm('确定要删除此问题吗？')" title="删除"><i class="bi bi-trash"></i></a>
                                            </div>
                                        </div>
                                        <c:if test="${question.questionType != 3 && not empty question.options}">
                                            <hr class="my-2">
                                            <div class="question-options d-flex flex-wrap gap-2">
                                                <c:forEach items="${question.options}" var="option">
                                                    <span class="badge bg-light text-dark border">${option.optionText}</span>
                                                </c:forEach>
                                            </div>
                                        </c:if>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-state">
                                    <i class="bi bi-question-circle"></i>
                                    <p class="mt-3 mb-1 fs-5">暂无问题</p>
                                    <p class="mb-0 small text-muted">请在左侧添加问题来丰富您的问卷。</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>

<script src="<c:url value='/resources/js/bootstrap/bootstrap.bundle.min.js'/>"></script>
<script>
    const navbar = document.querySelector('.navbar');
    window.addEventListener('scroll', function () {
        if (window.scrollY > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });
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