<?php

$doctor_id = $_POST['doctor_id'];
$reviewer_id = $_POST['reviewer_id'];
$content = $_POST['content'];

if ($doctor_id == NULL or $content == NULL) {
    return NULL;
}

$conn = require_once("../ASS1/connect_to_db.php");

echo pushReview($conn, $doctor_id, $reviewer_id, $content);

$conn->close();

function getDoctorName($conn, $doctor_id)
{
    $sql = "SELECT full_name FROM doctor WHERE unique_id = " . $doctor_id;

    $queryResult = $conn->query($sql);

    if ($queryResult->num_rows > 0) {
        return $queryResult->fetch_assoc()["full_name"];
    }

    return NULL;
}

function getReviewerName($conn, $reviewer_id)
{
    $sql = "SELECT full_name FROM patient WHERE unique_id = " . $reviewer_id;

    $queryResult = $conn->query($sql);

    if ($queryResult->num_rows > 0) {
        return $queryResult->fetch_assoc()["full_name"];
    }

    return NULL;
}

function pushReview($conn, $doctor_id, $reviewer_id, $content)
{
    $doctor_full_name = getDoctorName($conn, $doctor_id);

    $reviewer_full_name = "null";
    if ($reviewer_id != "null") {
        $reviewer_full_name = getReviewerName($conn, $reviewer_id);
    }

    $sql = "INSERT INTO review (reviewer_id, reviewer_full_name, doctor_id, doctor_full_name, content) VALUES (" . $reviewer_id . ", \"" . $reviewer_full_name . "\", " . $doctor_id . ", \"" . $doctor_full_name . "\", \"" . $content . "\")";

    $queryResult = $conn->query($sql);
    if (!$queryResult) {
        die("Failed to push review");
    }

    echo true;
}
