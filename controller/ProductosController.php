<?php
include_once('model/ProductosModel.php');
include_once('model/MarcasModel.php');
include_once('view/ProductosView.php');
include_once('view/UsuariosView.php');
require_once('simple-php-captcha-master/simple-php-captcha.php');
class ProductosController extends SecuredController
{
  function __construct()
  {
    parent::__construct();
    $this->view = new ProductosView();
    $this->usuariosView = new UsuariosView();
    $this->model = new ProductosModel();
    $this->marcasModel = new MarcasModel();
    // $this->usuariosModel = new UsuariosModel();
  }
  public function index()
  {
      $usuario=null;
    if ($this->usuario()) {
      $usuario = $_SESSION['usuario'];
    }
    $superAdmin =$this->superAdmin();
    $this->view->mostrarIndex($usuario,$superAdmin);
  }
  public function comparativa()
  {
    $productos = $this->model->getProductos();
    $marcas = $this->marcasModel->getMarcas();
    for ($i=0; $i < count($productos); $i++) {
      $id_marca = $productos[$i]['id_marca'];// puede ser 1, 2, 3, etc son los id que envio con el formulario
      $j=0;
      while (( $j < count($marcas) && (!(isset($productos[$i]['marca']))) ) ) {
        if ($id_marca == $marcas[$j]['id']) {
          $productos[$i]['marca'] = $marcas[$j]['nombre'];
        }
        $j++;
      }
    }
    $usuario = false;
    $superAdmin=false;
    if (isset($_SESSION['usuario'])) { // pregunto si tengo un usuario
      $usuario = true;
      if ($_SESSION['superAdmin']==1) {
        $superAdmin=true;
      }
    }
    $this->view->mostrarProductos($productos, $marcas, $usuario,$superAdmin);
  }
  public function mostrarProducto($value="")
  {
    $usuario = $this->usuario();
    $superAdmin= $this->superadmin();
    $marcas = $this->marcasModel->getMarcas();
    $_SESSION['captcha_array'] = $_SESSION['captcha'] = simple_php_captcha();//cuando entramos por primera vez a la pagina inicia el captcha
    $imagenCaptcha=$_SESSION['captcha_array']['image_src'];//toamos la imagene del captcha
    if (isset($_POST['id_producto'])&&!empty($_POST['id_producto'])) {
      $id = $_POST['id_producto'];
      $productos=$this->model->getProducto($id);
      $imagenes=$this->model->getImagenes($id);

      $this->view->mostrarDetalleProducto($productos,$marcas,$imagenes,$usuario,$superAdmin,$imagenCaptcha);
    }
    else{
      $productos=$this->model->getProducto($value);
      $imagenes=$this->model->getImagenes($value);
      $this->view->mostrarDetalleProducto($productos,$marcas,$imagenes,$usuario,$superAdmin,$imagenCaptcha);
    }
  }
  public function ReloadimagenCaptcha($value='')
  {
    $usuario=$this->usuario();
    $id=$_POST["id_producto"];
    $productos=$this->model->getProducto($id);
    $_SESSION['captcha_array'] = $_SESSION['captcha'] = simple_php_captcha();
    $imagenCaptcha=$_SESSION['captcha_array']['image_src'];
    $this->view->recargarCaptcha($imagenCaptcha,$usuario,$productos);
  }

  // public function mostrarListaUsuarios($value="")
  // {
  //   $superAdmin=false;
  //   if (isset($_SESSION['superAdmin'])) { // pregunto si tengo un usuario
  //     $superAdmin = true;
  //   }
  //   $usuarios = $this->usuariosModel->getUsuarios();
  //   $this->usuariosView->mostrarUsuarios($usuarios);
  // }


  /*MUESTRO EL PARTIAL NVIDIA*/
  public function nvidia()
  {
    $this->view->mostrarNvidia();
  }
  /*MUESTRO EL PARTIAL ATI*/
  public function Ati()
  {
    $this->view->mostrarAti();
  }
  /*FUNCION Q GUARDA PRODUCTOS*/
  public function store()
  {
    if ($this->superAdmin()) {
    $productos = $this->model->getProductos();
    $marcas = $this->marcasModel->getMarcas();
    $id_marca = $_POST['id_marca'];
    $modelo = $_POST['modelo'];
    $memoria = $_POST['memoria'];
    $banda = $_POST['banda'];
    $consumo = $_POST['consumo'];
    if((isset($_POST['modelo']) && !empty($_POST['modelo'])) &&
      (isset($_POST['memoria']) && !empty($_POST['memoria'])) &&
      (isset($_POST['banda']) && !empty($_POST['banda'])) &&
      (isset($_POST['consumo']) && !empty($_POST['consumo'])))
    {
        if(isset($_FILES['imagenproducto'])){
          $imagenes = $this->getExtensionesImagenesVerificadas($_FILES['imagenproducto']);
          $this->model->guardarProducto($id_marca,$modelo,$memoria,$banda,$consumo, $imagenes);
          $this->comparativa();
        }
    }
    else{
          $this->view->errorCrear("Todos los campos son requeridos", $productos, $marcas);
          $this->comparativa();
        }
    }
    // pregunto si tengo un usuario
  }
  /*FUNCION Q BORRA PRODUCTOS*/
  public function destroy()
  {
    if ($this->superAdmin()) {
    if (isset($_POST['id_producto'])) {
      $id = $_POST['id_producto'];
      $this->model->borrarProducto($id);
      $this->comparativa();
    }
  }
  }
  /*FUNCION PARA FILTRAR POR MARCA PRODUCTOS*/
  public function filtro()
  {
    $id_marca = $_POST['id_marca'];
    $productos = $this->model->getFiltro($id_marca);
    $marcas = $this->marcasModel->getMarcas();
    for ($i=0; $i < count($productos); $i++) {
      $id_marca = $productos[$i]['id_marca'];// puede ser 1, 2, 3, etc son los id que envio con el formulario
      $j=0;
      while (( $j < count($marcas) && (!(isset($productos[$i]['marca']))) ) )
      {
        if ($id_marca == $marcas[$j]['id']) {
          $productos[$i]['marca'] = $marcas[$j]['nombre'];
        }
        $j++;
      }
    }
    $usuario = false;
    $superAdmin=false;
    if (isset($_SESSION['usuario'])) { // pregunto si tengo un usuario
      $usuario = true;
      if ($_SESSION['superAdmin']==1) {
        $superAdmin=true;
      }
    }
    $this->view->mostrarProductos($productos, $marcas, $usuario,$superAdmin);
  }

  //ABRE LA PAGINA PARA EDITAR EL PRODUCTO
  public function edit()
  {
    if ($this->superAdmin()) {
      if (isset($_POST['id_producto'])) {
        $id = $_POST['id_producto'];
        $productos=$this->model->getProducto($id);
        $this->view->mostraredit($productos);
      }
    }
  }

  //EDITA EL PRODUCTO
  public function editar()
  {
    if ($this->superAdmin())
    {

      if((isset($_POST['id_producto'])&&!empty($_POST['id_producto']))&&
        (isset($_POST['modelo']) && !empty($_POST['modelo'])) &&
        (isset($_POST['memoria']) && !empty($_POST['memoria'])) &&
        (isset($_POST['banda']) && !empty($_POST['banda'])) &&
        (isset($_POST['consumo']) && !empty($_POST['consumo'])))
      {
      $id = $_POST['id_producto'];
      $modelo = $_POST['modelo'];
      $memoria = $_POST['memoria'];
      $banda = $_POST['banda'];
      $consumo = $_POST['consumo'];
      $this->model->editarProducto($modelo,$memoria,$banda,$consumo,$id);
      $this->comparativa();
      }
    }
  }
  function traemeElbody(){
    $this->view->seeBody();
  }
  /*FUNCION QUE CONTROLA QUE LAS IMAGENES TENGAN LA EXTENSION PERMITIDA*/
  function getExtensionesImagenesVerificadas($imagenes){
    $imagenesVerificadas = [];
    for ($i=0; $i < count($imagenes['size']); $i++) {
      //SOPORTA JPEG Y PNG, PARA REDUCIR EL ESPECTRO DE EXTENSIONES
      if($imagenes['size'][$i]>0 && ($imagenes['type'][$i]=="image/jpeg" || $imagenes['type'][$i]=="image/png"))
      {
        $imagen_aux = [];
        $imagen_aux['tmp_name']=$imagenes['tmp_name'][$i];
        $imagen_aux['name']=$imagenes['name'][$i];
        $imagenesVerificadas[]=$imagen_aux;
      }
      else{
        $this->view->errorCrear("Imagen no soportada / Producto sin imagen");//LA EXTENSION DE LA IMAGEN EJ SI ES BMP NO ANDA
      }
    }
    return $imagenesVerificadas;
  }
  /*FUNCION Q GUARDA IMAGENES*/
  public function storeImg()
  {
    $id = $_POST['id_producto'];
    if ($this->superAdmin())
    {
      // var_dump($_FILES['fotos']['size']['0']);
      // die();
      if(isset($_FILES['fotos']) && $_FILES['fotos']['size']['0'] > 0)
      {
        $imagenes = $this->getExtensionesImagenesVerificadas($_FILES['fotos']);
        $this->model->guardarImagenProducto($id,$imagenes);
        $this->mostrarProducto();
      }
      else{
        $this->view->errorCrear("No cargo imagen");
        $this->mostrarProducto();
      }
    }
    else{
      $this->view->errorCrear("No tiene permiso");
      $this->mostrarProducto();
     }
  }
  /*FUNCION Q BORRA IMAGEN DE PRODUCTO*/
  public function destroyImg()
  {
    if ($this->superAdmin())
    {
      if(isset($_POST['imgpath']))
      {
        $this->model->borrarImagenProducto($_POST['imgpath']);
        $this->mostrarProducto($_POST['idProducto']);
      }
    }
    else
    {
      $this->view->errorCrear("No tiene permiso");
      $this->mostrarProducto();
    }
  }

}
?>
