<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee Salary - Payroll</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="stylesheet" href="../assets/css/payroll-style.css">
     
     
</head>
<body>

<!-- Side bar -->
<div class="sidebar">
    <h2 class="title">CoreHR</h2><br>
    <div class="profile">
         <img src="https://img.freepik.com/premium-photo/official-girl-iamges-hd-wallpaper-free-download-girl-model-with-pant-shairt-product-view-ad_88650-3237.jpg?w=2000">
         <p id="name">Sarah Smith</p>
         <p id="role">Financial Analyst</p></div>
    <div class="features">
     <a href="paydashboard.jsp"><i class="fa-solid fa-user"></i> Dashboard</a>
     <a href="PayGetAllServlet#" class="active"><i class="fa-solid fa-file-invoice-dollar"></i> Payroll</a><br><br><br><br><br><br>
     <a href="login.jsp"><i class="fa-solid fa-right-from-bracket"></i> Logout</a></div>
    
</div>


<!-- Main Content -->
<main class="contents">
    <header class="menu-bar">
        <div class="user-profile">
            <i class="fa-solid fa-bell"></i>
            <span>Sarah Smith</span>
            <img src="https://img.freepik.com/premium-photo/official-girl-iamges-hd-wallpaper-free-download-girl-model-with-pant-shairt-product-view-ad_88650-3237.jpg?w=2000">
           
        </div>
    </header>
</main>


<!-- Content -->
<div class="content">
    <h5>Employee salary</h5>
    <div class="table-container">
        <table class="table table-striped">
            <thead>

                <!-- Search & Tool bar --> 
                <div class="search-toolbar">
                    <!-- Search Box -->
                    <div class="search-box">
                        <i class="fas fa-search"></i>
                        <input type="text" id="searchInput" placeholder="Search...">
                    </div>
                    <!-- Tool bar Icons -->
                    <div class="toolbar-icons">
                        <i onclick="activatePopup()" class="fa-solid fa-plus" id="add-icon"></i>
                        <i class="fa-solid fa-download" id="download-icon"></i>
                       
                    </div>
                </div>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Basic</th>
                    <th>OT</th>
                    <th>Allowance</th>
                    <th>Salary</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <c:forEach var="payment" items="${allsalary}">
            <tr>
                  <td>${payment.id}</td>
                  <td><img src="https://i.pravatar.cc/40?img=1" class="employee-img">${payment.name}</td>
                  <td>Rs.${payment.basic}</td>
                  <td>Rs.${payment.ot}</td>
                  <td>Rs.${payment.allowance}</td>
                  <td>Rs.${payment.salary}</td>
          
                   <td  style="display:flex; justify-content:center; align-items:center; gap:10px">                 
                       <!--a href="payupdate.jsp?id=${payment.id}&name=${payment.name}&basic=${payment.basic}&ot=${payment.ot}&allowance=${payment.allowance}&salary=${payment.salary}"></a><button onclick="activateUpdatePopup()" style="border:none"><i class="fa-regular fa-pen-to-square"></i></button>-->
                       
                       
                       <i class="fa-regular fa-pen-to-square" id="update-icon" onclick="activateUpdatePopup('${payment.id}', '${payment.name}', '${payment.basic}', '${payment.ot}', '${payment.allowance}', '${payment.salary}')"></i>
                       <!--<i class="fa-regular fa-pen-to-square" onclick="activateUpdatePopup()?id=${payment.id}&name=${payment.name}&basic=${payment.basic}&ot=${payment.ot}&allowance=${payment.allowance}&salary=${payment.salary}"></i>-->
                       <form action="PayDeleteServlet" method="post">
                       <input type="hidden" name="id" value="${payment.id}"><button  style="border:none"><i class="fa-regular fa-trash-can" id="delete-icon"></i></button>
                       </form>
                    
                  </td>
            </tr>
            </c:forEach>
            
        </table>
    </div>
</div> 
    
<!-- Popup menu Insert Part-->
<div class="cover_box">
   <a href="PayGetAllServlet#">
      <span class="icon-close"><i onclick='deactivateCoverPopup()' class="fa-solid fa-xmark"></i></span>
   </a>
   <div class="form-box-login">
       <h2>Employee Salary</h2>
           <form action="PayInsertServlet" method="post">
            <!-- <div style="display: flex; gap: 20px; max-width: 500px"></div> 
               <div class="input-box">
                    <input type="text" id="id" name="id" readonly>
                    <label>ID</label>
               </div>-->
               <div class="input-box">
                    <input type="text" id="name" name="name" required>
                    <label>Name</label>
               </div>
               <div class="input-box">
                    <input type="text" id="basicc" name="basicc" required>
                    <label>Basic Salary</label>
               </div>   
               <div class="input-box">
                    <input type="text" id="ott" name="ott" required>
                    <label>Over Time</label>
               </div> 
               <div class="input-box">
                    <input type="text" id="allowancee" name="allowancee" required>
                    <label>Allowance</label>
               </div>
               <button type="submit" class="btn">Submit</button>
                
           </form> 
            
             
   </div>
</div> 

<div id="updatePopup" class="cover_box">
    <a href="PayGetAllServlet#">
        <span class="icon-close"><i onclick='deactivateUpdatePopup()' class="fa-solid fa-xmark"></i></span>
    </a>
    <div class="form-box-login">
        <h2>Employee Salary</h2>
        <form action="PayUpdateServlet" method="post">
              <div class="input-box">
                    <input type="text" id="updateId" name="id" required>
                    <label>ID</label>
              </div>
              <div class="input-box">
                    <input type="text" id="updateName" name="name" required>
                    <label>Name</label>
              </div>
              <div class="input-box">
                    <input type="text" id="updateBasic" name="basicc" required>
                    <label>Basic Salary</label>
              </div> 
              <div class="input-box">
                    <input type="text" id="updateOt" name="ott" required>
                    <label>Over Time</label>
              </div> 
              <div class="input-box">
                    <input type="text" id="updateAllowance" name="allowancee" required>
                    <label>Allowance</label>
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
<script src="../assets/js/payroll-script.js"></script>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>    
</body>
</html>