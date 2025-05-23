//alert trigger
window.addEventListener('DOMContentLoaded', () => {
    const urlParams = new URLSearchParams(window.location.search);
    const status = urlParams.get('status');

    if (status === 'update_success') {
      const toast = new bootstrap.Toast(document.getElementById('successToast'));
	  document.querySelector("#successToast .toast-body").textContent = "Leave record successfully updated!";
      toast.show();
	  
	} else if (status === 'add_success') {
	   const toast = new bootstrap.Toast(document.getElementById('successToast'));
	   document.querySelector("#successToast .toast-body").textContent = "Leave record successfully added!";
	   toast.show();
	   
	} else if (status === 'delete_success') {
	   const toast = new bootstrap.Toast(document.getElementById('deleteToast'));
	   toast.show();   
   
    } else if (status === 'error') {
      const toast = new bootstrap.Toast(document.getElementById('errorToast'));
      toast.show();
    }
  });	
  
  
  //insert popup validations
	document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector("#addEmployeeModal form");
    if (!form) return;

    const startInput = form.querySelector("input[name='startDate']");
    const endInput = form.querySelector("input[name='endDate']");

    const today = new Date().toISOString().split("T")[0];
    startInput.min = today;
    endInput.min = today;

    startInput.addEventListener("change", function () {
		const startDate = new Date(startInput.value);
		startDate.setDate(startDate.getDate() + 1);
		const minEndDate = startDate.toISOString().split("T")[0];

	    endInput.min = minEndDate;

      if (endInput.value < startDate) {
        endInput.value = startDate ;
      }
    });
	
  });
  
  
	//update popup
	function fillUpdateForm(leaveId, leaveType, startDate, endDate, reason) {	
		
		document.getElementById("leaveId").value = leaveId;
	    document.getElementById("leaveType").value = leaveType;
	    document.getElementById("startDate").value = startDate;
	    document.getElementById("endDate").value = endDate;
		document.getElementById("reason").value = reason;
	}
	
	
	//delete popup
	function deleteForm(leaveId){	
		document.getElementById("deleteLink").href += leaveId;
	}

	
	//download icon	leave
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
	    XLSX.utils.book_append_sheet(wb, ws, 'Leave list');
	    XLSX.writeFile(wb, 'leave_list.xlsx');
	 } 
	 
	 //download icon attendance
	 	function downloadAttendanceExcel() {
	 	    const table = document.querySelector('table');
	 	    const wb = XLSX.utils.book_new();
	 	    const ws_data = [];

	 	    const selectedColumnIndices = [0, 1, 2, 3, 4]; 

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
	 	    XLSX.utils.book_append_sheet(wb, ws, 'Attendance list');
	 	    XLSX.writeFile(wb, 'attendance_list.xlsx');
	 	 } 

