# This is a defined resource, not a class
define nginx::vhost (
  $port = '80',
  $vdocroot = "$::nginx::docroot/$title",
  $servername = $title,
) {

  file { "${::nginx::confd_dir}/${servername}.conf":
    ensure  => file,
    content => template("nginx/vhost.conf.erb"),
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  file { $vdocroot:
    ensure => directory,
    mode   => '0755',
  }

  file { "$vdocroot/index.html":
    ensure  => file,
    content  => template('nginx/index.html.erb'),
    require => Package["nginx"],
  }

}
