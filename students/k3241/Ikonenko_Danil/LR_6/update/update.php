<?php
$dbuser = 'postgres';
$dbpass = 'pogavi44';
$host = 'localhost';
$dbname = 'db';
$pdo = new PDO("pgsql:host=$host;dbname=$dbname", $dbuser, $dbpass);



if ($_POST['enter']) {
	echo "
		Last name: $_POST[last_name]<br>
		First name: $_POST[first_name]<br>
		Patronimic: $_POST[patronimic]<br>
		New passport data: $_POST[new_passport]<br>
		<br>";
}

$sql = 'UPDATE passenger
		SET passport = :new_passport
		WHERE last_name = :last_name AND
		first_name = :first_name AND
		patronimic = :patronimic';

$stmt = $pdo->prepare($sql);
$stmt->bindValue(':new_passport', $_POST['new_passport']);
$stmt->bindValue(':last_name', $_POST['last_name']);
$stmt->bindValue(':first_name', $_POST['first_name']);
$stmt->bindValue(':patronimic', $_POST['patronimic']);
$stmt->execute();

echo "<b>Passport data updated!</b>"; 
?>
