#!"C:\xampp\perl\bin\perl.exe"

use CGI qw();
my $c = CGI->new;
my @arreglo = ["hola", "mi nombre es"];
# print $c->header('text/plain');
print "Content-type: application/json; charset=iso-8859-1\n\n";

my $valor1 = $c->param('valor1');
my $respuesta = "No entendi lo que dijiste";
if($valor1 =~ /hola/i){
	$respuesta = "Que tal, buenos dias :), como te llamas?";
}
if($valor1 =~ /mi nombre es/i){
	my $nombreUsuario = $valor1;
	$nombreUsuario =~ s/mi nombre es//i; 
	$respuesta = "mucho gusto " . $nombreUsuario . ", yo soy el servidor";
} 
print <<HASTA_EL_FINAL;
{
	"llavePrimaria": "${respuesta}",
	"llego2": "valor2"
}
HASTA_EL_FINAL
