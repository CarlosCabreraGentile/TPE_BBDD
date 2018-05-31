<?php
class LoginView extends View
{  
  function mostrarLogin($error = ''){
      $this->smarty->assign('error', $error);
      $this->smarty->display('templates/Login/login.tpl');
  }
  function mostrarsesionExpirada(){
    	$this->smarty->display('templates/sesionExpirada.tpl');
  }
  function mostrarRegister($error = ''){
      $this->smarty->assign('error', $error);
      $this->smarty->display('templates/register.tpl');
  }
  public function seeBody()
  {
    $this->smarty->display('templates/body.tpl');
  }
}

?>
