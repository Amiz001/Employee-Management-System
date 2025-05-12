//update popup
function fillUpdateForm(empId, name, email, phone, department, dob, gender, role, profilePhoto) {
    document.getElementById('empId').value = empId;
    document.getElementById('Ename').value = name;
    document.getElementById('email').value = email;
    document.getElementById('phone').value = phone;
    document.getElementById('department').value = department;
    document.getElementById('dob').value = dob;
   	document.getElementById('Erole').value = role;
	//document.getElementById('profilePhoto').value = profilePhoto;
	document.getElementById("profileImg").src += profilePhoto;

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