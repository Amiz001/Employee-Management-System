//insert popup
function activatePopup(){
    document.querySelector('.cover_box').classList.add('cover_box-active');
}

function deactivateCoverPopup(){
    document.querySelector('.cover_box').classList.remove('cover_box-active');
}

//update popup
function activateUpdatePopup(pay_id, emp_id, basic, ot, allowance, date) {
    document.getElementById("updatePopup").classList.add('cover_box-active');

    document.getElementById("updatePId").value = pay_id;
    document.getElementById("updateEId").value = emp_id;
    document.getElementById("updateBasic").value = basic;
    document.getElementById("updateOt").value = ot;
    document.getElementById("updateAllowance").value = allowance;
	document.getElementById("updatedate").value = date;
	
}

function deactivateUpdatePopup() {
    document.getElementById("updatePopup").classList.remove('cover_box-active');
}