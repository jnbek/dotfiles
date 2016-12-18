#!/usr/bin/env perl

use strict;
use warnings;

use Cwd;
use File::Copy;
use Env qw(HOME USER PATH DISPLAY);
use File::Path qw(make_path);
use Term::ANSIColor qw(:constants);
use Data::Dumper;
our $VERSION = "1.7.2";
( bless {}, __PACKAGE__ )->main();

sub x11_confs {
    {
        conky     => '_conkyrc',
        mrxvt => '_mrxvt',
        urxvt => '_urxvt',
        xinit => [ '_xinitrc', '_Xdefaults', '_Xmodmap' ],
    };
}

sub opt_confs {
    {
        ack       => '_ackrc',
        colortail => '_colortailrc',
        sqlite3   => '_sqliterc',
        jackd     => '_jackdrc',
    };
}
sub no_brick_bsd { 
    my $self = shift;
    my $key  = shift;
    my $files = {
        "_cshrc"   => 1,
        "_profile" => 1,
    };
    return $files->{$key};
}

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
    if($^O eq 'freebsd') {
        my $sysctl = $self->which('sysctl');
        my $is_jailed = qx{ $sysctl security.jail.jailed };
        return 0 if ($is_jailed =~ 1 && $self->no_brick_bsd($orig);
    }
    $name =~ s/^_/\./xms;

    #$name =~ s/\.sample$//xm if $name =~ m/\.sample$/mx;

    return 0 if $orig eq '_jackdrc' && not $self->which('jackd');
    if (   ( -f "$HOME/$name" && !-l "$HOME/$name" )
        || ( -d "$HOME/$name" && !-l "$HOME/$name" ) )
    {
        make_path( $self->{'bak_path'}, { verbose => 1 } )
          unless -e $self->{'bak_path'};
        move( "$HOME/$name", $self->{'bak_path'} . "/$name" );
    }
    if ( -l "$HOME/$name" ) {
        print BOLD, YELLOW, "Skipping $orig -> $HOME/$name: Symlink exists\n",
          RESET;
    }
    else {
        print BOLD, GREEN, "Creating Symlink: $orig -> $HOME/$name\n", RESET;
        symlink "$cwd/$orig", "$HOME/$name";
    }
    return 0;
}

sub do_cpanp_conf {
    my $self = shift;
    unless ( $self->which("cpanp") )
    {    #Sniff $PATH for cpanp and bail if not present
        print RED, "Skipping cpanplus configuration: cpanp not found!!\n",
          RESET;
        return;
    }
    my $cwd  = $self->{'cwd'};
    my $name = "User.pm";
    my $targ = "$HOME/.cpanplus/lib/CPANPLUS/Config/$name";
    my $orig = "$cwd/dot_cpanplus/$name";
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

