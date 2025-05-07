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

//dropdown menu
document.querySelector('.user-profile').addEventListener('click', function () {
    const dropdownMenu = document.getElementById('dropdownMenu');
    dropdownMenu.classList.toggle('show');
});

window.addEventListener('click', function (e) {
    const dropdownMenu = document.getElementById('dropdownMenu');
    const userProfile = document.querySelector('.user-profile');
    if (!userProfile.contains(e.target)) {
        dropdownMenu.classList.remove('show');
    }
});