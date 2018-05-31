<div class="tituloEdit">
          <p>Lista de Usuarios</p>
    </div>
<div class="container">

<div class="table-responsive">
        <table class="table table-striped centradoBlanco">
          <tr>
            <th><p>USUARIO</p></th>
            <th><p>NOMBRE</p></th>
            <th><p>APELLIDO</p></th>
            <th><p>ELIMINAR USUARIO</p></th>
            <th><p>EDITAR PERMISO</p></th>
            <th><p>QUITAR PERMISO</p></th>
          </tr>
          {foreach from=$usuarios item=usuario}
          <tr>
            <td><p>{$usuario['usuario']}</p></td>
            <td><p>{$usuario['nombre']}</p></td>
            <td><p>{$usuario['apellido']}</p></td>
            <td>
              <div class="col-xs-12 col-sm-12 col-md-12">
                <div class="borrarEditarCentrado">
                  <div class="enLinea">
                    <a href="{$usuario['id_usuario']}" class="borrarUsuario">
                      <p><span id="borrar" class="fa fa-trash-o" aria-hidden="true" value="0"></span></p>
                    </a>
                  </div>
                </div>
              </div>
            </td>
            <td>
            <div class="col-xs-12 col-sm-12 col-md-12">
              <div class="borrarEditarCentrado">
                <div class="enLinea">
                  <a href="{$usuario['id_usuario']}" name="{$usuario['superAdmin']}" class="editarPermiso">
                    <p><span id="asignar" class="fa fa-pencil-square-o" aria-hidden="true" value="0"></span></p>
                  </a>
                </div>
              </div>
            </div>
          </td>
          <td><p>{$usuario['tipo']}</p></td>
          </tr>
          {/foreach}
        </table>
  </div>
</div>  