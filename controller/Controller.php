<?php
define('HOME', 'http://'.$_SERVER['SERVER_NAME'] .":".$_SERVER['SERVER_PORT']. dirname($_SERVER['PHP_SELF']).'/');
define('LOGIN', 'http://'.$_SERVER['SERVER_NAME'] .":".$_SERVER['SERVER_PORT']. dirname($_SERVER['PHP_SELF']).'/login');
define('LOGOUT', 'http://'.$_SERVER['SERVER_NAME'] .":".$_SERVER['SERVER_PORT']. dirname($_SERVER['PHP_SELF']).'/logout');
define('COMPARATIVA', 'http://'.$_SERVER['SERVER_NAME'] .":".$_SERVER['SERVER_PORT']. dirname($_SERVER['PHP_SELF']).'/comparativa');
define('SESION', 'http://'.$_SERVER['SERVER_NAME'] .":".$_SERVER['SERVER_PORT']. dirname($_SERVER['PHP_SELF']).'/sesionExpirada');
class Controller
{
  protected $view;
  protected $model;
}
?>
