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
 