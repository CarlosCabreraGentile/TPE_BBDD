<?php
include_once('model/GestionHoteleraModel.php');

include_once('view/GestionHoteleraView.php');

class GestionHoteleraController extends SecuredController
{
  function __construct()
  {
    parent::__construct();
    $this->view = new GestionHoteleraView();
    $this->model = new GestionHoteleraModel();
  }
  public function index()
  {
    $this->view->mostrarIndex();
  }
  public function volverInicio(){
    $this->view->volverIndex();
  }

  public function BuscarHabitaciones(){
    $departamentos=$this->model->getDepartamentos();
    $this->view->mostrarBuscarHabitaciones($departamentos);
  }

  public function disponibilidad(){
  $dpto = $_POST['id_dpto'];
  $anio = $_POST['año'];
  $mes = $_POST['mes'];
  $fecha_aux = (int)$anio. '-' .$mes;
  $days_in_month = cal_days_in_month(CAL_GREGORIAN,(int)$mes,(int)$anio);
  $datos = $this->model->getEstadoDpto($dpto, $mes, $mes, $anio);
  $this->organizarDatos($datos, $mes, $days_in_month, $fecha_aux);

}
private function organizarDatos($datos, $mes, $diasMes, $fecha_aux){
  $disponibilidad_mes = array();
  for($i = 1; $i <= $diasMes; $i++){
    $disponibilidad_mes[$i] = 0;
  }
  if(!empty($datos)){
    foreach ($datos as $valor) {
      //[0] = año, [1] = mes, [2] = dia
      $fecha_desde = explode("-", $valor['fecha_desde']);
      $fecha_hasta = explode("-", $valor['fecha_hasta']);
      //desde es menor al mes y hasta es mayor - todo el mes ocupado
      if((int)$fecha_desde[1] < $mes && (int)$fecha_hasta[1] > $mes){
        $dia = 1;
        while($dia <= $diasMes){
          $disponibilidad_mes[$dia] = 1;
          $dia++;
        }
      //desde y hasta estan en el mes
      }else if((int)$fecha_desde[1] == $mes && (int)$fecha_hasta[1] == $mes){
        $dia = (int)$fecha_desde[2];
        while($dia<= (int)$fecha_hasta[2]){
          $disponibilidad_mes[$dia] = 1;
          $dia++;
        }
        //desde esta en el mes pero hasta es uno posterior
      }else if((int)$fecha_desde[1] == $mes && (int)$fecha_hasta[1] > $mes){
        $dia = (int)$fecha_desde[2];
        while($dia<= $diasMes){
          $disponibilidad_mes[$dia] = 1;
          $dia++;
        }
        //desde es anterior y hasta es dentro del mes
      }else if((int)$fecha_desde[1] < $mes && (int)$fecha_hasta[1] == $mes){
        $dia = 1;
        while($dia<= (int)$fecha_hasta[2]){
          $disponibilidad_mes[$dia] = 1;
          $dia++;
        }
      }
    }
  }
  header('Content-Type: application/json');
  $mes_start = $fecha_aux . '-' .'01';
  $mes_end = $fecha_aux . '-' . $diasMes;
  $result = array($fecha_aux, $disponibilidad_mes,$mes_start, $mes_end);
  echo json_encode($result);
}
}

?>
