<div class="container">
  <div class="row">
    <div class="col-md-6 col-sm-6">
      <div class="filtrar form-group">
        <form method="POST" href="filtrar" class="formFiltrar">
          <label for="id_marca">Seleccione un Departamento y el mes que desea consultar</label>
          <div class="col-md-3">
          <select class="marca" name="id_dpto">
            {foreach from=$departamentos item=departamento}
            <option class="marca" value="{$departamento['id_dpto']}" name="id_dpto">{$departamento['id_dpto']}</option>
            {/foreach}
          </select>
          </div>
          <div class="col-md-3">
          <select class="marca" name="mes">
            <option class="marca" value="1" name="mes">Enero</option>
            <option class="marca" value="2" name="mes">Febrero</option>
            <option class="marca" value="3" name="mes">Marzo</option>
            <option class="marca" value="4" name="mes">Abril</option>
            <option class="marca" value="5" name="mes">Mayo</option>
            <option class="marca" value="6" name="mes">Junio</option>
            <option class="marca" value="7" name="mes">Julio</option>
            <option class="marca" value="8" name="mes">Agosto</option>
            <option class="marca" value="9" name="mes">Septiembre</option>
            <option class="marca" value="10" name="mes">Octubre</option>
            <option class="marca" value="11" name="mes">Noviembre</option>
            <option class="marca" value="12" name="mes">Diciembre</option>
          </select>
          <input type="text"  class="marca"  name="año" value="2018" hidden="on"></input>
          </div>
          <input type="submit" class="btn btn-default" value="Consultar Disponibilidad">
        </form>
      </div>
    </div>
    <div class="row">
        <div class="col-md-8">
          <div id="calendar">

          </div>
      </div><!-- /.row -->

</div>
</div>
</div>
</div>
</div>
</div>
</div>
