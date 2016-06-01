class nginx::params {

  # Example of selector construction:
  $runas = $::osfamily ? {
    'Debian'  => "www-data",
    'Windows' => "nobody",
    default  => "nginx",
  }

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
    }

    default: { fail("Unsupported OS family: ${::osfamily}") }
  }

}
