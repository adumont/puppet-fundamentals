# Class: nginx
# ===========================
#
# Full description of class nginx here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'nginx':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class nginx {
  case $::osfamily {
    'Debian': {
      $package = "nginx"
      $owner = "root"
      $group = "root"
      $docroot = "/var/www"
      $confdir = "/etc/nginx"
      $confd_dir = "/etc/nginx/conf.d"
      $logs_dir = "/var/log/nginx"
      $service = "nginx"
      $runas = "www-data"
    }

    'RedHat': {
      $package = "nginx"
      $owner = "root"
      $group = "root"
      $docroot = "/var/www"
      $confdir = "/etc/nginx"
      $confd_dir = "/etc/nginx/conf.d"
      $logs_dir = "/var/log/nginx"
      $service = "nginx"
      $runas = "nginx"
    }

    'Windows': {
      $package = "nginx-service"
      $owner = "Administrator"
      $group = "Administrators"
      $docroot = "C:/ProgramData/nginx/html"
      $confdir = "C:/ProgramData/nginx/conf"
      $confd_dir = "C:/ProgramData/nginx/conf.d"
      $logs_dir = "C:/ProgramData/nginx/logs"
      $service = "nginx"
      $runas = "nobody"
    }

    default: { fail("Unsupported OS family: ${::osfamily}") }
  }

  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  package { 'nginx':
    ensure => latest
  }

  file { $docroot:
    ensure => directory,
    mode   => '0755',
  }

  file { "${confd_dir}/default.conf":
    ensure => file,
    source => "puppet:///modules/nginx/default-${::kernel}.conf",
    require => Package['nginx'],
  }

  file { "${confdir}/nginx.conf":
    ensure => file,
    source => "puppet:///modules/nginx/nginx-${::osfamily}.conf"
  }

  file { "$docroot/index.html":
    ensure  => file,
    source  => 'puppet:///modules/nginx/index.html',
    require => Package["nginx"],
  }

  service { 'nginx':
    ensure    =>  running,
    enable    =>  true,
    subscribe => File["/etc/nginx/conf.d/default.conf"],
  }

}
