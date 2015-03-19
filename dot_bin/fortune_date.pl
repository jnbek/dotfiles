#!/usr/bin/perl -w

use strict;
use warnings;

use POSIX;
use Sys::Hostname;

( bless {}, __PACKAGE__ )->main();

sub main {
    my $self = shift;

    my $hostname = hostname();
    my $nl       = "\n";
    my $fortune  = "";
    my $date     = strftime( "%c", localtime(time) );
    my $time     = strftime( "%X", localtime(time) );
    chomp $date;
    chomp $time;
    if ( my $exec = $self->get_bin ) {
        $fortune = qx{$exec};
        chomp $fortune;
    }
    else {
        $fortune = $date;
    }
    my $text = [ $date, $time, $fortune, $hostname ];
    my $index = rand @{$text};
    print qq{ $text->[$index] };
    exit(0);
}

sub get_bin {
    my $self = shift;
    my $fortune = $self->{'__fortune'} ||= do {
        my $exec;
        foreach my $dir ( split( /:/, $ENV{'PATH'} ) ) {
            if ( -x "$dir/fortune" ) {
                $exec = "$dir/fortune";
                last;
            }
        }
        $exec;
    };
    return $fortune;
}

__END__
print qq{
    $fortune
    $nl
    $date
    $nl
   $time
}
