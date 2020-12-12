<?php
// Handle query case constant

// Session start
session_start();

include 'util/config.php';
include 'util/const.php';

//Get Connection with database
$mysqlConnect = require_once('connect_to_db.php');

//Get type of user and phone number from Front End
$username = $_POST['username'];

phone_validate($mysqlConnect, $username);

// Function to validate if the user exists or not
function phone_validate($mysqlConnect, $username)
{
    //Session start
    $_SESSION['curr_username'] = $username;

    $roleList = [teacherType, studentType];

    for ($x = 0; $x < 2; $x++) {
        // Prepare and bind
        $sqlQuery = $mysqlConnect->prepare("SELECT username FROM $roleList[$x] WHERE Username = ?");
        $sqlQuery->bind_param("s", $username);
        $sqlQuery->execute();

        // Result of SQL query
        $result = $sqlQuery->get_result();
        $sqlQuery->close();

        // Check the number of item in query result
        $numberOfRow = $result->num_rows;

        if (!$result) {
            $json_obj = array(
                'status_code' => failToAdd,
                'error' => "Error: " . $sqlQuery . "<br>" . $mysqlConnect->error,
            );
            $jsonData = json_encode($json_obj);
            echo $jsonData;
        } else if ($numberOfRow != 0) {
            // Exist teacher or student
            // Give access to account
            $_SESSION['curr_user_role'] = $roleList[$x];

            $json_obj = array(
                'status_code' => userExist,
                'role' => $roleList[$x]
            );
            $jsonData = json_encode($json_obj);
            echo $jsonData;
            return;
        }
    }

    $json_obj = array(
        'status_code' => userNotExist,
    );
    $jsonData = json_encode($json_obj);
    echo $jsonData;

    $mysqlConnect->close();
}
