#!"C:\xampp\perl\bin\perl.exe"

use DBI;
use CGI qw();
my $c = CGI->new;

#$ENV{'PATH'} .= ';C:\xampp\perl\bin';
$ENV{'PATH'} .= ';C:\indigoampp\perl-5.12.1\bin';

my $operacion = $c->param('operacion');
my $nombreUsuario = $c->param('nombreUsuario');

my $respuesta = "No recibi un comando valido!";

my ($dbname, $user, $password, $host, $port, $socket) = 
("test", "root", "", "localhost", "3306", "");

my $dsn = "DBI:mysql:$dbname:host=$host:port=$port:mysql_socket=$socket";
my $dbh = DBI->connect($dsn, $user, $password, {PrintError => 0}) || die("Can't connect to the mysql server.\n");

if($operacion eq 'buscarNombre'){
	
	my ($cuantosEncontro) = $dbh->selectrow_array("Select count(1) from prueba where nombre = '${nombreUsuario}'");
	
	if($cuantosEncontro > 0){
		$respuesta = "SI";
	}else{
		$respuesta = "NO";
	}
	
}elsif($operacion eq 'guardarNombre'){
	
	$dbh->do("Insert into prueba values (2, '${nombreUsuario}')");
	
	$respuesta = "Nuevo nombre ${nombreUsuario} guardado en DB.";
}
                
$dbh->disconnect;

print "$respuesta\n";


# Ejemplo de como ver el contenido de una tabla:
#
# my $sth = $dbh->prepare("SELECT * FROM prueba");
# $sth->execute() || die "no puede ejecutar el query!";
# print "contenido de la tabla:\n";
# my $hashref;
#while ($hashref = $sth->fetchrow_hashref()) {
#	my $f;
#	foreach $f (keys (%{$hashref}) ) {
#		print "$f = " . $hashref->{$f} . "\n";
#	}
#}
