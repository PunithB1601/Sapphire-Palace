<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="javax.swing.text.DateFormatter"%>
<%@page import="com.sapphirepalace.dto.Guest"%>
<%@page import="com.sapphirepalace.dto.Image"%>
<%@page import="com.sapphirepalace.dto.Rooms"%>
<%@page import="java.util.List"%>
<%@page import="com.sapphirepalace.dao.impl.ImageDAOImpl"%>
<%@page import="com.sapphirepalace.dao.ImageDAO"%>
<%@page import="com.sapphirepalace.dao.impl.RoomsDAOImpl"%>
<%@page import="com.sapphirepalace.dao.RoomsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>Zen Resort Goa | Luxury Rooms & Suites</title>
    <!-- Google Fonts + Material Icons (for consistent icon style) -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
             font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
            background: linear-gradient(135deg, #FFFFFF 0%, #FFFFF4 50%, #F5E6C2 100%);
            color: #1a2c3e;
            line-height: 1.4;
        }

        /* Main booking container */
        .booking-layout {
            max-width: 1400px;
            margin: 0 auto;
            padding: 32px 24px 60px;
            display: flex;
            flex-wrap: wrap;
            gap: 32px;
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

        /* LEFT COLUMN – ROOMS LISTING */
        .rooms-container {
            flex: 2;
            min-width: 280px;
        }

        /* ROOM CARD (with image placeholder) */
        .room-card {
            background: white;
            border-radius: 28px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.05);
            margin-bottom: 36px;
            overflow: hidden;
            transition: all 0.2s;
        }

        /* image row – you can replace src with your DB images */
        .room-image {
            width: 100%;
            height: 220px;
            object-fit: cover;
            display: block;
            background: linear-gradient(135deg, #FFFFFF 0%, #FFFFF4 50%, #F5E6C2 100%);
        }

        /* header area */
        .room-header {
            padding: 20px 24px 10px 24px;
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            flex-wrap: wrap;
            gap: 12px;
            border-bottom: 1px solid #ecf3fa;
        }
        .room-title h2 {
            font-size: 1.7rem;
            font-weight: 700;
            letter-spacing: -0.3px;
        }
        .room-badges {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            align-items: center;
        }
        
        /* features strip */
        .room-features {
            display: flex;
            flex-wrap: wrap;
            gap: 24px;
            padding: 14px 24px;
           
            border-bottom: 1px solid #eef2f8;
            font-size: 0.8rem;
        }
        .feature {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #115eb6;
        }
        .offer-strip {
            background: #fff7e8;
            padding: 8px 24px;
            font-size: 0.75rem;
            font-weight: 500;
            color: #b75f2a;
            display: flex;
            align-items: center;
            gap: 8px;
            border-bottom: 1px solid #115eb6;
        }

        /* rate options */
        .rate-options {
            padding: 4px 0 12px;
        }
        .rate-row {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            justify-content: space-between;
            padding: 18px 24px;
            border-bottom: 1px solid #eff3f9;
            transition: background 0.1s;
        }
        .rate-plan {
            flex: 2;
            min-width: 150px;
        }
        .meal-type {
            font-weight: 700;
            font-size: 1rem;
        }
        .guest-edit {
            font-size: 0.7rem;
            color: #115eb6;
            margin-top: 4px;
            display: flex;
            align-items: center;
            gap: 6px;
        }
        .edit-link {
            color: #2c7da0;
            text-decoration: none;
            border-bottom: 1px dashed;
        }
        .pricing-box {
            text-align: right;
            min-width: 160px;
        }
        .old-price {
            font-size: 0.8rem;
            text-decoration: line-through;
            color: black;
            display: block;
        }
        .current-price {
            font-size: 1.55rem;
            font-weight: 800;
            color: #115eb6;
            line-height: 1.2;
        }
        .price-note {
            font-size: 0.68rem;
            color: black;
            font-weight: 500;
        }
        .btn-select {
            background: #115eb6;
            border: none;
            padding: 8px 24px;
            border-radius: 40px;
            font-weight: 700;
            font-size: 0.8rem;
            color: white;
            cursor: pointer;
            transition: 0.15s;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        .btn-select:hover {
            background: #bdd9ef;
            color:black;
            transform: scale(0.97);
        }

        /* Steps indicator */
        .booking-steps {
            display: flex;
            justify-content: center;
            gap: 32px;
            margin: 32px 0 20px;
        }
        .step {
            font-size: 0.85rem;
            font-weight: 500;
            color: #115eb6;
            padding-bottom: 6px;
            border-bottom: 2px solid transparent;
        }
        .step.active {
            color: #115eb6;
            border-bottom-color: #d4af37;
        }

        /* RIGHT SIDEBAR – booking summary & contact */
        .booking-sidebar {
            flex: 1.2;
            min-width: 290px;
            background: white;
            border-radius: 32px;
            box-shadow: 0 18px 35px rgba(0, 0, 0, 0.06);
            padding: 28px 24px;
            height: fit-content;
            position: sticky;
            top: 30px;
        }
        .summary-title {
            font-size: 1.5rem;
            font-weight: 700;
            border-left: 4px solid #115eb6;
            padding-left: 14px;
            margin-bottom: 20px;
        }
        .summary-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            color:black;
            border-bottom: 1px solid #eef2fa;
        }
        .total-price {
            font-weight: 800;
            font-size: 1.6rem;
            color: black;
            margin-top: 10px;
        }
        .address-block {
            margin-top: 32px;
            padding-top: 18px;
            border-top: 1px solid black;
            font-size: 0.75rem;
            color: black;
        }
        .contact-line {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-top: 12px;
            font-size: 0.75rem;
        }
        hr {
            margin: 12px 0;
            border-color: black;
        }

        /* Responsive */
        @media (max-width: 950px) {
            .booking-layout {
                flex-direction: column;
            }
            .booking-sidebar {
                position: static;
            }
            .rate-row {
                flex-direction: column;
                align-items: flex-start;
                gap: 14px;
            }
            .pricing-box {
                text-align: left;
                width: 100%;
            }
        }
        @media (max-width: 550px) {
            .room-header {
                flex-direction: column;
            }
            .anniversary-banner ul {
                flex-direction: column;
                gap: 10px;
            }
            
            .date-row {
                flex-direction: column;
                gap: 10px;
            }
        }
        
        /* Date Picker Section */
        .date-picker-section {
            background: #f8fafc;
            padding: 15px;
            border-radius: 16px;
            margin: 15px 0;
            border: 1px solid #eef2f8;
        }

        .date-row {
            display: flex;
            gap: 12px;
            margin-bottom: 12px;
        }

        .date-row:last-child {
            margin-bottom: 0;
        }

        .date-field {
            flex: 1;
        }

        .date-field label {
            display: block;
            font-size: 11px;
            font-weight: 600;
            color: #115eb6;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 5px;
        }

        .date-field input {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #e0e8f0;
            border-radius: 12px;
            font-size: 13px;
            font-family: 'Inter', sans-serif;
            background: white;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .date-field input:focus {
            outline: none;
            border-color: #115eb6;
            box-shadow: 0 0 0 3px rgba(17, 94, 182, 0.1);
        }

        .nights-info {
            text-align: center;
            font-size: 12px;
            color: #5a6e85;
            margin-top: 10px;
            padding-top: 8px;
            border-top: 1px dashed #e0e8f0;
        }

        .nights-info strong {
            color: #115eb6;
        }
        
        
    </style>
</head>
<body>

<%Guest g=(Guest)session.getAttribute("user");%>
<%if(g!=null){%>
 <!-- Top Bar -->
        <div class="top-bar">
            <h1 class="page-title" id="currentPageTitle">Dashboard</h1>
            <div class="admin-info">
                <span class="admin-name"><%=g.getName() %> - </span>
                <div class="admin-avatar"><%=g.getName().substring(0, 1)%></div>
            </div>
        </div>
        
        
        
<div class="booking-layout">
    <!-- LEFT SIDE: ROOMS SECTION -->
    <div class="rooms-container">
       
     
<%RoomsDAO rdao=new RoomsDAOImpl();
  ImageDAO idao=new ImageDAOImpl();%>
<%List<Rooms> roomsList=rdao.getAllRooms();%>
        <!-- ROOM 1 – DELUXE ROOM (with image) -->
       <%for(Rooms r:roomsList){%>
        <div class="room-card">
            <%Image i=idao.getImagesByRoomId(r.getRoomId()).get(0);%>
            <img class="room-image" src="<%=i.getFilePath()%>" alt="<%=i.getDescription()%>" 
                 style="background:#cfdfe9; object-fit:cover;">
            <div class="room-header">
                <div class="room-title">
                    <h2><%=r.getType()%></h2>
                </div>
                
            </div>
            
            <div class="room-features">
            <%
            String[] amenities = r.getAmenities().split(",");
            for(String amenity : amenities) {
                String trimmed = amenity.trim();
                String icon = "circle"; // default icon
        	%>
            <span class="feature"><span class="material-icons"><%=icon%></span> <%=trimmed%></span>
        <%}%>
            </div>
            
            <form action="bookRoom" method="post">
            
            
            <div class="date-picker-section">
                    <div class="date-row">
                        <div class="date-field">
                            <label>CHECK-IN</label>
                            <input type="date" id="checkin2" name="checkIn" class="checkin-date">
                       	
                        </div>
                        <div class="date-field">
                            <label>CHECK-OUT</label>
                            <input type="date" id="checkout2" name="checkOut" class="checkout-date">
                       
                        </div>
                    </div>
                </div>
               
            
            <div class="rate-options">
                
                <div class="rate-row">
                    <div class="rate-plan">
                        <div class="meal-type"><%=r.getDescription()%></div>
                        
                        
                        
                    </div>
                    <div class="pricing-box">
                        <span class="old-price">₹ <%=r.getPrice()*1.5%></span>
                        <div class="current-price">₹ <%=r.getPrice()%></div>
                        <div class="price-note">Per night</div>
                    </div>
                    
                    
                    
                    <input type="hidden" name="price" value="<%=r.getPrice() %>">
                    
                    <input type="hidden" name="roomId" value="<%=r.getRoomId()%>">
                    <input type="hidden" name="guestId" value="<%=g.getGuestId()%>">
                    <button type="submit" class="btn-select">Select</button>
                    
                    
                </div>
                
            </div>
            </form>
        </div>
<%}%>
    </div>

    <!-- RIGHT SIDEBAR: Booking summary + address -->
    <aside class="booking-sidebar">
        <div class="summary-title">Booking Summary</div>
        <div class="summary-row"><span>Max Guests</span><span><strong>2</strong></span></div>
        <div class="summary-row"><span>Room Type</span><span><strong><%= %></strong></span></div>
        <div class="summary-row"><span>Number of Nights</span><span><strong>0</strong></span></div>
        <div class="summary-row"><span>Check-in :</span><span>—</span></div>
        <div class="summary-row"><span>Check-out :</span><span>—</span></div>
        <hr>
        <div class="summary-row" style="border-bottom: none;"><span>Total (Incl. Taxes)</span><span class="total-price">₹ 0.00</span></div>
        <div class="summary-row" style="border-bottom: none; padding-top:0;"><span style="font-size:0.7rem;">0 Room [s]</span></div>

        <!-- property contact & address from original source -->
        
    
    </aside>
</div>
<%}else{%>
	<% request.setAttribute("loginError","Session expired!");
		request.getRequestDispatcher("sign.jsp").forward(request,response);
	%>
<%}%>

</body>
</html>