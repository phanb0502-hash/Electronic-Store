<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<!-- ========== CSS SECTION ========== -->
<style>
    .header-container {
        background: linear-gradient(90deg, #0056b3, #0056b3 100%);
        color: white;
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 12px 24px;
        border-radius: 6px;
        box-shadow: 0 2px 6px rgba(0,0,0,0.15);
    }

    .header-left {
        font-size: 18px;
        font-weight: bold;
        letter-spacing: 0.5px;
    }

    .header-left span {
        color: #f0f8ff;
    }

    .header-right {
        display: flex;
        align-items: center;
        gap: 15px;
    }

    .username {
        font-weight: 600;
        font-size: 15px;
    }

    .logout-link {
        background-color: #ff4d4f;
        color: white;
        padding: 6px 12px;
        border-radius: 6px;
        text-decoration: none;
        font-weight: 500;
        transition: 0.25s;
    }

    .logout-link:hover {
        background-color: #d9363e;
    }
</style>

<!-- ========== HTML + JSP SECTION ========== -->
<div class="header-container">
    <div class="header-left">
        <span>PRJ302</span> | Electronic Store
    </div>

    <div class="header-right">
        <span class="username">
            <c:out value="${sessionScope.user.fullName}" />
        </span>
        <a href="logout" class="logout-link">Đăng xuất</a>
    </div>
</div>
