package OTRS::OPM::Analyzer::Role::UnitTests;

# ABSTRACT: checks if the add on has unit tests

use Moose::Role;
use PPI;

with 'OTRS::OPM::Analyzer::Role::Base';

sub check {
    my ($self,$opm) = @_;
    
    my $has_unittest = 0;
    
    FILE:
    for my $file ( @{$opm->files} ) {
        if ( $file->{filename} =~ m{ /scripts/test/ .*?\.t \z } ) {
            $has_unittest = 1;
            last FILE;
        }
    }
    
    return $has_unittest;
}

no Moose::Role;

1;

=head1 METHODS

=head2 check

See I<DESCRIPTION>


