<?php
$dbuser = 'postgres';
$dbpass = 'pogavi44';
$host = 'localhost';
$dbname = 'db';
$pdo = new PDO("pgsql:host=$host;dbname=$dbname", $dbuser, $dbpass);

if ($_POST['enter']) {
	echo "
		Train id: $_POST[id_train]
		<br>
		Train type: $_POST[type]
		<br>
		Train name: $_POST[train_name]
		<br>
		Departure: $_POST[departure]
		<br>
		Arrival: $_POST[arrival]
		<br>
		Destination: $_POST[destination]
		<br><br>
	";
}

/*
$stmt = $pdo->query('SELECT * FROM train');
while ($row = $stmt->fetch())
{
	echo $row['id_train'] . "<br>" . $row['train_name'] . "<br>" . "<br>";
}
*/

$sql = 'INSERT INTO train(id_train, type, train_name, departure, arrival, destination) 
		VALUES(:id_train, :type, :train_name, :departure, :arrival, :destination)';
$stmt = $pdo->prepare($sql);
$stmt->bindValue(':id_train', $_POST['id_train']);
$stmt->bindValue(':type', $_POST['type']);
$stmt->bindValue(':train_name', $_POST['train_name']);
$stmt->bindValue(':departure', $_POST['departure']);
$stmt->bindValue(':arrival', $_POST['arrival']);
$stmt->bindValue(':destination', $_POST['destination']);
$stmt->execute();
echo '<b> Values inserted!</b><br>';

/*
$stmt = $pdo->query('SELECT * FROM train');
while ($row = $stmt->fetch())
{
	echo $row['id_train'] . "<br>" . $row['train_name'] . "<br>" . "<br>";
}
*/

?>