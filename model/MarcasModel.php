<?php
class MarcasModel extends Model
{
  function getMarcas(){
    $sentencia = $this->db->prepare( "select * from marca order by nombre asc");//marca es la tabla de la BBDD
    $sentencia->execute();
    return $sentencia->fetchAll(PDO::FETCH_ASSOC);
  }
  /*FUNCION PARA AGREGAR MARCAS DE LA TABLA*/
  function addmarca($marca){
    $sentencia = $this->db->prepare('INSERT INTO marca(nombre) VALUES(?)');
    $sentencia->execute([$marca]);
  }
  /*FUNCION PARA BORRAR MARCAS DE LA TABLA*/
  public function deleteMarca($id)
  {
    $sentencia = $this->db->prepare( "delete from marca where id=?");
    $sentencia->execute([$id]);
  }
  /*FUNCION PARA EDITAR MARCAS DE LA TABLA*/
  public function editMarca($id,$nombre)
  {
    $sentencia = $this->db->prepare("UPDATE marca SET  nombre =? WHERE id =?");
    $sentencia->execute([$nombre,$id]);
  }
  /*FUNCION PARA AGREGAR MARCAS DE LA TABLA*/
  public function getMarca($id){
    $sentencia = $this->db->prepare("select * from marca where id=?");//producto es la tabla de la BBDD
    $sentencia->execute([$id]);
    return $sentencia->fetchAll(PDO::FETCH_ASSOC);
  }
}
?>
