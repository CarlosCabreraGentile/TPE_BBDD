<?php
class LoginModel extends Model
{
  function getUser($userName){
    $sentencia = $this->db->prepare( "select * from usuario where usuario = ? limit 1");
    $sentencia->execute([$userName]);
    return $sentencia->fetchAll(PDO::FETCH_ASSOC);
  }
  public function guardardatosusuario($userName,$password,$nombre,$apellido)
  {
    $sentencia= $this->db->prepare('INSERT INTO usuario(usuario,password,nombre,apellido) VALUES(?,?,?,?)');
    $sentencia->execute([$userName,$password,$nombre,$apellido]);
  }
}
?>
