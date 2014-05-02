#!/usr/bin/perl

# PODNAME: validate_opms.pl
# ABSTRACT: Validate .opms against the XML schema

use strict;
use warnings;

use File::Basename;
use File::Find::Rule;
use File::Spec;
use XML::LibXML;

if ( !( $ARGV[0] and -d $ARGV[0] ) ) {
    die "Usage: $0 <dir_with_opms>\n";
}

my $dir      = dirname __FILE__;
my $xsd_path = File::Spec->catfile( $dir, '..', 'doc', 'opm.xsd' );

my @opms = File::Find::Rule->maxdepth(1)->file->name( '*.opm' )->in( $ARGV[0] );

for my $opm ( @opms ) {


    my $schema = XML::LibXML::Schema->new( location => $xsd_path );
    my $parser = XML::LibXML->new;

    $parser->keep_blanks(0);
    
    my $tree   = $parser->parse_file( $opm );
    print "$opm: ";
    
    my $ok = 'ok';

    eval{
        $schema->validate( $tree );
        1;
    } or $ok = $@;
    
    print "$ok\n";
    
    #<STDIN>;
}

print "done";
