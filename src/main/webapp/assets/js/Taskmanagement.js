//update popup
function fillUpdateForm(updateTId, updateTitle, updateEId, updateDeadline, updateStartdate, updateStatus) {
    document.getElementById("updateTId").value = updateTId;
    document.getElementById("updateTitle").value = updateTitle;
    document.getElementById("updateEId").value = updateEId;
    document.getElementById("updateDeadline").value = updateDeadline;
    document.getElementById("updateStartdate").value = updateStartdate;
    document.getElementById("updateStatus").value = updateStatus;
}

//alert trigger
window.addEventListener('DOMContentLoaded', () => {
    const urlParams = new URLSearchParams(window.location.search);
    const status = urlParams.get('status');

    if (status === 'update_success') {
      const toast = new bootstrap.Toast(document.getElementById('successToast'));
	  document.querySelector("#successToast .toast-body").textContent = "Task record successfully updated!";
      toast.show();
	  
	} else if (status === 'add_success') {
	   const toast = new bootstrap.Toast(document.getElementById('successToast'));
	   document.querySelector("#successToast .toast-body").textContent = "Task record successfully added!";
	   toast.show();
	   
	} else if (status === 'delete_success') {
	   const toast = new bootstrap.Toast(document.getElementById('errorToast'));
	   document.querySelector("#errorToast .toast-header .me-auto").textContent = "Success";
	   document.querySelector("#errorToast .toast-body").textContent = "Task record successfully deleted!";
	   toast.show();   
   
    } else if (status === 'error') {
      const toast = new bootstrap.Toast(document.getElementById('errorToast'));
      toast.show();
    }
  });	
  
  
  //delete popup
  	function deleteForm(task_id){	
  		document.getElementById("deleteLink").href += task_id;
  	}
	
	
	//download icon	task
		function downloadTaskExcel() {
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
		    XLSX.utils.book_append_sheet(wb, ws, 'Task list');
		    XLSX.writeFile(wb, 'task_list.xlsx');
		 } 
		 
		 
		 //download icon employee
		 		function downloadEmployeeExcel() {
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
		 		    XLSX.utils.book_append_sheet(wb, ws, 'Employee list');
		 		    XLSX.writeFile(wb, 'Employee_list.xlsx');
		 		 } 
				 
				 
				 //download icon leave
				 	function downloadLeaveExcel() {
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
				 	    XLSX.utils.book_append_sheet(wb, ws, 'Leave request list');
				 	    XLSX.writeFile(wb, 'Leave_request_list.xlsx');
				 	 } 
				 
				 
				 
