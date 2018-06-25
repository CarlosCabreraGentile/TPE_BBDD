<?php

class ConfigApp
{
    public static $ACTION = 'action';
    public static $PARAMS = 'params';
    public static $ACTIONS = [
      ''=> 'GestionHoteleraController#index',
      'home'=> 'GestionHoteleraController#index',
      'BuscarHabitaciones' => 'GestionHoteleraController#BuscarHabitaciones',
      'body'=> 'GestionHoteleraController#volverInicio',
      'filtrar'=> 'GestionHoteleraController#disponibilidad',
    ];
}
?>
