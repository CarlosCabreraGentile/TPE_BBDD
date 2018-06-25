<?php
/*define('DB','cursada');
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
*/
class Model
  {
   protected $db;
   protected $host = "dbases.exa.unicen.edu.ar";

   function __construct()
   {
     try {
         $this->db = new PDO("pgsql:host=localhost;port=5432; dbname=departamentos", 'postgres', 'system011');
         $this->db->exec('SET search_path TO public');
     }
     catch (PDOException $e){
       echo "ERROR: Trying to connect to the Database";
       die();
     }
   }
  }
?>
