package CPANPLUS::Config::User;
# ~/.cpanplus/lib/CPANPLUS/Config/User.pm

use strict;
use warnings;
use Env qw(EDITOR HOME PAGER PATH SHELL);

###############################################
###
###  Configuration structure for CPANPLUS::Config::User
###
###############################################

#sub source_engine { 'CPANPLUS::Internals::Source::Memory' }
sub source_engine { 'CPANPLUS::Internals::Source::SQLite' }

sub setup {
    my $conf = shift;

    ### conf section
    $conf->set_conf( allow_build_interactivity => 1 );
    $conf->set_conf( allow_unknown_prereqs     => 1 );
    $conf->set_conf( base                      => "$HOME/.cpanplus" );
    $conf->set_conf( buildflags                => '' );
    $conf->set_conf( cpantest                  => 0 );
    $conf->set_conf( cpantest_mx               => '' );
    $conf->set_conf( cpantest_reporter_args    => {} );
    $conf->set_conf( debug                     => 1 );
    $conf->set_conf( dist_type                 => '' );
    $conf->set_conf( email                     => 'jnbek@cpan.org' );
    $conf->set_conf( enable_custom_sources     => 1 );
    $conf->set_conf( extractdir                => '' );
    $conf->set_conf( fetchdir                  => '' );
    $conf->set_conf( flush                     => 1 );
    $conf->set_conf( force                     => 0 );
    $conf->set_conf( histfile                  => "$HOME/.cpanplus/history" );
    $conf->set_conf(
        hosts => [
            {
                'scheme' => 'http',
                'host'   => 'www.cpan.org',
                'path'   => '/'
            }, {
                'scheme' => 'ftp',
                'path'   => '/pub/CPAN/',
                'host'   => 'ftp.cpan.org'
            }, {
                'scheme' => 'ftp',
                'path'   => '/',
                'host'   => 'cpan.hexten.net'
            }, {
                'scheme' => 'ftp',
                'host'   => 'cpan.cpantesters.org',
                'path'   => '/CPAN/'
            }, {
                'path'   => '/pub/languages/perl/CPAN/',
                'host'   => 'ftp.funet.fi',
                'scheme' => 'ftp'
            }
        ]
    );
    $conf->set_conf( lib                => [] );
    $conf->set_conf( makeflags          => '' );
    $conf->set_conf( makemakerflags     => '' );
    $conf->set_conf( md5                => 1 );
    $conf->set_conf( no_update          => 0 );
    $conf->set_conf( passive            => 1 );
    $conf->set_conf( prefer_bin         => 1 );
    $conf->set_conf( prefer_makefile    => 1 );
    $conf->set_conf( prereqs            => 1 );
    $conf->set_conf( shell              => 'CPANPLUS::Shell::Default' );
    $conf->set_conf( show_startup_tip   => 1 );
    $conf->set_conf( signature          => 0 );
    $conf->set_conf( skiptest           => 0 );
    $conf->set_conf( source_engine      => source_engine() );
    $conf->set_conf( storable           => 1 );
    $conf->set_conf( timeout            => 300 );
    $conf->set_conf( verbose            => 1 );
    $conf->set_conf( write_install_logs => 1 );
    if (($ENV{'AUR_BUILD_SERVER'} || "") eq "TRUE") {
        $conf->set_conf( 'dist_type' => 'CPANPLUS::Dist::Arch' );
    }


    ### program section
    $conf->set_program( pager       => $PAGER );
    $conf->set_program( shell       => $SHELL );
    $conf->set_program( editor      => $EDITOR );
    $conf->set_program( make        => which('make') );
    $conf->set_program( sudo        => which('sudo') );
    $conf->set_program( perlwrapper => which('cpanp-run-perl') );


    return 1;
}

sub which {
    my $program = shift;
    foreach my $dir ( split ':', $PATH ) {
        return "$dir/$program" if -x "$dir/$program";
    }
}

=pod

=head1 NAME

CPANPLUS::Config::User

=head1 DESCRIPTION

This is a CPANPLUS configuration file. Editing this
config changes the way CPANPLUS will behave

=cut

1;

