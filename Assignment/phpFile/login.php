<?php
include 'util/config.php';
include 'util/const.php';

//Session start
session_start();

// Get username
$username = $_SESSION['curr_username'];
$user_role = $_SESSION['curr_user_role'];

// Send username back to front end
if ($_SERVER['REQUEST_METHOD'] == 'GET') {

    if (is_null($username)) return;
    else {
        $json_obj = array(
            'username' => $username,
            'user_role' => $user_role,
        );
        $jsonData = json_encode($json_obj);
        echo $jsonData;
    }

    return;
}

//Check if user does NOT provide enough infomation
if (
    !isset($_POST['password'])
) {
    $json_obj = array(
        'status_code' => notEnoughInfo,
    );
    $jsonData = json_encode($json_obj);
    echo $jsonData;
    return;
} elseif (
    $_POST['password'] == ''
) {
    $json_obj = array(
        'status_code' => notEnoughInfo,
    );
    $jsonData = json_encode($json_obj);
    echo $jsonData;
    return;
}

//Get Connection with database
$mysqlConnect = require_once('../phpFile/connect_to_db.php');

//Get password
$password = $_POST['password'];

login(
    $mysqlConnect,
    $username,
    $password,
    $user_role
);

// Add new patient to database
function login(
    $mysqlConnect,
    $username,
    $password,
    $user_role
) {

    // Prepare and bind
    $sqlQuery = $mysqlConnect->prepare("SELECT * FROM $user_role WHERE username = ? AND password = ?");
    $sqlQuery->bind_param("ss", $username, $password);
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
        if ($result->num_rows == 1) {
            $json_obj = array(
                'status_code' => loginSuccess,
            );
            $jsonData = json_encode($json_obj);
            echo $jsonData;
        } else {
            $json_obj = array(
                'status_code' => wrongPassword,
            );
            $jsonData = json_encode($json_obj);
            echo $jsonData;
        }

        $mysqlConnect->close();
    }
}
