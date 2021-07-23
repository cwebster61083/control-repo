# profile::firewall class

# Class: profile::firewall
#
#
class profile::firewall (
  $purge = false,
) {
  Firewall {
    before => Class['profile::firewall_post'],
    require => Class['profile::firewall_pre'],
  }

  class { ['::profile::firewall_pre', '::profile::firewall_post']: }

  resources { 'firewall':
    purge          => $purge,
    ignore_foreign => true,
  }

  include ::firewall

  firewall { '100 ssh allow all':
    dport  => '22',
    chain  => 'INPUT',
    proto  => 'tcp',
    action => 'accept',
  }
  firewall { '101 ssl allow all':
    dport  => '80',
    chain  => 'INPUT',
    proto  => 'tcp',
    action => 'accept',
  }
  firewall { '102 ssl allow all':
    dport  => '443',
    chain  => 'INPUT',
    proto  => 'tcp',
    action => 'accept',
  }
}
