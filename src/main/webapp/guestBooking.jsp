<%@page import="com.sapphirepalace.dto.Guest"%>
<%@page import="com.sapphirepalace.dao.GuestDAO"%>
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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sapphire Palace | Our Rooms</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
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

        /* Rooms Section */
        .rooms-section {
            max-width: 1400px;
            margin: 0 auto;
            padding: 60px 24px;
        }

        /* Section Header */
        .section-header {
            text-align: center;
            margin-bottom: 50px;
        }

        .section-badge {
            display: inline-block;
            font-size: 12px;
            letter-spacing: 4px;
            text-transform: uppercase;
            color: #115eb6;
            font-weight: 600;
            margin-bottom: 15px;
            background: rgba(17, 94, 182, 0.1);
            padding: 5px 18px;
            border-radius: 30px;
        }

        .section-title {
            font-size: 42px;
           
            color: #1a2c3e;
            margin-bottom: 15px;
        }

        .section-title span {
            color: #115eb6;
        }

        .section-divider {
            width: 60px;
            height: 3px;
            background: #d4af37;
            margin: 15px auto;
        }

        .section-desc {
            color: #5a6e85;
            max-width: 650px;
            margin: 0 auto;
            font-size: 16px;
            line-height: 1.6;
        }

        /* Rooms Grid */
        .rooms-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
            gap: 30px;
        }

        /* Room Card */
        .room-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
        }

        .room-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }
      

.room-image {
    width: 100%;
    height: 100%;
    object-fit: cover;   /* ensures image fills without distortion */
    object-position: center; /* keeps image centered */
    display: block;
}


       
        .image-container {
            position: relative;
            height: 260px;
            overflow: hidden;
            background: #eef2f8;
        }


        /* Room Badge */
        .room-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background: #115eb6;
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            z-index: 10;
        }

        /* Room Content */
        .room-content {
            padding: 20px;
        }

        .room-name {
            font-size: 22px;
            
            color: #1a2c3e;
            margin-bottom: 8px;
            font-weight: 700;
        }

        .room-price {
            font-size: 24px;
            font-weight: 700;
            color: #115eb6;
            margin: 10px 0;
        }

        .room-price span {
            font-size: 14px;
            font-weight: normal;
            color: #5a6e85;
        }

        .room-description {
            color: #5a6e85;
            font-size: 14px;
            line-height: 1.5;
            margin-bottom: 15px;
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

        /* Room Features */
        .room-features {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
            margin: 15px 0;
            padding: 12px 0;
            border-top: 1px solid #eef2f8;
            border-bottom: 1px solid #eef2f8;
        }

        .feature {
            display: flex;
            align-items: center;
            gap: 5px;
            font-size: 12px;
            color: #5a6e85;
        }

        .feature .material-icons {
            font-size: 16px;
            color: #115eb6;
        }

        /* Amenities Tags */
        .room-amenities {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin: 12px 0;
        }

        .amenity-tag {
            background: #f0f4fa;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 11px;
            color: #1a2c3e;
        }

        /* Book Button */
        .book-btn {
            width: 100%;
            padding: 12px;
            background: #115eb6;
            color: white;
            border: none;
            border-radius: 40px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
        }

        .book-btn:hover {
            background: #0e4d92;
            transform: translateY(-2px);
        }

        /* Hidden form fields for date submission */
        .date-inputs-hidden {
            display: none;
        }

        /* Carousel Position Rules */
        #room1-img1:checked ~ .carousel-slides { transform: translateX(0%); }
        #room1-img2:checked ~ .carousel-slides { transform: translateX(-100%); }
        #room1-img3:checked ~ .carousel-slides { transform: translateX(-200%); }
        #room1-img4:checked ~ .carousel-slides { transform: translateX(-300%); }

        #room1-img1:checked ~ .carousel-dots label[for="room1-img1"],
        #room1-img2:checked ~ .carousel-dots label[for="room1-img2"],
        #room1-img3:checked ~ .carousel-dots label[for="room1-img3"],
        #room1-img4:checked ~ .carousel-dots label[for="room1-img4"] {
            background: #d4af37;
            transform: scale(1.2);
        }

        #room2-img1:checked ~ .carousel-slides { transform: translateX(0%); }
        #room2-img2:checked ~ .carousel-slides { transform: translateX(-100%); }
        #room2-img3:checked ~ .carousel-slides { transform: translateX(-200%); }

        #room2-img1:checked ~ .carousel-dots label[for="room2-img1"],
        #room2-img2:checked ~ .carousel-dots label[for="room2-img2"],
        #room2-img3:checked ~ .carousel-dots label[for="room2-img3"] {
            background: #d4af37;
            transform: scale(1.2);
        }

        #room3-img1:checked ~ .carousel-slides { transform: translateX(0%); }
        #room3-img2:checked ~ .carousel-slides { transform: translateX(-100%); }
        #room3-img3:checked ~ .carousel-slides { transform: translateX(-200%); }

        #room3-img1:checked ~ .carousel-dots label[for="room3-img1"],
        #room3-img2:checked ~ .carousel-dots label[for="room3-img2"],
        #room3-img3:checked ~ .carousel-dots label[for="room3-img3"] {
            background: #d4af37;
            transform: scale(1.2);
        }

        #room4-img1:checked ~ .carousel-slides { transform: translateX(0%); }
        #room4-img2:checked ~ .carousel-slides { transform: translateX(-100%); }

        #room4-img1:checked ~ .carousel-dots label[for="room4-img1"],
        #room4-img2:checked ~ .carousel-dots label[for="room4-img2"] {
            background: #d4af37;
            transform: scale(1.2);
        }

        #room5-img1:checked ~ .carousel-slides { transform: translateX(0%); }
        #room5-img2:checked ~ .carousel-slides { transform: translateX(-100%); }
        #room5-img3:checked ~ .carousel-slides { transform: translateX(-200%); }

        #room5-img1:checked ~ .carousel-dots label[for="room5-img1"],
        #room5-img2:checked ~ .carousel-dots label[for="room5-img2"],
        #room5-img3:checked ~ .carousel-dots label[for="room5-img3"] {
            background: #d4af37;
            transform: scale(1.2);
        }

        #room6-img1:checked ~ .carousel-slides { transform: translateX(0%); }
        #room6-img2:checked ~ .carousel-slides { transform: translateX(-100%); }
        #room6-img3:checked ~ .carousel-slides { transform: translateX(-200%); }
        #room6-img4:checked ~ .carousel-slides { transform: translateX(-300%); }

        #room6-img1:checked ~ .carousel-dots label[for="room6-img1"],
        #room6-img2:checked ~ .carousel-dots label[for="room6-img2"],
        #room6-img3:checked ~ .carousel-dots label[for="room6-img3"],
        #room6-img4:checked ~ .carousel-dots label[for="room6-img4"] {
            background: #d4af37;
            transform: scale(1.2);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .rooms-section {
                padding: 40px 20px;
            }
            .section-title {
                font-size: 32px;
            }
            .rooms-grid {
                grid-template-columns: 1fr;
            }
            .image-container {
                height: 220px;
            }
            .date-row {
                flex-direction: column;
                gap: 10px;
            }
        }
    </style>
</head>
<body>

<%@include file="header.jsp"%>

<section class="rooms-section">
    <div class="section-header">
        <span class="section-badge">LUXURY COLLECTION</span>
        <h2 class="section-title">Our <span>Exquisite Rooms</span></h2>
        <div class="section-divider"></div>
        <p class="section-desc">
            Experience unparalleled comfort and elegance in our thoughtfully designed rooms and suites
        </p>
    </div>

    <div class="rooms-grid">
        
        <%RoomsDAO rdao = new RoomsDAOImpl();
  ImageDAO idao = new ImageDAOImpl();
  List<Rooms> roomsList = rdao.getAllRooms();%>

<%for(Rooms r : roomsList){ 
    Image img = idao.getImagesByRoomId(r.getRoomId()).get(0); // just one image
%>


<div class="room-card">
    <div class="image-container">
        <img src="<%=img.getFilePath()%>" alt="<%=img.getDescription()%>" class="room-image" style="object-fit:cover;">
        <div class="room-badge"><%=r.getType()%></div>
    </div>

    <div class="room-content">
        <h3 class="room-name"><%=r.getType()%></h3>
        <div class="room-price">₹<%=r.getPrice()%> <span>/ per night</span></div>
        <p class="room-description"><%=r.getDescription()%></p>

        <!-- Booking Form -->
        <form class="booking-form" action="bookRoom" method="POST">
            <div class="date-picker-section">
                <div class="date-row">
                    <div class="date-field">
                        <label>CHECK-IN DATE</label>
                        <input type="date" name="checkIn" class="checkin-date" required>
                    </div>
                    <div class="date-field">
                        <label>CHECK-OUT DATE</label>
                        <input type="date" name="checkOut" class="checkout-date" required>
                    </div>
                </div>
                
            </div>

            <input type="hidden" name="roomId" value="<%=r.getRoomId()%>">
            <input type="hidden" name="roomName" value="<%=r.getType()%>">
            <input type="hidden" name="roomPrice" value="<%=r.getPrice()%>">

           
            <div class="room-features">
                <% String[] amenities = r.getAmenities().split(",");
                   for(String amenity : amenities){ %>
                    <span class="feature"><span class="material-icons">check_circle</span> <%=amenity.trim()%></span>
                <% } %>
            </div>

            

            <button type="submit" class="book-btn">Book Now →</button>
        </form>
    </div>
</div>
<%}%>

    </div>
</section>
<%@include file="footer.jsp" %>

</body>
</html>