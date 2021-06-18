<?php
$dbuser = 'postgres';
$dbpass = '12345';
$host = 'localhost';
$dbname = 'Projects';
$pdo = new PDO("pgsql:host=$host;dbname=$dbname", $dbuser, $dbpass);
$deletion = <<<Q
delete from project_management.project where id_project=$_POST[id_project];
Q;
$pdo->query($deletion);

$query=<<<Q
select * from project_management.project
Q;
$result = $pdo->query($query);
echo "All available projects after deletion"."<br>";
while($row=$result->fetch()){
	echo $row['id_project']." ".$row['project_name'], "<br>";
}
?>