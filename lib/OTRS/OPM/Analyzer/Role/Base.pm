package OTRS::OPM::Analyzer::Role::Base;

# ABSTRACT: interface for all checks

use Moose::Role;

requires 'check';

no Moose::Role;

1;

=head1 INTERFACE

All checks that implement this interface have to provide a I<check> method.

