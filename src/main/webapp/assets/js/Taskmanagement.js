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
