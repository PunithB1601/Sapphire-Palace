<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login & Signup - Sapphire Palace</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:wght@400;500;600;700&display=swap" rel="stylesheet">
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
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
        }

        .auth-container {
            max-width: 1200px;
            width: 100%;
            margin: 0 auto;
        }

        
        .auth-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .auth-logo {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            text-decoration: none;
            margin-bottom: 10px;
            transition: transform 0.3s ease;
        }

        .auth-logo:hover {
            transform: scale(1.02);
        }

        .auth-logo-img {
            height: 55px;
            width: auto;
            display: block;
        }

        .auth-logo-text {
           	font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
            font-size: 32px;
            font-weight: 700;
            color: black;
        }

        .auth-logo-text span {
            color: #115eb6;
        }

        .auth-tagline {
            color: black;
            font-size: 14px;
            margin-top: 5px;
        }

        
        .forms-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            background: white;
            border-radius: 24px;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .form-card {
            padding: 40px;
            background: white;
        }

        .login-card {
            border-right: 1px solid #115eb6;
        }

        .form-title {
            font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
            font-size: 28px;
            margin-bottom: 8px;
        }

        .form-subtitle {
            font-size: 14px;
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-size: 14px;
            font-weight: 500;
            margin-bottom: 8px;
        }

        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #115eb6;
            border-radius: 12px;
            font-size: 14px;
            transition: all 0.3s ease;
            outline: none;
        }

        .form-group input:focus {
            border-color: #115eb6;
            
        }

        .password-container {
            position: relative;
        }

        .password-container input {
            padding-right: 45px;
        }

        .toggle-password {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #115eb6;
            font-size: 14px;
        }

        .form-options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .remember-me {
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
            font-size: 13px;
            color: #6b5e4a;
        }

        .forgot-password {
            color: #115eb6;
            text-decoration: none;
            font-size: 13px;
            font-weight: 500;
        }

        .submit-btn {
            width: 100%;
            padding: 14px;
            background: #115eb6;
            color: white;
            border: none;
            border-radius: 40px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-bottom: 20px;
        }

        .submit-btn:hover {
            background: #bdd9ef;
            transform: translateY(-2px);
            color:black;
        }

        .divider {
            text-align: center;
            position: relative;
            margin: 20px 0;
        }

        .divider::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 0;
            right: 0;
            height: 1px;
            background: #e0e0e0;
        }

        .divider span {
            background: white;
            padding: 0 15px;
            position: relative;
            color: #6b5e4a;
            font-size: 13px;
        }

        .error-message {
            color: #e74c3c;
            font-size: 12px;
            margin-top: 5px;
            display: block;
        }

       

        .success-message {
            background: #27ae60;
            color: white;
            padding: 12px;
            border-radius: 10px;
            margin-bottom: 20px;
            text-align: center;
            font-size: 14px;
            display: block;
        }

        

        @media (max-width: 900px) {
            .forms-grid {
                grid-template-columns: 1fr;
            }
            .login-card {
                border-right: none;
                border-bottom: 1px solid #eee;
            }
            .form-card {
                padding: 30px;
            }
        }

        @media (max-width: 480px) {
            .auth-logo-img {
                height: 40px;
            }
            .auth-logo-text {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>

<div class="auth-container">
    <!-- Header with Logo + Name -->
    <div class="auth-header">
        <a href="#" class="auth-logo">
            <img src="DCL/sp_hotel_logo.png" alt="Sapphire Palace Logo" class="auth-logo-img">
            <div class="auth-logo-text">SAPPHIRE <span>PALACE</span></div>
        </a>
        <p class="auth-tagline">Welcome to luxury — Sign in to continue or create new account</p>
    </div>

    <!-- Forms Grid -->
    <div class="forms-grid">
        
        <!-- LOGIN FORM -->
        <div class="form-card login-card">
            <h2 class="form-title">Welcome Back</h2>
            <p class="form-subtitle">Login to access your account</p>

		<%String loginSuccess=(String)request.getAttribute("loginSuccess");%>
		<%if(loginSuccess!=null){%>
            <div id="loginSuccess" class="success-message"><%=loginSuccess%></div>
		<%}%>
		
		<%String loginError=(String)request.getAttribute("loginError");%>
		<%if(loginError!=null){%>
            <div id="loginError" class="error-message"><%=loginError%></div>
		<%}%> 

            <form action="login" method="POST">
                <div class="form-group">
                    <label>Email Address <span>*</span></label>
                    <input type="email" name="mail" id="loginEmail" placeholder="Enter your email" required>
                    
                </div>

                <div class="form-group">
                    <label>Password <span>*</span></label>
                    <div class="password-container">
                        <input type="password" name="password" id="loginPassword" placeholder="Enter your password" required>
                    </div>
                    
                </div>

                <div class="form-options">
                    <label class="remember-me">
                        <input type="checkbox" id="rememberMe"> Remember me
                    </label>
                    <a href="forgotPassword.jsp" class="forgot-password" id="forgotPassword">Forgot Password?</a>
                </div>

                <button type="submit" class="submit-btn">Login</button>

           
            </form>
        </div>

        <!-- SIGNUP FORM -->
        <div class="form-card">
            <h2 class="form-title">Create Account</h2>
            <p class="form-subtitle">Join Sapphire Palace for exclusive benefits</p>

		<%String signupSuccess=(String)request.getAttribute("signupSuccess");%>
		<%if(signupSuccess!=null){%>
            <div id="signupSuccess" class="success-message show"><%=signupSuccess%></div>
		<%}%>
		
		<%String signupError=(String)request.getAttribute("signupError");%>
		<%if(signupError!=null){%>
            <div id="signupError" class="error-message show"><%=signupError%></div>
		<%}%>
           
            <form action="signup" method="POST">
                <div class="form-group">
                    <label>Full Name <span>*</span></label>
                    <input type="text" id="signupName" name="name" placeholder="Enter your full name" required>
                    
                </div>

                <div class="form-group">
                    <label>Phone Number <span>*</span></label>
                    <input type="tel" id="signupPhone" name="phone" placeholder="Enter your phone number" required>
                    
                </div>

                <div class="form-group">
                    <label>Email Address <span>*</span></label>
                    <input type="email" id="signupEmail" name="mail" placeholder="Enter your email" required>
                   
                </div>

                <div class="form-group">
                    <label>Password <span>*</span></label>
                    <div class="password-container">
                        <input type="password" id="signupPassword" name="password" placeholder="Set a new Password" required>
                       
                    </div>
                    
                </div>

                <div class="form-group">
                    <label>Confirm Password <span>*</span></label>
                    <div class="password-container">
                        <input type="password" id="signupConfirmPassword" name="confirm" placeholder="Confirm your password" required>
                       
                    </div>
                    
                </div>

                <button type="submit" class="submit-btn">Create Account</button>
            </form>
        </div>
    </div>
</div>

</body>
</html>