console.log("Cargando codigo JavaScript");

function enviarDatos(){
	var valor1 = document.getElementById('otroNombre').value;
	var valor2 = document.getElementById('valor2').value;
	
	console.log("Envio valor1: " + valor1);
	console.log("Envio valor2: " + valor2);
	
	$.ajax({
		beforeSend : function (){
			console.log("Espera un momento....");
		},
		headers: { 
	        'Accept': 'application/json',
	        'Content-Type': 'application/json' 
	    },
		url: '/cgi-bin/recibir_datos_03_JSON.pl?valor1=' + valor1,
		type: "GET",
		dataType: "json",
		success: function (responseData) {
			console.log("Me llego: " + JSON.stringify(responseData) );
			console.log("Me llego2: " + responseData.llavePrimaria );
			document.getElementById("aqui_va_la_respuesta").innerHTML = "<strong style='color:blue'>" + responseData.llavePrimaria + "</strong>";
		},
		error: function() {
			alert("no pude completar la comunicacion!!");
		},
		complete: function() {
			console.log("Ya termine!!");
		}
	});

}

console.log("JavaScript Listo");