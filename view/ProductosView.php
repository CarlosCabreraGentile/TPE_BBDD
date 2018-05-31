<?php
class ProductosView extends View
{
  function mostrarProductos($producto,$marca,$usuario,$superAdmin){
    $this->smarty->assign('productos', $producto);
    $this->smarty->assign('marcas', $marca);
    $this->smarty->assign('usuario', $usuario);
    $this->smarty->assign('superAdmin', $superAdmin);
    $this->smarty->display('templates/comparativa.tpl');
  }
  function mostrarIndex($usuario,$superAdmin){
    $this->smarty->assign('superAdmin',$superAdmin);
    $this->smarty->assign('usuario', $usuario);
    $this->smarty->assign('superAdmin', $superAdmin);
    $this->smarty->display('templates/index.tpl');
  }
  function mostrarCrearProductos(){
    $this->assignarProductoForm();
    $this->smarty->display('templates/formCrear.tpl');
  }
  function errorCrear($error){
    $this->smarty->assign('error', $error);
  }
  function mostrarNvidia(){
    $this->smarty->display('templates/nvidiaboostrap.tpl');
  }
  function mostrarAti(){
    $this->smarty->display('templates/atiboostrap.tpl');
  }
  function mostrarComparativa(){
    $this->smarty->display('templates/comparativa.tpl');
  }
  function guardaProductos($producto,$marca){
    $this->smarty->assign('productos', $producto);
    $this->smarty->assign('marcas', $marca);
    $this->smarty->display('templates/guardarProductos.tpl');
  }
  function mostrarDetalleProducto($producto,$marca,$imagenes,$usuario,$superAdmin,$imagenCaptcha){
    $this->smarty->assign('productos', $producto);
    $this->smarty->assign('marcas', $marca);
    $this->smarty->assign('imagenes', $imagenes);
    $this->smarty->assign('usuario', $usuario);
    $this->smarty->assign('superAdmin', $superAdmin);
    $this->smarty->assign('imagenCaptcha', $imagenCaptcha);
    $this->smarty->display('templates/detalleProducto.tpl');
  }
  function mostraredit($producto){
    $this->smarty->assign('productos', $producto);
    $this->smarty->display('templates/formEdit.tpl');
  }
  function mostrarEditMarca($marcas){
    $this->smarty->assign('marcas', $marcas);
    $this->smarty->display('templates/editMarca.tpl');
  }
  public function recargarCaptcha($imagenCaptcha,$usuario,$producto)
  {
    $this->smarty->assign('productos', $producto);
    $this->smarty->assign('imagenCaptcha', $imagenCaptcha);
    $this->smarty->assign('usuario', $usuario);
    $this->smarty->display('templates/formComentarios.tpl');
  }
  public function seeBody()
  {
    $this->smarty->display('templates/body.tpl');
  }

}
?>
