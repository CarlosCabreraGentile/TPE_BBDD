
<div class="tituloEdit">
          <p>Detalle del producto</p>
    </div>
<div class="container">

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
          {foreach from=$marcas item=marca}
          {if $marca['id'] == $producto['id_marca']}
            <td><p>{$marca['nombre']}</p></td>
          {/if}
          {/foreach}
            <td><p>{$producto['modelo']}</p></td>
            <td><p>{$producto['memoria']}</p></td>
            <td><p>{$producto['banda']}</p></td>
            <td><p>{$producto['consumo']}</p></td>
          </tr>
          {/foreach}
        </table>
  </div>
    <div class="tituloEdit">
        <p>Imagenes</p>
    </div>

    <!--TABLA INICIO-->
    <div class="table-responsive">
    <table class="table">

    <tr>


        <div class="row navbar-default">
              {foreach from=$imagenes key=index item=imagen}
              <div class="detalleProducto">
                <div class="col-md-4 col-xs-6">
                    <a href="{$imagen['path']}" class="thumbnail">
                    <img data-u="image" src="{$imagen['path']}" class="img-thumbnail" >

                    </a>
                    {if $superAdmin}
                    <button href="{$imagen['fk_id_tarea']}"class="btn btn-danger btn-xs borrarImagenProducto" type="button" data-imgpath="{$imagen['path']}">Eliminar Imagen</button>
                    {/if}
                </div>
                </div>
              {/foreach}
        </div>


    </tr>
    </table>
    </div>

<!--***AGREGAR NUEVA IMAGEN*******-->

  {if $superAdmin}
    <div class="row">
      <div class="col-xs-12 col-sm-6 col-sm-offset-3 col-md-6 col-md-offset-3 formulario">
        <div class="msj">
          <div class="panel panel-default">

            <div class="panel-body">
              {foreach from=$productos item=producto}
              <form href="guardarImagenProducto" class="formFiltrar" enctype="multipart/form-data" value="{$producto['id']}">

                <div class="form-group">
                  <label for="consumo">Adjuntar Imagen</label>
                  <input type="file" class="form-control" id="consumo" name="fotos[]"  value="" multiple required></input>

                  <input type="text"  class="idProducto"  name="id_producto" value="{$producto['id']}" hidden="on"></input>
                   {/foreach}
                </div>

                <input type="submit" class="btn btn-default" value="Agregar"></input>
                <div>
                  {if isset($error)}
                  <div class="alert alert-danger" role="alert">{$error}</div>
                  {/if}
                </div>
              </form>

            </div>

          </div>
        </div>
      </div>
    </div>
    {/if}

<!--***FIN AGREGAR NUEVA IMAGEN*******-->
<!--***ACA EMPIEZAN LOS COMENTARIOS*******-->
          <div class="comentarios">

          </div>
          <div class="formAddComentarios">
            {include file="formComentarios.tpl"}
          </div>

<!--***FIN DE COMENTARIOS*******-->

</div>
