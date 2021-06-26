<?php
$dbuser = 'postgres';
$dbpass = 'pogavi44';
$host = 'localhost';
$dbname = 'db';
$pdo = new PDO("pgsql:host=$host;dbname=$dbname", $dbuser, $dbpass);



if ($_POST['enter']) {
	echo "
		Train name: <b>$_POST[train_name]</b>
		<br><br>
	";
}

$sql = 'SELECT train.id_train, train.train_name, train.destination,
		carriage.id_carriage, carriage.type, 
		seat.seat_number, seat.seat_type FROM train 
		FULL JOIN carriage ON train.id_train = carriage.id_train
		FULL JOIN seat ON carriage.id_carriage = seat.id_carriage
		FULL JOIN ticket ON seat.id_seat = ticket.id_seat
		WHERE ticket.id_ticket IS NULL AND 
		train.train_name = :train_name';

$stmt = $pdo->prepare($sql);
$stmt->bindValue(':train_name', $_POST['train_name']);
$stmt->execute();

$i = 0;
while ($row = $stmt->fetch(PDO::FETCH_ASSOC))
{
	$i++;
	echo 
		"Место " . $i . "<br>" .
		"Carriage number: " . $row['id_carriage'] . "<br>" . 
		"Carriage type: " . $row['type'] . "<br>" .
		"Seat number: " . $row['seat_number'] . "<br>" .
		"Seat type: " . $row['seat_type'] . "<br><br>";
}
?>
