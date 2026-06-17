<%@page import="java.util.stream.Collectors"%>
<%@page import="com.sapphirepalace.servlet.BookRoom"%>
<%@page import="com.sapphirepalace.dto.Rooms"%>
<%@page import="com.sapphirepalace.dao.impl.RoomsDAOImpl"%>
<%@page import="com.sapphirepalace.dao.RoomsDAO"%>
<%@page import="com.sapphirepalace.dto.Image"%>
<%@page import="com.sapphirepalace.dao.impl.ImageDAOImpl"%>
<%@page import="com.sapphirepalace.dao.ImageDAO"%>
<%@page import="com.sapphirepalace.dto.Payment"%>
<%@page import="com.sapphirepalace.dao.impl.PaymentDAOImpl"%>
<%@page import="com.sapphirepalace.dao.PaymentDAO"%>
<%@page import="com.sapphirepalace.dto.Booking"%>
<%@page import="java.util.List"%>
<%@page import="com.sapphirepalace.dao.impl.BookingDAOImpl"%>
<%@page import="com.sapphirepalace.dao.BookingDAO"%>
<%@page import="com.sapphirepalace.dto.Guest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings - Sapphire Palace</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Inter', sans-serif;
        background: linear-gradient(135deg, #FFFFFF 0%, #FFFFF4 50%, #F5E6C2 100%);
        min-height: 100vh;
        padding: 0;
    }

    /* Main Container */
    .bookings-container {
        max-width: 1300px;
        margin: 0 auto;
        padding: 40px 20px;
    }

    /* Header Section */
    .page-header {
        text-align: center;
        margin-bottom: 40px;
    }

    .page-badge {
        display: inline-block;
        background: #115eb6;
        color: white;
        font-size: 12px;
        font-weight: 600;
        padding: 6px 18px;
        border-radius: 30px;
        letter-spacing: 1px;
        margin-bottom: 20px;
    }

    h1 {
        font-size: 42px;
        font-weight: 700;
        color: #1a2c3e;
        margin-bottom: 10px;
    }

    h1 span {
        color: #115eb6;
    }

    .header-line {
        width: 80px;
        height: 3px;
        background: #115eb6;
        margin: 15px auto;
    }

    .header-subtitle {
        color: #5a6e85;
        font-size: 16px;
        max-width: 500px;
        margin: 0 auto;
    }

    /* Stats Cards */
    .stats-row {
        display: flex;
        gap: 20px;
        margin-bottom: 40px;
        flex-wrap: wrap;
    }

    .stat-card {
        flex: 1;
        min-width: 180px;
        background: white;
        border-radius: 20px;
        padding: 25px 20px;
        text-align: center;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        transition: transform 0.2s;
    }

    .stat-card:hover {
        transform: translateY(-3px);
    }

    .stat-icon {
        font-size: 32px;
        margin-bottom: 10px;
    }

    .stat-number {
        font-size: 32px;
        font-weight: 800;
        color: #115eb6;
    }

    .stat-label {
        font-size: 13px;
        color: #6c86a3;
        margin-top: 5px;
    }

    /* Filter Tabs */
    .filter-tabs {
        display: flex;
        gap: 12px;
        margin-bottom: 30px;
        flex-wrap: wrap;
        border-bottom: 1px solid #eef2f8;
        padding-bottom: 15px;
    }

    .filter-btn {
        padding: 10px 24px;
        background: transparent;
        border: none;
        font-size: 14px;
        font-weight: 600;
        color: #7c8ea0;
        cursor: pointer;
        border-radius: 40px;
        transition: all 0.2s;
        text-decoration: none;
        display: inline-block;
    }

    .filter-btn:hover {
        background: rgba(17, 94, 182, 0.1);
        color: #115eb6;
    }

    .filter-btn.active {
        background: #115eb6;
        color: white;
    }

    /* Bookings Grid */
    .bookings-grid {
        display: flex;
        flex-direction: column;
        gap: 25px;
    }

    /* Booking Card */
    .booking-card {
        background: white;
        border-radius: 24px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
        overflow: hidden;
        transition: all 0.2s;
    }

    .booking-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
    }

    /* Card Header */
    .card-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 18px 25px;
        background: #f8fafc;
        border-bottom: 1px solid #eef2f8;
        flex-wrap: wrap;
        gap: 10px;
    }

    .booking-id {
        font-size: 14px;
        font-weight: 600;
        color: #115eb6;
    }

    .booking-date {
        font-size: 12px;
        color: #7c8ea0;
    }

    /* Status Badges */
    .status {
        padding: 4px 14px;
        border-radius: 30px;
        font-size: 12px;
        font-weight: 600;
        display: inline-block;
    }

    .status.confirmed, .status.CONFIRMED {
        background: #e8f5e9;
        color: #27ae60;
    }

    .status.pending, .status.PENDING {
        background: #fff8e1;
        color: #f39c12;
    }

    .status.completed, .status.COMPLETED {
        background: #e3f2fd;
        color: #115eb6;
    }

    .status.cancelled, .status.CANCELLED {
        background: #ffebee;
        color: #e74c3c;
    }

    /* Card Body */
    .card-body {
        padding: 20px 25px;
        display: flex;
        gap: 20px;
        flex-wrap: wrap;
    }

    .room-image {
        width: 120px;
        height: 120px;
        background: #e8f0fe;
        border-radius: 16px;
        overflow: hidden;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .room-image img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .booking-details {
        flex: 2;
        min-width: 200px;
    }

    .room-name {
        font-size: 20px;
        font-weight: 700;
        color: #1a2c3e;
        margin-bottom: 8px;
    }

    .room-features {
        display: flex;
        gap: 15px;
        flex-wrap: wrap;
        margin-bottom: 10px;
    }

    .room-features span {
        font-size: 12px;
        color: #6c86a3;
        display: flex;
        align-items: center;
        gap: 4px;
    }

    .room-features span .material-icons {
        font-size: 14px;
        color: #115eb6;
    }

    .date-info {
        display: flex;
        gap: 20px;
        flex-wrap: wrap;
        margin-top: 10px;
    }

    .date-item {
        font-size: 13px;
        color: #5a6e85;
    }

    .date-item strong {
        color: #1a2c3e;
        margin-right: 5px;
    }

    .booking-amount {
        text-align: right;
        min-width: 150px;
        background: #f8fafc;
        padding: 15px;
        border-radius: 16px;
    }

    .amount {
        font-size: 24px;
        font-weight: 800;
        color: #115eb6;
    }

    .per-night {
        font-size: 12px;
        color: #6c86a3;
        margin-top: 5px;
    }

    /* Card Footer */
    .card-footer {
        padding: 15px 25px;
        background: #f8fafc;
        border-top: 1px solid #eef2f8;
        display: flex;
        justify-content: flex-end;
        gap: 12px;
        flex-wrap: wrap;
    }

    .btn-view {
        padding: 8px 20px;
        background: #115eb6;
        color: white;
        border: none;
        border-radius: 30px;
        font-size: 13px;
        font-weight: 600;
        cursor: pointer;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        transition: all 0.2s;
    }

    .btn-view:hover {
        background: #0a4a8c;
        transform: translateY(-2px);
    }

    .btn-cancel {
        padding: 8px 20px;
        background: transparent;
        color: #e74c3c;
        border: 1px solid #e74c3c;
        border-radius: 30px;
        font-size: 13px;
        font-weight: 600;
        cursor: pointer;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        transition: all 0.2s;
    }

    .btn-cancel:hover {
        background: #ffebee;
        transform: translateY(-2px);
    }

    .btn-invoice {
        padding: 8px 20px;
        background: transparent;
        color: #115eb6;
        border: 1px solid #115eb6;
        border-radius: 30px;
        font-size: 13px;
        font-weight: 600;
        cursor: pointer;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        transition: all 0.2s;
    }

    .btn-invoice:hover {
        background: rgba(17, 94, 182, 0.05);
        transform: translateY(-2px);
    }

    /* Empty State */
    .empty-state {
        text-align: center;
        padding: 60px 20px;
        background: white;
        border-radius: 24px;
    }

    .empty-icon {
        font-size: 64px;
        margin-bottom: 20px;
        opacity: 0.5;
    }

    .empty-state h3 {
        font-size: 20px;
        color: #1a2c3e;
        margin-bottom: 10px;
    }

    .empty-state p {
        color: #7c8ea0;
        margin-bottom: 25px;
    }

    .btn-explore {
        display: inline-block;
        padding: 12px 30px;
        background: #115eb6;
        color: white;
        text-decoration: none;
        border-radius: 40px;
        font-weight: 600;
    }

    /* Footer spacing */
    footer {
        margin-top: 50px;
    }

    /* Responsive */
    @media (max-width: 700px) {
        .bookings-container {
            padding: 20px 15px;
        }
        
        .card-body {
            flex-direction: column;
        }
        
        .booking-amount {
            text-align: left;
            width: 100%;
        }
        
        .stats-row {
            flex-direction: column;
        }
        
        h1 {
            font-size: 32px;
        }
        
        .card-header {
            flex-direction: column;
            text-align: center;
        }
        
        .filter-tabs {
            justify-content: center;
        }
        
        .room-image {
            width: 100%;
            height: 180px;
        }
        
        .booking-amount {
            text-align: center;
        }
        
        .card-footer {
            justify-content: center;
        }
    }
</style>
</head>
<body>

<%@include file="header.jsp" %>
<%Guest guest=(Guest)session.getAttribute("user");%>
<%if(guest==null){%>
<%request.setAttribute("loginError","Session expired!");%>
<%request.getRequestDispatcher("sign.jsp").forward(request,response);%>
<%}%>
<div class="bookings-container">
    <!-- Page Header -->
    <div class="page-header">
        <div class="page-badge"> MY STAYS </div>
        <h1>My <span>Bookings</span></h1>
        <div class="header-line"></div>
        <p class="header-subtitle">View and manage your reservations at Sapphire Palace</p>
    </div>
	<%BookingDAO bdao=new BookingDAOImpl();
	  PaymentDAO pdao=new PaymentDAOImpl();
	  List<Booking> guestBookings=bdao.getAllBookings().stream().filter(book->book.getGuestId()==guest.getGuestId()).collect(Collectors.toList());%>
	 	
	 
    <!-- Stats Cards -->
    <div class="stats-row">
        <div class="stat-card">
            
            <div class="stat-number"><%=guestBookings.size()%></div>
            <div class="stat-label">Total Bookings</div>
        </div>
    </div>

    <!-- Filter Tabs -->
    <div class="filter-tabs">
        <a href="myBookings.jsp?guestBooking=all" class="filter-btn active">All Bookings</a>
         <a href="myBookings.jsp?guestBooking=pending" class="filter-btn">Pending</a>
        <a href="myBookings.jsp?guestBooking=confirmed" class="filter-btn">Upcoming</a>
        <a href="myBookings.jsp?guestBooking=completed" class="filter-btn">Completed</a>
        <a href="myBookings.jsp?guestBooking=cancelled" class="filter-btn">Cancelled</a>
    </div>
    <%
String type = request.getParameter("guestBooking");

if (type == null || type.equalsIgnoreCase("ALL")) {
    // no filtering, keep all
} else if (type.equalsIgnoreCase("CANCELLED")) {
    guestBookings = guestBookings.stream()
        .filter(bookings -> bookings.getStatus().equalsIgnoreCase("CANCELLED"))
        .collect(Collectors.toList());
} else if (type.equalsIgnoreCase("CONFIRMED")) {
    guestBookings = guestBookings.stream()
        .filter(bookings -> bookings.getStatus().equalsIgnoreCase("CONFIRMED"))
        .collect(Collectors.toList());
} else if (type.equalsIgnoreCase("COMPLETED")) {
    guestBookings = guestBookings.stream()
        .filter(bookings -> bookings.getStatus().equalsIgnoreCase("COMPLETED"))
        .collect(Collectors.toList());
} else if (type.equalsIgnoreCase("PENDING")) {
    guestBookings = guestBookings.stream()
        .filter(bookings -> bookings.getStatus().equalsIgnoreCase("PENDING"))
        .collect(Collectors.toList());
}
%>


    <!-- Bookings List -->
    <div class="bookings-grid">
        
        <%for(Booking b:guestBookings){%>
        <!-- Booking Card 1 - Upcoming/Confirmed -->
        <div class="booking-card">
            <div class="card-header">
                <div>
                    <span class="booking-id">Booking ID: #SAP<%=b.getBookingId()%></span>
                    <span class="booking-date" style="margin-left: 15px;">Booked on: <%=b.getCheckIn()%></span>
                </div>
                <%if(b.getStatus().equalsIgnoreCase("COMPLETED")){%>
                <span class="status completed"><%=b.getStatus()%></span>
                <%}else if(b.getStatus().equalsIgnoreCase("CANCELLED")){%>
                <span class="status cancelled"><%=b.getStatus()%></span>
                <%}else if(b.getStatus().equalsIgnoreCase("CONFIRMED")){%>
                <span class="status confirmed"><%=b.getStatus()%></span>
                <%}else{%>
                <span class="status pending"><%=b.getStatus()%></span>
                <%}%>
            </div>
            
            <div class="card-body">
            <%ImageDAO idao=new ImageDAOImpl();%>
            <%Image i=idao.getImagesByRoomId(b.getRoomId()).get(0);%>
                <div class="room-image"><img alt="<%=i.getDescription()%>" src="<%=i.getFilePath()%>"> </div>
                <div class="booking-details">
                <%RoomsDAO rdao=new RoomsDAOImpl();%>
                <%Rooms r=rdao.getRoomById(b.getRoomId());%>
                
                    <h3 class="room-name"><%=r.getType()%></h3>
                   
                    <div class="date-info">
                        <div class="date-item"><strong> Check-in:</strong><%=b.getCheckIn() %></div>
                        <div class="date-item"><strong> Check-out:</strong><%=b.getCheckOut()%></div>
                        <%Integer nights=BookRoom.noOfNights(b.getCheckIn(), b.getCheckOut());%>
                        <div class="date-item"><strong> Duration:</strong> <%=nights%> Nights</div>
                    </div>
                </div>
                <div class="booking-amount">
                    <div class="amount">₹<%=r.getPrice()%></div>
                    <div class="per-night">Total for <%=nights %> nights</div>
                </div>
            </div>
            <div class="card-footer">
                <a href="payment?bookingId=<%=b.getBookingId()%>" class="btn-view"> View Details</a>
                <%if(b.getStatus().equalsIgnoreCase("PENDING")){%>
                <a href="cancelBooking.jsp" class="btn-cancel"> Cancel Booking</a>
                <%}%>
                <a href="payment?bookingId=<%=b.getBookingId()%>" class="btn-invoice"> Download Invoice</a>
            </div>
            
        </div>
<%}%>    
    </div>
</div>
<br><br>
 <%@include file="footer.jsp" %>
</body>
</html>