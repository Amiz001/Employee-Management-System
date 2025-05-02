<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee Salary - Payroll</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" href="paydisplay.css">
<link rel="icon" href="../../assets/images/favicon.ico">
<link rel="icon" href="../../assets/images/favicon.ico">

</head>

<body>

<!-- Side bar -->
<div class="sidebar">
    <h2 class="sidebar-title">CoreHR</h2>
    
    <img src="https://img.freepik.com/premium-photo/official-girl-iamges-hd-wallpaper-free-download-girl-model-with-pant-shairt-product-view-ad_88650-3237.jpg?w=2000">
    <div id="sidebar-text">
    	<p id="p1">Sarah Smith</p>
    	<p id="p2">Financial Analyst</p>
    </div>
    
    
     <a href="paydashboard.jsp">Dashboard</a>
     <a href="PayGetAllServlet#">Payroll</a><br><br><br><br><br><br><br><br><br>
     <a href="login.jsp">Logout</a>
    
</div>


<!-- Main Content -->
<main class="contents">
    <header class="menu-bar">
        <div class="user-profile">
            <i class="fas fa-bell"></i>
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

                <div class="search-toolbar">                 
                    <div class="search-box">
                        <i class="fas fa-search"></i>
                        <input type="text" id="searchInput" placeholder="Search...">
                    </div>
                   
                    <div class="toolbar-icons">
                        <i onclick="activatePopup()" class="fas fa-plus-circle add-icon"></i>
                        <i class="fas fa-download download-icon"></i>
                    </div>
                </div>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Basic</th>
                    <th>OT</th>
                    <th>Allowance</th>
                    <th>Salary</th>
                    <th>Action</th>
                </tr>
            </thead>
            <c:forEach var="payment" items="${allsalary}">
            <tr>
                  <td>${payment.id}</td>
                  <td>${payment.name}</td>
                  <td>${payment.basic}</td>
                  <td>${payment.ot}</td>
                  <td>${payment.allowance}</td>
                  <td>${payment.salary}</td>
          
                   <td  style="display:flex; justify-content:center; align-items:center; gap:10px">                 
                       <!--<i onclick="activatePopup()" class="fa-regular fa-pen-to-square" ?id=${payment.id}&name=${payment.name}&basic=${payment.basic}&ot=${payment.ot}&allowance=${payment.allowance}&salary=${payment.salary}"></i>-->
                       <a href="payupdate.jsp?id=${payment.id}&name=${payment.name}&basic=${payment.basic}&ot=${payment.ot}&allowance=${payment.allowance}&salary=${payment.salary}"><i onclick="activatePopup()" class="fa-regular fa-pen-to-square"></i></a>
                       
                       
                       <form action="PayDeleteServlet" method="post">
                       <input type="hidden" name="id" value="${payment.id}"><button  style="border:none"><i class="fa-regular fa-trash-can"></i></button>
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
                <div class="input-box">
                    <input type="text" id="id" name="id" required>
                    <label>ID</label>
                </div>
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
    
<!-- Popup menu Update  Part-->
 <%
         
     String id= request.getParameter("id");
	 String name= request.getParameter("name");
	 String basic= request.getParameter("basic");
	 String ot= request.getParameter("ot");
     String allowance= request.getParameter("allowance");
	 String salary= request.getParameter("salary");
	 
 %>
     

    <div class="cover_box">
        <a href="PayGetAllServlet#">
        <span class="icon-close"><i onclick='deactivateCoverPopup()' class="fa-solid fa-xmark"></i></span>
        </a>
        <div class="form-box-login">
            <h2>Employee Salary</h2>
            <form action="PayUpdateServlet" method="post">
                <div class="input-box">
                    <input type="text" id="id" name="id" value="<%=id%>" readonly>
                    <label>ID</label>
                </div>
                <div class="input-box">
                    <input type="text" id="name" name="name" value="<%=name%>" required>
                    <label>Name</label>
                </div>
                <div class="input-box">
                    <input type="text" id="basicc" name="basicc" value="<%=basic%>" required>
                    <label>Basic Salary</label>
                </div> 
                <div class="input-box">
                    <input type="text" id="ott" name="ott" value="<%=ot%>" required>
                    <label>Over Time</label>
                </div> 
                <div class="input-box">
                    <input type="text" id="allowancee" name="allowancee" value="<%=allowance%>" required>
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
<script src="payinsert.js"></script>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>    
</body>
</html>