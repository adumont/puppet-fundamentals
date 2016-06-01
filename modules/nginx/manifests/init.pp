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
class nginx (
  $package = $::nginx::params::package,
  $owner = $::nginx::params::owner,
  $group = $::nginx::params::group,
  $port = $::nginx::params::port,
  $docroot = $::nginx::params::docroot,
  $confdir = $::nginx::params::confdir,
  $confd_dir = $::nginx::params::confd_dir,
  $logs_dir = $::nginx::params::logs_dir,
  $service = $::nginx::params::service,
  $runas = $::nginx::params::runas,
) inherits nginx::params {
  $servername = "_"

  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  package { 'nginx':
    ensure => latest
  }

  file { "${confdir}/nginx.conf":
    ensure => file,
    content  => template('nginx/nginx.conf.erb'),
    require => Package["nginx"],
  }

  file { "$::nginx::docroot":
    ensure => directory,
    mode   => '0755',
  }

  # we create a 'default' vhost
  nginx::vhost { 'default' :
    servername => $::fqdn,
  }

  service { 'nginx':
    ensure    =>  running,
    enable    =>  true,
  }

}
