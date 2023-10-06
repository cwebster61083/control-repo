plan test::windows_agent_upgrade (
  TargetSpec $targets,
) {
  $targets.apply_prep
  $primary_facts = run_task('facts', $targets, '_catch_errors' => true).first

  $apply_results = apply($targets) {
    class { 'puppet_agent':
      package_version => '7.24.0',
      windows_source  => 'C:\\Users\\user\\Downloads\\puppet-agent-x64.msi',
    }
  }
}
