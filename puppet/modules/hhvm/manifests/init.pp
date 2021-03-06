# == Class: hhvm
#
# Configures the HipHop Virtual Machine for PHP, a fast PHP interpreter
# that is mostly compatible with the Zend interpreter. This module is a
# work-in-progress.
#
class hhvm {
    include ::apache
    include ::apache::mod::actions
    include ::apache::mod::alias
    include ::apache::mod::fastcgi

    # 12.04 requires updated boost packages
    apt::ppa { 'mapnik/boost': }

    package { 'hhvm':
        require => Class['::apache::mod::alias', '::apache::mod::actions', '::apache::mod::fastcgi'],
    }

    # Remove the init.d HHVM service so we can use our Upstart job.
    exec { 'remove_hhvm_initd':
        command => '/usr/sbin/update-rc.d -f hhvm remove',
        onlyif  => '/usr/sbin/update-rc.d -n -f hhvm remove | /bin/grep -Pq rc..d',
        require => Package['hhvm'],
    }

    # Define an 'HHVM' flag, the presence of which can be checked
    # with <IfDefine> directives. This allows Apache site config
    # files to provide HHVM-specific configuration blocks.
    apache::env { 'hhvm':
        content => 'export APACHE_ARGUMENTS="${APACHE_ARGUMENTS:- }-D HHVM"',
        require => Service['hhvm'],
    }

    file { '/etc/hhvm/static.mime-types.hdf':
        source => 'puppet:///modules/hhvm/static.mime-types.hdf',
        require => Package['hhvm'],
        notify  => Service['hhvm'],
    }

    file { '/var/www/fastcgi':
        ensure => directory,
        owner  => 'www-data',
        group  => 'www-data',
        mode   => '0755',
    }

    file { '/etc/hhvm/server.hdf':
        content => template( 'hhvm/server.hdf.erb'),
        notify  => Service['hhvm'],
        require => [
            File['/etc/hhvm/static.mime-types.hdf'],
            Package['hhvm'],
        ],
    }

    file { '/etc/init/hhvm.conf':
        ensure  => file,
        content => template('hhvm/hhvm.conf.erb'),
        require => File['/etc/hhvm/server.hdf', '/var/www/fastcgi'],
    }

    service { 'hhvm':
        ensure   => running,
        provider => upstart,
        require  => File['/etc/init/hhvm.conf'],
    }
}
