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
<title>Employee Info</title>

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
     <a href="${pageContext.request.contextPath}/dashboard/financialAnalyst/dashboard.jsp"><i class="fa-solid fa-user"></i> Dashboard</a>
     <a href="${pageContext.request.contextPath}/EmployeeInfoServlet" class="active"><i class="fa-solid fa-address-book"></i> Employee Info</a>
     <a href="${pageContext.request.contextPath}/PayrollGetAllServlet"><i class="fa-solid fa-file-invoice-dollar"></i> Payroll</a>
     <a href="" id="log-out" data-bs-toggle="modal" data-bs-target="#logoutModal"><i class="fa-solid fa-right-from-bracket"></i> Logout</a></div>
</div>

<!--  Error and success alert messages -->
<div class="toast-container position-fixed bottom-0 end-0 p-3">

  <div id="errorToast" class="toast text-bg-danger" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="toast-header">
      <strong class="me-auto">Error</strong>
      <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
    <div class="toast-body">
     <%= request.getParameter("message")%>
    </div>
  </div>
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
                <a href="${pageContext.request.contextPath}/FinanceProfileServlet"><i class="fas fa-user"></i> Profile</a>
                <a href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </nav>
</div>

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
                        <span class="material-symbols-outlined" id="download-icon" onclick="downloadEmployeeColumnsExcel()">download</span>     
                     
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
                  <td><%= employee.getEmpId() %></td>
		          <td><%= employee.getName() %></td>
		          <td><%= employee.getEmail() %></td>
		          <td><%= employee.getPhone() %></td>
		          <td><%= employee.getDepartment() %></td>
		          <td><%= employee.getDob() %></td> 
		          <td><%= employee.getGender() %></td>
		          <td><%= employee.getRole() %></td>
		          <td><%= employee.getBasicSalary() %></td>
		          
                  <td  style="display:flex; justify-content:center; align-items:center; gap:10px">                                                                                                                                                                                                      
                  	
                  	<span style="color:#3a67d9; font-size: 20px; cursor:pointer; margin: 8px 0px" class="material-symbols-outlined" data-bs-toggle="modal" data-bs-target="#addEmployeeModal" 
                  	onclick="UpdateForm('<%=employee.getEmpId()%>','<%= employee.getBasicSalary() %>')">add_circle</span>
                    
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


<div class="modal fade" id="addEmployeeModal" tabindex="-1" aria-labelledby="addEmployeeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
      <form method="post" action="${pageContext.request.contextPath}/PayrollInsertServlet">
        <div class="modal-header">
          <h5 class="modal-title" id="addEmployeeModalLabel">Employee Salary</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
  
        <div class="modal-body custom-scroll">
          <div class="mb-3">
            <label for="emp_id" class="form-label">Employee ID</label>
            <input type="text" class="form-control" name="emp_id" id="emp_idid" readonly>
          </div>
          
          <div class="mb-3">
            <label for="basic" class="form-label">Basic Salary</label>
            <input type="text" class="form-control" name="basic" id="basicc" readonly>
          </div>
          
          <div class="mb-3">
            <label for="ot" class="form-label">Over Time</label>
            <input type="number" class="form-control" name="ot" required>
          </div>

          <div class="row g-3">
             <div class="mb-3">
            <label for="allowance" class="form-label">Allowance</label>
            <input type="number" class="form-control" name="allowance" required>
          </div>
          
            <div class="col-md-6">
              <label for="created_date" class="form-label">Date</label>
              <input type="date" class="form-control" name="created_date" required>
            </div>
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

    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.5/xlsx.full.min.js"></script>
	<script src="https://kit.fontawesome.com/55f983e54b.js" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/assets/js/common.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/payroll-script.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>   
</body>
</html>

