<%@page import="com.sapphirepalace.dto.Guest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
 /* Top Bar */	
 		body {
 			font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
            background: linear-gradient(135deg, #FFFFFF 0%, #FFFFF4 50%, #F5E6C2 100%);
            color: #1a2c3e;
 		}
 
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: white;
            padding: 15px 25px;
            border-radius: 16px;
            margin-bottom: 25px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .page-title {
            font-size: 24px;
            font-weight: 600;
            color: black;
        }

		.sidebar-logo {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .sidebar-logo-img {
            height: 45px;
            width: auto;
        }

        .sidebar-logo-text {
           
            font-size: 20px;
            font-weight: 700;
        }

        .sidebar-logo-text span {
            color: #115eb6;
        }
		
      /* Admin Info Container */
    .admin-info {
        display: flex;
        align-items: center;
        gap: 20px;
        position: relative;
    }

    .admin-name {
        font-weight: 500;
        color: black;
    }

    /* Avatar Wrapper - contains avatar and dropdown */
    .admin-avatar-wrapper {
        position: relative;
        cursor: pointer;
    }

    .admin-avatar {
        width: 45px;
        height: 45px;
        background: #bdd9ef;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: bold;
        color: black;
        transition: all 0.3s ease;
    }

    /* Dropdown Menu - Hidden by default */
    .dropdown-menu {
        position: absolute;
        top: 55px;
        right: 0;
        background: white;
        min-width: 200px;
        border-radius: 12px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
        overflow: hidden;
        opacity: 0;
        visibility: hidden;
        transform: translateY(-10px);
        transition: all 0.3s ease;
        z-index: 100;
    }

    /* Show dropdown on hover */
    .admin-avatar-wrapper:hover .dropdown-menu {
        opacity: 1;
        visibility: visible;
        transform: translateY(0);
    }

    /* Avatar hover effect */
    .admin-avatar-wrapper:hover .admin-avatar {
        background: #115eb6;
        color: white;
    }

    /* Dropdown Items */
    .dropdown-item {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 12px 16px;
        color: #1a2c3e;
        text-decoration: none;
        font-size: 14px;
        font-weight: 500;
        transition: all 0.2s ease;
    }

    .dropdown-item:hover {
        background: #f0f4fa;
        padding-left: 20px;
    }

    .dropdown-icon {
        font-size: 16px;
        width: 20px;
    }

    /* Logout item special styling */
    .logout-item {
        color: #e74c3c;
    }

    .logout-item:hover {
        background: #fee;
    }

    /* Divider */
    .dropdown-divider {
        height: 1px;
        background: #eef2f8;
        margin: 5px 0;
    }

    /* Small arrow indicator on avatar */
    .admin-avatar-wrapper::after {
        content: '▼';
        position: absolute;
        bottom: -18px;
        left: 50%;
        transform: translateX(-50%);
        font-size: 10px;
        color: #115eb6;
        opacity: 0;
        transition: opacity 0.3s ease;
    }

    .admin-avatar-wrapper:hover::after {
        opacity: 1;
    }

    /* Responsive */
    @media (max-width: 768px) {
        .dropdown-menu {
            position: fixed;
            top: auto;
            bottom: 0;
            left: 0;
            right: 0;
            width: 100%;
            border-radius: 20px 20px 0 0;
            transform: translateY(100%);
        }
        
        .admin-avatar-wrapper:hover .dropdown-menu {
            transform: translateY(0);
        }
       }
</style>
</head>
<body>
<%Guest user=(Guest)session.getAttribute("user");%>
<%if(user==null){
	request.setAttribute("loginError","Session expired!");
	request.getRequestDispatcher("sign.jsp").forward(request,response);
}else{%>
<!-- Top Bar -->
        <div class="top-bar">
        <div class="sidebar-logo">
                <!-- Logo Image Space - Replace src with your logo path -->
                <img src="DCL/logo-removebg-preview.png" alt="Sapphire Palace Logo" class="sidebar-logo-img" onerror="this.style.display='none'">
                <div class="sidebar-logo-text">SAPPHIRE <span>PALACE</span></div>
            </div>
            <h1 class="page-title">Manage Rooms</h1>
           <div class="admin-info">
    <span class="admin-name"><%=user.getName().toUpperCase()%></span>
    <div class="admin-avatar-wrapper">
        <div class="admin-avatar"><%=user.getName().substring(0, 1) %></div>
		<div class="dropdown-menu">
            <a href="index.jsp" class="dropdown-item">
                <span class="dropdown-icon"></span>
                Dashboard
            </a>
            <a href="updateAccount.jsp" class="dropdown-item">
                <span class="dropdown-icon"></span>
                Update Account
            </a>
            <div class="dropdown-divider"></div>
            <a href="logout" class="dropdown-item logout-item">
                <span class="dropdown-icon"></span>
                Logout
            </a>
            </div>
            </div>
            </div>
        </div>
        <%}%>
        
       
</body>
</html>