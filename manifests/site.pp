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
  include profile::base
}

node 'clwwin2019-443cd3-0.us-west1-c.c.customer-support-scratchpad.internal' {
  notify { 'notify':
    $simple = lookup('simple', Hash, 'deep'),
    $complex = lookup('role::name::complex', Hash, 'deep'),
    message => 'This is my Windows 2019 test box.',
    message => "$simple",
  }
  class test(
    $simple = lookup('simple', Hash, 'deep'),
    $complex = lookup('role::name::complex', Hash, 'deep'),
  ) {
    notify { "The value is: ${simple}": }
  }
}

# node 'windows.platform9.puppet.net' {
#   include profile::base

# }

# node 'windows2012.vpn.puppet.net' {
#   notify { 'notify':
#     message => 'This is the Windows Server 2012 test box.',
#   }
#   class {'::puppet_agent':
#     package_version => '6.17.0',
# }
# }

# node 'antitrust-aide.delivery.puppetlabs.net' {
#   # file { ''c':\\test.log':
#   #   ensure => file,
#   #   source => ''file':#webster.prv/testing/test.log',
#   # }
#   file { 'c:\\test.log':
#     ensure => file,
#     source => 'file://windowsdc.webster.prv/testing/test.log',
#   }
# }

# node 'windowsdc' {
#   notify { 'I am windowsdc': }

#   include chocolatey
#   package { 'git':
#     ensure   => installed,
#     provider => 'chocolatey',
#   }

#   user { 'cnanlocaladmin_account2':

#       ensure     => present,
#       name       => 'cnanlocaladmin',
#       forcelocal => true,
#       password   => lookup('password'),
#       groups     => ['BUILTIN\\Administrators'],
#     }
# }

# node 'dashboard.puppetdebug.vlan' {
#   notify {"I am ${fqdn}": }

#   # include role::metrics_dashboard
#   class{'puppet_metrics_dashboard':
#       add_dashboard_examples => true,
#       overwrite_dashboards   => false,
#       configure_telegraf     => false,
#       enable_telegraf        => false,
#       influxdb_database_name => ['puppet_metrics']
#     }
# }


# node 'elastic.puppetdebug.vlan' {
#   notify { 'I am elastic': }

#   include puppet_logging_dashboard

#   # include elastic_stack::repo
#   # class { 'java' :
#   #   package => 'java-1.8.0-openjdk-devel',
#   # }
#   # class { 'elasticsearch':
#   #   restart_on_change => true,
#   # }
#   # elasticsearch::instance { 'es-01':
#   #   jvm_options => [
#   #     '-Xms4g',
#   #     '-Xmx4g',
#   #     '#PrintGCDetails',
#   #     '#PrintGCDateStamps',
#   #     '#PrintTenuringDistribution',
#   #     '#PrintGCApplicationStoppedTime',
#   #     '#Xloggc',
#   #     '#UseGCLogFileRotation',
#   #     '#NumberOfGCLogFiles',
#   #     '#GCLogFileSize',
#   #     '#XX:UseConcMarkSweepGC',
#   #   ],
#   #   config      => {
#   #     #  'xpack.monitoring.collection.enabled' => true,
#   #     'network.host'                        => '0.0.0.0',
#   #     'http.port'                           => '9200',
#   #     'cluster.initial_master_nodes'        => 'elastic.puppetdebug.vlan',
#   #     'xpack.monitoring.collection.enabled' =>  true,
#   #   },
#   # }
#   # class { 'kibana' :
#   #   config => {
#   #     'server.port'                      => '8080',
#   #     'server.host'                      => '0.0.0.0',
#   #     'xpack.license_management.enabled' => false,
#   #   },
#   # }
# }

# node 'agent.puppetdebug.vlan' {
#   notify { 'I am the agent.': }

#   include profile::base

# }

# node 'pe-201980-elastic.platform9.puppet.net' {
#   notify { 'I am elastic': }

#   include puppet_logging_dashboard
#   # include elastic_stack::repo
#   # class { 'java' :
#   #   package => 'java-1.8.0-openjdk-devel',
#   # }
#   # class { 'elasticsearch':
#   #   restart_on_change => true,
#   # }
#   # elasticsearch::instance { 'es-01':
#   #   jvm_options => [
#   #     '-Xms4g',
#   #     '-Xmx4g',
#   #     '#PrintGCDetails',
#   #     '#PrintGCDateStamps',
#   #     '#PrintTenuringDistribution',
#   #     '#PrintGCApplicationStoppedTime',
#   #     '#Xloggc',
#   #     '#UseGCLogFileRotation',
#   #     '#NumberOfGCLogFiles',
#   #     '#GCLogFileSize',
#   #     '#XX:UseConcMarkSweepGC',
#   #   ],
#   #   config      => {
#   #     #  'xpack.monitoring.collection.enabled' => true,
#   #     'network.host'                        => '0.0.0.0',
#   #     'http.port'                           => '9200',
#   #     'cluster.initial_master_nodes'        => 'elastic.puppetdebug.vlan',
#   #     'xpack.monitoring.collection.enabled' =>  true,
#   #   },
#   # }
#   # class { 'kibana' :
#   #   config => {
#   #     'server.port'                      => '8080',
#   #     'server.host'                      => '0.0.0.0',
#   #     'xpack.license_management.enabled' => false,
#   #   },
#   # }
# }

# node 'replica.puppetdebug.vlan' {
#   notify { 'I am the replica change': }
#   # class { 'java' :
#   #   package => 'java-1.8.0-openjdk-devel',
#   # }
#   # include logstash
#   # file { '/etc/logstash/conf.d/puppetserver-log.conf':
#   #   ensure => file,
#   #   source => 'puppet:///modules/test/puppetserver-log.conf',
#   # }
#   # file { '/etc/logstash/conf.d/console-services-api-access-log.conf':
#   #   ensure => file,
#   #   source => 'puppet:///modules/test/console-services-api-access-log.conf',
#   # }
# }

# node 'replicated.puppetdebug.vlan' {
#   notify { "I am ${fqdn}.": }

#   #include ::profile::puppet::cd4pe
#   include ::profile::firewall

# }

# node 'primary.puppetdebug.vlan' {
#   notify { "I am ${fqdn}.":
#     message => 'This is my Primary Puppet Server.',
#   }

#   include puppet_metrics_collector
#   include puppet_metrics_collector::system

#   # #class { 'java' :
#   #   package => 'java-1.8.0-openjdk-devel',
#   # }
#   # class { 'logstash':
#   #   startup_options => {
#   #     'LS_NICE' => '10',
#   #     'LS_USER' => 'root',
#   #   },
#   # }
#   # file { '/etc/logstash/conf.d/puppetserver-log.conf':
#   #   ensure => file,
#   #   source => 'puppet:///modules/test/puppetserver-log.conf',
#   # }
#   # file { '/etc/logstash/conf.d/console-services-api-access-log.conf':
#   #   ensure => file,
#   #   source => 'puppet:///modules/test/console-services-api-access-log.conf',
#   # }

#   # file { '/etc/logstash/conf.d/puppetserver-access.conf':
#   #   ensure => file,
#   #   source => 'puppet:///modules/test/puppetserver-access.conf',
#   # }

#   # archive{'/var/tmp/install/tasks.zip':
#   #   ensure          => present,
#   #   source          => 'puppet:///modules/test/tasks.zip',
#   #   extract         => false,
#   #   checksum        => '1598183de4324c99efde7231031c1151',
#   #   checksum_type   => 'md5',
#   #   checksum_verify => false,
#   #   # extract_path    => 'C:\Strawberry\perl\lib',
#   #   # creates         => 'C:\Strawberry\perl\lib\Parallel',
#   #   cleanup         => false,
#   # }
# }


# node 'agent-test.puppetdebug.vlan' {
#   notify { 'I am the agent-test': }
#   include puppet_logging_dashboard
# }

# node 'lofty-pseudonym.delivery.puppetlabs.net' {
#   package { 'opensssl':
#     ensure   => minimum_version('openssl', '1.0.2k', '1.0.2k'),
#   }
# }

# node 'master2019.puppetdebug.vlan' {
#   # exec { 'testexec':
#   #   command => 'echo $(hostname -f >> /root/hostname)',
#   #   path    => ['/usr/bin', '/usr/sbin'],
#   #   unless  => 'false',
#   # } 
#   include mgc_case38321
# }

# node 'weak-experience.delivery.puppetlabs.net' {
#   include apache
# }

# node 'radial-honesty.delivery.puppetlabs.net' {
#   include apache
#   include apache::dissite
#   class { 'apache::ensite':
#     vhost_file => '001-default.conf',
#   }
# }

# node 'radiant-terror.delivery.puppetlabs.net' {
#   include puppet_logging_dashboard
# }

# node 'server2019.webster.prv' {
#   notify { 'test notify':
#     message => "I am ${fqdn}.",
#   }
#   scheduled_task { 'csv test schedule':
#     ensure    => 'present',
#     command   => "${::system32}\\WindowsPowerShell\\v1.0\\powershell.exe",
#     arguments => '-File "C:\\Scripts\\test.ps1',
#     enabled   => 'true',
#     trigger   => [{
#       'schedule'   => 'daily',
#       'start_time' => '23:00'
#     }],
#     user      => 'webster\\testuser',
#     password  => 'Abcd123412',
#   }
# }

# node 'clw2019hdp-b5fe62-0.us-west1-c.c.customer-support-scratchpad.internal' {
#   include profile::hdp_profile
# }

# node 'clwpe2019-b5fe62-0.us-west1-c.c.customer-support-scratchpad.internal' {
#   class { 'hdp::data_processor':
#       hdp_url =>  'https://clw2019hdp-b5fe62-0.us-west1-c.c.customer-support-scratchpad.internal:9091',
#     }
# }

# node 'win-2019-node-b5fe62-0.us-west1-c.c.customer-support-scratchpad.internal' {
#   include bpa_laps
# }

# node 'clwpe2021-b5fe62-0.us-west1-c.c.customer-support-scratchpad.internal' {
#   class { 'pe_status_check':
#     indicator_exclusions             => ['S0001', 'S0022'],
#   }
# }

# node 'clwdash-b5fe62-0.us-west1-c.c.customer-support-scratchpad.internal' {
#   include puppet_operational_dashboards
# }

# node 'clwpe-lts-b5fe62-2.us-west1-a.c.customer-support-scratchpad.internal' {
# }

# node 'clwpe-lts-b5fe62-3.us-west1-c.c.customer-support-scratchpad.internal' {
# }

# node 'clwpe-lts-b5fe62-5.us-west1-a.c.customer-support-scratchpad.internal' {

# }

# # node 'clwdash-b5fe62-0.us-west1-c.c.customer-support-scratchpad.internal' {
# #   include puppet_logging_dashboard
# # }

# node 'clwelastic-b5fe62-0.us-west1-c.c.customer-support-scratchpad.internal' {
#   notify { 'I am elastic': }

#   include puppet_logging_dashboard
# }

# node 'clw-win2019-b5fe62-0.us-west1-c.c.customer-support-scratchpad.internal' {
#   #  notify {"I am ${fqdn}": }

#   #  dsc_service { 'W3SVC':
#   #   dsc_name            => 'W3SVC',
#   #   dsc_startuptype     => 'Manual',
#   #   dsc_state           => 'Ignore',
#   #   dsc_builtinaccount  => 'LocalSystem',
#   #   # validation_mode     => 'resource',
#   #   } 


#   dsc_service { 'dummy_service':
#     dsc_ensure      => 'Present',
#     dsc_name        => 'dummy_service',
#     dsc_displayname => 'dummy_service',
#     dsc_path        => 'C:\temp\dummy.exe',
#     dsc_startuptype => 'Automatic',
#     dsc_state       => 'Ignore',
#     validation_mode => 'resource',
#   } 

# }

# node 'clwwin2019-443cd3-0.us-west1-c.c.customer-support-scratchpad.internal' {
#   dsc { 'newfile':
#     resource_name => 'file',
#     module        => 'PSDesiredStateConfiguration',
#     properties    => {
#       ensure => 'present',
#       name   => 'C:\\Users\\user\\Documents\\testing\\file.txt'
#     },
#   }
# }
