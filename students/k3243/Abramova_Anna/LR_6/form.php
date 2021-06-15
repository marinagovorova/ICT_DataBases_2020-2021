<?
    $mod = $_GET['mod'];
    $table_name = $_GET['table_name'];
    if ($mod == "edit")
    {
        $item_id = $_GET['id'];
    }
    require_once "config.php";
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <? echo "$table_name $mod" ?>
    </title>
</head>

<body>

    <?
        if ($mod == "add")
        {
            echo "<h2 class='p-2 m-0'>Добавление записи в $table_name</h2>";
        } 
        else if ($mod == "edit")
        {
            echo "<h2 class='p-2 m-0'>Редактирование записи из $table_name</h2>";
            $db = new PDO("pgsql:host=".dbconfig::$host.";dbname=".dbconfig::$dbname, dbconfig::$dbuser, dbconfig::$dbpass, array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION));
            $res = $db->query("SELECT * FROM " . $table_name ." WHERE " . $tables[$table_name][0] . "= $item_id" );
            
            $row = $res->fetch();
        }
    ?>
    <form action="save.php?mod=<?echo $mod?>&table_name=<?echo $table_name?><?if ($mod == "edit") echo "&id=" . $item_id?>" method="post">
        <?
            foreach ($tables[$table_name] as $col_name) {
                if ($col_name == $tables[$table_name][0]){
                    continue;
                }
        ?>
        <div>
            <label><?echo $col_name?></label>
            <input name="<?echo $col_name?>" placeholder="<?echo $col_name?>" value="<? if(isset($row)) echo $row[$col_name]; ?>">
        </div>
        <?
            }
        ?>
        <input type="submit" value="Save">
    </form>
    <a href="table.php?table_name=<?echo $table_name?>">Назад</a>     
<style>
    input {
        padding: 3px;
        margin-bottom: 5px;
    }
</style>

</body>

</html>