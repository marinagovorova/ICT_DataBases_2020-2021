<?php
$dbuser = 'postgres';
$dbpass = 'rayad223';
$host = 'localhost';
$dbname = 'postgres';
$pdo = new PDO("pgsql:host=$host;dbname=$dbname", $dbuser, $dbpass);



if ($_POST['enter']) {
	echo "
		Name: <b>$_POST[name]</b><br>
		<br>";
}

$sql = 'SELECT count(*) from laba6.someinfo';
$stmt = $pdo->prepare($sql);
$stmt->execute();
$rows_initial = $stmt->fetch(PDO::FETCH_ASSOC)['count'];

$sql = 'DELETE from laba6.someinfo
		WHERE name = :name';
		
$stmt = $pdo->prepare($sql);
$stmt->bindValue(':name', $_POST['name']);
$stmt->execute();

$sql = 'SELECT count(*) from laba6.someinfo';
$stmt = $pdo->prepare($sql);
$stmt->execute();
$rows_final = $stmt->fetch(PDO::FETCH_ASSOC)['count'];

echo "<b>Name deleted: " . $rows_initial - $rows_final . "</b>"; 

?>