#!"C:\xampp\perl\bin\perl.exe"

use CGI qw();
my $c = CGI->new;
my @arreglo = ["hola", "mi nombre es"];
my $filename = 'C:\xampp\cgi-bin\datos.txt';


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
	
	my $existeElnombreEnArchivo = buscarNombre($nombreUsuario);
	
	if($existeElnombreEnArchivo eq "SI"){
		$respuesta = "Otra vez por aca " . $nombreUsuario
		
	}else{
		$respuesta = "mucho gusto " . $nombreUsuario . ", yo soy el servidor";
		escribe_en_archivo($nombreUsuario);
	}
}

print <<HASTA_EL_FINAL;
{
	"llavePrimaria": "${respuesta}",
	"llego2": "valor2"
}
HASTA_EL_FINAL


sub escribe_en_archivo {
	my 	$nombreUsuario = $_[0];
	
	open(my $fh, '>>:encoding(UTF-8)', $filename) or die "Could not open file '$filename' $!";
	print $fh "$nombreUsuario\n";
	close $filename;
}

sub buscarNombre{
	my 	$nombreUsuario = $_[0];
	my $existeElnombreEnArchivo = "NO";
	open(my $fh, '<:encoding(UTF-8)', $filename) or die "Could not open file '$filename' $!";
	#my @contenidoArchivo = <$fh>;	
	while(my $linea = <$fh>){
		chomp($linea);
		if($linea =~ /$nombreUsuario/i){
			$existeElnombreEnArchivo = "SI";
		}
	}
	close $filename;
	return $existeElnombreEnArchivo;
}

