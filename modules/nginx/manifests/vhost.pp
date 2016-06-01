# This is a defined resource, not a class
define nginx::vhost (
  $port = '80',
  $docroot = "/var/www-$title",
  $servername = $title,
) {

  file { "${::nginx::confd_dir}/${servername}.conf":
    ensure  => file,
    content => template("nginx/vhost.conf.erb"),
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  file { $docroot:
    ensure => directory,
    mode   => '0755',
  }

  file { "$docroot/index.html":
    ensure  => file,
    content  => template('nginx/index.html.erb'),
    require => Package["nginx"],
  }

}
