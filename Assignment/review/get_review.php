<?php

$doctor_id = $_POST['doctor_id'];

$conn = require_once("../ASS1/connect_to_db.php");

echo queryReview($conn, $doctor_id);

$conn->close();

function queryReview($conn, $doctor_id)
{
    $sql = "SELECT review_id, reviewer_id, reviewer_full_name, doctor_id, doctor_full_name, content FROM review WHERE doctor_id = " . $doctor_id;

    $queryResult = $conn->query($sql);

    $reviewList = array();

    if ($queryResult->num_rows > 0) {
        while ($row = $queryResult->fetch_assoc()) {
            $data["review_id"] = $row["review_id"];
            $data["reviewer_id"] = $row["reviewer_id"];
            $data["reviewer_full_name"] = $row["reviewer_full_name"];
            $data["doctor_id"] = $row["doctor_id"];
            $data["doctor_full_name"] = $row["doctor_full_name"];
            $data["content"] = $row["content"];
            array_push($reviewList, $data);
        }
    }

    return json_encode($reviewList);
}
