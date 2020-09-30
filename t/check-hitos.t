# -*- cperl -*-

BEGIN { # Hay que poner estos módulos _al final_ para que no fastidien si no están en debian
  for my $path (qw(/usr/lib /usr/local/lib /usr/share/perl5 /usr/lib/x86_64-linux-gnu/perl5/5.24/) ){ # Necesarios para paquetes Debian
    push( @INC, $path)
  }
}

use Test::More;
use Git;
use Mojo::UserAgent;
use File::Slurper qw(read_text);
use JSON;
use Net::Ping;
use Term::ANSIColor qw(:constants);
use YAML qw(LoadFile);

use v5.14; # For say

# Allowed extensions for outline documents
my $extensions = "(md|org)";
my $repo = Git->repository ( Directory => '.' );
my $mi_repo = $repo->command('remote', 'show', 'origin') =~ /JJ\/IV/;
my $diff = $repo->command('diff','HEAD^1','HEAD');
my $diff_regex = qr/a\/proyectos\/hito-(\d)\.md/;
my $ua =  Mojo::UserAgent->new(connect_timeout => 10);
my $github;

SKIP: {
  my ($this_hito) = ($diff =~ $diff_regex);
  unless ( defined $this_hito ) {
    my ($fichero_objetivos) = ( $diff =~ /[ab]\/objetivos\/(\S+)\.$extensions/ );
    ok( $fichero_objetivos, "El envío es del fichero de objetivos y tiene la extensión correcta" );
    skip "No hay envío de proyecto";
  }
  my @files = split(/diff --git/,$diff);

  my ($diff_hito) = grep( /$diff_regex/, @files);
  say "Tratando diff\n\t$diff_hito";
  my @lines = split("\n",$diff_hito);
  my @adds = grep(/^\+[^+]/,@lines);
  is( $#adds, 0, "Añade sólo una línea"); # Test 1
  my ($url_repo) = ( $adds[0] =~ /(https?:[^\)\|\s]+)\)(|\||\s|\b)/ );
  say $url_repo;
  isnt($url_repo,"","El envío incluye un URL"); # Test 2
  like($url_repo,qr/github.com/,"El URL es de GitHub"); # Test 3
  my ($user,$name) = ($url_repo=~ /github.com\/(\S+)\/([^\)\.]+)/);

  # Comprobación de envío de objetivos cuando hay nombre de usuario
  my $prefix = ($repo->{'opts'}->{'WorkingSubdir'} eq 't/')?"..":".";
  my @ficheros_objetivos = glob "$prefix/objetivos/*.*";
  my ($este_fichero) =  grep( /$user/i, @ficheros_objetivos);
  ok( $este_fichero, "$user ha enviado fichero de objetivos con el nombre correcto" ); # Test 4

  # Comprobación de lo diferentes que son los ficheros de objetivos (o no)
  for my $f (@ficheros_objetivos) {
    if ($f ne $este_fichero ) {
      my $diff = `diff $f $este_fichero`;
      diag "✗ Si tus objetivos cumplidos son diferentes, el fichero también debería serlo" 
        unless isnt $diff, "", "El fichero de objetivos enviado no es idéntico a $f";
    }
  }

  # Comprobar que los ha actualizado
  my $objetivos_actualizados = objetivos_actualizados( $repo, $este_fichero );
  is( $objetivos_actualizados, "",
       "Fichero de objetivos $este_fichero está actualizado")
    or skip "Fichero de objetivos actualizados hace $objetivos_actualizados";

  my $repo_dir = create_student_repo_dir( $url_repo, $mi_repo, $user, $name );
  my $student_repo = Git->repository ( Directory => $repo_dir );
  
  my @repo_files = $student_repo->command("ls-files");
  say "Ficheros\n\t→", join( "\n\t→", @repo_files);

  doing("hito 0");
  for my $f (qw( README\.(org|md|rst) \.gitignore LICENSE )) { # Tests 5-7
    isnt( grep( /$f/, @repo_files), 0, "$f presente" );
  }


  # Get the extension used for the README
  my ($readme_file) = grep( /^README/, @repo_files );
  my $README =  read_text( "$repo_dir/$readme_file");
  unlike( $README, qr/[hH]ito/, "El README no debe incluir la palabra hito");

  my $iv; # Fichero de configuración
  if ( $this_hito >= 1 ) {
    doing("hito 1");
    $iv = LoadFile("$repo_dir/iv.yaml");
    ok( $iv, "Fichero de configuración para corrección iv.yaml cargado correctamente" );
    my $with_pip = grep(/req\w+\.txt/, @repo_files);
    if ($with_pip) {
      ok( grep( /requirements.txt/, @repo_files), "Fichero de requisitos de Python con nombre correcto" );
    }

    file_present( $iv->{'entidad'}, \@repo_files, " de implementación de una entidad" );
  }
  
  if ( $this_hito > 1 ) { # Comprobar milestones y eso
    doing("hito 2");
    isnt( grep( /.travis.yml/, @repo_files), 0, ".travis.yml presente" );
    my $travis_domain = travis_domain( $README, $user, $name );
    ok( $travis_domain =~ /(com|org)/ , "Está presente el badge de Travis con enlace al repo correcto");
    if ( $travis_domain =~ /(com|org)/ ) {
      is( travis_status($README), 'Passing', "Los tests deben pasar en Travis");
    }
  }

  if ( $this_hito > 2 ) { # Usando la buildtool para desplegar microservicio
    doing("hito 3");
    my ($buildtool) = ($README =~ m{(?:buildtool:)\s+(\S+)\s+});
    ok( $buildtool, "No he podido encontrar el fichero de build" );
    isnt( grep( /$buildtool/, @repo_files), 0, "$buildtool presente" );
  }

  if ( $this_hito > 3 ) { # Despliegue en algún lado
    doing("hito 4");
    my ($deployment_url) = ($README =~ m{(?:[Dd]espliegue|[Dd]eployment):\s+(https?://\S+)\b});
    if ( $deployment_url ) {
      diag "☑ Hallado URL de despliegue $deployment_url";
    } else {
      diag "✗ Problemas extrayendo URL de despliegue";
    }
    ok( $deployment_url, "URL de despliegue hito 3");
  SKIP: {
      skip "Ya en el hito siguiente", 2 unless $this_hito == 4;
      my $status = $ua->get("$deployment_url/status");
      if ( ! $status || $status =~ /html/ ) {
	$status = $ua->get( "$deployment_url/status"); # Por si acaso han movido la ruta
      }
      ok( $status->res, "Despliegue hecho en $deployment_url" );
      say "Respuesta ", $status->res;
      like( $status->res->headers->content_type, qr{application/json}, "Status devuelve application/json");
      say "Content Type ", $status->res->headers->content_type;
      my $status_ref = json_from_status( $status );
      like ( $status_ref->{'status'}, qr/[Oo][Kk]/, "Status $status_ref de $deployment_url correcto");
    }
  }

  if ( $this_hito > 4 ) { # Dockerfile y despliegue
    doing("hito 5");
    my ($deployment_url) = ($README =~ /(?:[Cc]ontenedor|[Cc]ontainer).+(https?:..\S+)\b/);
    if ( $deployment_url ) {
      diag "☑ Detectado URL de despliegue Docker $deployment_url";
    } else {
      diag "✗ Problemas detectando URL de despliegue de Docker";
    }
    isnt( grep( /Dockerfile/, @repo_files), 0, "Dockerfile presente" );

    my ($dockerhub_url) = ($README =~ m{(https://hub.docker.com/r/\S+)\b});
    unlike($README, qr/docker\.com\/repository/, "No se usa URL privado en dockerhub");
    ok($dockerhub_url, "Detectado URL de DockerHub");
    $dockerhub_url .= "/" if $dockerhub_url !~ m{/$}; # Para evitar redirecciones y errores
    diag "Detectado URL de Docker Hub '$dockerhub_url'";

    if ( ok( $deployment_url,  "URL de despliegue hito 4") ) {
    SKIP: {
	skip "Ya en el hito siguiente", 4 unless $this_hito == 5;
	$deployment_url = ($deployment_url =~ /status/)?$deployment_url:"$deployment_url/status";
	my $status = $ua->get( "$deployment_url" );
	ok( $status->res, "Despliegue hecho en $deployment_url" );
	my $status_ref = json_from_status( $status );
	like ( $status_ref->{'status'}, qr/[Oo][Kk]/, "Status de $deployment_url correcto");
	if ( $dockerhub_url ) {
	  my $dockerhub = $ua->get("$dockerhub_url/Dockerfile");
	  is( $dockerhub->res->code, 200, "Dockerfile actualizado en DockerHub");
	}
      }
    }
  }

   if ( $this_hito > 5 ) { # Despliegue en algún lado
    doing("hito 6");
    my ($provision) = ($README =~ /(?:[Pp]rovision:)\s+(\S+)/);
    isnt( grep( /$provision/, @repo_files ), "Fichero de provisionamiento presente" );
    
  }

  if ( $this_hito > 6 ) { # Despliegue en algún lado
    doing("hito 7");
    my ($deployment_url) = ($README =~ /(?:Despliegue final|Final deployment):\s+(\S+)\b/);
    if ( $deployment_url ) {
      diag "☑ Detectada IP de despliegue $deployment_url";
    } else {
      diag "✗ Problemas detectando IP de despliegue";
    }
    unlike( $deployment_url, qr/(heroku|now)/, "Despliegue efectivamente hecho en IaaS" );
    if ( ok( $deployment_url, "URL de despliegue hito 5") ) {
      check_ip($deployment_url);
      my $status = $ua->get("http://$deployment_url/status");
      ok( $status->res, "Despliegue correcto en $deployment_url/status" );
      my $status_ref = json_from_status( $status );
      like ( $status_ref->{'status'}, qr/[Oo][Kk]/, "Status de $deployment_url correcto");
    }
    isnt( grep( /Vagrantfile/, @repo_files), 0, "Vagrantfile presente" );
    isnt( grep( /despliegue|deployment/, @repo_files), 0, "Hay un directorio 'despliegue'" );
    isnt( grep( m{(despliegue|deployment)/\w+}, @repo_files), 0, "El directorio 'despliegue' no está vacío" );
  }
};

done_testing();

# Subs -------------------------------------------------------------

# Crea el repo del estudiante
sub create_student_repo_dir {
  my ($url_repo, $mi_repo, $user, $name) = @_;
  my $repo_dir;
  if ($mi_repo) {
    $repo_dir = "/tmp/$user-$name";
    if (!(-e $repo_dir) or  !(-d $repo_dir) ) {
      mkdir($repo_dir);
      `git clone $url_repo $repo_dir`;
    }
  } else {
    $repo_dir = ".";
  }
  return $repo_dir;
}


# Antes de cada hito
sub doing {
  my $what = shift;
  diag "\n\t✔ Comprobando $what\n";
}

# Está este fichero en el repo?
sub file_present {
  my ($file, $ls_files_ref, $name ) = @_;
  my @files = (ref($file) eq 'ARRAY')?@$file:($file);
  for my $file (@files ) {
    ok( grep( /$file/, @$ls_files_ref ), "Fichero $name → $file presente" );
  }

}

sub check_ip {
  my $ip = shift;
  if ( $ip ) {
    diag "\n\t".check( "Detectada dirección de despliegue $ip" )."\n";
  } else {
    diag "\n\t".fail_x( "Problemas detectando URL de despliegue" )."\n";
  }
  my $pinger = Net::Ping->new();
  $pinger->port_number(22); # Puerto ssh
  isnt($pinger->ping($ip), 0, "$ip es alcanzable");
}

sub check {
  return BOLD.GREEN ."✔ ".RESET.join(" ",@_);
}

sub fail_x {
  return BOLD.MAGENTA."✘".RESET.join(" ",@_);
}

sub get_github {
  my $url = shift;
  my $page = `curl -ss $url`;
  die "No pude descargar la página" if !$page;
  return $page;
}

sub travis_domain {
  my ($README, $user, $name) = @_;
  my ($domain) = ($README =~ /.Build Status..https:\/\/travis-ci.(\w+)\/$user\/$name\.svg.+$name\)/);
  return $domain;
}

sub travis_status {
  my $README = shift;
  my ($build_status) = ($README =~ /Build Status..([^\)]+)\)/);
  my $status_svg = `curl -L -s $build_status`;
  return $status_svg =~ /passing/?"Passing":"Fail";
}

sub objetivos_actualizados {
  my $repo = shift;
  my $objective_file = shift;
  my $date = $repo->command('log', '-1', '--date=relative', '--', "$objective_file");
  my ($hace,$unidad)= $date =~ /Date:.+?(\d+)\s+(\w+)/;
  if ( $unidad =~ /(semana|week|minut)/ ) {
    return "";
  } elsif ( $unidad =~ /ho/ ) {
    return ($hace > 1 )?"":"demasiado poco";
  } elsif ( $unidad =~ /d\w+/ ){
    return ($hace < 7)?"":"demasiado";
  }

}

# Devuelve el JSON del status
sub json_from_status {
  my $status = shift;
  my $body = $status->res->body;
  say "Body → $body";
  return from_json( $body );
}
