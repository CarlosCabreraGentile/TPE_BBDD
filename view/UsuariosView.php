<?php
class UsuariosView extends View
{
	function mostrarUsuarios($usuarios){
    	$this->smarty->assign('usuarios', $usuarios);
    	$this->smarty->display('templates/listaUsuarios.tpl');
  	}
}
?>