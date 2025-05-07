<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payroll-Dashboard</title>

     <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/payrolldashboard-style.css">
   <link rel="icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico">
    
</head>
<body>

<!-- Side bar -->
<div class="sidebar">
    <h2 class="title">CoreHR</h2>
    <div class="sidebar-profile">
         <img src="https://img.freepik.com/premium-photo/official-girl-iamges-hd-wallpaper-free-download-girl-model-with-pant-shairt-product-view-ad_88650-3237.jpg?w=2000">
         <p id="name">Sarah Smith</p>
         <p id="role">Financial Analyst</p></div>
         	
    <div class="features">
     <a href="${pageContext.request.contextPath}/dashboard/financialAnalyst/payrolldashboard.jsp" class="active"><i class="fa-solid fa-user"></i> Dashboard</a>
     <a href="${pageContext.request.contextPath}/dashboard/financialAnalyst/payrollemployees.jsp"><i class="fa-solid fa-user"></i> Employees</a>
     <a href="${pageContext.request.contextPath}/PayrollGetAllServlet#"><i class="fa-solid fa-file-invoice-dollar"></i> Payroll</a>
     <a href="login.jsp" id="log-out"><i class="fa-solid fa-right-from-bracket"></i> Logout</a></div>
    
</div>


<!-- Navigation bar -->
<div class="nav-container">
    <nav class="menu-bar">
    	<i id="bell" class="fa-solid fa-bell"></i>
        <div class="user-profile">
            <span>Sarah Smith</span>
            <img src="https://img.freepik.com/premium-photo/official-girl-iamges-hd-wallpaper-free-download-girl-model-with-pant-shairt-product-view-ad_88650-3237.jpg?w=2000"> 
        </div>
        
        <div class="dropdown-menu" id="dropdownMenu">
                <a href="#"><i class="fas fa-user"></i> Profile</a>
                <a href="#"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </nav>
</div>



     <!-- Content -->
     <div class="main-content">
        <div class="cards">
           <div>
            <div class="card green">
                <h4>New Projects</h4>
                <h2>102</h2>
                
            </div>
            <div class="card blue">
                <h4>New Customers</h4>
                <h2>154</h2>
                
            </div>
          </div>
          <div>
            <div class="card purple">
                <h4>Inquiry</h4>
                <h2>524</h2>
                
            </div>
            <div class="card orange">
                <h4>Earning</h4>
                <h2>$2,453</h2>
                
            </div>
         </div>   
        </div>
    </div>

    <script>
    document.addEventListener("DOMContentLoaded", function () {
        // Example: Simulate live updates
        setInterval(() => {
            let earnings = document.querySelector(".card.orange h2");
            let newAmount = (Math.random() * 3000).toFixed(2);
            earnings.innerText = `$${newAmount}`;
        }, 5000);
    });
    </script> 
    
    <script src="https://kit.fontawesome.com/55f983e54b.js" crossorigin="anonymous"></script>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/payroll-script.js"></script>
    
</body>
</html>


