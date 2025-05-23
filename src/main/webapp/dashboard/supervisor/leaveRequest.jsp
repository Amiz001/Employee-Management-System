<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.*, com.ems.model.Leave, com.ems.model.Employee" %>

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

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
     <a href="${pageContext.request.contextPath}/dashboard/supervisor/dashboard.jsp"><i class="fa-solid fa-user"></i> Dashboard</a>
     <a href="${pageContext.request.contextPath}/TaskmanagementServlet"><i class="fa-solid fa-list-check"></i>Task</a>
     <a href="${pageContext.request.contextPath}/EmployeeInfo2Servlet"><i class="fa-solid fa-address-book"></i> Employee info</a>
     <a href="${pageContext.request.contextPath}/LeaveManageServlet" class="active"><i class="fa-solid fa-person-walking-arrow-right"></i> Leave Requests</a>
     <a style="margin-top: 90px" id="log-out" data-bs-toggle="modal" data-bs-target="#logoutModal"><i class="fa-solid fa-right-from-bracket"></i> Logout</a></div>
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
               <a href="" id="log-out" data-bs-toggle="modal" data-bs-target="#logoutModal"><i class="fa-solid fa-right-from-bracket"></i> Logout</a></div>
        </div>
    </nav>
</div>


<!--  Error and success alert messages -->
<div class="toast-container position-fixed bottom-0 end-0 p-3">

  <div id="successToast" class="toast text-bg-primary" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="toast-header">
      <strong class="me-auto">Success</strong>
      <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
    <div class="toast-body">
      Updated successfully!
    </div>
  </div>

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
    <h5 id="main-title">Leave Request</h5>
    <div class="table-container">
        <table class="table table-striped my-table">
            <thead>

                <div class="search-toolbar">   
                    <div class="search-box">
                        <i class="fas fa-search"></i>
                        <input type="text" id="searchInput" placeholder="Search...">
                    </div>
                   
                    <div class="toolbar-icons"> 
                        <span class="material-symbols-outlined" id="download-icon" onclick="downloadLeaveExcel()">download</span>     
                    </div>
                </div>
                <tr>
                    <th>Leave ID</th>
                    <th>Employee ID</th>
                    <th>Available Leaves</th>
                    <th>Leave Type</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th>Total days</th>
                    <th>Reason</th>
                    <th>Status</th>  
                    <th>Actions</th>         
                </tr>
            </thead>
            
            <%
            List<Leave> leaveList = (List<Leave>) request.getAttribute("leaveList");
    		List<Employee> employeeList = (List<Employee>) request.getAttribute("employeeList");
            
    		int i=0;
    		  
		    if (leaveList != null) {
		        for (Leave leave : leaveList) {
		        
		        	Employee employee = null;
		        	int empid = leave.getEmpId();

		        	for (Employee emp : employeeList) {
		        	    if (emp.getEmpId() == empid) {
		        	        employee = emp;
		        	        break;
		        	    }
		        	}

			%>
			
            <tr>
                  <td><%= leave.getLeaveId() %></td>
                  <td><%= employee.getEmpId() %></td>
                  <td><%= employee.getLeaveCount() %></td>
		          <td><%= leave.getLeaveType() %></td>
		          <td><%= leave.getStartDate() %></td>
		          <td><%= leave.getEndDate() %></td>
		          <td><%= leave.getTotalDays() %></td>
		          <td><%= leave.getReason() %></td> 
		          <td><%= leave.getStatus() %></td> 
		          
                  <td  style="display:flex; justify-content:center; align-items:center; gap:10px;">                 
                    
                    <% if(leave.getStatus().equals("Pending")) {%> 
                  		<a href="LeaveStatusServlet?leaveId=<%= leave.getLeaveId()%>&action=accept&totalDays=<%= leave.getTotalDays() %>&empId=<%= employee.getEmpId() %>"><span class="material-symbols-outlined" id="update-icon" style="color:green">task_alt</span></a>
                  		<a href="LeaveStatusServlet?leaveId=<%= leave.getLeaveId()%>&action=reject&totalDays=<%= leave.getTotalDays() %>&empId=<%= employee.getEmpId() %>"><span class="material-symbols-outlined" id="delete-icon">cancel</span></a>
                    <%} else if(leave.getStatus().equals("Approved") || leave.getStatus().equals("Rejected")){ %>
                   	 	<p style="color:blue">Resolved</p>
                    <%} %>
                  </td>
            </tr>
            <%
            i++;
		        } 
	    	} else {
			%>
			        <tr><td colspan="10" style="text-align: center;">No leave records found</td></tr>
			<%
			    }
			%>
            
        </table>
    </div>
</div>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.5/xlsx.full.min.js"></script>
	<script src="https://kit.fontawesome.com/55f983e54b.js" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/assets/js/common.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/Taskmanagement.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>    
</body>
</html>