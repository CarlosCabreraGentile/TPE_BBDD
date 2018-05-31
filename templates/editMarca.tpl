<div class="tituloEdit">
  <p>Editar El Nombre de La Marca</p>
</div>
<div class="col-md-4 col-md-offset-4">  
<div class="edit">
  <form class="formFiltrar" href="editarMarca">
    {foreach from=$marcas item=marca}
    <p>Marca</p>
    <input class="form-control" type="text" name="nombre" value="{$marca['nombre']}">
    <input type="text" name="id_marca" value="{$marca['id']}" hidden="on">
    <button type="submit" class="btn btn-default" href="{$marca['nombre']}">Editar</button>
    {/foreach}
  </form>
</div>
</div>