#!/usr/bin/perl

use strict;
use warnings;

use Test::More;

use OTRS::OPM::Analyzer;
use FindBin;
use File::Basename;
use File::Spec;

my $config   = $FindBin::Bin . '/../conf/base.yml';
my $opm_file = File::Spec->catfile( dirname(__FILE__), 'data', 'QuickMerge-3.3.2.opm' );
my $opm      = OTRS::OPM::Analyzer->new( configfile => $config );

isa_ok $opm, 'OTRS::OPM::Analyzer';

TODO: {
    local $TODO = "Deep stuff I don't understand";
    my $result = eval { $opm->analyze($opm_file) };
    diag $@ if $@;
    my $check = {};

    is_deeply $result, $check;
    is $result,        undef;
}
done_testing();
