<?php

include 'util/config.php';
include 'util/const.php';

$conn = require_once('../phpFile/connect_to_db.php');

queryTest($conn);

$conn->close();

function queryTest($conn)
{
    $name = $_POST['name'];

    $sql = "SELECT TakeID, DateTake, TestID, Score, Duration FROM take where StudentUsername = '" . $name . "'";

    $ExecQuery = MySQLi_query($conn, $sql);

    $Result = array();

    while ($QueryResult = MySQLi_fetch_array($ExecQuery)) {
        echo "<div><p>" . $QueryResult['TakeID'] . "</p></div>";
        echo "<div><p>" . $QueryResult['DateTake'] . "</p></div>";
        echo "<div><p>" . $QueryResult['TestID'] . "</p></div>";
        echo "<div><p>" . $QueryResult['Score'] . "</p></div>";
        echo "<div><p>" . $QueryResult['Duration'] . "</p></div>";
    }
}
