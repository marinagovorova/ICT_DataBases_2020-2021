<?php
$dbuser = 'postgres';
$dbpass = '12345';
$host = 'localhost';
$dbname = 'Projects';
$pdo = new PDO("pgsql:host=$host;dbname=$dbname", $dbuser, $dbpass);
$query = <<<Q
SELECT PROJECT.id_project, PROJECT.project_name, PROJECT.project_status, PROJECT.start_date, PROJECT.end_date, CONCAT(EMPLOYEE.surname, ' ', EMPLOYEE.name) as head_of_project,
DEP.department_name, CLIENT.organisation_name
FROM project_management.project PROJECT
INNER JOIN project_management.employee EMPLOYEE ON PROJECT.employee_id = EMPLOYEE.id_employee
INNER JOIN project_management.client CLIENT ON PROJECT.client_id  = CLIENT.id_client
INNER JOIN project_management.department DEP ON EMPLOYEE.department_id = DEP.id_department
WHERE PROJECT.id_project ='$_POST[id_project]'
Q;
$result = $pdo->query($query);
while ($row = $result->fetch()){
	echo 
	"Project ID: " .$row['id_project']. "<br>" .
	"Название проекта: ".$row['project_name']. "<br>" .
	"Статус проекта: ".$row['project_status']."<br>" .
	"Дата начала: ".$row['start_date']."<br>" .
	"Дата окончания: ".$row['end_date']. "<br>".
	"Руководитель проекта: ".$row['head_of_project']."<br>" .
	"Клиент (организация): ".$row['organisation_name']."<br><br>";
}
echo "Список заданий: "."<br>";
$query = <<<Q
SELECT * FROM project_management.task WHERE project_id = '$_POST[id_project]'
Q;
$result = $pdo->query($query);

while ($row = $result->fetch()){
	
	echo 
	"ID Задания " .$row['id_task']. "<br>" .
	"Статус задания: ".$row['task_status']. "<br>" .
	"Описание задания: " .$row['task_description']."<br>" .
	"Дата начала: ".$row['start_date']."<br>" .
	"Дата окончания: ".$row['end_date']. "<br><br>";
}

?>