<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-lg-3">
    <div class="nav-card">
        <div class="nav-card-title">
            <i class="bi bi-compass"></i>
            <span>快速导航</span>
        </div>
        <div class="nav-card-sub">切换不同的问卷视图</div>
        <ul class="nav-card-menu">
            <li>
                <a href="<c:url value='/questionnaire/create'/>"
                   class="nav-link-chip ${pageName == 'create' ? 'active' : ''}">
                    <i class="bi bi-plus-circle"></i> 创建问卷
                </a>
            </li>
            <li>
                <a href="<c:url value='/questionnaire/list'/>"
                   class="nav-link-chip ${pageName == 'list' ? 'active' : ''}">
                    <i class="bi bi-list-ul"></i> 全部问卷
                </a>
            </li>
            <li>
                <a href="<c:url value='/questionnaire/starred'/>"
                   class="nav-link-chip ${pageName == 'starred' ? 'active' : ''}">
                    <i class="bi bi-star"></i> 星标问卷
                </a>
            </li>
            <li>
                <a href="<c:url value='/questionnaire/folders'/>"
                   class="nav-link-chip ${pageName == 'folders' ? 'active' : ''}">
                    <i class="bi bi-folder"></i> 文件夹
                </a>
            </li>
            <li>
                <a href="<c:url value='/questionnaire/recycle'/>"
                   class="nav-link-chip ${pageName == 'recycle' ? 'active' : ''}">
                    <i class="bi bi-trash"></i> 回收站
                </a>
            </li>
        </ul>
    </div>
</div>