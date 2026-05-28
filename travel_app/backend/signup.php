<?php
// signup.php
header("Content-Type: application/json");
require_once 'db.php';

// Capture raw JSON data sent by the client application
$inputData = json_decode(file_get_contents("php://input"), true);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = trim($inputData['email'] ?? '');
    $password = trim($inputData['password'] ?? '');

    // Basic Validation
    if (empty($email) || empty($password)) {
        echo json_encode(["status" => "error", "message" => "Both email and password are required."]);
        exit();
    }

    // Hash the password securely using bcrypt encryption
    $hashedPassword = password_hash($password, PASSWORD_BCRYPT);

    try {
        // Prepare SQL statement to protect against SQL Injection
        $stmt = $conn->prepare("INSERT INTO users (email, password_hash) VALUES (:email, :password_hash)");
        $stmt->bindParam(':email', $email);
        $stmt->bindParam(':password_hash', $hashedPassword);
        
        if ($stmt->execute()) {
            echo json_encode([
                "status" => "success", 
                "message" => "Account created successfully!"
            ]);
        }
    } catch (PDOException $e) {
        // Check if the error is due to a duplicate email entry
        if ($e->getCode() == 23000) {
            echo json_encode(["status" => "error", "message" => "This email is already registered."]);
        } else {
            echo json_encode(["status" => "error", "message" => "Registration failed: " . $e->getMessage()]);
        }
    }
} else {
    echo json_encode(["status" => "error", "message" => "Invalid request method. Use POST."]);
}
?>