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

//Dark-Mode Toggle
const toggleBtn = document.getElementById('darkModeToggle');

window.addEventListener('DOMContentLoaded', () => {
    const darkMode = localStorage.getItem('darkMode');
    if (darkMode === 'enabled') {
        document.body.classList.add('dark-mode');
        toggleBtn.textContent = 'dark_mode';
    } else {
        toggleBtn.textContent = 'light_mode';
    }
});

toggleBtn.addEventListener('click', () => {
    document.body.classList.toggle('dark-mode');

    if (document.body.classList.contains('dark-mode')) {
        toggleBtn.textContent = 'dark_mode';
        localStorage.setItem('darkMode', 'enabled');
    } else {
        toggleBtn.textContent = 'light_mode';
        localStorage.setItem('darkMode', 'disabled');
    }
});

	
//search Bar function
function filterTable() {
	var input, filter, table, tr, td, i, txtValue;
	input = document.getElementById("searchInput");
	filter = input.value.toUpperCase();
	table= document.querySelector("table");
	tr = table.getElementsByTagName("tr");
	
	for (i = 0; i < tr.length; i++) {
		td = tr[i].getElementsByTagName("td");
		for (var j = 0; j < td.length; j++) {
			if (td[j]) {
				txtValue = td[j].textContent || td[j].innerText;
				if (txtValue.toUpperCase().indexOf(filter) > -1) {
					tr[i].style.display="";
					break;
				}else{
					tr[i].style.display="none";
				}
				
			}
		}
	}
}

document.getElementById("searchInput").addEventListener("input", filterTable);


