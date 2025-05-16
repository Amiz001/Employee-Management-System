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
  function fillUpdateForms(updateemp_id, updatebasic) {
     
      document.getElementById("updateemp_id").value = updateemp_id;
      document.getElementById("updatebasic").value = updatebasic;
    
  }