# ~/.cpanplus/lib/CPANPLUS/Config/User.pm
###############################################
###
###  Configuration structure for CPANPLUS::Config::User
###
###############################################

#last changed: Sat Jan 10 23:09:18 2015 GMT

### minimal pod, so you can find it with perldoc -l, etc
=pod

=head1 NAME

CPANPLUS::Config::User

=head1 DESCRIPTION

This is a CPANPLUS configuration file. Editing this
config changes the way CPANPLUS will behave

=cut

package CPANPLUS::Config::User;

use strict;

use Env qw(HOME);

sub setup {
    my $conf = shift;

    ### conf section    
    $conf->set_conf( allow_build_interactivity => 1 );    
    $conf->set_conf( allow_unknown_prereqs => 1 );    
    $conf->set_conf( base => "$HOME/.cpanplus" );    
    $conf->set_conf( buildflags => '' );    
    $conf->set_conf( cpantest => 0 );    
    $conf->set_conf( cpantest_mx => '' );    
    $conf->set_conf( cpantest_reporter_args => {} );    
    $conf->set_conf( debug => 0 );    
    $conf->set_conf( dist_type => '' );    
    $conf->set_conf( email => 'jnbek@cpan.org' );    
    $conf->set_conf( enable_custom_sources => 1 );    
    $conf->set_conf( extractdir => '' );    
    $conf->set_conf( fetchdir => '' );    
    $conf->set_conf( flush => 1 );    
    $conf->set_conf( force => 0 );    
    $conf->set_conf( histfile => "$HOME/.cpanplus/history" );    
    $conf->set_conf( hosts => [
          {
            'scheme' => 'ftp',
            'path' => '/pub/CPAN/',
            'host' => 'ftp.cpan.org'
          },
          {
            'scheme' => 'http',
            'host' => 'www.cpan.org',
            'path' => '/'
          },
          {
            'scheme' => 'ftp',
            'path' => '/',
            'host' => 'cpan.hexten.net'
          },
          {
            'scheme' => 'ftp',
            'host' => 'cpan.cpantesters.org',
            'path' => '/CPAN/'
          },
          {
            'path' => '/pub/languages/perl/CPAN/',
            'host' => 'ftp.funet.fi',
            'scheme' => 'ftp'
          }
        ] );    
    $conf->set_conf( lib => [] );    
    $conf->set_conf( makeflags => '' );    
    $conf->set_conf( makemakerflags => '' );    
    $conf->set_conf( md5 => 1 );    
    $conf->set_conf( no_update => 0 );    
    $conf->set_conf( passive => 1 );    
    $conf->set_conf( prefer_bin => 1 );    
    $conf->set_conf( prefer_makefile => 1 );    
    $conf->set_conf( prereqs => 1 );    
    $conf->set_conf( shell => 'CPANPLUS::Shell::Default' );    
    $conf->set_conf( show_startup_tip => 1 );    
    $conf->set_conf( signature => 0 );    
    $conf->set_conf( skiptest => 0 );    
    $conf->set_conf( source_engine => 'CPANPLUS::Internals::Source::SQLite' );    
    $conf->set_conf( storable => 1 );    
    $conf->set_conf( timeout => 300 );    
    $conf->set_conf( verbose => 1 );    
    $conf->set_conf( write_install_logs => 1 );    
    
    
    ### program section    
    $conf->set_program( editor => 'vim' );    
    $conf->set_program( make => '/usr/bin/make' );    
    $conf->set_program( pager => 'less' );    
    $conf->set_program( perlwrapper => '/usr/bin/cpanp-run-perl' );    
    $conf->set_program( shell => '/bin/zsh' );    
    $conf->set_program( sudo => '/usr/bin/sudo' );    
    
    


    return 1;
}

1;

