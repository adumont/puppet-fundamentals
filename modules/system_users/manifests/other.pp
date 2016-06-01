define system_users::other {

  user { $name :
    gid => 'staff',
    shell => '/bin/bash',
    password => '123.qwe',
  }

}
