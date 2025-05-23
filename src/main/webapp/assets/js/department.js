
function fillUpdateForm(updatedep_id, updatename, updateno_of_emp, updatephone, updateemail, updatesupervisor_id) {
  document.getElementById("updatedep_id").value = updatedep_id;
  document.getElementById("updatename").value = updatename;
  document.getElementById("updateno_of_emp").value = updateno_of_emp;
  document.getElementById("updatephone").value = updatephone;
  document.getElementById("updateemail").value = updateemail;
  document.getElementById("updatesupervisor_id").value = updatesupervisor_id;
}

//alert trigger
window.addEventListener('DOMContentLoaded', () => {
    const urlParams = new URLSearchParams(window.location.search);
    const status = urlParams.get('status');

    if (status === 'update_success') {
      const toast = new bootstrap.Toast(document.getElementById('successToast'));
	  document.querySelector("#successToast .toast-body").textContent = "Department record successfully updated!";
      toast.show();
	  
	} else if (status === 'add_success') {
	   const toast = new bootstrap.Toast(document.getElementById('successToast'));
	   document.querySelector("#successToast .toast-body").textContent = "Department record successfully added!";
	   toast.show();
	   
	} else if (status === 'delete_success') {
	   const toast = new bootstrap.Toast(document.getElementById('errorToast'));
	   document.querySelector("#errorToast .toast-header .me-auto").textContent = "Success";
	   document.querySelector("#errorToast .toast-body").textContent = "Department record successfully deleted!";
	   toast.show();   
   
    } else if (status === 'error') {
      const toast = new bootstrap.Toast(document.getElementById('errorToast'));
      toast.show();
    }
  });	
  
  
  //delete popup
  	function deleteForm(dep_id){	
  		document.getElementById("deleteLink").href += dep_id;
  	}

	
	//download icon department
	function downloadDepartmentExcel() {
		   const table = document.querySelector('table');
		   const wb = XLSX.utils.book_new();
		   const ws_data = [];

		   const selectedColumnIndices = [0, 1, 2, 3, 4, 5]; 

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
		   XLSX.utils.book_append_sheet(wb, ws, 'Department Details');
		   XLSX.writeFile(wb, 'department_details_selected.xlsx');
		   }	
	
