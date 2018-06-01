<div class="container">
  <div class="row">
    <div class="col-md-6 col-sm-6">
      <div class="filtrar form-group">
        <form method="POST" href="filtrar" class="formFiltrar">
          <label for="id_marca">Seleccione una marca</label>
          <select class="marca" name="id_marca">
            {foreach from=$marcas item=marca}
            <option class="marca" value="{$marca['id']}" name="id_marca">{$marca['nombre']}</option>
            {/foreach}
          </select>
          <input type="submit" class="btn btn-default" value="Filtrar Marca">
          <input type="button" class="btn btn-default refresh" href="comparativa" value="Refrescar">
        </form>
      </div>
    </div>
    <div class="col-md-3 col-sm-3">
      <div class="form-group">
        <label>Check in</label>
        <div class="form-group">
          <div class="input-group date cc-date">
            <input type="text" class="form-control"><span class="input-group-addon">
            <span class="fa fa-calendar"></span>
          </span>
        </div>
      </div>
    </div>
  </div>
  <!--<div class="col-md-3">
    <div class="form-group">
      <label>Check in</label>
      <div class="form-group">
        <div class="input-group date" id="datetimepicker1">
          <input type="text" class="form-control" />
          <span class="input-group-addon">
            <span class="fa fa-calendar"></span>
          </span>
        </div>
      </div>
    </div>
  </div>-->
  
</div>
</div>
<div class="container">
<div class="row">
  <div class="table-responsive">
    <table class="table table-striped centradoBlanco">
      <tr>
        <th><p >Departamento</p></th>
        <th><p >nro Habitaciones</p></th>
        <th><p >precio</p></th>
        <th><p >cantidad de huespedes</p></th>
        <th><p >a modo de ejemplo</p></th>
        <th><p >DETALLES</p></th>
      </tr>
      {foreach from=$productos item=producto}
      <tr>
        <td><p>{$producto['marca']}</p></td>
        <td><p>{$producto['modelo']}</p></td>
        <td><p>{$producto['memoria']}</p></td>
        <td><p>{$producto['banda']}</p></td>
        <td><p>{$producto['consumo']}</p></td>
        <td>
          <div class="col-xs-12 col-sm-12 col-md-12">
            <div class="borrarEditarCentrado">
              <div class="enLinea">
                <a href="{$producto['id']}" class="mostrarProducto" >
                  <p><span id="mostrar" class="fa fa-info-circle" aria-hidden="true" value="0"></span></p>
                </a>
              </div>
            </div>
          </div>
        </td>
      </tr>
      {/foreach}
    </table>
  </div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>

<script
src="https://code.jquery.com/jquery-3.3.1.min.js"
integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
crossorigin="anonymous"></script>
<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
crossorigin="anonymous"></script>
<script src="js/bootstrap-datepicker.js" type="text/javascript" ></script>
<script  src="js/1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/mustache.js/2.3.0/mustache.min.js"></script>
<script  src="js/js-prueba.js"></script>