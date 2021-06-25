<?php
$dbuser = "postgres";
$dbpass = "1";
$host = "localhost";
$dbname = "phone_station";
$db = pg_connect("host=$host dbname=$dbname user=$dbuser password=$dbpass");

$query = "select * from client";
if (isset($_POST["city"]) && $_POST["city"] != "") {
    $city = $_POST["city"];
    $query .= " where city = '$city'";
}

$result = pg_query($db, $query);

$rows = pg_num_rows($result);
$fields = pg_num_fields($result);

$html = "<p>Result</p>";
$html .= "<table border='1'>";
$html .= "<tr><td>Number</td><td>Name</td><td>City</td><td>Street</td><td>Balance</td></tr>";
for ($i = 0; $i < $rows; $i++) {
    $html .= "<tr>";
    for ($j = 0; $j < $fields; $j++) {
        $cell = pg_fetch_result($result, $i, $j);
        $html .= "<td>$cell</td>";
    }
    $html .= "</tr>";
}
$html .= "</table>";
$html .= "<p><a href='select.php'>View whole table</a></p>";
$html .= "<p><a href='../index.html'>Return to index</a></p>";
echo $html;