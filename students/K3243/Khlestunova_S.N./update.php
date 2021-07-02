<?php
$dbuser = 'postgres';
$dbpass = 'rayad223';
$host = 'localhost';
$dbname = 'postgres';
$pdo = new PDO("pgsql:host=$host;dbname=$dbname", $dbuser, $dbpass);



if ($_POST['enter']) {
	echo "
		Name: $_POST[name]<br>
		New number: $_POST[new_number]<br>
		<br>";
}

$sql = 'UPDATE laba6.someinfo
		SET number = :new_number
		WHERE name = :name';

$stmt = $pdo->prepare($sql);
$stmt->bindValue(':new_number', $_POST['new_number']);
$stmt->bindValue(':name', $_POST['name']);
$stmt->execute();

echo "<b>Data updated!</b>"; 
?>