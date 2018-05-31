{if $usuario}
<div class="row">
    <div class="col-xs-12 col-sm-6 col-sm-offset-3 col-md-6 col-md-offset-3 formulario">
        <form href="api/comentarios" class="formComentarios" enctype="multipart/form-data">
            <div class="form-group">
                  <label for="comentario">Agregar Comentario</label>
                  <input type="text" class="form-control" id="comentario" name="comentario"  placeholder="Comentario..." required></input>
                  <label for="valoracion">Valoracion</label>
                  <select class="marca" id="valoracion" name="valoracion">
                        <option class="marca" value="1" name="valoracion">1</option>
                        <option class="marca" value="2" name="valoracion">2</option>
                        <option class="marca" value="3" name="valoracion">3</option>
                        <option class="marca" value="4" name="valoracion">4</option>
                        <option class="marca" value="5" name="valoracion">5</option>
                  </select>
                    {foreach from=$productos item=producto}
                  <input type="text"  class="idProducto"  id="id_producto"name="id_producto" value="{$producto['id']}" hidden="on"></input>
                    {/foreach}

            </div>
              <img src="{$imagenCaptcha}" alt="captcha">
              <input type="text" class="form-control" id="captcha" placeholder="Ingresar Captcha" value="" required>
              <input type="submit" class="btn btn-default" value="Agregar">
        </form>
      </div>
</div>
{/if}
