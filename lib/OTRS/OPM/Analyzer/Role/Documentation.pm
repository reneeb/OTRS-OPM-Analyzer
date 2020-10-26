package OTRS::OPM::Analyzer::Role::Documentation;

# ABSTRACT: check if .pod, .pdf or .xml files are included

use Moose::Role;

with 'OTRS::OPM::Analyzer::Role::Base';

sub check {
    my ($self,$opm) = @_;
    
    my $has_documentation = 0;
    
    FILE:
    for my $file ( @{$opm->files} ) {
        if ( $file->{filename} =~ m{ /doc/ .*?\.(?:xml|pod|pdf) \z } ) {
            $has_documentation = 1;
            last FILE;
        }
    }
    
    return $has_documentation;
}

no Moose::Role;

1;

=head1 METHODS

=head2 check

Check if some kind of documentation is included

