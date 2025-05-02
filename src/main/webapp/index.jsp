<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Login</title>
    <link rel="icon" href="assets/images/favicon.ico">
    <link rel="stylesheet" href="assets/css/login-style.css">
</head>
<body>
    <div id="header">
        <div id="top-text">    
            <h1 id="title">Manage Your Work force Efficiently</h1>
    
            <h2 id="sub-title">Our powerful Employee Management System helps businesses streamline HR processes, track attendance, and improve productivity effortlessly</h2>
            <button id="LearnMore" type="button">Learn More</button>
            <div id="Features">
                <div class="feature">
                    <img src="assets/images/check1.png" alt="check1">
                    <h3>Attendance Tracking </i></h3> 
                </div>
                <div class="feature">
                    <img src="assets/images/check1.png" alt="check1">
                    <h3>Secure Role-Based Access</h3>
                </div>
                <div class="feature">
                    <img src="assets/images/check1.png" alt="check1">
                    <h3>Payroll Management</h3>
                </div>
                <div class="feature">
                    <img src="assets/images/check1.png" alt="check1">
                    <h3>Employee Self-Service</h3>
                </div>
            </div>  
        </div>
        <div class="alert" id="alert">Invalid Input</div>
        <div id="serverMessage" style="display: none;">
   			 <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>
		</div>
        
        <div class="form-container">
            <h2>Welcome Back!</h2>
            <p></p><br> 

            <form id="Form" method="post" action="LoginServlet">
                <label for="email">Work Email *</label>
                <input type="email" id="email" name="email" placeholder="you@example.com" >
    
                <label for="password">Password *</label>
                <input type="password" id="password" name="password" placeholder="Password" >
    
                <a class="link" href="#"><p>Fogot password?</p></a><br>
    
                <button id="loginBtn" type="submit">Login to your account</button>
            </form>
    
            <p class="privacy-text">
                We're committed to your privacy. For more information, check out our 
                <a href="#" class="link">Privacy Policy</a>.
            </p>
        </div>
    </div>
  
    <script src="assets/js/login-script.js"></script> 
    <script src="https://kit.fontawesome.com/1f59e04ed2.js" crossorigin="anonymous"></script>
</body>
</html>