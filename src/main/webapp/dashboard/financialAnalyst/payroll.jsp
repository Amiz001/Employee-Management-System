<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payroll-Employee Salary</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/payroll-style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css">
    <link rel="icon" href="assets/images/favicon.ico">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
</head>
<body>

<!-- Side bar -->
<div class="sidebar">
    <h2 class="title">Core<span style="color: #a05aff;">HR</span></h2>
    <div class="sidebar-profile">
         <img src="https://img.freepik.com/premium-photo/official-girl-iamges-hd-wallpaper-free-download-girl-model-with-pant-shairt-product-view-ad_88650-3237.jpg?w=2000">
         <p id="name">Sarah Smith</p>
         <p id="role">Financial Analyst</p></div>
         	
    <div class="features">
     <a href="${pageContext.request.contextPath}/dashboard/financialAnalyst/payrolldashboard.jsp"><i class="fa-solid fa-user"></i> Dashboard</a>
     <a href="${pageContext.request.contextPath}/dashboard/financialAnalyst/payrollemployees.jsp"><i class="fa-solid fa-user"></i> Employees</a>
     <a href="${pageContext.request.contextPath}/PayrollGetAllServlet" class="active"><i class="fa-solid fa-file-invoice-dollar"></i> Payroll</a>
     <a href="login.jsp" id="log-out"><i class="fa-solid fa-right-from-bracket"></i> Logout</a></div>
</div>


<!-- Navigation bar -->
<div class="nav-container">
    <nav class="menu-bar">
    	<span id="darkModeToggle" class="material-icons">light_mode</span>
    	<i id="bell" class="fa-solid fa-bell"></i>
        <div class="user-profile">
            <span>Sarah Smith</span>
            <img src="https://img.freepik.com/premium-photo/official-girl-iamges-hd-wallpaper-free-download-girl-model-with-pant-shairt-product-view-ad_88650-3237.jpg?w=2000"> 
        </div>
        
        <div class="dropdown-menu" id="dropdownMenu">
                <a href="#"><i class="fas fa-user"></i> Profile</a>
                <a href="#"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </nav>
</div>



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
                    	<span onclick="activatePopup()" id="add-icon" class="material-symbols-outlined">add_circle</span>

                        <span class="material-symbols-outlined" id="download-icon">download</span>     

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
            
            <c:forEach var="payroll" items="${allsalary}">
            <tr>

                  <td>${payroll.pay_id}</td>
                  <td>${payroll.emp_id}</td>
                  <td>Rs.${payroll.basic}</td>
                  <td>Rs.${payroll.ot}</td>
                  <td>Rs.${payroll.allowance}</td>
                  <td>Rs.${payroll.total_salary}</td>
                  <td>${payroll.date}</td>
                              
                   <td  style="display:flex; justify-content:center; align-items:center; gap:10px">                 

                       
                       <i class="fa-regular fa-pen-to-square" id="update-icon" onclick="activateUpdatePopup('${payroll.pay_id}', '${payroll.emp_id}', '${payroll.basic}', '${payroll.ot}', '${payroll.allowance}', '${payroll.total_salary}', '${payroll.date}')"></i>
                       <form action="PayrollDeleteServlet" method="post">
                       <input type="hidden" name="pay_id" value="${payroll.pay_id}"><button  style="border:none"><i class="fa-regular fa-trash-can" id="delete-icon"></i></button>
                       </form>
                    
                  </td>
            </tr>
            </c:forEach>
            
        </table>
    </div>
</div> 
    
<!-- Insert Popup-->
<div class="cover_box">
   <a href="PayrollGetAllServlet#">
      <span class="icon-close"><i onclick='deactivateCoverPopup()' class="fa-solid fa-xmark"></i></span>
   </a>
   <div class="form-box-login">
       <h2>Employee Salary</h2>
           <form action="${pageContext.request.contextPath}/PayrollInsertServlet" method="post">
               <div class="input-box">
                    <input type="text" id="emp_id" name="emp_id" required>
                    <label>Employee ID</label>
               </div>
               <div class="input-box">
                    <input type="text" id="basic" name="basic" required>
                    <label>Basic Salary</label>
               </div>   
               <div class="input-box">
                    <input type="text" id="ot" name="ot" required>
                    <label>Over Time</label>
               </div> 
               <div class="input-box">
                    <input type="text" id="allowance" name="allowance" required>
                    <label>Allowance</label>
               </div>
               <div class="input-box">
                    <input type="date" id="date" name="date" required>
                    <label>Date</label>
               </div>
               <button type="submit" class="btn">Submit</button>    
           </form>  
   </div>
</div> 

<div id="updatePopup" class="cover_box">
    <a href="PayrollGetAllServlet#">
        <span class="icon-close"><i onclick='deactivateUpdatePopup()' class="fa-solid fa-xmark"></i></span>
    </a>
    <div class="form-box-login">
        <h2>Employee Salary</h2>
        <form action="${pageContext.request.contextPath}/PayrollUpdateServlet" method="post">
              <div class="input-box">
                    <input type="text" id="updatePId" name="pay_id" required>
                    <label>Payroll ID</label>
               </div>
             <div class="input-box">
                    <input type="text" id="updateEId" name="emp_id" required>
                    <label>Employee ID</label>
               </div>
              <div class="input-box">
                    <input type="text" id="updateBasic" name="basic" required>
                    <label>Basic Salary</label>
              </div> 
              <div class="input-box">
                    <input type="text" id="updateOt" name="ot" required>
                    <label>Over Time</label>
              </div> 
              <div class="input-box">
                    <input type="text" id="updateAllowance" name="allowance" required>
                    <label>Allowance</label>
              </div>
               <div class="input-box">
                    <input type="date" id="updatedate" name="date" required>
                    <label>Date</label>
               </div>
              <button type="submit" class="btn">Update</button>    
        </form>       
    </div>
</div>      

 
<script> 
function filterTable() {
	var input, filter, table, tr, td, i, txtValue;
	input = document.getElementById("searchInput");
	filter = input.value.toUpperCase();
	table= document.querySelector("table");
	tr = table.getElementsByTagName("tr");
	
	for (i = 0; i < tr.length; i++) {
		td = tr[i].getElementsByTagName("td");
		for (var j = 0; j < td.length; j++) {
			if (td[j]) {
				txtValue = td[j].textContent || td[j].innerText;
				if (txtValue.toUpperCase().indexOf(filter) > -1) {
					tr[i].style.display="";
					break;
				}else{
					tr[i].style.display="none";
				}
				
			}
		}
	}
}

document.getElementById("searchInput").addEventListener("input", filterTable);
</script>

	<script src="https://kit.fontawesome.com/55f983e54b.js" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/assets/js/payroll-script.js"></script>
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>    
</body>
</html>	