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
      if(url === "filtrar" ) {
        // Reload la web completa
        mostrarDatos(data);
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
        mostrarDatos(data);
    }//Cierro el SUCCESS
  });
}

  function mostrarDatos(data){
  console.log(data);
  $('.fyc-calendar').remove();
  let calendario = $('#calendar').fullYearCalendar({
    yearStart: new Date(data[2]),
    yearEnd: new Date(data[3])
  });
  let diasOcupados = [];
  for(let dia in data[1]){
    if(data[1][dia] == 1){
      let fecha = data[0]+'-'+dia;
      diasOcupados.push(fecha);
    }
  }
  for(let i = 0; i < diasOcupados.length; i++){
    calendario.addHoliday({
      type: 'publicHolidays',
      from: diasOcupados[i],
      to: diasOcupados[i]
    });
  }
}


$(document).on('click', '.link-ajax', function (event) {
  event.preventDefault();
  clearInterval(temporizador);
  let url=$(this).attr("href");
  cargar(url);
});

$(document).on('submit','.formFiltrar', function(event){
  event.preventDefault();
  getForm(this);
});
});
