class system_users::demo {

  group { 'staff': 
     ensure => present,
  }

  user {'demo':
    gid => 'staff',
    shell => '/bin/bash',
    password => '123.qwe',
  }
}
