<?php
$dbuser = 'postgres';
$dbpass = '12345';
$host = 'localhost';
$dbname = 'Projects';
$pdo = new PDO("pgsql:host=$host;dbname=$dbname", $dbuser, $dbpass);
$insertion = <<<Q
insert into project_management.project(
id_project,
project_name,
project_status,
start_date,
end_date,
client_id,
employee_id)
values(
(SELECT(MAX(id_project)+1) from project_management.project),
'$_POST[project_name]',
'$_POST[project_status]',
'$_POST[start_date]',
'$_POST[end_date]',
'$_POST[organisation_id]',
'$_POST[employee_id]'
);
Q;
$pdo->query($insertion);

$query=<<<Q
select * from project_management.project
Q;
$result = $pdo->query($query);
echo "All projects after insertion: ". "<br>";
while($row = $result->fetch()){
	echo $row['id_project']." ".$row["project_name"], "<br>";
}
?>
