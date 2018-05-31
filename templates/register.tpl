<div class="row">
  <div class="col-md-4 col-md-offset-4">

    <form class="formFiltrar" href="register" method="post">
      <div class="form-group formulario">
         <p><label for="usuario">Usuario</label></p>
        <input type="email" class="form-control" id="usuario" name="usuario" placeholder="ejemplo@email.com" required>
      </div>
      <div class="form-group formulario">
        <p><label for="password">Password</label></p>
        <input type="password" class="form-control" id="password" name ="password" placeholder="Password" required>
      </div>
      <div class="form-group formulario">
        <p><label for="nombre">Nombre</label></p>
        <input type="text" class="form-control" id="nombre" name ="nombre" placeholder="Nombre" required>
      </div>
      <div class="form-group formulario">
        <p><label for="apellido">Apellido</label></p>
        <input type="text" class="form-control" id="apellido" name ="apellido" placeholder="Apellido" required>
      </div>
        <div class="formulario">
        <button type="submit" class="btn btn-default">Registrar</button>
        </div>
      </form>
    </div>
  </div>
  <div class="col-md-4 col-md-offset-4 col-xs-4 col-xs-offset-4" id="loginError">
    <div class="alert alert-danger" role="alert">Error de datos</div>
  </div>
