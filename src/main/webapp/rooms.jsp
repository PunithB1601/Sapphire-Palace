<%@page import="com.sapphirepalace.dto.Rooms"%>
<%@page import="java.util.List"%>
<%@page import="com.sapphirepalace.dao.RoomsDAO"%>
<%@page import="com.sapphirepalace.dao.impl.RoomsDAOImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard - Manage Rooms | Sapphire Palace</title>
<!-- Font Awesome Icons -->
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
    
    .main-content {
        flex: 1;
        
        padding: 20px 30px;
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

    /* Stats Cards */
    .stats-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 20px;
        margin-bottom: 30px;
    }

    .stat-card {
        background: white;
        padding: 20px;
        border-radius: 16px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        transition: transform 0.3s ease;
    }

    .stat-card:hover {
        transform: translateY(-3px);
    }

    .stat-title {
        color: black;
        font-size: 13px;
        text-transform: uppercase;
        letter-spacing: 1px;
        margin-bottom: 10px;
    }

    .stat-value {
        font-size: 32px;
        font-weight: 700;
        color: #115eb6;
    }

    .stat-icon {
        float: right;
        font-size: 40px;
        color: black;
        opacity: 0.5;
    }

    /* Content Panels */
    .content-panel {
        display: none;
        background: white;
        border-radius: 20px;
        padding: 25px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
    }

    .content-panel.active {
        display: block;
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

    /* Buttons */
    .btn-primary {
        background: #115eb6;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 8px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        font-family: inherit;
        text-decoration: none;
        display: inline-block;
    }

    .btn-primary:hover {
        background: #0e4d92;
    }

    .btn-danger {
        background: #e74c3c;
        color: white;
        border: none;
        padding: 6px 12px;
        border-radius: 6px;
        cursor: pointer;
        margin-right: 5px;
    }

    .btn-warning {
        background: #f39c12;
        color: white;
        border: none;
        padding: 6px 12px;
        border-radius: 6px;
        cursor: pointer;
    }

    /* Action Buttons Container */
    .action-buttons {
        display: flex;
        gap: 8px;
        flex-wrap: wrap;
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

    /* Status Badges */
    .status {
        padding: 4px 12px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 500;
        display: inline-block;
    }

    .status.available {
        background: #d4edda;
        color: #155724;
    }

    .status.booked {
        background: #f8d7da;
        color: #721c24;
    }

    /* Responsive */
    @media (max-width: 1024px) {
        .stats-grid {
            grid-template-columns: repeat(2, 1fr);
        }
    }

    @media (max-width: 768px) {
        .sidebar {
            transform: translateX(-100%);
            position: fixed;
        }
        .main-content {
            margin-left: 0;
        }
        .stats-grid {
            grid-template-columns: 1fr;
        }
        .form-row {
            grid-template-columns: 1fr;
        }
    }
</style>
</head>
<body>

<%
    RoomsDAO rdao = new RoomsDAOImpl();
    List<Rooms> rList = rdao.getAllRooms();
%>

<div class="admin-container">
    <!-- Main Content -->
    <main class="main-content">
        <!-- Top Bar -->
        <div class="top-bar">
            <h1 class="page-title">Manage Rooms</h1>
            <div class="admin-info">
                <span class="admin-name">Administrator</span>
                <div class="admin-avatar">A</div>
            </div>
        </div>

        <!-- Rooms Management Panel -->
        <div id="roomsPanel" class="content-panel active">
            <div class="panel-header">
                <h2><i class="fas fa-bed"></i> All Rooms</h2>
                <div>
                    <a href="addRooms.jsp" class="btn-primary"><i class="fas fa-plus"></i> Add Room</a>
                    <a href="admin.jsp" class="btn-primary" style="background: #6c757d;"><i class="fas fa-arrow-left"></i> Back</a>
                </div>
            </div>
            <div class="data-table">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Room Number</th>
                            <th>Type</th>
                            <th>Price (₹)</th>
                            <th>Max Guests</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <% if (rList != null && !rList.isEmpty()) { 
                        for (Rooms r : rList) { %>
                        <tr>
                            <td><%= r.getRoomId() %></td>
                            <td><%= r.getRoomNumber() %></td>
                            <td><%= r.getType() %></td>
                            <td>₹<%=r.getPrice()%></td>
                            <td>2</td>
                            <td>
                                <% if (r.getAvailability()) { %>
                                    <span class="status available">Available</span>
                                <% } else { %>
                                    <span class="status booked">Booked</span>
                                <% } %>
                            </td>
                            <td class="action-buttons">
                                <form action="deleteRoom" method="POST" style="display: inline;">
                                    <input type="hidden" name="roomId" value="<%= r.getRoomId() %>">
                                    <button type="submit" class="btn-danger" onclick="return confirm('Are you sure you want to delete this room?')">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </form>
                                <form action="editRoom" method="POST" style="display: inline;">
                                    <input type="hidden" name="roomId" value="<%= r.getRoomId() %>">
                                    <button type="submit" class="btn-warning">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    <% } 
                    } else { %>
                        <tr>
                            <td colspan="7" style="text-align: center;">No rooms found</td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</div>
</body>
</html>