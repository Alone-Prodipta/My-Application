<?php
// submit_contact.php
header("Content-Type: application/json");
require_once 'db.php';

$inputData = json_decode(file_get_contents("php://input"), true);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $user_email = trim($inputData['email'] ?? '');
    $message = trim($inputData['message'] ?? '');

    if (empty($user_email) || empty($message)) {
        echo json_encode(["status" => "error", "message" => "Email and message contents cannot be empty."]);
        exit();
    }

    try {
        // Insert contact log details safely into database
        $stmt = $conn->prepare("INSERT INTO contact_messages (user_email, message) VALUES (:user_email, :message)");
        $stmt->bindParam(':user_email', $user_email);
        $stmt->bindParam(':message', $message);
        
        if ($stmt->execute()) {
            echo json_encode([
                "status" => "success", 
                "message" => "Contact message submitted successfully!"
            ]);
        }
    } catch (PDOException $e) {
        echo json_encode(["status" => "error", "message" => "Failed to save message: " . $e->getMessage()]);
    }
} else {
    echo json_encode(["status" => "error", "message" => "Invalid request method. Use POST."]);
}
?>