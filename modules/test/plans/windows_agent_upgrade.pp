plan test::windows_agent_upgrade (
  TargetSpec $targets,
  String $version,
  String $source = 'https://artifactory.test.lab:8443/artifactory/chocolatey-installers/windows/puppet7'
) {
  $full_source = "${source}/puppet-agent-${version}-x64.msi"
  $target_objects = get_targets($targets)
  $facts_result = puppetdb_fact($target_objects)
  $facts_retrieved_nodes = $facts_result.each |$node, $node_facts| {
    add_facts(get_target($node), $node_facts)
  }
  $result = apply($target_objects, _noop => false) {
    class { 'puppet_agent':
      install_options     => ['RESINSTALLMODE="amus"', 'ADDLOCAL=ALL'],
      package_version     => $version,
      wait_for_puppet_run => 900000,
      windows_source      => $source,
    }
  }
}
