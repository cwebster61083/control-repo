# CD4PE Profile

class profile::cd4pe {

  # $fqdn                   = lookup('cd4pe::fqdn')
  # $cert                   = $fqdn
  # $cd4pe_subnet           = '172.17.0.2/16'
  $puppet_master_fw       = ['8170','4433','8140','8081','8143']
  $cd4pe_ports_tcp        = ['6443','6783','8000','8800','10250','80','443']
  $cd4pe_ports_udp        = ['6783','6784']
  # $cd4pe_web              = ['8080','8443']
  $pod_subnet             = '10.32.0.0/22'
  $service_subnet         = '10.96.0.0/22'

  # $cd4pe_xmx              = lookup('cd4pe::xmx')
  # $cd4pe_xms              = lookup('cd4pe::xms')

  # include ::profile::firewall::web_server
  include ::profile::firewall::main
  include ::profile::firewall::kubernetes

  # if $facts['selinux'] == true {
  #   class { '::selinux':
  #     mode => 'disabled',
  #   }
  # }
  # k8s builds sets builds with firewall priority of 9xxx, but setting to 8xxx since 9xxx is system reserved.
  firewall { '8124 allow inbound to Weave':
    ensure => 'present',
    chain  => 'INPUT',
    jump   => 'WEAVE-IPSEC-IN',
    proto  => 'all',
    table  => 'mangle',
  }

  firewall { '8035 allow inbound to Kubernetes':
    ensure => 'present',
    chain  => 'INPUT',
    proto  => 'all',
    jump   => 'KUBE-FIREWALL',
    table  => 'filter',
  }

  firewall { '8044 Block non-local access to Weave Net control port':
    ensure      => 'present',
    action      => 'drop',
    chain       => 'INPUT',
    ctstate     => ['ESTABLISHED', 'RELATED'], # Existing code had ['! ESTABLISHED', '! RELATED'], but not parsing correctly
    destination => '127.0.0.1/32',
    dport       => ['6784'],
    proto       => 'tcp',
    src_type    => ['! LOCAL'],
    table       => 'filter',
  }

  firewall { '8045 allow outbound Weave':
    ensure  => 'present',
    chain   => 'INPUT',
    iniface => 'weave',
    jump    => 'WEAVE-NPC-EGRESS',
    proto   => 'all',
    table   => 'filter',
  }

  firewall { '8046 allow inbound to Weave':
    ensure => 'present',
    chain  => 'INPUT',
    jump   => 'WEAVE-IPSEC-IN',
    proto  => 'all',
    table  => 'filter',
  }

  firewall { '8061 allow inbound to Kubernetes':
    ensure => 'present',
    chain  => 'OUTPUT',
    jump   => 'KUBE-FIREWALL',
    proto  => 'all',
    table  => 'filter',
  }

  firewall { '110 allow port 8800 for replicated UI':
    ensure => present,
    chain  => 'FORWARD',
    dport  => 8800,
    proto  => 'tcp',
    action => 'accept',
  }

  # Added by k8s, but commenting out since puppet fails on match_mark value 
  # firewall { '8062 deny output':
  #   ensure       => 'present',
  #   action       => 'drop',
  #   chain        => 'OUTPUT',
  #   ipsec_dir    => 'out',
  #   ipsec_policy => 'none',
  #   match_mark   => '0x20000/0x20000',
  #   proto        => '! esp',
  #   table        => 'filter',
  # }

  firewall { '8125 allow outbound from Weave':
    ensure => 'present',
    chain  => 'OUTPUT',
    jump   => 'WEAVE-IPSEC-OUT',
    proto  => 'all',
    table  => 'mangle',
  }

  # Assume that the cd4pe class is already applied in the Puppet classifications,
  # which creates /etc/puppetlabs/cd4pe.

  # file { '/etc/puppetlabs/cd4pe/config':
  #   ensure => directory,
  #   owner  => 'root',
  #   group  => 'root',
  #   mode   => '0755',
  # }

  # file { '/etc/puppetlabs/cd4pe/env-extra':
  #   ensure  => file,
  #   owner   => 'root',
  #   group   => 'root',
  #   mode    => '0644',
  #   content => template('profile/puppet/cd4pe/env-extra.erb'),
  # }

  # file { '/etc/puppetlabs/cd4pe/config/log4j.properties':
  #   ensure  => file,
  #   owner   => 'root',
  #   group   => 'root',
  #   mode    => '0644',
  #   source  => 'puppet:///modules/profile/puppet/cd4pe/log4j.properties',
  #   require => File['/etc/puppetlabs/cd4pe/config']
  # }

  $cd4pe_ports_tcp.each | $port | {
    firewall { "110 allow port ${port} for cd4pe tcp":
      ensure => present,
      dport  => $port,
      proto  => 'tcp',
      action => 'accept',
    }
  }

  $cd4pe_ports_udp.each | $port | {
    firewall { "110 allow port ${port} for cd4pe udp":
      ensure => present,
      dport  => $port,
      proto  => 'udp',
      action => 'accept',
    }
  }

  $puppet_master_fw.each |$port| {
    # @@firewall { "110 allow cd4pe on for ${port} on ${facts['hostname']}":
    firewall { "110 allow cd4pe on for ${port} on ${facts['hostname']}":
      ensure => present,
      dport  => $port,
      proto  => 'tcp',
      action => 'accept',
      tag    => 'cd4pe-firewall',
      source => "${facts['ipaddress']}/32",
    }
  }

  firewall { '110 allow pod network':
    ensure => present,
    source => $pod_subnet,
    proto  => 'all',
    action => 'accept',
  }
  firewall { '110 allow service network':
    ensure => present,
    source => $service_subnet,
    proto  => 'all',
    action => 'accept',
  }

  # $cd4pe_web.each |$port_num| {
  #   firewall { "110 allow port ${port_num}":
  #     chain   => 'DOCKER-USER',
  #     iniface => 'ens160',
  #     dport   => $port_num,
  #     proto   => 'tcp',
  #     action  => 'accept',
  #   }
  # }
  # if $facts['docker'] {
  #   firewall { '110 allow port 5432 for docker network':
  #     ensure => present,
  #     dport  => '5432',
  #     proto  => 'tcp',
  #     source => $cd4pe_subnet,
  #     action => 'accept',
  #   }

  #   firewall { '110 allow port 8000 for docker network':
  #     ensure => present,
  #     dport  => '8000',
  #     proto  => 'tcp',
  #     source => $cd4pe_subnet,
  #     action => 'accept',
  #   }
  # }

  # certs::certificate { "${cert}.crt":
  #   source => "puppet:///modules/certs/${fqdn}/${cert}.crt",
  # }

  # certs::certificate { "${cert}.key":
  #   source => "puppet:///modules/certs/${fqdn}/${cert}.key",
  #   is_key => true,
  # }

  # Firewall <<| tag == 'cd4pe-firewall-stash' |>>

  # # Since ::profile::docker is not included on cd4pe master, specify filebeat here instead
  # filebeat::input { "${facts['hostname']}-containers":
  #   paths             => [ '/var/lib/docker/containers/*/*.log' ],
  #   fields_under_root => true,
  #   fields            => { type => 'containers', },
  #   processors        => [{
  #     'add_docker_metadata' => {
  #     'host' => 'unix:///var/run/docker.sock',
  #     }
  #   }],
  # }

}
