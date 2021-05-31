<?php
$dbuser = 'postgres';
$dbpass = 'pogavi44';
$host = 'localhost';
$dbname = 'db';
$pdo = new PDO("pgsql:host=$host;dbname=$dbname", $dbuser, $dbpass);



if ($_POST['enter']) {
	echo "
		Train name: <b>$_POST[train_name]</b><br>
		<br>";
}

$sql = 'SELECT count(*) from train';
$stmt = $pdo->prepare($sql);
$stmt->execute();
$rows_initial = $stmt->fetch(PDO::FETCH_ASSOC)['count'];
# echo $rows_initial . "<br>";

$sql = 'DELETE from train
		WHERE train_name = :train_name';
		
$stmt = $pdo->prepare($sql);
$stmt->bindValue(':train_name', $_POST['train_name']);
$stmt->execute();

$sql = 'SELECT count(*) from train';
$stmt = $pdo->prepare($sql);
$stmt->execute();
$rows_final = $stmt->fetch(PDO::FETCH_ASSOC)['count'];
# echo $rows_final . "<br>";

echo "<b>Train(s) deleted: " . $rows_initial - $rows_final . "</b>"; 

?>
