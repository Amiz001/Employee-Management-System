//update popup
function fillUpdateForm(updatepay_id, updateemp_id, updatebasic, updateot, updateallowance, updatecreated_date) {

    document.getElementById("updatepay_id").value = updatepay_id;
    document.getElementById("updateemp_id").value = updateemp_id;
    document.getElementById("updatebasic").value = updatebasic;
    document.getElementById("updateot").value = updateot;
    document.getElementById("updateallowance").value = updateallowance;
	document.getElementById("updatecreated_date").value = updatecreated_date;
}

//alert trigger
window.addEventListener('DOMContentLoaded', () => {
    const urlParams = new URLSearchParams(window.location.search);
    const status = urlParams.get('status');

    if (status === 'update_success') {
      const toast = new bootstrap.Toast(document.getElementById('successToast'));
	  document.querySelector("#successToast .toast-body").textContent = "Payroll record successfully updated!";
      toast.show();
	  
	} else if (status === 'add_success') {
	   const toast = new bootstrap.Toast(document.getElementById('successToast'));
	   document.querySelector("#successToast .toast-body").textContent = "Payroll record successfully added!";
	   toast.show();
	   
	} else if (status === 'delete_success') {
	   const toast = new bootstrap.Toast(document.getElementById('errorToast'));
	   document.querySelector("#errorToast .toast-header .me-auto").textContent = "Success";
	   document.querySelector("#errorToast .toast-body").textContent = "Payroll record successfully deleted!";
	   toast.show();   
   
    } else if (status === 'error') {
      const toast = new bootstrap.Toast(document.getElementById('errorToast'));
      toast.show();
    }
 });	
  
 //update popup
 function UpdateForm(emp_idid, basicc) {
     
	  document.getElementById("emp_idid").value = emp_idid;
	  document.getElementById("basicc").value = basicc;
    
}
  
//delete popup
function deleteForm(pay_id){	
  	  document.getElementById("deleteLink").href += pay_id;
}

//download icon	payroll
function downloadExcel() {
    const table = document.querySelector('table');
    const wb = XLSX.utils.book_new();
    const ws_data = [];

    const selectedColumnIndices = [0, 1, 2, 3, 4, 5, 6]; 

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
    XLSX.utils.book_append_sheet(wb, ws, 'Employee Salary');
    XLSX.writeFile(wb, 'employee_salary_selected.xlsx');
 }  		
 
 
//download icon employee
function downloadEmployeeColumnsExcel() {
   const table = document.querySelector('table');
   const wb = XLSX.utils.book_new();
   const ws_data = [];

   const selectedColumnIndices = [0, 1, 2, 3, 4, 5, 6, 7, 8]; 

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