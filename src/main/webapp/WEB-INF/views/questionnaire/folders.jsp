<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>文件夹管理 - 问卷星</title>
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
        .main-container {
            display: flex;
            min-height: 100vh;
        }
        .sidebar {
            width: var(--sidebar-width);
            background: white;
            border-right: 1px solid var(--border-color);
            padding: 1.5rem 0;
            box-shadow: 2px 0 5px rgba(0,0,0,0.05);
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
        .sidebar-menu-link:hover { background-color: #f8f9fc; color: rgba(var(--bs-primary-rgb), 1); }
        .sidebar-menu-link.active {
            background-color: rgba(var(--bs-primary-rgb), 0.1);
            color: rgba(var(--bs-primary-rgb), 1);
            border-left-color: rgba(var(--bs-primary-rgb), 1);
        }
        .sidebar-menu-link i { margin-right: 0.75rem; font-size: 1.1rem; width: 20px; text-align: center; }
        .content-area { flex: 1; padding: 2rem; }
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
        .page-title { font-size: 1.75rem; font-weight: 600; color: #2c3e50; margin: 0; }
        .create-btn {
            background: linear-gradient(135deg, rgba(var(--bs-primary-rgb), 1), rgba(var(--bs-primary-rgb), 0.8));
            border: none; padding: 0.75rem 1.5rem; font-weight: 500; border-radius: 8px; transition: all 0.3s ease;
        }
        .create-btn:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(var(--bs-primary-rgb), 0.3); }
        .folder-card {
            background: white; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 1rem; padding: 1.5rem 2rem; transition: all 0.3s ease; border-left: 4px solid transparent;
        }
        .folder-card:hover { transform: translateY(-2px); box-shadow: 0 5px 20px rgba(0,0,0,0.1); }
        .folder-header { display: flex; justify-content: space-between; align-items: center; }
        .folder-title { font-size: 1.2rem; font-weight: 600; color: #2c3e50; margin: 0; display: flex; align-items: center; gap: 0.5rem; }
        .folder-stats { display: flex; gap: 2rem; margin: 1rem 0; }
        .stat-item { display: flex; align-items: center; gap: 0.5rem; color: #6c757d; }
        .stat-value { font-weight: 600; color: rgba(var(--bs-primary-rgb), 1); }
        .folder-actions { display: flex; gap: 0.5rem; }
        .action-btn {
            padding: 0.5rem 1rem; border: 1px solid var(--border-color); background: white; color: var(--bs-body-color);
            text-decoration: none; border-radius: 6px; font-size: 0.9rem; transition: all 0.3s ease;
            display: flex; align-items: center; gap: 0.25rem;
        }
        .action-btn:hover { background-color: #f8f9fc; color: rgba(var(--bs-primary-rgb), 1); border-color: rgba(var(--bs-primary-rgb), 1); }
        .action-btn.danger { color: #dc3545; border-color: #dc3545; }
        .action-btn.danger:hover { background-color: #dc3545; color: white; }
        .empty-state {
            background: white; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            padding: 4rem 2rem; text-align: center; color: #6c757d;
        }
        .empty-state .icon { font-size: 4rem; color: #dee2e6; margin-bottom: 1rem; }
        #alert-container { position: fixed; top: 80px; right: 20px; z-index: 1055; width: 350px; }
    </style>
</head>
<body>
    <div id="alert-container"></div>
    <div class="main-container">
        <!-- Left Sidebar -->
        <div class="sidebar">
            <h4 class="px-4 pt-3 pb-2"><a href="<c:url value='/home'/>" class="text-decoration-none text-dark">问卷管理系统</a></h4>
            <ul class="sidebar-menu mt-3">
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
                    <a href="<c:url value='/questionnaire/folders'/>" class="sidebar-menu-link active">
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

        <!-- Content Area -->
        <div class="content-area">
            <div class="page-header">
                <h1 class="page-title">文件夹管理</h1>
                <button class="btn btn-primary create-btn" onclick="createFolder()">
                    <i class="bi bi-plus-lg"></i> 新建文件夹
                </button>
            </div>

            <div id="folder-list-container">
                <!-- Folders will be dynamically rendered here -->
            </div>
            
            <div id="empty-state-container" class="empty-state" style="display: none;">
                <div class="icon"><i class="bi bi-folder2"></i></div>
                <h4>暂无文件夹</h4>
                <p class="text-muted">点击上方的"新建文件夹"按钮创建您的第一个文件夹</p>
            </div>
        </div>
    </div>

    <script src="<c:url value='/resources/js/bootstrap/bootstrap.bundle.min.js'/>"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            loadFolders();
        });

        // --- Helper Functions ---
        function showAlert(type, message, duration = 3000) {
            const alertContainer = document.getElementById('alert-container');
            const alertId = 'alert-' + Date.now();
            const alert = `
                <div id="${alertId}" class="alert alert-${type} alert-dismissible fade show" role="alert">
                    ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            `;
            alertContainer.insertAdjacentHTML('beforeend', alert);
            
            setTimeout(() => {
                const alertElement = document.getElementById(alertId);
                if (alertElement) {
                    bootstrap.Alert.getOrCreateInstance(alertElement).close();
                }
            }, duration);
        }

        function formatDate(dateString) {
            if (!dateString) return 'N/A';
            const date = new Date(dateString);
            return date.toLocaleDateString('zh-CN') + ' ' + date.toLocaleTimeString('zh-CN', { hour: '2-digit', minute: '2-digit' });
        }

        function escapeHtml(text) {
            if (text === null || typeof text === 'undefined') return '';
            return text.toString()
                .replace(/&/g, '&amp;')
                .replace(/</g, '&lt;')
                .replace(/>/g, '&gt;')
                .replace(/"/g, '&quot;')
                .replace(/'/g, '&#039;');
        }

        // --- API Call Functions ---
        function loadFolders() {
            fetch('/folder/api/list')
                .then(response => {
                    if (!response.ok) throw new Error('Network response was not ok');
                    return response.json();
                })
                .then(data => {
                    if (data.success) {
                        renderFolders(data.folders);
                    } else {
                        showAlert('danger', '加载文件夹失败：' + data.message);
                    }
                })
                .catch(error => {
                    console.error('加载文件夹失败:', error);
                    showAlert('danger', '加载文件夹失败，请检查网络或联系管理员。');
                });
        }

        function createFolder() {
            const folderName = prompt('请输入新文件夹的名称：');
            if (folderName && folderName.trim()) {
                fetch('/folder/api/create', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify({ name: folderName.trim() })
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        showAlert('success', '文件夹创建成功！');
                        loadFolders();
                    } else {
                        showAlert('danger', '创建失败：' + data.message);
                    }
                })
                .catch(error => {
                    console.error('创建文件夹失败:', error);
                    showAlert('danger', '请求失败，请稍后重试。');
                });
            }
        }

        function editFolder(folderId, currentName) {
            const newName = prompt('请输入新的文件夹名称：', currentName);
            if (newName && newName.trim() && newName.trim() !== currentName) {
                fetch(`/folder/api/update/${folderId}`, {
                    method: 'PUT',
                    headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify({ name: newName.trim() })
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        showAlert('success', '文件夹重命名成功！');
                        loadFolders();
                    } else {
                        showAlert('danger', '重命名失败：' + data.message);
                    }
                })
                .catch(error => {
                    console.error('重命名文件夹失败:', error);
                    showAlert('danger', '请求失败，请稍后重试。');
                });
            }
        }

        function deleteFolder(folderId) {
            if (confirm('确定要删除这个文件夹吗？\n文件夹内的所有问卷将被移动到您的根目录，此操作不可撤销。')) {
                fetch(`/folder/api/delete/${folderId}`, {
                    method: 'DELETE'
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        showAlert('success', '文件夹删除成功！');
                        loadFolders();
                    } else {
                        showAlert('danger', '删除失败：' + data.message);
                    }
                })
                .catch(error => {
                    console.error('删除文件夹失败:', error);
                    showAlert('danger', '请求失败，请稍后重试。');
                });
            }
        }

        // --- Rendering Function ---
        function renderFolders(folders) {
            const container = document.getElementById('folder-list-container');
            const emptyState = document.getElementById('empty-state-container');
            
            if (!folders || folders.length === 0) {
                container.innerHTML = '';
                emptyState.style.display = 'block';
                return;
            }
            
            emptyState.style.display = 'none';
            
            const html = folders.map((folder, index) => {
                const isDefault = folder.name === '未分类';
                let deleteBtn = '';
                if (!isDefault) {
                    deleteBtn = '<button class="action-btn danger" onclick="deleteFolder(' + folder.id + ')">
                                    <i class="bi bi-trash"></i> 删除
                                </button>';
                }
                
                return (
                    '<div class="folder-card">
                        <div class="folder-header">
                            <h3 class="folder-title">
                                <i class="bi bi-folder2" style="color: ' + (isDefault ? '#ffc107' : '#4e73df') + '"></i> 
                                ' + escapeHtml(folder.name) + '
                            </h3>
                            <div class="folder-actions">
                                <a href="/questionnaire/list?folderId=' + folder.id + '" class="action-btn">
                                    <i class="bi bi-eye"></i> 查看问卷
                                </a>
                                <button class="action-btn" onclick="editFolder(' + folder.id + ', \'' + escapeHtml(folder.name) + '\')">
                                    <i class="bi bi-pencil"></i> 重命名
                                </button>' + 
                                deleteBtn + '
                            ' + 
                        '</div>
                        <div class="folder-stats">
                            <div class="stat-item">
                                <i class="bi bi-file-text"></i>
                                '<span>问卷数量：<span class="stat-value">' + (folder.questionnaireCount || 0) + '</span></span>'
                            '</div>
                            <div class="stat-item">
                                <i class="bi bi-calendar3"></i>
                                '<span>创建时间：' + formatDate(folder.createTime) + '</span>'
                            '</div>
                        '</div>
                    '</div>'
                );
            }).join('');
            
            container.innerHTML = html;
        }
    </script>
</body>
</html>