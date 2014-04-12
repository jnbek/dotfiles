#!/usr/bin/env perl

use strict;
use warnings;

use Cwd;
use File::Copy;
use Env qw(HOME USER);
use File::Path qw(make_path);
use Term::ANSIColor qw(:constants);

our $VERSION = "1.5";
( bless {}, __PACKAGE__ )->main();

sub main {
    my $self = shift;
    my $now  = time;
    my $cwd  = $self->{'cwd'} ||= do { getcwd(); };
    $self->{'bak_path'} = "$cwd/backups/$USER/$now";
    make_path( $self->{'bak_path'}, { verbose => 1 } );
    my $cnt = map { $self->install($_) } ( glob "_*" );
    return 0;
}

sub install {
    my $self = shift;
    my $name = shift;
    my $cwd  = $self->{'cwd'};
    my $orig = $name;
    $name =~ s/^_/\./xms;
    #$name =~ s/\.sample$//xm if $name =~ m/\.sample$/mx;
    if (   ( -f "$HOME/$name" && !-l "$HOME/$name" )
        || ( -d "$HOME/$name" && !-l "$HOME/$name" ) )
    {
        move( "$HOME/$name", $self->{'bak_path'} . "/$name" );
    }
    if ( -l "$HOME/$name" ) {
        print BOLD, YELLOW, "Skipping $orig -> $HOME/$name: Symlink exists\n", RESET;
    }
    else {
        print BOLD, GREEN, "Creating Symlink: $orig -> $HOME/$name\n", RESET;
        symlink "$cwd/$orig", "$HOME/$name";
    }
    return 0;
}
