<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.*, com.ems.model.Taskmanagement" %>

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
     <a href="${pageContext.request.contextPath}/dashboard/supervisor/dashboard.jsp"><i class="fa-solid fa-user"></i> Dashboard</a>
     <a href="${pageContext.request.contextPath}/TaskmanagementServlet" class="active"><i class="fa-solid fa-list-check"></i>Task</a>
     <a href="${pageContext.request.contextPath}/EmployeeInfo2Servlet"><i class="fa-solid fa-address-book"></i> Employee info</a>
     <a href="${pageContext.request.contextPath}/LeaveManageServlet"><i class="fa-solid fa-person-walking-arrow-right"></i> Leave Requests</a>
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
      Task record successfully updated!
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
        <a href="${pageContext.request.contextPath}/TaskmanagementDeleteServlet?task_id=" id="deleteLink"><button type="button" class="btn btn-danger" id="confirmDelete" style="min-width: 150px">Yes, Delete</button></a>

      </div>
    </div>
  </div>
</div>


<%  
String status = request.getParameter("status");
%>


<!-- Main Content-->
<div class="content">
    <h5 id="main-title">Start working from here</h5>
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
                        <span class="material-symbols-outlined" id="download-icon">download</span>     
                    </div>
                </div>
                <tr>
                    
            <th>Task ID</th>
            <th>Title</th>
            <th>Employee ID</th>
            <th>Deadline</th>
            <th>Start Date</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
       </thead>
            
            <%
            List<Taskmanagement> taskList = (List<Taskmanagement>) request.getAttribute("taskDetails");
            
		    if (taskList != null) {
		        for (Taskmanagement task : taskList) {
			%>
			

            <tr>
                <td><%= task.getTask_id() %></td>
                <td><%= task.getTitle() %></td>
                <td><%= task.getEmp_id() %></td>
                <td><%= task.getDeadline() %></td>
                <td><%= task.getStart_date() %></td>
                <td><%= task.getStatus() %></td>
                
                <td  style="display:flex; justify-content:center; align-items:center; gap:10px">                 
                       
	                <i class="fa-regular fa-pen-to-square" id="update-icon" data-bs-toggle="modal" data-bs-target="#updateEmployeeModal" onclick="fillUpdateForm('<%= task.getTask_id() %>', '<%= task.getTitle()%>', '<%=task.getEmp_id()%>', '<%=task.getDeadline()%>','<%=task.getStart_date()%>','<%= task.getStatus() %>')"></i>
	                <a onclick="deleteForm('<%= task.getTask_id() %>')" data-bs-toggle="modal" data-bs-target="#deleteConfirmModal"><i class="fa-solid fa-trash-can" id="delete-icon"></i></a>
     
                </td>    
            </tr>
           
            <%
		        } 
	    	} else {
			%>
			        <tr><td colspan="2" style="text-align: center">No task records found</td></tr>
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
      <form method="post" action="${pageContext.request.contextPath}/TaskmanagementInsertServlet">
        <div class="modal-header">
          <h5 class="modal-title" id="addEmployeeModalLabel">Add Employee Tasks</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
  
        <div class="modal-body custom-scroll">
          <div class="mb-3">
            <label for="title" class="form-label">Title</label>
            <input type="text" class="form-control" name="title" required>
          </div>
          
          <div class="mb-3">
            <label for="emp_id" class="form-label">Employee ID</label>
            <input type="number" class="form-control" name="emp_id" required>
          </div>

          <div class="row g-3">
            <div class="col-md-6">
              <label for="deadline" class="form-label">Deadline</label>
              <input type="date" class="form-control" name="deadline" required>
            </div>
            <div class="col-md-6">
              <label for="start_date" class="form-label">Start Date</label>
              <input type="date" class="form-control" name="start_date" required>
            </div>
          </div>

           <div class="mt-3">
            <label for="status" class="form-label">Status</label>
            <select class="form-select" name="status" required>
              <option value="Pending">Pending</option>
              <option value="In Progress">In Progress</option>
              <option value="Completed">Completed</option>
            </select>
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
      <form method="post" action="${pageContext.request.contextPath}/TaskmanagementUpdateServlet">
        <div class="modal-header">
          <h5 class="modal-title" id="addEmployeeModalLabel">Edit Employee Tasks</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>

        <div class="modal-body custom-scroll">
          <div class="mb-3">
            <label for="title" class="form-label">Title</label>
            <input type="text" class="form-control" name="title" value="" id="updateTitle" required>
          </div>
			<input type="hidden" class="form-control" name="task_id" value="" id="updateTId" required>
			
		<div class="mb-3">
            <label for="emp_id" class="form-label">Employee ID</label>
            <input type="number" class="form-control" name="emp_id" id="updateEId" required>
         </div>
			
          <div class="row g-3">
            <div class="col-md-6">
              <label for="deadline" class="form-label">Deadline</label>
              <input type="date" class="form-control" name="deadline" value="" id="updateDeadline" required>
            </div>
            <div class="col-md-6">
              <label for="start_date" class="form-label">Start Date</label>
              <input type="date" class="form-control" name="start_date" id="updateStartdate" value="" required>
            </div>
          </div>

          <div class="mt-3">
            <label for="status" class="form-label">Status</label>
            <select class="form-select" name="status" id="updateStatus" required>
              <option value="Pending">Pending</option>
              <option value="In Progress">In Progress</option>
              <option value="Completed">Completed</option>
            </select>
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
	<script src="${pageContext.request.contextPath}/assets/js/Taskmanagement.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>    
</body>
</html>