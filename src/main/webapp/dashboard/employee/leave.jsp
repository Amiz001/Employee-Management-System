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
<title>Leave Request</title>

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
     <a href="${pageContext.request.contextPath}/LeaveServlet" class="active"><i class="fa-solid fa-person-walking-arrow-right"></i>Request Leave</a>
     <a href="${pageContext.request.contextPath}/AttendanceServlet"><i class="fa-solid fa-user-check"></i> Attendance</a>
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
                <a href="${pageContext.request.contextPath}/EmployeeProfileServlet"><i class="fas fa-user"></i> Profile</a>
                <a data-bs-toggle="modal" data-bs-target="#logoutModal"><i class="fas fa-sign-out-alt"></i> Logout</a>
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
      Leave record successfully updated!
    </div>
  </div>

  <div id="errorToast" class="toast text-bg-danger" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="toast-header">
      <strong class="me-auto">Error</strong>
      <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
    <div class="toast-body">
      <%= request.getParameter("message") %>
    </div>
  </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteConfirmModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content border-0 shadow-sm" style="max-width: 400px; margin: auto;">
      <div class="modal-header bg-danger text-white py-2">
        <h6 class="modal-title" id="deleteConfirmModalLabel">Confirm Deletion</h6>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close" style="font-size: 0.9rem;"></button>
      </div>
      <div class="modal-body text-center py-3">
        <p class="mb-1">Are you sure you want to delete this record?</p>
        <small class="text-muted">This action cannot be undone.</small>
      </div>
      <div class="modal-footer justify-content-center py-2">
        <button type="button" class="btn btn-secondary me-2" data-bs-dismiss="modal">Cancel</button>
        <a href="${pageContext.request.contextPath}/LeaveDeleteServlet?leaveId=" id="deleteLink">
          <button type="button" class="btn btn-danger" id="confirmDelete" style="min-width: 150px">Yes, Delete</button>
        </a>
      </div>
    </div>
  </div>
</div>




<%  
	String status = request.getParameter("status");
	    		  
	Employee employee = (Employee) request.getAttribute("employee");
	
	List<Leave> leaveList = (List<Leave>) request.getAttribute("leaveList");
	
	boolean isPending = false;
	
	if (leaveList != null) {
	    for (Leave leave : leaveList) {
	    	if(leave.getStatus().equals("Pending")){
	    		isPending = true;
	    	}
	    }
	}   
%>
    		  

<!-- Main Content-->
<div class="content">
    <h5 id="main-title">Request Leave <span id="countDisplay">Leave Count: <%= employee.getLeaveCount() %></span></h5>
    
    <div class="table-container">
        <table class="table table-striped my-table">
            <thead>

                <div class="search-toolbar">   
                    <div class="search-box">
                        <i class="fas fa-search"></i>
                        <input type="text" id="searchInput" placeholder="Search...">
                    </div>
                   
                    <div class="toolbar-icons"> 
                    <% if(!isPending){%>  
                    	<span id="add-icon" class="material-symbols-outlined" data-bs-toggle="modal" data-bs-target="#addEmployeeModal">add_circle</span>
                    <%} %>
                        <span class="material-symbols-outlined" id="download-icon">download</span>     
                    </div>
                </div>
                <tr>
                    <th>Leave ID</th>
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
            
		    if (leaveList != null) {
		        for (Leave leave : leaveList) {
			%>
			
            <tr>
                  <td><%= leave.getLeaveId() %></td>
		          <td><%= leave.getLeaveType() %></td>
		          <td><%= leave.getStartDate() %></td>
		          <td><%= leave.getEndDate() %></td>
		          <td><%= leave.getTotalDays() %></td>
		          <td><%= leave.getReason() %></td> 
		          <td><%= leave.getStatus() %></td> 
		          
                  <td  style="display:flex; justify-content:center; align-items:center; gap:10px">                 
                     
                     <% if(!(leave.getStatus().equals("Approved") || leave.getStatus().equals("Rejected"))){%>   
                  	<i class="fa-regular fa-pen-to-square" id="update-icon" data-bs-toggle="modal" data-bs-target="#updateEmployeeModal" onclick="fillUpdateForm('<%= leave.getLeaveId() %>', '<%= leave.getLeaveType()%>', '<%=leave.getStartDate()%>', '<%=leave.getEndDate()%>','<%=leave.getReason()%>')"></i>
                    <%} %>
                    <a onclick="deleteForm('<%= leave.getLeaveId() %>')" data-bs-toggle="modal" data-bs-target="#deleteConfirmModal"><i class="fa-solid fa-trash-can" id="delete-icon"></i></a>
                    
                  </td>
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
     
     
<%
    java.time.LocalDate today = java.time.LocalDate.now();
%>
     
<!-- Insert Popup-->

<div class="modal fade" id="addEmployeeModal" tabindex="-1" aria-labelledby="addEmployeeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
      <form method="post" action="${pageContext.request.contextPath}/LeaveInsertServlet">
        <div class="modal-header">
          <h5 class="modal-title" id="addEmployeeModalLabel">Add Employee Leave</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
  
        <div class="modal-body custom-scroll">
          
          <div class="col-md-12" style="margin-bottom: 15px">
              <label for="role" class="form-label">Leave Type</label>
              <select class="form-select" name="leaveType" required>
                <option value="" selected disabled>Select one</option>
                <option value="Annual">Annual</option>
                <option value="Casual">Casual</option>
                <option value="Sick">Sick</option>
              </select>
            </div>

          <div class="row g-3">
            <div class="col-md-6">
              <label for="startDate" class="form-label">Start Date</label>
              <input type="date" class="form-control" name="startDate" required>
            </div>
            <div class="col-md-6">
              <label for="endDate" class="form-label">End Date</label>
              <input type="date" class="form-control" name="endDate" required>
            </div>
          </div>

          <div class="mt-3">
            <label for="reason" class="form-label">Reason</label>
            <textarea class="form-control" name="reason" rows="3" maxlength="500" required></textarea>
          </div>
        </div>

        <div class="modal-footer">
		  <button type="submit" class="btn btn-purple">Submit</button>
		  <button type="button" class="btn btn-black" data-bs-dismiss="modal">Cancel</button>
		</div>
	    </form>
	  </div>
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
      <div class="col-md-12" style="margin-bottom: 13px">
              <label for="role" class="form-label">Leave Type</label>
              <select class="form-select" name="leaveType" value="" id="leaveType" required>
                <option value="" selected disabled>Select one</option>
                <option value="Annual">Annual</option>
                <option value="Casual">Casual</option>
                <option value="Sick">Sick</option>
              </select>
            </div>
            
			<input type="hidden" class="form-control" name="leaveId" value="" id="leaveId" required>
          <div class="row g-3">
            <div class="col-md-6">
              <label for="startDate" class="form-label">Start Date</label>
              <input type="date" class="form-control" name="startDate" value="" id="startDate" required>
            </div>
            <div class="col-md-6">
              <label for="endDate" class="form-label">End Date</label>
              <input type="date" class="form-control" name="endDate" id="endDate" value="" required min="<?= java.time.LocalDate.now(); ?>">
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