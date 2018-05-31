<div class="tituloEdit">
      <p>Editar características del producto</p>
    </div>
<div class="col-md-4 col-md-offset-4">    
<div class="edit">
<form class="formFiltrar" href="editar">
  {foreach from=$productos item=producto}
  	<p>Modelo</p>
    <input class="form-control" type="text" name="modelo" value="{$producto['modelo']}">
    <p>Memoria</p>
    <input class="form-control" type="text" name="memoria" value="{$producto['memoria']}">
    <p>Banda</p>
    <input class="form-control" type="text" name="banda" value="{$producto['banda']}">
    <p>Consumo</p>
    <input class="form-control" type="text" name="consumo" value="{$producto['consumo']}">
    <input type="text" name="id_producto" value="{$producto['id']}" hidden="on">
    <p> </p>
    <button type="submit" class="btn btn-default" href="{$producto['id']}">Editar</button>
  {/foreach}
</form>
</div>
</div>