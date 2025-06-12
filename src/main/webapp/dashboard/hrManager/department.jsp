<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.*, com.ems.model.Department" %>

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
<title>Department Details</title>

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
     <a href="${pageContext.request.contextPath}/EmployeeServlet"><i class="fa-solid fa-users"></i>Employee</a>
     <a href="${pageContext.request.contextPath}/DepartmentServlet" class="active"><i class="fa-solid fa-cube"></i> Department</a>
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


<!--  Error and success alert messages -->
<div class="toast-container position-fixed bottom-0 end-0 p-3">

  <div id="successToast" class="toast text-bg-primary" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="toast-header">
      <strong class="me-auto">Success</strong>
      <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
    <div class="toast-body">
      Department record successfully updated!
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
        <a href="${pageContext.request.contextPath}/DepartmentDeleteServlet?dep_id=" id="deleteLink">
          <button type="button" class="btn btn-danger" id="confirmDelete" style="min-width: 150px">Yes, Delete</button>
        </a>
      </div>
    </div>
  </div>
</div>


<% 
String status = request.getParameter("status");
%>

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
                <a href="" data-bs-toggle="modal" data-bs-target="#logoutModal"><i class="fas fa-sign-out-alt" ></i> Logout</a>
        </div>
    </nav>
</div>



<!-- Main Content-->
<div class="content">
    <h5 id="main-title">Department Details</h5>
    <div class="table-container">
     <div class="search-toolbar">   
                    <div class="search-box">
                        <i class="fas fa-search"></i>
                        <input type="text" id="searchInput" placeholder="Search...">
                    </div>
                   
                    <div class="toolbar-icons"> 
                    	<span id="add-icon" class="material-symbols-outlined" data-bs-toggle="modal" data-bs-target="#addEmployeeModal">add_circle</span>
                        <span class="material-symbols-outlined" id="download-icon" onclick="downloadDepartmentExcel()">download</span>     
                    </div>
                </div>
        <table class="table table-striped my-table">
            <thead>

   
                <tr>
                    <th>Department ID</th>
                    <th>Department Name</th>
                    <th>No of Employees</th>
                    <th>Phone</th>
                    <th>Email</th>
                    <th>Supervisor ID</th>
                    <th>Action</th>
                </tr>
            </thead>
            
            <%
            List<Department> departmentList = (List<Department>) request.getAttribute("departments");
            
		    if (departmentList != null) {
		        for (Department department : departmentList) {
			%>
			
            
            <tr>
                <td><%=department.getDep_id() %></td>
	            <td><%=department.getName() %></td>
	            <td><%=department.getNo_of_emp() %></td>
	            <td><%=department.getPhone() %></td>
	            <td><%=department.getEmail() %></td>
	            <td><%=department.getSupervisor_id() %></td>
          
                   <td  style="display:flex; justify-content:center; align-items:center; gap:10px">                 
                       
                  	<i class="fa-regular fa-pen-to-square" id="update-icon" data-bs-toggle="modal" data-bs-target="#updateEmployeeModal"
   onclick="fillUpdateForm('<%= department.getDep_id() %>', '<%= department.getName()%>', '<%=department.getNo_of_emp()%>', '<%=department.getPhone()%>','<%=department.getEmail()%>','<%=department.getSupervisor_id() %>')">
</i>

                    <a onclick="deleteForm('<%= department.getDep_id() %>')" data-bs-toggle="modal" data-bs-target="#deleteConfirmModal"><i class="fa-solid fa-trash-can" id="delete-icon"></i></a>
                    
                  </td>
            </tr>
            <%
		        } 
	    	} else {
			%>
			        <tr><td colspan="2" style="text-align: center">No department records found</td></tr>
			<%
			    }
			%>
            
        </table>
    </div>
</div> 

<!-- Add Department Modal -->
<div class="modal fade" id="addEmployeeModal" tabindex="-1" aria-labelledby="addEmployeeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
      <form method="post" action="${pageContext.request.contextPath}/DepartmentInsertServlet">
        <div class="modal-header">
          <h5 class="modal-title" id="addEmployeeModalLabel">Add Department</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>

        <div class="modal-body custom-scroll">
          <div class="mb-3">
            <label for="dep_id" class="form-label">Department ID</label>
            <input type="text" class="form-control" name="dep_id" required>
          </div>

         
            <div class="mt-3">
              <label for="name" class="form-label">Department Name</label>
              <input type="text" class="form-control" name="name" required>
            </div>
            <div class="mt-3">
              <label for="no_of_emp" class="form-label">No of Employee</label>
              <input type="text" class="form-control" name="no_of_emp" required>
            </div>
          

          <div class="mt-3">
            <label for="phone" class="form-label">Phone</label>
            <input type="text" class="form-control" name="phone"  pattern="^[0-9]{10}$" title="Enter a 10-digit phone number" required>
          </div>
          
          <div class="mt-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" class="form-control" name="email" required>
          </div>
          
          <div class="mt-3">
            <label for="supervisor_id" class="form-label">Supervisor Id</label>
            <input type="text" class="form-control" name="supervisor_id" required>
          </div>
          
        </div>

        <div class="modal-footer">
          <button type="submit" class="btn btn-purple">Submit</button>
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        </div>

      </form>
    </div>
  </div>
</div>

<!-- Update Department Modal -->
<div class="modal fade" id="updateEmployeeModal" tabindex="-1" aria-labelledby="updateEmployeeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
      <form method="post" action="${pageContext.request.contextPath}/DepartmentUpdateServlet">
        <div class="modal-header">
          <h5 class="modal-title" id="updateEmployeeModalLabel">Update Department</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>

        <div class="modal-body custom-scroll">
          <div class="mb-3">
            <label for="dep_id" class="form-label">Department ID</label>
            <input type="text" class="form-control" name="dep_id" id="updatedep_id"  readonly>
          </div>

          
            <div class="mt-3">
              <label for="name" class="form-label">Department Name</label>
              <input type="text" class="form-control" name="name" id="updatename" required>
            </div>
            <div class="mt-3">
              <label for="no_of_emp" class="form-label">No of Employee</label>
              <input type="text" class="form-control" name="no_of_emp" id="updateno_of_emp" required>
            </div>
          

          <div class="mt-3">
            <label for="phone" class="form-label">Phone</label>
            <input type="text" class="form-control" name="phone" id="updatephone"  pattern="^[0-9]{10}$" title="Enter a 10-digit phone number" required>
          </div>
          
          <div class="mt-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" class="form-control" name="email" id="updateemail" required>
          </div>
           <div class="mt-3">
			  <label for="supervisor_id" class="form-label">Supervisor Id</label>
			  <input type="text" class="form-control" name="supervisor_id" id="updatesupervisor_id" required>
		  </div>
          
          
          
        </div>

        <div class="modal-footer">
		  <button type="submit" class="btn btn-purple">Save</button>
		  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
		</div>
      </form>
    </div>
  </div>
</div>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.5/xlsx.full.min.js"></script>
	<script src="https://kit.fontawesome.com/55f983e54b.js" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/assets/js/common.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/department.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>      
</body>
</html>
