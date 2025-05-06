//update popup
function fillUpdateForm(leaveId, leaveType, startDate, endDate, reason) {
	
	document.getElementById("leaveId").value = leaveId;
    document.getElementById("leaveType").value = leaveType;
    document.getElementById("startDate").value = startDate;
    document.getElementById("endDate").value = endDate;
	document.getElementById("reason").value = reason;
}