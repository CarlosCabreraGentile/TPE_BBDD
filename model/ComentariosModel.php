<?php
require_once('model/Model.php');
class ComentariosModel extends Model{
    public function getComentarios()
    {
      $sentencia = $this->db->prepare("select * from comentarios");//comentarios es la tabla de la BBDD
      $sentencia->execute();
      return $sentencia->fetchAll(PDO::FETCH_ASSOC);
    }
    public function guardarComentario($comentario,$valoracioncion,$id_producto)
    {
      $sentencia = $this->db->prepare("INSERT INTO `comentarios`(`comentario`,`valoracion`,id_producto) VALUES (?,?,?)");
      $sentencia->execute([$comentario,$valoracioncion,$id_producto]);
      $id = $this->db->lastInsertId();
      return $this->getComentariosdeUnProducto($id_producto);
    }
    public function getComentario($id)
    {
      $sentencia = $this->db->prepare("select * from comentarios where id_comentario =?");//comentarios es la tabla de la BBDD
      $sentencia->execute([$id]);
      return $sentencia->fetchAll(PDO::FETCH_ASSOC);
    }
    public function borrarComentario($id)
    {
      $sentencia = $this->db->prepare( "delete from comentarios where id_comentario=?");
      $sentencia->execute([$id]);
    }
    public function modificarComentario($id, $comentario,$valoracion)
    {
      $sentencia = $this->db->prepare("UPDATE comentarios SET comentario =?, valoracion =? WHERE id_comentario =?");
      $sentencia->execute([$comentario,$valoracion,$id]);
      return $this->getComentario($id);
    }
    public function getComentariosdeUnProducto($id_producto)
    {
      $sentencia = $this->db->prepare("select * from comentarios where id_producto=?");//comentarios es la tabla de la BBDD
      $sentencia->execute([$id_producto]);
      return $sentencia->fetchAll(PDO::FETCH_ASSOC);
    }
}
?>
