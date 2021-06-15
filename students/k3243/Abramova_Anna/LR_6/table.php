<?
$table_name = $_GET['table_name'];
require_once "config.php";


?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> <?echo $table_name?> </title>
</head>
<body>
    <div class="container">
		<div class="top-bar d-flex pt-3 pb-3 justify-content-between">
			<div class="title">
				<h2 class="m-0"><?echo $table_name?></h2>
			</div>
			<div class="">
				<a href="/mysite">Главная</a>	
				<br>
				<a href="form.php?mod=add&table_name=<?echo $table_name?>">Добавить запись</a>	
			</div>
		</div>
		<div>
			<div>
				<table>
					<thead>
						<tr>
							<?
								foreach ($tables[$table_name] as $col) {
									echo "<th>" . $col . "</th>";
								}
							?>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>

						<?
							try {
								$db = new PDO("pgsql:host=".dbconfig::$host.";dbname=".dbconfig::$dbname, dbconfig::$dbuser, dbconfig::$dbpass);
								$res = $db->query("SELECT *  FROM " . $table_name);
							} catch (\Throwable $th) {
								echo "<pre>" . $th . "</pre>";
							}
							
							while ($row = $res->fetch())
							{
						?>

						<tr>
							<?
								foreach ($tables[$table_name] as $col) {
									echo "<td>" . $row[$col] . "</td>";
								}
							?>
							<td><a href="form.php?mod=edit&table_name=<?echo $table_name?>&id=<?echo $row[$tables[$table_name][0]] ?>">Редактировать</a>
							<br>
							<a href="delete.php?table_name=<?echo $table_name?>&id=<?echo $row[$tables[$table_name][0]] ?>">Удалить</a></td>
						</tr>

						<?}?>
						
					</tbody>
				</table>
			</div>
			
		</div>
		
    </div>

<style>
table th, td {
	padding: 10px;
	border: 1px solid #000;
}
</style>

</body>
</html>



