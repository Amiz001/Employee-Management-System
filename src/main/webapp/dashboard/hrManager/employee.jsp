<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.*, com.ems.model.Employee" %>

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
<title>Employee Management</title>

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
     <a href="${pageContext.request.contextPath}/dashboard/hrManager/dashboard.jsp"><i class="fa-solid fa-user"></i> Dashboard</a>
     <a href="${pageContext.request.contextPath}/EmployeeServlet" class="active"><i class="fa-solid fa-users"></i>Employee</a>
     <a href="${pageContext.request.contextPath}/DepartmentServlet"><i class="fa-solid fa-cube"></i> Department</a>
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
                <a href="${pageContext.request.contextPath}/HRManagerProfileServlet"><i class="fas fa-user"></i> Profile</a>
                <a href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a>
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
      Employee record successfully updated!
    </div>
  </div>
  
  <div id="errorToast" class="toast text-bg-danger" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="toast-header">
      <strong class="me-auto">Success</strong>
      <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
    <div class="toast-body">
      Employee record successfully deleted!
    </div>
  </div>
</div>

<% String status = request.getParameter("status"); %>

<!-- Main Content-->
<div class="content">
    <h5 id="main-title">Employee Details</h5>
    <div class="table-container">
        <table class="table table-striped my-table">
            <thead>

                <div class="search-toolbar">   
                    <div class="search-box">
                        <i class="fas fa-search"></i>
                        <input type="text" id="searchInput" placeholder="Search...">
                    </div>
                   
                    <div class="toolbar-icons"> 
                    	<span id="add-icon" class="material-symbols-outlined" data-bs-toggle="modal" data-bs-target="#addEmployeeModal">add_circle</span>
                        <span class="material-symbols-outlined" id="download-icon" onclick="downloadEmployeeExcel()">download</span>     
                    </div>
                </div>
                <tr>
                
                    <th>Employee ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Department</th>
                    <th>DOB</th>
                    <th>Gender</th>
                    <th>Role</th>
                    <th>Leave Count</th>
                    <th>Basic Salary</th>  
                    <th>Actions</th>        
                </tr>
            </thead>
            
            <%
            
            List<Employee> employeeList = (List<Employee>) request.getAttribute("employeeList");
            
		    if (employeeList != null) {
		        for (Employee employee : employeeList) {
			%>
			
            <tr>
                  <td style="width:10px"><%= employee.getEmpId() %></td>
		          <td><%= employee.getName() %></td>
		          <td><%= employee.getEmail() %></td>
		          <td><%= employee.getPhone() %></td>
		          <td><%= employee.getDepartment() %></td>
		          <td><%= employee.getDob() %></td> 
		          <td><%= employee.getGender() %></td>
		          <td><%= employee.getRole() %></td>
		          <td  style="width:10px"><%= employee.getLeaveCount() %></td>
		          <td><%= employee.getBasicSalary() %></td> 
		          
                  <td  style="display:flex; justify-content:center; align-items:center; gap:10px">                                                                                                                                                                                                      
                  	<i class="fa-regular fa-pen-to-square" id="update-icon" data-bs-toggle="modal" data-bs-target="#updateEmployeeModal" 
                  	onclick="fillUpdateForm('<%= employee.getEmpId() %>', '<%= employee.getName() %>', '<%=employee.getEmail()%>', '<%=employee.getPhone()%>','<%=employee.getDepartment()%>', '<%= employee.getDob() %>', '<%= employee.getGender() %>', '<%= employee.getRole() %>', '<%= employee.getLeaveCount() %>', '<%= employee.getBasicSalary() %>')"></i>
                    
                    <a href="${pageContext.request.contextPath}/EmployeeDeleteServlet?empId=<%= employee.getEmpId() %>"><i class="fa-solid fa-trash-can" id="delete-icon"></i></a>
                    
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
   
   
    
<!-- Insert Popup-->

<div class="modal fade" id="addEmployeeModal" tabindex="-1" aria-labelledby="addEmployeeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
      <form method="post" action="${pageContext.request.contextPath}/EmployeeInsertServlet">
        <div class="modal-header">
          <h5 class="modal-title" id="addEmployeeModalLabel">Add Employee Details</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
  
        <div class="modal-body custom-scroll">
          <div class="mb-3">
            <label for="name" class="form-label">Name</label>
            <input type="text" class="form-control" name="name" required>
          </div>

          <div class="row g-3 mb-3">
            <div class="col-md-6">
              <label for="email" class="form-label">Email</label>
              <input type="email" class="form-control" name="email" required>
            </div>
            <div class="col-md-6">
              <label for="phone" class="form-label">Phone</label>
              <input type="text" class="form-control" name="phone" required>
            </div>
          </div>

          <div class="row g-3 mb-3">
            <div class="col-md-6">
              <label for="department" class="form-label">Department</label>
              <select class="form-select" name="department" required>
                <option value="" selected disabled>Select one</option>
                <option value="HR">HR</option>
                <option value="Finance">Finance</option>
                <option value="Development">Development</option>
                <option value="Operations">Operations</option>
              </select>
            </div>
            <div class="col-md-6">
              <label for="role" class="form-label">Role</label>
              <select class="form-select" name="role" required>
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
              <input type="date" class="form-control" name="dob" required>
            </div>
            <div class="col-md-6">
              <label class="form-label d-block">Gender</label>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="gender" value="Male">
                <label class="form-check-label" for="gender">Male</label>
              </div>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="gender" value="Female">
                <label class="form-check-label" for="gender">Female</label>
              </div>
            </div>
          </div>
			
          <div class="mb-3">
            <label for="leaveCount" class="form-label">Leave Count</label>
            <input type="text" class="form-control" name="leaveCount" required>
          </div>
          
          <div class="mb-3">
            <label for="basicSalary" class="form-label">Basic Salary</label>
            <input type="text" class="form-control" name="basicSalary" required>
          </div>
        
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" name="password" required>
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
      <form method="post" action="${pageContext.request.contextPath}/EmployeeUpdateServlet">
        <div class="modal-header">
          <h5 class="modal-title" id="addEmployeeModalLabel">Edit Employee Details</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>

        <div class="modal-body custom-scroll">
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
              <select class="form-select" name="department" id="department" required>
                <option value="" selected disabled>Select one</option>
                <option value="HR">HR</option>
                <option value="Finance">Finance</option>
                <option value="Development">Development</option>
                <option value="Operations">Operations</option>
              </select>
            </div>
            <div class="col-md-6">
              <label for="role" class="form-label">Role</label>
              <select class="form-select" name="role" id="Erole" required>
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
            
            <div class="mb-3">
            <label for="leaveCount" class="form-label">Leave Count</label>
            <input type="text" class="form-control" name="leaveCount" id="leaveCount" required>
          </div>
          
          <div class="mb-3">
            <label for="basicSalary" class="form-label">Basic Salary</label>
            <input type="text" class="form-control" name="basicSalary" id="basicSalary" required>
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
	<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.5/xlsx.full.min.js"></script>
	<script src="https://kit.fontawesome.com/55f983e54b.js" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/assets/js/common.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/employee-script.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>    
</body>
</html>