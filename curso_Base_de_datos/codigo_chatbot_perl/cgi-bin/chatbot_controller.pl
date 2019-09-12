#!C:/indigoampp/perl-5.12.1/bin/perl.exe

use CGI qw();
use chatbot_CRUD;

my $c       = CGI->new;
my $mensaje = $c->param('mensaje');

my $respuesta = "No entendi lo que dijiste!";
my $emoticon  = "pensativo";

if($mensaje =~ /^hola/i){
	$respuesta = "Que tal, como te llamas?";
	$emoticon = "";
}
elsif($mensaje =~ /^me llamo (\w+)/i){
	my $nombreUsuario = $1;

	my $existeElnombre = chatbot_CRUD::buscarNombre($nombreUsuario);
	
	if($existeElnombre eq "SI"){
		$respuesta = "Regresaste!!, como has estado?";
		$emoticon = "encantado";
	}else{
		$respuesta = "mucho gusto " . $nombreUsuario . ", como estas?";
		$emoticon = "abrazo";
		chatbot_CRUD::guardarNombre($nombreUsuario);
	}
}
elsif($mensaje =~ /me cambie de nombre/i){
	$respuesta = "orale!!!, ahora como te llamas?";
	$emoticon = "sorprendido";
}
elsif($mensaje =~ /me llamaba (\w+) y ahora me llamo (\w+)/i){
	my $nombreAnterior = $1;
	my $nombreNuevo    = $2;
	my $resultado = chatbot_CRUD::actualizarNombre($nombreAnterior, $nombreNuevo);
	
	if($resultado == 1){
		$respuesta = "Listo ${nombreNuevo}, ya lo actualice!";
		$emoticon = "listo";
	}
	else{
		$respuesta = "haaa, ese nombre ni lo tenia!";
		$emoticon = "nelpastel";
	}
}

print "Content-type: application/json; charset=iso-8859-1\n\n";

print <<HASTA_EL_FINAL;
{
	"texto": "${respuesta}",
	"emoticon": "${emoticon}"
}
HASTA_EL_FINAL
