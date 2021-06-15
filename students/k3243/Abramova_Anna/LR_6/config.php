<?
    class dbconfig
    {
        public static $dbuser = 'postgres';
        public static $dbpass = 'Artek1925';
        public static $host = 'localhost';
        public static $dbname = 'postgres';
    }

    $tables = [
        "book_hotel.client" => array(
            "id_client",
            "passport_number", 
            "client_name",  
            "const_adres"
        ),
        "book_hotel.hotel" => array(
            "id_hotel",
            "hotel_name", 
            "hotel_adress", 
            "stars", 
            "hotel_type"
        ),
        "book_hotel.registration" => array (
            "id_registration",
            "id",
            "date_arrival",
            "date_departure",
            "pay_status",
            "fk_passport_number",
            "fk_room_number",
            "fk_tabel_number"
        ),
        "book_hotel.room" => array(
            "id_room",
            "room_number",
            "room_occupancy",
            "cleaning_status",
            "fk_hotel_name",
            "fk_room_class"
        ),
        "book_hotel.room_type" => array(
            "id_room_type",
            "room_class",
            "room_quantity",
            "daily_price",
            "conveniences",
            "beds_quantity",
            "fk_stock_type"
        ),
        "book_hotel.worker" => array(
            "id_worker",
            "tabel_number",
            "contacts",
            "worker_name"
        ),
        "book_hotel.stock" => array(
            "id_stock",
            "stock_type",
            "stock_annotation",
            "stock_start",
            "stock_end",
            "stock_procent"
        )
    ];
?>

