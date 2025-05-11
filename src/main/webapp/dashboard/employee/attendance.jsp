<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.*, com.ems.model.Attendance" %>

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
<title>Attendance</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css">
    <link rel="icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
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
     <a href="${pageContext.request.contextPath}/dashboard/employee/dashboard.jsp"><i class="fa-solid fa-user"></i> Dashboard</a>
     <a href="${pageContext.request.contextPath}/LeaveServlet" ><i class="fa-solid fa-person-walking-arrow-right"></i>Request Leave</a>
     <a href="${pageContext.request.contextPath}/AttendanceServlet" class="active"><i class="fa-solid fa-user-check"></i> Attendance</a>
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
                <a href="#"><i class="fas fa-user"></i> Profile</a>
                <a href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </nav>
</div>


<!--  Error alert messages -->
  <div id="errorToast" class="toast text-bg-danger" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="toast-header">
      <strong class="me-auto">Error</strong>
      <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
    <div class="toast-body">
      Something went wrong. Please try again!
    </div>
  </div>
</div>


<%  
String status = request.getParameter("status");
%>

<!-- Main Content-->
<div class="content">
    <h5 id="main-title">Attendance</h5>

    <div class="table-container">
        <table class="table table-striped my-table">
            <thead>

                <div class="search-toolbar">   
                    <div class="search-box">
                        <i class="fas fa-search"></i>
                        <input type="text" id="searchInput" placeholder="Search...">
                    </div>
                   
                    <div class="toolbar-icons"> 
                        <span class="material-symbols-outlined" id="download-icon">download</span>     
                    </div>
                </div>
                <tr>
                    <th>Attendance ID</th>
                    <th>Date</th>
                    <th>Check in</th>
                    <th>Check out</th>
                    <th>Status</th>         
                </tr>
            </thead>
            
            <%
            List<Attendance> attendanceList = (List<Attendance>) request.getAttribute("attendanceList");
            
		    if (attendanceList != null) {
		        for (Attendance attendance : attendanceList) {
			%>
			
            <tr>
                  <td><%= attendance.getAttendanceId() %></td>
		          <td><%= attendance.getDate() %></td>
		          <td><%= attendance.getCheckInTime() %></td>
		          <td><%= attendance.getCheckOutTime() %></td>
		          <td><%= attendance.getStatus() %></td>
            </tr>
            <%
		        } 
	    	} else {
			%>
			        <tr><td colspan="2" style="text-align: center">No leave records found</td></tr>
			<%
			    }
			%>
            
        </table>
    </div>
</div> 
  
<!-- Update Popup -->

<div class="modal fade" id="updateEmployeeModal" tabindex="-1" aria-labelledby="updateEmployeeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
      <form method="post" action="${pageContext.request.contextPath}/LeaveUpdateServlet">
        <div class="modal-header">
          <h5 class="modal-title" id="addEmployeeModalLabel">Edit Employee Leave</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>

        <div class="modal-body custom-scroll">
          <div class="mb-3">
            <label for="leaveType" class="form-label">Leave Type</label>
            <input type="text" class="form-control" name="leaveType" value="" id="leaveType" required>
          </div>
			<input type="hidden" class="form-control" name="leaveId" value="" id="leaveId" required>
          <div class="row g-3">
            <div class="col-md-6">
              <label for="startDate" class="form-label">Start Date</label>
              <input type="date" class="form-control" name="startDate" value="" id="startDate" required>
            </div>
            <div class="col-md-6">
              <label for="endDate" class="form-label">End Date</label>
              <input type="date" class="form-control" name="endDate" id="endDate" value="" required>
            </div>
          </div>

          <div class="mt-3">
            <label for="reason" class="form-label">Reason</label>
            <textarea class="form-control" name="reason" id="reason" value="" rows="3" required></textarea>
          </div>
        </div>

        <div class="modal-footer">
		  <button type="submit" class="btn btn-purple">Save</button>
		  <button type="button" class="btn btn-black" data-bs-dismiss="modal">Cancel</button>
		</div>
	    </form>
	  </div>
	</div>
</div>

	<script src="https://kit.fontawesome.com/55f983e54b.js" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/assets/js/common.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/leave.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>    
</body>
</html>