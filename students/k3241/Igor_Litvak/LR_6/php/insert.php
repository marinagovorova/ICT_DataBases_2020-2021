<?php
$dbuser = "postgres";
$dbpass = "1";
$host = "localhost";
$dbname = "phone_station";
$db = pg_connect("host=$host dbname=$dbname user=$dbuser password=$dbpass");


if (isset($_POST["number"]) && isset($_POST["name"]) && isset($_POST["city"]) && isset($_POST["address"])) {
    $query = "insert into client(phone_number, full_name, city, address, balance)";
    $number = $_POST["number"];
    $name = $_POST["name"];
    $city = $_POST["city"];
    $address = $_POST["address"];
    $query .= " values ('$number', '$name', '$city', '$address', 0)";

    pg_query($db, $query);

    echo("<p>Inserted</p>");
    echo("<p><a href='select.php'>View whole table</a></p>");
    echo("<p><a href='../index.html'>Return to index</a></p>");
} else {
    echo("Error");
}
