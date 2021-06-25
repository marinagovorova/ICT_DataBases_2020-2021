<?php
$dbuser = "postgres";
$dbpass = "1";
$host = "localhost";
$dbname = "phone_station";
$db = pg_connect("host=$host dbname=$dbname user=$dbuser password=$dbpass");


if (isset($_POST["number"]) && isset($_POST["addbalance"])) {
    $query = "update client";
    $number = $_POST["number"];
    $addbalance = $_POST["addbalance"];
    $query .= " set balance = balance + $addbalance";
    $query .= " where phone_number = '$number'";

    pg_query($db, $query);

    echo("<p>Updated</p>");
    echo("<p><a href='select.php'>View whole table</a></p>");
    echo("<p><a href='../index.html'>Return to index</a></p>");
} else {
    echo("Error");
}
