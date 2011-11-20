
require 5;
package Pod::Perldoc::BaseTo;
use strict;
use warnings;

use vars qw($VERSION);
$VERSION = '3.15_10';

use Carp qw(croak carp);

sub is_pageable        { '' }
sub write_with_binmode {  1 }

sub output_extension   { 'txt' }  # override in subclass!

# sub new { my $self = shift; ...  }
# sub parse_from_file( my($class, $in, $out) = ...; ... }

#sub new { return bless {}, ref($_[0]) || $_[0] }

# this is also in Perldoc.pm, but why look there when you're a
# subclass of this?
sub TRUE  () {1}
sub FALSE () {return}

BEGIN {
 *is_vms     = $^O eq 'VMS'     ? \&TRUE : \&FALSE unless defined &is_vms;
 *is_mswin32 = $^O eq 'MSWin32' ? \&TRUE : \&FALSE unless defined &is_mswin32;
 *is_dos     = $^O eq 'dos'     ? \&TRUE : \&FALSE unless defined &is_dos;
 *is_os2     = $^O eq 'os2'     ? \&TRUE : \&FALSE unless defined &is_os2;
 *is_cygwin  = $^O eq 'cygwin'  ? \&TRUE : \&FALSE unless defined &is_cygwin;
 *is_linux   = $^O eq 'linux'   ? \&TRUE : \&FALSE unless defined &is_linux;
 *is_hpux    = $^O =~ m/hpux/   ? \&TRUE : \&FALSE unless defined &is_hpux;
}

sub _perldoc_elem {
  my($self, $name) = splice @_,0,2;
  if(@_) {
    $self->{$name} = $_[0];
  } else {
    $self->{$name};
  }
}

sub debugging {
    defined(&Pod::Perldoc::DEBUG) and &Pod::Perldoc::DEBUG()
	}

sub debug {
	my( $self, @messages ) = @_;
	return unless $self->debugging;
	print STDERR map { "DEBUG $_" } @messages;
	}

sub warn {
	my( $self, @messages ) = @_;
	carp join "\n", @messages;
	}

sub die {
	my( $self, @messages ) = @_;
	croak join "\n", @messages;
	}

1;

__END__

=head1 NAME

Pod::Perldoc::BaseTo - Base for Pod::Perldoc formatters

=head1 SYNOPSIS

    package Pod::Perldoc::ToMyFormat;

    use base qw( Pod::Perldoc::BaseTo );
    ...

=head1 DESCRIPTION

This package is meant as a base of Pod::Perldoc formatters,
like L<Pod::Perldoc::ToText>, L<Pod::Perldoc::ToMan>, etc.

It provides default implementations for the methods

    is_pageable
    write_with_binmode
    output_extension
    _perldoc_elem

The concrete formatter must implement

    new
    parse_from_file

=head1 SEE ALSO

L<perldoc>

=head1 COPYRIGHT AND DISCLAIMERS

Copyright (c) 2002-2007 Sean M. Burke.

This library is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

This program is distributed in the hope that it will be useful, but
without any warranty; without even the implied warranty of
merchantability or fitness for a particular purpose.

=head1 AUTHOR

Current maintainer: brian d foy C<< <bdfoy@cpan.org> >>

Past contributions from:
Adriano R. Ferreira C<< <ferreira@cpan.org> >>,
Sean M. Burke C<< <sburke@cpan.org> >>

=cut
