#! /usr/bin/perl -w
eval 'exec /usr/bin/perl -S $0 ${1+"$@"}'
  if 0;    #$running_under_some_shell

use strict;
use warnings;
use Data::Dumper;
use Cwd        ();
use File::Find ();

    use vars qw/*name *dir *prune/;
    *name  = *File::Find::name;
    *dir   = *File::Find::dir;
    *prune = *File::Find::prune;

( bless {}, __PACKAGE__ )->main();

sub pwd { shift->{'__cwd'} ||= Cwd::cwd() }

sub main {
    my $self = shift;
    $self->{'orphans'} = [];
    $SIG{'INT'} = sub { exit };
    my $cwd = $self->pwd;
    foreach my $d (@INC) {
        next if $d =~ m/^\.\.?$/;
        my $want = sub { return $self->wanted };
        File::Find::find( { wanted => $want }, $d );
    }
    print "The following files are orphaned/not owned by a package:\n";
    print Dumper($self->{'orphans'});
    exit;
}

sub wanted {
    my $self = shift;
    my ( $dev, $ino, $mode, $nlink, $uid, $gid );

    ( ( $dev, $ino, $mode, $nlink, $uid, $gid ) = lstat($name) )
      && -f _
      && $self->doexec();
}

sub doexec {
    my $self = shift;
    my $orphans = [];
    my $regex = qr/^error:\sNo\spackage\sowns/;
    my $command = "/usr/bin/pacman -Qo $name 2>&1";
    my $output  = qx{$command};
    chomp($output);
    #print "$output\n" if $output =~ $regex;
    print "$output\n" if grep {"-v"} @ARGV;
    if ($output =~ $regex) {
        $output =~ s/$regex\s(.+)$/$1/;
        push @{$self->{'orphans'}}, $output;
    }
    return 0;
}
