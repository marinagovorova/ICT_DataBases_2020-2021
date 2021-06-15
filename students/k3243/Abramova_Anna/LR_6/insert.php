<?php
$dbuser = 'postgres';
$dbpass = 'Artek1925';
$host = 'localhost';
$dbname = 'postgres';
$pdo = new PDO("pgsql:host=$host;dbname=$dbname", $dbuser, $dbpass);

if ($_POST['enter']) {
	echo "
		ID  $_POST[id]
		<br>
		Arrival date: $_POST[date_arrival]
		<br>
		Departure date: $_POST[date_departure]
		<br>
		Pay status: $_POST[pay_status]
		<br>
		Tabel number: $_POST[fk_tabel_number]
		<br>
		Passport number: $_POST[fk_passport_number]
		<br>
        Room number: $_POST[fk_room_number]
        <br>
	";
}


$sql = 'INSERT INTO train(id, date_arrival, train_name, departure, arrival, destination) 
		VALUES(:id, :date_arrival, :train_name, :departure, :arrival, :destination)';
$stmt = $pdo->prepare($sql);
$stmt->bindValue(':id', $_POST['id']);
$stmt->bindValue(':date_arrival', $_POST['date_arrival']);
$stmt->bindValue(':date_departure', $_POST['date_departure']);
$stmt->bindValue(':pay_status', $_POST['pay_status']);
$stmt->bindValue(':fk_tabel_number', $_POST['fk_tabel_number']);
$stmt->bindValue(':fk_passport_number', $_POST['fk_passport_number']);
$stmt->bindValue(':fk_room_number', $_POST['fk_room_number']);
$stmt->execute();
echo '<b> Values inserted!</b><br>';



?>