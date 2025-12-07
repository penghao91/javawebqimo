<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${not empty pageTitle ? pageTitle : '问卷星'}</title>

    <link href="<c:url value='/resources/css/bootstrap/bootstrap.min.css'/>" rel="stylesheet">
    <link href="<c:url value='/resources/css/bootstrap-icons/bootstrap-icons.css'/>" rel="stylesheet">

    <style>
        :root {
            --primary-color: #4e73df;
            --primary-dark: #224abe;
            --secondary-color: #858796;
            --success-color: #1cc88a;
            --danger-color: #e74a3b;
            --light-color: #f8f9fc;
            --dark-color: #4b4d63;
            --muted-color: #a0a3b1;
            --border-soft: #e1e5f2;
        }

        * { box-sizing: border-box; }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'SF Pro Text', 'Segoe UI', 'Roboto', 'Helvetica Neue', Arial, sans-serif;
            background: radial-gradient(circle at top left, #f0f4ff 0, #f8f9fc 45%, #fdfdfd 100%);
            color: var(--dark-color);
            line-height: 1.6;
        }

        a { text-decoration: none; }

        .navbar {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(16px);
            box-shadow: 0 8px 24px rgba(15, 23, 42, 0.08);
            transition: all 0.3s ease;
            padding-top: 0.75rem;
            padding-bottom: 0.75rem;
        }

        .navbar.scrolled {
            padding-top: 0.4rem;
            padding-bottom: 0.4rem;
            background: rgba(255, 255, 255, 0.98);
            box-shadow: 0 10px 30px rgba(15, 23, 42, 0.14);
        }

        .navbar-brand {
            font-weight: 800;
            font-size: 1.45rem;
            color: var(--primary-color) !important;
            display: flex;
            align-items: center;
            gap: .4rem;
        }

        .navbar-brand i {
            font-size: 1.4rem;
            color: var(--primary-dark);
        }

        .navbar-collapse {
            flex-grow: 0;
        }

        .user-dropdown-btn {
            text-decoration: none;
            font-weight: 500;
            color: var(--secondary-color) !important;
        }

        .user-dropdown-btn i { color: var(--primary-color); }

        .user-dropdown-btn:hover {
            color: var(--primary-color) !important;
        }

        .page-wrapper {
            padding-top: 88px;
            padding-bottom: 40px;
        }

        .design-header {
            margin-bottom: 18px;
        }

        .design-header-inner {
            background: linear-gradient(135deg, #4f46e5 0, #1d4ed8 40%, #2563eb 100%);
            border-radius: 20px;
            padding: 18px 22px;
            color: #fff;
            box-shadow: 0 14px 36px rgba(37, 99, 235, 0.35);
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 1rem;
        }

        .design-header-title {
            margin: 0;
            font-size: 1.5rem;
            font-weight: 700;
        }

        .design-header-subtitle {
            margin: .25rem 0 0;
            font-size: .96rem;
            opacity: .9;
        }

        .badge-step {
            display: inline-flex;
            align-items: center;
            gap: .25rem;
            padding: .25rem .8rem;
            border-radius: 999px;
            border: 1px solid rgba(248, 250, 252, 0.9);
            background: rgba(15,23,42,.15);
            font-size: .8rem;
        }

        .folder-layout, .design-layout { margin-top: 10px; }

        .nav-card {
            background: #ffffff;
            border-radius: 18px;
            padding: 14px 14px 10px;
            box-shadow: 0 14px 40px rgba(15, 23, 42, 0.08);
            border: 1px solid rgba(226, 232, 240, 0.9);
        }

        .nav-card-title {
            font-weight: 700;
            font-size: .95rem;
            display: flex;
            align-items: center;
            gap: .35rem;
            margin-bottom: 8px;
        }

        .nav-card-title i { color: var(--primary-color); }

        .nav-card-sub {
            font-size: .8rem;
            color: var(--muted-color);
            margin-bottom: .6rem;
        }

        .nav-card-menu {
            list-style: none;
            padding-left: 0;
            margin: 0;
        }

        .nav-card-menu li + li { margin-top: .25rem; }

        .nav-link-chip {
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: .35rem;
            padding: .42rem .75rem;
            border-radius: 999px;
            font-size: .86rem;
            color: #4b5563;
            border: 1px solid transparent;
            background: #f9fafb;
            transition: all .15s ease;
        }

        .nav-link-chip i {
            font-size: 1rem;
            width: 18px;
            text-align: center;
            color: var(--primary-color);
        }

        .nav-link-chip:hover {
            background: #eef2ff;
            border-color: rgba(78, 115, 223, 0.45);
            color: var(--primary-color);
            transform: translateY(-1px);
        }

        .nav-link-chip.active {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            color: #fff;
            border-color: transparent;
            box-shadow: 0 10px 24px rgba(78,115,223,0.55);
        }

        .nav-link-chip.active i { color: #fff; }

        .content-card, .add-question-card, .questions-card {
            background: #ffffff;
            border-radius: 18px;
            padding: 22px 24px 20px;
            box-shadow: 0 14px 40px rgba(15, 23, 42, 0.08);
            border: 1px solid rgba(226, 232, 240, 0.9);
        }
        
        .content-card-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 14px;
        }

        .content-card-title {
            display: flex;
            align-items: center;
            gap: .5rem;
        }

        .content-card-title-icon {
            width: 36px;
            height: 36px;
            border-radius: 12px;
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
        }

        .content-card-title-text {
            font-size: 1rem;
            font-weight: 700;
        }

        .content-card-subtitle {
            font-size: .86rem;
            color: var(--muted-color);
            margin-top: 2px;
        }
        
        .questionnaire-card {
            background: #fff;
            border-radius: 12px;
            border: 1px solid #e5e7eb;
            margin-bottom: .7rem;
            padding: 1rem 1.1rem .9rem;
            border-left: 4px solid transparent;
            transition: all .16s ease;
        }

        .questionnaire-card:hover {
            transform: translateY(-1px);
            box-shadow: 0 12px 28px rgba(15, 23, 42, 0.12);
            border-left-color: rgba(78,115,223,.6);
        }
        
        .empty-state {
            padding: 3rem 1rem;
            text-align: center;
            color: #858796;
            border: 2px dashed var(--border-soft);
            border-radius: 0.75rem;
            background: #f9fafb;
        }
        .empty-state .icon {
            font-size: 3.2rem;
            color: #cbd5f5;
            margin-bottom: 1rem;
        }
        
        .form-control, .form-select { border-radius: 12px; border: 1px solid var(--border-soft); font-size: .9rem; padding: .5rem .75rem; }
        .form-control:focus, .form-select:focus { border-color: var(--primary-color); box-shadow: 0 0 0 1px rgba(78,115,223,0.35); outline: none; }
        
        .add-question-header, .questions-header-title { font-weight: 700; font-size: .95rem; display: flex; align-items: center; gap: .4rem; margin-bottom: 10px; }
        .add-question-header i, .questions-header-title i { color: var(--primary-color); }
        .question-card { border-radius: 14px; border: 1px solid var(--border-soft); padding: 12px 12px 10px; margin-bottom: 10px; background: #ffffff; }
        .question-title { font-weight: 600; font-size: .95rem; }
        
        #alert-container { position: fixed; top: 80px; right: 20px; z-index: 1055; width: 360px; }
        .pretty-alert { border-radius: 12px; border: none; box-shadow: 0 8px 30px rgba(15, 23, 42, 0.2); padding: 0.85rem 1rem; display: flex; align-items: center; gap: 0.6rem; margin-bottom: 0.5rem; font-size: 0.9rem; }
        .pretty-alert i { font-size: 1.1rem; }
        
        .folder-modal .modal-content, .delete-modal .modal-content { border-radius: 16px; border: none; box-shadow: 0 16px 40px rgba(15, 23, 42, 0.35); overflow: hidden; }
        .folder-modal .modal-header, .delete-modal .modal-header { color: white; border-bottom: none; padding: 1.1rem 1.5rem; }
        .folder-modal .modal-header { background: linear-gradient(135deg, var(--primary-color), var(--primary-dark)); }
        .delete-modal .modal-header { background: linear-gradient(135deg, #f97373, #ef4444); }
        
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light fixed-top">
    <div class="container">
        <a class="navbar-brand" href="<c:url value='/questionnaire/list'/>">
            <i class="bi bi-card-checklist"></i> 问卷星
        </a>

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
</body>