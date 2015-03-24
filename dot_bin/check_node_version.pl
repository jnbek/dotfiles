#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dumper;
use HTTP::Tiny;
use JSON;

( bless {}, __PACKAGE__ )->main();

#Objects
sub arg { $ARGV[0] }

sub http_obj {
    shift->{'_http_obj'} ||= do { HTTP::Tiny->new }
}

sub main {
    my $self = shift;
    my $pkgname = $self->arg || die "NodeJS or AUR package name required";
    if ( $pkgname =~ m/^nodejs-/g ) {
        $pkgname =~ s/^nodejs-//g;
    }
    my $url  = "http://registry.npmjs.org/" . $pkgname;
    my $http = $self->http_obj;
    my $res  = $http->get($url);
    my $hash = from_json( $res->{content} );
    #print Dumper($hash);
    my $latest   = $hash->{'dist-tags'}->{'latest'};
    my $versions = $hash->{'versions'};
    print Dumper( { $pkgname => $versions->{$latest}->{'version'} } );
    return 0;
}
