<?php
include 'util/config.php';
include 'util/const.php';

//Session start
session_start();

// Get username
$username = $_SESSION['curr_username'];
$user_role = $_SESSION['curr_user_role'];

//Get Connection with database
$mysqlConnect = require_once('../phpFile/connect_to_db.php');

if ($_SERVER['REQUEST_METHOD'] != 'GET') return;

if ($user_role == teacherType) {
    getTeacherInfo($mysqlConnect, $username);
} else {
    getStudentInfo($mysqlConnect, $username);
}


function getStudentInfo($mysqlConnect, $username)
{
    // Prepare and bind
    $sqlQuery = $mysqlConnect->prepare("SELECT username, fullname, email FROM student WHERE username = ?");
    $sqlQuery->bind_param("s", $username);
    $sqlQuery->execute();

    // Result of SQL query
    $result = $sqlQuery->get_result();
    $sqlQuery->close();

    // Check result from database
    if (!$result) {

        $json_obj = array(
            'status_code' => errorO,
            'error' =>  "<br>" . "Error: " . $sqlQuery->error . "<br>",
        );
        $jsonData = json_encode($json_obj);
        echo $jsonData;
    } else {
        $tuple = $result->fetch_assoc();

        $json_obj = array(
            'username' => $tuple['username'],
            'fullname' => $tuple['fullname'],
            'email' => $tuple['email']
        );
        $jsonData = json_encode($json_obj);
        echo $jsonData;

        $mysqlConnect->close();
    }
}

function getTeacherInfo($mysqlConnect, $username)
{

    // Prepare and bind
    $sqlQuery = $mysqlConnect->prepare("SELECT username, fullname, phonenumber, IdentityNumber, email FROM teacher WHERE username = ?");
    $sqlQuery->bind_param("s", $username);
    $sqlQuery->execute();

    // Result of SQL query
    $result = $sqlQuery->get_result();
    $sqlQuery->close();

    // Check result from database
    if (!$result) {

        $json_obj = array(
            'status_code' => failToAdd,
            'error' =>  "<br>" . "Error: " . $sqlQuery->error . "<br>",
        );
        $jsonData = json_encode($json_obj);
        echo $jsonData;
    } else {
        $tuple = $result->fetch_assoc();

        $json_obj = array(
            'username' => $tuple['username'],
            'fullname' => $tuple['fullname'],
            'phonenumber' => $tuple['phonenumber'],
            'identity_number' => $tuple['IdentityNumber'],
            'email' => $tuple['email']
        );
        $jsonData = json_encode($json_obj);
        echo $jsonData;


        $mysqlConnect->close();
    }
}
