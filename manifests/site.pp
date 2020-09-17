## site.pp ##

# This file (./manifests/site.pp) is the main entry point
# used when an agent connects to a master and asks for an updated configuration.
# https://puppet.com/docs/puppet/latest/dirs_manifest.html
#
# Global objects like filebuckets and resource defaults should go in this file,
# as should the default node definition if you want to use it.

## Active Configurations ##

# Disable filebucket by default for all File resources:
# https://github.com/puppetlabs/docs-archive/blob/master/pe/2015.3/release_notes.markdown#filebucket-resource-no-longer-created-by-default
File { backup => false }

## Node Definitions ##

# The default node definition matches any node lacking a more specific node
# definition. If there are no other node definitions in this file, classes
# and resources declared in the default node definition will be included in
# every node's catalog.
#
# Note that node definitions in this file are merged with node data from the
# Puppet Enterprise console and External Node Classifiers (ENC's).
#
# For more on node definitions, see: https://puppet.com/docs/puppet/latest/lang_node_definitions.html
node default {
  # This is where you can declare classes for all nodes.
  # Example:
  #   class { 'my_class': }
}

node 'windows.puppetdebug.vlan' {
  include role::windows
}

node 'antitrust-aide.delivery.puppetlabs.net' {
  # file { ''c':\\test.log':
  #   ensure => file,
  #   source => ''file':#webster.prv/testing/test.log',
  # }
  file { 'c:\\test.log':
    ensure => file,
    source => 'file://windowsdc.webster.prv/testing/test.log',
  }
}

node 'windowsdc.platform9.puppet.net' {
  notify { 'I am windowsdc': }
}

node 'elastic.puppetdebug.vlan' {
  notify { 'I am elastic': }

  include puppet_logging_dashboard

  # include elastic_stack::repo
  # class { 'java' :
  #   package => 'java-1.8.0-openjdk-devel',
  # }
  # class { 'elasticsearch':
  #   restart_on_change => true,
  # }
  # elasticsearch::instance { 'es-01':
  #   jvm_options => [
  #     '-Xms4g',
  #     '-Xmx4g',
  #     '#PrintGCDetails',
  #     '#PrintGCDateStamps',
  #     '#PrintTenuringDistribution',
  #     '#PrintGCApplicationStoppedTime',
  #     '#Xloggc',
  #     '#UseGCLogFileRotation',
  #     '#NumberOfGCLogFiles',
  #     '#GCLogFileSize',
  #     '#XX:UseConcMarkSweepGC',
  #   ],
  #   config      => {
  #     #  'xpack.monitoring.collection.enabled' => true,
  #     'network.host'                        => '0.0.0.0',
  #     'http.port'                           => '9200',
  #     'cluster.initial_master_nodes'        => 'elastic.puppetdebug.vlan',
  #     'xpack.monitoring.collection.enabled' =>  true,
  #   },
  # }
  # class { 'kibana' :
  #   config => {
  #     'server.port'                      => '8080',
  #     'server.host'                      => '0.0.0.0',
  #     'xpack.license_management.enabled' => false,
  #   },
  # }
}

node 'agent.puppetdebug.vlan' {
  notify { 'I am elastic': }

  include puppet_logging_dashboard

}

node 'pe-201980-elastic.platform9.puppet.net' {
  notify { 'I am elastic': }

  include puppet_logging_dashboard
  # include elastic_stack::repo
  # class { 'java' :
  #   package => 'java-1.8.0-openjdk-devel',
  # }
  # class { 'elasticsearch':
  #   restart_on_change => true,
  # }
  # elasticsearch::instance { 'es-01':
  #   jvm_options => [
  #     '-Xms4g',
  #     '-Xmx4g',
  #     '#PrintGCDetails',
  #     '#PrintGCDateStamps',
  #     '#PrintTenuringDistribution',
  #     '#PrintGCApplicationStoppedTime',
  #     '#Xloggc',
  #     '#UseGCLogFileRotation',
  #     '#NumberOfGCLogFiles',
  #     '#GCLogFileSize',
  #     '#XX:UseConcMarkSweepGC',
  #   ],
  #   config      => {
  #     #  'xpack.monitoring.collection.enabled' => true,
  #     'network.host'                        => '0.0.0.0',
  #     'http.port'                           => '9200',
  #     'cluster.initial_master_nodes'        => 'elastic.puppetdebug.vlan',
  #     'xpack.monitoring.collection.enabled' =>  true,
  #   },
  # }
  # class { 'kibana' :
  #   config => {
  #     'server.port'                      => '8080',
  #     'server.host'                      => '0.0.0.0',
  #     'xpack.license_management.enabled' => false,
  #   },
  # }
}

node 'replica.puppetdebug.vlan' {
  notify { 'I am the replica': }
  # class { 'java' :
  #   package => 'java-1.8.0-openjdk-devel',
  # }
  # include logstash
  # file { '/etc/logstash/conf.d/puppetserver-log.conf':
  #   ensure => file,
  #   source => 'puppet:///modules/test/puppetserver-log.conf',
  # }
  # file { '/etc/logstash/conf.d/console-services-api-access-log.conf':
  #   ensure => file,
  #   source => 'puppet:///modules/test/console-services-api-access-log.conf',
  # }
}

node 'master.puppetdebug.vlan' {
  notify { 'I am the master':
    message => 'This is my MOM!',
  }
  include puppet_metrics_collector

  # #class { 'java' :
  #   package => 'java-1.8.0-openjdk-devel',
  # }
  # class { 'logstash':
  #   startup_options => {
  #     'LS_NICE' => '10',
  #     'LS_USER' => 'root',
  #   },
  # }
  # file { '/etc/logstash/conf.d/puppetserver-log.conf':
  #   ensure => file,
  #   source => 'puppet:///modules/test/puppetserver-log.conf',
  # }
  # file { '/etc/logstash/conf.d/console-services-api-access-log.conf':
  #   ensure => file,
  #   source => 'puppet:///modules/test/console-services-api-access-log.conf',
  # }

  # file { '/etc/logstash/conf.d/puppetserver-access.conf':
  #   ensure => file,
  #   source => 'puppet:///modules/test/puppetserver-access.conf',
  # }

  # archive{'/var/tmp/install/tasks.zip':
  #   ensure          => present,
  #   source          => 'puppet:///modules/test/tasks.zip',
  #   extract         => false,
  #   checksum        => '1598183de4324c99efde7231031c1151',
  #   checksum_type   => 'md5',
  #   checksum_verify => false,
  #   # extract_path    => 'C:\Strawberry\perl\lib',
  #   # creates         => 'C:\Strawberry\perl\lib\Parallel',
  #   cleanup         => false,
  # }
}

node 'agent-test.puppetdebug.vlan' {
  notify { 'I am the agent-test': }
  include puppet_logging_dashboard
}

node 'lofty-pseudonym.delivery.puppetlabs.net' {
  package { 'opensssl':
    ensure   => minimum_version('openssl', '1.0.2k', '1.0.2k'),
  }
}

node 'master2019.puppetdebug.vlan' {
  # exec { 'testexec':
  #   command => 'echo $(hostname -f >> /root/hostname)',
  #   path    => ['/usr/bin', '/usr/sbin'],
  #   unless  => 'false',
  # } 
  include mgc_case38321
}

node 'weak-experience.delivery.puppetlabs.net' {
  include apache
}

node 'radial-honesty.delivery.puppetlabs.net' {
  include apache
  include apache::dissite
  class { 'apache::ensite':
    vhost_file => '001-default.conf',
  }
}

node 'radiant-terror.delivery.puppetlabs.net' {
  include puppet_logging_dashboard
}

node 'server2019.webster.prv' {
  notify { 'I am 2019':
    message => "I am ${fqdn}.",
  }
  scheduled_task { 'csv test schedule':
    ensure    => 'present',
    command   => "${::system32}\\WindowsPowerShell\\v1.0\\powershell.exe",
    arguments => '-File "C:\\Scripts\\test.ps1',
    enabled   => 'true',
    trigger   => [{
      'schedule'   => 'daily',
      'start_time' => '23:00'
    }],
    user      => 'webster\\testuser',
    password  => 'Abcd123412',
  }
}
