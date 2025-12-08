<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <jsp:include page="_head.jsp"/>
    <title>${empty questionnaire.id ? '创建问卷' : '编辑问卷'} - 问卷星</title>
</head>
<body>


<%-- 设置当前页面名称，用于左侧导航高亮显示 --%>
<c:set var="pageName" value="create" scope="request"/>
<jsp:include page="_navbar.jsp"/>

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
                <%-- 使用公共左侧导航组件 --%>
                <jsp:include page="_leftnav.jsp"/>

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


<%-- 使用公共脚本 --%>
<jsp:include page="_scripts.jsp"/>

</body>
</html>