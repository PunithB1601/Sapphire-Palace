<%@page import="com.sapphirepalace.dto.Rooms"%>
<%@page import="com.sapphirepalace.dto.Guest"%>
<%@page import="com.sapphirepalace.dto.Booking"%>
<%@page import="com.sapphirepalace.dao.impl.BookingDAOImpl"%>
<%@page import="com.sapphirepalace.dao.BookingDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment - Sapphire Palace</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
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
            min-height: 100vh;
            padding: 40px 0;
        }

        .container {
            max-width: 1100px;
            margin: 0 auto;
            padding: 0 20px;
        }

        /* Header */
        .hotel-brand {
            text-align: center;
            margin-bottom: 30px;
        }

        .hotel-brand h2 {
            font-size: 28px;
            font-weight: 800;
            color: #1a2c3e;
            letter-spacing: -0.5px;
        }

        .hotel-brand h2 span {
            color: #115eb6;
        }

        /* Two Column Layout */
        .payment-layout {
            display: flex;
            gap: 30px;
            flex-wrap: wrap;
        }

        /* LEFT COLUMN */
        .payment-left {
            flex: 1.3;
            background: white;
            border-radius: 20px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            overflow: hidden;
        }

        /* Progress Steps */
        .progress-steps {
            display: flex;
            padding: 20px 25px;
            background: white;
            border-bottom: 1px solid #f0f0f0;
        }

        .step {
            flex: 1;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 13px;
            font-weight: 500;
            color: #bbb;
        }

        .step.active {
            color: #115eb6;
        }

        .step-number {
            width: 28px;
            height: 28px;
            background: #f0f0f0;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            font-weight: 600;
            color: #999;
        }

        .step.active .step-number {
            background: #115eb6;
            color: white;
            text-decoration: none;
        }

        .step-line {
            flex: 1;
            height: 1px;
            background: #e0e0e0;
            margin: 0 5px;
        }

        /* Payment Methods Header */
        .payment-methods-header {
            padding: 20px 25px;
            border-bottom: 1px solid #f0f0f0;
        }

        .payment-methods-header h3 {
            font-size: 18px;
            font-weight: 600;
            color: #1a2c3e;
        }

        /* Payment Tabs Container */
        .tabs-container {
            padding: 0 25px;
            margin-top: 15px;
        }

        .tab-buttons {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        .tab-btn {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 12px 20px;
            background: #f8f9fc;
            border: 1px solid #e8ecf0;
            border-radius: 50px;
            font-size: 14px;
            font-weight: 500;
            color: #5a6e85;
            cursor: pointer;
            transition: all 0.2s;
        }

        .tab-btn.active {
            background: #115eb6;
            border-color: #115eb6;
            color: white;
        }

        /* Payment Forms Container */
        .forms-container {
            padding: 25px;
        }

        .payment-form {
            display: none;
        }

        .payment-form.active {
            display: block;
        }

        /* Form Fields */
        .form-field {
            margin-bottom: 20px;
        }

        .form-field label {
            display: block;
            font-size: 12px;
            font-weight: 600;
            color: #2d3e50;
            margin-bottom: 6px;
        }

        .form-field input, .form-field select {
            width: 100%;
            padding: 14px 16px;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            font-size: 14px;
            font-family: 'Inter', sans-serif;
            background: white;
            transition: all 0.2s;
        }

        .form-field input:focus, .form-field select:focus {
            outline: none;
            border-color: #115eb6;
            box-shadow: 0 0 0 2px rgba(17, 94, 182, 0.1);
        }

        .card-row {
            display: flex;
            gap: 15px;
        }

        .card-row .form-field {
            flex: 1;
        }

        .card-icons-row {
            display: flex;
            gap: 8px;
            margin-top: 8px;
        }

        .card-icons-row span {
            font-size: 28px;
            opacity: 0.4;
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
        

        /* RIGHT COLUMN - Price Summary */
        .payment-right {
            flex: 0.9;
        }

        .price-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            overflow: hidden;
            position: sticky;
            top: 20px;
        }

        .price-header {
            background: linear-gradient(135deg, #115eb6 0%, #0a4a8c 100%);
            color: white;
            padding: 20px;
        }

        .price-header h4 {
            font-size: 14px;
            font-weight: 500;
            margin-bottom: 8px;
            opacity: 0.9;
        }

        .price-header .total-price {
            font-size: 32px;
            font-weight: 800;
        }

        .price-header .total-price small {
            font-size: 12px;
            font-weight: 400;
        }

        .price-details {
            padding: 20px;
        }

        .price-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            font-size: 14px;
            color: #4a627a;
            border-bottom: 1px solid #f0f4f8;
        }

        .price-row.total {
            font-weight: 700;
            font-size: 16px;
            color: #1a2c3e;
            border-bottom: none;
            margin-top: 5px;
            padding-top: 12px;
        }

        .price-row.total .amount {
            color: #115eb6;
            font-size: 18px;
        }

        .room-info-card {
            padding: 20px;
            background: #f8fafc;
            margin: 0 20px 20px 20px;
            border-radius: 16px;
        }

        .room-info-card h5 {
            font-size: 14px;
            font-weight: 600;
            color: #1a2c3e;
            margin-bottom: 8px;
        }

        .room-info-card p {
            font-size: 12px;
            color: #6c86a3;
            margin-bottom: 5px;
        }

        .room-info-card .room-rate {
            font-weight: 700;
            color: #115eb6;
            margin-top: 8px;
        }

        .pay-btn {
            width: calc(100% - 40px);
            margin: 0 20px 25px 20px;
            padding: 16px;
            background: #115eb6;
            border: none;
            border-radius: 50px;
            color: white;
            font-size: 16px;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            cursor: pointer;
            transition: all 0.2s;
        }

        .pay-btn:hover {
            background: #0a4a8c;
            transform: translateY(-2px);
        }

        .secure-footer {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
            padding: 15px 20px;
            border-top: 1px solid #f0f0f0;
            font-size: 11px;
            color: #8a9bb0;
        }

        /* Responsive */
        @media (max-width: 800px) {
            .payment-layout {
                flex-direction: column;
            }
            .card-row {
                flex-direction: column;
                gap: 0;
            }
            .progress-steps {
                flex-direction: column;
                gap: 10px;
            }
            .step-line {
                display: none;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <!-- Hotel Brand -->
    <div class="hotel-brand">
    <img src="DCL/logo-removebg-preview.png" alt="Sapphire Palace Logo" class="sidebar-logo-img" onerror="this.style.display='none'">
        <h2>SAPPHIRE<span> PALACE</span></h2>
    </div>

    <div class="payment-layout">
         <form action="payment" method="POST">
        <div class="payment-left">
            <div class="progress-steps">
                <div class="step">
                    <div class="step-number"><a href="guestBooking.jsp">1</a></div>
                    <span>Details</span>
                </div>
                <div class="step-line"></div>
                <div class="step active">
                    <div class="step-number"><a href="payment.jsp">2</a></div>
                    <span>Payment</span>
                </div>
                <div class="step-line"></div>
                <div class="step">
                    <div class="step-number">3</div>
                    <span>Confirmation</span>
                </div>
            </div>
		
            <!-- Payment Methods Header -->
            <div class="payment-methods-header">
                <h3>Select payment method</h3>
            </div>

            <!-- Payment Tabs -->
            <div class="tabs-container">
                <div class="tab-buttons">
                    <input type="button" value="CREDIT CARD" name="method" class="tab-btn active" data-tab="card">
                    <input type="button" value="DEBIT CARD" name="method" class="tab-btn" data-tab="card">
                    <input type="button" value="UPI" name="method" class="tab-btn" data-tab="upi">
                    <input type="button" value="CASH" name="method" class="tab-btn" data-tab="netbank">
                </div>
            </div>

            <!-- Payment Forms -->
            <div class="forms-container">
                <!-- Card Form -->
                <div class="payment-form active" id="form-card">
                    <div class="form-field">
                        <label>Card number</label>
                        <input type="text" placeholder="1234 5678 9012 3456">
                    </div>
                    <div class="card-row">
                        <div class="form-field">
                            <label>Expiry date</label>
                            <input type="text" placeholder="MM/YY">
                        </div>
                        <div class="form-field">
                            <label>CVV</label>
                            <input type="password" placeholder="123">
                        </div>
                    </div>
                    <div class="form-field">
                        <label>Cardholder name</label>
                        <input type="text" placeholder="Name on card">
                    </div>
                </div>

                <!-- UPI Form -->
                <div class="payment-form" id="form-upi">
                    <div class="form-field">
                        <label>UPI ID</label>
                        <input type="text" placeholder="username@okhdfcbank">
                    </div>
                    <div style="font-size: 12px; color: #6c86a3; margin-top: 10px;">
                        <span class="material-icons" style="font-size: 16px; vertical-align: middle;">info</span> You'll receive a payment request on your UPI app
                    </div>
                </div>
            </div>

            <!-- Secure Footer -->
            <div class="secure-footer">
                <span class="material-icons" style="font-size: 16px;">lock</span>
                Secure transaction
                <span>•</span>
                <span class="material-icons" style="font-size: 16px;">verified</span>
                SSL encrypted
            </div>
        </div>

<%Rooms r=(Rooms)request.getAttribute("room");%>
<%Integer nights=(Integer)request.getAttribute("nights"); %>
<%Double TotalPrice=nights*r.getPrice(); %>

        <!-- RIGHT SIDE - PRICE SUMMARY -->
        <div class="payment-right">
            <div class="price-card">
                <div class="price-header">
                    <h4>Your total price</h4>
                    <%=TotalPrice%>
                    <div class="total-price"><small>for <%=nights%> nights</small></div>
                </div>
                
                <div class="room-info-card">
                    <h5><%=r.getType()%></h5>
                    
                    <div class="room-rate">₹<%=r.getPrice()%> / night</div>
                </div>

                <div class="price-details">
                    <div class="price-row">
                        <span>Room charges (<%=nights%> nights)</span>
                        <span>₹<%=TotalPrice%></span>
                    </div>
                    <div class="price-row">
                        <span>Taxes & fees (18% GST)</span>
                        <%Double tax=TotalPrice*0.18;%>
                        <span>₹<%=tax%></span>
                    </div>
                  
                    <div class="price-row total">
                        <span>Total</span>
                        <%Double finalPrice=TotalPrice+tax;%>
                        <span class="amount">₹<%=finalPrice%></span>
                    </div>
                </div>
                <%Booking b=(Booking)request.getAttribute("booking");%>
                
				<input type="hidden" name="bookingId" value="<%=b.getBookingId()%>">
				<input type="hidden" name="totalPrice" value="<%=TotalPrice%>">
				<input type="hidden" name="tax" value="<%=tax%>">
				<input type="hidden" name="finalPrice" value="<%=finalPrice%>">
                <button class="pay-btn" type="submit">
                    <span class="material-icons">lock</span> Pay ₹<%=finalPrice%>
                </button>
            </div>
        </div>
        </form>
    </div>
</div>

<!-- Simple CSS-only tab switching using JavaScript (minimal, only for tab functionality) -->
<script>
    // This is the ONLY JavaScript - just for tab switching functionality
    // No payment logic, no validation, just UI tab switching
    const tabBtns = document.querySelectorAll('.tab-btn');
    const forms = {
        card: document.getElementById('form-card'),
        upi: document.getElementById('form-upi'),
        netbank: document.getElementById('form-netbank')
    };

    tabBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            // Remove active class from all buttons
            tabBtns.forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            
            // Hide all forms
            Object.values(forms).forEach(form => {
                if (form) form.classList.remove('active');
            });
            
            // Show selected form
            const tabId = btn.getAttribute('data-tab');
            if (forms[tabId]) {
                forms[tabId].classList.add('active');
            }
        });
    });
</script>
<br>
<%@include file="footer.jsp" %>
</body>
</html>