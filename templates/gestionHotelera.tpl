<div class="tablafondo">
  <!--HOME Presentation -->
  <div class="conthome2">
    <p>Gestión Hotelera</p>
  </div>
  <div class="container">
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
