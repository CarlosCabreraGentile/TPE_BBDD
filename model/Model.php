<?php
define('DB','cursada');
define('HOST','dbases.exa.unicen.edu.ar');
define('USERNAME','unc_247903');
define('PASSWORD','123456');
class Model{
   protected $db;
   function __construct(){
     try{ $host = HOST;
       $dbn = DB;
       $config = "pgsql:host=$host;port=6432;dbname=$dbn";
       $this->db = new PDO($config, USERNAME, PASSWORD);
       $this->db->exec('SET search_path TO unc_247903');
      }catch (Exception $e)
      {       echo "ERROR: Trying to conect to the Database";
       }
     }
     }
?>
