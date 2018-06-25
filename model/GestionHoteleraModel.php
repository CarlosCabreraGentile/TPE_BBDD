<?php
class GestionHoteleraModel extends Model
{
  /*FUNCION PARA TRAER LOS PRODUCTOS DE LA TABLA*/
  public function getDepartamentos()
  {
    $sentencia = $this->db->prepare("select id_dpto from gr04_departamento");//producto es la tabla de la BBDD
    $sentencia->execute();
    return $sentencia->fetchAll(PDO::FETCH_ASSOC);// code...
  }
  public function getEstadoDpto($id, $mes1, $mes2, $anio){
    $salida = $this->db->prepare("SELECT fecha_desde,fecha_hasta
    FROM GR04_RESERVA R
    WHERE r.id_dpto = ? and ((extract(month from(fecha_desde))=?) or
    (extract(month from(fecha_hasta))=?))and(extract(year from(fecha_hasta))=?)");
    $salida->execute([$id, $mes1, $mes2, $anio]);
    return $salida->fetchAll(PDO::FETCH_ASSOC);
  }

}
?>
