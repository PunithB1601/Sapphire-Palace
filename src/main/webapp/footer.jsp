<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.footer {
            background: #0A192F;
            color: #ffffff;
            position: relative;
            overflow: hidden;
        }

        /* Decorative Elements */
        .footer::before {
            content: '✦';
            position: absolute;
            top: 50px;
            right: 50px;
            font-size: 150px;
            color: rgba(212, 175, 55, 0.03);
            font-family: serif;
            pointer-events: none;
        }

        .footer::after {
            content: '✧';
            position: absolute;
            bottom: 50px;
            left: 50px;
            font-size: 120px;
            color: rgba(212, 175, 55, 0.03);
            font-family: serif;
            pointer-events: none;
        }

        .footer-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 60px 5% 30px;
            position: relative;
            z-index: 2;
        }

        /* Footer Top Section */
        .footer-top {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 40px;
            margin-bottom: 50px;
            border-bottom: 1px solid rgba(212, 175, 55, 0.2);
            padding-bottom: 50px;
        }

        /* Brand Column */
        .footer-brand {
            grid-column: span 1;
        }

        .footer-logo {
            font-size: 28px;
            font-weight: 700;
            color: #ffffff;
            margin-bottom: 15px;
        }

        .footer-logo span {
            color: #115eb6;
        }

        .footer-tagline {
            color: white;
            font-size: 14px;
            line-height: 1.6;
            margin-bottom: 20px;
        }

        .footer-social {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }

        
        /* Footer Columns */
        .footer-col {
            grid-column: span 1;
        }

        .footer-col h4 {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 20px;
            color: white;
            position: relative;
            display: inline-block;
        }

        .footer-col h4::after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 0;
            width: 40px;
            height: 2px;
            background: #bdd9ef;
        }

        .footer-links {
            list-style: none;
            margin-top: 20px;
        }

        .footer-links li {
            margin-bottom: 12px;
        }

        .footer-links a {
            color: #bdd9ef;
            text-decoration: none;
            font-size: 14px;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .footer-links a:hover {
            color: #bdd9ef;
            transform: translateX(5px);
        }

        /* Contact Info */
        .contact-info {
            list-style: none;
            margin-top: 20px;
        }

        .contact-info li {
            display: flex;
            align-items: flex-start;
            gap: 12px;
            margin-bottom: 15px;
            color: #bdd9ef;
            font-size: 14px;
            line-height: 1.5;
        }

        .contact-info li span:first-child {
            color: #D4AF37;
            font-size: 18px;
            min-width: 25px;
        }

        /* Newsletter */
        .newsletter-text {
            color: #bdd9ef;
            font-size: 14px;
            line-height: 1.6;
            margin-bottom: 20px;
        }

        .newsletter-form {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }

        .newsletter-input {
            flex: 1;
            padding: 12px 15px;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(212, 175, 55, 0.3);
            border-radius: 40px;
            color: white;
            font-size: 14px;
            outline: none;
            transition: all 0.3s ease;
        }

        .newsletter-input:focus {
            border-color: #D4AF37;
            background: rgba(255, 255, 255, 0.15);
        }

        .newsletter-input::placeholder {
            color: rgba(255, 255, 255, 0.4);
        }

        .newsletter-btn {
            padding: 12px 20px;
            background: #bdd9ef;
            border: none;
            border-radius: 40px;
            color: #0A192F;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .newsletter-btn:hover {
            background: #115eb6;
            color: white;
            transform: translateY(-2px);
        }

        /* Payment Methods */
        .payment-methods {
            margin-top: 20px;
        }

        .payment-methods p {
            color: rgba(255, 255, 255, 0.5);
            font-size: 12px;
            margin-bottom: 10px;
        }

        .payment-icons {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .payment-icons span {
            background: rgba(255, 255, 255, 0.1);
            padding: 5px 10px;
            border-radius: 8px;
            font-size: 20px;
        }

        /* Footer Bottom */
        .footer-bottom {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
            padding-top: 30px;
            border-top: 1px solid rgba(212, 175, 55, 0.15);
        }

        .copyright {
            color: rgba(255, 255, 255, 0.5);
            font-size: 13px;
        }

        .footer-bottom-links {
            display: flex;
            gap: 25px;
            flex-wrap: wrap;
        }

        .footer-bottom-links a {
            color: rgba(255, 255, 255, 0.5);
            text-decoration: none;
            font-size: 13px;
            transition: color 0.3s ease;
        }

        .footer-bottom-links a:hover {
            color: #D4AF37;
        }

        /* Back to Top Button */
        .back-to-top {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 45px;
            height: 45px;
            background: #D4AF37;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #0A192F;
            text-decoration: none;
            font-size: 20px;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
            z-index: 100;
        }

        .back-to-top.show {
            opacity: 1;
            visibility: visible;
        }

        .back-to-top:hover {
            background: #c4a137;
            transform: translateY(-3px);
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .footer-top {
                grid-template-columns: repeat(2, 1fr);
                gap: 30px;
            }
        }

        @media (max-width: 768px) {
            .footer-top {
                grid-template-columns: 1fr;
                gap: 40px;
            }
            
            .footer-brand {
                grid-column: span 1;
            }
            
            .footer-bottom {
                flex-direction: column;
                text-align: center;
            }
            
            .footer-bottom-links {
                justify-content: center;
            }
            
            .newsletter-form {
                flex-direction: column;
            }
            
            .newsletter-btn {
                width: 100%;
            }
        }

        @media (max-width: 480px) {
            .footer-container {
                padding: 40px 20px 20px;
            }
            
            .footer-logo {
                font-size: 24px;
            }
        }
</style>
</head>
<body>
<footer class="footer">
    <div class="footer-container">
        
        <!-- Footer Top Section -->
        <div class="footer-top">
            
            <!-- Brand Column -->
            <div class="footer-brand">
                <div class="footer-logo">SAPPHIRE<span>PALACE</span></div>
                <p class="footer-tagline">
                    Where luxury meets the Arabian Sea — experience unparalleled hospitality and timeless elegance at Sapphire Palace, Goa.
                </p>
               
            </div>

            <!-- Quick Links Column -->
            <div class="footer-col">
                <h4>Quick Links</h4>
                <ul class="footer-links">
                    <li><a href="#">Home</a></li>
                    <li><a href="#">Rooms & Suites</a></li>
                    <li><a href="#">Restaurant & Bar</a></li>
                    <li><a href="#">Spa & Wellness</a></li>
                    <li><a href="#">Pool & Activities</a></li>
                    <li><a href="#">Gallery</a></li>
                </ul>
            </div>

            <!-- Support Column -->
            <div class="footer-col">
                <h4>Support</h4>
                <ul class="footer-links">
                    <li><a href="#">FAQ</a></li>
                    <li><a href="#">Contact Us</a></li>
                    <li><a href="#">Terms & Conditions</a></li>
                    <li><a href="#">Privacy Policy</a></li>
                    <li><a href="#">Reviews</a></li>
                    <li><a href="#">Sitemap</a></li>
                </ul>
            </div>

            <!-- Contact & Newsletter Column -->
            <div class="footer-col">
                <h4>Contact Us</h4>
                <ul class="contact-info">
                    <li>
                        <span>📍</span>
                        <span>Cola Beach, South Goa, India - 403702</span>
                    </li>
                    <li>
                        <span>📞</span>
                        <span>+91 832 123 4567</span>
                    </li>
                    <li>
                        <span>✉️</span>
                        <span>admin@sapphirepalace.com</span>
                    </li>
                </ul>
                
                <div class="newsletter">
                    <p class="newsletter-text">Subscribe for exclusive offers & updates</p>
                    <div class="newsletter-form">
                        <input type="email" class="newsletter-input" placeholder="Your email address">
                        <button class="newsletter-btn">Subscribe</button>
                    </div>
                </div>
                
                
            </div>
        </div>

        <!-- Footer Bottom Section -->
        <div class="footer-bottom">
            <div class="copyright">
                © 2026 Sapphire Palace, Goa. All rights reserved. | Designed for DCL students for their understanding</div>
            <div class="footer-bottom-links">
                <a href="#">Privacy Policy</a>
                <a href="#">Terms of Service</a>
                <a href="#">Cookie Policy</a>
                <a href="#">Accessibility</a>
            </div>
        </div>
    </div>
</footer>

</body>
</html>