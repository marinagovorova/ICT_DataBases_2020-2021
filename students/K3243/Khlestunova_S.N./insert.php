<?php
$dbuser = 'postgres';
$dbpass = 'rayad223';
$host = 'localhost';
$dbname = 'postgres';
$pdo = new PDO("pgsql:host=$host;dbname=$dbname", $dbuser, $dbpass);

if ($_POST['enter']) {
	echo "
		Name: $_POST[name]
		<br>
		Number: $_POST[number]
		<br><br>
	";
}


$sql = 'INSERT INTO laba6.someinfo VALUES(:name, :number)';
$stmt = $pdo->prepare($sql);
$stmt->bindValue(':name', $_POST['name']);
$stmt->bindValue(':number', $_POST['number']);
$stmt->execute();
echo '<b> Values inserted!</b><br>';

?>