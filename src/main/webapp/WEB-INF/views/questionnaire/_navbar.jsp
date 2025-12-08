<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 
    通用导航栏组件
    用法：在 JSP 页面的 <body> 开始处使用 <jsp:include page="_navbar.jsp"/>
--%>

<!-- 统一的顶部导航栏 -->
<nav class="navbar navbar-expand-lg navbar-light fixed-top">
    <div class="container">
        <a class="navbar-brand" href="<c:url value='/questionnaire/list'/>">
            <i class="bi bi-card-checklist"></i> 问卷星
        </a>

        <!-- 移动端折叠按钮 -->
        <button class="navbar-toggler custom-toggler collapsed"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#navbarNav"
                aria-controls="navbarNav"
                aria-expanded="false"
                aria-label="切换导航">
            <span class="toggler-lines">
                <span></span>
                <span></span>
                <span></span>
            </span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value='/'/>">首页</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="<c:url value='/questionnaire/list'/>">我的问卷</a>
                </li>
            </ul>
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
