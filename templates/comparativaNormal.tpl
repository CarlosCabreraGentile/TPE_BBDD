<div class="reemplazo">


  <div class="tablafondo">
    <!--HOME Presentation -->
    <div class="conthome2">
      <p>Comparativa entre ATI y NVidia</p>
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
        </form>

      </div>
      <div class="table-responsive">
        <table class="table table-striped centradoBlanco">
          <tr>
            <th><p >MARCA</p></th>
            <th><p >MODELO</p></th>
            <th><p >MEMORIA RAM (GB)</p></th>
            <th><p >ANCHO DE BANDA (GB/s)</p></th>
            <th><p >CONSUMO (W)</p></th>
          </tr>
          {foreach from=$productos item=producto}
          <tr>
            <td><p>{$producto['marca']}</p></td>
            <td><p>{$producto['modelo']}</p></td>
            <td><p>{$producto['memoria']}</p></td>
            <td><p>{$producto['banda']}</p></td>
            <td><p>{$producto['consumo']}</p></td>
          </tr>
         {/foreach}
       </table>
     </div>

   </div>
 </div>
</div>
</div>
</div>