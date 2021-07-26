# Base iptables config and logrotation
class profile::main (
  $purge_iptables = true,
  $docker_swarm = false,
){

  include ::firewall
  include ::profile::pre
  include ::profile::post

  # $chains     = ['PREROUTING', 'FORWARD', 'INPUT', 'OUTPUT', 'POSTROUTING']
  $chains     = ['PREROUTING', 'INPUT', 'OUTPUT', 'POSTROUTING']
  $raw_chains = ['PREROUTING', 'OUTPUT']

  Firewall {
    before  => Class['profile::firewall::post'],
    require => Class['profile::firewall::pre'],
  }

  Firewallchain {
    purge => $purge_iptables,
    ignore_foreign => true,
  }

  firewallchain { 'INPUT:filter:IPv4':
  }

  firewallchain { 'OUTPUT:filter:IPv4':
  }

  if ! defined('profile::firewall::docker') {
    firewallchain { 'FORWARD:filter:IPv4':
    }
    $chains.each | $chain | {
      firewallchain { "${chain}:nat:IPv4":
      }
    }
  }
  $chains.each | $chain | {
    firewallchain { "${chain}:mangle:IPv4":
    }
  }

  $raw_chains.each | $chain | {
    firewallchain { "${chain}:raw:IPv4":
    }
  }

  # Below is needed in order to send iptables logs to their own file
  # This may be better managed with an rsyslog module, but this works
  # file { '/etc/rsyslog.d/25-iptables.conf':
  #   owner  => 'root',
  #   group  => 'root',
  #   source => 'puppet:///modules/profile/base/rsyslog.iptables.conf',
  #   notify => Service['rsyslog'],
  # }

  # ensure_resource('service', 'rsyslog', {'ensure' => 'running'})

  # logrotate::rule { 'iptables':
  #   path         => '/var/log/iptables.log',
  #   rotate       => 5,
  #   rotate_every => 'week',
  #   compress     => true,
  #   copytruncate => true,
  # }

}
