include ::nginx
#include ::nginx::params
nginx::vhost{ 'vhosttest1': 
  port => '8123',
}
nginx::vhost{ 'vhosttest2': }
nginx::vhost{ 'vhosttest3': }
nginx::vhost{ 'vhosttest4': }
