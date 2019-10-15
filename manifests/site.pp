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

node 'master.puppetdebug.vlan' {
  notify { 'This is the master': }
}

node 'agent.platform9.puppet.net' {
  notify { 'This is the agent': }

  $hostname = $facts['networking']['hostname']
  $domain = $facts['networking']['domain']

  notify { $hostname:}
  notify { $domain: }

  $node_network_profile = $facts['networking']['interfaces']

  notify { String($node_network_profile): }

  $node_networks_present = $node_network_profile.filter |$networks|{
    $networks[1] == true
  }


  notify { String($node_networks_present): }
}

node 'windows.platform9.puppet.net' {
  notify { 'This is my windows host': }
}

node 'dashboard.platform9.puppet.net' {
  include puppet_metrics_collector
}
