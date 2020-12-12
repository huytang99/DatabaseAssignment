<?php

include 'util/config.php';
include 'util/const.php';

$conn = require_once('../phpFile/connect_to_db.php');

queryTest($conn);

$conn->close();

function queryTest($conn)
{
    $id = $_POST['id'];

    $sql = "SELECT QuestionID, QuestionTitle, Answer1, Answer2, Answer3, Answer4, CorrectAnswerIndex FROM question where TestID = '" . $id . "'";

    $ExecQuery = MySQLi_query($conn, $sql);

    while ($QueryResult = MySQLi_fetch_array($ExecQuery)) {
        echo "<div><p>" . $QueryResult['QuestionID'] . "</p></div>";
        echo "<div><p>" . $QueryResult['QuestionTitle'] . "</p></div>";
        echo "<div><p>" . $QueryResult['Answer1'] . "</p></div>";
        echo "<div><p>" . $QueryResult['Answer2'] . "</p></div>";
        echo "<div><p>" . $QueryResult['Answer3'] . "</p></div>";
        echo "<div><p>" . $QueryResult['Answer4'] . "</p></div>";
        echo "<div><p>" . $QueryResult['CorrectAnswerIndex'] . "</p></div>";
    }
}
