<?php

require_once('model/ComentariosModel.php');
require_once('Api.php');
/**
 *
 */
class ComentariosApiController extends Api
{
  protected $model;
  function __construct()
  {
      parent::__construct();
      $this->model = new ComentariosModel();
      $this->modelUsuario =false;
  }
  public function deleteComentario($url_params = [])
  {
      if ($this->superAdmin()) {
        $id_comentario = $url_params[":id"];
        if((isset($id_comentario) && !empty($id_comentario))) {
              $coments = $this->model->getComentario($id_comentario);
              if($coments)
              {
                $this->model->borrarComentario($id_comentario);
                return $this->json_response("Borrado exitoso.", 200);
              }
              else{
                return $this->json_response(false, 404);
              }
            }
          }
          else{
            return $this->json_response(false, 404);
          }
  }
  public function createComentario($url_params = []) {
    if ($this->usuario()) {
      $body = json_decode($this->raw_data);
      $comentario = $body->comentario;
      $valoracion = $body->valoracion;
      $id_producto = $body->id_producto;
      $captcha = $body->captcha;
      if((isset($comentario) && !empty($comentario)) &&
        (isset($valoracion) && !empty($valoracion)) &&
        (isset($captcha) && !empty($captcha))&&
        (isset($id_producto) && !empty($id_producto)))
        {
          if($_SESSION['captcha_array']['code'] == $captcha){
            $coments = $this->model->guardarComentario($comentario,$valoracion,$id_producto);
            return $this->json_response($coments, 200);
            }
            else{
              return $this->json_response("Error Comentario", 400);
            }
        }
        else{
          return $this->json_response("Error Comentario", 400);
        }
    }
    else{
      return $this->json_response(false, 400);
    }
  }
  public function getComent($url_params = [])
  {
    $id=$url_params[":id"];
    $Coments = $this->model->getComentario($id);
    return $this->json_response($Coments, 200);
  }
  public function getComentsdeUnProducto($url_params = [])
  {
    $id_producto=$url_params[":id"];
    $Coments = $this->model->getComentariosdeUnProducto($id_producto);
        $response = new stdClass();
        $response->comentarios =$Coments;
        $response->usuario =$this->usuario();
        $response->admin =$this->superAdmin();
        $response->status = 200;
    return $this->json_response($response, 200);
  }

}
?>
