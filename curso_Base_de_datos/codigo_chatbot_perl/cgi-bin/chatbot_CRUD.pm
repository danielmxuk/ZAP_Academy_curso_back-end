package chatbot_CRUD;

use DBI;
my $dbh = 0;
my ($dbname, $user, $password, $host, $port, $socket) = ("test", "root", "", "localhost", "3306", "");
my $dsn = "DBI:mysql:$dbname:host=$host:port=$port:mysql_socket=$socket";

sub conectarDB {
	$dbh = DBI->connect($dsn, $user, $password, {PrintError => 0}) || die "Can't connect to the mysql server.\n";
}

sub desconectarDB {
	$dbh->disconnect;
}

sub buscarNombre {
	my $nombreUsuario = $_[0];
	conectarDB();
	my $conteo = $dbh->selectrow_array("SELECT count(1) FROM test.chatbot_usuarios WHERE nombre = '${nombreUsuario}'"); 
	desconectarDB();
	
	if($conteo == 1){
		return "SI";
	}else{
		return "NO";
	}
}

sub guardarNombre {
	my $nombreUsuario = $_[0];
	conectarDB();
	$dbh->do("INSERT INTO test.chatbot_usuarios VALUES ('${nombreUsuario}')");
	desconectarDB();
}

sub actualizarNombre {
	my $nombreAnterior = $_[0];
	my $nombreNuevo    = $_[1];
	conectarDB();
	my $resultado = $dbh->do("UPDATE test.chatbot_usuarios SET nombre = '${nombreNuevo}' WHERE nombre = '${nombreAnterior}'");
	desconectarDB();
	return $resultado;
}

1;