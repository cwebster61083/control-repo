plan test::update_puppet2(
  TargetSpec $targets,
  # String $version,
) {
  # $targets.apply_prep
  # $primary_facts = run_task('facts', $targets, '_catch_errors' => true).first

  run_task ('service', $targets, 'action' => 'status', 'name' => 'Puppet Agent')
  run_task ('service', $targets, 'action' => 'status', 'name' => 'Puppet PXP Agent')
  # run_command("Get-Service -DisplayName 'Puppet PXP Agent' -ErrorAction SilentlyContinue | Stop-Service", $targets)

  # run_task('puppet_agent::install', $targets, 'version' => $version)
}
