#!/usr/bin/perl

# PODNAME: opm_analyzer_test.pl

use strict;
use warnings;

use File::Basename;
use File::Spec;
use File::Temp;
use FindBin;

use lib $FindBin::Bin . '/../lib';
use OTRS::OPM::Analyzer;

use Data::Dumper;

my $file     = $ARGV[0];

if ( !$file || !-f $file ) {
    print "$0 <opm_file>";
    exit;
}

my $config   = $FindBin::Bin . '/../conf/base.yml';
my $analyzer = OTRS::OPM::Analyzer->new(
    configfile => $config,
    roles => {
        opm => [qw/Dependencies/],
    },
);
my $results  = $analyzer->analyze( $file );

print Dumper $results;
