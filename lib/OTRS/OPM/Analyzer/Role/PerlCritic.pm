package OTRS::OPM::Analyzer::Role::PerlCritic;

use Moose::Role;

use File::Basename;
use File::Temp ();
use Perl::Critic;

with 'OTRS::OPM::Analyzer::Role::Base';

sub check {
    my ($self,$document) = @_;
    
    return if $document->{filename} !~ m{ \. (?:pl|pm|pod|t) \z }xms;
    
    my ($file,$path,$suffix) = fileparse( $document->{filename}, qr{ \..* \z }xms );
    
    my $fh = File::Temp->new(
        SUFFIX => $suffix,
    );
    
    my $filename = $fh->filename;
    
    print $fh $document->{content};
    close $fh;
    
    my $conf_path    = $self->config->get( 'utils.config' );
    my $perlcriticrc = $self->config->get( 'utils.perlcritic.config' );
    my $theme        = $self->config->get( 'utils.perlcritic.theme' ) || 'otrs';
    my $include      = $self->config->get( 'utils.perlcritic.include' ) || ['otrs'];

    my %options;
    $options{-profile} = $conf_path . '/' . $perlcriticrc if $perlcriticrc;
    
    my $critic       = Perl::Critic->new(
        -theme    => $theme,
        -include  => $include,
        %options,
    );
    
    my @violations = $critic->critique( $filename );
    my $return     = join '', @violations;
    
    return $return;
}

no Moose::Role;

1;
