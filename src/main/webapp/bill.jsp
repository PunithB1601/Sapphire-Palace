<%@page import="com.sapphirepalace.servlet.BookRoom"%>
<%@page import="java.time.Period"%>
<%@page import="com.sapphirepalace.dto.Payment"%>
<%@page import="com.sapphirepalace.dto.Rooms"%>
<%@page import="com.sapphirepalace.dto.Booking"%>
<%@page import="com.sapphirepalace.dto.Guest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Invoice - Sapphire Palace</title>
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
            padding: 50px 20px;
        }

        /* Invoice Container */
        .invoice-container {
            max-width: 1000px;
            margin: 0 auto;
        }

        /* Invoice Card */
        .invoice-card {
            background: white;
            border-radius: 28px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }

        /* Header Section */
        .invoice-header {
            background: linear-gradient(135deg, #115eb6 0%, #0a4a8c 100%);
            padding: 30px 35px;
            color: white;
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 20px;
        }

        .hotel-info h2 {
            font-size: 28px;
            font-weight: 800;
            letter-spacing: -0.5px;
            margin-bottom: 5px;
        }

        .hotel-info p {
            font-size: 13px;
            opacity: 0.85;
            margin-top: 5px;
        }

        .invoice-title {
            text-align: right;
        }

        .invoice-title h3 {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .invoice-title p {
            font-size: 12px;
            opacity: 0.85;
        }

        .invoice-id {
            background: rgba(255, 255, 255, 0.2);
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            display: inline-block;
            margin-top: 8px;
        }

        /* Content Section */
        .invoice-content {
            padding: 35px;
        }

        /* Guest & Booking Details Row */
        .details-row {
            display: flex;
            gap: 30px;
            flex-wrap: wrap;
            margin-bottom: 30px;
            padding-bottom: 25px;
            border-bottom: 1px solid #eef2f8;
        }

        .details-col {
            flex: 1;
            min-width: 200px;
        }

        .details-col h4 {
            font-size: 14px;
            font-weight: 600;
            color: #115eb6;
            margin-bottom: 12px;
            letter-spacing: 0.5px;
        }

        .details-col p {
            font-size: 14px;
            color: #4a627a;
            margin-bottom: 6px;
        }

        .details-col strong {
            color: #1a2c3e;
        }

        /* Room Details Card */
        .room-details-card {
            background: #f8fafc;
            border-radius: 20px;
            padding: 20px;
            margin-bottom: 30px;
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
            align-items: center;
        }

        .room-icon {
            width: 70px;
            height: 70px;
            background: #e8f0fe;
            border-radius: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 35px;
        }

        .room-info-detail {
            flex: 2;
        }

        .room-info-detail h4 {
            font-size: 18px;
            font-weight: 700;
            color: #1a2c3e;
            margin-bottom: 6px;
        }

        .room-info-detail p {
            font-size: 13px;
            color: #6c86a3;
            margin-bottom: 4px;
        }

        .room-price-detail {
            text-align: right;
        }

        .room-price-detail .rate {
            font-size: 22px;
            font-weight: 800;
            color: #115eb6;
        }

        .room-price-detail .per-night {
            font-size: 12px;
            color: #6c86a3;
        }

        /* Price Breakdown Table */
        .price-table {
            width: 100%;
            margin-bottom: 30px;
            border-collapse: collapse;
        }

        .price-table tr {
            border-bottom: 1px solid #eef2f8;
        }

        .price-table td {
            padding: 12px 0;
            font-size: 14px;
        }

        .price-table td:last-child {
            text-align: right;
            font-weight: 600;
        }

        .price-table tr:last-child {
            border-bottom: none;
        }

        .total-row {
            background: #f8fafc;
            margin-top: 10px;
        }

        .total-row td {
            font-size: 18px;
            font-weight: 800;
            color: #1a2c3e;
            padding: 15px 0;
        }

        .total-row td:last-child {
            color: #115eb6;
        }

        /* Payment Status */
        .payment-status {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px 20px;
            background: #e8f5e9;
            border-radius: 16px;
            margin-bottom: 30px;
        }

        .payment-status.success {
            background: #e8f5e9;
        }

        .payment-status .status-icon {
            width: 45px;
            height: 45px;
            background: #27ae60;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
        }

        .payment-status .status-text h4 {
            font-size: 16px;
            font-weight: 700;
            color: #27ae60;
        }

        .payment-status .status-text p {
            font-size: 12px;
            color: #5a6e85;
        }

        /* Footer Buttons */
        .invoice-footer {
            display: flex;
            gap: 15px;
            justify-content: flex-end;
            flex-wrap: wrap;
            padding-top: 20px;
            border-top: 1px solid #eef2f8;
        }

        .btn-print {
            padding: 12px 28px;
            background: #115eb6;
            color: white;
            border: none;
            border-radius: 40px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.2s;
        }

        .btn-print:hover {
            background: #0a4a8c;
            transform: translateY(-2px);
        }

        .btn-download {
            padding: 12px 28px;
            background: transparent;
            color: #115eb6;
            border: 2px solid #115eb6;
            border-radius: 40px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.2s;
        }

        .btn-download:hover {
            background: rgba(17, 94, 182, 0.05);
            transform: translateY(-2px);
        }

        .btn-home {
            padding: 12px 28px;
            background: #f0f4fa;
            color: #1a2c3e;
            border: none;
            border-radius: 40px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.2s;
        }

        .btn-home:hover {
            background: #e2e8f0;
            transform: translateY(-2px);
        }

        /* Thank You Section */
        .thankyou-section {
            text-align: center;
            padding: 25px 35px;
            background: #f8fafc;
            border-top: 1px solid #eef2f8;
        }

        .thankyou-section p {
            font-size: 14px;
            color: #6c86a3;
        }

        .thankyou-section strong {
            color: #115eb6;
        }

        /* Responsive */
        @media (max-width: 700px) {
            .invoice-header {
                flex-direction: column;
                text-align: center;
            }
            .invoice-title {
                text-align: center;
            }
            .room-details-card {
                flex-direction: column;
                text-align: center;
            }
            .room-price-detail {
                text-align: center;
            }
            .invoice-footer {
                justify-content: center;
            }
        }
    </style>
</head>
<body>
<%Guest user=(Guest)session.getAttribute("user"); %>
<%Booking b=(Booking)request.getAttribute("booking");%>
<%Rooms r=(Rooms)request.getAttribute("room");%>
<%Payment p=(Payment)request.getAttribute("payment"); %>
<div class="invoice-container">
    <div class="invoice-card">
        <!-- Header -->
        <div class="invoice-header">
            <div class="hotel-info">
                <h2>SAPPHIRE<span style="font-weight:400;"> PALACE</span></h2>
                <p>Cola Beach, South Goa, India - 403702</p>
                <p> +91 832 123 4567 |  hello@sapphirepalace.com</p>
            </div>
            <div class="invoice-title">
                <h3>BILL INVOICE</h3>
                <p>Booking Confirmation</p>
                <div class="invoice-id">INV-<%=p.getPaymentId()%></div>
            </div>
        </div>

        <!-- Content -->
        <div class="invoice-content">
            <!-- Guest & Booking Details -->
            <div class="details-row">
                <div class="details-col">
                    <h4>GUEST DETAILS</h4>
                    <p><strong>Name:</strong> <%=user.getName().toUpperCase()%></p>
                    <p><strong>Email:</strong> <%=user.getEmail()%></p>
                    <p><strong>Phone:</strong> <%=user.getPhone()%></p>
                </div>
                <div class="details-col">
                    <h4>BOOKING DETAILS</h4>
                    <p><strong>Booking ID:</strong> #SAP<%=b.getBookingId()%></p>
                    <p><strong>Booking Date:</strong><%=b.getCheckIn()%></p>
                    <p><strong>Payment Status:</strong> <span style="color: #27ae60;"> Paid</span></p>
                </div>
                <div class="details-col">
                    <h4>STAY PERIOD</h4>
                    <p><strong>Check-in:</strong> <%=b.getCheckIn()%></p>
                    <p><strong>Check-out:</strong> <%=b.getCheckOut() %></p>
                    <%Integer nights=BookRoom.noOfNights(b.getCheckIn(), b.getCheckOut());%>
                    <p><strong>Duration:</strong> <%=nights%> nights, <%=nights+1%> days </p>
                </div>
            </div>

            
            <div class="room-details-card">
                <div class="room-icon"></div>
                <div class="room-info-detail">
                    <h4><%=r.getType()%></h4>
           
                </div>
                <div class="room-price-detail">
                    <div class="rate"><%=r.getPrice()%></div>
                    <div class="per-night">per night</div>
                </div>
            </div>

            <!-- Price Breakdown -->
            <table class="price-table">
                <tr>
                    <td>Room Charges (<%=nights%> nights)</td>
                    <%Double total=r.getPrice()*nights;%>
                    <td>₹<%=total%></td>
                </tr>
                <tr>
                    <td>GST 18%</td>
                    <%Double gst=total*0.18; %>
                    <td>₹<%=gst%></td>
                </tr>
                
                <tr class="total-row">
                    <td><strong>Total Amount</strong></td>
                    <td><strong>₹<%=total+gst%></strong></td>
                </tr>
            </table>

            <!-- Payment Status -->
            <div class="payment-status success">
                <div class="status-icon">
                    <span class="material-icons">check</span>
                </div>
                <div class="status-text">
                    <h4><%=request.getAttribute("success")%></h4>
                    <p>Transaction ID: TXN_<%=p.getPaymentId()%> | Paid via <%=p.getMethod()%></p>
                </div>
            </div>

            <!-- Terms & Policies -->
            <div style="margin-bottom: 25px;">
                <h4 style="font-size: 14px; font-weight: 600; color: #1a2c3e; margin-bottom: 10px;">Terms & Policies</h4>
                <ul style="font-size: 12px; color: #6c86a3; margin-left: 20px; line-height: 1.6;">
                    <li>Check-in time: 2:00 PM | Check-out time: 11:00 AM</li>
                    <li>Free cancellation up to 7 days before check-in</li>
                    <li>Government ID proof required for all guests</li>
                    <li>Unmarried couples allowed with valid ID proof</li>
                </ul>
            </div>

            <!-- Footer Buttons -->
            <div class="invoice-footer">
                <a href="index.jsp" class="btn-home">
                    <span class="material-icons">home</span> Back to Home
                </a>
                <a href="#" class="btn-download" onclick="window.print(); return false;">
                    <span class="material-icons">download</span> Download PDF
                </a>
                <a href="#" class="btn-print" onclick="window.print(); return false;">
                    <span class="material-icons">print</span> Print Invoice
                </a>
            </div>
        </div>

        <!-- Thank You -->
        <div class="thankyou-section">
            <p>Thank you for choosing <strong>Sapphire Palace</strong>!</p>
            <p style="font-size: 12px; margin-top: 8px;">We look forward to welcoming you. For any assistance, contact us at +91 832 123 4567</p>
        </div>
    </div>
</div>

</body>
</html>