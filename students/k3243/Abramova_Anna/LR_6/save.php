<?
    $mod = $_GET['mod'];
    $table_name = $_GET['table_name'];

    if ($mod == "edit")
    {
        $item_id = $_GET['id'];
    }
    require_once "config.php";

    if ($mod == "add")
    {
        $action = "INSERT INTO $table_name (";
        foreach ($tables[$table_name] as $row) {
            if ($row == $tables[$table_name][0]){
                continue;
            }
            $action .= $row . ", ";
        }
        $action = substr($action, 0, -2);
        $action .= ") VALUES (";
        foreach ($_POST as $col) {
            if ($col == "")
                $action .= "null, ";
            else
                $action .= "'$col', ";
        }
        $action = substr($action, 0, -2);
        $action .= ")";
    }
    else if ($mod == "edit")
    {
        $action = "UPDATE $table_name SET ";
        $temp_cols = array();
        foreach ($tables[$table_name] as $row) {
            if ($row == $tables[$table_name][0]){
                continue;
            }
            $temp_cols[] = $row . " = ";
        }
        $i = 0;
        foreach ($_POST as $col) {
            if ($col == "")
                $temp_cols[$i] .= "null, ";
            else
                $temp_cols[$i] .= "'$col', ";
            $i++;
        }
        foreach ($temp_cols as $col)
        {
            $action .= $col;
        }
        $action = substr($action, 0, -2);
        $action .= " WHERE ". $tables[$table_name][0] ." = $item_id";
    }

    try {
        $db = new PDO("pgsql:host=".dbconfig::$host.";dbname=".dbconfig::$dbname, dbconfig::$dbuser, dbconfig::$dbpass, array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION));
        $res = $db->query($action);
        header("Location: table.php?table_name=$table_name");
        exit;
    } catch (\Throwable $th) {
        echo "<pre>" . $th . "</pre>";
    }
?>