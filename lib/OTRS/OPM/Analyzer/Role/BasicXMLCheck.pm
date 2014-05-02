package OTRS::OPM::Analyzer::Role::BasicXMLCheck;

# ABSTRACT: Check if the .xml files can be parsed

use Moose::Role;
use XML::LibXML;

with 'OTRS::OPM::Analyzer::Role::Base';

sub check {
    my ( $self, $document ) = @_;
    
    return if $document->{filename} !~ m{ \.xml \z }xms;
    
    my $content = $document->{content};    
    my $check_result = '';
    
    eval {
        my $parser = XML::LibXML->new;
        $parser->parse_string( $content );
    } or $check_result = $@;
    
    return $check_result;
}

no Moose::Role;

1;

=head1 DESCRIPTION

All .xml files are checked if they can be parsed with C<XML::LibXML>

