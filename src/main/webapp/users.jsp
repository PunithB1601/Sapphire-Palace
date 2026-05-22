<%@page import="com.sapphirepalace.dto.Guest"%>
<%@page import="java.util.List"%>
<%@page import="com.sapphirepalace.dao.impl.GuestDAOImpl"%>
<%@page import="com.sapphirepalace.dao.GuestDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Users - Sapphire Palace</title>
<!-- Font Awesome for icons - ADD THIS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style type="text/css">
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
        background: linear-gradient(135deg, #FFFFFF 0%, #FFFFF4 50%, #F5E6C2 100%);
        overflow-x: hidden;
    }

    /* Admin Container */
    .admin-container {
        display: flex;
        min-height: 100vh;
    }
    
    /* Main Content */
    .main-content {
        flex: 1;
        margin-left: 0;
        padding: 20px 30px;
        width: 100%;
    }

    /* Top Bar */
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

    .admin-info {
        display: flex;
        align-items: center;
        gap: 20px;
    }

    .admin-name {
        font-weight: 500;
        color: black;
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
    }

    /* Content Panels */
    .content-panel {
        display: block;
        background: white;
        border-radius: 20px;
        padding: 25px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
    }

    .panel-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 25px;
        flex-wrap: wrap;
        gap: 15px;
    }

    .panel-header h2 {
        font-size: 22px;
        color: black;
    }

    /* ==================== BUTTON STYLES - ADD THIS ==================== */
    .btn-primary {
        background: #115eb6;
        color: white;
        border: none;
        padding: 8px 16px;
        border-radius: 8px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        font-family: inherit;
        text-decoration: none;
        display: inline-block;
        margin: 0 5px;
    }

    .btn-primary:hover {
        background: #0e4d92;
    }

    /* Gray button for Back */
    .btn-gray {
        background: #6c757d;
        color: white;
    }

    .btn-gray:hover {
        background: #5a6268;
    }

    /* Tables */
    .data-table {
        width: 100%;
        overflow-x: auto;
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    th, td {
        padding: 12px;
        text-align: left;
        border-bottom: 1px solid #eee;
    }

    th {
        background: #f8f9fa;
        font-weight: 600;
        color: #0A192F;
    }

    /* Responsive */
    @media (max-width: 1024px) {
        .stats-grid {
            grid-template-columns: repeat(2, 1fr);
        }
    }

    @media (max-width: 768px) {
        .main-content {
            margin-left: 0;
            padding: 15px;
        }
        .data-table {
            font-size: 14px;
        }
        th, td {
            padding: 8px;
        }
        .panel-header {
            flex-direction: column;
            align-items: flex-start;
        }
        .btn-primary {
            margin: 5px 0;
        }
    }
</style>
</head>
<body>
    <div class="admin-container">
        <!-- Main Content -->
        <main class="main-content">
            <!-- Top Bar -->
            <div class="top-bar">
                <h1 class="page-title">Manage Users</h1>
                <div class="admin-info">
                    <span class="admin-name">Administrator</span>
                    <div class="admin-avatar">A</div>
                </div>
            </div>
           
            <div id="usersPanel" class="content-panel">
                <div class="panel-header">
                    <h2>Registered Users</h2>
                    <div>
                        <a href="booking.jsp" class="btn-primary"><i class="fas fa-calendar"></i>  Bookings</a>
                        <a href="admin.jsp" class="btn-primary btn-gray"><i class="fas fa-arrow-left"></i> Back</a>
                    </div>
                </div>
                <div class="data-table">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                               
                            </tr>
                        </thead>
                        
                        <%GuestDAO gdao=new GuestDAOImpl();%>
                        <tbody>
                        <%List<Guest> gList=gdao.getAllGuests();%>
                        <%for(Guest g:gList){%>
                            <tr>
                            <td><%=g.getGuestId() %></td>
                            <td><%=g.getName()%></td>
                            <td><%=g.getEmail()%></td>
                            <td><%=g.getPhone()%></td>
                            </tr>
                          <%}%>  
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>
</body>
</html>