//insert popup
function activatePopup(){
    document.querySelector('.cover_box').classList.add('cover_box-active');
}

function deactivateCoverPopup(){
    document.querySelector('.cover_box').classList.remove('cover_box-active');
}

//update popup
function activateUpdatePopup(id, name, basic, ot, allowance, salary) {
    document.getElementById("updatePopup").classList.add('cover_box-active');

    document.getElementById("updateId").value = id;
    document.getElementById("updateName").value = name;
    document.getElementById("updateBasic").value = basic;
    document.getElementById("updateOt").value = ot;
    document.getElementById("updateAllowance").value = allowance;
}

function deactivateUpdatePopup() {
    document.getElementById("updatePopup").classList.remove('cover_box-active');
}