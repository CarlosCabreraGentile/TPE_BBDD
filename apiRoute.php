<?php

define('RESOURCE', 0);
define('PARAMS', 1);

require_once('api/config/Router.php');
require_once('api/controller/ComentariosApiController.php');


$router = new Router();
//url, verb, controller, method
$router->AddRoute("comentarios", "GET", "ComentariosApiController", "getComents");
// $router->AddRoute("comentarios/:id", "GET", "TareasApiController", "getComent");
$router->AddRoute("comentarios/:id", "GET", "ComentariosApiController", "getComentsdeUnProducto");
$router->AddRoute("comentarios", "POST", "ComentariosApiController", "createComentario");
$router->AddRoute("comentarios/:id", "DELETE", "ComentariosApiController", "deleteComentario");
$router->AddRoute("comentarios/:id", "PUT", "ComentariosApiController", "editComentario");

$route = $_GET['resource'];
$array = $router->Route($route);

if(sizeof($array) == 0)
  echo "404";
else
{
  $controller = $array[0];
  $metodo = $array[1];
  $url_params = $array[2];
  echo (new $controller())->$metodo($url_params);
}
?>
