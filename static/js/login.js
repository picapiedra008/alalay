document.addEventListener("DOMContentLoaded", function () {
    // Manejador para mostrar/ocultar contraseña
    const togglePassword = document.querySelectorAll('.toggle-password');
    togglePassword.forEach(function (toggle) {
        toggle.addEventListener('click', function () {
            const icon = this.querySelector('i');
            const passwordField = this.nextElementSibling;
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            } else {
                passwordField.type = 'password';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            }
        });
    });
    // Validación del correo electrónico en tiempo real
    const emailInput = document.getElementById('email');
    const emailWarning = document.createElement('div');
    emailWarning.style.color = 'red';
    emailWarning.style.display = 'none';
    emailInput.parentNode.insertBefore(emailWarning, emailInput.nextSibling);

    emailInput.addEventListener('input', function() {
        const email = emailInput.value;

        if (email) {
            fetch('/check_email', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ email: email })
            })
            .then(response => response.json())
            .then(data => {
                if (data.exists) {
                    emailWarning.textContent = 'El email ya se encuentra registrado.';
                    emailWarning.style.display = 'block';
                    emailInput.classList.add('invalid');
                } else {
                    emailWarning.style.display = 'none';
                    emailInput.classList.remove('invalid');
                }
            });
        } else {
            emailWarning.style.display = 'none';
            emailInput.classList.remove('invalid');
        }
    });
});



const container = document.getElementById('container');
const registerBtn = document.getElementById('register');
const loginBtn = document.getElementById('login');

loginBtn.addEventListener('click', () => {
    container.classList.remove("active");
});

registerBtn.addEventListener('click', () => {
    container.classList.add("active");
});


function validateForm() {
    const form = document.getElementById('registerForm');
    const inputs = form.querySelectorAll('input[required]');
    let isValid = true;

    inputs.forEach(input => {
        if (!input.value) {
            input.classList.add('invalid');
            isValid = false;
        } else {
            input.classList.remove('invalid');
        }
    });

    if (!isValid) {
        alert('Por favor, complete todos los campos obligatorios.');
    }

    return isValid;
}

const emailInput = document.getElementById('email');

emailInput.addEventListener('invalid', () => {
    if (emailInput.validity.typeMismatch) {
        emailInput.setCustomValidity('Por favor, ingrese una dirección de correo electrónico válida.');
    } else {
        emailInput.setCustomValidity('');
    }
});
// Código de validación del formulario de registro
const registerForm = document.getElementById('registerForm');
registerForm.addEventListener('submit', function(event) {
    event.preventDefault();

    if (validateForm()) {
        const formData = new FormData(registerForm);
        fetch(registerForm.action, {
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                Swal.fire({
                    title: 'Registro exitoso',
                    text: 'Tu registro fue exitoso. ¡Bienvenido a campus alalay!',
                    icon: 'success',
                    confirmButtonText: 'aceptar'
                }).then(() => {
                    window.location.href = '/login';
                });
            } else {
                Swal.fire({
                    title: 'Error',
                    text: data.message,
                    icon: 'error',
                    confirmButtonText: 'Intentar de nuevo'
                });
            }
        });
    }
});
