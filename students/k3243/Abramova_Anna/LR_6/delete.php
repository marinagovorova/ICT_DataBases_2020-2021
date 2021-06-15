<?
    $table_name = $_GET['table_name'];
    $item_id = $_GET['id'];

    require_once "config.php";

    try {
        $db = new PDO("pgsql:host=".dbconfig::$host.";dbname=".dbconfig::$dbname, dbconfig::$dbuser, dbconfig::$dbpass, array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION));
        $res = $db->query("DELETE FROM $table_name WHERE ". $tables[$table_name][0] ." = $item_id");
        header("Location: table.php?table_name=$table_name");
        exit;
    } catch (\Throwable $th) {
        echo "<pre>" . $th . "</pre>";
    }
?>