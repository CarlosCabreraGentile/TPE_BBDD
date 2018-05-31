<?php
class ProductosModel extends Model
{
  /*FUNCION PARA TRAER LOS PRODUCTOS DE LA TABLA*/
  function getProductos(){
    $sentencia = $this->db->prepare("select * from producto");//producto es la tabla de la BBDD
    $sentencia->execute();
    return $sentencia->fetchAll(PDO::FETCH_ASSOC);
  }
  function getImagenes($id_producto){
    $sentencia = $this->db->prepare("select * from imagen where fk_id_tarea=?");
    $sentencia->execute(array($id_producto));
    return $sentencia->fetchAll(PDO::FETCH_ASSOC);
  }
  /*FUNCION PARA AGREGAR  PRODUCTOS A LA TABLA*/
  function guardarProducto($id_marca,$modelo,$memoria,$banda,$consumo, $imagenes){
    $sentencia = $this->db->prepare('INSERT INTO producto(id_marca,modelo,memoria,banda,consumo) VALUES(?,?,?,?,?)');
    $sentencia->execute([$id_marca,$modelo,$memoria,$banda,$consumo]);
    $id_producto = $this->db->lastInsertId();

    foreach ($imagenes as $key => $imagen) {
      $path="img/".uniqid()."_".$imagen["name"];
      move_uploaded_file($imagen["tmp_name"], $path);
      $insertImagen = $this->db->prepare("INSERT INTO imagen(path,fk_id_tarea) VALUES(?,?)");
      $insertImagen->execute(array($path,$id_producto));
    }
  }
  /*FUNCION PARA AGREGAR IMAGEN DE PRODUCTO A LA TABLA*/
  function guardarImagenProducto($id_producto,$imagenes){
     foreach ($imagenes as $key => $imagen) {
      $path="img/".uniqid()."_".$imagen["name"];
      move_uploaded_file($imagen["tmp_name"], $path);
      $insertImagen = $this->db->prepare("INSERT INTO imagen(path,fk_id_tarea) VALUES(?,?)");
      $insertImagen->execute(array($path,$id_producto));
    }
  }
  /*FUNCION PARA BORRAR PRODUCTOS DE LA TABLA*/
  function borrarProducto($id){
    $sentencia = $this->db->prepare("delete from producto where id=?");
    $sentencia->execute([$id]);
  }
  function borrarImagenProducto($imgpath) {
    $sentencia = $this->db->prepare("delete from imagen where path=?");
    $sentencia->execute(array($imgpath));
  }
  /*FUNCION PARA PARA FILTRAR POR MARCA*/
  function getFiltro($id_marca){
    $sentencia = $this->db->prepare("select * from producto where id_marca =?");
  //producto es la tabla de la BBDD
    $sentencia->execute([$id_marca]);
    return $sentencia->fetchAll(PDO::FETCH_ASSOC);
  }
/*FUNCION PARA TRAER UN PRODUCTO ESPECIFICO DE LA TABLA PRODUCTOS DE LA TABLA*/
  function getProducto($id){
    $sentencia = $this->db->prepare("select * from producto where id =?");//producto es la tabla de la BBDD
    $sentencia->execute([$id]);
    return $sentencia->fetchAll(PDO::FETCH_ASSOC);
  }
/*FUNCION PARA EDITAR LOS PRODUCTOS DE LA TABLA*/
  function editarProducto($modelo,$memoria,$banda,$consumo,$id) {
    $sentencia = $this->db->prepare("UPDATE producto SET modelo =?, memoria =?, banda =?, consumo =? WHERE id =?");
    $sentencia->execute([$modelo,$memoria,$banda,$consumo,$id]);
  }
}
?>
