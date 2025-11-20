<?php
/**
 * Database Connection Configuration
 * ReadHub Online Bookstore
 */

// Database credentials
define('DB_HOST', 'localhost');
define('DB_USER', 'root');
define('DB_PASS', '');
define('DB_NAME', 'readhub_library');

// Create database connection
$database_connection = mysqli_connect(DB_HOST, DB_USER, DB_PASS, DB_NAME);

// Check if connection was successful
if ($database_connection === false) {
    die("ERROR: Could not connect to database. " . mysqli_connect_error());
}

// Set character encoding to UTF-8
mysqli_set_charset($database_connection, "utf8mb4");

// Function to sanitize input
function sanitize_input($data) {
    global $database_connection;
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data);
    return mysqli_real_escape_string($database_connection, $data);
}

// Function to close database connection
function close_connection() {
    global $database_connection;
    if ($database_connection) {
        mysqli_close($database_connection);
    }
}
?>