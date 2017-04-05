#!/usr/bin/env perl
use strict;
use warnings;
use File::Find;
use Data::Dumper;
( bless {}, __PACKAGE__ )->main();

sub main {
    my $self = shift;
    my $hash = {};   
    for my $inc (grep {!/^\.\.?$/} @INC) {
        find {
            wanted => sub {
                return if !/\.pm\z/;
                my $a = $File::Find::name;
                my $full_path = $a;
                $a =~ s|^\Q$inc\E/||;
                my $mod_path = $a;
                $a =~ s/\//::/g;
                $a =~ s/(.*)\.pm$/$1/g;
                $hash->{$a}->{'count'}++;
                push @{$hash->{$a}->{'fullpath'}}, $full_path;# if $hash->{$a}->{'count'} > 1;
            },
            no_chdir => 1
        }, $inc;
    }
    foreach my $key (keys %{$hash}) {
        printf("%s:\n \t Count: %s\n\tPaths: [ %s ]\n", $key, $hash->{$key}->{'count'} ,(join q{ : }, @{$hash->{$key}->{'fullpath'}})) if $hash->{$key}->{'count'} > 1;
    }
}
