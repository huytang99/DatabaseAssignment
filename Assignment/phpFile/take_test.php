<?php

include 'util/config.php';
include 'util/const.php';

$conn = require_once('../phpFile/connect_to_db.php');

echo take_test($conn);

$conn->close();

function take_test($conn)
{
    if (check_test($conn)) {
        $testid = $_POST['testid'];
        $answer = $_POST['answer'];

        $sql = "SELECT CorrectAnswerIndex FROM `question` WHERE TestID = " . $testid;

        $queryResult = $conn->query($sql);
        if (!$queryResult) {
            die("Failed to push question");
        }

        if ($queryResult->num_rows > 0) {
            $score = 0;
            while ($row = $queryResult->fetch_assoc()) {
                if ($row["CorrectAnswerIndex"] == $answer) {
                    $score += 1;
                }
            }
            $finalScore = ($score / $queryResult->num_rows) * 10;

            push_score($conn, $finalScore);

            return $finalScore;
        }
        return "No Question";
    } else {
        return "Test is not existed!";
    }
}

function check_test($conn)
{
    $testid = $_POST['testid'];

    $sql = "SELECT 1 FROM test WHERE TestID = " . $testid;

    $queryResult = $conn->query($sql);
    if (!$queryResult) {
        die("Failed to check test");
    }

    if ($queryResult->num_rows > 0) {
        return true;
    }
    return false;
}

function push_score($conn, $finalScore)
{
    $testid = $_POST['testid'];
    $studentname = $_POST['studentname'];
    $id = round(microtime(true) * 1000);
    $date = date("Y-m-d H:i:s");

    $sql = "INSERT INTO `take` (`TakeID`, `DateTake`, `Score`, `Duration`, `TestID`, `StudentUsername`) VALUES ('" . $id . "', '" . $date . "', " . $finalScore . ", 60, '" . $testid . "', '" . $studentname . "')";

    $queryResult = $conn->query($sql);
    if (!$queryResult) {
        die($sql);
    }
}
