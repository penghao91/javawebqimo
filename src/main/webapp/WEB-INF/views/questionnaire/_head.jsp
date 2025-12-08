<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 
    通用头部样式和资源引用
    用法：在 JSP 页面的 <head> 标签内使用 <jsp:include page="_head.jsp"/>
--%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="<c:url value='/resources/css/bootstrap/bootstrap.min.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/bootstrap-icons/bootstrap-icons.css'/>" rel="stylesheet">

<%-- 引入统一的公共样式 --%>
<jsp:include page="common-styles.jsp"/>