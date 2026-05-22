<%@page import="com.sapphirepalace.dao.impl.PaymentDAOImpl"%>
<%@page import="com.sapphirepalace.dao.PaymentDAO"%>
<%@page import="com.sapphirepalace.dto.Payment"%>
<%@page import="com.sapphirepalace.dto.Booking"%>
<%@page import="java.util.List"%>
<%@page import="com.sapphirepalace.dao.impl.GuestDAOImpl"%>
<%@page import="com.sapphirepalace.dao.GuestDAO"%>
<%@page import="com.sapphirepalace.dao.RoomsDAO"%>
<%@page import="com.sapphirepalace.dao.impl.RoomsDAOImpl"%>
<%@page import="com.sapphirepalace.dao.impl.BookingDAOImpl"%>
<%@page import="com.sapphirepalace.dao.BookingDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
 <style>
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

    /* ==================== ADMIN CONTAINER - ADD THIS ==================== */
    .admin-container {
        display: flex;
        min-height: 100vh;
    }

    /* ==================== SIDEBAR - ADD THIS ==================== */
    .sidebar {
        width: 280px;
        background: linear-gradient(135deg, #FFFFFF 0%, #FFFFF4 50%, #F5E6C2 100%);
        position: fixed;
        height: 100vh;
        overflow-y: auto;
        transition: all 0.3s ease;
        z-index: 100;
        box-shadow: 2px 0 10px rgba(0,0,0,0.05);
    }

    .sidebar-header {
        padding: 25px 20px;
        border-bottom: 1px solid rgba(17, 94, 182, 0.2);
        margin-bottom: 20px;
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
        color: #115eb6;
    }

    .sidebar-logo-text span {
        color: #115eb6;
    }

    .sidebar-menu {
        padding: 0 15px;
    }

    .menu-item {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 12px 15px;
        margin-bottom: 8px;
        border-radius: 12px;
        transition: all 0.3s ease;
        color: black;
        text-decoration: none;
    }

    .menu-item:hover {
        background: #115eb6;
        color: white;
    }

    .menu-item.active {
        background: #115eb6;
        color: white;
    }

    .menu-item i {
        width: 22px;
        font-size: 18px;
    }

    /* ==================== MAIN CONTENT ==================== */
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

    /* Content Panels */
    .content-panel {
        display: block;  /* CHANGED FROM 'none' TO 'block' - so panel shows */
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

    /* Back Button - FIXED */
    .back-btn {
        margin-bottom: 20px;
    }

    /* Buttons */
    .btn-primary {
        background: #115eb6;  /* CHANGED to match sidebar color */
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
    }

    .btn-primary:hover {
        background: #0e4d92;
    }

    .btn-primary:disabled {
        background: #ccc;
        cursor: not-allowed;
        opacity: 0.6;
    }

    /* Back Button Special Style - FIXED */
    .btn-back {
        background: #6c757d;
        color: white;
    }

    .btn-back:hover {
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
        vertical-align: middle;  /* ADDED for better alignment */
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

    .status.confirmed {
        background: #d4edda;
        color: #155724;
    }

    .status.pending {
        background: #fff3cd;
        color: #856404;
    }

    .status.cancelled {
        background: #f8d7da;
        color: #721c24;
    }

    .status.completed {
        background: #d1ecf1;
        color: #0c5460;
    }

    /* Filter Select */
    .filter-select {
        padding: 8px 15px;
        border-radius: 8px;
        border: 1px solid #ddd;
        font-family: inherit;
        background: white;
    }

    /* Action Form - FIXED for inline alignment */
    .action-form {
        display: flex;
        gap: 8px;
        align-items: center;
        flex-wrap: wrap;
    }

    form {
        display: inline-flex;
        gap: 8px;
        align-items: center;
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
        table, thead, tbody, th, td, tr {
            display: block;
        }
        th {
            display: none;
        }
        td {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #eee;
        }
        td::before {
            content: attr(data-label);
            font-weight: bold;
            width: 40%;
        }
    }
    </style>
</head>

<body>

<%BookingDAO bdao=new BookingDAOImpl();
  RoomsDAO rdao=new RoomsDAOImpl();
  GuestDAO gdao=new GuestDAOImpl();
  PaymentDAO pdao=new PaymentDAOImpl();%>

	<div class="admin-container">
    <!-- Main Content -->
    <main class="main-content">
    <div class="top-bar">
            <h1 class="page-title">Manage Bookings</h1>
            <div class="admin-info">
                <span class="admin-name">Administrator</span>
                <div class="admin-avatar">A</div>
            </div>
      </div>
	<div id="bookingsPanel" class="content-panel">
           <div>
                    <a href="admin.jsp" class="btn-primary" style="background: #6c757d;"><i class="fas fa-arrow-left"></i> Back</a>
           </div> 
            <%List<Booking> bList=bdao.getAllBookings();%>
            <div class="panel-header">
                <h2>All Bookings</h2>
                <select class="filter-select">
                    <option value="booking?status=all">All Bookings</option>
                    <option value="booking?status=pending">Pending</option>
                    <option value="booking?status=confirmed">Confirmed</option>
                    <option value="booking?status=completed">Completed</option>
                    <option value="booking?status=cancelled">Cancelled</option>
                </select>
            </div>
            <div class="data-table">
                <table>
                    <thead>
                        <tr>
                            <th>Booking ID</th>
                            <th>Guest Name</th>
                            <th>Room</th>
                            <th>Check In</th>
                            <th>Check Out</th>
                           
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%for(Booking b:bList){%>
                        <tr><td>BK00<%=b.getBookingId()%></td>
                        <td><%=gdao.getGuestById(b.getGuestId()).getName()%></td>
                        <td><%=rdao.getRoomById(b.getRoomId())%></td>
                        <td><%=b.getCheckIn()%></td>
                        <td><%=b.getCheckOut()%></td>
                        
                        <%if(b.getStatus().equals("CONFIRMED")){%>
                        <td><span class="status confirmed">Confirmed</span></td>
                        <%}else if(b.getStatus().equals("COMPLETED")){%>
                        <td><span class="status completed">Completed</span></td>
                        <%}else if(b.getStatus().equals("CANCELLED")){%>
                        <td><span class="status cancelled">Cancelled</span></td>
                        <%}else{%>
                        <td><span class="status pending">Pending</span></td>
                        <%}%>
                        
                        <%if(b.getStatus().equals("COMFIRMED")||b.getStatus().equals("PENDING")){%>
                         <td>
                         <form action="updateBooking" method="POST">
                         <select class="filter-select">
                    		<option value="CONFIRMED">Confirm</option>
                    		<option value="COMPLETED">Complete</option>
                		</select>
                        <button type="submit" class="btn-primary">Update</button>
                        </form>
                         </td>
                        <%}else{%>
                        <td><button class="btn-primary" disabled="disabled">Update</button></td>
                        <%}%>   
                    <%}%>
                    </tbody>
                </table>
            </div>
        </div>
		</main>
		</div>
</body>
</html>