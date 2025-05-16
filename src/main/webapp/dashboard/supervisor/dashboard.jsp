<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    if (session == null || session.getAttribute("role") == null) {
        response.sendRedirect("../../index.jsp");
        return;
    }
	
	int empId = (int) session.getAttribute("empId");
    String name = (String) session.getAttribute("name");
    String role = (String) session.getAttribute("role");
    String profilePhoto = (String) session.getAttribute("profilePhoto");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Supervisor Dashboard</title>
S	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
    <link rel="icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>

<!-- Side bar -->
<div class="sidebar">
    <h2 class="title">Core<span style="color: #a05aff;">HR</span></h2>
    <div class="sidebar-profile">
         <img src="${pageContext.request.contextPath}/assets/uploads/<%= profilePhoto%>">
         <p id="name"><%= name %></p>
         <p id="role"><%= role %></p></div>
         	
    <div class="features">
     <a href="${pageContext.request.contextPath}/dashboard/supervisor/dashboard.jsp" class="active"><i class="fa-solid fa-user"></i> Dashboard</a>
     <a href="${pageContext.request.contextPath}/TaskmanagementServlet"><i class="fa-solid fa-list-check"></i>Task</a>
     <a href="${pageContext.request.contextPath}/dashboard/supervisor/leaveRequest.jsp"><i class="fa-solid fa-person-walking-arrow-right"></i> Leave Requests</a>
     <a href="" id="log-out" data-bs-toggle="modal" data-bs-target="#logoutModal"><i class="fa-solid fa-right-from-bracket"></i> Logout</a></div>
</div>


<!--  logout popup -->
<div class="modal fade" id="logoutModal" tabindex="-1" aria-labelledby="logoutModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content border-0 shadow-lg rounded-4">
      <div class="modal-header bg-light-purple text-white rounded-top-4">
        <h5 class="modal-title" id="logoutModalLabel">Confirm Logout</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body text-dark">
        Are you sure you want to log out from your account?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
        <a href="${pageContext.request.contextPath}/LogoutServlet" class="btn btn-purple">Log Out</a>
      </div>
    </div>
  </div>
</div>



<!-- Navigation bar -->
<div class="nav-container">
    <nav class="menu-bar">
    	<span id="darkModeToggle" class="material-icons">light_mode</span>
    	<i id="bell" class="fa-solid fa-bell"></i>
        <div class="user-profile">
            <span><%= name %></span>
            <img src="${pageContext.request.contextPath}/assets/uploads/<%= profilePhoto%>"> 
        </div>
        
        <div class="dropdown-menu" id="dropdownMenu">
                <a href="${pageContext.request.contextPath}/SupervisorProfileServlet"><i class="fas fa-user"></i> Profile</a>
                <a href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </nav>
</div>



<!-- Main Content-->
<div class="content" id="main-content">
    <h5 id="main-title">Dashboard</h5>

    <div class="row g-4 mb-5">
      <div class="col-md-3">
        <div class="card card-stat bg-gradient-primary" id="card1" style="background: linear-gradient(45deg, #4e73df, #224abe);">
          <div class="card-body">
            <h3 class="fw-bold">88%</h3>
            <p>Attendance</p>
          </div>
        </div>
      </div>
      <div class="col-md-3">
        <div class="card card-stat" id="card2" style="background: linear-gradient(45deg, #1cc88a, #17a673);">
          <div class="card-body">
            <h3 class="fw-bold">5 Days</h3>
            <p>Remaining Leaves</p>
          </div>
        </div>
      </div>
      <div class="col-md-3">
        <div class="card card-stat" id="card3" style="background: linear-gradient(45deg, #f6c23e, #dda20a);">
          <div class="card-body">
            <h3 class="fw-bold">Rs. 120,000</h3>
            <p>Salary</p>
          </div>
        </div>
      </div>
      <div class="col-md-3">
        <div class="card card-stat" id="card4" style="background: linear-gradient(45deg, #e74a3b, #be2617);">
          <div class="card-body">
            <h3 class="fw-bold">7 Tasks</h3>
            <p>Pending Approvals</p>
          </div>
        </div>
      </div>
    </div>

    <div class="row g-4">
      <div class="col-md-6">
  <div class="card shadow-sm border-0">
    <div class="card-body">
      <h5 class="card-title mb-3">📢 Announcements</h5>
      <div class="announcement-scroll">
        <div class="announcement-item p-3 mb-2 rounded">
          <div class="fw-semibold">Annual Meeting</div>
          <div class="text-muted small">Scheduled for May 25th.</div>
        </div>
        <div class="announcement-item p-3 mb-2 rounded">
          <div class="fw-semibold">April Reports Due</div>
          <div class="text-muted small">Please submit by May 15th.</div>
        </div>
        <div class="announcement-item p-3 mb-2 rounded">
          <div class="fw-semibold">Company Outing</div>
          <div class="text-muted small">Fun event planned in June.</div>
        </div>
        <div class="announcement-item p-3 mb-2 rounded">
          <div class="fw-semibold">HR Policy Update</div>
          <div class="text-muted small">New guidelines available on portal.</div>
        </div>
        <div class="announcement-item p-3 mb-2 rounded">
          <div class="fw-semibold">Performance Reviews</div>
          <div class="text-muted small">Starting next week.</div>
        </div>
      </div>
    </div>
  </div>
</div>



  <div class="col-md-6">
  <div class="calendar-card bg-white">
    <div class="d-flex justify-content-between align-items-center mb-3">
      <h5>📌 Assigned Tasks Overview</h5>
      <button class="btn btn-outline-dark btn-sm rounded-pill" id="card-date">4 June 2024</button>
    </div>

    <div class="text-center">
      <canvas id="taskChart" width="120" height="120" class="mx-auto d-block" style="max-width: 120px; max-height: 120px;"></canvas>
    </div>

    <div class="row text-center mt-4">
      <div class="col-6 col-md-3"><span class="badge bg-primary me-1">&nbsp;</span> Pending Tasks: 15</div>
      <div class="col-6 col-md-3"><span class="badge bg-warning me-1">&nbsp;</span> In Progress: 30</div>
      <div class="col-6 col-md-3"><span class="badge bg-success me-1">&nbsp;</span> Completed: 25</div>
      <div class="col-6 col-md-3"><span class="badge bg-purple me-1" style="background-color:#6f42c1;">&nbsp;</span> Over due: 04</div>
    </div>

    <div class="text-center mt-3">
      <button class="btn btn-outline-dark btn-sm">View Details</button>
    </div>
  </div>
</div>

    </div>
  </div> 
  
  <script>
  const ctx = document.getElementById('taskChart').getContext('2d');
  new Chart(ctx, {
    type: 'doughnut',
    data: {
      labels: ['Pending Tasks', 'In Progress', 'Completed', 'Over due'],
      datasets: [{
        data: [15, 30, 25, 4],
        backgroundColor: ['#0d6efd', '#ffc107', '#198754', '#6f42c1'],
        borderWidth: 0
      }]
    },
    options: {
      plugins: {
        legend: { display: false },
        tooltip: { enabled: true }
      },
      cutout: '60%',
    }
  });
</script>
	    <script src="https://kit.fontawesome.com/55f983e54b.js" crossorigin="anonymous"></script>
		<script src="${pageContext.request.contextPath}/assets/js/common.js"></script>
		<script src="${pageContext.request.contextPath}/assets/js/dashboard.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
	    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script> 

</body>
</html>