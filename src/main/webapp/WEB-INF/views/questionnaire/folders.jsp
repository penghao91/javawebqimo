<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>文件夹管理 - 问卷系统</title>
    <link href="<c:url value='/resources/css/bootstrap/bootstrap.min.css'/>" rel="stylesheet">
    <link href="<c:url value='/resources/css/bootstrap-icons/bootstrap-icons.css'/>" rel="stylesheet">
    <style>
        :root {
            --bs-primary-rgb: 78, 115, 223;
            --bs-body-bg: #f8f9fc;
            --bs-body-color: #5a5c69;
            --border-color: #e3e6f0;
            --sidebar-width: 250px;
        }
        body {
            background-color: var(--bs-body-bg);
            color: var(--bs-body-color);
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
        }
        /* 顶部导航 */
        .top-navbar {
            background: linear-gradient(135deg, rgba(var(--bs-primary-rgb), 1), rgba(var(--bs-primary-rgb), 0.8));
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            height: 70px;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1030;
        }
        .top-navbar .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
            color: white !important;
        }
        .top-nav-menu {
            display: flex;
            align-items: center;
            gap: 2rem;
            margin-left: 2rem;
        }
        .top-nav-item {
            color: rgba(255,255,255,0.9) !important;
            text-decoration: none;
            font-weight: 500;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        .top-nav-item:hover, .top-nav-item.active {
            background-color: rgba(255,255,255,0.15);
            color: white !important;
        }
        .user-info {
            display: flex;
            align-items: center;
            gap: 1rem;
            color: white;
        }
        .user-phone { font-weight: 500; }

        /* 主体布局 */
        .main-container {
            display: flex;
            min-height: calc(100vh - 70px);
            margin-top: 70px;
            position: relative;
            z-index: 1;
        }
        /* 左侧菜单 */
        .sidebar {
            width: var(--sidebar-width);
            background: white;
            border-right: 1px solid var(--border-color);
            padding: 1.5rem 0;
            box-shadow: 2px 0 5px rgba(0,0,0,0.05);
            position: relative;
            z-index: 100;
        }
        .sidebar-menu { list-style: none; padding: 0; margin: 0; }
        .sidebar-menu-item { margin: 0.25rem 0; }
        .sidebar-menu-link {
            display: flex;
            align-items: center;
            padding: 0.75rem 1.5rem;
            color: var(--bs-body-color);
            text-decoration: none;
            transition: all 0.3s ease;
            border-left: 3px solid transparent;
        }
        .sidebar-menu-link:hover {
            background-color: #f8f9fc;
            color: rgba(var(--bs-primary-rgb), 1);
        }
        .sidebar-menu-link.active {
            background-color: rgba(var(--bs-primary-rgb), 0.1);
            color: rgba(var(--bs-primary-rgb), 1);
            border-left-color: rgba(var(--bs-primary-rgb), 1);
        }
        .sidebar-menu-link i {
            margin-right: 0.75rem;
            font-size: 1.1rem;
            width: 20px;
            text-align: center;
        }

        /* 内容区域 */
        .content-area {
            flex: 1;
            padding: 2rem;
            background-color: var(--bs-body-bg);
        }
        .page-header {
            background: white;
            padding: 1.5rem 2rem;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .page-title {
            font-size: 1.75rem;
            font-weight: 600;
            color: #2c3e50;
            margin: 0;
            display: flex;
            align-items: center;
        }
        .page-title i { margin-right: 0.5rem; }
        .page-indicator {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.35rem 0.9rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
            margin-left: 0.75rem;
            background: rgba(var(--bs-primary-rgb), 0.08);
            color: rgba(var(--bs-primary-rgb), 1);
        }
        .create-btn {
            background: linear-gradient(135deg, rgba(var(--bs-primary-rgb), 1), rgba(var(--bs-primary-rgb), 0.8));
            border: none;
            padding: 0.75rem 1.5rem;
            font-weight: 500;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        .create-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(var(--bs-primary-rgb), 0.3);
        }

        /* 文件夹卡片 */
        .folder-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 1rem;
            padding: 1.5rem 2rem;
            transition: all 0.3s ease;
            border-left: 4px solid transparent;
        }
        .folder-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        .folder-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .folder-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: #2c3e50;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .folder-sub {
            font-size: 0.85rem;
            color: #6c757d;
            margin-top: 0.25rem;
        }
        .folder-stats {
            display: flex;
            gap: 2rem;
            margin: 1rem 0 0.25rem 0;
            flex-wrap: wrap;
        }
        .stat-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #6c757d;
            font-size: 0.9rem;
        }
        .stat-value {
            font-weight: 600;
            color: rgba(var(--bs-primary-rgb), 1);
        }
        .folder-actions {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }
        .action-btn {
            padding: 0.45rem 0.95rem;
            border: 1px solid var(--border-color);
            background: white;
            color: var(--bs-body-color);
            text-decoration: none;
            border-radius: 6px;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
        }
        .action-btn:hover {
            background-color: #f8f9fc;
            color: rgba(var(--bs-primary-rgb), 1);
            border-color: rgba(var(--bs-primary-rgb), 1);
        }
        .action-btn.danger {
            color: #dc3545;
            border-color: #dc3545;
        }
        .action-btn.danger:hover {
            background-color: #dc3545;
            color: white;
        }

        /* 空状态 */
        .empty-state {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            padding: 4rem 2rem;
            text-align: center;
            color: #6c757d;
        }
        .empty-state .icon {
            font-size: 4rem;
            color: #dee2e6;
            margin-bottom: 1rem;
        }

        /* 顶部提示（toast 样式） */
        #alert-container {
            position: fixed;
            top: 80px;
            right: 20px;
            z-index: 1055;
            width: 360px;
        }
        .pretty-alert {
            border-radius: 12px;
            border: none;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
            padding: 0.85rem 1rem;
            display: flex;
            align-items: center;
            gap: 0.6rem;
            margin-bottom: 0.5rem;
        }
        .pretty-alert i {
            font-size: 1.2rem;
        }

        /* 文件夹新建/重命名模态框 */
        .folder-modal .modal-content {
            border-radius: 12px;
            border: none;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            overflow: hidden;
        }
        .folder-modal .modal-header {
            background: linear-gradient(135deg, rgba(var(--bs-primary-rgb), 1), rgba(34, 74, 190, 1));
            color: white;
            border-bottom: none;
            padding: 1.15rem 1.5rem;
        }
        .folder-modal .modal-title {
            font-weight: 600;
            font-size: 1.1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .folder-modal .modal-body {
            padding: 1.6rem 1.5rem 1.2rem;
        }
        .folder-modal .modal-footer {
            border-top: 1px solid #e9ecef;
            padding: 0.9rem 1.5rem;
            gap: 0.75rem;
        }
        .folder-modal .folder-icon {
            width: 48px;
            height: 48px;
            border-radius: 16px;
            background: rgba(78, 115, 223, 0.08);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 0.75rem;
        }
        .folder-modal .folder-icon i {
            font-size: 1.8rem;
            color: rgba(var(--bs-primary-rgb), 1);
        }
        .folder-modal .input-label {
            font-weight: 500;
            margin-bottom: 0.35rem;
        }
        .folder-modal .form-text {
            font-size: 0.85rem;
        }
        .folder-modal .btn-cancel {
            background: #f8f9fa;
            border: 1px solid #dee2e6;
            color: #6c757d;
            padding: 0.45rem 1.4rem;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .folder-modal .btn-cancel:hover {
            background: #e9ecef;
            color: #495057;
        }
        .folder-modal .btn-save {
            background: linear-gradient(135deg, rgba(var(--bs-primary-rgb), 1), rgba(34, 74, 190, 1));
            border: none;
            color: white;
            padding: 0.45rem 1.6rem;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .folder-modal .btn-save:hover {
            transform: translateY(-1px);
            box-shadow: 0 5px 15px rgba(78, 115, 223, 0.35);
        }

        /* 删除确认模态框（复用你问卷页的风格） */
        .delete-modal .modal-content {
            border-radius: 12px;
            border: none;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            overflow: hidden;
        }
        .delete-modal .modal-header {
            background: linear-gradient(135deg, #ff6b6b, #ff5252);
            color: white;
            border-bottom: none;
            padding: 1.25rem 1.5rem;
        }
        .delete-modal .modal-title {
            font-weight: 600;
            font-size: 1.1rem;
        }
        .delete-modal .modal-body {
            padding: 2rem 1.8rem 1.5rem;
            text-align: center;
        }
        .delete-modal .warning-icon {
            font-size: 3rem;
            color: #ff6b6b;
            margin-bottom: 1rem;
        }
        .delete-modal .delete-message {
            font-size: 1.1rem;
            color: #2c3e50;
            margin-bottom: 0.5rem;
            font-weight: 500;
        }
        .delete-modal .delete-hint {
            color: #6c757d;
            font-size: 0.9rem;
        }
        .delete-modal .modal-footer {
            border-top: 1px solid #e9ecef;
            padding: 1rem 1.5rem;
            gap: 0.75rem;
        }
        .delete-modal .btn-cancel {
            background: #f8f9fa;
            border: 1px solid #dee2e6;
            color: #6c757d;
            padding: 0.5rem 1.5rem;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .delete-modal .btn-cancel:hover {
            background: #e9ecef;
            color: #495057;
        }
        .delete-modal .btn-delete {
            background: linear-gradient(135deg, #ff6b6b, #ff5252);
            border: none;
            color: white;
            padding: 0.5rem 1.5rem;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .delete-modal .btn-delete:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.4);
        }

        @media (max-width: 768px) {
            .sidebar { display: none; }
            .content-area { padding: 1rem; }
            .page-header {
                flex-direction: column;
                gap: 1rem;
                text-align: center;
                align-items: flex-start;
            }
            .page-title {
                flex-wrap: wrap;
            }
            .folder-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.75rem;
            }
            .folder-actions {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<div id="alert-container"></div>

<!-- 顶部导航栏 -->
<nav class="navbar navbar-expand-lg top-navbar fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="<c:url value='/questionnaire/list'/>">
            <i class="bi bi-card-checklist"></i> 问卷星
        </a>
        <div class="top-nav-menu">
            <a href="<c:url value='/questionnaire/list'/>" class="top-nav-item">
                <i class="bi bi-journal-text"></i> 我的问卷
            </a>
            <a href="#" class="top-nav-item">
                <i class="bi bi-people"></i> 通讯录
            </a>
            <a href="#" class="top-nav-item">
                <i class="bi bi-grid-3x3-gap"></i> 应用
            </a>
        </div>
        <div class="user-info ms-auto">
            <span class="user-phone">${user.username}</span>
            <a class="btn btn-outline-light btn-sm" href="<c:url value='/user/logout'/>">
                <i class="bi bi-box-arrow-right"></i> 退出
            </a>
        </div>
    </div>
</nav>

<div class="main-container">
    <!-- 左侧边栏 -->
    <div class="sidebar">
        <ul class="sidebar-menu">
            <li class="sidebar-menu-item">
                <a href="<c:url value='/questionnaire/create'/>" class="sidebar-menu-link">
                    <i class="bi bi-plus-circle"></i> 创建问卷
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="<c:url value='/questionnaire/list'/>" class="sidebar-menu-link">
                    <i class="bi bi-list-ul"></i> 全部问卷
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="<c:url value='/questionnaire/starred'/>" class="sidebar-menu-link">
                    <i class="bi bi-star"></i> 星标问卷
                </a>
            </li>
            <li class="sidebar-menu-item">
                <!-- 当前页高亮 -->
                <a href="<c:url value='/folder/list'/>" class="sidebar-menu-link active">
                    <i class="bi bi-folder"></i> 文件夹
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="<c:url value='/questionnaire/recycle'/>" class="sidebar-menu-link">
                    <i class="bi bi-trash"></i> 回收站
                </a>
            </li>
        </ul>
    </div>

    <!-- 内容区域 -->
    <div class="content-area">
        <div class="page-header">
            <div class="d-flex align-items-center">
                <h1 class="page-title">
                    <i class="bi bi-folder-fill"></i> 文件夹管理
                </h1>
                <span class="page-indicator">
                    <i class="bi bi-layers"></i> 对问卷进行分组和归类
                </span>
            </div>
            <button class="btn btn-primary create-btn" type="button" onclick="openCreateFolderModal()">
                <i class="bi bi-plus-lg"></i> 新建文件夹
            </button>
        </div>

        <div id="folder-list-container">
            <!-- JS 渲染文件夹列表 -->
        </div>

        <div id="empty-state-container" class="empty-state" style="display: none;">
            <div class="icon"><i class="bi bi-folder2-open"></i></div>
            <h4>暂无文件夹</h4>
            <p class="text-muted">点击右上角“新建文件夹”按钮创建您的第一个文件夹</p>
            <button class="btn btn-primary mt-3" type="button" onclick="openCreateFolderModal()">
                <i class="bi bi-plus-lg"></i> 新建文件夹
            </button>
        </div>
    </div>
</div>

<!-- 新建 / 重命名 文件夹模态框 -->
<div class="modal fade folder-modal" id="folderEditModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="folderModalTitle">
                    <i class="bi bi-folder-plus"></i> 新建文件夹
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="d-flex mb-3">
                    <div class="folder-icon">
                        <i class="bi bi-folder2"></i>
                    </div>
                    <div>
                        <div class="fw-semibold mb-1" style="font-size: 0.95rem;">合理使用文件夹，可以更高效地管理问卷</div>
                        <div class="text-muted" style="font-size: 0.85rem;" id="folderModalHint">
                            例如：“市场调研”、“满意度调查”、“内部问卷”等
                        </div>
                    </div>
                </div>

                <div class="mb-2">
                    <label class="input-label" for="folderNameInput">文件夹名称</label>
                    <input type="text" class="form-control" id="folderNameInput" maxlength="50"
                           placeholder="请输入文件夹名称">
                    <div class="invalid-feedback" id="folderNameError" style="display: none;"></div>
                </div>
                <div class="form-text text-muted">
                    建议使用简短且能清晰表达用途的名称，最多 50 个字符。
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-cancel" data-bs-dismiss="modal">
                    <i class="bi bi-x-lg me-1"></i>取消
                </button>
                <button type="button" class="btn btn-save" onclick="submitFolderModal()">
                    <i class="bi bi-check-lg me-1"></i>确定
                </button>
            </div>
        </div>
    </div>
</div>

<!-- 删除文件夹确认模态框 -->
<div class="modal fade delete-modal" id="folderDeleteModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i> 确认删除文件夹
                </h5>
            </div>
            <div class="modal-body">
                <div class="warning-icon">
                    <i class="bi bi-exclamation-circle"></i>
                </div>
                <div class="delete-message">
                    确定要删除文件夹 <span class="text-danger" id="deleteFolderName">该文件夹</span> 吗？
                </div>
                <div class="delete-hint">
                    文件夹删除后，文件夹中的问卷不会被删除，将自动移动到“未分类”文件夹中。
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-cancel" data-bs-dismiss="modal">
                    <i class="bi bi-x-lg me-1"></i>取消
                </button>
                <button type="button" class="btn btn-delete" onclick="confirmDeleteFolder()">
                    <i class="bi bi-trash-fill me-1"></i>确认删除
                </button>
            </div>
        </div>
    </div>
</div>

<script src="<c:url value='/resources/js/bootstrap/bootstrap.bundle.min.js'/>"></script>
<script>
    let currentFolderId = null;
    let deleteFolderId = null;

    document.addEventListener('DOMContentLoaded', function () {
        loadFolders();
    });

    function showAlert(type, message, duration) {
        if (duration === undefined) duration = 3000;
        const alertContainer = document.getElementById('alert-container');
        if (!alertContainer) return;

        const alertId = 'alert-' + Date.now();
        const icon = type === 'success' ? 'check-circle-fill' : 'exclamation-triangle-fill';
        const bsClass = type === 'success' ? 'alert-success' : 'alert-danger';

        const html =
            '<div id="' + alertId + '" class="alert ' + bsClass + ' pretty-alert alert-dismissible fade show" role="alert">' +
            '<i class="bi bi-' + icon + '"></i>' +
            '<div class="flex-grow-1">' + message + '</div>' +
            '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>' +
            '</div>';

        alertContainer.insertAdjacentHTML('beforeend', html);

        setTimeout(function () {
            const alertElement = document.getElementById(alertId);
            if (alertElement) {
                const bsAlert = bootstrap.Alert.getOrCreateInstance(alertElement);
                if (bsAlert) bsAlert.close();
            }
        }, duration);
    }

    function formatDate(dateString) {
        if (!dateString) return 'N/A';
        const normalized = dateString.replace(' ', 'T');
        const date = new Date(normalized);
        if (isNaN(date.getTime())) return dateString;
        return date.toLocaleDateString('zh-CN', {
            year: 'numeric',
            month: '2-digit',
            day: '2-digit'
        });
    }

    function escapeHtml(text) {
        if (text === null || typeof text === 'undefined') return '';
        const map = {
            '&': '&amp;',
            '<': '&lt;',
            '>': '&gt;',
            '"': '&quot;',
            "'": '&#039;'
        };
        return text.toString().replace(/[&<>"']/g, function (m) { return map[m]; });
    }

    function loadFolders() {
        fetch('<c:url value="/folder/api/list"/>')
            .then(function (response) {
                return response.ok ? response.json() : Promise.reject('Network response was not ok');
            })
            .then(function (data) {
                if (data.success) {
                    renderFolders(data.folders);
                } else {
                    showAlert('danger', '加载文件夹失败: ' + data.message);
                }
            })
            .catch(function (error) {
                console.error('加载文件夹失败:', error);
                showAlert('danger', '加载文件夹失败，请检查网络或联系管理员。');
            });
    }

    /* 打开新建文件夹弹窗 */
    function openCreateFolderModal() {
        currentFolderId = null;
        const titleEl = document.getElementById('folderModalTitle');
        const hintEl = document.getElementById('folderModalHint');
        const inputEl = document.getElementById('folderNameInput');
        const errorEl = document.getElementById('folderNameError');

        titleEl.innerHTML = '<i class="bi bi-folder-plus"></i> 新建文件夹';
        hintEl.textContent = '例如：“市场调研”、“满意度调查”、“内部问卷”等';
        inputEl.value = '';
        inputEl.placeholder = '请输入文件夹名称';
        inputEl.classList.remove('is-invalid');
        errorEl.style.display = 'none';

        const modalEl = document.getElementById('folderEditModal');
        const modal = bootstrap.Modal.getOrCreateInstance(modalEl);
        modal.show();

        setTimeout(function () { inputEl.focus(); }, 200);
    }

    /* 打开重命名弹窗 */
    function openEditFolderModal(id, name) {
        currentFolderId = parseInt(id, 10);
        const titleEl = document.getElementById('folderModalTitle');
        const hintEl = document.getElementById('folderModalHint');
        const inputEl = document.getElementById('folderNameInput');
        const errorEl = document.getElementById('folderNameError');

        titleEl.innerHTML = '<i class="bi bi-pencil-square"></i> 重命名文件夹';
        hintEl.textContent = '重命名不会影响文件夹中的问卷，仅修改显示名称';
        inputEl.value = name || '';
        inputEl.placeholder = '';
        inputEl.classList.remove('is-invalid');
        errorEl.style.display = 'none';

        const modalEl = document.getElementById('folderEditModal');
        const modal = bootstrap.Modal.getOrCreateInstance(modalEl);
        modal.show();

        setTimeout(function () {
            inputEl.focus();
            inputEl.select();
        }, 200);
    }

    /* 保存（新建/重命名） */
    function submitFolderModal() {
        const inputEl = document.getElementById('folderNameInput');
        const errorEl = document.getElementById('folderNameError');
        const rawName = inputEl.value;
        const name = rawName.replace(/^\s+|\s+$/g, '');

        inputEl.classList.remove('is-invalid');
        errorEl.style.display = 'none';

        if (!name) {
            inputEl.classList.add('is-invalid');
            errorEl.textContent = '文件夹名称不能为空';
            errorEl.style.display = 'block';
            inputEl.focus();
            return;
        }
        if (name.length > 50) {
            inputEl.classList.add('is-invalid');
            errorEl.textContent = '文件夹名称不能超过 50 个字符';
            errorEl.style.display = 'block';
            inputEl.focus();
            return;
        }

        let url;
        let method;
        const bodyObj = { name: name };

        if (currentFolderId === null) {
            url = '<c:url value="/folder/api/create"/>';
            method = 'POST';
        } else {
            url = '<c:url value="/folder/api/update"/>' + '/' + currentFolderId;
            method = 'PUT';
        }

        fetch(url, {
            method: method,
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify(bodyObj)
        })
            .then(function (response) { return response.json(); })
            .then(function (data) {
                if (data.success) {
                    const modalEl = document.getElementById('folderEditModal');
                    const modal = bootstrap.Modal.getOrCreateInstance(modalEl);
                    modal.hide();

                    if (currentFolderId === null) {
                        showAlert('success', '文件夹创建成功！');
                    } else {
                        showAlert('success', '文件夹重命名成功！');
                    }
                    loadFolders();
                } else {
                    inputEl.classList.add('is-invalid');
                    errorEl.textContent = data.message || '操作失败，请稍后重试';
                    errorEl.style.display = 'block';
                }
            })
            .catch(function () {
                inputEl.classList.add('is-invalid');
                errorEl.textContent = '请求失败，请稍后重试';
                errorEl.style.display = 'block';
            });
    }

    /* 打开删除弹窗 */
    function openDeleteFolderModal(id, name) {
        deleteFolderId = parseInt(id, 10);
        const nameEl = document.getElementById('deleteFolderName');
        nameEl.textContent = name || '该文件夹';

        const modalEl = document.getElementById('folderDeleteModal');
        const modal = bootstrap.Modal.getOrCreateInstance(modalEl);
        modal.show();
    }

    /* 确认删除 */
    function confirmDeleteFolder() {
        if (deleteFolderId === null || isNaN(deleteFolderId)) return;

        const url = '<c:url value="/folder/api/delete"/>' + '/' + deleteFolderId;

        fetch(url, {method: 'DELETE'})
            .then(function (response) { return response.json(); })
            .then(function (data) {
                const modalEl = document.getElementById('folderDeleteModal');
                const modal = bootstrap.Modal.getOrCreateInstance(modalEl);
                modal.hide();

                if (data.success) {
                    showAlert('success', '文件夹删除成功！');
                    loadFolders();
                } else {
                    showAlert('danger', data.message || '文件夹删除失败');
                }
            })
            .catch(function () {
                showAlert('danger', '请求失败，请稍后重试。');
            })
            .finally(function () {
                deleteFolderId = null;
            });
    }

    function renderFolders(folders) {
        const container = document.getElementById('folder-list-container');
        const emptyState = document.getElementById('empty-state-container');

        if (!folders || folders.length === 0) {
            container.innerHTML = '';
            emptyState.style.display = 'block';
            return;
        }

        emptyState.style.display = 'none';

        const html = folders.map(function (folder) {
            const isDefault = folder.name === '未分类';
            const folderColor = isDefault ? '#ffc107' : '#4e73df';
            const safeName = escapeHtml(folder.name);

            let actionButtons =
                '<a href="<c:url value="/questionnaire/list"/>' + '?folderId=' + folder.id + '" class="action-btn">' +
                '<i class="bi bi-eye"></i> 查看问卷' +
                '</a>';

            if (!isDefault) {
                actionButtons +=
                    '<button type="button" class="action-btn" ' +
                    'data-folder-id="' + folder.id + '" ' +
                    'data-folder-name="' + safeName + '" ' +
                    'onclick="openEditFolderModal(this.getAttribute(\'data-folder-id\'), this.getAttribute(\'data-folder-name\'))">' +
                    '<i class="bi bi-pencil"></i> 重命名' +
                    '</button>' +
                    '<button type="button" class="action-btn danger" ' +
                    'data-folder-id="' + folder.id + '" ' +
                    'data-folder-name="' + safeName + '" ' +
                    'onclick="openDeleteFolderModal(this.getAttribute(\'data-folder-id\'), this.getAttribute(\'data-folder-name\'))">' +
                    '<i class="bi bi-trash"></i> 删除' +
                    '</button>';
            }

            return '' +
                '<div class="folder-card" style="border-left-color: ' + folderColor + ';">' +
                '<div class="folder-header">' +
                '<div>' +
                '<h3 class="folder-title">' +
                '<i class="bi bi-folder2" style="color: ' + folderColor + ';"></i>' +
                safeName +
                '</h3>' +
                (isDefault
                    ? '<div class="folder-sub"><i class="bi bi-info-circle me-1"></i>系统默认文件夹，所有未分类问卷将自动归入此处</div>'
                    : '') +
                '</div>' +
                '<div class="folder-actions">' + actionButtons + '</div>' +
                '</div>' +
                '<div class="folder-stats">' +
                '<div class="stat-item">' +
                '<i class="bi bi-file-earmark-text"></i>' +
                '<span>问卷数量：<span class="stat-value">' + (folder.questionnaireCount || 0) + '</span></span>' +
                '</div>' +
                '<div class="stat-item">' +
                '<i class="bi bi-calendar3"></i>' +
                '<span>创建时间：' + formatDate(folder.createTime) + '</span>' +
                '</div>' +
                '</div>' +
                '</div>';
        }).join('');

        container.innerHTML = html;
    }
</script>
</body>
</html>
