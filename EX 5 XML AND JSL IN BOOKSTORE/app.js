// ===== CART MANAGEMENT =====
function updateCartBadge() {
    const cartData = getCartItems();
    const badge = document.getElementById('cartBadge');
    if (badge) {
        badge.textContent = cartData.length;
    }
}

function getCartItems() {
    const cartJSON = localStorage.getItem('readhub_cart');
    return cartJSON ? JSON.parse(cartJSON) : [];
}

function saveCartItems(items) {
    localStorage.setItem('readhub_cart', JSON.stringify(items));
    updateCartBadge();
}

function addItemToCart(bookId, bookTitle, bookPrice, bookImage) {
    const cartItems = getCartItems();
    cartItems.push({
        id: bookId,
        title: bookTitle,
        price: parseFloat(bookPrice),
        image: bookImage,
        quantity: 1
    });
    saveCartItems(cartItems);
    
    showNotification('Added to cart!', 'success');
}

function removeFromCart(index) {
    const cartItems = getCartItems();
    cartItems.splice(index, 1);
    saveCartItems(cartItems);
    
    if (typeof loadCartPage === 'function') {
        loadCartPage();
    }
}

function updateQuantity(index, newQty) {
    if (newQty < 1) return;
    
    const cartItems = getCartItems();
    if (cartItems[index]) {
        cartItems[index].quantity = newQty;
        saveCartItems(cartItems);
        
        if (typeof loadCartPage === 'function') {
            loadCartPage();
        }
    }
}

function clearEntireCart() {
    if (confirm('Are you sure you want to remove all items from cart?')) {
        localStorage.removeItem('readhub_cart');
        updateCartBadge();
        
        if (typeof loadCartPage === 'function') {
            loadCartPage();
        }
    }
}

// ===== FORM VALIDATION =====
function validateEmail(email) {
    const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return regex.test(email);
}

function validateUsername(username) {
    const regex = /^[a-zA-Z0-9_]{3,20}$/;
    return regex.test(username);
}

function validatePassword(password) {
    return password.length >= 6;
}

function showError(fieldId, message) {
    const errorElement = document.getElementById(fieldId + 'Error');
    if (errorElement) {
        errorElement.textContent = message;
        errorElement.classList.add('show');
    }
}

function clearError(fieldId) {
    const errorElement = document.getElementById(fieldId + 'Error');
    if (errorElement) {
        errorElement.textContent = '';
        errorElement.classList.remove('show');
    }
}

function clearAllErrors() {
    const errorElements = document.querySelectorAll('.error-message');
    errorElements.forEach(el => {
        el.textContent = '';
        el.classList.remove('show');
    });
}

// ===== SIGNIN VALIDATION =====
function validateSignin(event) {
    event.preventDefault();
    clearAllErrors();
    
    const username = document.getElementById('username').value.trim();
    const password = document.getElementById('password').value;
    
    let isValid = true;
    
    if (!username) {
        showError('username', 'Username is required');
        isValid = false;
    } else if (!validateUsername(username)) {
        showError('username', 'Username must be 3-20 characters (letters, numbers, underscore only)');
        isValid = false;
    }
    
    if (!password) {
        showError('password', 'Password is required');
        isValid = false;
    } else if (!validatePassword(password)) {
        showError('password', 'Password must be at least 6 characters');
        isValid = false;
    }
    
    if (isValid) {
        document.getElementById('signinForm').submit();
    }
    
    return false;
}

// ===== SIGNUP VALIDATION =====
function validateSignup(event) {
    event.preventDefault();
    clearAllErrors();
    
    const fullname = document.getElementById('fullname').value.trim();
    const username = document.getElementById('username').value.trim();
    const email = document.getElementById('email').value.trim();
    const password = document.getElementById('password').value;
    const confirmPass = document.getElementById('confirm_password').value;
    
    let isValid = true;
    
    if (!fullname || fullname.length < 3) {
        showError('fullname', 'Full name must be at least 3 characters');
        isValid = false;
    }
    
    if (!username) {
        showError('username', 'Username is required');
        isValid = false;
    } else if (!validateUsername(username)) {
        showError('username', 'Username must be 3-20 characters (letters, numbers, underscore only)');
        isValid = false;
    }
    
    if (!email) {
        showError('email', 'Email is required');
        isValid = false;
    } else if (!validateEmail(email)) {
        showError('email', 'Please enter a valid email address');
        isValid = false;
    }
    
    if (!password) {
        showError('password', 'Password is required');
        isValid = false;
    } else if (!validatePassword(password)) {
        showError('password', 'Password must be at least 6 characters');
        isValid = false;
    }
    
    if (!confirmPass) {
        showError('confirm_password', 'Please confirm your password');
        isValid = false;
    } else if (password !== confirmPass) {
        showError('confirm_password', 'Passwords do not match');
        isValid = false;
    }
    
    if (isValid) {
        document.getElementById('signupForm').submit();
    }
    
    return false;
}

// ===== REAL-TIME VALIDATION =====
document.addEventListener('DOMContentLoaded', function() {
    // Update cart badge on page load
    updateCartBadge();
    
    // Add real-time validation to inputs
    const inputs = document.querySelectorAll('input');
    inputs.forEach(input => {
        input.addEventListener('blur', function() {
            validateField(this);
        });
        
        input.addEventListener('input', function() {
            clearError(this.id);
        });
    });
});

function validateField(field) {
    const fieldId = field.id;
    const value = field.value.trim();
    
    switch(fieldId) {
        case 'username':
            if (!value) {
                showError(fieldId, 'Username is required');
            } else if (!validateUsername(value)) {
                showError(fieldId, 'Username must be 3-20 characters (letters, numbers, underscore only)');
            }
            break;
            
        case 'email':
            if (!value) {
                showError(fieldId, 'Email is required');
            } else if (!validateEmail(value)) {
                showError(fieldId, 'Please enter a valid email address');
            }
            break;
            
        case 'password':
            if (!value) {
                showError(fieldId, 'Password is required');
            } else if (!validatePassword(value)) {
                showError(fieldId, 'Password must be at least 6 characters');
            }
            break;
            
        case 'fullname':
            if (!value || value.length < 3) {
                showError(fieldId, 'Full name must be at least 3 characters');
            }
            break;
    }
}

// ===== NOTIFICATION SYSTEM =====
function showNotification(message, type = 'info') {
    const notification = document.createElement('div');
    notification.className = `notification notification-${type}`;
    notification.textContent = message;
    notification.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        padding: 15px 25px;
        background: ${type === 'success' ? '#10b981' : type === 'error' ? '#ef4444' : '#2563eb'};
        color: white;
        border-radius: 8px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        z-index: 10000;
        animation: slideIn 0.3s ease;
    `;
    
    document.body.appendChild(notification);
    
    setTimeout(() => {
        notification.style.animation = 'slideOut 0.3s ease';
        setTimeout(() => notification.remove(), 300);
    }, 3000);
}

// Add CSS animations
const style = document.createElement('style');
style.textContent = `
    @keyframes slideIn {
        from {
            transform: translateX(400px);
            opacity: 0;
        }
        to {
            transform: translateX(0);
            opacity: 1;
        }
    }
    
    @keyframes slideOut {
        from {
            transform: translateX(0);
            opacity: 1;
        }
        to {
            transform: translateX(400px);
            opacity: 0;
        }
    }
`;
document.head.appendChild(style);