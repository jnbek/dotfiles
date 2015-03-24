#!/usr/bin/env perl 

use strict;
use warnings;

use CPANPLUS::Backend;
use Data::Dumper;

( bless {}, __PACKAGE__ )->main();

# Objects
sub arg { $ARGV[0] }

sub cplus_obj {
    shift->{'__cpanplus_obj'} ||= do { CPANPLUS::Backend->new }
}

sub main {
    my $self    = shift;
    my $pkgname = $self->arg || die "Perl or AUR package name required";
    my $cb_obj  = $self->cplus_obj;
    if ( $pkgname =~ m/^perl-/g ) {
        $pkgname =~ s/^perl-//g;
    }
    if ( $pkgname =~ m/\-/g ) {
        $pkgname =~ s/\-/::/g;
    }
    my $regex = qr/^$pkgname$/i;
    my ($mod_obj) = $cb_obj->search( type => "name", allow => [$regex], verbose => 1 );
    print Dumper( { $mod_obj->module => $mod_obj->version } );
    return 0;
}
