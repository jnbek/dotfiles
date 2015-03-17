#!/usr/bin/env perl

use strict;
use warnings;

use Cwd;
use File::Copy;
use Env qw(HOME USER PATH);
use File::Path qw(make_path);
use Term::ANSIColor qw(:constants);

our $VERSION = "1.7";
( bless {}, __PACKAGE__ )->main();

sub main {
    my $self = shift;
    my $now  = time;
    my $cwd  = $self->{'cwd'} ||= do { getcwd(); };
    $self->{'bak_path'} = "$cwd/backups/$USER/$now";
    my $cpc = $self->do_cpanp_conf();
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
        make_path( $self->{'bak_path'}, { verbose => 1 } );
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

sub do_cpanp_conf {
    my $self = shift;
    unless ( $self->which("cpanp") ) {    #Sniff $PATH for cpanp and bail if not present
        print RED, "Skipping cpanplus configuration: cpanp not found!!\n", RESET;
        return;
    }
    my $cwd  = $self->{'cwd'};
    my $name = "User.pm";
    my $targ = "$HOME/.cpanplus/lib/CPANPLUS/Config/$name";
    my $orig = "$cwd/cpanplus_config/$name";
    unless ( -d "$HOME/.cpanplus/lib/CPANPLUS/Config/" ) {
        make_path( "$HOME/.cpanplus/lib/CPANPLUS/Config/", { verbose => 1 } );
    }
    if ( -f $targ && !-l $targ ) {
        move( $targ, $self->{'bak_path'} . "/$name" );
    }
    if ( -l $targ ) {
        print BOLD, YELLOW, "Skipping $orig -> $targ: Symlink exists\n", RESET;
    }
    else {
        print BOLD, GREEN, "Creating Symlink: $orig -> $targ\n", RESET;
        symlink $orig, $targ;
    }
    return 0;
}

sub which {
    my $self    = shift;
    my $program = shift;
    foreach my $dir ( split ':', $PATH ) {
        return "$dir/$program" if -x "$dir/$program";
    }
    return;
}

