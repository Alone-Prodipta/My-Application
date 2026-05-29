<?php
include 'db.php';
header("Content-Type: application/json");

try {
    $stmt = $conn->prepare("SELECT * FROM countries ORDER BY name ASC");
    $stmt->execute();
    $countries = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode(["status" => "success", "data" => $countries]);
} catch (PDOException $e) {
    echo json_encode(["status" => "error", "message" => $e->getMessage()]);
}
?>