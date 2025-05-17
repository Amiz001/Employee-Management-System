<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.ems.model.Employee" %>
<%@ page import="com.ems.model.Payroll" %>


<%
    if (session == null || session.getAttribute("role") == null) {
        response.sendRedirect("../../index.jsp");
        return;
    }
	
	int empId = (int) session.getAttribute("empId");
    String name = (String) session.getAttribute("name");
    String role = (String) session.getAttribute("role");
    String profilePhoto = (String) session.getAttribute("profilePhoto");

    
	String status = request.getParameter("status");
    		  
	Employee employee = (Employee) request.getAttribute("employee");
	Payroll payroll = (Payroll) request.getAttribute("payroll");

	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/profile-style.css">
    <link rel="icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
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
     <a href="${pageContext.request.contextPath}/TaskmanagementServlet" ><i class="fa-solid fa-person-walking-arrow-right"></i>Task</a>
     <a href="${pageContext.request.contextPath}/EmployeeInfo2Servlet"><i class="fa-solid fa-address-book"></i> Employee info</a>
     <a href="${pageContext.request.contextPath}/LeaveManageServlet"><i class="fa-solid fa-user-check"></i> Leave Request</a>
     <a href="${pageContext.request.contextPath}/LogoutServlet" id="log-out" data-bs-toggle="modal" data-bs-target="#logoutModal"><i class="fa-solid fa-right-from-bracket"></i> Logout</a></div>
     
     
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
                <a data-bs-toggle="modal" data-bs-target="#logoutModal"><i class="fas fa-sign-out-alt" ></i> Logout</a>
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
      Something went wrong. Please try again!
    </div>
  </div>
</div>

<!-- Main Content-->
<div class="content" id="main-content">
    
    <div class="profile-header mb-5">
      <div class="d-flex align-items-center profile-top">
        <img src="${pageContext.request.contextPath}/assets/uploads/<%= profilePhoto%>" class="profile-img me-4 shadow" alt="Profile">
        <div>
          <h4><%= name %></h4>
          <p class="mb-1"><%= role %> · <%= employee.getDepartment() %></p>
          <div class="d-flex flex-wrap gap-3 mt-3">
            <div class="quick-box text-white"><strong>Email:</strong> <%= employee.getEmail() %></div>
            <div class="quick-box text-white"><strong>Phone:</strong> <%= employee.getPhone() %></div>
            <div class="quick-box text-white"><strong>Gender:</strong> <%= employee.getGender() %></div>
            <div class="quick-box text-white"><strong>DOB:</strong> <%= employee.getDob() %></div>
          </div>
        </div>
        <div class="ms-auto action-buttons">
          <button class="btn btn-outline-light me-2" data-bs-toggle="modal" data-bs-target="#updateEmployeeModal" onclick="fillUpdateForm('<%= employee.getEmpId() %>', '<%= employee.getName() %>', '<%=employee.getEmail()%>', '<%=employee.getPhone()%>','<%=employee.getDepartment()%>', '<%= employee.getDob() %>', '<%= employee.getGender() %>', '<%= employee.getRole() %>', '<%= employee.getProfilePhoto() %>')">
            <i class="bi bi-pencil-square"></i> Edit Details
          </button>
        </div>
      </div>
    </div>

    <div class="row align-items-stretch" style="margin-top:-20px">
      <div class="col-lg-6 d-flex flex-column">
        <div class="glass-card flex-fill">
          <div class="section-title">Personal Details</div>
          <div class="row">
            <div class="col-6 mb-2"><span class="info-label">Name:</span> <%= employee.getName() %></div>
            <div class="col-6 mb-2"><span class="info-label">Role:</span> <%= employee.getRole() %></div>
            <div class="col-6 mb-2"><span class="info-label">Department:</span> <%= employee.getDepartment() %></div>
            <div class="col-6 mb-2"><span class="info-label">Email:</span> <%= employee.getEmail() %></div>
            <div class="col-6 mb-2"><span class="info-label">Phone:</span> <%= employee.getPhone() %></div>
            <div class="col-6 mb-2"><span class="info-label">DOB:</span> <%= employee.getDob() %></div>
          </div>
        </div>

        <div class="glass-card">
          <div class="section-title">Security</div>
          <div class="mb-3">
            <label class="info-label">Password:</label>
            <div>
			<% 
				String password = employee.getPassword();
			
				for(int i=0; i<password.length(); i++){%>
					*
				<%}
			
			%>
			</div>
          </div>
          <button class="btn btn-purple" data-bs-toggle="modal" data-bs-target="#passwordModal">
            <i class="bi bi-lock"></i> Change Password
          </button>
        </div>
      </div>


      <div class="col-lg-6">

        <div class="glass-card h-100" style="max-height: 384px; max-width: 567px;">
          <div class="section-title">Salary Details</div>
          <div class="row">
            <div class="col-md-6 mb-2"><span class="info-label">Basic:</span> Rs.<%= payroll.getBasic() %></div>
            <div class="col-md-6 mb-2"><span class="info-label">Allowances:</span> Rs.<%= payroll.getAllowance() %></div>
            <div class="col-md-6 mb-2"><span class="info-label">Over Time:</span> <%= payroll.getOt() %></div>
            <div class="col-md-6 mb-2"><span class="info-label">Net Salary:</span> <span class="net-salary">Rs.<%= payroll.getTotal_salary() %></span></div>
          </div>
          <button class="btn btn-outline-dark" style="text-align:center; position: absolute; left: 61%; margin-top: 25px;">
            <i class="bi bi-download"></i> Download Payroll
          </button>
          
          <img src="${pageContext.request.contextPath}/assets/images/payment.svg" style="width:200px; position:absolute; right: 10%; bottom: 8%">
        </div>
      </div>
    </div>
    
  </div> 
  
  
  <!-- Edit Modal -->
  <div class="modal fade" id="updateEmployeeModal" tabindex="-1" aria-labelledby="updateEmployeeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
      <form method="post" action="${pageContext.request.contextPath}/SupervisorProfileServlet">
        <div class="modal-header">
          <h5 class="modal-title" id="addEmployeeModalLabel">Edit Employee Details</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>

        <div class="modal-body custom-scroll">
        <div class="mb-4 d-flex align-items-center gap-4">
			  <div>
			    <img id="profileImg" 
			         src="${pageContext.request.contextPath}/assets/uploads/" 
			         alt="Profile Photo" 
			         class="rounded-circle border" 
			         style="width: 100px; height: 100px; object-fit: cover;">
			  </div>
			
			  <div class="flex-grow-1">
			    <label for="profilePhoto" class="form-label">Profile Photo</label>
			    <input type="file" class="form-control" id="profilePhoto" name="profilePhoto" accept="image/*">
			  </div>
			</div>
			
          <div class="mb-3">
            <label for="name" class="form-label">Name</label>
            <input type="text" class="form-control" name="name" id="Ename" required>
          </div>
			<input type="hidden" class="form-control" name="empId" id="empId">
          <div class="row g-3 mb-3">
            <div class="col-md-6">
              <label for="email" class="form-label">Email</label>
              <input type="email" class="form-control" name="email" id="email" required>
            </div>
            <div class="col-md-6">
              <label for="phone" class="form-label">Phone</label>
              <input type="text" class="form-control" name="phone" id="phone" required>
            </div>
          </div>

          <div class="row g-3 mb-3">
            <div class="col-md-6">
              <label for="department" class="form-label">Department</label>
              <select class="form-select" name="department" id="department" disabled>
                <option value="" selected disabled>Select one</option>
                <option value="HR">HR</option>
                <option value="Finance">Finance</option>
                <option value="Development">Development</option>
                <option value="Operations">Operations</option>
              </select>
            </div>
            <div class="col-md-6">
              <label for="role" class="form-label">Role</label>
              <select class="form-select" name="role" id="Erole" disabled >
                <option value="" selected disabled>Select one</option>
                <option value="HR Manager">HR Manager</option>
                <option value="Supervisor">Supervisor</option>
                <option value="Finance Analyst">Financial Analyst</option>
                <option value="Employee">Regular Employee</option>
              </select>
            </div>
          </div>

          <div class="row g-3 mb-3">
            <div class="col-md-6">
              <label for="dob" class="form-label">Date of Birth</label>
              <input type="date" class="form-control" name="dob" id="dob" required>
            </div>
            <div class="col-md-6">
              <label class="form-label d-block">Gender</label>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="gender" id="genderMale" value="Male">
                <label class="form-check-label" for="gender">Male</label>
              </div>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="gender" id="genderFemale" value="Female">
                <label class="form-check-label" for="gender">Female</label>
              </div>
            </div>
            
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

  <!-- Password Modal -->
  <div class="modal fade" id="passwordModal" tabindex="-1" aria-labelledby="passwordModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <form method="post" action="${pageContext.request.contextPath}/UpdatePasswordServlet">
          <div class="modal-header">
            <h5 class="modal-title">Change Password</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body">
            <div class="mb-2"><label>Current Password</label><input type="password" class="form-control" id="currentPswd" name="currentPswd"></div>
            <div class="mb-2"><label>New Password</label><input type="password" class="form-control" id="pswd1" name="pswd1"></div>
            <div class="mb-2"><label>Confirm New Password</label><input type="password" class="form-control" id="pswd2" name="pswd2"></div>
          </div>
          <div class="modal-footer">
            <button class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
            <button type="submit" class="btn btn-purple">Update Password</button>
          </div>
        </form>
      </div>
    </div>
  </div>
  
  	<script> 
  //delete form validation
    document.addEventListener("DOMContentLoaded", function () {
        const form = document.querySelector('#passwordModal form');
        const currentPswdInput = document.getElementById('currentPswd');
        const newPswdInput = document.getElementById('pswd1');
        const confirmPswdInput = document.getElementById('pswd2');

        // Server-side current password (rendered into JS from JSP)
        const serverCurrentPassword = '<%= employee.getPassword() %>';

        form.addEventListener('submit', function (e) {
          const currentPswd = currentPswdInput.value.trim();
          const newPswd = newPswdInput.value.trim();
          const confirmPswd = confirmPswdInput.value.trim();

          if (currentPswd === '' || newPswd === '' || confirmPswd === '') {
            alert("All fields are required.");
            e.preventDefault();
            return;
          }

          if (currentPswd !== serverCurrentPassword) {
            alert("Current password is incorrect.");
            e.preventDefault();
            return;
          }

          if (newPswd.length < 6) {
            alert("New password must be at least 6 characters long.");
            e.preventDefault();
            return;
          }

          if (newPswd !== confirmPswd) {
            alert("New passwords do not match.");
            e.preventDefault();
            return;
          }
        });
      });
  	</script>
  
	<script src="https://kit.fontawesome.com/55f983e54b.js" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/assets/js/common.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/profile-script.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>    
</body>
</html>