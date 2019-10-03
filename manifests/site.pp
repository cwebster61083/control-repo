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
}

node 'windows.platform9.puppet.net' {
  file { 'C:/test':
    ensure             => directory,
    source             => 'C:\\stuff\\test',
    recurse            => true,
    force              => true,
    source_permissions => ignore,
  }

  $paths_root = 'HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Installer\\UserData\\S-1-5-18\\Products\\'
  $paths_prerequisites = [
    "${paths_root}EFEE0228DC83E77358593193D847A0EC", # VS2008 x64
    "${paths_root}D20352A90C039D93DBF6126ECE614057", # VS2008 x86
    "${paths_root}C173E5AD3336A8D3394AF65D2BB0CCE6", # VS2010 x64
    "${paths_root}D04BB691875110D32B98EBCF771AA1E1", # VS2010 x86
    "${paths_root}51E9E3D0A7EDB003691F4BFA219B4688", # VS2015 x64
    "${paths_root}55E3652ACEB38283D8765E8E9B8E6B57", # VS2015 x86
    "${paths_root}058244C1FE8B65D4DBA1A29CABB77F15", #Product
  ]

  notify { 'regpaths':
    loglevel => info,
    message  => "The reg paths are: *${paths_prerequisites}",
  }
}
