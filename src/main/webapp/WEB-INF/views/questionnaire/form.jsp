<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty questionnaire.id ? '创建问卷' : '编辑问卷'} - 问卷星</title>
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
        .navbar-brand { font-weight: 800; font-size: 1.45rem; color: var(--primary-color) !important; display: flex; align-items: center; gap: .4rem; }
        .navbar-brand i { font-size: 1.4rem; color: var(--primary-dark); }
        .user-dropdown-btn { text-decoration: none; font-weight: 500; color: var(--secondary-color) !important; }
        .user-dropdown-btn i { color: var(--primary-color); }
        .user-dropdown-btn:hover { color: var(--primary-color) !important; }
        .page-wrapper { padding-top: 88px; padding-bottom: 40px; }
        .design-header { margin-bottom: 18px; }
        .design-header-inner { background: linear-gradient(135deg, #4f46e5 0, #1d4ed8 40%, #2563eb 100%); border-radius: 20px; padding: 18px 22px; color: #fff; box-shadow: 0 14px 36px rgba(37, 99, 235, 0.35); display: flex; align-items: center; justify-content: space-between; gap: 1rem; }
        .design-header-title { margin: 0; font-size: 1.5rem; font-weight: 700; }
        .design-header-subtitle { margin: .25rem 0 0; font-size: .96rem; opacity: .9; }
        .badge-step { display: inline-flex; align-items: center; gap: .25rem; padding: .25rem .8rem; border-radius: 999px; border: 1px solid rgba(248, 250, 252, 0.9); background: rgba(15,23,42,.15); font-size: .8rem; }
        .folder-layout { margin-top: 10px; }
        .nav-card { background: #ffffff; border-radius: 18px; padding: 14px 14px 10px; box-shadow: 0 14px 40px rgba(15, 23, 42, 0.08); border: 1px solid rgba(226, 232, 240, 0.9); }
        .nav-card-title { font-weight: 700; font-size: .95rem; display: flex; align-items: center; gap: .35rem; margin-bottom: 8px; }
        .nav-card-title i { color: var(--primary-color); }
        .nav-card-sub { font-size: .8rem; color: var(--muted-color); margin-bottom: .6rem; }
        .nav-card-menu { list-style: none; padding-left: 0; margin: 0; }
        .nav-card-menu li + li { margin-top: .25rem; }
        .nav-link-chip { text-decoration: none; display: flex; align-items: center; gap: .35rem; padding: .42rem .75rem; border-radius: 999px; font-size: .86rem; color: #4b5563; border: 1px solid transparent; background: #f9fafb; transition: all .15s ease; }
        .nav-link-chip i { font-size: 1rem; width: 18px; text-align: center; color: var(--primary-color); }
        .nav-link-chip:hover { background: #eef2ff; border-color: rgba(78, 115, 223, 0.45); color: var(--primary-color); transform: translateY(-1px); }
        .nav-link-chip.active { background: linear-gradient(135deg, var(--primary-color), var(--primary-dark)); color: #fff; border-color: transparent; box-shadow: 0 10px 24px rgba(78,115,223,0.55); }
        .nav-link-chip.active i { color: #fff; }
        .content-card { background: #ffffff; border-radius: 18px; padding: 22px 24px 20px; box-shadow: 0 14px 40px rgba(15, 23, 42, 0.08); border: 1px solid rgba(226, 232, 240, 0.9); }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light fixed-top">
    <div class="container">
        <a class="navbar-brand" href="<c:url value='/questionnaire/list'/>"><i class="bi bi-card-checklist"></i> 问卷星</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto"></ul>
            <div class="d-flex align-items-center">
                <c:if test="${not empty user}">
                    <div class="dropdown">
                        <button class="btn btn-link user-dropdown-btn dropdown-toggle"
                                type="button" id="userDropdown"
                                data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-person-circle me-1"></i>${user.username}
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                            <li class="dropdown-header small text-muted px-3 py-2">
                                用户名：${user.username}<br>
                                账号ID：${user.id}<br>
                                <c:if test="${not empty user.email}">
                                    邮箱：${user.email}
                                </c:if>
                            </li>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <a class="dropdown-item" href="<c:url value='/user/profile'/>">
                                    <i class="bi bi-person-lines-fill me-1"></i>账号信息
                                </a>
                            </li>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <a class="dropdown-item text-danger" href="<c:url value='/user/logout'/>">
                                    <i class="bi bi-box-arrow-right me-1"></i>退出
                                </a>
                            </li>
                        </ul>
                    </div>
                </c:if>
                <c:if test="${empty user}">
                    <a href="<c:url value='/user/login'/>" class="btn btn-outline-primary btn-sm">
                        登录
                    </a>
                </c:if>
            </div>
        </div>
    </div>
</nav>

<div class="page-wrapper">
    <div class="container">
        <section class="design-header">
            <div class="design-header-inner">
                <div>
                    <h1 class="design-header-title">${empty questionnaire.id ? '创建新问卷' : '编辑问卷'}</h1>
                    <p class="design-header-subtitle mb-1">为你的问卷填写标题和描述，开启信息收集之旅的第一步。</p>
                </div>
                <div class="text-end"><span class="badge-step mb-2 d-inline-flex"><i class="bi bi-pencil-square"></i> 基本信息</span></div>
            </div>
        </section>

        <section class="folder-layout">
            <div class="row g-4">
                <div class="col-lg-3">
                    <div class="nav-card">
                        <div class="nav-card-title"><i class="bi bi-compass"></i><span>快速导航</span></div>
                        <div class="nav-card-sub">切换不同的问卷视图</div>
                        <ul class="nav-card-menu">
                            <li><a href="<c:url value='/questionnaire/create'/>" class="nav-link-chip active"><i class="bi bi-plus-circle"></i> 创建问卷</a></li>
                            <li><a href="<c:url value='/questionnaire/list'/>" class="nav-link-chip"><i class="bi bi-list-ul"></i> 全部问卷</a></li>
                            <li><a href="#" class="nav-link-chip"><i class="bi bi-star"></i> 星标问卷</a></li>
                            <li><a href="<c:url value='/questionnaire/folders'/>" class="nav-link-chip"><i class="bi bi-folder"></i> 文件夹</a></li>
                            <li><a href="#" class="nav-link-chip"><i class="bi bi-trash"></i> 回收站</a></li>
                        </ul>
                    </div>
                </div>

                <div class="col-lg-9">
                    <div class="content-card">
                        <c:url value='/questionnaire/${empty questionnaire.id ? "create" : "edit/"}${questionnaire.id}' var="formAction"/>
                        <form:form modelAttribute="questionnaire" action="${formAction}" method="post">
                            <div class="mb-4">
                                <form:label path="title" class="form-label">问卷标题 <span class="text-danger">*</span></form:label>
                                <form:input path="title" class="form-control form-control-lg" required="true" maxlength="200" placeholder="请输入问卷标题"/>
                            </div>
                            <div class="mb-4">
                                <form:label path="description" class="form-label">问卷描述</form:label>
                                <form:textarea path="description" class="form-control" rows="4" maxlength="1000" placeholder="请输入问卷描述，帮助填写者了解问卷目的"/>
                            </div>
                            <div class="d-flex justify-content-end gap-3">
                                <a href="<c:url value='/questionnaire/list'/>" class="btn btn-secondary">取消</a>
                                <button type="submit" class="btn btn-primary">${empty questionnaire.id ? '创建并设计问卷' : '保存修改'}</button>
                            </div>
                        </form:form>
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
        if (window.scrollY > 50) navbar.classList.add('scrolled');
        else navbar.classList.remove('scrolled');
    });
</script>

</body>
</html>