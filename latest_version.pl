#!/usr/bin/env perl


use Net::FTP;


my %connection_hash = (
        "server"              => "ftp.isc.org",
        "uri"                     => "/isc/bind9/",
        "login"                => "anonymous",
        "password"      => "anonymous"
);

my $ftp_con = Net::FTP->new( $connection_hash{"server"}, Debug => 1, Passive => 1  );

$ftp_con->login( $connection_hash{ "login" }, $connection_hash{ "password" } ) or die "Cannot login ", $ftp_con->message;
$ftp_con->cwd( $connection_hash{ "uri" } );

my @dir = map( sort( $_ ) , $ftp_con->ls());
my @versions = undef;

$ftp_con->quit;


foreach ( @dir )
{
    # remove alpha, beta, rc version
    if ( $_ !~ /rc|a|b/ ) {
        push @versions, $_;
    }
}

my @new_sorted_array = undef;
my $counter = 0;

foreach my $number ( reverse 0..16 )
{
    if ( $counter eq 0 ) {
        foreach my $version ( @versions )
        {
            if ( $version =~ /9\.$number.*/ )
            {
                push ( @new_sorted_array, $version );
                $counter = 1;
            }
        }
    }   
}


my $environment_variable = (reverse map( sort($_), @new_sorted_array))[0];
$ENV{BIND_VERSION} = $environment_variable;

open( my $fhw, ">", ".bind_version" ) or die ($!);
print $fhw "-e BIND_VERSION=$environment_variable";
close($fhw);




