# Creates a metrics server. This server by default listens on port 3000 and can
# be logged in to using admin/admin
#
class profile::metrics_dashboard (
  $puppetserver_hosts = undef,
  $puppetdb_hosts = undef,
  $port = 3000,
  $data_retention = '336h0m0s', # Two weeks
  $database_names = ['puppet_metrics'],
) {
  # If we haven't passed in the puppetserver hosts we need to work it out
  # ourselves from PuppetDB
  if $puppetserver_hosts {
    $_puppetserver_hosts = $puppetserver_hosts
  } else {
    $server_results = puppetdb_query('nodes[certname] { resources { type = "Class" and title = "Puppet_enterprise::Profile::Master" } }')
    $_puppetserver_hosts = $server_results.map |$hash| {
    $hash['certname']
    }
  }

  # Also look up puppetdb servers if required
  if $puppetdb_hosts {
    $_puppetdb_hosts = $puppetdb_hosts
  } else {
    $db_results = puppetdb_query('nodes[certname] { resources { type = "Class" and title = "Puppet_enterprise::Profile::Puppetdb" } }')
    $_puppetdb_hosts = $db_results.map |$hash| {
    $hash['certname']
    }
  }

  # Set up the metrics dashboard server
  class { 'puppet_metrics_dashboard':
    add_dashboard_examples => true,
    overwrite_dashboards   => false,
    manage_repos           => true,
    configure_telegraf     => false,
    enable_telegraf        => false,
    grafana_http_port      => $port,
    grafana_version        => '7.2.0',
    influxdb_database_name => $database_names,
    master_list            => $_puppetserver_hosts.sort,
    puppetdb_list          => $_puppetdb_hosts.sort,
  }

  # $database_names.each |$database| {
  #   $policy = "RETENTION POLICY \"${database}_retention\" ON \"${database}\" DURATION ${data_retention} REPLICATION 1 DEFAULT"

  #   # Attempt to create the policy or alter it if that fails
  #   exec { "Set retention policy for ${database}":
  #     command => "influx -execute 'CREATE ${policy}' -database=\"${database}\" || influx -execute 'ALTER ${policy}' -database=\"${database}\"",
  #     unless  => "influx -execute 'SHOW RETENTION POLICIES ON ${database}' -database=\"${database}\" | grep ${data_retention}",
  #     path    => $facts['path'],
  #     notify  => Service['influxdb'],
  #     }
  # }
}
