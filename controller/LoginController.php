<?php
include_once('model/LoginModel.php');
include_once('view/LoginView.php');

class LoginController extends Controller
{
  function __construct()
  {
    $this->view = new LoginView();
    $this->model = new LoginModel();
  }
  public function index()
  {
    $this->view->mostrarLogin();
  //  echo password_hash('654321', PASSWORD_DEFAULT);//DE ESTA FORMA VEO EL PASSWORD ENCRIPTADO EN SHA1
  //  password: //$2y$10$mX0CJe.TzCawcbgGb1x4h.GLC4ZYlqCtqtjI85vaqmxc/kmNbX9s.//
  }
    /*FUNCION Q VERIFICA EL USUARIO*/
  public function verify()
  {
    $userName = $_POST['usuario'];
    $password = $_POST['password'];
    if(!empty($userName) && !empty($password)){
      $user = $this->model->getUser($userName);
      if((!empty($user)) && password_verify($password, $user[0]['password'])) {
        session_start();
        $_SESSION['usuario'] = $user[0]['nombre'];
        $_SESSION['LAST_ACTIVITY'] = time();
        $_SESSION['superAdmin']=$user[0]['superAdmin'];
        header('Location: '.HOME);
        die();
        // $this->controllerProduct->comparativa();
      }
      else{
        echo("User pass error");
      }
    }
  }
    /*FUNCION PARA TERMINAR SESION*/
  public function destroy()
  {
    session_start();
    session_destroy();
    $this->view->mostrarsesionExpirada();
    die();
  }
  public function register()
  {
    $this->view->mostrarRegister();
  }
  public function registrarEnDB()
  {
    $userName = $_POST['usuario'];
    $password = $_POST['password'];
    $hash = password_hash($password, PASSWORD_DEFAULT);
    $nombre =$_POST['nombre'];
    $apellido=$_POST['apellido'];
    if ((filter_var($userName,FILTER_VALIDATE_EMAIL)) &&
      (isset($_POST['password']) && !empty($_POST['password'])) &&
      (isset($_POST['nombre']) && !empty($_POST['nombre'])) &&
      (isset($_POST['apellido']) && !empty($_POST['apellido'])))  {
      $this->model->guardardatosusuario($userName,$hash,$nombre,$apellido);
      $user = $this->model->getUser($userName);
      if((!empty($user)) && password_verify($password, $user[0]['password'])) {
        session_start();
        $_SESSION['usuario'] = $userName;
        $_SESSION['LAST_ACTIVITY'] = time();
        $_SESSION['superAdmin']=$user[0]['superAdmin'];
        header('Location: '.HOME);
        die();
      }
    }
    else {
      echo "Email Invalido";
    }
  }
}
?>
