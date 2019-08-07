#!"C:\xampp\perl\bin\perl.exe"

use CGI qw();
my $c = CGI->new;

# print $c->header('text/plain');
print "Content-type: text/html; charset=iso-8859-1\n\n";

print "<strong>hola Daniel!!</strong>";

if( $c->request_method eq 'GET' && $c->param('dato') ) {
	print "si llego: <br>" . $c->param('dato') . "<br>";
} else {
	print "no llego";
}
print '<br><br>Eso es todo!!';