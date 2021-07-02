<?php
$dbuser = 'postgres';
$dbpass = 'rayad223';
$host = 'localhost';
$dbname = 'postgres';
$pdo = new PDO("pgsql:host=$host;dbname=$dbname", $dbuser, $dbpass);



if ($_POST['enter']) {
	echo "
		Name: <b>$_POST[name]</b>
		<br><br>
	";
}

$sql = 'SELECT * FROM laba6.someinfo WHERE name = :name';

$result = pg_query($db, $sql);
$result = pg_fetch_assoc($result); 
echo $result['name'] . '</br>' . $result['number'];
pg_close($db);
?>