#!/usr/bin/env perl


use Net::FTP;


my %connection_hash = (
        "server"            => "ftp.isc.org",
        "uri"               => "/isc/bind9/",
        "login"             => "anonymous",
        "password"          => "anonymous"
);

my @new_sorted_array = undef;
my @versions = undef;


my $ftp_con = Net::FTP->new( $connection_hash{"server"}, Debug => 1, Passive => 1  );

$ftp_con->login( $connection_hash{ "login" }, $connection_hash{ "password" } ) or die "Cannot login ", $ftp_con->message;
$ftp_con->cwd( $connection_hash{ "uri" } );

my @dir = map( sort( $_ ) , $ftp_con->ls() );
$ftp_con->quit;


map { if ( ! /rc|a|b|cur|keys/ ) {
                push( @versions, $_ );
            }
} @dir;

my $counter = 0;
foreach my $number ( reverse 0..16 ) {
    if ( $counter eq 0 ) {
        map {
            if ( $_ =~ /9\.$number\.[0-9]/ ) {
                push ( @new_sorted_array, $_ );
                $counter = 1;
            }   
        } @versions;
    }   
}

eval {
    open( my $fhw, ">", ".bind_version" );
    print $fhw "-e BIND_VERSION=" . ( reverse map( sort($_ ), @new_sorted_array ) )[0];
    close($fhw);
    1;
} or do {
    die( "version not found !" );
}


