#!/usr/bin/perl 
use strict;
use warnings;

use Data::Dumper;
use JSON;
use HTTP::Tiny;
(bless {}, __PACKAGE__)->main;

sub arg { $ARGV[0] }

sub main {
    my $self = shift;
    my $pkgname  = $self->arg || die "NodeJS or AUR package name required";
    if ($pkgname =~ m/^nodejs-/g) {
        $pkgname =~ s/^nodejs-//g;
    }

    my $url = "http://registry.npmjs.org/".$pkgname;
    my $http = HTTP::Tiny->new;
    my $res = $http->get($url);
    my $hash = from_json($res->{content});
    #print Dumper($hash);
    my $latest = $hash->{'dist-tags'}->{'latest'};
    my $versions = $hash->{'versions'};
    print Dumper($versions->{$latest}->{'version'});
    return 0;
}


