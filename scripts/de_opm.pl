#!/usr/bin/perl

use strict;
use warnings;

use OTRS::OPM::Anaylze;
use LWP::Simple;
use File::Temp;

my $location = $ARGV[0];

if ( $