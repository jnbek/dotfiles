#!/usr/bin/env perl -w

use strict;
use warnings;

use Cwd;
use File::Copy;
use Env qw(HOME USER);
use File::Path qw(make_path);

( bless {}, __PACKAGE__ )->main();

sub main {
    my $self     = shift;
    my $now      = time();
    my $cwd      = getcwd();
    my $bak_path = "$cwd/backups/$USER/$now";
    make_path( $bak_path, { verbose => 1 } );
    my $cnt = map {
        my $orig = $_;
        $_ =~ s/^_/\./xm;
        #$_ =~ s/\.sample$//xm if $_ =~ m/\.sample$/mx;
        if ( -f "$HOME/$_" ) {
            copy( "$HOME/$_", "$bak_path/$_" );
        }
        if ( -l "$HOME/$_" ) {
            print "Skipping $orig -> $HOME/$_: Symlink exists\n";
        }
        else {
            symlink $_, "$HOME/$_";
        }
    } ( glob("_*") );
    return 0;
}
