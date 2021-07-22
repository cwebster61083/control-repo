# Class: firewall_post

class profile::firewall_post {
  firewall { '999 drop all':
    proto  => 'all',
    action => 'drop',
    before => undef,
  }
}
