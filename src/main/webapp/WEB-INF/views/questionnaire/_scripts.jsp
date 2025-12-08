<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 
    通用JavaScript脚本
    用法：在 JSP 页面的 </body> 结束标签前使用 <jsp:include page="_scripts.jsp"/>
--%>

<script src="<c:url value='/resources/js/bootstrap/bootstrap.bundle.min.js'/>"></script>
<script>
    // 统一的导航栏滚动效果 - 优化版本，使用 requestAnimationFrame 防止抖动
    (function() {
        const navbar = document.querySelector('.navbar');
        if (!navbar) return;
        
        let ticking = false;
        let lastScrollY = 0;
        
        function updateNavbar() {
            const scrollY = window.scrollY || window.pageYOffset;
            
            // 只在滚动位置实际改变时更新类名
            if (scrollY !== lastScrollY) {
                if (scrollY > 50) {
                    navbar.classList.add('scrolled');
                } else {
                    navbar.classList.remove('scrolled');
                }
                lastScrollY = scrollY;
            }
            
            ticking = false;
        }
        
        function onScroll() {
            if (!ticking) {
                // 使用 requestAnimationFrame 确保在下一帧渲染前更新
                window.requestAnimationFrame(updateNavbar);
                ticking = true;
            }
        }
        
        // 使用 passive 选项提高滚动性能
        window.addEventListener('scroll', onScroll, { passive: true });
        
        // 初始化状态
        updateNavbar();
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
