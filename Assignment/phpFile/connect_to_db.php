<?php
include_once 'util/config.php';

// Create connection to database
$conn = new mysqli($dbservername, $dbusername, $dbpassword, $dbname);

// Check connection with database
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

return $conn;