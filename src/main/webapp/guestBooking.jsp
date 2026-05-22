<%@page import="com.sapphirepalace.dao.impl.ImageDAOImpl"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.sapphirepalace.dto.Image"%>
<%@page import="com.sapphirepalace.dao.ImageDAO"%>
<%@page import="com.sapphirepalace.dto.Rooms"%>
<%@page import="java.util.List"%>
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
    <!-- Google Fonts + Material Icons -->
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

        /* LEFT COLUMN – ROOMS LISTING */
        .rooms-container {
            flex: 2;
            min-width: 280px;
        }

        /* Anniversary Banner */
        .anniversary-banner {
            background: linear-gradient(115deg, #1b3b2b 0%, #2a5a3c 100%);
            color: #fef5e7;
            border-radius: 32px;
            padding: 20px 28px;
            margin-bottom: 32px;
            box-shadow: 0 12px 20px rgba(0, 0, 0, 0.08);
        }
        .anniversary-banner h3 {
            font-size: 1.4rem;
            font-weight: 700;
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            gap: 14px;
            margin-bottom: 8px;
        }
        .price-badge {
            background: #f7c35c;
            color: #1e3a2a;
            padding: 5px 18px;
            border-radius: 60px;
            font-size: 0.9rem;
            font-weight: 800;
        }
        .anniversary-banner ul {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-top: 16px;
            list-style: none;
        }
        .anniversary-banner li {
            font-size: 0.8rem;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .anniversary-banner .material-icons {
            font-size: 18px;
            color: #ffeaac;
        }

        /* ROOM CARD */
        .room-card {
            background: white;
            border-radius: 28px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.05);
            margin-bottom: 36px;
            overflow: hidden;
            transition: all 0.2s;
        }

        /* ==================== CAROUSEL STYLES ==================== */
        .carousel-container {
            position: relative;
            width: 100%;
            overflow: hidden;
            background: #eef2f8;
        }
        
        .carousel-slides {
            position: relative;
            width: 100%;
        }
        
        /* Hide radio buttons */
        .carousel-slides input[type="radio"] {
            display: none;
        }
        
        /* Slides wrapper */
        .slides-wrapper {
            display: flex;
            width: 100%;
            transition: transform 0.5s ease;
        }
        
        .slide {
            flex: 0 0 100%;
            width: 100%;
        }
        
        .slide img {
            width: 100%;
            height: 260px;
            object-fit: cover;
            display: block;
        }
        
        /* Radio button logic - move slides based on checked radio */
        #room1-img1:checked ~ .slides-wrapper {
            transform: translateX(0%);
        }
        #room1-img2:checked ~ .slides-wrapper {
            transform: translateX(-100%);
        }
        #room1-img3:checked ~ .slides-wrapper {
            transform: translateX(-200%);
        }
        #room1-img4:checked ~ .slides-wrapper {
            transform: translateX(-300%);
        }
        
        #room2-img1:checked ~ .slides-wrapper {
            transform: translateX(0%);
        }
        #room2-img2:checked ~ .slides-wrapper {
            transform: translateX(-100%);
        }
        #room2-img3:checked ~ .slides-wrapper {
            transform: translateX(-200%);
        }
        
        #room3-img1:checked ~ .slides-wrapper {
            transform: translateX(0%);
        }
        #room3-img2:checked ~ .slides-wrapper {
            transform: translateX(-100%);
        }
        #room3-img3:checked ~ .slides-wrapper {
            transform: translateX(-200%);
        }
        
        /* Navigation Dots */
        .carousel-dots {
            position: absolute;
            bottom: 15px;
            left: 0;
            right: 0;
            display: flex;
            justify-content: center;
            gap: 10px;
            z-index: 10;
        }
        
        .dot {
            width: 10px;
            height: 10px;
            background: rgba(255, 255, 255, 0.6);
            border-radius: 50%;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-block;
        }
        
        .dot:hover {
            background: rgba(255, 255, 255, 0.9);
        }
        
        /* Active dot styling - Room 1 */
        #room1-img1:checked ~ .carousel-dots label[for="room1-img1"],
        #room1-img2:checked ~ .carousel-dots label[for="room1-img2"],
        #room1-img3:checked ~ .carousel-dots label[for="room1-img3"],
        #room1-img4:checked ~ .carousel-dots label[for="room1-img4"] {
            background: #d4af37;
            transform: scale(1.3);
        }
        
        /* Active dot styling - Room 2 */
        #room2-img1:checked ~ .carousel-dots label[for="room2-img1"],
        #room2-img2:checked ~ .carousel-dots label[for="room2-img2"],
        #room2-img3:checked ~ .carousel-dots label[for="room2-img3"] {
            background: #d4af37;
            transform: scale(1.3);
        }
        
        /* Active dot styling - Room 3 */
        #room3-img1:checked ~ .carousel-dots label[for="room3-img1"],
        #room3-img2:checked ~ .carousel-dots label[for="room3-img2"],
        #room3-img3:checked ~ .carousel-dots label[for="room3-img3"] {
            background: #d4af37;
            transform: scale(1.3);
        }
        
        /* Navigation Arrows */
        .carousel-arrows {
            position: absolute;
            top: 50%;
            left: 0;
            right: 0;
            transform: translateY(-50%);
            pointer-events: none;
            z-index: 10;
        }
        
        .arrow {
            position: absolute;
            width: 36px;
            height: 36px;
            background: rgba(0, 0, 0, 0.5);
            color: white;
            text-align: center;
            line-height: 36px;
            font-size: 28px;
            font-weight: bold;
            border-radius: 50%;
            cursor: pointer;
            pointer-events: auto;
            transition: all 0.3s ease;
            text-decoration: none;
        }
        
        .arrow:hover {
            background: #d4af37;
            color: #1a2c3e;
        }
        
        .prev {
            left: 15px;
        }
        
        .next {
            right: 15px;
        }
        
        /* Show/hide arrows - Room 1 */
        .arrow-1 {
            display: none;
        }
        #room1-img1:checked ~ .carousel-arrows .arrow-1-prev1,
        #room1-img2:checked ~ .carousel-arrows .arrow-1-prev2,
        #room1-img3:checked ~ .carousel-arrows .arrow-1-prev3,
        #room1-img4:checked ~ .carousel-arrows .arrow-1-prev4,
        #room1-img1:checked ~ .carousel-arrows .arrow-1-next1,
        #room1-img2:checked ~ .carousel-arrows .arrow-1-next2,
        #room1-img3:checked ~ .carousel-arrows .arrow-1-next3,
        #room1-img4:checked ~ .carousel-arrows .arrow-1-next4 {
            display: block;
        }
        
        /* Show/hide arrows - Room 2 */
        .arrow-2 {
            display: none;
        }
        #room2-img1:checked ~ .carousel-arrows .arrow-2-prev1,
        #room2-img2:checked ~ .carousel-arrows .arrow-2-prev2,
        #room2-img3:checked ~ .carousel-arrows .arrow-2-prev3,
        #room2-img1:checked ~ .carousel-arrows .arrow-2-next1,
        #room2-img2:checked ~ .carousel-arrows .arrow-2-next2,
        #room2-img3:checked ~ .carousel-arrows .arrow-2-next3 {
            display: block;
        }
        
        /* Show/hide arrows - Room 3 */
        .arrow-3 {
            display: none;
        }
        #room3-img1:checked ~ .carousel-arrows .arrow-3-prev1,
        #room3-img2:checked ~ .carousel-arrows .arrow-3-prev2,
        #room3-img3:checked ~ .carousel-arrows .arrow-3-prev3,
        #room3-img1:checked ~ .carousel-arrows .arrow-3-next1,
        #room3-img2:checked ~ .carousel-arrows .arrow-3-next2,
        #room3-img3:checked ~ .carousel-arrows .arrow-3-next3 {
            display: block;
        }

        /* Room header area */
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
        .looking-badge {
            background: #eef3ff;
            border-radius: 40px;
            padding: 6px 14px;
            font-size: 0.75rem;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: #1f5680;
        }
        .nav-arrows {
            display: flex;
            gap: 6px;
        }
        .nav-arrows span {
            background: #f0f4fa;
            border-radius: 50%;
            width: 32px;
            height: 32px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            color: #577190;
            cursor: default;
        }
        .age-badge {
            background: #eef3ff;
            border-radius: 30px;
            padding: 2px 14px;
            font-weight: 600;
            font-size: 0.8rem;
        }

        /* features strip */
        .room-features {
            display: flex;
            flex-wrap: wrap;
            gap: 24px;
            padding: 14px 24px;
            background: #fefefe;
            border-bottom: 1px solid #eef2f8;
            font-size: 0.8rem;
        }
        .feature {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #2a4b6e;
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
            border-bottom: 1px solid #f1e7d4;
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
            color: #4f7ea0;
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
            color: #8b9eb5;
            display: block;
        }
        .current-price {
            font-size: 1.55rem;
            font-weight: 800;
            color: #22663e;
            line-height: 1.2;
        }
        .price-note {
            font-size: 0.68rem;
            color: #2d6a4f;
            font-weight: 500;
        }
        .btn-select {
            background: #d4af37;
            border: none;
            padding: 8px 24px;
            border-radius: 40px;
            font-weight: 700;
            font-size: 0.8rem;
            color: #1f2e3a;
            cursor: pointer;
            transition: 0.15s;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        .btn-select:hover {
            background: #c2a12e;
            transform: scale(0.97);
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
            max-width: 1400px;
            margin-left: auto;
            margin-right: auto;
            margin-top: 20px;
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
            color: #8193aa;
            padding-bottom: 6px;
            border-bottom: 2px solid transparent;
        }
        .step.active {
            color: #1c482f;
            border-bottom-color: #d4af37;
        }

        /* RIGHT SIDEBAR */
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
            border-left: 4px solid #d4af37;
            padding-left: 14px;
            margin-bottom: 20px;
        }
        .summary-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #eef2fa;
        }
        .total-price {
            font-weight: 800;
            font-size: 1.6rem;
            color: #2d6a4f;
            margin-top: 10px;
        }
        .address-block {
            margin-top: 32px;
            padding-top: 18px;
            border-top: 1px solid #e5ecf3;
            font-size: 0.75rem;
            color: #3e5a7c;
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
            border-color: #ecf3f9;
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
            .slide img {
                height: 200px;
            }
            .arrow {
                width: 30px;
                height: 30px;
                line-height: 30px;
                font-size: 22px;
            }
        }
    </style>
</head>
<body>

<!-- Top Bar -->
<div class="top-bar">
    <h1 class="page-title">Luxury Rooms</h1>
    <div class="admin-info">
        <span class="admin-name">Guest</span>
        <div class="admin-avatar">G</div>
    </div>
</div>

<div class="booking-layout">
    <!-- LEFT SIDE: ROOMS SECTION -->
    <div class="rooms-container">
        
        <!-- Anniversary Banner -->
        <div class="anniversary-banner">
            <h3>🎉 COME CELEBRATE OUR 10TH ANNIVERSARY WITH US 
                <span class="price-badge">STARTING AT JUST ₹2699/- PER NIGHT</span>
            </h3>
            <p style="font-size:0.75rem; margin-top: 4px;">(Minimum 3 Nights Stay*)</p>
            <ul>
                <li><span class="material-icons">breakfast_dining</span> Breakfast</li>
                <li><span class="material-icons">coffee</span> Daily High Tea</li>
                <li><span class="material-icons">pedal_bike</span> Free Activa Rental</li>
                <li><span class="material-icons">schedule</span> Early Check-in from 10 am</li>
                <li><span class="material-icons">access_time</span> Late Checkout till 2 Pm</li>
                <li><span class="material-icons">family_restroom</span> Kids up to 12 years stay Free</li>
            </ul>
        </div>



        <!-- ROOM 1 – DELUXE ROOM with Carousel -->
        <div class="room-card">
            <div class="carousel-container">
                <div class="carousel-slides">
                    <input type="radio" name="carousel1" id="room1-img1" checked>
                    <input type="radio" name="carousel1" id="room1-img2">
                    <input type="radio" name="carousel1" id="room1-img3">
                    <input type="radio" name="carousel1" id="room1-img4">
                    
                    <div class="slides-wrapper">
                        <div class="slide">
                            <img src="" alt="Deluxe Room Main View">
                        </div>
                    </div>
                  
                    
                    <div class="carousel-dots">
                        <label for="room1-img1" class="dot"></label>
                        <label for="room1-img2" class="dot"></label>
                        <label for="room1-img3" class="dot"></label>
                        <label for="room1-img4" class="dot"></label>
                    </div>
                    
                    <div class="carousel-arrows">
                        <label for="room1-img1" class="arrow prev arrow-1-prev1">‹</label>
                        <label for="room1-img2" class="arrow prev arrow-1-prev2">‹</label>
                        <label for="room1-img3" class="arrow prev arrow-1-prev3">‹</label>
                        <label for="room1-img4" class="arrow prev arrow-1-prev4">‹</label>
                        <label for="room1-img2" class="arrow next arrow-1-next1">›</label>
                        <label for="room1-img3" class="arrow next arrow-1-next2">›</label>
                        <label for="room1-img4" class="arrow next arrow-1-next3">›</label>
                        <label for="room1-img1" class="arrow next arrow-1-next4">›</label>
                    </div>
                </div>
            </div>

            <div class="room-header">
                <div class="room-title">
                    <h2></h2>
                </div>
                <div class="room-badges">
                    
                    <div class="nav-arrows">
                        <span class="material-icons">keyboard_arrow_left</span>
                        <span class="material-icons">keyboard_arrow_right</span>
                    </div>
                    <span class="age-badge">7+</span>
                </div>
            </div>
            <div class="room-features">
                <div class="feature"><span class="material-icons">bathtub</span> Bathroom amenities</div>
                <div class="feature"><span class="material-icons">supervisor_account</span> Max Occupancy : 4 Adults : 4 Children : 1</div>
                <div class="feature"><span class="material-icons">airline_seat_individual_suite</span> Bed Type : Double Bed - 1 ... More Details</div>
            </div>
            <div class="offer-strip">
                <span class="material-icons">new_releases</span> Applicable Offers : HOT DEAL + 3 More
            </div>
            <div class="rate-options">
                <div class="rate-row">
                    <div class="rate-plan">
                        <div class="meal-type">Room Only</div>
                        <div class="guest-edit">For 1 Adults | 0 Child <span class="edit-link">edit</span></div>
                    </div>
                    <div class="pricing-box">
                        <span class="old-price">₹ 7,099.05</span>
                        <div class="current-price">₹ 3,194.10</div>
                        <div class="price-note">Per night ( incl taxes )</div>
                        <div class="price-note">*Applied HOT DEAL</div>
                    </div>
                    <button class="btn-select">Select</button>
                </div>
                <div class="rate-row">
                    <div class="rate-plan">
                        <div class="meal-type">Breakfast</div>
                        <div class="guest-edit">For 1 Adults | 0 Child <span class="edit-link">edit</span></div>
                    </div>
                    <div class="pricing-box">
                        <span class="old-price">₹ 8,980.98</span>
                        <div class="current-price">₹ 3,596.25</div>
                        <div class="price-note">Per night ( incl taxes )</div>
                        <div class="price-note">*Applied HOT DEAL</div>
                    </div>
                    <button class="btn-select">Select</button>
                </div>
            </div>
        </div>
<%}%>
        <!-- ROOM 2 – FAMILY ROOM WITH BALCONY -->
        <div class="room-card">
            <div class="carousel-container">
                <div class="carousel-slides">
                    <input type="radio" name="carousel2" id="room2-img1" checked>
                    <input type="radio" name="carousel2" id="room2-img2">
                    <input type="radio" name="carousel2" id="room2-img3">
                    
                    <div class="slides-wrapper">
                        <div class="slide">
                            <img src="https://placehold.co/1200x600/D9E2EC/2F5A5A?text=Family+Room+Main" alt="Family Room Main">
                        </div>
                        <div class="slide">
                            <img src="https://placehold.co/1200x600/EDE2D4/5A4A2F?text=Family+Room+Living" alt="Family Room Living Area">
                        </div>
                        <div class="slide">
                            <img src="https://placehold.co/1200x600/D5F5E3/2C6E4C?text=Family+Room+Balcony" alt="Family Room Balcony">
                        </div>
                    </div>
                    
                    <div class="carousel-dots">
                        <label for="room2-img1" class="dot"></label>
                        <label for="room2-img2" class="dot"></label>
                        <label for="room2-img3" class="dot"></label>
                    </div>
                    
                    <div class="carousel-arrows">
                        <label for="room2-img1" class="arrow prev arrow-2-prev1">‹</label>
                        <label for="room2-img2" class="arrow prev arrow-2-prev2">‹</label>
                        <label for="room2-img3" class="arrow prev arrow-2-prev3">‹</label>
                        <label for="room2-img2" class="arrow next arrow-2-next1">›</label>
                        <label for="room2-img3" class="arrow next arrow-2-next2">›</label>
                        <label for="room2-img1" class="arrow next arrow-2-next3">›</label>
                    </div>
                </div>
            </div>

            <div class="room-header">
                <div class="room-title">
                    <h2>Family Room with Balcony</h2>
                </div>
                <div class="room-badges">
                    <span class="looking-badge"><span class="material-icons" style="font-size:16px">favorite</span> 9-10 People looking</span>
                    <div class="nav-arrows">
                        <span class="material-icons">keyboard_arrow_left</span>
                        <span class="material-icons">keyboard_arrow_right</span>
                    </div>
                    <span class="age-badge">7+</span>
                </div>
            </div>
            <div class="room-features">
                <div class="feature"><span class="material-icons">bathtub</span> Bathroom amenities</div>
                <div class="feature"><span class="material-icons">supervisor_account</span> Max Occupancy : 4 Adults : 4 Children : 2</div>
                <div class="feature"><span class="material-icons">airline_seat_individual_suite</span> Bed Type : Double Bed - 1 and Sofa Bed - 1 ... More Details</div>
            </div>
            <div class="offer-strip">
                <span class="material-icons">new_releases</span> Applicable Offers : HOT DEAL + 3 More
            </div>
            <div class="rate-options">
                <div class="rate-row">
                    <div class="rate-plan">
                        <div class="meal-type">Room Only</div>
                        <div class="guest-edit">For 1 Adults | 0 Child <span class="edit-link">edit</span></div>
                    </div>
                    <div class="pricing-box">
                        <span class="old-price">₹ 11,104.98</span>
                        <div class="current-price">₹ 4,446.75</div>
                        <div class="price-note">Per night ( incl taxes )</div>
                        <div class="price-note">*Applied HOT DEAL</div>
                    </div>
                    <button class="btn-select">Select</button>
                </div>
                <div class="rate-row">
                    <div class="rate-plan">
                        <div class="meal-type">Breakfast</div>
                        <div class="guest-edit">For 1 Adults | 0 Child <span class="edit-link">edit</span></div>
                    </div>
                    <div class="pricing-box">
                        <span class="old-price">₹ 12,107.98</span>
                        <div class="current-price">₹ 4,847.85</div>
                        <div class="price-note">Per night ( incl taxes )</div>
                        <div class="price-note">*Applied HOT DEAL</div>
                    </div>
                    <button class="btn-select">Select</button>
                </div>
            </div>
        </div>

        <!-- ROOM 3 – SUPERIOR SUITE -->
        <div class="room-card">
            <div class="carousel-container">
                <div class="carousel-slides">
                    <input type="radio" name="carousel3" id="room3-img1" checked>
                    <input type="radio" name="carousel3" id="room3-img2">
                    <input type="radio" name="carousel3" id="room3-img3">
                    
                    <div class="slides-wrapper">
                        <div class="slide">
                            <img src="https://placehold.co/1200x600/E8DCC6/4A3B2C?text=Premium+Suite+Main" alt="Superior Suite Main">
                        </div>
                        <div class="slide">
                            <img src="https://placehold.co/1200x600/F5E6D3/6E4C2C?text=Premium+Suite+Bedroom" alt="Superior Suite Bedroom">
                        </div>
                        <div class="slide">
                            <img src="https://placehold.co/1200x600/D5F5E3/2C6E4C?text=Premium+Suite+Terrace" alt="Superior Suite Terrace">
                        </div>
                    </div>
                    
                    <div class="carousel-dots">
                        <label for="room3-img1" class="dot"></label>
                        <label for="room3-img2" class="dot"></label>
                        <label for="room3-img3" class="dot"></label>
                    </div>
                    
                    <div class="carousel-arrows">
                        <label for="room3-img1" class="arrow prev arrow-3-prev1">‹</label>
                        <label for="room3-img2" class="arrow prev arrow-3-prev2">‹</label>
                        <label for="room3-img3" class="arrow prev arrow-3-prev3">‹</label>
                        <label for="room3-img2" class="arrow next arrow-3-next1">›</label>
                        <label for="room3-img3" class="arrow next arrow-3-next2">›</label>
                        <label for="room3-img1" class="arrow next arrow-3-next3">›</label>
                    </div>
                </div>
            </div>

            <div class="room-header">
                <div class="room-title">
                    <h2>Superior Suite (Ocean View)</h2>
                </div>
                <div class="room-badges">
                    <span class="looking-badge"><span class="material-icons">favorite</span> 5-6 People looking</span>
                    <div class="nav-arrows"><span class="material-icons">keyboard_arrow_left</span><span class="material-icons">keyboard_arrow_right</span></div>
                    <span class="age-badge">7+</span>
                </div>
            </div>
            <div class="room-features">
                <div class="feature"><span class="material-icons">bathtub</span> Premium bathroom</div>
                <div class="feature"><span class="material-icons">supervisor_account</span> Max Occupancy : 3 Adults : 2 Children</div>
                <div class="feature"><span class="material-icons">airline_seat_individual_suite</span> King Bed + Private Terrace</div>
            </div>
            <div class="offer-strip"><span class="material-icons">new_releases</span> HOT DEAL + Early Bird Offer</div>
            <div class="rate-options">
                <div class="rate-row">
                    <div class="rate-plan">
                        <div class="meal-type">Room Only</div>
                        <div class="guest-edit">For 2 Adults | 0 Child edit</div>
                    </div>
                    <div class="pricing-box">
                        <span class="old-price">₹ 12,450</span>
                        <div class="current-price">₹ 5,600</div>
                        <div class="price-note">Per night (incl taxes)</div>
                    </div>
                    <button class="btn-select">Select</button>
                </div>
                <div class="rate-row">
                    <div class="rate-plan">
                        <div class="meal-type">Breakfast + Spa</div>
                        <div class="guest-edit">For 2 Adults | 0 Child edit</div>
                    </div>
                    <div class="pricing-box">
                        <span class="old-price">₹ 14,800</span>
                        <div class="current-price">₹ 6,990</div>
                        <div class="price-note">Per night incl taxes</div>
                    </div>
                    <button class="btn-select">Select</button>
                </div>
            </div>
        </div>

        <!-- Booking Steps -->
        <div class="booking-steps">
            <div class="step active">1. Select Room</div>
            <div class="step">2. Guest Info</div>
            <div class="step">3. Secure Payment</div>
        </div>
    </div>

    <!-- RIGHT SIDEBAR: Booking Summary -->
    <aside class="booking-sidebar">
        <div class="summary-title">Booking Summary</div>
        <div class="summary-row"><span>Rooms</span><span><strong>0</strong></span></div>
        <div class="summary-row"><span>Total Guest</span><span><strong>0</strong></span></div>
        <div class="summary-row"><span>Add On</span><span><strong>0</strong></span></div>
        <div class="summary-row"><span>Check-in :</span><span>—</span></div>
        <div class="summary-row"><span>Check-out :</span><span>—</span></div>
        <hr>
        <div class="summary-row" style="border-bottom: none;"><span>Total (Incl. Taxes)</span><span class="total-price">₹ 0.00</span></div>
        <div class="summary-row" style="border-bottom: none; padding-top:0;"><span style="font-size:0.7rem;">0 Room [s]</span></div>

        <div class="address-block">
            <strong>Address</strong><br>
            H. NO. 1088, Escrea-Walddo, Opp. Novotel Shrems Hotel, Candolim, Goa, 403515, India
        </div>
        <div class="contact-line"><span class="material-icons" style="font-size:18px">phone</span> +91-7722098360</div>
        <div class="contact-line"><span class="material-icons" style="font-size:18px">email</span> info@zenseresort.com</div>
    </aside>
</div>

</body>
</html>