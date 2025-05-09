//update popup
function fillUpdateForm(leaveId, leaveType, startDate, endDate, reason) {
	
	document.getElementById("leaveId").value = leaveId;
    document.getElementById("leaveType").value = leaveType;
    document.getElementById("startDate").value = startDate;
    document.getElementById("endDate").value = endDate;
	document.getElementById("reason").value = reason;
}

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
	   const toast = new bootstrap.Toast(document.getElementById('errorToast'));
	   document.querySelector("#errorToast .toast-header .me-auto").textContent = "Success";
	   document.querySelector("#errorToast .toast-body").textContent = "Leave record successfully deleted!";
	   toast.show();   
   
    } else if (status === 'error') {
      const toast = new bootstrap.Toast(document.getElementById('errorToast'));
      toast.show();
    }
  });	