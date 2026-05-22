<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.sapphirepalace.dto.Image"%>
<%@page import="com.sapphirepalace.dao.impl.ImageDAOImpl"%>
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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        body{
            font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
        }
        .logo-img {
        height: 100px;
        width: auto;
        transition: transform 0.3s ease;
    }

        .logo-img:hover {
        transform: scale(1.05);  /* Slight zoom on hover */
    }

     .navbar {
        display: flex;
        height:50px;
        justify-content: space-between;
        align-items: center;
        padding: 1rem 5%;
        background: linear-gradient(135deg, #FFFFFF 0%, #FFFFF4 50%, #F5E6C2 100%);
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        
    }


    .nav-links {
        display: flex;
        list-style: none;
        gap: 2rem;
        margin: 0;
        padding: 0;
    }

    .nav-links li a {
        text-decoration: none;
        color: #2c3a2b;
        font-weight: 500;
        transition: color 0.3s ease;
    }

    .nav-links li a:hover {
        color: #115eb6; 
    }

    .book-btn a {
        font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
        background-color: #115eb6;
        color: white;
        text-decoration:none;
        border: none;
        padding: 0.6rem 1.5rem;
        border-radius: 40px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .book-btn button:hover {
        background-color: #bdd9ef;
        color:#2c3a2b;
        transform: translateY(-2px);
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    }

    .hero {
    position: relative;
    height: 90vh;
    min-height: 600px;
    display: flex;
    align-items: center;
    justify-content: center;
    text-align: center;
    overflow: hidden;
}

/* Video Background */
.hero-video {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
     opacity: 0.8;
    z-index: 0;
}

/* Overlay - Creates the "half white" effect */
.hero-overlay {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: linear-gradient(
        135deg,
        rgba(255, 250, 243, 0.85) 0%,
        rgba(255, 250, 243, 0.7) 50%,
        rgba(42, 95, 92, 0.4) 100%
    );
    z-index: 1;
}

/* Content Container */
.hero-content {
    position: relative;
    z-index: 2;
    max-width: 800px;
    padding: 2rem;
    animation: fadeInUp 1s ease-out;
}

/* Subtitle */
.hero-subtitle {
    font-size: 0.9rem;
    text-transform: uppercase;
    letter-spacing: 3px;
    color: white;
    margin-bottom: 1rem;
    font-weight: 600;
}

.hero-img {
        height: 200px;
        width: auto;
        transition: transform 0.3s ease;
    }


/* Main Title */
.hero-title {

    font-size: 4.5rem;
    font-weight: 500;
    color: white;
    margin-top: 0.1rem;
    margin-bottom: 0.5rem;
    font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
    line-height: 1.2;
}

.hero-title span {
    color: white;
    font-weight: 600;
}

/* Divider Line */
.hero-divider {
    width: 60px;
    height: 2px;
    background: white;
    margin: 1.5rem auto;
}

/* Description */
.hero-description {
    font-size: 1.1rem;
    color: white;
    max-width: 600px;
    margin: 0 auto 2rem;
    line-height: 1.6;
}

/* Buttons Container */
.hero-buttons {
    display: flex;
    gap: 1rem;
    justify-content: center;
    flex-wrap: wrap;
}


.btn-primary {
    display: inline-block;
    padding: 0.9rem 2.2rem;
    background-color: #115eb6;
    color: white;
    text-decoration: none;
    border-radius: 40px;
    font-weight: 500;
    transition: all 0.3s ease;
    border: none;
    cursor: pointer;
}

.btn-primary:hover {
    background-color: #115eb6;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0,0,0,0.2);
}

/* Secondary Button */
.btn-secondary {
    display: inline-block;
    padding: 0.9rem 2.2rem;
    background: transparent;
    color: white;
    text-decoration: none;
    border-radius: 40px;
    font-weight: 500;
    border: 2px solid #115eb6;
    transition: all 0.3s ease;
    cursor: pointer;
}

.btn-secondary:hover {
    background-color: #115eb6;
    color: white;
    transform: translateY(-2px);
}

/* Scroll Indicator */
.scroll-indicator {
    position: absolute;
    bottom: 30px;
    left: 50%;
    transform: translateX(-50%);
    z-index: 2;
    cursor: pointer;
}

.scroll-wheel {
    width: 26px;
    height: 42px;
    border: 2px solid #115eb6;
    border-radius: 20px;
    position: relative;
}

.scroll-wheel::before {
    content: '';
    position: absolute;
    top: 8px;
    left: 50%;
    transform: translateX(-50%);
    width: 4px;
    height: 8px;
    background-color: #115eb6;
    border-radius: 2px;
    animation: scrollBounce 2s infinite;
}

 .rooms-section {
        padding: 80px 5%;
        background: linear-gradient(135deg, #FFFFFF 0%, #FFFFF4 50%, #F5E6C2 100%);
    }

    .rooms-container {
        max-width: 1400px;
        margin: 0 auto;
    }

    /* Section Header */
    .rooms-header {
        text-align: center;
        margin-bottom: 50px;
    }

    .section-badge {
        display: inline-block;
        font-size: 12px;
        letter-spacing: 1px;
        text-transform: uppercase;
        color: white;
        font-weight: 600;
        background: #115eb6;
        padding: 5px 15px;
        border-radius: 20px;
    }

    .section-title {
        font-size: 42px;
    }

    .section-title span {
        color: #115eb6;
    }

    .title-divider {
        color:black;
    }

    .section-desc {
        color: black;
        max-width: 650px;
        margin: 0 auto;
        font-size: 16px;
        line-height: 1.6;
    }

    /* Filter Tabs */
    .room-filters {
        display: flex;
        justify-content: center;
        flex-wrap: wrap;
        gap: 12px;
        margin-bottom: 40px;
    }

    .filter-btn {
        padding: 8px 24px;
        background: transparent;
        border: 2px solid #115eb6;
        color: #115eb6;
        border-radius: 40px;
        font-size: 14px;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .filter-btn:hover,
    .filter-btn.active {
        background: #115eb6;
        color: white;
    }

    /* Rooms Grid */
    .rooms-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
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

    /* Card Image */
    .card-image {
        position: relative;
        height: 260px;
        overflow: hidden;
    }

    .card-image img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.5s ease;
    }

    .room-card:hover .card-image img {
        transform: scale(1.05);
    }

    /* Price Badge */
    .price-badge {
        position: absolute;
        top: 15px;
        left: 15px;
        background: #115eb6;
        color: white;
        padding: 6px 14px;
        border-radius: 30px;
        font-size: 18px;
        font-weight: 700;
        backdrop-filter: blur(4px);
    }

    .price-badge span {
        font-size: 11px;
        font-weight: normal;
        margin-left: 3px;
    }

    /* Room Type Badge */
    .room-type {
        position: absolute;
        bottom: 15px;
        right: 15px;
        background: rgba(0, 0, 0, 0.6);
        backdrop-filter: blur(4px);
        color: white;
        padding: 4px 12px;
        border-radius: 20px;
        font-size: 11px;
        font-weight: 600;
        letter-spacing: 1px;
    }

    /* Card Body */
    .card-body {
        padding: 20px;
    }

    .room-title {
        font-size: 22px;
        color: #2c3a2b;
        margin-bottom: 8px;
    }

    .room-desc {
        color: #6b5e4a;
        font-size: 14px;
        line-height: 1.5;
        margin-bottom: 15px;
    }

    /* Room Features */
    .room-features {
        display: flex;
        flex-wrap: wrap;
        gap: 15px;
        margin-bottom: 15px;
        padding-bottom: 15px;
        border-bottom: 1px solid #eee;
    }

    .room-features span {
        font-size: 13px;
        color: #6b5e4a;
    }

    /* Room Amenities */
    .room-amenities {
        display: flex;
        flex-wrap: wrap;
        gap: 8px;
        margin-bottom: 20px;
    }

    .room-amenities span {
        background: #bdd9ef;
        padding: 4px 12px;
        border-radius: 20px;
        font-size: 11px;
        color: #2c3a2b;
    }

    /* Book Now Button */
    .book-now-btn {
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
    }

    .book-now-btn:hover {
        background: #bdd9ef;
        color:black;
        transform: translateY(-2px);
    }

    /* ==================== EXPERIENCES SECTION ==================== */
 /* ==================== EXPERIENCES SECTION ==================== */
      .experiences-section {
            padding: 80px 5%;
            background: #fefaf5;
        }

        .experiences-container {
            max-width: 1400px;
            margin: 0 auto;
        }

        /* Section Header */
        .exp-header {
            text-align: center;
            margin-bottom: 50px;
        }

        .exp-badge {
            display: inline-block;
            font-size: 12px;
            letter-spacing: 4px;
            text-transform: uppercase;
            color: #115eb6;
            font-weight: 600;
            margin-bottom: 15px;
            background: #bdd9ef;
            padding: 5px 18px;
            border-radius: 30px;
        }

        .exp-title {
            font-size: 42px;
            margin-bottom: 15px;
        }

        .exp-title span {
            color: #115eb6;

        }

        .exp-divider {
            width: 60px;
            height: 3px;
            background: #2a5f5c;
            margin: 15px auto;
        }

        .exp-desc {
          
            max-width: 650px;
            margin: 0 auto;
            font-size: 16px;
            line-height: 1.6;
        }

        /* Experiences Grid */
        .exp-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 25px;
            margin-bottom: 50px;
        }

        /* Experience Card */
        .exp-card {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .exp-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
        }

        /* Card Image */
        .exp-card-img {
            width: 100%;
            height: 220px;
            object-fit: cover;
        }

        /* Card Content */
        .exp-card-content {
            padding: 18px;
        }

        .exp-card-icon {
            font-size: 30px;
        }

        .exp-card-title {
            font-size: 18px;
            font-weight: 600;
        }

        .exp-card-desc {
            font-size: 13px;
            line-height: 1.5;
            margin-bottom: 12px;
        }

        .exp-card-features {
            display: flex;
            flex-wrap: wrap;
            gap: 6px;
            margin-bottom: 15px;
        }

        .exp-card-features span {
            background: #bdd9ef;
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 10px;
        }

        .exp-link {
            color: #115eb6;
            font-size: 13px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .exp-link:hover {
            gap: 8px;
        }

        /* CTA Button */
        .exp-cta {
            text-align: center;
        }

        .exp-cta-btn {
            display: inline-block;
            padding: 12px 32px;
            background: #115eb6;
            color: white;
            text-decoration: none;
            border-radius: 40px;
            font-weight: 600;
            transition: all 0.3s ease;
            border: 2px solid #115eb6;
        }

        .exp-cta-btn:hover {
            background: transparent;
            color: #115eb6;
        }

        /* Responsive */
        @media (max-width: 1200px) {
            .exp-grid {
                grid-template-columns: repeat(3, 1fr);
            }
        }

        @media (max-width: 900px) {
            .exp-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 600px) {
            .exp-grid {
                grid-template-columns: 1fr;
            }
            
            .exp-title {
                font-size: 32px;
            }
            
            .experiences-section {
                padding: 50px 20px;
            }
        }
/* ==================== PRINT STYLES ==================== */
@media print {
    .experiences-section {
        padding: 20px;
        background: white;
    }
    
    .exp-card {
        break-inside: avoid;
        page-break-inside: avoid;
        box-shadow: none;
        border: 1px solid #ddd;
    }
    
    .exp-overlay {
        display: none;
    }
    
    .exp-cta-btn {
        display: none;
    }
}



    /* Responsive */
    @media (max-width: 768px) {
        .rooms-section {
            padding: 50px 20px;
        }
        
        .section-title {
            font-size: 32px;
        }
        
        .rooms-grid {
            grid-template-columns: 1fr;
        }
        
        .room-filters {
            gap: 8px;
        }
        
        .filter-btn {
            padding: 6px 16px;
            font-size: 12px;
        }
    }

/* Animations */
@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(30px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

@keyframes scrollBounce {
    0% {
        opacity: 1;
        transform: translateX(-50%) translateY(0);
    }
    70% {
        opacity: 0.5;
        transform: translateX(-50%) translateY(15px);
    }
    100% {
        opacity: 1;
        transform: translateX(-50%) translateY(0);
    }
}
        /* Responsive */
        @media (max-width: 1200px) {
            .exp-grid {
                grid-template-columns: repeat(3, 1fr);
            }
        }

        @media (max-width: 900px) {
            .exp-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 600px) {
            .exp-grid {
                grid-template-columns: 1fr;
            }
            
            .exp-title {
                font-size: 32px;
            }
            
            .experiences-section {
                padding: 50px 20px;
            }
        }
/* ==================== PRINT STYLES ==================== */
@media print {
    .experiences-section {
        padding: 20px;
        background: white;
    }
    
    .exp-card {
        break-inside: avoid;
        page-break-inside: avoid;
        box-shadow: none;
        border: 1px solid #ddd;
    }
    
    .exp-overlay {
        display: none;
    }
    
    .exp-cta-btn {
        display: none;
    }
}

    /* Responsive */
    @media (max-width: 768px) {
        .rooms-section {
            padding: 50px 20px;
        }
        
        .section-title {
            font-size: 32px;
        }
        
        .rooms-grid {
            grid-template-columns: 1fr;
        }
        
        .room-filters {
            gap: 8px;
        }
        
        .filter-btn {
            padding: 6px 16px;
            font-size: 12px;
        }
    }

/* Animations */
@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(30px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

@keyframes scrollBounce {
    0% {
        opacity: 1;
        transform: translateX(-50%) translateY(0);
    }
    70% {
        opacity: 0.5;
        transform: translateX(-50%) translateY(15px);
    }
    100% {
        opacity: 1;
        transform: translateX(-50%) translateY(0);
    }
}


@keyframes scrollBounce {
    0% {
        opacity: 1;
        transform: translateX(-50%) translateY(0);
    }
    70% {
        opacity: 0.5;
        transform: translateX(-50%) translateY(15px);
    }
    100% {
        opacity: 1;
        transform: translateX(-50%) translateY(0);
    }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="logo">
            <img src="DCL/sp_hotel_logo-removebg-preview.png" alt="Sapphire Palace logo-img" class="logo-img">
        </div>
        <ul class="nav-links">
            <li><a href="#">Home</a></li>
            <li><a href="#">About Us</a></li>
            <li><a href="#">Rooms</a></li>
            <li><a href="#">Gallery</a></li>
            <li><a href="#">Restaurant</a></li>
            <li><a href="#">Contact Us</a></li>
        </ul>
         <div class="book-btn"><a href="sign.jsp">Book Now</a></div>
    </nav>
    <section class="hero">
         <video class="hero-video" autoplay muted loop>
            <source src="DCL/vecteezy_luxurious-hotel-lobby-with-chandeliers_47658476.mp4">
        </video>
        <div class="hero-content">
            <div class="hero-subtitle">Welcome to Paradise</div>
            <div><img src="DCL/sp_hotel_logo-removebg-preview.png" alt="Sapphire Palace logo-img" class="hero-img">
                <h1 class="hero-title">Sapphire Palace Hotel</h1></div>
            <div class="hero-divider"></div>
            <p class="hero-description">Where luxury meets the Arabian Sea — intimate elegance, soulful escapes, and unforgettable memories.</p>
            <div class="hero-buttons">
                <a href="sign.jsp" class="btn-primary">Discover More →</a>
                <a href="#" class="btn-secondary">View Rooms</a>
            </div>
            <div class="scroll-indicator"><div class="scroll-wheel"></div>
            </div>
           
        </div>

    </section>
    

        <!-- ==================== ROOMS SECTION ==================== -->
<section class="rooms-section">
    <div class="rooms-container">
        <!-- Section Header -->
        <div class="rooms-header">
            <span class="section-badge">Luxury Living</span>
            <h2 class="section-title">Our Exquisite Rooms</h2>
            <div class="title-divider"></div>
            <p class="section-desc">
                Experience unparalleled comfort and elegance in our thoughtfully designed accommodations
            </p>
        </div>

       

<!-- Rooms Grid - Cards Container -->
 <div class="rooms-grid" id="roomsGrid">
<%RoomsDAO rdao=new RoomsDAOImpl();
ImageDAO idao=new ImageDAOImpl();
List<Rooms> roomsList=rdao.getAllRooms();%>
<%List<Rooms> result =roomsList.stream()
                        		   .collect(Collectors.toMap(
                            		room -> room.getType().toLowerCase(),
                            		room -> room,
                            		(existing, replacement) -> existing,
                            		LinkedHashMap::new
                        ))
                        			.values()
                        			.stream()
                        			.toList();
                        %>
<%for(Rooms r:result){%>
        
            <!-- Room Card 1 -->
            <div class="room-card" data-category="<%=r.getType() %>">
                <div class="card-image">
                <%List<Image> imageList=idao.getImagesByRoomId(r.getRoomId());%>
                
                    <img src="<%=imageList.get(0).getFilePath()%>" alt="Lagoon View Room">
                    <div class="price-badge">₹<%=r.getPrice() %><span>/night</span></div>
                   
                </div>
                <div class="card-body">
                    <h3 class="room-title"><%=r.getType() %></h3>
                    <p class="room-desc"><%=r.getDescription() %></p>
                   
                   <%String amenities = r.getAmenities();
                   if(amenities!=null&&!amenities.isEmpty()){
                	   String[] arr=amenities.split(", ");
                	   %>
                	   
                	   
                    <div class="room-amenities">
                    <%for(String am:arr){ %>
                        <span><%=am%></span>
                        <%}%>
                    </div>
                    <%}%>
                    <button class="book-now-btn" onclick="bookRoom(1)">Book Now →</button>
                </div>
            </div>
             <%}%>
        </div>
       
    </div>
</section>

<section class="experiences-section">
    <div class="experiences-container">
        
        <!-- Header -->
        <div class="exp-header">
            <span class="exp-badge">MAKE MEMORIES</span>
            <h2 class="exp-title">Experiences at <span>Sapphire Palace</span></h2>

            <p class="exp-desc">
                Discover unforgettable moments crafted just for you — from wellness retreats to thrilling adventures
            </p>
        </div>

        <!-- Experiences Grid -->
        <div class="exp-grid">
            
            <!-- Card 1 - Spa -->
            <div class="exp-card">
                <img class="exp-card-img" src="https://images.pexels.com/photos/4504414/pexels-photo-4504414.jpeg?auto=compress&cs=tinysrgb&w=600" alt="Spa">
                <div class="exp-card-content">
                   
                    <h3 class="exp-card-title">Ayurveda Spa</h3>
                    <p class="exp-card-desc">Rejuvenating traditional therapies and massages by expert therapists.</p>
                    <div class="exp-card-features">
                        <span>Traditional</span>
                        <span>Aromatherapy</span>
                        <span>Detox</span>
                    </div>
                    <a href="#" class="exp-link">Learn More →</a>
                </div>
            </div>

            <!-- Card 2 - Dining -->
            <div class="exp-card">
                <img class="exp-card-img" src="https://images.pexels.com/photos/260922/pexels-photo-260922.jpeg?auto=compress&cs=tinysrgb&w=600" alt="Dining">
                <div class="exp-card-content">
                    
                    <h3 class="exp-card-title">Fine Dining</h3>
                    <p class="exp-card-desc">Exquisite Goan & international cuisine crafted by master chefs.</p>
                    <div class="exp-card-features">
                        <span>Seafood</span>
                        <span>Wine Pairing</span>
                        <span>Sunset Dinner</span>
                    </div>
                    <a href="#" class="exp-link">Learn More →</a>
                </div>
            </div>

            <!-- Card 3 - Water Sports -->
            <div class="exp-card">
                <img class="exp-card-img" src="https://tse4.mm.bing.net/th/id/OIP.W3jGKszoVKtdDYM69CDPrwHaEK?rs=1&pid=ImgDetMain&o=7&rm=3" alt="Water Sports">
                <div class="exp-card-content">
                   
                    <h3 class="exp-card-title">Water Adventures</h3>
                    <p class="exp-card-desc">Thrilling water sports including jet skiing, parasailing & scuba.</p>
                    <div class="exp-card-features">
                        <span>Scuba Diving</span>
                        <span>Jet Ski</span>
                        <span>Kayaking</span>
                    </div>
                    <a href="#" class="exp-link">Learn More →</a>
                </div>
            </div>

            <!-- Card 4 - Yoga -->
            <div class="exp-card">
                <img class="exp-card-img" src="https://images.pexels.com/photos/3823039/pexels-photo-3823039.jpeg?auto=compress&cs=tinysrgb&w=600" alt="Yoga">
                <div class="exp-card-content">
                   
                    <h3 class="exp-card-title">Sunrise Yoga</h3>
                    <p class="exp-card-desc">Beachfront yoga sessions with certified instructors.</p>
                    <div class="exp-card-features">
                        <span>Beachfront</span>
                        <span>Hatha Yoga</span>
                        <span>Meditation</span>
                    </div>
                    <a href="#" class="exp-link">Learn More →</a>
                </div>
            </div>

            <!-- Card 5 - Cultural Tour -->
            <div class="exp-card">
                <img class="exp-card-img" src="https://images.pexels.com/photos/1271619/pexels-photo-1271619.jpeg?auto=compress&cs=tinysrgb&w=600" alt="Heritage">
                <div class="exp-card-content">
                    
                    <h3 class="exp-card-title">Heritage Walk</h3>
                    <p class="exp-card-desc">Explore Goa's rich Portuguese heritage & spice plantations.</p>
                    <div class="exp-card-features">
                        <span>Old Churches</span>
                        <span>Spice Farm</span>
                        <span>Local Markets</span>
                    </div>
                    <a href="#" class="exp-link">Learn More →</a>
                </div>
            </div>

            <!-- Card 6 - Romantic -->
            <div class="exp-card">
                <img class="exp-card-img" src="https://lussostay.com/wp-content/uploads/2023/04/AdobeStock_576999848-scaled.jpeg" alt="Romantic">
                <div class="exp-card-content">
                    <h3 class="exp-card-title">Romantic Escape</h3>
                    <p class="exp-card-desc">Private beach dinners & couple spa treatments.</p>
                    <div class="exp-card-features">
                        <span>Sunset Dinner</span>
                        <span>Couple Spa</span>
                        <span>Private Cruise</span>
                    </div>
                    <a href="#" class="exp-link">Learn More →</a>
                </div>
            </div>

            <!-- Card 7 - Kids -->
            <div class="exp-card">
                <img class="exp-card-img" src="https://images.pexels.com/photos/3661352/pexels-photo-3661352.jpeg?auto=compress&cs=tinysrgb&w=600" alt="Kids">
                <div class="exp-card-content">
                    <h3 class="exp-card-title">Kids Club</h3>
                    <p class="exp-card-desc">Fun activities & games for our young guests.</p>
                    <div class="exp-card-features">
                        <span>Art & Craft</span>
                        <span>Treasure Hunt</span>
                        <span>Kids Pool</span>
                    </div>
                    <a href="#" class="exp-link">Learn More →</a>
                </div>
            </div>

            <!-- Card 8 - Cruise -->
            <div class="exp-card">
                <img class="exp-card-img" src="https://images.pexels.com/photos/1161089/pexels-photo-1161089.jpeg?auto=compress&cs=tinysrgb&w=600" alt="Cruise">
                <div class="exp-card-content">
                   
                    <h3 class="exp-card-title">Backwater Cruise</h3>
                    <p class="exp-card-desc">Serene houseboat experience through mangroves.</p>
                    <div class="exp-card-features">
                        <span>Houseboat</span>
                        <span>Dolphin Spotting</span>
                        <span>Sunset View</span>
                    </div>
                    <a href="#" class="exp-link">Learn More →</a>
                </div>
            </div>
        </div>
    </div>
</section>

<%@include file="footer.jsp"%>


</body>
</html>