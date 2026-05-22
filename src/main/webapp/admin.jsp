<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.stream.Collector"%>
<%@page import="com.sapphirepalace.servlet.BookingServlet"%>
<%@page import="com.sapphirepalace.dto.Payment"%>
<%@page import="java.util.List"%>
<%@page import="com.sapphirepalace.dao.impl.PaymentDAOImpl"%>
<%@page import="com.sapphirepalace.dao.PaymentDAO"%>
<%@page import="com.sapphirepalace.dto.Booking"%>
<%@page import="java.util.Comparator"%>
<%@page import="com.sapphirepalace.dao.impl.BookingDAOImpl"%>
<%@page import="com.sapphirepalace.dao.impl.GuestDAOImpl"%>
<%@page import="com.sapphirepalace.dao.BookingDAO"%>
<%@page import="com.sapphirepalace.dao.GuestDAO"%>
<%@page import="com.sapphirepalace.dao.impl.RoomsDAOImpl"%>
<%@page import="com.sapphirepalace.dao.RoomsDAO"%>
<%@page import="com.sapphirepalace.dto.Rooms"%>
<%@page import="com.sapphirepalace.dto.Guest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Sapphire Palace</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Playfair+Display:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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

        /* Admin Container */
        .admin-container {
            display: flex;
            min-height: 100vh;
        }
        
        /* ==================== SIDEBAR ==================== */
        .sidebar {
            width: 280px;
            
           	background: linear-gradient(135deg, #FFFFFF 0%, #FFFFF4 50%, #F5E6C2 100%);
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            transition: all 0.3s ease;
            z-index: 100;
        }

        .sidebar-header {
            padding: 25px 20px;
            border-bottom: 1px solid rgba(212, 175, 55, 0.2);
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
			color:black;
            text-decoration: none;
        }

        .menu-item:hover {
            background:  #115eb6;;
            color: white;
        }

        .menu-item.active {
            background:  #115eb6;;
            color: white;
        }

        .menu-item i {
            width: 22px;
            font-size: 18px;
        }

		 
        /* ==================== MAIN CONTENT ==================== */
        .main-content {
            flex: 1;
            margin-left: 280px;
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
            background: #D4AF37;
            color: #0A192F;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            font-family: 'Inter', sans-serif;
        }

        .btn-primary:hover {
            background: #c4a137;
        }

        .btn-danger {
            background: #e74c3c;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;
        }

        .btn-success {
            background: #27ae60;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;
        }

        .btn-warning {
            background: #f39c12;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;
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

        .status.available {
            background: #d4edda;
            color: #155724;
        }

        .status.booked {
            background: #f8d7da;
            color: #721c24;
        }

        /* Forms */
        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #0A192F;
        }

        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-family: 'Inter', sans-serif;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        /* Modal */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }

        .modal.active {
            display: flex;
        }

        .modal-content {
            background: white;
            border-radius: 20px;
            padding: 30px;
            width: 90%;
            max-width: 500px;
            max-height: 90vh;
            overflow-y: auto;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .close-modal {
            font-size: 24px;
            cursor: pointer;
            color: #999;
        }

        /* Filter Select */
        .filter-select {
            padding: 8px 15px;
            border-radius: 8px;
            border: 1px solid #ddd;
            font-family: 'Inter', sans-serif;
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


<%Guest admin=(Guest)session.getAttribute("user");%>
<%if(admin==null){%>
	<%request.setAttribute("loginError","Session expired!");
	request.getRequestDispatcher("sign.jsp").forward(request,response);%>
<%}else{%>
<div class="admin-container">
   
    <aside class="sidebar">
        <div class="sidebar-header">
            <div class="sidebar-logo">
                <!-- Logo Image Space - Replace src with your logo path -->
                <img src="DCL/sp_hotel_logo.png" alt="Sapphire Palace Logo" class="sidebar-logo-img" onerror="this.style.display='none'">
                <div class="sidebar-logo-text">SAPPHIRE <span>PALACE</span></div>
            </div>
        </div>
        <nav class="sidebar-menu">
            <a href="admin.jsp" class="menu-item active" data-page="dashboard">
                <i class="fas fa-tachometer-alt"></i>
                <span>Dashboard</span>
            </a>
            <a href="rooms.jsp" class="menu-item" data-page="rooms">
                <i class="fas fa-bed"></i>
                <span>Manage Rooms</span>
            </a>
            <a href="booking.jsp" class="menu-item" data-page="bookings">
                <i class="fas fa-calendar-check"></i>
                <span>Bookings</span>
            </a>
       
            <a href="users.jsp" class="menu-item" data-page="users">
                <i class="fas fa-users"></i>
                <span>Users</span>
            </a>
            <a href="settings.jsp" class="menu-item" data-page="settings">
                <i class="fas fa-cog"></i>
                <span>Settings</span>
            </a>
     
            <a href="logout" class="menu-item">
                <i class="fas fa-sign-out-alt"></i>
                <span>Logout</span>
            </a>
        </nav>
    </aside>
    
   
    <main class="main-content">
        <!-- Top Bar -->
        <div class="top-bar">
            <h1 class="page-title" id="currentPageTitle">Dashboard</h1>
            <div class="admin-info">
                <span class="admin-name">Admin - </span>
                <div class="admin-avatar"><%=admin.getName().substring(0, 1) %></div>
            </div>
        </div>

        <%RoomsDAO rdao=new RoomsDAOImpl();
          BookingDAO bdao=new BookingDAOImpl();
          PaymentDAO pdao=new PaymentDAOImpl();
          GuestDAO gdao=new GuestDAOImpl();%>
        
        
        <div id="dashboardPanel" class="content-panel active">
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon"><i class="fas fa-bed"></i></div>
                    <div class="stat-title">Total Rooms</div>
                    <div class="stat-value"><%=rdao.getAllRooms().size()%></div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon"><i class="fas fa-calendar-check"></i></div>
                    <div class="stat-title">Total Bookings</div>
                    <div class="stat-value"><%=bdao.getAllBookings().size()%></div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon"><i class="fas fa-dollar-sign"></i></div>
                    <div class="stat-title">Monthly Revenue</div>
                    <%List<Payment> payments=pdao.getAllPayments();%>
                    <%Double amount=0.0;
                    for(Payment p:payments){%>
                    <%amount+=p.getAmount();%>
                    <%}%>
                    <div class="stat-value"><%=amount%></div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon"><i class="fas fa-users"></i></div>
                    <div class="stat-title">Total Users</div>
                    <div class="stat-value"><%=gdao.getAllGuests().size()%></div>
                </div>
            </div>

            
            <div style="background: white; border-radius: 16px; padding: 20px;">
                <h3 style="margin-bottom: 15px;">Recent Bookings</h3>
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
                            </tr>
                        </thead>
                        <tbody>
                        
                        <%List<Booking> bList=bdao.getAllBookings();
                        bList=bList.stream().sorted(Comparator.comparing(Booking::getCheckOut).reversed()).limit(5).collect(Collectors.toList());%>
                        <%for(Booking b:bList){%>
                            <tr>
                            <td>BK00<%=b.getBookingId()%></td>
                            <td><%=gdao.getGuestById(b.getGuestId()).getName()%></td>
                            <td><%=rdao.getRoomById(b.getRoomId()).getRoomNumber()%></td>
                            <td><%=b.getCheckIn()%></td>
                            <td><%=b.getCheckOut()%></td>
                            
                            <%String status=b.getStatus();
                        if(status.equals("CONFIRMED")){%>
                          <td><span class="status confirmed"><%=status%></span></td>
                        <%}else if(status.equals("COMPLETED")){%>
						  <td><span class="status completed"><%=status%></span></td>
						  <%}else if(status.equals("PENDING")){%>
						  <td><span class="status pending"><%=status%></span></td>
						  <%}else{%>
							  <td><span class="status cancelled"><%=status%></span></td>
						  <%}%>
                        <%}%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

       

        <!-- ==================== BOOKINGS MANAGEMENT PANEL ==================== -->
        

        <!-- ==================== REVENUE PANEL ==================== -->
        <div id="revenuePanel" class="content-panel">
            <div class="panel-header">
                <h2>Revenue Overview</h2>
                <select class="filter-select">
                    <option value="weekly">This Week</option>
                    <option value="monthly" selected>This Month</option>
                    <option value="yearly">This Year</option>
                </select>
            </div>
            
            <div class="stats-grid" style="margin-bottom: 30px;">
                <div class="stat-card">
                    <div class="stat-title">Total Revenue</div>
                    <div class="stat-value">₹4,25,000</div>
                </div>
                <div class="stat-card">
                    <div class="stat-title">Total Bookings</div>
                    <div class="stat-value">28</div>
                </div>
                <div class="stat-card">
                    <div class="stat-title">Avg. Booking Value</div>
                    <div class="stat-value">₹15,178</div>
                </div>
                <div class="stat-card">
                    <div class="stat-title">Occupancy Rate</div>
                    <div class="stat-value">68%</div>
                </div>
            </div>

            <div style="background: #f8f9fa; border-radius: 16px; padding: 20px;">
                <h3 style="margin-bottom: 15px;">Revenue Breakdown by Room</h3>
                <div class="data-table">
                    <table>
                        <thead>
                            <tr>
                                <th>Room Name</th>
                                <th>Room Type</th>
                                <th>Bookings</th>
                                <th>Revenue</th>
                                <th>Occupancy %</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr><td>Lagoon View</td><td>Deluxe</td><td>8</td><td>₹1,00,000</td><td>65%</td></tr>
                            <tr><td>Forest Bungalow</td><td>Suite</td><td>5</td><td>₹94,500</td><td>55%</td></tr>
                            <tr><td>Ocean Suite</td><td>Presidential</td><td>4</td><td>₹1,14,000</td><td>80%</td></tr>
                            <tr><td>Garden View</td><td>Standard</td><td>6</td><td>₹51,000</td><td>50%</td></tr>
                            <tr><td>Poolside Cabana</td><td>Deluxe</td><td>3</td><td>₹47,700</td><td>60%</td></tr>
                            <tr><td>Beachfront Villa</td><td>Villa</td><td>2</td><td>₹71,800</td><td>40%</td></tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- ==================== USERS PANEL ==================== -->
        <div id="usersPanel" class="content-panel">
            <div class="panel-header">
                <h2>Registered Users</h2>
            </div>
            <div class="data-table">
                <table>
                    <thead>
                        </table>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Bookings</th>
                            <th>Joined Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr><td>1</td><td>Rajesh Sharma</td><td>rajesh@example.com</td><td>9876543210</td><td>2</td><td>2025-01-15</td></tr>
                        <tr><td>2</td><td>Priya Patel</td><td>priya@example.com</td><td>9876543211</td><td>1</td><td>2025-02-20</td></tr>
                        <tr><td>3</td><td>Amit Kumar</td><td>amit@example.com</td><td>9876543212</td><td>3</td><td>2025-01-10</td></tr>
                        <tr><td>4</td><td>Neha Singh</td><td>neha@example.com</td><td>9876543213</td><td>1</td><td>2025-03-05</td></tr>
                        <tr><td>5</td><td>Vikram Malhotra</td><td>vikram@example.com</td><td>9876543214</td><td>2</td><td>2025-02-28</td></tr>
                        <tr><td>6</td><td>Sanjay Mehta</td><td>sanjay@example.com</td><td>9876543215</td><td>1</td><td>2025-03-10</td></tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- ==================== SETTINGS PANEL ==================== -->
        <div id="settingsPanel" class="content-panel">
            <h2>Settings</h2>
            <p style="color: #6b5e4a; margin-bottom: 20px;">Configure hotel settings, tax rates, check-in/out times, and more.</p>
            <div class="form-group">
                <label>Hotel Name</label>
                <input type="text" value="Sapphire Palace Goa">
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>Check-in Time</label>
                    <input type="time" value="14:00">
                </div>
                <div class="form-group">
                    <label>Check-out Time</label>
                    <input type="time" value="11:00">
                </div>
            </div>
            <div class="form-group">
                <label>Tax Rate (%)</label>
                <input type="number" value="18">
            </div>
            <button class="btn-primary">Save Settings</button>
        </div>
    </main>
</div>

<!-- ==================== ADD ROOM MODAL ==================== -->
<div id="addRoomModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>Add New Room</h3>
            <span class="close-modal" onclick="document.getElementById('addRoomModal').classList.remove('active')">&times;</span>
        </div>
        <form>
            <div class="form-group">
                <label>Room Name</label>
                <input type="text" placeholder="e.g., Ocean View Suite">
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>Room Type</label>
                    <select>
                        <option>Deluxe</option>
                        <option>Suite</option>
                        <option>Presidential</option>
                        <option>Standard</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Price per Night</label>
                    <input type="number" placeholder="Enter price">
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>Bed Type</label>
                    <select>
                        <option>King</option>
                        <option>Queen</option>
                        <option>Twin</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Max Guests</label>
                    <input type="number" value="2">
                </div>
            </div>
            <div class="form-group">
                <label>Description</label>
                <textarea rows="3" placeholder="Room description..."></textarea>
            </div>
            <div class="form-group">
                <label>Image URL</label>
                <input type="text" placeholder="Enter image URL">
            </div>
            <button type="submit" class="btn-primary" style="width: 100%;">Add Room</button>
        </form>
    </div>
</div>

<!-- ==================== UPDATE STATUS MODAL ==================== -->
<div id="updateStatusModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>Update Booking Status</h3>
            <span class="close-modal" onclick="document.getElementById('updateStatusModal').classList.remove('active')">&times;</span>
        </div>
        <form>
            <div class="form-group">
                <label>Booking ID</label>
                <input type="text" value="BK001" readonly>
            </div>
            <div class="form-group">
                <label>Booking Status</label>
                <select>
                    <option value="pending">Pending</option>
                    <option value="confirmed" selected>Confirmed</option>
                    <option value="completed">Completed</option>
                    <option value="cancelled">Cancelled</option>
                </select>
            </div>
            <button type="submit" class="btn-primary" style="width: 100%;">Update Status</button>
        </form>
    </div>
</div>

<%}%>

</body>
</html>