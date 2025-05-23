document.addEventListener('DOMContentLoaded', function () {
    const loginBtn = document.getElementById('loginBtn');
    const alertBox = document.getElementById('alert');
    const form = document.getElementById('Form');
    const serverMessage = document.getElementById('serverMessage');

    if (!loginBtn || !alertBox || !form) return;

    // Show message if servlet sends back an error 
    if (serverMessage && serverMessage.textContent.trim() !== '') {
        showAlert(serverMessage.textContent.trim(), 'alert-error');
    }

    loginBtn.addEventListener('click', function (event) {
        event.preventDefault();

        const email = document.getElementById('email').value.trim();
        const password = document.getElementById('password').value.trim();
        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        // Reset alert box
        alertBox.style.display = 'none';
        alertBox.className = 'alert'; 
        alertBox.textContent = ''; 

        void alertBox.offsetWidth;

        // Frontend input validation
        if (!email || !password) {
            showAlert('Please fill in all fields', 'alert-error');
            return;
        }

        if (!emailPattern.test(email)) {
            showAlert('Invalid email address', 'alert-error');
            return;
        }

        // If all checks pass, show success message
         showAlert('Login Successful', 'alert-success');

        // Delay submission to allow user to read success message
        setTimeout(() => {
            form.submit(); 
        }, 2000);
    });

    function showAlert(message, type) {
        alertBox.textContent = message;
        alertBox.classList.add(type, 'fade-in'); 
        alertBox.style.display = 'block';
    }
});
