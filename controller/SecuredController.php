<?php
include_once("controller/Controller.php");
class SecuredController extends Controller
{
  function __construct()
  {
    session_start();
    if(isset($_SESSION['usuario']))
    {
      if (time() - $_SESSION['LAST_ACTIVITY'] > 360 ) 
      {
        header('Location: '.LOGOUT);
        die();
      }
      $_SESSION['LAST_ACTIVITY'] = time();
    }
  }
  public function superAdmin($value='')
  {
    $superAdmin=false;
    if(isset($_SESSION['superAdmin'])&&$_SESSION['superAdmin']==1)
    {
      $superAdmin=true;
    }
    return $superAdmin;
  }
  public function usuario($value='')
  {
    $usuario=false;
    if(isset($_SESSION['usuario']))
    {
      $usuario=true;
    }
    return $usuario;
  }
}
?>
