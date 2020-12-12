<?php

if (isset($_GET['page'])) {
    $page = $_GET['page'];
    switch ($page) {
        case "user_validate":
            include "../htmlFile/user_validate.html";
            return;
        case "teacher_register":
            include "../htmlFile/teacher_register.html";
            return;
        case "student_register":
            include "../htmlFile/student_register.html";
            return;
        case "login":
            include "../htmlFile/login.html";
            return;
        case "teacher_page":
            include "../htmlFile/teacher_page.html";
            return;
        case "student_page":
            include "../htmlFile/student_page.html";
            return;
        case "add_question":
            include "../htmlFile/add_question.html";
            return;
        case "search_question":
            include "../htmlFile/search_question.html";
            return;
        case "search_test":
            include "../htmlFile/search_test.html";
            return;
        case "take_test":
            include "../htmlFile/take_test.html";
            return;
        default:
            include "";
            return;
    }
}
