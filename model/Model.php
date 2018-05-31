<?php
define('DB_NAME', 'db_departamentos');
define('DB_USER', 'root');
define('DB_PASSWORD', '');
define('DB_HOSTNAME', 'localhost');
define('DB_FILE','SQL/db_departamentos.sql');

class Model
{
  protected $db;
  protected $host = "http://dbases.exa.unicen.edu.ar:8080";

  function __construct()
  {
    try {
       // $this->db = new PDO('mysql:host='.DB_HOSTNAME . '; dbname='.DB_NAME. ';charset=utf8', DB_USER,DB_PASSWORD);
        $this->db = new PDO("pgsql:host=$host; port=6432; dbname=cursada", 'unc_246336', 'ibanez011');
    }
    catch (PDOException $e){
      echo "ERROR: Trying to connect to the Database";
      echo $db;
      die();
    }
  }
}
?>
