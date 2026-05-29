<?php
include 'db.php';
header("Content-Type: application/json");

$data = json_decode(file_get_contents("php://input"), true);
$user_id = $data['user_id'];
$country_name = $data['country_name'];
$action = $data['action']; 

if ($action == 'fetch') {
    $stmt = $conn->prepare("SELECT note_content FROM user_diary_notes WHERE user_id = ? AND country_name = ?");
    $stmt->execute([$user_id, $country_name]);
    $note = $stmt->fetch(PDO::FETCH_ASSOC);
    echo json_encode(["status" => "success", "notes" => $note ? json_decode($note['note_content']) : []]);
} 

elseif ($action == 'save') {
    $note_content = json_encode($data['notes']);
    $stmt = $conn->prepare("INSERT INTO user_diary_notes (user_id, country_name, note_content) VALUES (?, ?, ?) 
                            ON DUPLICATE KEY UPDATE note_content = ?");
    $stmt->execute([$user_id, $country_name, $note_content, $note_content]);
    echo json_encode(["status" => "success"]);
}
?>