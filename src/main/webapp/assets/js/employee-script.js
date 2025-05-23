//update popup
function fillUpdateForm(empId, name, email, phone, department, dob, gender, role, leaveCount, basicSalary) {
    document.getElementById('empId').value = empId;
    document.getElementById('Ename').value = name;
    document.getElementById('email').value = email;
    document.getElementById('phone').value = phone;
    document.getElementById('department').value = department;
    document.getElementById('dob').value = dob;
	document.getElementById('leaveCount').value = leaveCount;
	document.getElementById('basicSalary').value = basicSalary;
    document.getElementById('Erole').value = role;

    if (gender === 'Male') {
      document.getElementById('genderMale').checked = true;
    } else if (gender === 'Female') {
      document.getElementById('genderFemale').checked = true;
    }
  }
  
  //alert trigger
  window.addEventListener('DOMContentLoaded', () => {
      const urlParams = new URLSearchParams(window.location.search);
      const status = urlParams.get('status');

	  if (status === 'update_success') {
	    const toast = new bootstrap.Toast(document.getElementById('successToast'));
	    document.querySelector("#successToast .toast-body").textContent = "Employee record successfully updated!";
	    toast.show();
	    
	  } else if (status === 'add_success') {
	     const toast = new bootstrap.Toast(document.getElementById('successToast'));
	     document.querySelector("#successToast .toast-body").textContent = "Employee record successfully added!";
	     toast.show();
  	   
	  	} else if (status === 'delete_success') {
	  	   const toast = new bootstrap.Toast(document.getElementById('errorToast'));
	  	   document.querySelector("#errorToast .toast-header .me-auto").textContent = "Success";
	  	   document.querySelector("#errorToast .toast-body").textContent = "Employee record successfully deleted!";
	  	   toast.show();   
	     
	      } else if (status === 'error') {
	        const toast = new bootstrap.Toast(document.getElementById('errorToast'));
	        toast.show();
      }
    });
	
	//download icon employee
	function downloadEmployeeExcel() {
	   const table = document.querySelector('table');
	   const wb = XLSX.utils.book_new();
	   const ws_data = [];

	   const selectedColumnIndices = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]; 

	   const headerRow = [];
	   const headerCells = table.querySelectorAll('thead th');
	   selectedColumnIndices.forEach(index => {
	     headerRow.push(headerCells[index].textContent);
	   });
	   ws_data.push(headerRow);

	   const dataRows = table.querySelectorAll('tbody tr');
	   dataRows.forEach(row => {
	     const rowData = [];
	     const cells = row.querySelectorAll('td');
	     selectedColumnIndices.forEach(index => {
	       rowData.push(cells[index].textContent);
	     });
	     ws_data.push(rowData);
	   });

	   const ws = XLSX.utils.aoa_to_sheet(ws_data);
	   XLSX.utils.book_append_sheet(wb, ws, 'Employee Details');
	   XLSX.writeFile(wb, 'employee_details_selected.xlsx');
	   }