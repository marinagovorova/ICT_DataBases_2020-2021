<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All tables</title>
</head>
<body>

	<h1>Таблицы</h1>
	<ul>
	<?
		require_once "config.php";
		foreach ($tables as $table => $value)
		{
			echo "<li><a href='table.php?table_name=$table'>$table</a></li>";
		}

	?>

</body>
</html>