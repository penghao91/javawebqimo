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
        /* --- 顶部导航栏统一修复 --- */
        .navbar {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(16px);
            box-shadow: 0 8px 24px rgba(15, 23, 42, 0.08);
            transition: all 0.3s ease;
            height: 76px;            /* 固定高度，防止抖动 */
            padding: 0;
        }
        .navbar > .container {
            height: 100%;
            display: flex;
            align-items: center;
        }
        .navbar.scrolled {
            /* 不再调整 padding，仅调整背景和阴影，避免高度变化 */
            background: rgba(255, 255, 255, 0.98);
            box-shadow: 0 10px 30px rgba(15, 23, 42, 0.14);
        }
        .navbar-brand {
            font-weight: 800;
            font-size: 1.45rem;
            color: var(--primary-color) !important;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            height: 100%;
            padding: 0;
            margin-right: 2rem;
        }
        .navbar-brand i {
            font-size: 1.4rem;
            color: var(--primary-dark);
            transform: translateY(-1px);
        }
        .navbar-nav .nav-link {
            font-weight: 600;
            color: var(--secondary-color) !important;
            padding: 0.5rem 1rem !important;
            transition: color 0.2s ease, transform 0.2s ease;
            position: relative;
        }
        .navbar-nav .nav-link:hover {
            color: var(--primary-color) !important;
            transform: translateY(-1px);
        }
        .user-dropdown-btn {
            text-decoration: none;
            font-weight: 500;
            color: var(--secondary-color) !important;
        }
        .user-dropdown-btn i { color: var(--primary-color); }
        .user-dropdown-btn:hover { color: var(--primary-color) !important; }

        /* 页面整体内边距（统一一处定义） */
        .page-wrapper {
            padding-top: 96px; /* 76px 导航 + 20px 间距 */
            padding-bottom: 40px;
        }

        /* --- 头部区域 --- */
        .design-header {
            margin-bottom: 24px;
        }
        .design-header-inner {
            background: linear-gradient(135deg, #4f46e5 0, #1d4ed8 40%, #2563eb 100%);
            border-radius: 20px;
            padding: 24px 28px;
            color: #fff;
            box-shadow: 0 14px 36px rgba(37, 99, 235, 0.35);
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 1rem;
            min-height: 136px;
            box-sizing: border-box;
        }
        .design-header-title {
            margin: 0;
            font-size: 1.5rem;
            font-weight: 700;
            line-height: 1.3;
        }
        .design-header-subtitle {
            margin: 0.35rem 0 0;
            font-size: 0.96rem;
            opacity: 0.9;
            line-height: 1.5;
        }
        .design-header-meta {
            font-size: 0.85rem;
            opacity: 0.85;
            margin-top: 0.25rem;
        }

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

        /* 草稿题目高亮 */
        .question-card.draft {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 1px rgba(78,115,223,0.18);
        }
        .draft-options-list .input-group { margin-bottom: .4rem; }
        .draft-options-list .form-control { font-size: .85rem; }
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
                <!-- 左侧：题型选择 + 隐藏表单 -->
                <div class="col-lg-4">
                    <div class="add-question-card position-sticky" style="top: 100px;">
                        <div class="add-question-header">
                            <i class="bi bi-plus-circle-dotted"></i><span>添加新问题</span>
                        </div>
                        <div class="mb-3">
                            <p class="small text-muted mb-2">选择题型后，右侧会新增一个可编辑的问题模块，可连续添加。</p>
                            <button type="button" class="btn btn-outline-primary w-100 mb-2"
                                    onclick="createDraftQuestion('1')">
                                <i class="bi bi-record-circle me-1"></i> 单选题
                            </button>
                            <button type="button" class="btn btn-outline-primary w-100 mb-2"
                                    onclick="createDraftQuestion('2')">
                                <i class="bi bi-check2-square me-1"></i> 多选题
                            </button>
                            <button type="button" class="btn btn-outline-primary w-100 mb-2"
                                    onclick="createDraftQuestion('4')">
                                <i class="bi bi-input-cursor-text me-1"></i> 单项填空
                            </button>
                            <button type="button" class="btn btn-outline-primary w-100 mb-2"
                                    onclick="createDraftQuestion('5')">
                                <i class="bi bi-list-check me-1"></i> 多项填空
                            </button>
                            <button type="button" class="btn btn-outline-secondary w-100"
                                    onclick="createDraftQuestion('3')">
                                <i class="bi bi-card-text me-1"></i> 简答题
                            </button>
                        </div>

                        <!-- 隐藏的真实提交表单：仍然走你原来的 /question/add -->
                        <form id="hiddenQuestionForm" action="<c:url value='/question/add'/>" method="post" style="display:none;">
                            <input type="hidden" name="questionnaireId" value="${questionnaire.id}"/>
                            <textarea id="questionText" name="questionText"></textarea>
                            <select id="questionType" name="questionType">
                                <option value="1">单选题</option>
                                <option value="2">多选题</option>
                                <option value="3">简答题</option>
                                <option value="4">单项填空</option>
                                <option value="5">多项填空</option>
                            </select>
                            <textarea id="options" name="options"></textarea>
                            <input type="checkbox" id="isRequired" name="isRequired" value="1" checked>
                        </form>
                    </div>
                </div>

                <!-- 右侧：问题列表 + 草稿编辑模块 -->
                <div class="col-lg-8">
                    <div class="questions-card">
                        <div class="questions-header">
                            <div class="questions-header-title">
                                <i class="bi bi-list-ul"></i><span>问题列表</span>
                            </div>
                            <div class="questions-header-meta">
                                <c:choose>
                                    <c:when test="${not empty questions}">共 ${fn:length(questions)} 题</c:when>
                                    <c:otherwise>暂无题目</c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <hr class="mt-2 mb-3"/>

                        <div id="questionList">
                            <c:choose>
                                <c:when test="${not empty questions}">
                                    <c:forEach items="${questions}" var="question" varStatus="status">
                                        <div class="question-card">
                                            <div class="d-flex justify-content-between align-items-start">
                                                <div class="pe-3">
                                                    <div class="question-title">${status.count}. ${question.questionText}</div>
                                                    <div class="question-badges mt-1">
                                                        <span class="badge bg-info text-dark me-1">${question.typeDesc}</span>
                                                        <c:if test="${question.isRequired == 1}">
                                                            <span class="badge bg-danger">必填</span>
                                                        </c:if>
                                                    </div>
                                                </div>
                                                <div class="question-actions">
                                                    <a href="javascript:void(0);"
                                                       class="btn btn-sm btn-outline-danger"
                                                       onclick="openDeleteConfirm('<c:url value='/question/delete/${question.id}'/>')"
                                                       title="删除">
                                                        <i class="bi bi-trash"></i>
                                                    </a>
                                                </div>
                                            </div>

                                            <!-- 选项 / 填空项预览：简答题(3) 和 单项填空(4) 不显示 -->
                                            <c:if test="${question.questionType != 3 && question.questionType != 4 && not empty question.options}">
                                                <hr class="my-2">
                                                <div class="question-options d-flex flex-wrap gap-2">
                                                    <c:forEach items="${question.options}" var="option">
                                                        <span class="badge bg-light text-dark border">
                                                                ${option.optionText}
                                                        </span>
                                                    </c:forEach>
                                                </div>
                                            </c:if>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="empty-state" id="emptyState">
                                        <i class="bi bi-question-circle"></i>
                                        <p class="mt-3 mb-1 fs-5">暂无问题</p>
                                        <p class="mb-0 small text-muted">请在左侧选择题型来添加问题。</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>

<!-- 美化后的提示模态框 -->
<div class="modal fade" id="alertModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header border-0">
                <h5 class="modal-title"><i class="bi bi-info-circle text-primary me-2"></i>提示</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="关闭"></button>
            </div>
            <div class="modal-body">
                <p id="alertModalMessage" class="mb-0"></p>
            </div>
            <div class="modal-footer border-0">
                <button type="button" class="btn btn-primary btn-sm" data-bs-dismiss="modal">我知道了</button>
            </div>
        </div>
    </div>
</div>

<!-- 美化后的确认删除模态框 -->
<div class="modal fade" id="confirmModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header border-0">
                <h5 class="modal-title"><i class="bi bi-exclamation-triangle text-danger me-2"></i>确认删除</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="关闭"></button>
            </div>
            <div class="modal-body">
                <p class="mb-0">确定要删除此问题吗？此操作不可撤销。</p>
            </div>
            <div class="modal-footer border-0">
                <button type="button" class="btn btn-outline-secondary btn-sm" data-bs-dismiss="modal">取消</button>
                <button type="button" class="btn btn-danger btn-sm" onclick="handleDeleteConfirm()">确认删除</button>
            </div>
        </div>
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

    // ===== 全局弹窗封装（替代 alert/confirm） =====
    function showNiceAlert(message) {
        const modalEl = document.getElementById('alertModal');
        if (!modalEl) {
            window.alert(message);
            return;
        }
        const msgEl = document.getElementById('alertModalMessage');
        if (msgEl) msgEl.textContent = message;
        const modal = bootstrap.Modal.getOrCreateInstance(modalEl);
        modal.show();
    }

    let pendingDeleteUrl = null;
    function openDeleteConfirm(url) {
        pendingDeleteUrl = url;
        const modalEl = document.getElementById('confirmModal');
        if (!modalEl) {
            if (window.confirm('确定要删除此问题吗？')) {
                window.location.href = url;
            }
            return;
        }
        const modal = bootstrap.Modal.getOrCreateInstance(modalEl);
        modal.show();
    }
    function handleDeleteConfirm() {
        if (pendingDeleteUrl) {
            window.location.href = pendingDeleteUrl;
        }
    }

    // ====== 问卷星式编辑逻辑，支持多草稿 ======
    function createDraftQuestion(type) {
        const list = document.getElementById('questionList');
        if (!list) return;

        // 移除空状态
        const empty = document.getElementById('emptyState');
        if (empty) empty.remove();

        const card = document.createElement('div');
        card.className = 'question-card draft';

        card.innerHTML = '' +
            '<form onsubmit="return submitDraftQuestion(this);">' +
            '  <div class="d-flex justify-content-between align-items-start mb-2">' +
            '    <div class="flex-grow-1 pe-2">' +
            '      <div class="mb-2">' +
            '        <label class="form-label small mb-1">题目内容 <span class="text-danger">*</span></label>' +
            '        <textarea class="form-control" name="draftQuestionText" rows="2" placeholder="请输入问题内容"></textarea>' +
            '      </div>' +
            '      <div class="mb-2 draft-options-area">' +
            '        <label class="form-label small mb-1">选项 / 填空项（点击即可修改文字）</label>' +
            '        <div class="draft-options-list">' +
            '          <div class="input-group input-group-sm">' +
            '            <span class="input-group-text">项1</span>' +
            '            <input type="text" class="form-control draft-option-input" value="选项1">' +
            '            <button class="btn btn-outline-secondary" type="button" onclick="removeDraftOption(this)"><i class="bi bi-x"></i></button>' +
            '          </div>' +
            '          <div class="input-group input-group-sm">' +
            '            <span class="input-group-text">项2</span>' +
            '            <input type="text" class="form-control draft-option-input" value="选项2">' +
            '            <button class="btn btn-outline-secondary" type="button" onclick="removeDraftOption(this)"><i class="bi bi-x"></i></button>' +
            '          </div>' +
            '        </div>' +
            '        <button type="button" class="btn btn-link btn-sm px-0 mt-1" onclick="addDraftOption(this)">+ 添加项</button>' +
            '      </div>' +
            '    </div>' +
            '    <button type="button" class="btn-close ms-2" aria-label="关闭" onclick="cancelDraftQuestion(this)"></button>' +
            '  </div>' +
            '  <div class="d-flex justify-content-between align-items-center mt-2">' +
            '    <div class="d-flex align-items-center gap-3">' +
            '      <div class="form-check mb-0">' +
            '        <input class="form-check-input" type="checkbox" name="draftIsRequired" checked>' +
            '        <label class="form-check-label small">必答</label>' +
            '      </div>' +
            '      <div class="d-flex align-items-center gap-1">' +
            '        <span class="small text-muted">题型</span>' +
            '        <select name="draftQuestionType" class="form-select form-select-sm w-auto" onchange="handleDraftTypeChange(this)">' +
            '          <option value="1">单选题</option>' +
            '          <option value="2">多选题</option>' +
            '          <option value="3">简答题</option>' +
            '          <option value="4">单项填空</option>' +
            '          <option value="5">多项填空</option>' +
            '        </select>' +
            '      </div>' +
            '    </div>' +
            '    <div>' +
            '      <button type="submit" class="btn btn-primary btn-sm">完成编辑</button>' +
            '    </div>' +
            '  </div>' +
            '</form>';

        list.appendChild(card);

        const select = card.querySelector('select[name="draftQuestionType"]');
        if (select) {
            select.value = type;
            handleDraftTypeChange(select);
        }

        const textarea = card.querySelector('textarea[name="draftQuestionText"]');
        if (textarea) textarea.focus();

        // 不再滚动，以减少“抖动”感
    }

    // 根据题型控制选项区域显示
    function handleDraftTypeChange(select) {
        const form = select.closest('form');
        if (!form) return;
        const optionsArea = form.querySelector('.draft-options-area');
        if (!optionsArea) return;

        const type = select.value;
        // 简答题(3) & 单项填空(4) 不需要选项区域
        if (type === '3' || type === '4') {
            optionsArea.style.display = 'none';
        } else {
            optionsArea.style.display = 'block';
        }
    }

    function addDraftOption(btn) {
        const optionsList = btn.closest('.draft-options-area').querySelector('.draft-options-list');
        if (!optionsList) return;
        const index = optionsList.querySelectorAll('.input-group').length + 1;

        const wrapper = document.createElement('div');
        wrapper.className = 'input-group input-group-sm';
        wrapper.innerHTML =
            '<span class="input-group-text">项' + index + '</span>' +
            '<input type="text" class="form-control draft-option-input" value="选项' + index + '">' +
            '<button class="btn btn-outline-secondary" type="button" onclick="removeDraftOption(this)"><i class="bi bi-x"></i></button>';

        optionsList.appendChild(wrapper);
    }

    function removeDraftOption(btn) {
        const group = btn.closest('.input-group');
        const list = btn.closest('.draft-options-list');
        if (group && list) {
            group.remove();
            const groups = list.querySelectorAll('.input-group');
            groups.forEach(function (g, idx) {
                const span = g.querySelector('.input-group-text');
                if (span) span.textContent = '项' + (idx + 1);
            });
        }
    }

    function cancelDraftQuestion(btn) {
        const card = btn.closest('.question-card.draft');
        if (card) card.remove();
    }

    function submitDraftQuestion(form) {
        const questionText = form.querySelector('textarea[name="draftQuestionText"]').value.trim();
        const typeSelect = form.querySelector('select[name="draftQuestionType"]');
        const type = typeSelect ? typeSelect.value : '1';
        const requiredChecked = form.querySelector('input[name="draftIsRequired"]').checked;

        if (!questionText) {
            showNiceAlert('请填写题目内容');
            return false;
        }

        let optionsText = '';
        // 单选、多选、多项填空需要“项”
        if (type === '1' || type === '2' || type === '5') {
            const optionInputs = form.querySelectorAll('.draft-option-input');
            const arr = [];
            optionInputs.forEach(function (input) {
                const v = input.value.trim();
                if (v) arr.push(v);
            });
            if (arr.length < 2) {
                showNiceAlert('请至少填写两个选项 / 填空项');
                return false;
            }
            optionsText = arr.join('\n'); // 与原来“每行一个”格式兼容
        }

        const hiddenForm = document.getElementById('hiddenQuestionForm');
        if (!hiddenForm) return false;

        hiddenForm.querySelector('#questionText').value = questionText;
        hiddenForm.querySelector('#questionType').value = type;
        hiddenForm.querySelector('#options').value = optionsText;

        const requiredInput = hiddenForm.querySelector('#isRequired');
        requiredInput.checked = requiredChecked;

        hiddenForm.submit();
        return false;
    }
</script>
</body>
</html>
