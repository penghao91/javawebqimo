<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 
    通用JavaScript脚本
    用法：在 JSP 页面的 </body> 结束标签前使用 <jsp:include page="_scripts.jsp"/>
--%>

<script src="<c:url value='/resources/js/bootstrap/bootstrap.bundle.min.js'/>"></script>
<script>
    // 统一的导航栏滚动效果
    (function() {
        const navbar = document.querySelector('.navbar');
        if (!navbar) return;
        
        window.addEventListener('scroll', function () {
            if (window.scrollY > 50) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        });
    })();

    // 移动端导航折叠控制
    (function() {
        const navbarCollapseEl = document.getElementById('navbarNav');
        const navbarToggler = document.querySelector('.navbar-toggler');

        if (!navbarToggler || !navbarCollapseEl) return;
        
        try {
            const collapseInstance = new bootstrap.Collapse(navbarCollapseEl, {toggle: false});
            
            navbarToggler.addEventListener('click', function () {
                const isShown = navbarCollapseEl.classList.contains('show');
                if (isShown) {
                    collapseInstance.hide();
                } else {
                    collapseInstance.show();
                }
            });

            navbarCollapseEl.addEventListener('shown.bs.collapse', function () {
                navbarToggler.setAttribute('aria-expanded', 'true');
                navbarToggler.classList.remove('collapsed');
            });
            
            navbarCollapseEl.addEventListener('hidden.bs.collapse', function () {
                navbarToggler.setAttribute('aria-expanded', 'false');
                navbarToggler.classList.add('collapsed');
            });
        } catch (error) {
            console.error('Failed to initialize navbar collapse:', error);
        }
    })();
</script>
