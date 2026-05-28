<?php
// db.php
$host = "localhost";
$db_name = "travel_app";
$username = "root"; // Default XAMPP username
$password = "Prodipta_007#";    

try {
    // Create a new secure PDO connection
    $conn = new PDO("mysql:host=$host;dbname=$db_name;charset=utf8", $username, $password);
    
    // Set error mode to exception so we can catch database errors easily
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    // If connection fails, output the error as JSON
    header("Content-Type: application/json");
    echo json_encode([
        "status" => "error", 
        "message" => "Database connection failed: " . $e->getMessage()
    ]);
    exit();
}
?>