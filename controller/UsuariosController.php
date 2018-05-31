<?php
include_once('model/UsuariosModel.php');
include_once('view/UsuariosView.php');
class UsuariosController extends SecuredController{
  function __construct()
  {
    parent::__construct();
    $this->usuariosView = new UsuariosView();
    $this->usuariosModel = new UsuariosModel();
  }
  public function mostrarListaUsuarios($value="")
  {
      if ($this->superAdmin()) 
      {
        $usuarios = $this->usuariosModel->getUsuarios();
        $usuarios_editados = [];
          foreach ($usuarios as $usuario) 
          {
            if ($usuario['superAdmin'] == 1) {
               $usuario['tipo'] = "Administrador";
            }
            else{
               $usuario['tipo'] = "Usuario";
            }
            array_push($usuarios_editados,$usuario);
          }
        $this->usuariosView->mostrarUsuarios($usuarios_editados);
      }
  }
  /*FUNCION QUE BORRA USUARIOS*/
  public function borrarUsuario()
  {
    if ($this->superAdmin()) 
    {
      if (isset($_POST['id_usuario'])) 
      {
        $id = $_POST['id_usuario'];
        /*PREGUNTAR SI ES SUPER USUARIO Y DENEGARLO $usuario[0]['superUsuario'] != 1*/
        $this->usuariosModel->deleteUsuario($id);
        $usuarios = $this->usuariosModel->getUsuarios();
        $usuarios_editados = [];
        foreach ($usuarios as $usuario) 
        {
          if ($usuario['superAdmin'] == 1) {
           $usuario['tipo'] = "Administrador";
          }
          else{
           $usuario['tipo'] = "Usuario";
          }
          array_push($usuarios_editados,$usuario);
        }
        $this->usuariosView->mostrarUsuarios($usuarios_editados);
      }
    }
  }
  public function editarPermisoUsuario()
  {
      if ($this->superAdmin()) 
      {
        if (isset($_POST['id_usuario'])) 
        {
          $id = $_POST['id_usuario'];
          $permiso = $_POST['permisoUsuario'];
          if ($permiso == 1) 
          {
            $permiso = 0;
          }
          else
          {
            $permiso = 1;
          }
      /*PREGUNTAR SI ES SUPER USUARIO Y DENEGARLO $usuario[0]['superUsuario'] != 1*/
            $this->usuariosModel->asignarPermisoUsuario($id, $permiso);
            $usuarios = $this->usuariosModel->getUsuarios();
            $usuarios_editados = [];
            foreach ($usuarios as $usuario) 
            {
              if ($usuario['superAdmin'] == 1) 
              {
                $usuario['tipo'] = "Administrador";
              }
              else
              {
                $usuario['tipo'] = "Usuario";
              }
                array_push($usuarios_editados,$usuario);
            }
            $this->usuariosView->mostrarUsuarios($usuarios_editados);
        }
      }
  }
}
?>
