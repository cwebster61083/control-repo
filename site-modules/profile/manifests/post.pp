# Ending rules for iptables
class profile::post {

  firewall { '899 drop broadcast':
    action   => 'drop',
    dst_type => 'BROADCAST',
    proto    => 'all',
    before   => undef,
  }

  firewall { '900 INPUT denies get logged':
    jump       => 'LOG',
    log_level  => '4',
    log_prefix => 'iptables denied: ',
    proto      => 'all',
    before     => undef,
    limit      => '30/min',
  }

  if $profile::firewall::main::docker_swarm {
    $source = '! 172.16.0.0/12'
  }
  else {
    $source = undef
  }

  firewall { '999 drop all':
    proto  => 'all',
    source => $source,
    action => 'drop',
    before => undef,
  }

}
