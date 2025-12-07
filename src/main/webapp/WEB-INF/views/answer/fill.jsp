<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${questionnaire.title} - 问卷填写</title>

    <link href="<c:url value='/resources/css/bootstrap/bootstrap.min.css'/>" rel="stylesheet">
    <link href="<c:url value='/resources/css/bootstrap-icons/bootstrap-icons.css'/>" rel="stylesheet">

    <style>
        /* --- 全局变量 (源自你的系统风格) --- */
        :root {
            --primary-color: #4e73df;
            --primary-dark: #224abe;
            --secondary-color: #858796;
            --success-color: #1cc88a;
            --danger-color: #e74a3b;
            --bg-gradient: radial-gradient(circle at top left, #f0f4ff 0, #f8f9fc 45%, #fdfdfd 100%);
            --card-shadow: 0 12px 40px rgba(15, 23, 42, 0.08);
            --border-soft: #e1e5f2;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, "Helvetica Neue", Arial, sans-serif;
            background: var(--bg-gradient);
            color: #4b4d63;
            line-height: 1.6;
            min-height: 100vh;
            margin: 0;
            padding-bottom: 80px;
        }

        /* --- 顶部进度条 (吸顶) --- */
        .progress-fixed {
            position: fixed; top: 0; left: 0; width: 100%; height: 4px; z-index: 1050; background: transparent;
        }
        .progress-bar-fill {
            height: 100%; background: linear-gradient(90deg, var(--success-color), var(--primary-color));
            width: 0%; transition: width 0.4s ease; box-shadow: 0 1px 3px rgba(78, 115, 223, 0.3);
        }

        /* --- 简易导航栏 --- */
        .navbar-simple {
            padding: 1.2rem 0; text-align: center; margin-bottom: 1rem;
        }
        .brand-logo {
            font-weight: 800; font-size: 1.5rem; color: var(--primary-color);
            display: inline-flex; align-items: center; gap: 0.5rem; text-decoration: none;
        }

        /* --- 问卷卡片 (核心容器) --- */
        .survey-container {
            max-width: 800px;
            margin: 0 auto;
            background: #fff;
            border-radius: 20px;
            box-shadow: var(--card-shadow);
            overflow: hidden;
            border: 1px solid rgba(255,255,255,0.8);
            position: relative;
        }

        /* 问卷头部 (蓝色渐变背景，呼应后台风格) */
        .survey-header {
            background: linear-gradient(135deg, #4f46e5 0, #1d4ed8 40%, #2563eb 100%);
            padding: 3.5rem 3rem;
            color: #fff;
            position: relative;
        }
        .survey-header::after {
            content: ''; position: absolute; top: -60%; right: -10%;
            width: 300px; height: 300px; background: rgba(255,255,255,0.1);
            border-radius: 50%; pointer-events: none;
        }
        .survey-title { font-size: 1.8rem; font-weight: 700; margin: 0 0 0.8rem 0; position: relative; z-index: 1; }
        .survey-desc { font-size: 1rem; opacity: 0.9; white-space: pre-wrap; position: relative; z-index: 1; }

        /* 问卷主体 */
        .survey-body { padding: 3rem; }

        /* --- 题目样式 --- */
        .question-item { margin-bottom: 2.5rem; animation: fadeIn 0.5s ease; }

        .q-title {
            font-size: 1.1rem; font-weight: 600; color: #2c3e50; margin-bottom: 1rem;
            display: flex; align-items: flex-start; line-height: 1.5;
        }
        .q-index { color: var(--primary-color); font-weight: 800; margin-right: 8px; min-width: 25px; }
        .q-req { color: var(--danger-color); margin-left: 4px; vertical-align: middle; }
        .q-type {
            font-size: 0.75rem; background: #eff6ff; color: var(--primary-color);
            padding: 2px 8px; border-radius: 4px; margin-left: 8px; font-weight: normal; vertical-align: middle;
        }

        /* 选项样式 (整行点击，悬停效果) */
        .option-group { display: flex; flex-direction: column; gap: 0.8rem; }

        .option-label {
            display: flex; align-items: center; padding: 0.8rem 1.2rem;
            border: 1px solid var(--border-soft); border-radius: 12px;
            cursor: pointer; transition: all 0.2s ease; background: #fff;
        }
        .option-label:hover {
            border-color: #cbd5e1; background-color: #f8f9fc; transform: translateX(4px);
        }
        /* 选中态高亮 */
        .option-label.active {
            border-color: var(--primary-color); background-color: #eff6ff;
            color: var(--primary-dark); font-weight: 500;
        }

        .form-check-input {
            width: 1.2em; height: 1.2em; margin-top: 0; margin-right: 1rem;
            cursor: pointer; flex-shrink: 0;
        }

        /* 文本域 */
        .form-control-area {
            width: 100%; padding: 1rem; border-radius: 12px; border: 1px solid var(--border-soft);
            background: #fcfcfd; resize: vertical; transition: all 0.2s;
        }
        .form-control-area:focus {
            background: #fff; border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(78, 115, 223, 0.15); outline: none;
        }

        /* --- 底部提交区 --- */
        .submit-area { text-align: center; margin-top: 3rem; }
        .btn-submit {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            border: none; padding: 0.8rem 4rem; font-size: 1.1rem; font-weight: 600;
            border-radius: 999px; color: #fff; box-shadow: 0 10px 25px rgba(78, 115, 223, 0.35);
            transition: all 0.2s;
        }
        .btn-submit:hover { transform: translateY(-2px); box-shadow: 0 15px 30px rgba(78, 115, 223, 0.45); color: #fff; }
        .btn-submit:active { transform: translateY(0); }
        .btn-submit:disabled { opacity: 0.7; cursor: not-allowed; transform: none; }

        /* --- 预览模式横幅 --- */
        .preview-banner {
            background: #fff3cd; color: #856404; padding: 0.8rem; text-align: center;
            border-bottom: 1px solid #ffeeba; margin-bottom: 1rem; font-size: 0.9rem;
        }

        /* 移动端适配 */
        @media (max-width: 576px) {
            .survey-container { border-radius: 0; box-shadow: none; margin: 0; min-height: 100vh; }
            .survey-header { padding: 2.5rem 1.5rem; }
            .survey-body { padding: 2rem 1.5rem; }
        }

        /* 预览弹窗样式 */
        .preview-modal-content {
            border-radius: 14px;
            box-shadow: var(--card-shadow);
            border: none;
        }

        .preview-modal-body {
            padding: 2rem 2.5rem;
            font-size: 1rem;
            color: #4b4d63;
        }

        .preview-modal-body p {
            margin-bottom: 1.5rem;
        }

        .preview-modal-close {
            position: absolute;
            right: 1rem;
            top: 0.8rem;
            border: none;
            background: transparent;
            font-size: 1.2rem;
            opacity: .5;
        }

        .preview-modal-close:hover {
            opacity: .9;
        }

        /* 调整遮罩透明度，接近问卷星那种灰蒙效果 */
        .modal-backdrop.show {
            opacity: .35;
        }

        /* 顶部预览工具条（手机 / 电脑 / 关闭） */
        .preview-toolbar {
            background: #ffffff;
            border-bottom: 1px solid #e5e7eb;
            box-shadow: 0 1px 3px rgba(15,23,42,0.04);
            padding: 0.5rem 0;
            margin-bottom: 0.5rem;
        }
        .preview-tabs {
            display: flex;
            justify-content: center;
            gap: 0.3rem;
        }
        .preview-tab {
            border: none;
            background: transparent;
            padding: 0.4rem 1.4rem;
            border-radius: 999px;
            font-size: 0.9rem;
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
            cursor: pointer;
            color: #6b7280;
        }
        .preview-tab i {
            font-size: 1rem;
        }
        .preview-tab.active {
            background: #eef2ff;
            color: var(--primary-dark);
            box-shadow: 0 1px 2px rgba(79,70,229,0.23);
        }
        .preview-tab.preview-close {
            color: #dc2626;
        }
        .preview-tab.preview-close.active {
            background: #fee2e2;
            box-shadow: none;
        }

        /* 预览模式：手机端效果（中间竖着一台手机） */
        .preview-mode.preview-mobile .survey-container {
            max-width: 420px;
            margin: 1.5rem auto;
            border-radius: 24px;
        }

        /* 预览模式：电脑端效果（宽一点，接近整页） */
        .preview-mode.preview-desktop .survey-container {
            max-width: 1000px;
            margin: 1.5rem auto;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(15,23,42,0.12);
        }

        /* 根据模式微调背景，让感觉更像截图 */
        .preview-mode.preview-mobile {
            background: radial-gradient(circle at top left, #f0f4ff 0, #f8f9fc 45%, #fdfdfd 100%);
        }
        .preview-mode.preview-desktop {
            background: #f5f7fb;
        }
    </style>
</head>
<body class="${param.preview eq 'true' ? 'preview-mode preview-mobile' : ''}">

<div class="progress-fixed">
    <div class="progress-bar-fill" id="progressBar"></div>
</div>

<c:if test="${param.preview == 'true'}">
    <div class="preview-banner">
        <i class="bi bi-exclamation-triangle-fill me-1"></i>
        当前为 <strong>预览模式</strong>，作答数据不会被保存。
        <a href="javascript:history.back()" class="ms-3 text-decoration-underline" style="color: inherit;">返回编辑</a>
    </div>

    <!-- 手机 / 电脑 / 关闭 预览工具条 -->
    <div class="preview-toolbar">
        <div class="preview-tabs">
            <button type="button"
                    class="preview-tab active"
                    data-mode="mobile">
                <i class="bi bi-phone"></i> 手机预览
            </button>
            <button type="button"
                    class="preview-tab"
                    data-mode="desktop">
                <i class="bi bi-display"></i> 电脑预览
            </button>
            <button type="button"
                    class="preview-tab preview-close"
                    onclick="closePreview()">
                <i class="bi bi-x-lg"></i> 关闭预览
            </button>
        </div>
    </div>
</c:if>

<div class="navbar-simple">
    <a href="/" class="brand-logo">
        <i class="bi bi-card-checklist"></i> 问卷星
    </a>
</div>

<div class="survey-container">

    <form id="questionnaireForm" action="<c:url value='/answer/submit/${questionnaire.id}'/>" method="post">

        <div class="survey-header">
            <h1 class="survey-title">${questionnaire.title}</h1>
            <div class="survey-desc">${not empty questionnaire.description ? questionnaire.description : '感谢您能抽出几分钟时间来参加本次答题。'}</div>
        </div>

        <div class="survey-body">
            <c:choose>
                <c:when test="${not empty questions}">
                    <c:forEach items="${questions}" var="q" varStatus="status">

                        <div class="question-item" id="q_${q.id}" data-id="${q.id}" data-type="${q.questionType}">

                            <div class="q-title">
                                <span class="q-index">${status.index + 1}.</span>
                                <span>${q.questionText}</span>
                                <c:if test="${q.isRequired == 1}">
                                    <span class="q-req">*</span>
                                </c:if>
                                <span class="q-type">${q.typeDesc}</span>
                            </div>

                            <div>
                                <c:if test="${q.questionType == 1}">
                                    <div class="option-group">
                                        <c:forEach items="${q.options}" var="opt">
                                            <label class="option-label" onclick="selectRadio(this)">
                                                <input type="radio" class="form-check-input"
                                                       name="question_${q.id}"
                                                       value="${opt.optionText}"
                                                    ${q.isRequired == 1 ? 'required' : ''}
                                                       onchange="updateProgress()">
                                                <span>${opt.optionText}</span>
                                            </label>
                                        </c:forEach>
                                    </div>
                                </c:if>

                                <c:if test="${q.questionType == 2}">
                                    <div class="option-group">
                                        <c:forEach items="${q.options}" var="opt">
                                            <label class="option-label" onclick="toggleCheckbox(this)">
                                                <input type="checkbox" class="form-check-input"
                                                       name="question_${q.id}"
                                                       value="${opt.optionText}"
                                                       onchange="updateProgress()">
                                                <span>${opt.optionText}</span>
                                            </label>
                                        </c:forEach>
                                    </div>
                                </c:if>

                                <c:if test="${q.questionType == 3}">
                                        <textarea class="form-control-area"
                                                  name="question_${q.id}"
                                                  rows="3"
                                                  placeholder="请输入您的回答..."
                                            ${q.isRequired == 1 ? 'required' : ''}
                                                  oninput="updateProgress()"></textarea>
                                </c:if>
                            </div>
                        </div>

                    </c:forEach>

                    <div class="submit-area">
                        <button type="submit" class="btn btn-submit" id="submitBtn">
                            提交答卷
                        </button>
                    </div>

                </c:when>
                <c:otherwise>
                    <div class="text-center py-5 text-muted">
                        <i class="bi bi-clipboard-x display-4 mb-3 d-block" style="opacity:0.3"></i>
                        <p>该问卷暂时没有题目，请联系发布者。</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

    </form>

    <!-- 预览模式禁止提交提示框 -->
    <div class="modal fade" id="previewModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content preview-modal-content position-relative">
                <button type="button"
                        class="preview-modal-close"
                        data-bs-dismiss="modal"
                        aria-label="Close">
                    &times;
                </button>
                <div class="modal-body preview-modal-body text-center">
                    <p>此问卷为预览状态，不能提交</p>
                    <button type="button"
                            class="btn btn-primary px-4"
                            data-bs-dismiss="modal">
                        确认
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="text-center mt-4 text-muted small">
    &copy; 2023 问卷星 · 提供技术支持
</div>

<script src="<c:url value='/resources/js/bootstrap/bootstrap.bundle.min.js'/>"></script>
<script>
    let previewModal; // 全局变量，用于预览弹窗

    // 初始化
    document.addEventListener('DOMContentLoaded', function() {
        updateProgress();

        const isPreview = new URLSearchParams(window.location.search).get('preview') === 'true';

        // 预览模式下，绑定手机 / 电脑 tab 切换
        if (isPreview) {
            const tabs = document.querySelectorAll('.preview-tab[data-mode]');
            tabs.forEach(tab => {
                tab.addEventListener('click', function () {
                    const mode = this.dataset.mode; // 'mobile' or 'desktop'

                    // 切换 body 上的模式 class
                    document.body.classList.remove('preview-mobile', 'preview-desktop');
                    document.body.classList.add('preview-' + mode);

                    // 切换 tab 高亮
                    tabs.forEach(t => t.classList.remove('active'));
                    this.classList.add('active');
                });
            });
        }

        // 只在预览模式关闭浏览器的原生表单校验
        if (isPreview) {
            const form = document.getElementById('questionnaireForm');
            if (form) {
                // 1) 关闭 HTML5 自带校验（不会再弹“请选择其中一个选项”）
                form.noValidate = true;

                // 2) 可选：顺便把 required 删掉，彻底干净
                form.querySelectorAll('[required]').forEach(function (el) {
                    el.removeAttribute('required');
                });
            }
        }

        // 如果你按照上一次的步骤加了预览提示 Modal，这里顺便初始化
        const modalEl = document.getElementById('previewModal');
        if (modalEl && window.bootstrap && bootstrap.Modal) {
            previewModal = new bootstrap.Modal(modalEl, {
                backdrop: 'static',
                keyboard: false
            });
        }
    });

    // 1. 进度条逻辑
    function updateProgress() {
        const questions = document.querySelectorAll('.question-item');
        const total = questions.length;
        if (total === 0) return;

        let answered = 0;
        questions.forEach(q => {
            const type = q.dataset.type;
            let isDone = false;
            if (type === '1') { // 单选
                if (q.querySelector('input:checked')) isDone = true;
            } else if (type === '2') { // 多选
                if (q.querySelector('input:checked')) isDone = true;
            } else if (type === '3') { // 填空
                if (q.querySelector('textarea').value.trim() !== '') isDone = true;
            }
            if (isDone) answered++;
        });

        const pct = Math.round((answered / total) * 100);
        document.getElementById('progressBar').style.width = pct + '%';
    }

    // 2. 交互视觉：单选高亮
    function selectRadio(label) {
        setTimeout(() => {
            const radio = label.querySelector('input[type="radio"]');
            const name = radio.name;
            document.querySelectorAll('input[name="' + name + '"]').forEach(input => {
                input.closest('.option-label').classList.remove('active');
            });
            if (radio.checked) label.classList.add('active');
        }, 10);
    }

    // 3. 交互视觉：多选高亮
    function toggleCheckbox(label) {
        setTimeout(() => {
            const checkbox = label.querySelector('input[type="checkbox"]');
            if (checkbox.checked) label.classList.add('active');
            else label.classList.remove('active');
        }, 10);
    }

    // 4. 表单提交验证
    document.getElementById('questionnaireForm').addEventListener('submit', function(e) {
        // 检查URL中的preview参数，判断是否为预览模式
        const isPreview = new URLSearchParams(window.location.search).get('preview') === 'true';

        // ***** 核心逻辑：拦截预览模式下的提交 *****
        if (isPreview) {
            e.preventDefault();
            if (previewModal) {
                previewModal.show();    // 弹出自定义提示框
            } else {
                // 兜底：如果 modal 初始化失败，就用原来的 alert
                alert('当前为预览模式，无法提交数据。');
            }
            return;
        }
        // ***************************************

        // 必填校验
        const questions = document.querySelectorAll('.question-item');
        let hasError = false;
        let firstErrorItem = null;

        for (let q of questions) {
            const required = q.querySelector('.q-req');
            const type = q.dataset.type;
            q.querySelector('.q-title').style.color = '#2c3e50'; // 恢复标题颜色

            if (required) {
                let valid = true;
                if (type === '2') { // 多选至少选一项
                    if (!q.querySelector('input:checked')) valid = false;
                } else if (type === '1') { // 单选
                    if (!q.querySelector('input:checked')) valid = false;
                } else if (type === '3') { // 填空
                    if (q.querySelector('textarea').value.trim() === '') valid = false;
                }

                if (!valid) {
                    hasError = true;
                    q.querySelector('.q-title').style.color = 'var(--danger-color)';
                    if (!firstErrorItem) firstErrorItem = q;
                }
            }
        }

        if (hasError) {
            e.preventDefault();
            firstErrorItem.scrollIntoView({behavior: 'smooth', block: 'center'});
            // 简单的视觉反馈
            firstErrorItem.style.transform = "translateX(5px)";
            setTimeout(() => firstErrorItem.style.transform = "translateX(0)", 100);
            alert('请填写所有必填项（标*号题目）');
        } else {
            // 防止重复提交
            const btn = document.getElementById('submitBtn');
            btn.disabled = true;
            btn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>提交中...';
        }
    });

    // 关闭预览功能
    function closePreview() {
        if (document.referrer) {
            window.history.back();
        } else {
            // 如果没有 referrer，就回到首页 / 或者改成你的问卷编辑地址
            window.location.href = '/';
        }
    }
</script>
</body>
</html>