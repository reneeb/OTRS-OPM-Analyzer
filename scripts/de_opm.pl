#!/usr/bin/perl

use strict;
use warnings;

use LWP::Simple qw(getstore);
use File::Basename;
use File::Path qw(make_path);
use File::Spec;
use File::Temp;
use FindBin;

use lib $FindBin::Bin . '/../lib';
use OTRS::OPM::Analyzer::Utils::OPMFile;

my $location = $ARGV[0];
my $out_dir  = $ARGV[1];

if ( $location =~ m{ \A (?:f|ht)tp:// } ) {
    my  ($fh,$file) = File::Temp::tempfile();
    close $fh;
    
    getstore( $location, $file );
    
    $location = $file;
}

if ( !-f $location ) {
    die "Usage: $0 <location> <output_directory>";
}

my $object = OTRS::OPM::Analyzer::Utils::OPMFile->new(
    opm_file => $location,
);

$object->parse;

for my $file ( $object->files ) {
    my $full_path = File::Spec->catfile( $out_dir, $file->{filename} );
    my $dir       = dirname( $full_path );
    
    make_path( $dir ) if !-e $dir;
    
    open my $fh, '>', $full_path or next;
    print $fh $file->{content};
    close $fh;
}