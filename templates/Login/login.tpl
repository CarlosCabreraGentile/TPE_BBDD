<div class="row">
  <div class="col-md-4 col-md-offset-4">
    <form class="formFiltrar" href="verificarUsuario" method="post">
      <div class="form-group formulario">
         <p><label for="usuario">Usuario</label></p>
            <input type="text" class="form-control" id="usuario" name="usuario" placeholder="Usuario" required>
      </div>
      <div class="form-group formulario">
        <p><label for="password">Password</label></p>
          <input type="password" class="form-control" id="password" name ="password" placeholder="Password" required>
      </div>
      <div class="formulario">
        <button type="submit" class="btn btn-default">Login</button>
      </div>
    </form>
  </div>
</div>
<div class="col-md-4 col-md-offset-4 col-xs-4 col-xs-offset-4" id="loginError">
  <div class="alert alert-danger" role="alert">Usuario y/o contraseña incorrectas</div>  
</div>