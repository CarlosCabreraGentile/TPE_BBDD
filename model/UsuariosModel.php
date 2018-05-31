<?php
class UsuariosModel extends Model
{
/*FUNCION PARA TRAER LOS USUARIOS DE LA TABLA*/
  function getUsuarios(){
    $sentencia = $this->db->prepare("select * from usuario");//usuario es la tabla de la BBDD
    $sentencia->execute();
    return $sentencia->fetchAll(PDO::FETCH_ASSOC);
  }
  /*FUNCION PARA BORRAR USUARIOS DE LA TABLA*/
  function deleteUsuario($id){
    $sentencia = $this->db->prepare("delete from usuario where id_usuario=?");
    $sentencia->execute([$id]);
  }
  /*FUNCION PARA ASIGNAR PERMISO USUARIO DE LA TABLA*/
  function asignarPermisoUsuario($id, $permiso){
    $sentencia = $this->db->prepare("UPDATE usuario SET superAdmin=? WHERE id_usuario=?");
    $sentencia->execute([$permiso, $id]);
  }
}
?>