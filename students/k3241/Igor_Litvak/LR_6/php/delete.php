<?php
$dbuser = "postgres";
$dbpass = "1";
$host = "localhost";
$dbname = "phone_station";
$db = pg_connect("host=$host dbname=$dbname user=$dbuser password=$dbpass");


if (isset($_POST["number"])) {
    $query = "delete from client";
    $number = $_POST["number"];
    $query .= " where phone_number = '$number'";

    pg_query($db, $query);

    echo("<p>Deleted</p>");
    echo("<p><a href='select.php'>View whole table</a></p>");
    echo("<p><a href='../index.html'>Return to index</a></p>");
} else {
    echo("Error");
}
