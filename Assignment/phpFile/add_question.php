<?php

include 'util/config.php';
include 'util/const.php';

$conn = require_once('../phpFile/connect_to_db.php');

echo push_question($conn);

$conn->close();

function push_question($conn)
{
    if (check_test($conn)) {
        $testid = $_POST['testid'];
        $question = $_POST['question'];
        $answer1 = $_POST['answer1'];
        $answer2 = $_POST['answer2'];
        $answer4 = $_POST['answer4'];
        $answer3 = $_POST['answer3'];
        $correctanswer = $_POST['correctanswer'];
        $id = round(microtime(true) * 1000);

        $sql = "INSERT INTO `question` (`TestID`, `QuestionID`, `QuestionTitle`, `Answer1`, `Answer2`, `Answer3`, `Answer4`, `CorrectAnswerIndex`) VALUES ('" . $testid . "', '" . $id . "', '" . $question . "' ,'" . $answer1 . "', '" . $answer2 . "', '" . $answer3 . "', '" . $answer4 . "', " . $correctanswer . ")";

        $queryResult = $conn->query($sql);
        if (!$queryResult) {
            die("Failed to push question");
        }
        return "Question created";
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
        die("Failed to push question");
    }

    if ($queryResult->num_rows > 0) {
        return true;
    }
    return false;
}
