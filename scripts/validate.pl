#!/usr/bin/perl

use strict;
use warnings;

use File::Basename;
use File::Spec;
use XML::LibXML;

if ( !$ARGV[0] and -f $ARGV[0] ) {
    die "Usage: $0 <file_to_check.opm>\n";
}

my $dir      = dirname __FILE__;
my $xsd_path = File::Spec->catfile( $dir, '..', 'doc', 'opm.xsd' );

my $schema = XML::LibXML::Schema->new( location => $xsd_path );
my $parser = XML::LibXML->new;

$parser->keep_blanks(0);

my $tree   = $parser->parse_file( $ARGV[0] );

eval{
    $schema->validate( $tree );
    1;
} or die $@;

print "done";