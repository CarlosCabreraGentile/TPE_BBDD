<div class="tablafondo">
  <!--HOME Presentation -->
  <div class="conthome2">
    <p>Comparativa entre ATI y NVidia</p>
  </div>
  <!-- RESERVATION FORM -->
        <section class="reservation-form-over no-padding">
            <div class="container">
                <div class="row">

                    <div class="reservation-form">
                        <form action="#" method="post">

                            <div class="col-md-3">
                                <div class="form-group2">
                                    <label>Check in</label>
                                    <div class="form-group2">
                                        <div class="input-group date" id="datetimepicker1">
                                            <input type="text" class="form-control" />
                                            <span class="input-group-addon">
                      <span class="fa fa-calendar"></span>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group2">
                                    <label>Check in</label>
                                    <div class="form-group2">
                                        <div class="input-group date" id="datetimepicker2">
                                            <input type="text" class="form-control" />
                                            <span class="input-group-addon">
                      <span class="fa fa-calendar"></span>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>



                            <div class="col-md-1">
                                <div class="form-group2">
                                    <label>Adults</label>
                                    <input type="number" placeholder="2" name="adults" value="" max="10" min="1">
                                </div>
                            </div>

                            <div class="col-md-1">
                                <div class="form-group2">
                                    <label>Children</label>
                                    <input type="number" placeholder="0" name="children" value="" max="10" min="1">
                                </div>
                            </div>



                            <div class="col-md-2">
                                <div class="form-group2">
                                    <label>Room type</label>
                                    <select id="room_type" name="room_type">
                                        <option value="">Select Room</option>

                                        <option value="Single Room">Single Room</option>

                                        <option value="Double Room">Double Room</option>

                                        <option value="King double Room">King double Room</option>
                                    </select>
                                </div>
                            </div>

                            <div class="col-md-2">
                                <div class="form-group2">
                                    <button class="btn btn-default m-t-35">Check Avaliability</button>
                                </div>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </section>
        <!-- end: RESERVATION FORM -->
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
          <th><p >MARCA</p></th>
          <th><p >MODELO</p></th>
          <th><p >MEMORIA RAM (GB)</p></th>
          <th><p >ANCHO DE BANDA (GB/s)</p></th>
          <th><p >CONSUMO (W)</p></th>
          <th><p >DETALLES</p></th>
          {if $superAdmin}
          <th><p ></p></th>
          {/if}
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
                  <a href="{$producto['id']}" class="mostrarProducto" name="{$superAdmin}">
                    <p><span id="mostrar" class="fa fa-info-circle" aria-hidden="true" value="0"></span></p>
                  </a>
                </div>
              </div>
            </div>
          </td>
          {if $superAdmin}
          <td>
            <div class="col-xs-12 col-sm-12 col-md-12">
              <div class="borrarEditarCentrado">
                <div class="enLinea">
                  <a href="{$producto['id']}" class="borrarProducto">
                    <p><span id="borrar" class="fa fa-trash-o " aria-hidden="true" value="0"></span></p>
                  </a>
                </div>
                <div class="enLinea">
                  <a href="{$producto['id']}" class="editarProducto">
                    <p><span id="editar" class="fa fa-pencil-square-o " aria-hidden="true" value="0"></span></p>
                  </a>
                </div>
              </div>
            </div>
          </td>
          {/if}
        </tr>
        {/foreach}
      </table>
    </div>
    {if $superAdmin}
    <div class="row">
      <div class="col-xs-12 col-sm-6 col-sm-offset-3 col-md-6 col-md-offset-3 formulario">
        <div class="msj">
          <div class="panel panel-default">

            <div class="panel-body">

              <form href="guardarProducto" class="formFiltrar" enctype="multipart/form-data">

                <div class="form-group">
                  <label for="id_marca">Seleccione una marca</label>

                  <select class="marca" name="id_marca">
                    {foreach from=$marcas item=marca}
                    <option class="marca" value="{$marca['id']}" name="id_marca">{$marca['nombre']}</option>
                    {/foreach}
                  </select>
                </div>
                <div class="form-group">
                  <label for="modelo">Modelo</label>
                  <input type="text" class="form-control" id="modelo" name="modelo"  placeholder="Modelo de VGA"></input>
                </div>
                <div class="form-group">
                  <label for="memoria">Memoria</label>
                  <input type="text" class="form-control" id="memoria" name="memoria"  placeholder="Memoria"></input>
                </div>
                <div class="form-group">
                  <label for="banda">Ancho de Banda</label>
                  <input type="text" class="form-control" id="banda" name="banda"  placeholder="Ancho de Banda"></input>
                </div>
                <div class="form-group">
                  <label for="consumo">Consumo</label>
                  <input type="text" class="form-control" id="consumo" name="consumo"  placeholder="Consumo"></input>
                </div>
                <div class="form-group">
                  <label for="consumo">Adjuntar Imagen</label>
                  <input type="file" class="form-control" id="consumo" name="imagenproducto[]"  value="" multiple></input>
                </div>

                <input type="submit" class="btn btn-default" value="Crear">
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

    <div class="table-responsive">
      <div class="col-xs-12 col-sm-6 col-sm-offset-3 col-md-6 col-md-offset-3 formulario">
        <table class="table table-striped centradoBlanco">
          <tr>
            <th><p >MARCA</p></th>

            <th><p ></p></th>

          </tr>
          {foreach from=$marcas item=marca}
          <tr>
            <td><p>{$marca['nombre']}</p></td>

            <td>
              <div class="col-xs-12 col-sm-12 col-md-12">
                <div class="borrarEditarCentrado">
                  <div class="enLinea">
                    <a href="{$marca['id']}" class="borrarMarca">
                      <p><span id="borrarMarca" class="fa fa-trash-o " aria-hidden="true" value="0"></span></p>
                    </a>
                  </div>
                  <div class="enLinea">
                    <a href="{$marca['id']}" class="comienzoEditarMarca">
                      <p><span id="editarMarca" class="fa fa-pencil-square-o " aria-hidden="true" value="0"></span></p>
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

    <div class="row">
      <div class="col-xs-12 col-sm-6 col-sm-offset-3 col-md-6 col-md-offset-3 formulario">
        <div class="msj">
          <div class="panel panel-default">
            <div class="panel-body">
              <form href="guardarMarca" class="formAgregarMarca">

                <div class="form-group">
                  <label for="id_marca">Agregar una marca</label>
                </div>
                <div class="form-group">
                  <label for="marca">Marca</label>
                  <input type="text" class="form-control" id="marca" name="marca"  placeholder="Marca ej:msi">
                </div>
                <input type="submit" class="btn btn-default" value="Crear">
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

  </div>
</div>
{/if}
</div>
</div>
</div>
</div>
