class system_users::demo {

  user {'demo':
    gid => 'staff',
    shell => '/bin/bash',
    password => '123.qwe',
  }
}
