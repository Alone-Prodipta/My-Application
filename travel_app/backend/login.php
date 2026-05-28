<?php
// login.php
header("Content-Type: application/json");
require_once 'db.php';

$inputData = json_decode(file_get_contents("php://input"), true);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = trim($inputData['email'] ?? '');
    $password = trim($inputData['password'] ?? '');

    if (empty($email) || empty($password)) {
        echo json_encode(["status" => "error", "message" => "Both email and password are required."]);
        exit();
    }

    try {
        // Find the user by their email
        $stmt = $conn->prepare("SELECT id, password_hash FROM users WHERE email = :email");
        $stmt->bindParam(':email', $email);
        $stmt->execute();
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        // Check if user exists and verify the hashed password matches
        if ($user && password_verify($password, $user['password_hash'])) {
            echo json_encode([
                "status" => "success", 
                "message" => "Login successful!",
                "user_id" => $user['id']
            ]);
        } else {
            echo json_encode(["status" => "error", "message" => "Invalid email or password."]);
        }
    } catch (PDOException $e) {
        echo json_encode(["status" => "error", "message" => "Login failed: " . $e->getMessage()]);
    }
} else {
    echo json_encode(["status" => "error", "message" => "Invalid request method. Use POST."]);
}
?>