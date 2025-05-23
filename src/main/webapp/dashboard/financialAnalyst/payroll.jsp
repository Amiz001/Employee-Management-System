<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.*, com.ems.model.Payroll" %>


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
<title>Payroll</title>

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
     <a href="${pageContext.request.contextPath}/EmployeeInfoServlet"><i class="fa-solid fa-address-book"></i> Employee Info</a>
     <a href="${pageContext.request.contextPath}/PayrollGetAllServlet" class="active"><i class="fa-solid fa-file-invoice-dollar"></i> Payroll</a>
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
                <a href="${pageContext.request.contextPath}/FinanceProfileServlet"><i class="fas fa-user"></i> Profile</a>
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
      Payroll record successfully updated!
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
        <a href="${pageContext.request.contextPath}/PayrollDeleteServlet?pay_id=" id="deleteLink">
          <button type="button" class="btn btn-danger" id="confirmDelete" style="min-width: 150px">Yes, Delete</button>
        </a>
      </div>
    </div>
  </div>
</div>


<%  
String status = request.getParameter("status");
%>

<!-- Main Content-->
<div class="content">
    <h5 id="main-title">Employee salary</h5>
    <div class="table-container">
        <table class="table table-striped my-table">
            <thead>

                <div class="search-toolbar">   
                    <div class="search-box">
                        <i class="fas fa-search"></i>
                        <input type="text" id="searchInput" placeholder="Search...">
                    </div>
                  
                    <div class="toolbar-icons"> 
                        <span class="material-symbols-outlined" id="download-icon" onclick="downloadExcel()">download</span>
                    </div>
                </div>
                <tr>
                    <th>Payroll ID</th>
                    <th>Employee ID</th>
                    <th>Basic</th>
                    <th>OT</th>
                    <th>Allowance</th>
                    <th>Total Salary</th>
                    <th>Date</th>
                    <th>Actions</th>
                </tr>
            </thead>
            
            <%
            List<Payroll> payList = (List<Payroll>) request.getAttribute("allsalary");
            
		    if (payList != null) {
		        for (Payroll payroll : payList) {
			%>
                      
            <tr>

                  <td><%= payroll.getPay_id() %></td>
                  <td><%= payroll.getEmp_id() %></td>
                  <td><%= payroll.getBasic() %></td>
                  <td><%= payroll.getOt() %></td>
                  <td><%= payroll.getAllowance() %></td>
                  <td><%= payroll.getTotal_salary() %></td>
                  <td><%= payroll.getCreated_date() %></td>
                              
                  <td  style="display:flex; justify-content:center; align-items:center; gap:10px">               
                       <i class="fa-regular fa-pen-to-square" id="update-icon" data-bs-toggle="modal" data-bs-target="#updateEmployeeModal" onclick="fillUpdateForm('<%=payroll.getPay_id()%>', '<%=payroll.getEmp_id()%>', '<%=payroll.getBasic()%>', '<%=payroll.getOt()%>', '<%=payroll.getAllowance()%>',  '<%=payroll.getCreated_date()%>')"></i>
                       <a onclick="deleteForm('<%= payroll.getPay_id() %>')" data-bs-toggle="modal" data-bs-target="#deleteConfirmModal"><i class="fa-solid fa-trash-can" id="delete-icon"></i></a>                     
                  </td>
            </tr>
            <%
		        } 
	    	} else {
			%>
			        <tr><td colspan="2" style="text-align: center">No payroll records found</td></tr>
			<%
			    }
			%>
            
        </table>
    </div>
</div> 


<div class="modal fade" id="updateEmployeeModal" tabindex="-1" aria-labelledby="updateEmployeeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
      <form method="post" action="${pageContext.request.contextPath}/PayrollUpdateServlet">
        <div class="modal-header">
          <h5 class="modal-title" id="addEmployeeModalLabel">Edit Employee Salary</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>

        <div class="modal-body custom-scroll">
           <div class="mb-3">
            <label for="emp_id" class="form-label">Employee ID</label>
            <input type="number" class="form-control" name="emp_id" value="" id="updateemp_id" readonly>
          </div>
          
	      <div class="mb-3">
            <label for="basic" class="form-label">Basic Salary</label>
            <input type="number" class="form-control" name="basic" value="" id="updatebasic" readonly>
          </div>
          
          <input type="hidden" class="form-control" name="pay_id" value="" id="updatepay_id" required>
         
          <div class="mb-3">
            <label for="ot" class="form-label">Over Time</label>
            <input type="number" class="form-control" name="ot" value="" id="updateot" required>
          </div>
         
          <div class="mb-3">
            <label for="allowance" class="form-label">Allowance</label>
            <input type="number" class="form-control" name="allowance" value="" id="updateallowance" required>
          </div>
            
            <div class="col-md-6">
              <label for="updatecreated_date" class="form-label">Date</label>
              <input type="date" class="form-control" name="created_date" id="updatecreated_date" required>
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
	<script src="${pageContext.request.contextPath}/assets/js/payroll-script.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>   
</body>
</html>	