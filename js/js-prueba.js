/*FUNCION PARA NAVER GAR CON PARTIAL*/
$(document).ready(function() {
var temporizador;
let templateComentario;
$.ajax({ url: 'js/templates/comentarios.mst'}).done( template => templateComentario = template);
function cargarApi(idProduct,superAdmin) {
  let url="api/comentarios/"+idProduct;
  $.ajax(url).done(function(data) {
      let array=[{n:1},{n:2},{n:3},{n:4},{n:5}]
      let idProd=[{id:idProduct}];
      let rendered = Mustache.render(templateComentario,{data,array,idProd});
      $(".comentarios").html(rendered);
    });
}
function cargar(url) {

  $.ajax({
    url: url,
    method:"GET",
    dataType:"html",
    beforeSend:function(){
      $(".reemplazo").html("<h1><i class='fa fa-superpowers fa-spin'></i> Loading...</h1>");
    },
    success: function(data){
      if(url === "logout" ) {
        // Reload la web completa
        window.location.reload();
      }
      else {
        $(".reemplazo").html(data);
      }
    },
    error: function(){
      $(".reemplazo").html("<h1>Error - Request Failed!</h1>");
    }
  });

  return false;
}
function getForm (datos) {
  let dir = $(datos).attr("href");
  let formData = new FormData(datos);
  let idProduct=$(datos).attr("value");
  $.ajax({
    method: "POST",
    url: dir,
    data: formData,
    contentType: false,
    cache: false,
    processData: false,
    success: function(data) {
      // Si el usuario está logueado refresco la web
      if(dir === "verificarUsuario" ) {
         // Si ingreso la contraseña
         if(data === "User pass error"){
          $("div .form-group").addClass('has-error');
          $("input").val("");
          $('#loginError').css('visibility', 'visible');
        }
        else{
          //Sino Reload la web completa
          window.location.reload();
        }
      }
      else if(dir === "register" ) {
        if(data == "Email Invalido"){
          $("div .form-group").addClass('has-error');
          $("input").val("");
          $('#loginError').css('visibility', 'visible');
        }
        else{
          //Sino Reload la web completa
          window.location.reload();
        }
      }
      else if(dir === "guardarImagenProducto" ) {
          $(".reemplazo").html(data);
          cargarApi(idProduct);
      }
      //Cierro el IF
      else{
        $(".reemplazo").html(data);
      }
    }//Cierro el SUCCESS
  });
}
function crearComentario() {
  let coment={
      "comentario":$("#comentario").val(),
      "valoracion":$("#valoracion").val(),
      "id_producto":$("#id_producto").val(),
      "captcha":$("#captcha").val()
    };
    let idProducto=$("#id_producto").val();
           $.ajax({
                   method: "POST",
                   url: "api/comentarios",
                   data: JSON.stringify(coment),
                 })
               .done(function(data) {
                 cargarApi(idProducto);
               })
               .fail(function(data) {
                   alert('Imposible crear la Comentario');
               });
    }
    function borrarComentario(idComentario,admin) {
      let superAdmin=0;
      let urldelete="api/comentarios/"+idComentario;
      let idProducto=$("#id_producto").val();
      if (admin) {
        superAdmin=1;
      }

      $.ajax({
              method: "DELETE",
              url: urldelete,
            })
          .done(function(data) {
            cargarApi(idProducto);
          })
          .fail(function(data) {
              alert('Imposible Borrar Comentario');
          });

    }
$(document).on('click', '.link-ajax', function (event) {
  event.preventDefault();
  clearInterval(temporizador);
  let url=$(this).attr("href");
  cargar(url);
});
$(document).on('click', '.refresh', function (event) {
  event.preventDefault();
  let url=$(this).attr("href");
  cargar(url);
});

$(document).on('submit','.formFiltrar', function(event){
  event.preventDefault();
  getForm(this);
});
$(document).on('submit','.formAgregarMarca', function(event){
  event.preventDefault();
  getForm(this);
});

/*FUNCIONES PARA REGISTRAR LO Q SE ENVIA POR formulario*/
/*FUNCIONES PARA ASIGNARLES EVENTOS A LOS BOTONES*/
$(document).on('click','.borrarProducto', function(event){
  event.preventDefault();

  let idProducto = $(this).attr("href");
  let jsonProducto = {id_producto: idProducto};
  $.post("borrarProducto", jsonProducto, function(data) {
    $('.reemplazo').html(data);
  });

});
/*FUNCIONES PARA ASIGNARLES EVENTOS A LOS BOTONES*/
$(document).on('click','.borrarUsuario', function(event){
  event.preventDefault();

  let idUsuario = $(this).attr("href");
  let jsonUsuario = {id_usuario: idUsuario};

  $.post("borrarUsuario", jsonUsuario, function(data) {
    $('.reemplazo').html(data);
  });

});
/*FUNCIONES PARA ASIGNARLES EVENTOS A LOS BOTONES*/
$(document).on('click','.editarPermiso', function(event){
  event.preventDefault();

  let permiso = $(this).attr("name");
  let idUsuario = $(this).attr("href");
  let jsonUsuario = {id_usuario: idUsuario, permisoUsuario: permiso};

  $.post("editarPermiso", jsonUsuario, function(data) {
    $('.reemplazo').html(data);
  });

});
/*FUNCIONES PARA ASIGNARLES EVENTOS A LOS BOTONES*/
$(document).on('click','.borrarImagenProducto', function(event){
  event.preventDefault();

  let idProducto = $(this).attr("href");//156
  let imgpath = $(this).attr("data-imgpath"); //ej: 5a076bde41df7_9

 // let jsonProducto = {id_producto: idProducto};

  $.post("borrarImagenProducto", {imgpath, idProducto}, function(data) {
    $('.reemplazo').html(data);
    cargarApi(idProducto);
  });
});
/*FUNCIONES PARA ASIGNARLES EVENTOS A LOS BOTONES*/
$(document).on('click','.editarProducto', function(event){
  event.preventDefault();

  let idProducto = $(this).attr("href");
  let jsonProducto = {id_producto: idProducto};

  $.post("editarProducto", jsonProducto, function(data) {
    $('.reemplazo').html(data);
  });
});
/*FUNCIONES PARA ASIGNARLES EVENTOS A LOS BOTONES*/
$(document).on('click','.mostrarProducto', function(event){
  event.preventDefault();
  let idProducto = $(this).attr("href");
  let superAdmin = $(this).attr("name");
  let jsonProducto = {id_producto: idProducto};

  $.post("mostrarProducto", jsonProducto, function(data) {
    $('.reemplazo').html(data);
    clearInterval(temporizador);
    temporizador=setInterval(function(){cargarApi(idProducto); }, 2000);
  });

});
/*FUNCIONES PARA ASIGNARLES EVENTOS A LOS BOTONES*/
$(document).on('click','.borrarMarca', function(event){
  event.preventDefault();

  let idMarca = $(this).attr("href");
  let jsonProducto = {id_marca: idMarca};

  $.post("borrarMarca", jsonProducto, function(data) {
    $('.reemplazo').html(data);
  });

});
/*FUNCIONES PARA ASIGNARLES EVENTOS A LOS BOTONES*/
$(document).on('click','.comienzoEditarMarca', function(event){
  event.preventDefault();

  let idMarca = $(this).attr("href");
  let jsonProducto = {id_marca: idMarca};

  $.post("comienzoEditarMarca", jsonProducto, function(data) {
    $('.reemplazo').html(data);
  });

});
$(document).on('submit','.formComentarios', function(event){
  event.preventDefault();
  crearComentario();
  refreshInputComentarios();
});
function refreshInputComentarios() {
      let idProducto =$("#id_producto").val();
      let jsonProducto = {id_producto: idProducto};
      $.post("refreshAddComentarios", jsonProducto, function(data) {
        $('.formAddComentarios').html(data);
      });
}

$(document).on('click','.borrarComentario', function(event){
      event.preventDefault();
      let idComentario=$(this).attr("href");
      let admin=$(this).attr("name");
      borrarComentario(idComentario,admin);
    });
});
